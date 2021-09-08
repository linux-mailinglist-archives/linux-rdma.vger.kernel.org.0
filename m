Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E149403434
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 08:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347681AbhIHGWM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 02:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347656AbhIHGWL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 02:22:11 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9736C061757
        for <linux-rdma@vger.kernel.org>; Tue,  7 Sep 2021 23:21:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id bb10so666169plb.2
        for <linux-rdma@vger.kernel.org>; Tue, 07 Sep 2021 23:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=suw2T1e6kwJIDG8V4tApESOsygFx+IuCL+NR4/bwr/Q=;
        b=P9/D4sYU90Q6PzfXGlRkM3n//Hlb/mW8cGUKYXc1L1Hxz9bx1v7F73qb+3f8u75DJs
         eN+UY0Hx7p/Th+a/HZS3Dysl47z/dyzPWFZXHRy8xTUI+H8v1euniYs6jFv8czVwNaZo
         Sy8wgXEM06htydtSXgk8VFxu4EEe6iKupN4dym9TthvTMi7TOkFcMrkK9aG1cFD+xVaL
         TbPordUMdZctjs6kHM6l9JYQXPzfm0c+2zkzmQn/gU4W0BUL3s28DlLBjCpb08bezQUd
         KrvyQIHCy6djZZz9iDeDUgfSNmN4q3fRAPsmurXXt014srIxeERCSwtLkTgmdYTjJsDf
         pk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=suw2T1e6kwJIDG8V4tApESOsygFx+IuCL+NR4/bwr/Q=;
        b=NQY4RLN2ha5qv1FCRtTYkAdaXJouyRlu83Ojwim1rb1IC1giJgZ+7EVvO9nVMBaCjq
         m08DJfz5KSIfpIsksekjK6ewIRC1QglWpkT+mU9YNkd4FL5t/nsgMiQjD1ceAnUn+9Yc
         Q7t5erh4m/n28WLiMYb8vSIHKVpg6L5GxIJkYpTHetbuR71wrPD1HBCXvv7IuyrfSM4+
         6jtAMW8FBAqF0d+A328oH4m1FZKEZT1U69F1HmMoMgs48x5eRkq8KiTllxCmjzxQu/jh
         /rp3H/65A7ivmoGjkcDssdaTKk766UEWk3dvga1LjDV8xzlLdAr9psc/0K6/9Kj8sxvt
         1s2w==
X-Gm-Message-State: AOAM5338r7XwB0fucZlea1FcLcqT/85/XDtbLVii0haPYztChK9PwLXo
        w+JfLEgQs2fuWIlf634YsY+aOw==
X-Google-Smtp-Source: ABdhPJxPB85FSW14lImuXsNEIzUKnm0Zoq1S4CeQKRJO8HGrY5mAfi+H3lB2t0qK5Pum9fGwo8o8VA==
X-Received: by 2002:a17:902:7806:b0:138:1eee:c010 with SMTP id p6-20020a170902780600b001381eeec010mr1691037pll.20.1631082063411;
        Tue, 07 Sep 2021 23:21:03 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id l9sm657297pjz.55.2021.09.07.23.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 23:21:02 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Shunsuke Mie <mie@igel.co.jp>, dhobsong@igel.co.jp,
        taki@igel.co.jp, etom@igel.co.jp
Subject: [RFC PATCH] Providers/rxe: Add dma-buf support
Date:   Wed,  8 Sep 2021 15:20:49 +0900
Message-Id: <20210908062049.70699-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the user space counter-part of the kernel patch set to add
dma-buf support to the RXE driver.

Implement a new provider method for dma-buf base memory registration.

Pull request at GitHub: https://github.com/linux-rdma/rdma-core/pull/1055

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 providers/rxe/rxe.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3c3ea8bb..0e6b1ecd 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -239,6 +239,25 @@ static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	return &vmr->ibv_mr;
 }
 
+static struct ibv_mr* rxe_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t length,
+        uint64_t iova, int fd, int access)
+{
+	struct verbs_mr *vmr;
+    int ret;
+
+    vmr = malloc(sizeof (*vmr));
+    if (!vmr)
+        return NULL;
+
+    ret = ibv_cmd_reg_dmabuf_mr(pd, offset, length, iova, fd, access, vmr);
+    if (ret) {
+        free(vmr);
+        return NULL;
+    }
+
+    return &vmr->ibv_mr;
+}
+
 static int rxe_dereg_mr(struct verbs_mr *vmr)
 {
 	int ret;
@@ -1706,6 +1725,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.alloc_pd = rxe_alloc_pd,
 	.dealloc_pd = rxe_dealloc_pd,
 	.reg_mr = rxe_reg_mr,
+	.reg_dmabuf_mr = rxe_reg_dmabuf_mr,
 	.dereg_mr = rxe_dereg_mr,
 	.alloc_mw = rxe_alloc_mw,
 	.dealloc_mw = rxe_dealloc_mw,
-- 
2.17.1

