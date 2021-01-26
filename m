Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F32303DC9
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391796AbhAZMuQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404097AbhAZMuD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:50:03 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258EFC08EB2B
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d16so15649208wro.11
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/3ugDjDRvHTQ/02f6IlRMQWKsjtDgmsBi/8dZ2CLI4=;
        b=EQegMAgrLM+Vr8PO8VzM7X3XUCOndiJh4RMraOt81gPr7MwY3n9rPF7FSh4Du93Lz3
         Rx4WQ+umSynWAJhTevwqFS3Mv+Sca2TGkcTknt3N0smXTkDzDYeIY044JrTgHbrrmIAg
         +V41G2CEe0nxpS4NcOezKqgHhsvb80vmTRe28HIzCgNcHfvMn22F/YOzU8NvA1+ov7Y/
         lwuLuOr/kgvzbd0CuI1zZSx55iomagSI7Ro6XoA8nLuSC8LOc0sugmRvrDLS/7kwbE2e
         evgXPM2lyg67gnAHc1msOez/krfP2VJ90ATYy/e4RWt1tz7FoEGlu5R9yUxcg6xjKrVY
         DP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/3ugDjDRvHTQ/02f6IlRMQWKsjtDgmsBi/8dZ2CLI4=;
        b=tmXzXZRBJFWaf3mATVOGcjGUvjuVNJgkdkIKu9egJoWJ7+CcQDrA1VnNhAa3UXCkPn
         MmYZO2x14eErS29/zbxE81qKlZiLPLfCjDoBaDh1upDTiFeOHs14Fm8HZX0puePeIJiz
         n8hxkk/tkLxkpGDX+JwbhXP6BEIm42jLnma6/uidl5ubsnyTK/1dKQC8mpw7PDQXNRx2
         9MgClQOdgaTH0qBOqDSpJxd/HQ6hvDZDN1cdNyb5hNEB+1SnGt6zXDWTktG2G3St55Px
         uasOn2H3oVH4J3wWl8/4JnjLpyghLTr4Sh7+s0cSbU2wK8/uVaMbA07TrDc1RGUtvX5f
         DtRQ==
X-Gm-Message-State: AOAM531wkkezI2J5KOUhz0TksmWozGRu2+IcAQsKbeRUGkMYlFlNeQg7
        YbLG/pXIHRSIP8Jjk44Cs9Ip+A==
X-Google-Smtp-Source: ABdhPJyri6xa2WTEf8CycWDv4AHunjQCgUCllTOhxa8Z9mAIhGPlgIVDAh2Lzz/ZrrtFPDpswpzomA==
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr5909547wru.152.1611665272896;
        Tue, 26 Jan 2021 04:47:52 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 15/20] RDMA/hw/hfi1/tid_rdma: Fix a plethora of kernel-doc issues
Date:   Tue, 26 Jan 2021 12:47:27 +0000
Message-Id: <20210126124732.3320971-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/tid_rdma.c:321: warning: Function parameter or member 'rdi' not described in 'qp_to_rcd'
 drivers/infiniband/hw/hfi1/tid_rdma.c:321: warning: Function parameter or member 'qp' not described in 'qp_to_rcd'
 drivers/infiniband/hw/hfi1/tid_rdma.c:505: warning: Function parameter or member 'queue' not described in 'kernel_tid_waiters'
 drivers/infiniband/hw/hfi1/tid_rdma.c:536: warning: Function parameter or member 'rcd' not described in 'dequeue_tid_waiter'
 drivers/infiniband/hw/hfi1/tid_rdma.c:536: warning: Function parameter or member 'queue' not described in 'dequeue_tid_waiter'
 drivers/infiniband/hw/hfi1/tid_rdma.c:536: warning: Function parameter or member 'qp' not described in 'dequeue_tid_waiter'
 drivers/infiniband/hw/hfi1/tid_rdma.c:562: warning: Function parameter or member 'queue' not described in 'queue_qp_for_tid_wait'
 drivers/infiniband/hw/hfi1/tid_rdma.c:607: warning: Function parameter or member 'qp' not described in 'tid_rdma_schedule_tid_wakeup'
 drivers/infiniband/hw/hfi1/tid_rdma.c:639: warning: Function parameter or member 'work' not described in 'tid_rdma_trigger_resume'
 drivers/infiniband/hw/hfi1/tid_rdma.c:666: warning: Function parameter or member 'qp' not described in '_tid_rdma_flush_wait'
 drivers/infiniband/hw/hfi1/tid_rdma.c:666: warning: Function parameter or member 'queue' not described in '_tid_rdma_flush_wait'
 drivers/infiniband/hw/hfi1/tid_rdma.c:713: warning: Function parameter or member 'rcd' not described in 'kern_reserve_flow'
 drivers/infiniband/hw/hfi1/tid_rdma.c:713: warning: Function parameter or member 'last' not described in 'kern_reserve_flow'
 drivers/infiniband/hw/hfi1/tid_rdma.c:879: warning: Function parameter or member 'flow' not described in 'tid_rdma_find_phys_blocks_4k'
 drivers/infiniband/hw/hfi1/tid_rdma.c:879: warning: Function parameter or member 'pages' not described in 'tid_rdma_find_phys_blocks_4k'
 drivers/infiniband/hw/hfi1/tid_rdma.c:879: warning: Function parameter or member 'npages' not described in 'tid_rdma_find_phys_blocks_4k'
 drivers/infiniband/hw/hfi1/tid_rdma.c:879: warning: Function parameter or member 'list' not described in 'tid_rdma_find_phys_blocks_4k'
 drivers/infiniband/hw/hfi1/tid_rdma.c:972: warning: Function parameter or member 'list' not described in 'tid_flush_pages'
 drivers/infiniband/hw/hfi1/tid_rdma.c:972: warning: Function parameter or member 'idx' not described in 'tid_flush_pages'
 drivers/infiniband/hw/hfi1/tid_rdma.c:972: warning: Function parameter or member 'pages' not described in 'tid_flush_pages'
 drivers/infiniband/hw/hfi1/tid_rdma.c:972: warning: Function parameter or member 'sets' not described in 'tid_flush_pages'
 drivers/infiniband/hw/hfi1/tid_rdma.c:1017: warning: Function parameter or member 'flow' not described in 'tid_rdma_find_phys_blocks_8k'
 drivers/infiniband/hw/hfi1/tid_rdma.c:1017: warning: Function parameter or member 'pages' not described in 'tid_rdma_find_phys_blocks_8k'
 drivers/infiniband/hw/hfi1/tid_rdma.c:1017: warning: Function parameter or member 'npages' not described in 'tid_rdma_find_phys_blocks_8k'
 drivers/infiniband/hw/hfi1/tid_rdma.c:1017: warning: Function parameter or member 'list' not described in 'tid_rdma_find_phys_blocks_8k'
 drivers/infiniband/hw/hfi1/tid_rdma.c:1083: warning: Function parameter or member 'flow' not described in 'kern_find_pages'
 drivers/infiniband/hw/hfi1/tid_rdma.c:1083: warning: Function parameter or member 'pages' not described in 'kern_find_pages'
 drivers/infiniband/hw/hfi1/tid_rdma.c:1083: warning: Function parameter or member 'ss' not described in 'kern_find_pages'
 drivers/infiniband/hw/hfi1/tid_rdma.c:1083: warning: Function parameter or member 'last' not described in 'kern_find_pages'
 drivers/infiniband/hw/hfi1/tid_rdma.c:1604: warning: Function parameter or member 'req' not described in 'hfi1_kern_exp_rcv_free_flows'
 drivers/infiniband/hw/hfi1/tid_rdma.c:3458: warning: Function parameter or member 'qp' not described in 'hfi1_tid_write_alloc_resources'
 drivers/infiniband/hw/hfi1/tid_rdma.c:3458: warning: Function parameter or member 'intr_ctx' not described in 'hfi1_tid_write_alloc_resources'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c | 47 +++++++++++++++------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 92aa2a9b3b5ac..0b1f9e4d038b0 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -309,7 +309,8 @@ int hfi1_kern_exp_rcv_init(struct hfi1_ctxtdata *rcd, int reinit)
 
 /**
  * qp_to_rcd - determine the receive context used by a qp
- * @qp - the qp
+ * @rdi: rvt dev struct
+ * @qp: the qp
  *
  * This routine returns the receive context associated
  * with a a qp's qpn.
@@ -484,6 +485,7 @@ static struct rvt_qp *first_qp(struct hfi1_ctxtdata *rcd,
 /**
  * kernel_tid_waiters - determine rcd wait
  * @rcd: the receive context
+ * @queue: the queue to operate on
  * @qp: the head of the qp being processed
  *
  * This routine will return false IFF
@@ -517,7 +519,9 @@ static bool kernel_tid_waiters(struct hfi1_ctxtdata *rcd,
 
 /**
  * dequeue_tid_waiter - dequeue the qp from the list
- * @qp - the qp to remove the wait list
+ * @rcd: the receive context
+ * @queue: the queue to operate on
+ * @qp: the qp to remove the wait list
  *
  * This routine removes the indicated qp from the
  * wait list if it is there.
@@ -549,6 +553,7 @@ static void dequeue_tid_waiter(struct hfi1_ctxtdata *rcd,
 /**
  * queue_qp_for_tid_wait - suspend QP on tid space
  * @rcd: the receive context
+ * @queue: the queue to operate on
  * @qp: the qp
  *
  * The qp is inserted at the tail of the rcd
@@ -593,7 +598,7 @@ static void __trigger_tid_waiter(struct rvt_qp *qp)
 
 /**
  * tid_rdma_schedule_tid_wakeup - schedule wakeup for a qp
- * @qp - the qp
+ * @qp: the qp
  *
  * trigger a schedule or a waiting qp in a deadlock
  * safe manner.  The qp reference is held prior
@@ -630,7 +635,7 @@ static void tid_rdma_schedule_tid_wakeup(struct rvt_qp *qp)
 
 /**
  * tid_rdma_trigger_resume - field a trigger work request
- * @work - the work item
+ * @work: the work item
  *
  * Complete the off qp trigger processing by directly
  * calling the progress routine.
@@ -654,7 +659,7 @@ static void tid_rdma_trigger_resume(struct work_struct *work)
 	rvt_put_qp(qp);
 }
 
-/**
+/*
  * tid_rdma_flush_wait - unwind any tid space wait
  *
  * This is called when resetting a qp to
@@ -693,8 +698,8 @@ void hfi1_tid_rdma_flush_wait(struct rvt_qp *qp)
 /* Flow functions */
 /**
  * kern_reserve_flow - allocate a hardware flow
- * @rcd - the context to use for allocation
- * @last - the index of the preferred flow. Use RXE_NUM_TID_FLOWS to
+ * @rcd: the context to use for allocation
+ * @last: the index of the preferred flow. Use RXE_NUM_TID_FLOWS to
  *         signify "don't care".
  *
  * Use a bit mask based allocation to reserve a hardware
@@ -860,9 +865,10 @@ static u8 trdma_pset_order(struct tid_rdma_pageset *s)
 
 /**
  * tid_rdma_find_phys_blocks_4k - get groups base on mr info
- * @npages - number of pages
- * @pages - pointer to an array of page structs
- * @list - page set array to return
+ * @flow: overall info for a TID RDMA segment
+ * @pages: pointer to an array of page structs
+ * @npages: number of pages
+ * @list: page set array to return
  *
  * This routine returns the number of groups associated with
  * the current sge information.  This implementation is based
@@ -949,10 +955,10 @@ static u32 tid_rdma_find_phys_blocks_4k(struct tid_rdma_flow *flow,
 
 /**
  * tid_flush_pages - dump out pages into pagesets
- * @list - list of pagesets
- * @idx - pointer to current page index
- * @pages - number of pages to dump
- * @sets - current number of pagesset
+ * @list: list of pagesets
+ * @idx: pointer to current page index
+ * @pages: number of pages to dump
+ * @sets: current number of pagesset
  *
  * This routine flushes out accumuated pages.
  *
@@ -990,9 +996,10 @@ static u32 tid_flush_pages(struct tid_rdma_pageset *list,
 
 /**
  * tid_rdma_find_phys_blocks_8k - get groups base on mr info
- * @pages - pointer to an array of page structs
- * @npages - number of pages
- * @list - page set array to return
+ * @flow: overall info for a TID RDMA segment
+ * @pages: pointer to an array of page structs
+ * @npages: number of pages
+ * @list: page set array to return
  *
  * This routine parses an array of pages to compute pagesets
  * in an 8k compatible way.
@@ -1064,7 +1071,7 @@ static u32 tid_rdma_find_phys_blocks_8k(struct tid_rdma_flow *flow,
 	return sets;
 }
 
-/**
+/*
  * Find pages for one segment of a sge array represented by @ss. The function
  * does not check the sge, the sge must have been checked for alignment with a
  * prior call to hfi1_kern_trdma_ok. Other sge checking is done as part of
@@ -1598,7 +1605,7 @@ void hfi1_kern_exp_rcv_clear_all(struct tid_rdma_request *req)
 
 /**
  * hfi1_kern_exp_rcv_free_flows - free priviously allocated flow information
- * @req - the tid rdma request to be cleaned
+ * @req: the tid rdma request to be cleaned
  */
 static void hfi1_kern_exp_rcv_free_flows(struct tid_rdma_request *req)
 {
@@ -3435,7 +3442,7 @@ static u32 hfi1_compute_tid_rnr_timeout(struct rvt_qp *qp, u32 to_seg)
 	return 0;
 }
 
-/**
+/*
  * Central place for resource allocation at TID write responder,
  * is called from write_req and write_data interrupt handlers as
  * well as the send thread when a queued QP is scheduled for
-- 
2.25.1

