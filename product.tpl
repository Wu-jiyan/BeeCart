<div class="row">
	{include file="cart/BeeCart/sidebar-categories"}

	<div class="{if count($Cart.product_groups) > 1}col-sm-9{else}col-sm-10{/if}">
		{if $Cart.product_groups_checked.headline || $Cart.product_groups_checked.tagline}
		<div class="product-headline mb-4">
			{if $Cart.product_groups_checked.headline}
			<h2 class="headline-title">{$Cart.product_groups_checked.headline}</h2>
			{/if}
			{if $Cart.product_groups_checked.tagline}
			<div class="headline-content">{$Cart.product_groups_checked.tagline}</div>
			{/if}
		</div>
		{/if}
		
		<div style="min-height: calc(100vh - 200px);">
			{if $Cart.products}
			<div class="row g-3">
				{foreach $Cart.products as $list}
				<div class="col-sm-6 col-lg-4 mb-4">
					<div class="product-card">
						<div class="product-header">
							{php}
							if (strpos($list['name'], '|') !== false) {
								$name_parts = explode('|', $list['name']);
								echo '<h3 class="product-title">'.trim($name_parts[0]).'</h3>';
								if(!empty(trim($name_parts[1]))) {
									echo '<span class="product-tag">'.trim($name_parts[1]).'</span>';
								}
							} else {
								echo '<h3 class="product-title">'.$list['name'].'</h3>';
							}
							{/php}
						</div>
						<div class="product-body">
							<div class="product-description">
								{$list.description}
							</div>
							
							{if $list.stock_control==1}
							<div class="product-stock">
								{$Lang.stock}： {$list.qty}
							</div>
							{/if}
							
							<div class="product-price-section">
								{if $list.has_bates}
								<div class="price-main">
									<span class="currency">{$Cart.currency.prefix}</span>
									<span class="amount">{$list.sale_price}</span>
									<span class="period">/ {$list.billingcycle_zh}</span>
								</div>
								{if $list.ontrial==1}
								<div class="price-trial">
									{$Cart.currency.prefix}{$list.ontrial_setup_fee+$list.ontrial_price} / 
									{$list.ontrial_cycle} {$list.ontrial_cycle_type == 'day' ? $Lang.day : $Lang.hour}
								</div>
								{/if}
								<div class="price-original">
									{$Lang.original_price}：{$Cart.currency.prefix} {$list.product_price} / {$list.billingcycle_zh}
								</div>
								{else}
								<div class="price-main">
									<span class="currency">{$Cart.currency.prefix}</span>
									<span class="amount">{$list.product_price}</span>
									<span class="period">/ {$list.billingcycle_zh}</span>
								</div>
								{if $list.ontrial==1}
								<div class="price-trial">
									{$Cart.currency.prefix}{$list.ontrial_setup_fee+$list.ontrial_price} / 
									{$list.ontrial_cycle} {$list.ontrial_cycle_type == 'day' ? $Lang.day : $Lang.hour}
								</div>
								{/if}
								{/if}
							</div>

							{if $list.stock_control==1 && $list.qty<1}
							<div class="sold-out">
								<i class="iconfont icon-yishouqing"></i>
								<span>{$Lang.sold_out}</span>
							</div>
							{else}
							<a href="/cart?action=configureproduct&pid={$list.id}{if $Get.site}&site={$Get.site}{/if}" 
								class="btn-buy">
								{$Lang.buy_now}
							</a>
							{/if}
						</div>
					</div>
				</div>
				{/foreach}
			</div>
			
			<div class="pagination-wrapper">
				<ul class="pagination">
					{$Pages}
				</ul>
			</div>
			{else}
			<div class="empty-state">
				<div class="empty-icon">
					<i class="fas fa-box-open"></i>
				</div>
				<p>{$Lang.no_data_available}</p>
			</div>
			{/if}
		</div>
	</div>
</div>

<style>
/* 修改标语样式 */
.product-headline {
	background: #2B6DE5;
	color: #fff;
	padding: 1.2rem 1.5rem;
	border-radius: 0;
	box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.headline-title {
	font-size: 1.1rem;
	font-weight: 600;
	margin: 0 0 0.5rem 0;
	color: #fff;
	background: none;
	-webkit-text-fill-color: initial;
}

.headline-content {
	font-size: 0.9rem;
	font-weight: normal;
	line-height: 1.5;
	color: rgba(255, 255, 255, 0.9);
	opacity: 1;
}

/* 修改产品卡片样式 */
.product-card {
	background: #fff;
	border-radius: 0;
	border: 1px solid transparent;
	box-shadow: 0 2px 8px rgba(0,0,0,0.08);
	transition: border-color 0.2s ease;
	height: 100%;
	display: flex;
	flex-direction: column;
}

.product-card:hover {
	border-color: #2B6DE5;
}

.product-header {
	padding: 20px;
	background: #f8f9fa;
	border-bottom: 1px solid rgba(0,0,0,0.05);
}

.product-title {
	font-size: 18px;
	font-weight: 600;
	color: #2c3e50;
	margin: 0;
	background: none;
	-webkit-text-fill-color: initial;
}

.product-body {
	padding: 20px;
	flex: 1;
	display: flex;
	flex-direction: column;
}

.product-description {
	color: #64748b;
	font-size: 14px;
	line-height: 1.6;
	margin-bottom: 20px;
	flex: 1;
}

.product-stock {
	color: #64748b;
	font-size: 14px;
	margin-bottom: 15px;
}

.product-price-section {
	margin-bottom: 20px;
}

.price-main {
	color: #2B6DE5;
	font-weight: 600;
	margin-bottom: 5px;
}

.price-main .currency {
	font-size: 16px;
	font-weight: normal;
}

.price-main .period {
	font-size: 14px;
	color: #64748b;
	font-weight: normal;
}

.price-trial {
	font-size: 14px;
	color: #4988fe;
	margin-bottom: 5px;
	background: linear-gradient(135deg, #4988fe 0%, #0142bc 100%);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

.price-original {
	font-size: 13px;
	color: #94a3b8;
	text-decoration: line-through;
}

.btn-buy {
	display: block;
	width: 100%;
	padding: 12px;
	background: #2B6DE5;
	color: #fff;
	text-align: center;
	border-radius: 0;
	font-weight: 500;
	transition: background 0.2s ease;
}

.btn-buy:hover {
	background: #2259c7;
	color: #fff;
}

.sold-out {
	text-align: center;
	padding: 12px;
	background: #f1f5f9;
	color: #64748b;
	border-radius: 8px;
	font-weight: 500;
}

/* 分页样式 */
.pagination-wrapper {
	width: 100%;
	display: flex;
	justify-content: center;
	margin-top: 30px;
	animation: fadeInUp 0.6s ease-out;
	animation-delay: 0.7s;
	animation-fill-mode: backwards;
}

/* 空状态样式 */
.empty-state {
	text-align: center;
	padding: 60px 20px;
	color: #64748b;
	animation: fadeInUp 0.6s ease-out;
}

.empty-icon {
	font-size: 48px;
	margin-bottom: 20px;
	color: #94a3b8;
}

/* 添加标签样式 */
.product-tag {
	position: absolute;
	top: 15px;
	right: 25px;
	background: #2B6DE5;
	color: #fff;
	padding: 4px 12px;
	border-radius: 0;
	font-size: 12px;
	font-weight: 500;
}
</style>
