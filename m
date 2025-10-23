Return-Path: <linux-rdma+bounces-14013-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2C2C00B47
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 13:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90ED73A2E0E
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FA230DD1E;
	Thu, 23 Oct 2025 11:24:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AED2FDC3A;
	Thu, 23 Oct 2025 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218657; cv=none; b=k+sfGHcjXJiZA6g3fycQytWNOuTfCj3032YDeEr9ynd5KkfhFUHJWXukE5jfaJw43qX45Q+SMS3cRKII1uCnOmH2AcIeNIb8IGNLAOxAD8zMap2KGaqTbrg+7mnXcWhEJdNVldDT9NuZBdzsA3RYej8xSLh9XBr0aCJhcdDu3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218657; c=relaxed/simple;
	bh=a3aNs6vrR4psypDkWMqYmRy2IIe82SusVNMrEZ3tF3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TB2MNpPHCctM/RzB5I+vA/oX6L6FS1StQQItmKSnvtzHszQrI1qPaIWhd7ITDRO5Np8PqkaEJ/FdhH2Xtvnh73iUjp00WTNSZz6U6CZjrr8mVI0xMT7iNHbgQPdBlPn4XaX7qnr97MRStB3KgX+3ycokPmwdntnal5lEI3bBXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDFE31516;
	Thu, 23 Oct 2025 04:23:59 -0700 (PDT)
Received: from [10.57.36.157] (unknown [10.57.36.157])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30F673F63F;
	Thu, 23 Oct 2025 04:24:04 -0700 (PDT)
Message-ID: <d594cdf2-5aab-4539-8d44-f7e57770df72@arm.com>
Date: Thu, 23 Oct 2025 12:24:01 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu: Allow drivers to say if they use
 report_iommu_fault()
To: Jason Gunthorpe <jgg@nvidia.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Christian Benvenuti <benve@cisco.com>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nelson Escobar <neescoba@cisco.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Samuel Holland <samuel@sholland.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>
Cc: patches@lists.linux.dev
References: <3-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <3-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-22 6:12 pm, Jason Gunthorpe wrote:
> report_iommu_fault() is an older API that has been superseded by
> iommu_report_device_fault() which is capable to support PRI.
> 
> Only two external drivers consume this, drivers/remoteproc and
> drivers/gpu/drm/msm. Ideally they would move over to the new APIs, but for
> now protect against accidentally mix and matching the wrong components.
> 
> The iommu drivers support either the old iommu_set_fault_handler() via the
> driver calling report_iommu_fault(), or they are newer server focused
> drivers that call iommu_report_device_fault().
> 
> Include a flag in the domain_ops if it calls report_iommu_fault() and
> block iommu_set_fault_handler() on iommu's that can't support it.

This isn't a domain operation though; depending on how you look at it, 
supporting a legacy fault_handler is either a capability of the IOMMU 
driver (that would be reachable via domain->owner->capable) or a 
property of the iommu_domain itself that the drivers can set at 
allocation time (basically this same patch just with the lines in 
slightly different places).

Thanks,
Robin.
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c   | 1 +
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 1 +
>   drivers/iommu/iommu.c                   | 6 +++++-
>   drivers/iommu/ipmmu-vmsa.c              | 1 +
>   drivers/iommu/mtk_iommu.c               | 1 +
>   drivers/iommu/mtk_iommu_v1.c            | 1 +
>   drivers/iommu/omap-iommu.c              | 1 +
>   drivers/iommu/rockchip-iommu.c          | 1 +
>   drivers/iommu/sun50i-iommu.c            | 1 +
>   include/linux/iommu.h                   | 3 +++
>   10 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 4ced4b5bee4df3..5ce8f82ddb534b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1644,6 +1644,7 @@ static const struct iommu_ops arm_smmu_ops = {
>   	.def_domain_type	= arm_smmu_def_domain_type,
>   	.owner			= THIS_MODULE,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.report_iommu_fault_supported = true,
>   		.attach_dev		= arm_smmu_attach_dev,
>   		.map_pages		= arm_smmu_map_pages,
>   		.unmap_pages		= arm_smmu_unmap_pages,
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index c5be95e560317e..3163a23fcbaa4f 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -598,6 +598,7 @@ static const struct iommu_ops qcom_iommu_ops = {
>   	.device_group	= generic_device_group,
>   	.of_xlate	= qcom_iommu_of_xlate,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.report_iommu_fault_supported = true,
>   		.attach_dev	= qcom_iommu_attach_dev,
>   		.map_pages	= qcom_iommu_map,
>   		.unmap_pages	= qcom_iommu_unmap,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 59244c744eabd2..34546a70fb5279 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2005,6 +2005,9 @@ EXPORT_SYMBOL_GPL(iommu_group_has_isolated_msi);
>    * This function should be used by IOMMU users which want to be notified
>    * whenever an IOMMU fault happens.
>    *
> + * This is a legacy API not supported by all drivers. New users should look
> + * to using domain->iopf_handler for the modern API.
> + *
>    * The fault handler itself should return 0 on success, and an appropriate
>    * error code otherwise.
>    */
> @@ -2012,7 +2015,8 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
>   					iommu_fault_handler_t handler,
>   					void *token)
>   {
> -	if (WARN_ON(!domain || domain->cookie_type != IOMMU_COOKIE_NONE))
> +	if (WARN_ON(!domain || domain->cookie_type != IOMMU_COOKIE_NONE ||
> +		    !domain->ops->report_iommu_fault_supported))
>   		return;
>   
>   	domain->cookie_type = IOMMU_COOKIE_FAULT_HANDLER;
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index ffa892f6571406..770fa248e30477 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -885,6 +885,7 @@ static const struct iommu_ops ipmmu_ops = {
>   			? generic_device_group : generic_single_device_group,
>   	.of_xlate = ipmmu_of_xlate,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.report_iommu_fault_supported = true,
>   		.attach_dev	= ipmmu_attach_device,
>   		.map_pages	= ipmmu_map,
>   		.unmap_pages	= ipmmu_unmap,
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 0e0285348d2b8e..0f44993eaadce3 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1019,6 +1019,7 @@ static const struct iommu_ops mtk_iommu_ops = {
>   	.get_resv_regions = mtk_iommu_get_resv_regions,
>   	.owner		= THIS_MODULE,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.report_iommu_fault_supported = true,
>   		.attach_dev	= mtk_iommu_attach_device,
>   		.map_pages	= mtk_iommu_map,
>   		.unmap_pages	= mtk_iommu_unmap,
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 10cc0b1197e801..279e7acfd5c6d3 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -582,6 +582,7 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
>   	.device_group	= generic_device_group,
>   	.owner          = THIS_MODULE,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.report_iommu_fault_supported = true,
>   		.attach_dev	= mtk_iommu_v1_attach_device,
>   		.map_pages	= mtk_iommu_v1_map,
>   		.unmap_pages	= mtk_iommu_v1_unmap,
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 5c6f5943f44b1f..3f3193de3ecd86 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1724,6 +1724,7 @@ static const struct iommu_ops omap_iommu_ops = {
>   	.device_group	= generic_single_device_group,
>   	.of_xlate	= omap_iommu_of_xlate,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.report_iommu_fault_supported = true,
>   		.attach_dev	= omap_iommu_attach_dev,
>   		.map_pages	= omap_iommu_map,
>   		.unmap_pages	= omap_iommu_unmap,
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 0861dd469bd866..0053f5aa2cb781 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1174,6 +1174,7 @@ static const struct iommu_ops rk_iommu_ops = {
>   	.device_group = generic_single_device_group,
>   	.of_xlate = rk_iommu_of_xlate,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.report_iommu_fault_supported = true,
>   		.attach_dev	= rk_iommu_attach_device,
>   		.map_pages	= rk_iommu_map,
>   		.unmap_pages	= rk_iommu_unmap,
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index de10b569d9a940..29b230050906a2 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -849,6 +849,7 @@ static const struct iommu_ops sun50i_iommu_ops = {
>   	.of_xlate	= sun50i_iommu_of_xlate,
>   	.probe_device	= sun50i_iommu_probe_device,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.report_iommu_fault_supported = true,
>   		.attach_dev	= sun50i_iommu_attach_device,
>   		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
>   		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index c30d12e16473df..e2bf7885287fac 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -714,6 +714,8 @@ struct iommu_ops {
>   
>   /**
>    * struct iommu_domain_ops - domain specific operations
> + * @report_iommu_fault_supported: True if the domain supports
> + *                                iommu_set_fault_handler()
>    * @attach_dev: attach an iommu domain to a device
>    *  Return:
>    * * 0		- success
> @@ -751,6 +753,7 @@ struct iommu_ops {
>    * @free: Release the domain after use.
>    */
>   struct iommu_domain_ops {
> +	bool report_iommu_fault_supported : 1;
>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>   	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
>   			     ioasid_t pasid, struct iommu_domain *old);

