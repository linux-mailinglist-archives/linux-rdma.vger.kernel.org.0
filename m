Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D0A133093
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 21:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgAGUbY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 15:31:24 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39248 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGUbX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 15:31:23 -0500
Received: by mail-qv1-f65.google.com with SMTP id y8so452416qvk.6
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 12:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZjFOC68CDVuCWb5i2FiMM/4p0GejOCaxCUOfVp+zroQ=;
        b=jSpuhEmkwINM2/TCGww+B5nO3x6Yvfg9OTTXay1APORPd72Z5mYn4J5YmtIKISpqqs
         z0wvqrcFBTSL78qgxkPeEOreVdUx/ao5GLV2IZlhW/6GtWa/10VUZPu05yESUWBXDz2g
         Tg67Y9TynpficOYpxfE2POrJITtWHFWBnqGy1BMOkkK2LSdcXLubsrg1JoWdff03T7RV
         jGmPD0A4U8IUXoyWLYqks9/zJg2HIkmt4v090kb481GET1ls2kWcubQO7TZJtJtrZvs3
         AV4HOeRi0bBlmctKkz0CvDSnap8lgjBdhi1NQZulx3jMH7Tv8Q7HBCGdgoVBEHCQGqOm
         akZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZjFOC68CDVuCWb5i2FiMM/4p0GejOCaxCUOfVp+zroQ=;
        b=VvYpjmcpNEesDDY2tmG6Oi9P6PJwUfcwEi9QTxbAPxWepYwqN4VYSmFIXGkrYiraUJ
         vQleBZysgE+rjaVZIBEUH4+DukjoXkdLMsU+wzPAsswaXVzDrA9S3ZUkk23KTkzPeUoW
         lZmhbQ8IvMH22/t2J9B1535OXNm92K6U6kkd0e38jTd3SQElAaeVY9jKsQpSZjJ8MmWs
         pR3wA7zaRF8nRVVAktOm810KCr0Rkro3conRu5t5fQdgB1rrvhHle8HIAMv6YrMBMf7M
         5RGUAPiT6LlRYD84JyIXvViqzgQxisVM/zAHwkPOo3cOm+pwMozGYuSJUnFnPKJzXL6e
         BNBQ==
X-Gm-Message-State: APjAAAW+rEMMGHLOJFjVbXfzgCNhlhRvt3pZbDWgamBY4NCWQl58VFfq
        X2c+9WKLUhd1LXc7SJYmtVtSNA==
X-Google-Smtp-Source: APXvYqyDcLj6x8DCYXQ7iv0OTKYJp9oxs/NtOuDXEL+ZR/VntN/AG/oRRx+y7jb/lC+k+R9CdjKtGQ==
X-Received: by 2002:a0c:ed22:: with SMTP id u2mr1168813qvq.13.1578429082471;
        Tue, 07 Jan 2020 12:31:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o17sm395427qtq.93.2020.01.07.12.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 12:31:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iovVZ-0001Ql-JE; Tue, 07 Jan 2020 16:31:21 -0400
Date:   Tue, 7 Jan 2020 16:31:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 7/7] RDMA/hns: Fix coding style issues
Message-ID: <20200107203121.GA5313@ziepe.ca>
References: <1578313276-29080-1-git-send-email-liweihang@huawei.com>
 <1578313276-29080-8-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578313276-29080-8-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 06, 2020 at 08:21:16PM +0800, Weihang Li wrote:
> From: Lijun Ou <oulijun@huawei.com>
> 
> Fix some coding style issuses without changing logic of codes, most of the
> modification is unreasonable line breaks and alignments.
> 
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 167 ++++++++++-------------------
>  drivers/infiniband/hw/hns/hns_roce_main.c  |  56 +++++-----
>  2 files changed, 86 insertions(+), 137 deletions(-)

If you are going to be re-intending code please at least refer to
clang-format's presentation. I recommend clang-format as an
interactive editor plugin to do single statement reformatting on
demand to help follow the coding style.

I ran it over the lines changed here and it suggested the below, which
seems like a reasonable improvement so I folded it in:
 - One line is better than two
 - Subexpressions crossing lines should be indented more than the
   normal indent. ie
    foo(a &
          B,
        c)
 - ?: should line up under the ?

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f15690fa56db47..00fd40fd8380e7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1366,8 +1366,7 @@ static int hns_roce_query_pf_timer_resource(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
-static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
-					int vf_id)
+static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev, int vf_id)
 {
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_vf_switch *swt;
@@ -1821,12 +1820,12 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 			roce_set_field(req_b->tail_ba_h, CFG_LLM_TAIL_BA_H_M,
 				       CFG_LLM_TAIL_BA_H_S,
 				       entry[page_num - 1].blk_ba1_nxt_ptr &
-				       HNS_ROCE_LINK_TABLE_BA1_M);
+					       HNS_ROCE_LINK_TABLE_BA1_M);
 			roce_set_field(req_b->tail_ptr, CFG_LLM_TAIL_PTR_M,
 				       CFG_LLM_TAIL_PTR_S,
 				       (entry[page_num - 2].blk_ba1_nxt_ptr &
-				       HNS_ROCE_LINK_TABLE_NXT_PTR_M) >>
-				       HNS_ROCE_LINK_TABLE_NXT_PTR_S);
+					HNS_ROCE_LINK_TABLE_NXT_PTR_M) >>
+					       HNS_ROCE_LINK_TABLE_NXT_PTR_S);
 		}
 	}
 	roce_set_field(req_a->depth_pgsz_init_en, CFG_LLM_INIT_EN_M,
@@ -2398,8 +2397,8 @@ static int hns_roce_v2_mw_write_mtpt(void *mb_buf, struct hns_roce_mw *mw)
 		       V2_MPT_BYTE_4_PD_S, mw->pdn);
 	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PBL_HOP_NUM_M,
 		       V2_MPT_BYTE_4_PBL_HOP_NUM_S,
-		       mw->pbl_hop_num == HNS_ROCE_HOP_NUM_0 ?
-		       0 : mw->pbl_hop_num);
+		       mw->pbl_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 :
+							       mw->pbl_hop_num);
 	roce_set_field(mpt_entry->byte_4_pd_hop_st,
 		       V2_MPT_BYTE_4_PBL_BA_PG_SZ_M,
 		       V2_MPT_BYTE_4_PBL_BA_PG_SZ_S,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index ac2e426c62504f..84e4707337a9b7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -260,10 +260,11 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u8 port_num,
 	mtu = iboe_get_mtu(net_dev->mtu);
 	props->active_mtu = mtu ? min(props->max_mtu, mtu) : IB_MTU_256;
 	props->state = netif_running(net_dev) && netif_carrier_ok(net_dev) ?
-		       IB_PORT_ACTIVE : IB_PORT_DOWN;
+			       IB_PORT_ACTIVE :
+			       IB_PORT_DOWN;
 	props->phys_state = props->state == IB_PORT_ACTIVE ?
-			    IB_PORT_PHYS_STATE_LINK_UP :
-			    IB_PORT_PHYS_STATE_DISABLED;
+				    IB_PORT_PHYS_STATE_LINK_UP :
+				    IB_PORT_PHYS_STATE_DISABLED;
 
 	spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
