Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9932EA5A3
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 07:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbhAEG4u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jan 2021 01:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbhAEG4u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Jan 2021 01:56:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 807C722482;
        Tue,  5 Jan 2021 06:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609829769;
        bh=5J9RZ0PBh+el0jE9d5uxFPRBh30jeEHN+OpWxbHJc74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WasnQiplFhQQqoJXUsbN4eZtBqNjCaaGKjIROrzo7VMwEn11Z6SuyQZHAUKJumrd5
         nVTapSNz7AIaYDviv9P+s65prs3lqjf8copvS0GmcxQhADk9uR8cXMKlcIqzWmw159
         XFrn8tZ4BG8Bi4lVJWv1ojldaTWD8QMMJI0iUW2k/mXxR0qi7Su7oAuuTtJCfrSuCZ
         CBGKf7XNmxCy9YxB5XK6YwK61WiInRw/nHOetDtVYRm47ktZv6v1ILvhNpX/EZzcFt
         2V0Wt2AbqTq8RDF79xDOOKKlTMbdYP7jl6QCZ4L8Qf0fShSsvAxFqyP55Xw+fqnbCL
         +HCEy28CbqllQ==
Date:   Tue, 5 Jan 2021 08:56:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH for-next] RDMA/hns: Add caps flag for UD inline of
 userspace
Message-ID: <20210105065605.GO31158@unreal>
References: <1609810615-50515-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609810615-50515-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 05, 2021 at 09:36:55AM +0800, Weihang Li wrote:
> HIP09 supports UD inline up to size of 1024 Bytes, the caps flag is got
> from firmware and passed back to userspace when creating QP.
>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 1 +
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 3 +++
>  include/uapi/rdma/hns-abi.h                 | 1 +
>  5 files changed, 9 insertions(+)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 55d5386..87716da 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -214,6 +214,7 @@ enum {
>  	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
>  	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
>  	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
> +	HNS_ROCE_CAP_FLAG_UD_SQ_INL		= BIT(13),
>  	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
>  	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
>  };
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 833e1f2..619e828 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1916,6 +1916,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
>  		caps->gmv_buf_pg_sz = 0;
>  		caps->gid_table_len[0] = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
>  					 caps->gmv_entry_sz);
> +		caps->flags |= HNS_ROCE_CAP_FLAG_UD_SQ_INL;
> +		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INL_EXT;

You are doing very similar assignment in the top of set_default_caps().
  1803         caps->max_sq_inline     = HNS_ROCE_V2_MAX_SQ_INLINE;

IMHO, it will be better to have one assignment instead of overwrite in
the same function.

Thanks
