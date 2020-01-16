Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18B913F9F8
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbgAPTvW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 14:51:22 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33843 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbgAPTvV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 14:51:21 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so9666551qvf.1
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 11:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YRsLxcccoIS5oqpRytcB+dyuErle/RRf6ycIL/M4rRM=;
        b=fnBvYJx9kxuaBb6/8JwbIYXJdh2v5vVJvHYT74IyJ11fCEbdMYFYAGjkAIQBzhlxF/
         ONlTg4QE540WYUMAUWN5Rb5TuVqnZZwFQXHJhFVuJsi4XxHxHnzRvfdUI/2ohNEbr4jb
         gr9FERKyDdtHveUrZ+Gedl4vMSWtthwZuUqFIcjBm08nH9jHssx2tL/dXYC7GvdIsdmt
         LDzNNzbQjbXXGEp4b41ZZF3k31xJ8bJsOjkSBWpUsoRcfJkNgboD+6Xj7AAejRHtXDga
         GECMuMGiXCHEgLzFSL9dQM2izOc5oaD2GuSCW75NTxWRA4ZEO2DVVZKkAEDa5GSLfkOE
         j/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YRsLxcccoIS5oqpRytcB+dyuErle/RRf6ycIL/M4rRM=;
        b=TVkV8JZExBZwNE2u1P3/pOmJXRwPG9DNOQQvfq+QXGE8ymbOjE+gz6uBpYVsAQXYlC
         PHGAhYwkSI+X6zR1hpvc4lO9wzN6BQF9llTK89yfGNQ+2PFnd36cWGG2mlDJlfEcJIv4
         tX8mUItZQylSrGtHmV+/1sbgMv4WMTnzq9hvWhagVkE8c758+mtKMZhpnsASmUYUObZ8
         njGkkqEyqAliMEoUnGDvxCbJoy4yN8+6xZB+AAmqFE4OBAWeMSUwSWZ6TjWEScQczF4T
         hXZQfRCQa9TjWw9TAf6lZobYH+Z+tOoW7/GIfYybvTGY1wmZTi7oxWdx3QRkY6KMgM4E
         Eh4A==
X-Gm-Message-State: APjAAAWekcfG8zzOkArfVkz4LbwYALwDMQWM00dLziyq/cgqbmxg+pv+
        lo5YQmXzu9FaZPiX3ZgTjYpoqQ==
X-Google-Smtp-Source: APXvYqy8pAf56sBLzvNeUgN/PYUVZUdpmRh3o1uVOW8bOZadsJNYaPmA7xEjNcoY8LkKu2Vzyi+ZaA==
X-Received: by 2002:ad4:478b:: with SMTP id z11mr4361328qvy.185.1579204280408;
        Thu, 16 Jan 2020 11:51:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v4sm11706599qtd.24.2020.01.16.11.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 11:51:19 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1isBAk-0003OX-GC; Thu, 16 Jan 2020 15:51:18 -0400
Date:   Thu, 16 Jan 2020 15:51:18 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic in
 userspace
Message-ID: <20200116195118.GG10759@ziepe.ca>
References: <1579052546-11746-1-git-send-email-liweihang@huawei.com>
 <20200115205611.GG25201@ziepe.ca>
 <9b7a3629-0564-6643-f6e7-c2f098afd010@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b7a3629-0564-6643-f6e7-c2f098afd010@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 12:05:13PM +0800, Weihang Li wrote:
> 
> 
> On 2020/1/16 4:56, Jason Gunthorpe wrote:
> > On Wed, Jan 15, 2020 at 09:42:26AM +0800, Weihang Li wrote:
> >> From: Jiaran Zhang <zhangjiaran@huawei.com>
> >>
> >> To support extended atomic operations including cmp & swap and fetch & add
> >> of 8 bytes, 16 bytes, 32 bytes, 64 bytes in userspace, some field in qpc
> >> should be configured.
> >>
> >> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 16 +++++++++++++++-
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  3 ++-
> >>  2 files changed, 17 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> index f1e0ba6..7edf3d8 100644
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> @@ -1692,7 +1692,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
> >>  	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
> >>  	caps->qpc_entry_sz	= HNS_ROCE_V2_QPC_ENTRY_SZ;
> >>  	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
> >> -	caps->trrl_entry_sz	= HNS_ROCE_V2_TRRL_ENTRY_SZ;
> >> +	caps->trrl_entry_sz	= HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ;
> >>  	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
> >>  	caps->srqc_entry_sz	= HNS_ROCE_V2_SRQC_ENTRY_SZ;
> >>  	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
> >> @@ -3286,6 +3286,9 @@ static void set_access_flags(struct hns_roce_qp *hr_qp,
> >>  	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
> >>  		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
> >>  	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S, 0);
> >> +	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S,
> >> +		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
> >> +	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S, 0);
> >>  }
> >>  
> >>  static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
> >> @@ -3653,6 +3656,12 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
> >>  			     IB_ACCESS_REMOTE_ATOMIC));
> >>  		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
> >>  			     0);
> >> +		roce_set_bit(context->byte_76_srqn_op_en,
> >> +			     V2_QPC_BYTE_76_EXT_ATE_S,
> >> +			     !!(attr->qp_access_flags &
> >> +				IB_ACCESS_REMOTE_ATOMIC));
> >> +		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
> >> +			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
> >>  	} else {
> >>  		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S,
> >>  			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_READ));
> >> @@ -3668,6 +3677,11 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
> >>  			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_ATOMIC));
> >>  		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
> >>  			     0);
> >> +		roce_set_bit(context->byte_76_srqn_op_en,
> >> +			     V2_QPC_BYTE_76_EXT_ATE_S,
> >> +			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_ATOMIC));
> >> +		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
> >> +			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
> >>  	}
> > 
> > What happens to your userspace if it runs on an old kernel and tries
> > to use extended atomic?
> > 
> > Jason
> >
> 
> Hi Jason,
> 
> If the hns userspace runs with old kernel, the hardware will report a asynchronous
> event for the extended atomic operation and modify the qp to error state because
> the enable bit in this qp's context hasn't been set.
> 
> The driver will print like this:
> 
> [ 1252.240921] hns3 0000:7d:00.0: Invalid request local work queue 0x9 error.
> [ 1252.247772] hns3 0000:7d:00.0: no hr_qp can be found!

Ideally the provider will not set
IBV_PCI_ATOMIC_OPERATION_4_BYTE_SIZE_SUP and related without kernel
support..

I've applied this patch, but I feel like you may need a followup to
fix the capability reporting?

Jason
