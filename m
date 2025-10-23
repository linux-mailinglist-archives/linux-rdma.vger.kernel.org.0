Return-Path: <linux-rdma+bounces-14016-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 155BEC0126F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 14:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776341A61B6A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB1B30FC1F;
	Thu, 23 Oct 2025 12:34:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8E0309DB4;
	Thu, 23 Oct 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222870; cv=none; b=VxZ4LbDf4TVm1mcmiusU1O7gaeZH5erjfpVd0UFxSTKCQYtgViBmkhWDQTy3t9tPkRc+BSi8xAY3x7/HhXwjWKoHsz5GBhdMEeDumo1oFbIT+Fn5Z70gPdhSJ3SVYk0alDzyLOTu1kZdV0onctwYtPoklth0LT4BfgUA8I55SuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222870; c=relaxed/simple;
	bh=Q5hOvbRir9Pxa5UGWpGXYz016Pe0dJulkOyLZ3IDyLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJrAKibApxyE4pvpRx+6LfCIUlgFhIqRgYPDAISVvkru1vTU1qR/Tdjbe4uhmfVBSUk9m0CzVBlWzGMDKpnR1RM0Q7Cn6yW50r1NsmJmhYybBtW6Df7XBtjdbvhpe/Gz4n1YkYArHDlkuiuI2SWHHGBKpbyE26neEISHNObRXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 397E11516;
	Thu, 23 Oct 2025 05:34:19 -0700 (PDT)
Received: from [10.57.36.157] (unknown [10.57.36.157])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67773F59E;
	Thu, 23 Oct 2025 05:34:23 -0700 (PDT)
Message-ID: <579bdc4e-ab71-4120-8991-34400d4bbf8d@arm.com>
Date: Thu, 23 Oct 2025 13:34:21 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu/amd: Don't call report_iommu_fault()
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
References: <2-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <2-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-22 6:12 pm, Jason Gunthorpe wrote:
> This old style API is only used by drivers/gpu/drm/msm and
> drivers/remoteproc, neither are used on x86 HW. Remove the dead code to
> discourage new users.

I'd be almost certain there's somebody somewhere using remoteproc on x86 
with some FPGA/bespoke PCI device/on-board MCU/etc. - whether they're 
doing it on AMD *and* care about its fault reporting mechanism is really 
the question.
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/amd/iommu.c | 24 ------------------------
>   1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 2e1865daa1cee8..072c80bb2c2b3a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -840,29 +840,6 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
>   		dev_data = dev_iommu_priv_get(&pdev->dev);
>   
>   	if (dev_data) {
> -		/*
> -		 * If this is a DMA fault (for which the I(nterrupt)
> -		 * bit will be unset), allow report_iommu_fault() to
> -		 * prevent logging it.
> -		 */
> -		if (IS_IOMMU_MEM_TRANSACTION(flags)) {
> -			/* Device not attached to domain properly */
> -			if (dev_data->domain == NULL) {
> -				pr_err_ratelimited("Event logged [Device not attached to domain properly]\n");
> -				pr_err_ratelimited("  device=%04x:%02x:%02x.%x domain=0x%04x\n",
> -						   iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
> -						   PCI_FUNC(devid), domain_id);
> -				goto out;
> -			}
This part is unrelated to the report_iommu_fault() call - in fact it was 
specifically added even more recently.

Thanks,
Robin.

> -
> -			if (!report_iommu_fault(&dev_data->domain->domain,
> -						&pdev->dev, address,
> -						IS_WRITE_REQUEST(flags) ?
> -							IOMMU_FAULT_WRITE :
> -							IOMMU_FAULT_READ))
> -				goto out;
> -		}
> -
>   		if (__ratelimit(&dev_data->rs)) {
>   			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
>   				domain_id, address, flags);
> @@ -873,7 +850,6 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
>   			domain_id, address, flags);
>   	}
>   
> -out:
>   	if (pdev)
>   		pci_dev_put(pdev);
>   }


