Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F02BB64B
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 21:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgKTUNn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 15:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgKTUNn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Nov 2020 15:13:43 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8CFC0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 20 Nov 2020 12:13:41 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id l2so10197626qkf.0
        for <linux-rdma@vger.kernel.org>; Fri, 20 Nov 2020 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aPScyrnxh4plIbLylCUaxhXSEQ1IghdSBQrLlD6gycQ=;
        b=Qn0bVboy65DJwhPQ3Z98EEd4x85LdYqSfn7+3YQmrPHY58Ox6tmVwtrmLH6Hi1XacK
         dr8+P0hBfavK9p4oXycUgNlA2fnu2iy+MaVJW1Ec43HBiu9ogmNEbaiWxafm8H11b4M/
         KGx0tEc/rQl0eltFP/5UTV630EUaAGv41fJDMfrMlks15eFJ16RaP1msLZ+kmfUaz/Cm
         n0GGWuap04soA2H5vscqjRX6TgA7Ks5rUJT+GE2yWqVXVr/fwlxQDZDR7P4D2ZWJQMmT
         bWgT3SB8UVoUdZzj2aF8tyiyoNE591A43/pj823lGn61o8aFAGpZEWuPZL9SYeax3KsW
         HOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aPScyrnxh4plIbLylCUaxhXSEQ1IghdSBQrLlD6gycQ=;
        b=A/5x8j2SYtbmnkOJMosHMgwOFLe8ROJZt5OZ6nM0onyporIUNReJ9kr0ANOsCNhnRg
         lzSPCt9EBX23lTYyhygAwQ288A7SpUrNXDhycOG+oEWDER2YLTeyYvH2S+4xQQCYXNgQ
         h4TGP5jXzex0SqKI2QzTRliY2WnsvU+mahsxLfh1ZjbjumpDnl8YdcImuIIp1Ss5Z8oT
         JlJ92YUcQj6YjsOOfkoJF96Z37Ty3pC2UAPb9ISXLw++68s0nFJmzxx1JPGXVcwRDUuz
         fhAaSEzcrLkA3OVFQZFlweNu29CHK8hsx1qC16v+IU7ko7hW7xSTPzUwVC9jUfkWaoJw
         A06g==
X-Gm-Message-State: AOAM530G8jLr91uQ3NGM4VONqF3Qjl9CMJBYFrw4EgJDFf0P4WDPtxJ+
        qAJ/Z+Olv8l+Y06r/6Y6WDxFJg==
X-Google-Smtp-Source: ABdhPJxn9yQcVnjaOFYDCV3KBoI2du+QJm6m8/ZZkpQ8dNwjshGiaw06a4Grt42BBWOpwNmfhPPLsw==
X-Received: by 2002:a37:78c:: with SMTP id 134mr18811281qkh.359.1605903220464;
        Fri, 20 Nov 2020 12:13:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r190sm2565852qkf.101.2020.11.20.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:13:39 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kgCmo-008xNw-Vd; Fri, 20 Nov 2020 16:13:39 -0400
Date:   Fri, 20 Nov 2020 16:13:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v3 for-next 1/2] RDMA/hns: Add support for CQ stash
Message-ID: <20201120201338.GS244516@ziepe.ca>
References: <1605867440-2413-1-git-send-email-liweihang@huawei.com>
 <1605867440-2413-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605867440-2413-2-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 20, 2020 at 06:17:19PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Stash is a mechanism that uses the core information carried by the ARM AXI
> bus to access the L3 cache. It can be used to improve the performance by
> increasing the hit ratio of L3 cache. CQs need to enable stash by default.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_common.h | 10 ++++++++
>  drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 39 +++++++++++++++++------------
>  4 files changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
> index f5669ff..41a2252 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_common.h
> @@ -53,6 +53,16 @@
>  #define roce_set_bit(origin, shift, val) \
>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
>  
> +#define FIELD_LOC(field_h, field_l) field_h, field_l
> +
> +#define _hr_reg_enable(arr, field_h, field_l)                                  \
> +	(arr)[(field_l) / 32] |=                                               \
> +		(BIT((field_l) % 32)) +                                        \
> +		BUILD_BUG_ON_ZERO((field_h) != (field_l)) +                    \
> +		BUILD_BUG_ON_ZERO((field_l) / 32 >= ARRAY_SIZE(arr))
> +
> +#define hr_reg_enable(arr, field) _hr_reg_enable(arr, field)
> +
>  #define ROCEE_GLB_CFG_ROCEE_DB_SQ_MODE_S 3
>  #define ROCEE_GLB_CFG_ROCEE_DB_OTH_MODE_S 4
>  
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 1d99022..ab7df8e 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -223,6 +223,7 @@ enum {
>  	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
>  	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
>  	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
> +	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
>  };
>  
>  #define HNS_ROCE_DB_TYPE_COUNT			2
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 4b82912..da7f909 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -3177,6 +3177,9 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
>  		       V2_CQC_BYTE_8_CQE_SIZE_S, hr_cq->cqe_size ==
>  		       HNS_ROCE_V3_CQE_SIZE ? 1 : 0);
>  
> +	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_STASH)
> +		hr_reg_enable(cq_context->raw, CQC_STASH);
> +
>  	cq_context->cqe_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
>  
>  	roce_set_field(cq_context->byte_16_hop_addr,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index 1409d05..50a5187 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -267,22 +267,27 @@ enum hns_roce_sgid_type {
>  };
>  
>  struct hns_roce_v2_cq_context {
> -	__le32	byte_4_pg_ceqn;
> -	__le32	byte_8_cqn;
> -	__le32	cqe_cur_blk_addr;
> -	__le32	byte_16_hop_addr;
> -	__le32	cqe_nxt_blk_addr;
> -	__le32	byte_24_pgsz_addr;
> -	__le32	byte_28_cq_pi;
> -	__le32	byte_32_cq_ci;
> -	__le32	cqe_ba;
> -	__le32	byte_40_cqe_ba;
> -	__le32	byte_44_db_record;
> -	__le32	db_record_addr;
> -	__le32	byte_52_cqe_cnt;
> -	__le32	byte_56_cqe_period_maxcnt;
> -	__le32	cqe_report_timer;
> -	__le32	byte_64_se_cqe_idx;
> +	union {
> +		struct {
> +			__le32 byte_4_pg_ceqn;
> +			__le32 byte_8_cqn;
> +			__le32 cqe_cur_blk_addr;
> +			__le32 byte_16_hop_addr;
> +			__le32 cqe_nxt_blk_addr;
> +			__le32 byte_24_pgsz_addr;
> +			__le32 byte_28_cq_pi;
> +			__le32 byte_32_cq_ci;
> +			__le32 cqe_ba;
> +			__le32 byte_40_cqe_ba;
> +			__le32 byte_44_db_record;
> +			__le32 db_record_addr;
> +			__le32 byte_52_cqe_cnt;
> +			__le32 byte_56_cqe_period_maxcnt;
> +			__le32 cqe_report_timer;
> +			__le32 byte_64_se_cqe_idx;
> +		};
> +		__le32 raw[16];
> +	};

It has missed the point of how the FIELD_LOC worked in the iba macros,
you want to specify the type

  FIELD_LOC(struct hns_roce_v2_cq_context, 63, 63)

And not introduce a raw array in a union, just validate the type and
cast it to a __le32 *

And again, if you are going to be building macros like this then
setting fields to all ones must be the corner case.

Write it more clearly:

hr_reg_set(cq_context, CQC_STASH, FIELD_ALL_ONES(CQC_STASH));

Now you can replace some of the other macros with the safer/simpler
scheme.

Jason
