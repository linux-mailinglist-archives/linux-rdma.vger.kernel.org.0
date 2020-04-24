Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A447C1B7AF8
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 18:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgDXQBS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 12:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgDXQBS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Apr 2020 12:01:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C61C09B046;
        Fri, 24 Apr 2020 09:01:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so11445542wrm.13;
        Fri, 24 Apr 2020 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lWfBQsVyyMTVvcrJcEKSHvSl9LpE9cOW8DgSNhENSiQ=;
        b=hqoiJsHtarLSfLuNoh2mk5rGbr4437zI0PLe307qCSes9jMu8tAazKqrs2ipjSJieQ
         /jtiDiD/tchZWvtqUsyAm9RBjyo/OBYLFeHKnWDT3dyRW5+LLzdpd/EkWFlcBnpj/+hA
         tAxzXNKJ3w0aYFZxHzrHrQcnY6Oset61qQu6j6TQ4QgABaiI4XyG3XqLpfBL/AFc+CnV
         34jO36Q/yHuB07HhCeAyZlEtAVpVwKd42XbzNXjKjgKz19ddxxiT8eUWLtWqNGVw5kR+
         gnt5tKRam3qGBHaB2EqhLc0TUbM8tBMGb2fXFOnBOOUB9gCpldmowrLGjBYEOc0Qp3ez
         5KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lWfBQsVyyMTVvcrJcEKSHvSl9LpE9cOW8DgSNhENSiQ=;
        b=P5eXOr4l8B2wWRZScKAEVjXcft8uU7eE897KCU9/MrHiAUP8wub5rFbRiw/bfRsi7Q
         DnREM6SBNReY/Ei7SGe3J2sGF0C7nD5psXSS95+y4/LDWOOPogSiNXasX1W99xmRy5pE
         HbtlcxbnYFg1QjDLU5lNSJEZQ57oxN9KB2/lLerEMj2ykZHBFladQBORy5bXtb7bjgf1
         zKlqA6Nie2QIIktUMia1d8DGWJ4DJKqlg5f0U+MW7lqt567GJFIYqHZAM1fr0uYYJJjE
         +GSQ3uGZWbujQ31v8Uvd4jB8NOjT8yp/RRLu7vH3x6RHq72MeTATCjLgddNVkqVD3MYj
         K/Mw==
X-Gm-Message-State: AGi0PubW5ukix2saW+PxNIVSNRmN+wywftOLMLI1Pjhzknd8+DvRh/bs
        YA7B+n/JSCnQxiCYTyNmyKg=
X-Google-Smtp-Source: APiQypLJHTBDw6IqdxWHWR7afcrBkn2zkMvkizxlImMyHITrN6NbkOPOzrZ+qSeym2lxAsxk3NVFbg==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr11772255wrs.391.1587744076764;
        Fri, 24 Apr 2020 09:01:16 -0700 (PDT)
Received: from debian.office.codethink.co.uk. ([78.40.148.180])
        by smtp.gmail.com with ESMTPSA id u127sm3363017wme.8.2020.04.24.09.01.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 09:01:16 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] IB/rdmavt: return proper error code
Date:   Fri, 24 Apr 2020 17:01:14 +0100
Message-Id: <20200424160114.7139-1-sudipm.mukherjee@gmail.com>
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
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

 drivers/infiniband/sw/rdmavt/cq.c   | 4 ++--
 drivers/infiniband/sw/rdmavt/mmap.c | 2 +-
 drivers/infiniband/sw/rdmavt/qp.c   | 4 ++--
 drivers/infiniband/sw/rdmavt/srq.c  | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

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
index 652f4a7efc1b..eba1d5e7f056 100644
--- a/drivers/infiniband/sw/rdmavt/mmap.c
+++ b/drivers/infiniband/sw/rdmavt/mmap.c
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

