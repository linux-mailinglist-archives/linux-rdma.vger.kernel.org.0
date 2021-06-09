Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A14C3A15E3
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 15:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbhFINq2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 09:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236518AbhFINq2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 09:46:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD3CF6101A;
        Wed,  9 Jun 2021 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623246273;
        bh=9S5I/hONNnA49sSVmWGmLopswGW0CUdL0fGYQc8r3VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRpb+C45ueKNi6MMNu0n9z4m4F/HSRqlhVF/tf9pNRbUpVKxu/aagkMTUKf0oqTyT
         cgNwRlddUp7zhjA108254xSvnAfseRoRvwPAk8tA+W0Y9RfU79mQJJz1xQp+4+Y7S6
         UlDE8XKGO6mjhCcEqqtQdsXGkN7wuO4yFNAE5Es4kM9/QLhDJuhYVNCYVfq2SSbZVQ
         Dtm3vsqxcCxImgwnUAWtD6Um/9EPOwOJMZ3Cy9OY9MRJgnGQDp+OHh5rWexS0cY3+K
         8kHNq7skGADelVrPW/hA0xIkv2jzSIrspWJpQYzWFxgx20zIFrX1I4N6+ep7fPcKph
         1hMQAvmAkiK6A==
Date:   Wed, 9 Jun 2021 16:44:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Clear extended doorbell info before
 using
Message-ID: <YMDFvX0ySdq3n+Ra@unreal>
References: <1623237065-43344-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623237065-43344-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 07:11:05PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> Both of HIP08 and HIP09 require the extended doorbell information to be
> cleared before being used.

Is it bugfix or feature?
For the fix, it needs to have Fixes ... line.

> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 16 ++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index fbc45b9..c5d2cfb 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1572,6 +1572,20 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
>  	}
>  }
>  
> +static void hns_roce_clear_extdb_list_info(struct hns_roce_dev *hr_dev)
> +{
> +	struct hns_roce_cmq_desc desc;
> +	int ret;
> +
> +	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO,
> +				      false);
> +	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
> +	if (ret)
> +		ibdev_warn(&hr_dev->ib_dev,
> +			   "failed to clear extended doorbell info, ret = %d.\n",
> +			   ret);
> +}
> +
>  static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
>  {
>  	struct hns_roce_query_fw_info *resp;
> @@ -2684,6 +2698,8 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
>  	if (ret)
>  		return ret;
>  
> +	/* The hns ROCEE requires the extdb info to be cleared before using */
> +	hns_roce_clear_extdb_list_info(hr_dev);

If it "requires", why do you proceed anyway? Why don't you check for
success/failure?

Thanks

>  	if (hr_dev->is_vf)
>  		return 0;
>  
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index cd361c0..073e835 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -250,6 +250,7 @@ enum hns_roce_opcode_type {
>  	HNS_ROCE_OPC_CLR_SCCC				= 0x8509,
>  	HNS_ROCE_OPC_QUERY_SCCC				= 0x850a,
>  	HNS_ROCE_OPC_RESET_SCCC				= 0x850b,
> +	HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO		= 0x850d,
>  	HNS_ROCE_OPC_QUERY_VF_RES			= 0x850e,
>  	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
>  	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
> -- 
> 2.7.4
> 
