Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51171B7CD4
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgDXRbt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727031AbgDXRbt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 13:31:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045B9C09B047;
        Fri, 24 Apr 2020 10:31:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so11803546wmh.0;
        Fri, 24 Apr 2020 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RQGcdRJLNrYqSHSgVV8oTnHfyay5BCm0woR8WhTdc4Q=;
        b=ja+aS0yrKmnDgS7/Yv353TzMUKf+Ohd2yz5rM1nrhcs5dukGoeteAfWBJAbt9agbOq
         f23Nn2GAq/qOdvbIRw/3KPT4ycN+pInXMjd1BChA640icyCAStpunnza9TON5zmWMu1c
         1ncRB2J/f7CYgBxuId+vlwxI0hwDmtqs8WM5Nx+E/1Qj82b0akdSIo8m7dwMIWIfZLmj
         wm0MkvHkENoCf8kX1kuTXcsyiHwBE90KfYczH3u7iNcGNw3zA/yU1fPsG86QmBe706e+
         lnVV5pozr5Qvn5kcurLq4rGmVJafcm02HGsPIMeYIq7N/IGfY8m4NS7YMgkBf/ZnvW/c
         c7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RQGcdRJLNrYqSHSgVV8oTnHfyay5BCm0woR8WhTdc4Q=;
        b=rTiLQJaBjeNFEbmfCcRUd36kwg+H4USUtzkfUbLN+606VJY0kRItZrijdMnV6eOZzU
         I3x+HIXtDg4VTscHTL7QBYBDI5Rilrgjd7Zadi64UZeD37OT1T4YgA8QjKs/5xLghH+1
         bbShNF9n2Fv8MwFkGlrN8C2bT43OVB1b9MxGSCCd4XgJuLIqDOQnND6PI8GoWlQFPXoJ
         7lxm6fDpahHAeu3Egmzdbk0VyEW1y/+26hO2vMPhM4pXeN3fpGkNTeivwgOnkS6R0eDa
         FMTYV01sCrXyYhoW66zhTuC0SSeKgnWgBDTZG5EkrEfTh+AgKnna/L039WAYd4bYieat
         k+qg==
X-Gm-Message-State: AGi0PuYLf7R1MHGf1xmMd41AkaUKA04zJTq0SbJYgOH1K7ykXj9lGLOA
        sRc1nhXHfepZRCjj9LMapCA=
X-Google-Smtp-Source: APiQypIVOrCpLaUv6phLa+L8W2tcwyIUTRMpgnidvQwqKqpiIqMqXsVGTeo/XmtxMnTfLSyKDoDk4w==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr10922438wmk.97.1587749507716;
        Fri, 24 Apr 2020 10:31:47 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id s17sm3556006wmc.48.2020.04.24.10.31.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 10:31:47 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v3] IB/rdmavt: return proper error code
Date:   Fri, 24 Apr 2020 18:31:46 +0100
Message-Id: <20200424173146.10970-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The commit 'ff23dfa13457' modified rvt_create_mmap_info() to return
error code and also NULL but missed fixing codes which called
rvt_create_mmap_info(). Modify rvt_create_mmap_info() to only return
errorcode and fix error checking after rvt_create_mmap_info() was
called.

Fixes: ff23dfa13457 ("IB: Pass only ib_udata in function prototypes")
Cc: stable@vger.kernel.org [5.4+]
Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Acked-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/infiniband/sw/rdmavt/cq.c   | 4 ++--
 drivers/infiniband/sw/rdmavt/mmap.c | 4 ++--
 drivers/infiniband/sw/rdmavt/qp.c   | 4 ++--
 drivers/infiniband/sw/rdmavt/srq.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 5724cbbe38b1..04d2e72017fe 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -248,8 +248,8 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	 */
 	if (udata && udata->outlen >= sizeof(__u64)) {
 		cq->ip = rvt_create_mmap_info(rdi, sz, udata, u_wc);
-		if (!cq->ip) {
-			err = -ENOMEM;
+		if (IS_ERR(cq->ip)) {
+			err = PTR_ERR(cq->ip);
 			goto bail_wc;
 		}
 
diff --git a/drivers/infiniband/sw/rdmavt/mmap.c b/drivers/infiniband/sw/rdmavt/mmap.c
index 652f4a7efc1b..37853aa3bcf7 100644
--- a/drivers/infiniband/sw/rdmavt/mmap.c
+++ b/drivers/infiniband/sw/rdmavt/mmap.c
@@ -154,7 +154,7 @@ int rvt_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
  * @udata: user data (must be valid!)
  * @obj: opaque pointer to a cq, wq etc
  *
- * Return: rvt_mmap struct on success
+ * Return: rvt_mmap struct on success, ERR_PTR on failure
  */
 struct rvt_mmap_info *rvt_create_mmap_info(struct rvt_dev_info *rdi, u32 size,
 					   struct ib_udata *udata, void *obj)
@@ -166,7 +166,7 @@ struct rvt_mmap_info *rvt_create_mmap_info(struct rvt_dev_info *rdi, u32 size,
 
 	ip = kmalloc_node(sizeof(*ip), GFP_KERNEL, rdi->dparms.node);
 	if (!ip)
-		return ip;
+		return ERR_PTR(-ENOMEM);
 
 	size = PAGE_ALIGN(size);
 
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 0e1b291d2cec..500a7ee04c44 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1244,8 +1244,8 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 
 			qp->ip = rvt_create_mmap_info(rdi, s, udata,
 						      qp->r_rq.wq);
-			if (!qp->ip) {
-				ret = ERR_PTR(-ENOMEM);
+			if (IS_ERR(qp->ip)) {
+				ret = ERR_CAST(qp->ip);
 				goto bail_qpn;
 			}
 
diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/rdmavt/srq.c
index 24fef021d51d..f547c115af03 100644
--- a/drivers/infiniband/sw/rdmavt/srq.c
+++ b/drivers/infiniband/sw/rdmavt/srq.c
@@ -111,8 +111,8 @@ int rvt_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *srq_init_attr,
 		u32 s = sizeof(struct rvt_rwq) + srq->rq.size * sz;
 
 		srq->ip = rvt_create_mmap_info(dev, s, udata, srq->rq.wq);
-		if (!srq->ip) {
-			ret = -ENOMEM;
+		if (IS_ERR(srq->ip)) {
+			ret = PTR_ERR(srq->ip);
 			goto bail_wq;
 		}
 
-- 
2.11.0

