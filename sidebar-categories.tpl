<style>
	/* 导航卡片整体样式 */
	.category-nav {
		background: #fff;
		border-radius: 4px;
		box-shadow: 0 2px 8px rgba(0,0,0,0.08);
		overflow: hidden;
	}
	
	/* 搜索框区域 */
	.search-section {
		padding: 20px;
		background: #2B6DE5;
	}
	
	.pro-search-box .form-control {
		height: 42px;
		padding-left: 40px;
		padding-right: 15px;
		font-size: 14px;
		border-radius: 4px;
		background: rgba(255,255,255,0.1) !important;
		border: 1px solid rgba(255,255,255,0.2) !important;
		color: #fff;
		transition: background 0.2s ease;
		width: 100%;
	}
	
	.pro-search-box .form-control::placeholder {
		color: rgba(255, 255, 255, 0.7);
	}
	
	.pro-search-box .form-control:focus {
		background: rgba(255,255,255,0.15) !important;
		outline: none;
	}
	
	.pro-search-box .search-icon {
		position: absolute;
		left: 15px;
		top: 50%;
		transform: translateY(-50%);
		font-size: 18px;
		color: rgba(255, 255, 255, 0.7);
		cursor: pointer;
		pointer-events: auto;
	}
	
	.pro-search-box .position-relative {
		position: relative;
		width: 100%;
		display: flex;
		align-items: center;
	}
	
	/* 分类列表样式 */
	.prolist {
		padding: 10px 0;
	}
	
	.category-item {
		position: relative;
		border-bottom: 1px solid rgba(0,0,0,0.05);
	}
	
	.category-item:last-child {
		border-bottom: none;
	}
	
	/* 一级菜单样式 */
	.first-level {
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 14px 20px;
		color: #333;
		font-weight: 500;
		cursor: pointer;
	}
	
	.first-level:hover,
	.first-level.active {
		color: #2B6DE5;
		background: #f8f9fa;
	}
	
	/* 箭头样式 */
	.arrow-icon {
		font-size: 12px;
		color: #999;
	}
	
	.category-item.open .arrow-icon {
		transform: rotate(90deg);
	}
	
	/* 二级菜单样式 */
	.submenu {
		display: none;
		background: #f8f9fa;
	}
	
	.category-item.open .submenu {
		display: block;
	}
	
	.submenu-item {
		display: flex;
		align-items: center;
		gap: 8px;
		padding: 12px 20px 12px 40px;
		color: #666;
		text-decoration: none;
	}
	
	.submenu-item:hover,
	.submenu-item.active {
		color: #2B6DE5;
		background: #f5f7fa;
		text-decoration: none;
	}
	
	/* 国旗图标样式 */
	.country-flag {
		width: 18px;
		object-fit: cover;
		border-radius: 0;
	}
</style>

<div class="{if count($Cart.product_groups) > 1}col-sm-3{else}col-sm-2{/if}">
	<div class="category-nav">
		<!-- 搜索区域 -->
		<div class="search-section">
			<div class="search-box pro-search-box">
				<div class="position-relative">
					<input type="text" id="searchInp" name="keywords" 
						class="form-control" 
						placeholder="{$Lang.search_products}"
						value="{$Get.keywords}"
						autocomplete="off">
					<i class="mdi mdi-magnify search-icon text-white" id="searchIcon"></i>
				</div>
			</div>
		</div>

		<!-- 分类导航 -->
		{if $Cart.product_groups}
		<div class="prolist">
			{foreach $Cart.product_groups as $firstIndex=>$groups}
			<div class="category-item {if ($Get.fid == $groups.id) || (empty($Get.fid) && $firstIndex==0)}open{/if}">
				<div class="first-level {if ($Get.fid == $groups.id) || (empty($Get.fid) && $firstIndex==0)}active{/if}">
					<span>{$groups.name}</span>
					<i class="fas fa-chevron-right arrow-icon"></i>
				</div>
				<div class="submenu">
					{foreach $groups.second as $secondIndex=>$second}
					<a class="submenu-item {if ($Get.gid == $second.id) || (empty($Get.gid) && empty($Get.fid) && $firstIndex==0 && $secondIndex==0)}active{/if}" 
						href="/cart?fid={$second.gid}&gid={$second.id}">
						{php}
						if (strpos($second['name'], '|') !== false) {
							$name_parts = explode('|', $second['name']);
							echo '<img src="/upload/common/country/'.trim($name_parts[0]).'.png" class="country-flag" alt="'.trim($name_parts[0]).'">';
							echo '<span>'.trim($name_parts[1]).'</span>';
						} else {
							echo $second['name'];
						}
						{/php}
					</a>
					{/foreach}
				</div>
			</div>
			{/foreach}
		</div>
		{else}
		<div class="d-flex align-items-center justify-content-center" style="height: 200px">
			{$Lang.no_data_available}
		</div>
		{/if}
	</div>
</div>

<script>
	// 搜索功能
	$(document).ready(function() {
		// 阻止表单默认提交行为
		$('.pro-search-box').on('submit', function(e) {
			e.preventDefault();
		});
		
		// 回车搜索
		$('#searchInp').on('keydown', function(e) {
			if (e.keyCode === 13) {
				e.preventDefault();
				doSearch();
			}
		});
		
		// 点击搜索图标
		$('#searchIcon').on('click', function(e) {
			e.preventDefault();
			doSearch();
		});
		
		// 搜索函数
		function doSearch() {
			var keywords = $('#searchInp').val().trim();
			if (keywords !== '') {
				window.location.href = '/cart?action=product&keywords=' + encodeURIComponent(keywords);
			}
		}
	});
	
	// 分类展开/收起
	$('.first-level').on('click', function(e) {
		e.preventDefault();
		const item = $(this).parent();
		
		if(item.hasClass('open')) {
			item.removeClass('open');
		} else {
			item.addClass('open');
		}
	});
	
	// 初始化激活状态
	$(document).ready(function() {
		const activeItem = $('.submenu-item.active').parents('.category-item');
		if(activeItem.length) {
			activeItem.addClass('open');
		}
	});
</script>