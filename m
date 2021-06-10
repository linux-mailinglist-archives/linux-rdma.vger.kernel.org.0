Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A233A2AAA
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFJLuk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhFJLuj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 07:50:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 144F3613CA;
        Thu, 10 Jun 2021 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623325723;
        bh=OichHuMC0wIFssq6xKyc++HmwrkwJ+fMZTVl83jkHM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFwJlYMyYLQTs1NqUoPOGJePGuKwCSmrVM3qqig7SdhvYKUcjoYJj4QbpDUNURJV4
         jctsW8+AC6iDwNQwJGeQD/hYq8+LgKeMrLB2hV0Ar4uVZaA5hphYntXNtd+piXxESR
         rQfji5KkcCcyGNaOZ+UdWRftDq1TWqnQjsRGEnj+GbaYFqcEgMFnDWYWpcfGvr71EM
         Twh6e7soONpd4CaUgY4YxmtTQ5NjDz00g0H/ks2MOekAhGeuHDiCLGO4V2lAQgDDD6
         Nv4YMlvl9rVJCoL2e3Nll9V1Lr0EMz1FHgNGYTDTzPusInwIadK4fVPJeRTl8QsfoT
         toelhlLXZerMQ==
Date:   Thu, 10 Jun 2021 14:48:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Clear extended doorbell info
 before using
Message-ID: <YMH8GD2eoGLJugsS@unreal>
References: <1623323990-62343-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623323990-62343-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 10, 2021 at 07:19:50PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> Both of HIP08 and HIP09 require the extended doorbell information to be
> cleared before being used.
> 
> Fixes: 6b63597d3540 ("RDMA/hns: Add TSQ link table support")
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1:
> - Add fixes tag.
> - Add check for return value of hns_roce_clear_extdb_list_info().
> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1623237065-43344-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 21 +++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index fbc45b9..d24ac5c 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1572,6 +1572,22 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
>  	}
>  }
>  
> +static int hns_roce_clear_extdb_list_info(struct hns_roce_dev *hr_dev)
> +{
> +	struct hns_roce_cmq_desc desc;
> +	int ret;
> +
> +	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO,
> +				      false);
> +	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
> +	if (ret)
> +		ibdev_err(&hr_dev->ib_dev,
> +			  "failed to clear extended doorbell info, ret = %d.\n",
> +			  ret);
> +
> +	return ret;
> +}
> +
>  static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
>  {
>  	struct hns_roce_query_fw_info *resp;
> @@ -2684,6 +2700,11 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
>  	if (ret)
>  		return ret;
>  
> +	/* The hns ROCEE requires the extdb info to be cleared before using */
> +	ret = hns_roce_clear_extdb_list_info(hr_dev);
> +	if (ret)
> +		return ret;

You forgot to call to put_hem_table(hr_dev).

Thanks

> +
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
