Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5319A41D337
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 08:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348293AbhI3GW3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 02:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348287AbhI3GW3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 02:22:29 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA6C06176C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 23:20:47 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso5951314otu.9
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 23:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i2cDjHFp2D2fj9lJTnJF4bsUIHxqYSPf+C49ab40XcM=;
        b=lIZkjVfAqaVUd1GtL2O+rDAuSxwrbA5nzwiQnZYjWDjr1lrbm+RiwmjHgNZOnmdLpE
         1QB6chWzbzuG7Xm8PAz4/zmqyJvk+IyXdhU0ZPYJXXsA7w2ZP13659TNWPX7NP+PA7MC
         Fq6DEccpMQUNmhXIzZBX8YwrqF6KMgn9t78lI61Wd9TaVwARAaC4zW8rWYSF12gzryVX
         Duivm9aUhQ98d+6GvUdTpNha40siqwI1F1+sEU0cKabA2xAXWlVY0573K/2Xa+S3fHLB
         mKbnVJjj6JhX+X1k8EK3kCRE5igF4d81ox6JV6FBfflPiV6IvWmdnJUsJUUqr2eIe1u5
         bD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i2cDjHFp2D2fj9lJTnJF4bsUIHxqYSPf+C49ab40XcM=;
        b=lpKQN8cCd1sRONhnRjixBVq/HEfZkwpJeolT1Xf8x0GMLgMY6Zfo89+3275NsNP3oW
         vy1pQUJ1C7IYh5gkaCdiS/YcW2orkd2DjQZ/RtOZq1Zitq5DXi8gH+4kvrvCtfeoxi/S
         YitjgohG4VihF04U0Q2tFmpUhVbR2Z9T2SPigEOlKw1i8r8tl+sYvgR9IJdqAdgyNbuu
         wo1XYjEvo3Mgr3oHsSLHcRQ+eDn6oqBEx8x2O+mXLrN1NotGbG1InzdaPcX8QJyVUNst
         T0p1LwmSfj8QdY3r1oXGHK+5KR8UvkJhKpZIxnFJ8eLb9luEdQ8nFpehFgAYjqlilLrd
         jE/Q==
X-Gm-Message-State: AOAM532mpXfrCh1S1cHkK+KEwTLH3Nd2yOsupq7cyeBDvi2z09O2/9T1
        h5o1nxT8I5R5pUeHXQOHuvvMaw==
X-Google-Smtp-Source: ABdhPJxNI0XzDYJEcld97bpEE3r3fX0uX6RXWm8xF6ug6VChx9utYQKThX8aQ9xukWdbbu6fQJxRGg==
X-Received: by 2002:a9d:2c22:: with SMTP id f31mr3636211otb.303.1632982846503;
        Wed, 29 Sep 2021 23:20:46 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id x4sm421228otq.25.2021.09.29.23.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 23:20:46 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, dhobsong@igel.co.jp, taki@igel.co.jp,
        etom@igel.co.jp
Subject: [RFC PATCH v2 1/1] Providers/rxe: Add dma-buf support
Date:   Thu, 30 Sep 2021 15:20:14 +0900
Message-Id: <20210930062014.38200-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210930062014.38200-1-mie@igel.co.jp>
References: <20210930062014.38200-1-mie@igel.co.jp>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement a new provider method for dma-buf base memory registration.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 providers/rxe/rxe.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3c3ea8bb..84e00e60 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -239,6 +239,26 @@ static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	return &vmr->ibv_mr;
 }
 
+static struct ibv_mr *rxe_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset,
+					size_t length, uint64_t iova, int fd,
+					int access)
+{
+	struct verbs_mr *vmr;
+	int ret;
+
+	vmr = malloc(sizeof(*vmr));
+	if (!vmr)
+		return NULL;
+
+	ret = ibv_cmd_reg_dmabuf_mr(pd, offset, length, iova, fd, access, vmr);
+	if (ret) {
+		free(vmr);
+		return NULL;
+	}
+
+	return &vmr->ibv_mr;
+}
+
 static int rxe_dereg_mr(struct verbs_mr *vmr)
 {
 	int ret;
@@ -1706,6 +1726,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.alloc_pd = rxe_alloc_pd,
 	.dealloc_pd = rxe_dealloc_pd,
 	.reg_mr = rxe_reg_mr,
+	.reg_dmabuf_mr = rxe_reg_dmabuf_mr,
 	.dereg_mr = rxe_dereg_mr,
 	.alloc_mw = rxe_alloc_mw,
 	.dealloc_mw = rxe_dealloc_mw,
-- 
2.17.1

