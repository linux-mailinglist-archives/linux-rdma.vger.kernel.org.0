Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F5E2FE715
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 11:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbhAUKF5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 05:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbhAUJrx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CBCC061349
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:46:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a9so1056126wrt.5
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqksBZrA3odDFn/ITnacc/iTVMMrBkdLV36fQYYpBKs=;
        b=IUHmUEPz1ssVdtT4iImldKBIPFQSaTjNATWl7tdiuiuCD6yIIvpW1LcjWqf2zC+kP+
         ONvIqMfLNnBxYsAjFxhqUZKTgOetpiOucBtGyycM6K+34CFTNmR2j8iHyiDqRazhlGBc
         qRh3c3qTtOWnDb00KWaUh/UZexq0lrQYMf1ezzoInYRh3sJOLgEhcH+uNVGNB9u0/363
         q/3qmOMCHAwiHnsJUKhCLptQuhFk04j4h3uYAiguVyK4Q1f90DtcDDwc3OD/guHvROCn
         z3lbMc5Eq/0vCPRmQ3u98ZqEe8k0K11pYmvcz7IhGcZJDA7vIWZn7yDejUNqs68yMmY7
         kgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqksBZrA3odDFn/ITnacc/iTVMMrBkdLV36fQYYpBKs=;
        b=jd5hmcYF4kNgwqiKEW3yYd3sZ7tdBlHctbrM0ak3CBuQlDH6CohqM8JBGHYnNUvFLy
         JI1zbqpQ0ewwqMrTAh5PsVblTDnfxHvA7vfP/adogGpd4tO482ZcYODJgtdzQr4TZXi/
         Rkppa5OnoH7f93PwwWylyhn+a/dCtBiUZhZIsV9wM2ffGKI1W3B19/E3LqzFX6GYgzrQ
         1wDmaxkh+AwvM9kuLdoDUnCQLWaewepuzxVgMln/1VIH8XnLIgEPS+xI/G5fZ9A7AyF1
         MHtvjq4UUyQQljhlJWAXIJ1g1LVrO3Vuz9MV03Lon/8xx5QSKNYBXc/PyqS+pV48MANE
         dOaQ==
X-Gm-Message-State: AOAM530l9rJRCMtQAGxgBJ316KFgqaSG5sZhgAirUMszXqzbFOIFgOTx
        3dKWFq9ZkGeUVpDr/Ue/cTLa6Q==
X-Google-Smtp-Source: ABdhPJzC+77t2FW0BclKKfKW3nlo0wzlW6UtCmvMAeUddP508BE1nW6k6f4Ou+MV0qRyLsxZmlPopQ==
X-Received: by 2002:a5d:4bc2:: with SMTP id l2mr13557020wrt.204.1611222360687;
        Thu, 21 Jan 2021 01:46:00 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:46:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 30/30] RDMA/sw/rdmavt/qp: Fix a bunch of kernel-doc misdemeanours
Date:   Thu, 21 Jan 2021 09:45:19 +0000
Message-Id: <20210121094519.2044049-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/sw/rdmavt/qp.c:165: warning: Function parameter or member 'rdi' not described in 'rvt_wss_init'
 drivers/infiniband/sw/rdmavt/qp.c:329: warning: Function parameter or member 'rdi' not described in 'init_qpn_table'
 drivers/infiniband/sw/rdmavt/qp.c:534: warning: Function parameter or member 'type' not described in 'alloc_qpn'
 drivers/infiniband/sw/rdmavt/qp.c:664: warning: Function parameter or member 'wqe' not described in 'rvt_swqe_has_lkey'
 drivers/infiniband/sw/rdmavt/qp.c:664: warning: Function parameter or member 'lkey' not described in 'rvt_swqe_has_lkey'
 drivers/infiniband/sw/rdmavt/qp.c:682: warning: Function parameter or member 'qp' not described in 'rvt_qp_sends_has_lkey'
 drivers/infiniband/sw/rdmavt/qp.c:682: warning: Function parameter or member 'lkey' not described in 'rvt_qp_sends_has_lkey'
 drivers/infiniband/sw/rdmavt/qp.c:706: warning: Function parameter or member 'qp' not described in 'rvt_qp_acks_has_lkey'
 drivers/infiniband/sw/rdmavt/qp.c:706: warning: Function parameter or member 'lkey' not described in 'rvt_qp_acks_has_lkey'
 drivers/infiniband/sw/rdmavt/qp.c:866: warning: Function parameter or member 'rdi' not described in 'rvt_init_qp'
 drivers/infiniband/sw/rdmavt/qp.c:920: warning: Function parameter or member 'rdi' not described in '_rvt_reset_qp'
 drivers/infiniband/sw/rdmavt/qp.c:1736: warning: Function parameter or member 'udata' not described in 'rvt_destroy_qp'
 drivers/infiniband/sw/rdmavt/qp.c:1924: warning: Function parameter or member 'qp' not described in 'rvt_qp_valid_operation'
 drivers/infiniband/sw/rdmavt/qp.c:1924: warning: Function parameter or member 'post_parms' not described in 'rvt_qp_valid_operation'
 drivers/infiniband/sw/rdmavt/qp.c:1924: warning: Function parameter or member 'wr' not described in 'rvt_qp_valid_operation'
 drivers/infiniband/sw/rdmavt/qp.c:2020: warning: Function parameter or member 'call_send' not described in 'rvt_post_one_wr'
 drivers/infiniband/sw/rdmavt/qp.c:2621: warning: Function parameter or member 'qp' not described in 'rvt_stop_rnr_timer'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/sw/rdmavt/qp.c | 34 ++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 22fa9bde54199..76d6bbfbec50c 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -156,7 +156,7 @@ void rvt_wss_exit(struct rvt_dev_info *rdi)
 	rdi->wss = NULL;
 }
 
-/**
+/*
  * rvt_wss_init - Init wss data structures
  *
  * Return: 0 on success
@@ -323,6 +323,7 @@ static void get_map_page(struct rvt_qpn_table *qpt,
 
 /**
  * init_qpn_table - initialize the QP number table for a device
+ * @rdi: rvt dev struct
  * @qpt: the QPN table
  */
 static int init_qpn_table(struct rvt_dev_info *rdi, struct rvt_qpn_table *qpt)
@@ -524,6 +525,7 @@ static inline unsigned mk_qpn(struct rvt_qpn_table *qpt,
  *	       IB_QPT_SMI/IB_QPT_GSI
  * @rdi: rvt device info structure
  * @qpt: queue pair number table pointer
+ * @type: the QP type
  * @port_num: IB port number, 1 based, comes from core
  * @exclude_prefix: prefix of special queue pair number being allocated
  *
@@ -655,8 +657,8 @@ static void rvt_clear_mr_refs(struct rvt_qp *qp, int clr_sends)
 
 /**
  * rvt_swqe_has_lkey - return true if lkey is used by swqe
- * @wqe - the send wqe
- * @lkey - the lkey
+ * @wqe: the send wqe
+ * @lkey: the lkey
  *
  * Test the swqe for using lkey
  */
@@ -675,8 +677,8 @@ static bool rvt_swqe_has_lkey(struct rvt_swqe *wqe, u32 lkey)
 
 /**
  * rvt_qp_sends_has_lkey - return true is qp sends use lkey
- * @qp - the rvt_qp
- * @lkey - the lkey
+ * @qp: the rvt_qp
+ * @lkey: the lkey
  */
 static bool rvt_qp_sends_has_lkey(struct rvt_qp *qp, u32 lkey)
 {
@@ -699,8 +701,8 @@ static bool rvt_qp_sends_has_lkey(struct rvt_qp *qp, u32 lkey)
 
 /**
  * rvt_qp_acks_has_lkey - return true if acks have lkey
- * @qp - the qp
- * @lkey - the lkey
+ * @qp: the qp
+ * @lkey: the lkey
  */
 static bool rvt_qp_acks_has_lkey(struct rvt_qp *qp, u32 lkey)
 {
@@ -716,10 +718,10 @@ static bool rvt_qp_acks_has_lkey(struct rvt_qp *qp, u32 lkey)
 	return false;
 }
 
-/*
+/**
  * rvt_qp_mr_clean - clean up remote ops for lkey
- * @qp - the qp
- * @lkey - the lkey that is being de-registered
+ * @qp: the qp
+ * @lkey: the lkey that is being de-registered
  *
  * This routine checks if the lkey is being used by
  * the qp.
@@ -853,6 +855,7 @@ int rvt_alloc_rq(struct rvt_rq *rq, u32 size, int node,
 
 /**
  * rvt_init_qp - initialize the QP state to the reset state
+ * @rdi: rvt dev struct
  * @qp: the QP to init or reinit
  * @type: the QP type
  *
@@ -907,6 +910,7 @@ static void rvt_init_qp(struct rvt_dev_info *rdi, struct rvt_qp *qp,
 
 /**
  * _rvt_reset_qp - initialize the QP state to the reset state
+ * @rdi: rvt dev struct
  * @qp: the QP to reset
  * @type: the QP type
  *
@@ -1726,6 +1730,7 @@ int rvt_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 /**
  * rvt_destroy_qp - destroy a queue pair
  * @ibqp: the queue pair to destroy
+ * @udata: unused by the driver
  *
  * Note that this can be called while the QP is actively sending or
  * receiving!
@@ -1901,9 +1906,9 @@ int rvt_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 
 /**
  * rvt_qp_valid_operation - validate post send wr request
- * @qp - the qp
- * @post-parms - the post send table for the driver
- * @wr - the work request
+ * @qp: the qp
+ * @post_parms_ the post send table for the driver
+ * @wr: the work request
  *
  * The routine validates the operation based on the
  * validation table an returns the length of the operation
@@ -2013,6 +2018,7 @@ static inline int rvt_qp_is_avail(
  * rvt_post_one_wr - post one RC, UC, or UD send work request
  * @qp: the QP to post on
  * @wr: the work request to send
+ * @call_send: kick the send engine into gear
  */
 static int rvt_post_one_wr(struct rvt_qp *qp,
 			   const struct ib_send_wr *wr,
@@ -2612,7 +2618,7 @@ EXPORT_SYMBOL(rvt_stop_rc_timers);
 
 /**
  * rvt_stop_rnr_timer - stop an rnr timer
- * @qp - the QP
+ * @qp: the QP
  *
  * stop an rnr timer and return if the timer
  * had been pending.
-- 
2.25.1

