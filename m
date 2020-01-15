Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E1C13CE5C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 21:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgAOU4O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 15:56:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42078 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgAOU4N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 15:56:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id z14so17060996qkg.9
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 12:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I0s06Kjim1gi+IqtxvNfAWyLaPerL8CAGUSFL7wN6f8=;
        b=FQ7NQEjjZuujAFEZj77Zn0UoMjMBIrHmGqLh7FDBZzxyYSEkf13Cfz9IwWHjSA/t65
         dp2/1pqb9zHs5Mb4mrAGTTN0Jx1JY0e1B9cCXKiXJWuG3Hmw3BmOUZ6MuT7TqugCw0bQ
         4GVJXroXTVKXsjOslzFchBdFythSIyItDLQG4DNm/Vb8e7YRu6lgor3aue1sfNt+esTW
         lRxTvQ/0udy5rk8FI8YOn6kIpjbG/CapsabYM1qdxLoI+LYN3bt8i36J6WnsCNiihYms
         jTN4r0shBBAyKdIUQ6ydQjY7lLsxWvLT5QAse2Ic+b9fuq7BIHKJuSXHhdqnZ/Gll7qU
         zuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I0s06Kjim1gi+IqtxvNfAWyLaPerL8CAGUSFL7wN6f8=;
        b=R2Oa2fFbBP+0VDgP6PsKskKsCzLEsTbZGLANrM5K3Qc7GWZFppRqYE/d3CGAhfnOW+
         YN6kdqm8nKokOvd3iQJlizTqIrFRAVwLGyH0J2A8j+bzpqrvWIpMloZvF/YXPYaTZjGj
         p6gFYFvUSjmQEyLqUCK6H/kgAFNgkGKs0WDEUGEprhBlWUDwHKehhY7AzeOEljYrTcY/
         Cadm1Y6QVsoDihzkDU7Vy4sKxt2guX/AEp0q1Wu/2870rVA1bqVDNJthUIDpLbmzj7X6
         yzAAqdbGUF/oMk0DuIq0AWR7Y1F6UDn7naX7RNFsUEMfssxEZV07s/r3bODcoqZIAjf6
         V49w==
X-Gm-Message-State: APjAAAXd2Q8RwCTEh//C8/Wd3RgNSMMWn3HNYvShyP2aXzGsBDmEV2VZ
        FKgAXNYuVKZLHeaTEvqBm3XELg==
X-Google-Smtp-Source: APXvYqw8JMraU3J1rDXpQUJLiGwz1VNO4Q9m9A6mWlHEaKagglGCTIsNPu/etOQyiMZmzoyx3q5M8Q==
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr24391092qkk.423.1579121772521;
        Wed, 15 Jan 2020 12:56:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s26sm9239606qkj.24.2020.01.15.12.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 12:56:12 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irphz-0007J9-L8; Wed, 15 Jan 2020 16:56:11 -0400
Date:   Wed, 15 Jan 2020 16:56:11 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic in
 userspace
Message-ID: <20200115205611.GG25201@ziepe.ca>
References: <1579052546-11746-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579052546-11746-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 15, 2020 at 09:42:26AM +0800, Weihang Li wrote:
> From: Jiaran Zhang <zhangjiaran@huawei.com>
> 
> To support extended atomic operations including cmp & swap and fetch & add
> of 8 bytes, 16 bytes, 32 bytes, 64 bytes in userspace, some field in qpc
> should be configured.
> 
> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 16 +++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  3 ++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index f1e0ba6..7edf3d8 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1692,7 +1692,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
>  	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
>  	caps->qpc_entry_sz	= HNS_ROCE_V2_QPC_ENTRY_SZ;
>  	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
> -	caps->trrl_entry_sz	= HNS_ROCE_V2_TRRL_ENTRY_SZ;
> +	caps->trrl_entry_sz	= HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ;
>  	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
>  	caps->srqc_entry_sz	= HNS_ROCE_V2_SRQC_ENTRY_SZ;
>  	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
> @@ -3286,6 +3286,9 @@ static void set_access_flags(struct hns_roce_qp *hr_qp,
>  	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
>  		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
>  	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S, 0);
> +	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S,
> +		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
> +	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S, 0);
>  }
>  
>  static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
> @@ -3653,6 +3656,12 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
>  			     IB_ACCESS_REMOTE_ATOMIC));
>  		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
>  			     0);
> +		roce_set_bit(context->byte_76_srqn_op_en,
> +			     V2_QPC_BYTE_76_EXT_ATE_S,
> +			     !!(attr->qp_access_flags &
> +				IB_ACCESS_REMOTE_ATOMIC));
> +		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
> +			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
>  	} else {
>  		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S,
>  			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_READ));
> @@ -3668,6 +3677,11 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
>  			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_ATOMIC));
>  		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
>  			     0);
> +		roce_set_bit(context->byte_76_srqn_op_en,
> +			     V2_QPC_BYTE_76_EXT_ATE_S,
> +			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_ATOMIC));
> +		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
> +			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
>  	}

What happens to your userspace if it runs on an old kernel and tries
to use extended atomic?

Jason
