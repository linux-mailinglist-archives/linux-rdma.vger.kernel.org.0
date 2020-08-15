Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC882453DA
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Aug 2020 00:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgHOWGg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 18:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgHOVuu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:50:50 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8488DC061247
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:13 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v21so9247994otj.9
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRibimADuzuSML9VI3K1x9yLKpeJEahrh1omDAsSoUw=;
        b=XaHxxkSMWcVsVPUB7h+hQc+7B+fn2rFH4Lzlpdp8DDUie4WMMbTF9cETklMWlRhAAI
         BnjcbPlUwG2SOgQIBlgcqXlVgmenOIekihQgIwLDfkoOF+WSb5wvQdeKinZc7mnm2cpj
         yhdQIZuHFcvTEtSBOWtyTJr2miDMuA5EBD9U8eZXAC/o3pfQGx9lCFX6tw8bJcGVkguf
         zsMGO4oGH0hC6oSRL8VWL3H6i6/6JKC7xnFb46q6x/1cY/CIbuVUrC2Ngut4M1JN4Qgo
         Y/M7ILOpcUw4FwpPdgDGFFa7MZLqIdjMdqt6TNDPtI28pexfde69aacOTEop9ef3jt8J
         ZAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eRibimADuzuSML9VI3K1x9yLKpeJEahrh1omDAsSoUw=;
        b=uUNhnd8qTFLs8rjeccSKMAY5PzMWj/rV8JaYMRof8GAhnbWnDQFkmWshwxQBQQtmqn
         7j2q3FiCAgP8kJAHQe6lqEfA3sU/Ua5wKcQ7xYg3lDH/7BNj05Qq7NrTJQkitZ9U30wa
         P2RJBGgxMRJxtcM10vSbmROY9q/cICgdF8NTI7WzsHQ2mAIONyN8oiN2QBTvPWmP/c9P
         wWcJ/XMH6Z7DDsqzb/sp+sQrAXy3OmnfB88Hy+Jm2hBeKO6XWnJEUCO8MEjEO9XFnHqr
         SLo2OO0nNp5gpxXM71dmMkRHPFe67mU6QC56LaFBeS+3r9+69CoDLg4Tl+aQXm+F27hh
         kDJw==
X-Gm-Message-State: AOAM530r3Bfx1QW0SGM5/B6shAAu7XrMNJuTph1GrmmGeSGNA8lZXVU4
        +rZ9Bt4P38xfwniPHQPNTff2z7qUptQaaA==
X-Google-Smtp-Source: ABdhPJxtT1L5qLV71UVYoVtBs7Ncyx0cfEn6G28op9QzW8076jgzeQQrI565asRLShQB5tWLsz+6PQ==
X-Received: by 2002:a9d:824:: with SMTP id 33mr4494069oty.35.1597467609904;
        Fri, 14 Aug 2020 22:00:09 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id y15sm2089618oto.60.2020.08.14.22.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 20/20] fixed checkpatch issues for all files in rxe
Date:   Fri, 14 Aug 2020 23:58:44 -0500
Message-Id: <20200815045912.8626-21-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Went through all the files in the rxe dirextory and fixed all issues
reported by checkpatch. Removed remaining debugging code. Added SPDX
headers.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c             |  31 +---
 drivers/infiniband/sw/rxe/rxe.h             |  31 +---
 drivers/infiniband/sw/rxe/rxe_av.c          |  31 +---
 drivers/infiniband/sw/rxe/rxe_comp.c        |  54 ++----
 drivers/infiniband/sw/rxe/rxe_cq.c          |  31 +---
 drivers/infiniband/sw/rxe/rxe_hdr.h         |  67 +++-----
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  61 ++-----
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |  31 +---
 drivers/infiniband/sw/rxe/rxe_icrc.c        |  31 +---
 drivers/infiniband/sw/rxe/rxe_loc.h         |  38 +----
 drivers/infiniband/sw/rxe/rxe_mcast.c       |  31 +---
 drivers/infiniband/sw/rxe/rxe_mmap.c        |  31 +---
 drivers/infiniband/sw/rxe/rxe_mr.c          |  59 ++-----
 drivers/infiniband/sw/rxe/rxe_mw.c          | 176 ++++++++------------
 drivers/infiniband/sw/rxe/rxe_net.c         |  37 +---
 drivers/infiniband/sw/rxe/rxe_net.h         |  31 +---
 drivers/infiniband/sw/rxe/rxe_opcode.c      |  33 +---
 drivers/infiniband/sw/rxe/rxe_opcode.h      |  31 +---
 drivers/infiniband/sw/rxe/rxe_param.h       |  31 +---
 drivers/infiniband/sw/rxe/rxe_pool.c        |  43 +----
 drivers/infiniband/sw/rxe/rxe_pool.h        |  31 +---
 drivers/infiniband/sw/rxe/rxe_qp.c          |  53 ++----
 drivers/infiniband/sw/rxe/rxe_queue.c       |  31 +---
 drivers/infiniband/sw/rxe/rxe_queue.h       |  31 +---
 drivers/infiniband/sw/rxe/rxe_recv.c        |  31 +---
 drivers/infiniband/sw/rxe/rxe_req.c         | 122 ++++++--------
 drivers/infiniband/sw/rxe/rxe_resp.c        | 170 +++++++++----------
 drivers/infiniband/sw/rxe/rxe_srq.c         |  31 +---
 drivers/infiniband/sw/rxe/rxe_sysfs.c       |  34 +---
 drivers/infiniband/sw/rxe/rxe_task.c        |  31 +---
 drivers/infiniband/sw/rxe/rxe_task.h        |  33 +---
 drivers/infiniband/sw/rxe/rxe_verbs.c       |  51 ++----
 drivers/infiniband/sw/rxe/rxe_verbs.h       |  34 +---
 33 files changed, 384 insertions(+), 1208 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 25bd25371f8e..97ed495c840e 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <rdma/rdma_netlink.h>
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index fb07eed9e402..87a75943ac27 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * drivers/infiniband/sw/rxe/rxe.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_H
diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 81ee756c19b8..9ab524ae4517 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_av.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *		- Redistributions of source code must retain the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer.
- *
- *		- Redistributions in binary form must reproduce the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer in the documentation and/or other materials
- *		  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index ed9e27eeaadd..681e2b9811f2 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_comp.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
@@ -563,21 +538,13 @@ int rxe_completer(void *arg)
 	struct sk_buff *skb = NULL;
 	struct rxe_pkt_info *pkt = NULL;
 	enum comp_state state;
-	int entered;
 
 	rxe_add_ref(qp);
 
-	// this code is 'guaranteed' to never be entered more
-	// than once. Check to make sure that this is the case
-	entered = atomic_inc_return(&qp->comp.task.entered);
-	if (entered > 1) {
-		pr_err("rxe_completer: entered %d times\n", entered);
-	}
-
 	if (!qp->valid || qp->req.state == QP_STATE_ERROR ||
 	    qp->req.state == QP_STATE_RESET) {
-			rxe_drain_resp_pkts(qp, qp->valid &&
-				    qp->req.state == QP_STATE_ERROR);
+		rxe_drain_resp_pkts(qp, qp->valid &&
+			    qp->req.state == QP_STATE_ERROR);
 		goto exit;
 	}
 
@@ -699,9 +666,8 @@ int rxe_completer(void *arg)
 			 */
 
 			/* there is nothing to retry in this case */
-			if (!wqe || (wqe->state == wqe_state_posted)) {
+			if (!wqe || (wqe->state == wqe_state_posted))
 				goto exit;
-			}
 
 			/* if we've started a retry, don't start another
 			 * retry sequence, unless this is a timeout.
@@ -792,17 +758,17 @@ int rxe_completer(void *arg)
 
 exit:
 	/* we come here if we are done with processing and want the task to
-	 * exit from the loop calling us */
+	 * exit from the loop calling us
+	 */
 	WARN_ON_ONCE(skb);
-	atomic_dec(&qp->comp.task.entered);
 	rxe_drop_ref(qp);
 	return -EAGAIN;
 
 done:
 	/* we come here if we have processed a packet and we want
-	 * to be called again to see if there is anything else to do */
+	 * to be called again to see if there is anything else to do
+	 */
 	WARN_ON_ONCE(skb);
-	atomic_dec(&qp->comp.task.entered);
 	rxe_drop_ref(qp);
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index ad3090131126..20e4d8bfd2e7 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_cq.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 #include <linux/vmalloc.h>
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index ce003666b800..3edd49bb331c 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * drivers/infiniband/sw/rxe/rxe_hdr.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_HDR_H
@@ -83,9 +58,9 @@ static inline struct sk_buff *PKT_TO_SKB(struct rxe_pkt_info *pkt)
 #define RXE_ICRC_SIZE		(4)
 #define RXE_MAX_HDR_LENGTH	(80)
 
-/******************************************************************************
+/*
  * Base Transport Header
- ******************************************************************************/
+ */
 struct rxe_bth {
 	u8			opcode;
 	u8			flags;
@@ -450,9 +425,9 @@ static inline void bth_init(struct rxe_pkt_info *pkt, u8 opcode, int se,
 	bth->apsn = cpu_to_be32(psn);
 }
 
-/******************************************************************************
+/*
  * Reliable Datagram Extended Transport Header
- ******************************************************************************/
+ */
 struct rxe_rdeth {
 	__be32			een;
 };
@@ -485,9 +460,9 @@ static inline void rdeth_set_een(struct rxe_pkt_info *pkt, u32 een)
 		+ rxe_opcode[pkt->opcode].offset[RXE_RDETH], een);
 }
 
-/******************************************************************************
+/*
  * Datagram Extended Transport Header
- ******************************************************************************/
+ */
 struct rxe_deth {
 	__be32			qkey;
 	__be32			sqp;
@@ -548,9 +523,9 @@ static inline void deth_set_sqp(struct rxe_pkt_info *pkt, u32 sqp)
 		+ rxe_opcode[pkt->opcode].offset[RXE_DETH], sqp);
 }
 
-/******************************************************************************
+/*
  * RDMA Extended Transport Header
- ******************************************************************************/
+ */
 struct rxe_reth {
 	__be64			va;
 	__be32			rkey;
@@ -635,9 +610,9 @@ static inline void reth_set_len(struct rxe_pkt_info *pkt, u32 len)
 		+ rxe_opcode[pkt->opcode].offset[RXE_RETH], len);
 }
 
-/******************************************************************************
+/*
  * Atomic Extended Transport Header
- ******************************************************************************/
+ */
 struct rxe_atmeth {
 	__be64			va;
 	__be32			rkey;
@@ -749,9 +724,9 @@ static inline void atmeth_set_comp(struct rxe_pkt_info *pkt, u64 comp)
 		+ rxe_opcode[pkt->opcode].offset[RXE_ATMETH], comp);
 }
 
-/******************************************************************************
+/*
  * Ack Extended Transport Header
- ******************************************************************************/
+ */
 struct rxe_aeth {
 	__be32			smsn;
 };
@@ -829,9 +804,9 @@ static inline void aeth_set_msn(struct rxe_pkt_info *pkt, u32 msn)
 		+ rxe_opcode[pkt->opcode].offset[RXE_AETH], msn);
 }
 
-/******************************************************************************
+/*
  * Atomic Ack Extended Transport Header
- ******************************************************************************/
+ */
 struct rxe_atmack {
 	__be64			orig;
 };
@@ -862,9 +837,9 @@ static inline void atmack_set_orig(struct rxe_pkt_info *pkt, u64 orig)
 		+ rxe_opcode[pkt->opcode].offset[RXE_ATMACK], orig);
 }
 
-/******************************************************************************
+/*
  * Immediate Extended Transport Header
- ******************************************************************************/
+ */
 struct rxe_immdt {
 	__be32			imm;
 };
@@ -895,9 +870,9 @@ static inline void immdt_set_imm(struct rxe_pkt_info *pkt, __be32 imm)
 		+ rxe_opcode[pkt->opcode].offset[RXE_IMMDT], imm);
 }
 
-/******************************************************************************
+/*
  * Invalidate Extended Transport Header
- ******************************************************************************/
+ */
 struct rxe_ieth {
 	__be32			rkey;
 };
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
index 636edb5f4cf4..d61e484f034e 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
@@ -1,54 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
+ * drivers/infiniband/sw/rxe/rxe_hw_counters.c
  *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
+ * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
  */
 
 #include "rxe.h"
 #include "rxe_hw_counters.h"
 
 static const char * const rxe_counter_name[] = {
-	[RXE_CNT_SENT_PKTS]           =  "sent_pkts",
-	[RXE_CNT_RCVD_PKTS]           =  "rcvd_pkts",
-	[RXE_CNT_DUP_REQ]             =  "duplicate_request",
-	[RXE_CNT_OUT_OF_SEQ_REQ]      =  "out_of_seq_request",
-	[RXE_CNT_RCV_RNR]             =  "rcvd_rnr_err",
-	[RXE_CNT_SND_RNR]             =  "send_rnr_err",
-	[RXE_CNT_RCV_SEQ_ERR]         =  "rcvd_seq_err",
-	[RXE_CNT_COMPLETER_SCHED]     =  "ack_deferred",
-	[RXE_CNT_RETRY_EXCEEDED]      =  "retry_exceeded_err",
-	[RXE_CNT_RNR_RETRY_EXCEEDED]  =  "retry_rnr_exceeded_err",
-	[RXE_CNT_COMP_RETRY]          =  "completer_retry_err",
-	[RXE_CNT_SEND_ERR]            =  "send_err",
-	[RXE_CNT_LINK_DOWNED]         =  "link_downed",
-	[RXE_CNT_RDMA_SEND]           =  "rdma_sends",
-	[RXE_CNT_RDMA_RECV]           =  "rdma_recvs",
+	[RXE_CNT_SENT_PKTS]	      =	 "sent_pkts",
+	[RXE_CNT_RCVD_PKTS]	      =	 "rcvd_pkts",
+	[RXE_CNT_DUP_REQ]	      =	 "duplicate_request",
+	[RXE_CNT_OUT_OF_SEQ_REQ]      =	 "out_of_seq_request",
+	[RXE_CNT_RCV_RNR]	      =	 "rcvd_rnr_err",
+	[RXE_CNT_SND_RNR]	      =	 "send_rnr_err",
+	[RXE_CNT_RCV_SEQ_ERR]	      =	 "rcvd_seq_err",
+	[RXE_CNT_COMPLETER_SCHED]     =	 "ack_deferred",
+	[RXE_CNT_RETRY_EXCEEDED]      =	 "retry_exceeded_err",
+	[RXE_CNT_RNR_RETRY_EXCEEDED]  =	 "retry_rnr_exceeded_err",
+	[RXE_CNT_COMP_RETRY]	      =	 "completer_retry_err",
+	[RXE_CNT_SEND_ERR]	      =	 "send_err",
+	[RXE_CNT_LINK_DOWNED]	      =	 "link_downed",
+	[RXE_CNT_RDMA_SEND]	      =	 "rdma_sends",
+	[RXE_CNT_RDMA_RECV]	      =	 "rdma_recvs",
 };
 
 int rxe_ib_get_hw_stats(struct ib_device *ibdev,
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
index 72c0d63c79e0..a3c26f66a76c 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
@@ -1,33 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
- * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
+ * drivers/infiniband/sw/rxe/rxe_hw_counters.h
  *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
+ * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
  */
 
 #ifndef RXE_HW_COUNTERS_H
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 39e0be31aab1..d02eca260053 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_icrc.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 2421ca311845..e0f566b48c71 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * drivers/infiniband/sw/rxe/rxe_loc.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_LOC_H
@@ -145,8 +120,8 @@ int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
 /* rxe_qp.c */
 int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init);
 
-int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
-		     struct ib_qp_init_attr *init,
+int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
+		     struct rxe_pd *pd, struct ib_qp_init_attr *init,
 		     struct rxe_create_qp_resp __user *uresp,
 		     struct ib_pd *ibpd, struct ib_udata *udata);
 
@@ -219,7 +194,8 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 
 int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_attr *attr, enum ib_srq_attr_mask mask,
-		      struct rxe_modify_srq_cmd *ucmd, struct ib_udata *udata);
+		      struct rxe_modify_srq_cmd *ucmd,
+		      struct ib_udata *udata);
 
 void rxe_dealloc(struct ib_device *ib_dev);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 522a7942c56c..244e47759aa2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_mcast.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *		- Redistributions of source code must retain the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer.
- *
- *		- Redistributions in binary form must reproduce the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer in the documentation and/or other materials
- *		  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index 7887f623f62c..0640578c1ae3 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_mmap.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/module.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index ce64d4101888..e49251ed38a4 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -1,41 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_mr.c
+ *
+ * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* choose a unique non zero random number for lkey
- * use high order bit to indicate MR vs MW */
+/*
+ * choose a unique non zero random number for lkey
+ * use high order bit to indicate MR vs MW
+ */
 void rxe_set_mr_lkey(struct rxe_mr *mr)
 {
 	u32 lkey;
@@ -82,7 +60,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	else
 		mr->ibmr.rkey = 0;
 
-	// TODO we shouldn't carry two copies
 	mr->lkey		= mr->ibmr.lkey;
 	mr->rkey		= mr->ibmr.rkey;
 	mr->state		= RXE_MEM_STATE_INVALID;
@@ -319,7 +296,8 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 	return addr;
 }
 
-/* copy data from a range (vaddr, vaddr+length-1) to or from
+/*
+ * copy data from a range (vaddr, vaddr+length-1) to or from
  * a mr object starting at iova. Compute incremental value of
  * crc32 if crcp is not zero. caller must hold a reference to mr
  */
@@ -430,7 +408,8 @@ static struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 lkey)
 	return mr;
 }
 
-/* copy data in or out of a wqe, i.e. sg list
+/*
+ * copy data in or out of a wqe, i.e. sg list
  * under the control of a dma descriptor
  */
 int copy_data(
@@ -559,12 +538,9 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 	return 0;
 }
 
+/* this is a placeholder. there is lots more to do */
 int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
 {
-	// much more TODO here, can fail
-	// mw is closer to what is needed
-	// but for another day
-
 	mr->state = RXE_MEM_STATE_FREE;
 
 	return 0;
@@ -577,22 +553,19 @@ int rxe_mr_check_access(struct rxe_qp *qp, struct rxe_mr *mr,
 	struct rxe_pd *pd = to_rpd(mr->ibmr.pd);
 
 	if (unlikely(mr->state != RXE_MEM_STATE_VALID)) {
-		pr_err("attempt to access a MR that is"
-			" not in the valid state\n");
+		pr_err("attempt to access a MR that is not in the valid state\n");
 		return -EINVAL;
 	}
 
 	/* C10-56 */
 	if (unlikely(pd != qp->pd)) {
-		pr_err("attempt to access a MR with a"
-			" different PD than the QP\n");
+		pr_err("attempt to access a MR with a different PD than the QP\n");
 		return -EINVAL;
 	}
 
 	/* C10-57 */
 	if (unlikely(access && !(access & mr->access))) {
-		pr_err("attempt to access a MR that does"
-			" not have the required access rights\n");
+		pr_err("attempt to access a MR that does not have the required access rights\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index ae7f5710f7dd..735b83a7eb49 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -1,52 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_mw.c
+ *
  * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* choose a unique non zero random number for rkey
- * use high order bit to indicate MR vs MW */
-void rxe_set_mw_rkey(struct rxe_mw *mw)
+static void set_mw_rkey(struct rxe_mw *mw)
 {
 	u32 rkey;
 	int tries = 0;
 
+	/*
+	 * there is a very rare chance the RNG will produce all zeros
+	 * or that it will produce a duplicate to an existing MW
+	 * just try again
+	 */
 	do {
 		get_random_bytes(&rkey, sizeof(rkey));
 		rkey |= IS_MW;
 		if (likely((rkey & ~IS_MW) &&
-			   (rxe_add_key(mw, &rkey) == 0)))
+		    (rxe_add_key(mw, &rkey) == 0)))
 			return;
 	} while (tries++ < 10);
 	pr_err("unable to get random rkey for mw\n");
@@ -83,7 +61,8 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 		mw->state	= RXE_MEM_STATE_FREE;
 		break;
 	default:
-		pr_err("attempt to allocate MW with unknown type\n");
+		pr_err_once("attempt to allocate MW with bad type = %d\n",
+				type);
 		ret = -EINVAL;
 		goto err3;
 	}
@@ -91,15 +70,15 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 	rxe_add_index(mw);
 	index = mw->pelem.index;
 
-	/* o10-37.2.32: */
-	rxe_set_mw_rkey(mw);
+	/* o10-37.2.32 */
+	set_mw_rkey(mw);
 
 	mw->qp			= NULL;
 	mw->mr			= NULL;
 	mw->addr		= 0;
 	mw->length		= 0;
-        mw->ibmw.pd		= ibpd;
-        mw->ibmw.type		= type;
+	mw->ibmw.pd		= ibpd;
+	mw->ibmw.type		= type;
 
 	spin_lock_init(&mw->lock);
 
@@ -120,44 +99,39 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 	return ERR_PTR(ret);
 }
 
-/* Check the rules for bind MW oepration. */
 static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			 struct rxe_mw *mw, struct rxe_mr *mr)
 {
-	/* check to see if bind operation came through
-	 * ibv_bind_mw verbs API. */
+	/* check to see if bind operation came through verbs API. */
 	switch (mw->ibmw.type) {
 	case IB_MW_TYPE_1:
-		/* o10-37.2.34: */
+		/* o10-37.2.34 */
 		if (unlikely(!(wqe->wr.wr.umw.flags & RXE_BIND_MW))) {
 			pr_err("attempt to bind type 1 MW with send WR\n");
 			return -EINVAL;
 		}
 		break;
 	case IB_MW_TYPE_2:
-		/* o10-37.2.35: */
+		/* o10-37.2.35 */
 		if (unlikely(wqe->wr.wr.umw.flags & RXE_BIND_MW)) {
-			pr_err("attempt to bind type 2 MW with verbs API\n");
+			pr_err_once("attempt to bind type 2 MW with verbs API\n");
 			return -EINVAL;
 		}
 
-		/* C10-72: */
+		/* C10-72 */
 		if (unlikely(qp->pd != to_rpd(mw->ibmw.pd))) {
-			pr_err("attempt to bind type 2 MW with qp"
-				" with different PD\n");
+			pr_err_once("attempt to bind type 2 MW with qp with different PD\n");
 			return -EINVAL;
 		}
 
-		/* o10-37.2.40: */
+		/* o10-37.2.40 */
 		if (unlikely(wqe->wr.wr.umw.length == 0)) {
-			pr_err("attempt to invalidate type 2 MW by"
-				" binding with zero length\n");
+			pr_err_once("attempt to invalidate type 2 MW by binding with zero length\n");
 			return -EINVAL;
 		}
 
 		if (unlikely(!mr)) {
-			pr_err("attempt to invalidate type 2 MW by"
-				" binding to NULL mr\n");
+			pr_err_once("attempt to bind type 2 MW to NULL MR\n");
 			return -EINVAL;
 		}
 		break;
@@ -167,20 +141,19 @@ static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 
 	if (unlikely((mw->ibmw.type == IB_MW_TYPE_1) &&
 			(mw->state != RXE_MEM_STATE_VALID))) {
-		pr_err("attempt to bind a type 1 MW not in the"
-			" valid state\n");
+		pr_err_once("attempt to bind an invalid type 1 MW\n");
 		return -EINVAL;
 	}
 
-	/* o10-36.2.2: */
+	/* o10-36.2.2 */
 	if (unlikely((mw->access & IB_ZERO_BASED) &&
 			(mw->ibmw.type == IB_MW_TYPE_1))) {
-		pr_err("attempt to bind a zero based type 1 MW\n");
+		pr_err_once("attempt to bind a zero based type 1 MW\n");
 		return -EINVAL;
 	}
 
 	if ((wqe->wr.wr.umw.rkey & 0xff) == (mw->ibmw.rkey & 0xff)) {
-		pr_err("attempt to bind MW with same key\n");
+		pr_err_once("attempt to bind a MW with same key\n");
 		return -EINVAL;
 	}
 
@@ -189,47 +162,42 @@ static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		return 0;
 
 	if (unlikely(mr->access & IB_ZERO_BASED)) {
-		pr_err("attempt to bind MW to zero based MR\n");
+		pr_err_once("attempt to bind MW to zero based MR\n");
 		return -EINVAL;
 	}
 
-	/* o10-37.2.30: */
+	/* o10-37.2.30 */
 	if (unlikely((mw->ibmw.type == IB_MW_TYPE_2) &&
 			(mw->state != RXE_MEM_STATE_FREE))) {
-		pr_err("attempt to bind a type 2 MW not in the"
-			" free state\n");
+		pr_err_once("attempt to bind a not free type 2 MW\n");
 		return -EINVAL;
 	}
 
-	/* C10-73: */
+	/* C10-73 */
 	if (unlikely(!(mr->access & IB_ACCESS_MW_BIND))) {
-		pr_err("attempt to bind an MW to an MR without"
-			" bind access\n");
+		pr_err_once("attempt to bind an MW to an MR without bind access\n");
 		return -EINVAL;
 	}
 
-	/* C10-74: */
+	/* C10-74 */
 	if (unlikely((mw->access & (IB_ACCESS_REMOTE_WRITE |
 				    IB_ACCESS_REMOTE_ATOMIC)) &&
 	    !(mr->access & IB_ACCESS_LOCAL_WRITE))) {
-		pr_err("attempt to bind an MW with write/atomic"
-			" access to an MR without local write access\n");
+		pr_err_once("attempt to bind an MW with write/atomic access to an MR without local write access\n");
 		return -EINVAL;
 	}
 
-	/* C10-75: */
+	/* C10-75 */
 	if (mw->access & IB_ZERO_BASED) {
 		if (unlikely(wqe->wr.wr.umw.length > mr->length)) {
-			pr_err("attempt to bind a ZB MW outside"
-				" of the MR\n");
+			pr_err_once("attempt to bind a MW out of the MR\n");
 			return -EINVAL;
 		}
 	} else {
 		if (unlikely((wqe->wr.wr.umw.addr < mr->iova) ||
 		    ((wqe->wr.wr.umw.addr + wqe->wr.wr.umw.length) >
 		     (mr->iova + mr->length)))) {
-			pr_err("attempt to bind a VA MW outside"
-				" of the MR\n");
+			pr_err_once("attempt to bind a MW out of the MR\n");
 			return -EINVAL;
 		}
 	}
@@ -243,47 +211,48 @@ static int do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	int ret;
 	u32 rkey;
 	u32 new_rkey;
+	struct rxe_mw *duplicate_mw;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
-	/* key part of new rkey is provided by user for type 2
-	 * and ibv_bind_mw() for type 1 MWs */
+	/*
+	 * key part of new rkey is provided by user for type 2
+	 * and ibv_bind_mw() for type 1 MWs
+	 * there is a very rare chance that the new rkey will
+	 * collide with an existing MW. Return an error if this
+	 * occurs
+	 */
 	rkey = mw->ibmw.rkey;
-	rxe_drop_key(mw);
 	new_rkey = (rkey & 0xffffff00) | (wqe->wr.wr.umw.rkey & 0x000000ff);
-	ret = rxe_add_key(mw, &new_rkey);
-	if (ret) {
-		/* this should never happen */
-		pr_err("shouldn't happen unable to set new rkey\n");
-		/* try to put back the old one */
-		rxe_add_key(mw, &rkey);
-		return ret;
+
+	duplicate_mw = rxe_get_key(rxe, &new_key);
+	if (duplicate_mw) {
+		pr_err_once("new MW key is a duplicate, try another\n");
+		rxe_drop_ref(duplicate_mw);
+		return -EINVAL;
 	}
 
+	rxe_drop_key(mw);
+	rxe_add_key(mw, &new_rkey);
+
 	mw->access = wqe->wr.wr.umw.access;
 	mw->state = RXE_MEM_STATE_VALID;
 	mw->addr = wqe->wr.wr.umw.addr;
 	mw->length = wqe->wr.wr.umw.length;
 
-	/* get rid of existing MR if any, type 1 only */
 	if (mw->mr) {
 		rxe_drop_ref(mw->mr);
 		atomic_dec(&mw->mr->num_mw);
 		mw->mr = NULL;
 	}
 
-	/* if length != 0 bind to new MR */
 	if (mw->length) {
 		mw->mr = mr;
 		atomic_inc(&mr->num_mw);
 		rxe_add_ref(mr);
 	}
 
-	/* remember qp if type 2, cleared by invalidate
-	 * this is weak since qp can go away legally
-	 * only used to compare with qp used to perform
-	 * memory ops */
-	if (mw->ibmw.type == IB_MW_TYPE_2) {
+	if (mw->ibmw.type == IB_MW_TYPE_2)
 		mw->qp = qp;
-	}
 
 	return 0;
 }
@@ -300,7 +269,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		mw = rxe_pool_get_index(&rxe->mw_pool,
 					wqe->wr.wr.umw.mw_index);
 		if (!mw) {
-			pr_err("mw with index = %d not found\n",
+			pr_err_once("mw with index = %d not found\n",
 				wqe->wr.wr.umw.mw_index);
 			ret = -EINVAL;
 			goto err1;
@@ -308,7 +277,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		mr = rxe_pool_get_index(&rxe->mr_pool,
 					wqe->wr.wr.umw.mr_index);
 		if (!mr && wqe->wr.wr.umw.length) {
-			pr_err("mr with index = %d not found\n",
+			pr_err_once("mr with index = %d not found\n",
 				wqe->wr.wr.umw.mr_index);
 			ret = -EINVAL;
 			goto err2;
@@ -326,12 +295,10 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	spin_lock_irqsave(&mw->lock, flags);
 
-	/* check the rules */
 	ret = check_bind_mw(qp, wqe, mw, mr);
 	if (ret)
 		goto err3;
 
-	/* implement the change */
 	ret = do_bind_mw(qp, wqe, mw, mr);
 err3:
 	spin_unlock_irqrestore(&mw->lock, flags);
@@ -347,14 +314,13 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 static int check_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
 {
 	if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
-		pr_warn("attempt to invalidate a MW that"
-			" is not valid\n");
+		pr_err_once("attempt to invalidate a MW that is not valid\n");
 		return -EINVAL;
 	}
 
-	/* o10-37.2.26: */
+	/* o10-37.2.26 */
 	if (unlikely(mw->ibmw.type == IB_MW_TYPE_1)) {
-		pr_err("attempt to invalidate a type 1 MW\n");
+		pr_err_once("attempt to invalidate a type 1 MW\n");
 		return -EINVAL;
 	}
 
@@ -434,41 +400,37 @@ int rxe_mw_check_access(struct rxe_qp *qp, struct rxe_mw *mw,
 	struct rxe_pd *pd = to_rpd(mw->ibmw.pd);
 
 	if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
-		pr_err("attempt to access a MW that is"
-			" not in the valid state\n");
+		pr_err_once("attempt to access a MW that is not in the valid state\n");
 		return -EINVAL;
 	}
 
 	/* C10-76.2.1 */
 	if (unlikely((mw->ibmw.type == IB_MW_TYPE_1) && (pd != qp->pd))) {
-		pr_err("attempt to access a type 1 MW with a"
-			" different PD than the QP\n");
+		pr_err_once("attempt to access a type 1 MW with a different PD than the QP\n");
 		return -EINVAL;
 	}
 
 	/* o10-37.2.43 */
 	if (unlikely((mw->ibmw.type == IB_MW_TYPE_2) && (mw->qp != qp))) {
-		pr_err("attempt to access a type 2 MW that is"
-			" associated with a different QP\n");
+		pr_err_once("attempt to access a type 2 MW that is associated with a different QP\n");
 		return -EINVAL;
 	}
 
 	/* C10-77 */
 	if (unlikely(access && !(access & mw->access))) {
-		pr_err("attempt to access a MW that does"
-			" not have the required access rights\n");
+		pr_err_once("attempt to access a MW that does not have the required access rights\n");
 		return -EINVAL;
 	}
 
 	if (mw->access & IB_ZERO_BASED) {
 		if (unlikely((va + resid) > mw->length)) {
-			pr_err("attempt to access a MW out of bounds\n");
+			pr_err_once("attempt to access a MW out of bounds\n");
 			return -EINVAL;
 		}
 	} else {
 		if (unlikely((va < mw->addr) ||
 			((va + resid) > (mw->addr + mw->length)))) {
-			pr_err("attempt to access a MW out of bounds\n");
+			pr_err_once("attempt to access a MW out of bounds\n");
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 0c3808611f95..e9b6f491e922 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_net.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
@@ -120,7 +95,7 @@ static struct dst_entry *rxe_find_route6(struct net_device *ndev,
 	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
 					       recv_sockets.sk6->sk, &fl6,
 					       NULL);
-	if (unlikely(IS_ERR(ndst))) {
+	if (IS_ERR(ndst)) {
 		pr_err_ratelimited("no route to %pI6\n", daddr);
 		return NULL;
 	}
@@ -333,8 +308,8 @@ static void prepare_ipv6_hdr(struct dst_entry *dst, struct sk_buff *skb,
 	ip6h		  = ipv6_hdr(skb);
 	ip6_flow_hdr(ip6h, prio, htonl(0));
 	ip6h->payload_len = htons(skb->len);
-	ip6h->nexthdr     = proto;
-	ip6h->hop_limit   = ttl;
+	ip6h->nexthdr	  = proto;
+	ip6h->hop_limit	  = ttl;
 	ip6h->daddr	  = *daddr;
 	ip6h->saddr	  = *saddr;
 	ip6h->payload_len = htons(skb->len - sizeof(*ip6h));
diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
index 2ca71d3d245c..1142dd4b47cb 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.h
+++ b/drivers/infiniband/sw/rxe/rxe_net.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * drivers/infiniband/sw/rxe/rxe_net.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_NET_H
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index d2f2092f0be5..31065d772f10 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_opcode.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <rdma/ib_pack.h>
@@ -397,7 +372,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		.name	= "IB_OPCODE_RC_SEND_ONLY_INV",
 		.mask	= RXE_IETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK
 				| RXE_COMP_MASK | RXE_RWR_MASK | RXE_SEND_MASK
-				| RXE_END_MASK  | RXE_START_MASK,
+				| RXE_END_MASK	| RXE_START_MASK,
 		.length = RXE_BTH_BYTES + RXE_IETH_BYTES,
 		.offset = {
 			[RXE_BTH]	= 0,
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 307604e9c78d..7a42bfab1d45 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * drivers/infiniband/sw/rxe/rxe_opcode.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_OPCODE_H
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 41e7b74efcbc..c24d90911434 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * drivers/infiniband/sw/rxe/rxe_param.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_PARAM_H
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index df3e2a514ce3..0f8b83f0965a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_pool.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *		- Redistributions of source code must retain the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer.
- *
- *		- Redistributions in binary form must reproduce the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer in the documentation and/or other materials
- *		  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
@@ -38,7 +13,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
-		.flags          = RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
@@ -68,7 +43,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_CQ] = {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
-		.flags          = RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_NO_ALLOC,
 		.cleanup	= rxe_cq_cleanup,
 	},
 	[RXE_TYPE_MR] = {
@@ -366,10 +341,8 @@ void rxe_drop_key(void *arg)
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
-	if (elem == NULL) {
-		pr_warn("rxe_drop_key: called with null pointer\n");
+	if (elem == NULL)
 		return;
-	}
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	rb_erase(&elem->key_node, &pool->key.tree);
@@ -394,10 +367,8 @@ void rxe_drop_index(void *arg)
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
-	if (elem == NULL) {
-		pr_warn("rxe_drop_index: called with null pointer\n");
+	if (elem == NULL)
 		return;
-	}
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	clear_bit(elem->index - pool->index.min_index, pool->index.table);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 0ba811456f79..43c38f67fa26 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * drivers/infiniband/sw/rxe/rxe_pool.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *		- Redistributions of source code must retain the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer.
- *
- *		- Redistributions in binary form must reproduce the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer in the documentation and/or other materials
- *		  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_POOL_H
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 6c11c3aeeca6..0b09ab0b1543 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_qp.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *		- Redistributions of source code must retain the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer.
- *
- *		- Redistributions in binary form must reproduce the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer in the documentation and/or other materials
- *		  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
@@ -217,7 +192,8 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 }
 
 static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
-			   struct ib_qp_init_attr *init, struct ib_udata *udata,
+			   struct ib_qp_init_attr *init,
+			   struct ib_udata *udata,
 			   struct rxe_create_qp_resp __user *uresp)
 {
 	int err;
@@ -331,7 +307,8 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 }
 
 /* called by the create qp verb */
-int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
+int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
+		     struct rxe_pd *pd,
 		     struct ib_qp_init_attr *init,
 		     struct rxe_create_qp_resp __user *uresp,
 		     struct ib_pd *ibpd,
@@ -413,7 +390,7 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 		    struct ib_qp_attr *attr, int mask)
 {
 	enum ib_qp_state cur_state = (mask & IB_QP_CUR_STATE) ?
-					attr->cur_qp_state : qp->attr.qp_state;
+				attr->cur_qp_state : qp->attr.qp_state;
 	enum ib_qp_state new_state = (mask & IB_QP_STATE) ?
 					attr->qp_state : cur_state;
 
@@ -628,9 +605,8 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 	if (mask & IB_QP_QKEY)
 		qp->attr.qkey = attr->qkey;
 
-	if (mask & IB_QP_AV) {
+	if (mask & IB_QP_AV)
 		rxe_init_av(&attr->ah_attr, &qp->pri_av);
-	}
 
 	if (mask & IB_QP_ALT_PATH) {
 		rxe_init_av(&attr->alt_ah_attr, &qp->alt_av);
@@ -649,7 +625,10 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		if (attr->timeout == 0) {
 			qp->qp_timeout_jiffies = 0;
 		} else {
-			/* According to the spec, timeout = 4.096 * 2 ^ attr->timeout [us] */
+			/*
+			 * According to the spec,
+			 * timeout = 4.096 * 2 ^ attr->timeout [us]
+			 */
 			int j = nsecs_to_jiffies(4096ULL << attr->timeout);
 
 			qp->qp_timeout_jiffies = j ? j : 1;
@@ -687,7 +666,8 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		qp->attr.sq_psn = (attr->sq_psn & BTH_PSN_MASK);
 		qp->req.psn = qp->attr.sq_psn;
 		qp->comp.psn = qp->attr.sq_psn;
-		pr_debug("qp#%d set req psn = 0x%x\n", qp_num(qp), qp->req.psn);
+		pr_debug("qp#%d set req psn = 0x%x\n",
+				qp_num(qp), qp->req.psn);
 	}
 
 	if (mask & IB_QP_PATH_MIG_STATE)
@@ -803,7 +783,8 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 /* called when the last reference to the qp is dropped */
 static void rxe_qp_do_cleanup(struct work_struct *work)
 {
-	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
+	struct rxe_qp *qp = container_of(work, typeof(*qp),
+					cleanup_work.work);
 
 	rxe_drop_all_mcast_groups(qp);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index 245040c3a35d..f761943e7467 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_queue.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must retailuce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/vmalloc.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index 8ef17d617022..98fb2f50621a 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * drivers/infiniband/sw/rxe/rxe_queue.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_QUEUE_H
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 7e123d3c4d09..9eb38008f603 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_recv.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f0fa195fcc70..61f41cfdfefd 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -1,34 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_req.c
+ *
+ * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
@@ -135,7 +111,8 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 	unsigned long flags;
 
 	if (unlikely(qp->req.state == QP_STATE_DRAIN)) {
-		/* check to see if we are drained;
+		/*
+		 * check to see if we are drained;
 		 * state_lock used by requester and completer
 		 */
 		spin_lock_irqsave(&qp->state_lock, flags);
@@ -345,7 +322,8 @@ static int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	return -EINVAL;
 }
 
-static inline int check_init_depth(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
+static inline int check_init_depth(struct rxe_qp *qp,
+				struct rxe_send_wqe *wqe)
 {
 	int depth;
 
@@ -394,9 +372,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	/* length from start of bth to end of icrc */
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
 
-	/* pkt->hdr, rxe, port_num and mask are initialized in ifc
-	 * layer
-	 */
+	/* pkt->hdr, rxe, port_num and mask are initialized in ifc layer */
 	pkt->opcode	= opcode;
 	pkt->qp		= qp;
 	pkt->psn	= qp->req.psn;
@@ -551,9 +527,9 @@ static void save_state(struct rxe_send_wqe *wqe,
 		       struct rxe_send_wqe *rollback_wqe,
 		       u32 *rollback_psn)
 {
-	rollback_wqe->state     = wqe->state;
+	rollback_wqe->state	= wqe->state;
 	rollback_wqe->first_psn = wqe->first_psn;
-	rollback_wqe->last_psn  = wqe->last_psn;
+	rollback_wqe->last_psn	= wqe->last_psn;
 	*rollback_psn		= qp->req.psn;
 }
 
@@ -591,18 +567,25 @@ static int local_invalidate(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	u32 key = wqe->wr.ex.invalidate_rkey;
 
-	if (!(key & IS_MW) && (mr = rxe_pool_get_key(&rxe->mr_pool, &key))) {
-		ret = rxe_invalidate_mr(qp, mr);
-		rxe_drop_ref(mr);
-	} else if ((mw = rxe_pool_get_key(&rxe->mw_pool, &key))) {
+	if (key & IS_MW) {
+		mw = rxe_pool_get_key(&rxe->mw_pool, &key);
+		if (!mw)
+			goto err;
 		ret = rxe_invalidate_mw(qp, mw);
 		rxe_drop_ref(mw);
-	} else {
-		ret = -EINVAL;
-		pr_err("No mr/mw for rkey %#x\n", key);
+		return ret;
 	}
 
+	mr = rxe_pool_get_key(&rxe->mr_pool, &key);
+	if (!mr)
+		goto err;
+	ret = rxe_invalidate_mr(qp, mr);
+	rxe_drop_ref(mr);
 	return ret;
+
+err:
+	pr_err("No mr/mw for rkey 0x%x\n", key);
+	return -EINVAL;
 }
 
 int rxe_requester(void *arg)
@@ -619,17 +602,9 @@ int rxe_requester(void *arg)
 	int ret;
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
-	int entered;
 
 	rxe_add_ref(qp);
 
-	// this code is 'guaranteed' to never be entered more
-	// than once. Check to make sure that this is the case
-	entered = atomic_inc_return(&qp->req.task.entered);
-	if (entered > 1) {
-		pr_err("rxe_requester: entered %d times\n", entered);
-	}
-
 next_wqe:
 	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
 		goto exit;
@@ -652,19 +627,21 @@ int rxe_requester(void *arg)
 	if (unlikely(!wqe))
 		goto exit;
 
-	/* process local operations */
-	/* current behavior if an error occurs
+	/*
+	 * process local operations
+	 * current behavior if an error occurs
 	 * for any of these local operations
 	 * is to generate an error work completion
 	 * then error the QP and flush any
-	 * remaining WRs */
+	 * remaining WRs
+	 */
 	if (wqe->mask & WR_LOCAL_MASK) {
 		wqe->state = wqe_state_done;
 		wqe->status = IB_WC_SUCCESS;
 
 		switch (wqe->wr.opcode) {
 		case IB_WR_LOCAL_INV:
-			if ((ret = local_invalidate(qp, wqe)))
+			if (local_invalidate(qp, wqe))
 				wqe->status = IB_WC_LOC_QP_OP_ERR;
 			break;
 		case IB_WR_REG_MR:
@@ -676,22 +653,26 @@ int rxe_requester(void *arg)
 			mr->iova = wqe->wr.wr.reg.mr->iova;
 			break;
 		case IB_WR_BIND_MW:
-			if ((ret = rxe_bind_mw(qp, wqe)))
+			if (rxe_bind_mw(qp, wqe))
 				wqe->status = IB_WC_MW_BIND_ERR;
 			break;
 		default:
-			pr_err("rxe_requester: unexpected local"
-				" WR opcode = %d\n", wqe->wr.opcode);
-			/* these should be memory operation errors
-			 * but there isn't one available */
+			pr_err("unexpected local WR opcode = %d\n",
+				wqe->wr.opcode);
+			/*
+			 * these should be memory operation errors
+			 * but there isn't one available
+			 */
 			wqe->status = IB_WC_LOC_QP_OP_ERR;
 		}
 
 		/* we're done processing the wqe so move index */
 		qp->req.wqe_index = next_index(qp->sq.queue, qp->req.wqe_index);
 
-		/* if an error occurred do a completion pass now
-		 * (below) and then quit processing more wqes */
+		/*
+		 * if an error occurred do a completion pass now
+		 * (below) and then quit processing more wqes
+		 */
 		if (wqe->status != IB_WC_SUCCESS)
 			goto err;
 
@@ -743,12 +724,6 @@ int rxe_requester(void *arg)
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 
-			/* TODO why?? why not just treat the same as a
-			 * successful wqe and go to next wqe?
-			 * __rxe_do_task probably shouldn't be used
-			 * it reenters the completion task which may
-			 * already be running
-			 */
 			__rxe_do_task(&qp->comp.task);
 			goto again;
 		}
@@ -798,20 +773,24 @@ int rxe_requester(void *arg)
 	goto next_wqe;
 
 err:
-	/* we come here if an error occured while processing
+	/*
+	 * we come here if an error occured while processing
 	 * a send wqe. The completer will put the qp in error
 	 * state and no more wqes will be processed unless
-	 * the qp is cleaned up and restarted. */
+	 * the qp is cleaned up and restarted.
+	 */
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
 	ret = -EAGAIN;
 	goto done;
 
 exit:
-	/* we come here if either there are no more wqes in the send
+	/*
+	 * we come here if either there are no more wqes in the send
 	 * queue or we are blocked waiting for some resource or event.
 	 * The current wqe will be restarted or new wqe started when
-	 * there is something to do. */
+	 * there is something to do.
+	 */
 	ret = -EAGAIN;
 	goto done;
 
@@ -821,7 +800,6 @@ int rxe_requester(void *arg)
 	goto done;
 
 done:
-	atomic_dec(&qp->req.task.entered);
 	rxe_drop_ref(qp);
 	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 0bfea50505d1..0696ca85161e 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1,34 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_resp.c
+ *
+ * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
@@ -71,36 +47,36 @@ enum resp_states {
 };
 
 static char *resp_state_name[] = {
-	[RESPST_NONE]				= "NONE",
-	[RESPST_GET_REQ]			= "GET_REQ",
-	[RESPST_CHK_PSN]			= "CHK_PSN",
-	[RESPST_CHK_OP_SEQ]			= "CHK_OP_SEQ",
-	[RESPST_CHK_OP_VALID]			= "CHK_OP_VALID",
-	[RESPST_CHK_RESOURCE]			= "CHK_RESOURCE",
-	[RESPST_CHK_LENGTH]			= "CHK_LENGTH",
-	[RESPST_CHK_RKEY]			= "CHK_RKEY",
-	[RESPST_EXECUTE]			= "EXECUTE",
-	[RESPST_READ_REPLY]			= "READ_REPLY",
-	[RESPST_COMPLETE]			= "COMPLETE",
-	[RESPST_ACKNOWLEDGE]			= "ACKNOWLEDGE",
-	[RESPST_CLEANUP]			= "CLEANUP",
-	[RESPST_DUPLICATE_REQUEST]		= "DUPLICATE_REQUEST",
-	[RESPST_ERR_MALFORMED_WQE]		= "ERR_MALFORMED_WQE",
-	[RESPST_ERR_UNSUPPORTED_OPCODE]		= "ERR_UNSUPPORTED_OPCODE",
-	[RESPST_ERR_MISALIGNED_ATOMIC]		= "ERR_MISALIGNED_ATOMIC",
-	[RESPST_ERR_PSN_OUT_OF_SEQ]		= "ERR_PSN_OUT_OF_SEQ",
-	[RESPST_ERR_MISSING_OPCODE_FIRST]	= "ERR_MISSING_OPCODE_FIRST",
-	[RESPST_ERR_MISSING_OPCODE_LAST_C]	= "ERR_MISSING_OPCODE_LAST_C",
-	[RESPST_ERR_MISSING_OPCODE_LAST_D1E]	= "ERR_MISSING_OPCODE_LAST_D1E",
-	[RESPST_ERR_TOO_MANY_RDMA_ATM_REQ]	= "ERR_TOO_MANY_RDMA_ATM_REQ",
-	[RESPST_ERR_RNR]			= "ERR_RNR",
-	[RESPST_ERR_RKEY_VIOLATION]		= "ERR_RKEY_VIOLATION",
-	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
-	[RESPST_ERR_CQ_OVERFLOW]		= "ERR_CQ_OVERFLOW",
-	[RESPST_ERROR]				= "ERROR",
-	[RESPST_RESET]				= "RESET",
-	[RESPST_DONE]				= "DONE",
-	[RESPST_EXIT]				= "EXIT",
+	[RESPST_NONE]			      = "NONE",
+	[RESPST_GET_REQ]		      = "GET_REQ",
+	[RESPST_CHK_PSN]		      = "CHK_PSN",
+	[RESPST_CHK_OP_SEQ]		      = "CHK_OP_SEQ",
+	[RESPST_CHK_OP_VALID]		      = "CHK_OP_VALID",
+	[RESPST_CHK_RESOURCE]		      = "CHK_RESOURCE",
+	[RESPST_CHK_LENGTH]		      = "CHK_LENGTH",
+	[RESPST_CHK_RKEY]		      = "CHK_RKEY",
+	[RESPST_EXECUTE]		      = "EXECUTE",
+	[RESPST_READ_REPLY]		      = "READ_REPLY",
+	[RESPST_COMPLETE]		      = "COMPLETE",
+	[RESPST_ACKNOWLEDGE]		      = "ACKNOWLEDGE",
+	[RESPST_CLEANUP]		      = "CLEANUP",
+	[RESPST_DUPLICATE_REQUEST]	      = "DUPLICATE_REQUEST",
+	[RESPST_ERR_MALFORMED_WQE]	      = "ERR_MALFORMED_WQE",
+	[RESPST_ERR_UNSUPPORTED_OPCODE]	      = "ERR_UNSUPPORTED_OPCODE",
+	[RESPST_ERR_MISALIGNED_ATOMIC]	      = "ERR_MISALIGNED_ATOMIC",
+	[RESPST_ERR_PSN_OUT_OF_SEQ]	      = "ERR_PSN_OUT_OF_SEQ",
+	[RESPST_ERR_MISSING_OPCODE_FIRST]     = "ERR_MISSING_OPCODE_FIRST",
+	[RESPST_ERR_MISSING_OPCODE_LAST_C]    = "ERR_MISSING_OPCODE_LAST_C",
+	[RESPST_ERR_MISSING_OPCODE_LAST_D1E]  = "ERR_MISSING_OPCODE_LAST_D1E",
+	[RESPST_ERR_TOO_MANY_RDMA_ATM_REQ]    = "ERR_TOO_MANY_RDMA_ATM_REQ",
+	[RESPST_ERR_RNR]		      = "ERR_RNR",
+	[RESPST_ERR_RKEY_VIOLATION]	      = "ERR_RKEY_VIOLATION",
+	[RESPST_ERR_LENGTH]		      = "ERR_LENGTH",
+	[RESPST_ERR_CQ_OVERFLOW]	      = "ERR_CQ_OVERFLOW",
+	[RESPST_ERROR]			      = "ERROR",
+	[RESPST_RESET]			      = "RESET",
+	[RESPST_DONE]			      = "DONE",
+	[RESPST_EXIT]			      = "EXIT",
 };
 
 /* rxe_recv calls here to add a request packet to the input queue */
@@ -462,7 +438,13 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	resid	= qp->resp.resid;
 	pktlen	= payload_size(pkt);
 
-	if ((rkey & IS_MW) && (mw = rxe_pool_get_key(&rxe->mw_pool, &rkey))) {
+	if (rkey & IS_MW) {
+		mw = rxe_pool_get_key(&rxe->mw_pool, &rkey);
+		if (!mw) {
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err;
+		}
+
 		spin_lock_irqsave(&mw->lock, flags);
 		if (rxe_mw_check_access(qp, mw, access, va, resid)) {
 			spin_unlock_irqrestore(&mw->lock, flags);
@@ -479,16 +461,19 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 
 		spin_unlock_irqrestore(&mw->lock, flags);
 		rxe_drop_ref(mw);
-	} else if ((mr = rxe_pool_get_key(&rxe->mr_pool, &rkey)) &&
-		   (mr->rkey == rkey)) {
+	} else {
+		mr = rxe_pool_get_key(&rxe->mr_pool, &rkey);
+		if (!mr || mr->rkey != rkey) {
+			if (mr)
+				rxe_drop_ref(mr);
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err;
+		}
+
 		if (rxe_mr_check_access(qp, mr, access, va, resid)) {
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
 		}
-	} else {
-		pr_err("no MR/MW found with rkey = 0x%08x\n", rkey);
-		state = RESPST_ERR_RKEY_VIOLATION;
-		goto err;
 	}
 
 	if (pkt->mask & RXE_WRITE_MASK)	 {
@@ -853,15 +838,22 @@ static int send_invalidate(struct rxe_qp *qp, struct rxe_dev *rxe, u32 rkey)
 	struct rxe_mr *mr;
 	struct rxe_mw *mw;
 
-	if ((mr = rxe_pool_get_key(&rxe->mr_pool, &rkey))) {
-		ret = rxe_invalidate_mr(qp, mr);
-		rxe_drop_ref(mr);
-	} else if ((mw = rxe_pool_get_key(&rxe->mw_pool, &rkey))) {
+	if (rkey & IS_MW) {
+		mw = rxe_pool_get_key(&rxe->mw_pool, &rkey);
+		if (!mw) {
+			pr_err("no MW found for rkey = 0x%x\n", rkey);
+			ret = -EINVAL;
+		}
 		ret = rxe_invalidate_mw(qp, mw);
 		rxe_drop_ref(mw);
 	} else {
-		pr_err("send invalidate failed for rkey = 0x%x\n", rkey);
-		ret = -EINVAL;
+		mr = rxe_pool_get_key(&rxe->mr_pool, &rkey);
+		if (!mr) {
+			pr_err("no MR found for rkey = 0x%x\n", rkey);
+			ret = -EINVAL;
+		}
+		ret = rxe_invalidate_mr(qp, mr);
+		rxe_drop_ref(mr);
 	}
 
 	return ret;
@@ -884,13 +876,13 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	memset(&cqe, 0, sizeof(cqe));
 
 	if (qp->rcq->is_user) {
-		uwc->status             = qp->resp.status;
-		uwc->qp_num             = qp->ibqp.qp_num;
-		uwc->wr_id              = wqe->wr_id;
+		uwc->status		= qp->resp.status;
+		uwc->qp_num		= qp->ibqp.qp_num;
+		uwc->wr_id		= wqe->wr_id;
 	} else {
-		wc->status              = qp->resp.status;
-		wc->qp                  = &qp->ibqp;
-		wc->wr_id               = wqe->wr_id;
+		wc->status		= qp->resp.status;
+		wc->qp			= &qp->ibqp;
+		wc->wr_id		= wqe->wr_id;
 	}
 
 	if (pkt->mask & RXE_IETH_MASK) {
@@ -909,7 +901,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		wc->vendor_err = 0;
 		wc->byte_len = (pkt->mask & RXE_IMMDT_MASK &&
 				pkt->mask & RXE_WRITE_MASK) ?
-					qp->resp.length : wqe->dma.length - wqe->dma.resid;
+					qp->resp.length :
+					wqe->dma.length - wqe->dma.resid;
 
 		/* fields after byte_len are different between kernel and user
 		 * space
@@ -936,7 +929,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		} else {
 			struct sk_buff *skb = PKT_TO_SKB(pkt);
 
-			wc->wc_flags = IB_WC_GRH | IB_WC_WITH_NETWORK_HDR_TYPE;
+			wc->wc_flags = IB_WC_GRH |
+					IB_WC_WITH_NETWORK_HDR_TYPE;
 			if (skb->protocol == htons(ETH_P_IP))
 				wc->network_hdr_type = RDMA_NETWORK_IPV4;
 			else
@@ -1175,7 +1169,7 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 			/* Resend the result. */
 			rc = rxe_xmit_packet(qp, pkt, res->atomic.skb);
 			if (rc) {
-				pr_err("Failed resending result. This flow is not handled - skb ignored\n");
+				pr_err("Failed resending result\n");
 				rc = RESPST_CLEANUP;
 				goto out;
 			}
@@ -1189,7 +1183,9 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 	return rc;
 }
 
-/* Process a class A or C. Both are treated the same in this implementation. */
+/* Process a class A or C. Both are treated the same
+ * in this implementation.
+ */
 static void do_class_ac_error(struct rxe_qp *qp, u8 syndrome,
 			      enum ib_wc_status status)
 {
@@ -1257,17 +1253,9 @@ int rxe_responder(void *arg)
 	enum resp_states state;
 	struct rxe_pkt_info *pkt = NULL;
 	int ret = 0;
-	int entered;
 
 	rxe_add_ref(qp);
 
-	// this code is 'guaranteed' to never be entered more
-	// than once. Check to make sure that this is the case
-	entered = atomic_inc_return(&qp->resp.task.entered);
-	if (entered > 1) {
-		pr_err("rxe_responder: entered %d times\n", entered);
-	}
-
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
 	if (!qp->valid) {
@@ -1330,7 +1318,8 @@ int rxe_responder(void *arg)
 			break;
 		case RESPST_ERR_PSN_OUT_OF_SEQ:
 			/* RC only - Class B. Drop packet. */
-			send_ack(qp, pkt, AETH_NAK_PSN_SEQ_ERROR, qp->resp.psn);
+			send_ack(qp, pkt, AETH_NAK_PSN_SEQ_ERROR,
+				 qp->resp.psn);
 			state = RESPST_CLEANUP;
 			break;
 
@@ -1446,7 +1435,6 @@ int rxe_responder(void *arg)
 exit:
 	ret = -EAGAIN;
 done:
-	atomic_dec(&qp->resp.task.entered);
 	rxe_drop_ref(qp);
 	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index d8459431534e..81394bab2c0f 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_srq.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/vmalloc.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
index ccda5f5a3bc0..39aa0c04dde8 100644
--- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
+++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_sysfs.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
@@ -92,7 +67,8 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
 	return err;
 }
 
-static int rxe_param_set_remove(const char *val, const struct kernel_param *kp)
+static int rxe_param_set_remove(const char *val,
+				const struct kernel_param *kp)
 {
 	int len;
 	char intf[32];
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 08f05ac5f5d5..44c3b908b9f4 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_task.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index e33806c6f5a4..836b21dcf2ae 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * drivers/infiniband/sw/rxe/rxe_task.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_TASK_H
@@ -55,8 +30,6 @@ struct rxe_task {
 	int			ret;
 	char			name[16];
 	bool			destroyed;
-	// debug code, delete me when done
-	atomic_t		entered;
 };
 
 /*
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index caaacfabadbc..7ddf97fac67d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * drivers/infiniband/sw/rxe/rxe_verbs.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/dma-mapping.h>
@@ -133,7 +108,8 @@ static enum rdma_link_layer rxe_get_link_layer(struct ib_device *dev,
 	return IB_LINK_LAYER_ETHERNET;
 }
 
-static int rxe_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
+static int rxe_alloc_ucontext(struct ib_ucontext *uctx,
+				struct ib_udata *udata)
 {
 	struct rxe_dev *rxe = to_rdev(uctx->device);
 	struct rxe_ucontext *uc = to_ruc(uctx);
@@ -376,7 +352,8 @@ static void rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	rxe_drop_ref(srq);
 }
 
-static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
+static int rxe_post_srq_recv(struct ib_srq *ibsrq,
+			     const struct ib_recv_wr *wr,
 			     const struct ib_recv_wr **bad_wr)
 {
 	int err = 0;
@@ -605,8 +582,9 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 		wqe->mask = mask;
 		wqe->state = wqe_state_posted;
 		return 0;
-	} else
-		memcpy(wqe->dma.sge, ibwr->sg_list,
+	}
+
+	memcpy(wqe->dma.sge, ibwr->sg_list,
 		       num_sge * sizeof(struct ib_sge));
 
 	wqe->iova = mask & WR_ATOMIC_MASK ? atomic_wr(ibwr)->remote_addr :
@@ -664,7 +642,8 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	return err;
 }
 
-static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
+static int rxe_post_send_kernel(struct rxe_qp *qp,
+				const struct ib_send_wr *wr,
 				const struct ib_send_wr **bad_wr)
 {
 	int err = 0;
@@ -773,7 +752,8 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	return err;
 }
 
-static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+static int rxe_create_cq(struct ib_cq *ibcq,
+			 const struct ib_cq_init_attr *attr,
 			 struct ib_udata *udata)
 {
 	int err;
@@ -868,7 +848,8 @@ static int rxe_peek_cq(struct ib_cq *ibcq, int wc_cnt)
 	return (count > wc_cnt) ? wc_cnt : count;
 }
 
-static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
+static int rxe_req_notify_cq(struct ib_cq *ibcq,
+			     enum ib_cq_notify_flags flags)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
 	unsigned long irq_flags;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index c990654e396d..b738f1603d13 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * drivers/infiniband/sw/rxe/rxe_verbs.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_VERBS_H
@@ -436,7 +411,8 @@ struct rxe_dev {
 	struct crypto_shash	*tfm;
 };
 
-static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
+static inline void rxe_counter_inc(struct rxe_dev *rxe,
+				   enum rxe_counters index)
 {
 	atomic64_inc(&rxe->stats_counters[index]);
 }
-- 
2.25.1

