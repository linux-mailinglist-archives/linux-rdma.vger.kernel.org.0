Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45F96227BE
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Nov 2022 10:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiKIJ52 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Nov 2022 04:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKIJ5Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Nov 2022 04:57:24 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6F9240B3;
        Wed,  9 Nov 2022 01:57:22 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f27so45265186eje.1;
        Wed, 09 Nov 2022 01:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nL5z1Js6hyAcZrzyFU0BOmZNXRwS5uMdz4l6yylknWc=;
        b=JTFpGXxocV3WCUC3KPauTR1lExSPlX6xdVTo7SaZ3bR1BmKgPMEIl8IbuUqUcG802T
         LM/OAauC87Wj1PB+oGYWAYG7K3FnlSHsdcHW07k8t8cDSezMiVo9fsQqQRTxHybBFy+W
         FLoUuIPFesQsz7f7lRGKwbvkr5b0c5yTOOY6JaFLc54me/FV7tQfO5C8yx0lL3n7LyRE
         5zeEx/nCJDV7Lg4dB45nEJowvJrPBqabsRTYFYhdgso9tQPdrySZfOCLii5CGXdE3Rgn
         Z0WPg/HCMxUqe8ISGixYIyyNXuV+bcfceFA/OAqYkKr7fwDqcat0yIgaFwHgqTzdWSzv
         WbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nL5z1Js6hyAcZrzyFU0BOmZNXRwS5uMdz4l6yylknWc=;
        b=cRtuF6WNEmQtSu7YJaXqlVFjwpdmoZdWt/SQ1xDp4GX2SzNdjRyKmFOEuIFTis+L1p
         0h+3mL1Nk8lNu31Wh+Yq+MyG17+pqUMexxMwR7zxuxwG9zhYausCJjEv/ZasKmGA49nh
         pGcO2fdFC3XFRmJt5UNzkBYDNJ0gPN6liZ9rzZcO1aCHPbtC9XA/bi/jqLgXlEzzowV1
         fNxgzSv4u8+RUkD5SJ3eTNrWMSk8w20m8tQ0F56sT9PH1wQf0UfYRG5g0pdnMM+kCV2G
         zUAUUjNjfTvZb6ysFAZ3UvEaRVX6BtUF685rAn+gDV1u3vtEvhXCZ8wrmHSl4GcyFpPk
         JOZw==
X-Gm-Message-State: ACrzQf2pvJfcLcJUBgPyLStShQMjtFCyCf5LFB4FdIieYsWd6JFoVB2d
        GZWDJGo6cQKkdzzDCJGgdRg=
X-Google-Smtp-Source: AMsMyM5uFFRc5skbmGh0Z8d+QcefJmP/NWF5aU2IwgfknwLbB/WeaF0mHX1Y0WzRXxAS1r+U0SWQdg==
X-Received: by 2002:a17:906:3b91:b0:7a5:e944:9e48 with SMTP id u17-20020a1709063b9100b007a5e9449e48mr1149141ejf.109.1667987840266;
        Wed, 09 Nov 2022 01:57:20 -0800 (PST)
Received: from leonid-Inspiron-3421 (93-172-204-39.bb.netvision.net.il. [93.172.204.39])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm5666716ejb.83.2022.11.09.01.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 01:57:19 -0800 (PST)
Date:   Wed, 9 Nov 2022 11:57:17 +0200
From:   Leonid Ravich <lravich@gmail.com>
To:     jgg@ziepe.ca, leon@kernel.org, mhiramat@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] IB/MAD: fix might sleep in atomic
Message-ID: <Y2t5feomyznrVj7V@leonid-Inspiron-3421>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sleep in TR_assign not allowd

WARNING: CPU: 0 PID: 1888000 at kernel/trace/ring_buffer.c:2492 rb_commit+0xc1/0x220
CPU: 0 PID: 1888000 Comm: kworker/u9:0 Kdump: loaded Tainted: G           OE    --------- -  - 4.18.0-305.3.1.el8.x86_64 #1
l: Hardware name: Red Hat KVM, BIOS 1.13.0-2.module_el8.3.0+555+a55c8938 04/01/2014
l: Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
l: RIP: 0010:rb_commit+0xc1/0x220
l: RSP: 0000:ffffa8ac80f9bca0 EFLAGS: 00010202
l: RAX: ffff8951c7c01300 RBX: ffff8951c7c14a00 RCX: 0000000000000246
l: RDX: ffff8951c707c000 RSI: ffff8951c707c57c RDI: ffff8951c7c14a00
l: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
l: R10: ffff8951c7c01300 R11: 0000000000000001 R12: 0000000000000246
l: R13: 0000000000000000 R14: ffffffff964c70c0 R15: 0000000000000000
l: FS:  0000000000000000(0000) GS:ffff8951fbc00000(0000) knlGS:0000000000000000
l: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
l: CR2: 00007f20e8f39010 CR3: 000000002ca10005 CR4: 0000000000170ef0
l: Call Trace:
l:  ring_buffer_unlock_commit+0x1d/0xa0
l:  trace_buffer_unlock_commit_regs+0x3b/0x1b0
l:  trace_event_buffer_commit+0x67/0x1d0
l:  trace_event_raw_event_ib_mad_recv_done_handler+0x11c/0x160 [ib_core]
l:  ib_mad_recv_done+0x48b/0xc10 [ib_core]
l:  ? trace_event_raw_event_cq_poll+0x6f/0xb0 [ib_core]
l:  __ib_process_cq+0x91/0x1c0 [ib_core]
l:  ib_cq_poll_work+0x26/0x80 [ib_core]
l:  process_one_work+0x1a7/0x360
l:  ? create_worker+0x1a0/0x1a0
l:  worker_thread+0x30/0x390
l:  ? create_worker+0x1a0/0x1a0
l:  kthread+0x116/0x130
l:  ? kthread_flush_work_fn+0x10/0x10
l:  ret_from_fork+0x35/0x40
l: ---[ end trace 78ba8509d3830a16 ]---

Signed-off-by: Leonid Ravich <lravich@gmail.com>
---
 drivers/infiniband/core/mad.c |  3 ---
 include/trace/events/ib_mad.h | 13 ++++---------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 1893aa613ad7..3937b40b93c1 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -59,7 +59,6 @@ static void create_mad_addr_info(struct ib_mad_send_wr_private *mad_send_wr,
 			  struct ib_mad_qp_info *qp_info,
 			  struct trace_event_raw_ib_mad_send_template *entry)
 {
-	u16 pkey;
 	struct ib_device *dev = qp_info->port_priv->device;
 	u32 pnum = qp_info->port_priv->port_num;
 	struct ib_ud_wr *wr = &mad_send_wr->send_wr;
@@ -69,8 +68,6 @@ static void create_mad_addr_info(struct ib_mad_send_wr_private *mad_send_wr,
 
 	/* These are common */
 	entry->sl = attr.sl;
-	ib_query_pkey(dev, pnum, wr->pkey_index, &pkey);
-	entry->pkey = pkey;
 	entry->rqpn = wr->remote_qpn;
 	entry->rqkey = wr->remote_qkey;
 	entry->dlid = rdma_ah_get_dlid(&attr);
diff --git a/include/trace/events/ib_mad.h b/include/trace/events/ib_mad.h
index 59363a083ecb..d92691c78cff 100644
--- a/include/trace/events/ib_mad.h
+++ b/include/trace/events/ib_mad.h
@@ -49,7 +49,6 @@ DECLARE_EVENT_CLASS(ib_mad_send_template,
 		__field(int,            retries_left)
 		__field(int,            max_retries)
 		__field(int,            retry)
-		__field(u16,            pkey)
 	),
 
 	TP_fast_assign(
@@ -89,7 +88,7 @@ DECLARE_EVENT_CLASS(ib_mad_send_template,
 		  "hdr : base_ver 0x%x class 0x%x class_ver 0x%x " \
 		  "method 0x%x status 0x%x class_specific 0x%x tid 0x%llx " \
 		  "attr_id 0x%x attr_mod 0x%x  => dlid 0x%08x sl %d "\
-		  "pkey 0x%x rpqn 0x%x rqpkey 0x%x",
+		  "rpqn 0x%x rqpkey 0x%x",
 		__entry->dev_index, __entry->port_num, __entry->qp_num,
 		__entry->agent_priv, be64_to_cpu(__entry->wrtid),
 		__entry->retries_left, __entry->max_retries,
@@ -100,7 +99,7 @@ DECLARE_EVENT_CLASS(ib_mad_send_template,
 		be16_to_cpu(__entry->class_specific),
 		be64_to_cpu(__entry->tid), be16_to_cpu(__entry->attr_id),
 		be32_to_cpu(__entry->attr_mod),
-		be32_to_cpu(__entry->dlid), __entry->sl, __entry->pkey,
+		be32_to_cpu(__entry->dlid), __entry->sl,
 		__entry->rqpn, __entry->rqkey
 	)
 );
@@ -204,7 +203,6 @@ TRACE_EVENT(ib_mad_recv_done_handler,
 		__field(u16,            wc_status)
 		__field(u32,            slid)
 		__field(u32,            dev_index)
-		__field(u16,            pkey)
 	),
 
 	TP_fast_assign(
@@ -224,9 +222,6 @@ TRACE_EVENT(ib_mad_recv_done_handler,
 		__entry->slid = wc->slid;
 		__entry->src_qp = wc->src_qp;
 		__entry->sl = wc->sl;
-		ib_query_pkey(qp_info->port_priv->device,
-			      qp_info->port_priv->port_num,
-			      wc->pkey_index, &__entry->pkey);
 		__entry->wc_status = wc->status;
 	),
 
@@ -234,7 +229,7 @@ TRACE_EVENT(ib_mad_recv_done_handler,
 		  "base_ver 0x%02x class 0x%02x class_ver 0x%02x " \
 		  "method 0x%02x status 0x%04x class_specific 0x%04x " \
 		  "tid 0x%016llx attr_id 0x%04x attr_mod 0x%08x " \
-		  "slid 0x%08x src QP%d, sl %d pkey 0x%04x",
+		  "slid 0x%08x src QP%d, sl %d",
 		__entry->dev_index, __entry->port_num, __entry->qp_num,
 		__entry->wc_status,
 		__entry->length,
@@ -244,7 +239,7 @@ TRACE_EVENT(ib_mad_recv_done_handler,
 		be16_to_cpu(__entry->class_specific),
 		be64_to_cpu(__entry->tid), be16_to_cpu(__entry->attr_id),
 		be32_to_cpu(__entry->attr_mod),
-		__entry->slid, __entry->src_qp, __entry->sl, __entry->pkey
+		__entry->slid, __entry->src_qp, __entry->sl
 	)
 );
 
-- 
2.34.1

