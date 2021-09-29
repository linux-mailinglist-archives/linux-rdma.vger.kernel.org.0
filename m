Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D43541BDEA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 06:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbhI2EVM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 00:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbhI2EVI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Sep 2021 00:21:08 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861DC061755
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 21:19:28 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s69so1262347oie.13
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 21:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r3BsV1GTEqKXRyiYvYJGLvk2Pn1r3f4nsDFd9biBydc=;
        b=yQhoCHSc2QmeXBNruKP7ofAeqKwXabtEQcqWyz1YFuL5HRasrZUXf/07QWDq2jfE/i
         rf3eib1kC/fm8Exz4aooPYGC2Z+2M6L9AGo7JkLSe5tIR8EtXzDOdqNdX5/IMrbPXLxN
         GoKr9HETaWP19B0FuaGOj35nuxIIlM2L46h3yl2ir70nEwQ7pAFSRjQD0x0MftQMqqyG
         21mUAr1FncdJgxXIfPaZ5dkqaHCWpL0FeGQJKZrIzeeBkAgFoX4PIYqwOla5k03Vc084
         dHkygsOf8gGQmUBJ9Y2FJ3Flqdl6tj0VSRo+hSejWGiQOkJYas40OeFNT541sUmMAtY9
         VycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r3BsV1GTEqKXRyiYvYJGLvk2Pn1r3f4nsDFd9biBydc=;
        b=k1oT4Sn9t/mMt6oKERj62tV+L1G6Q3r0lKmESwA5ssgpjOYHKrCPaqte/QyiaC1+j6
         oMrqm7LWxr5qcBNBT5RqTZj9CKpIbxrcCyK1zDIXitNtkAAFCk288oc/keE/w+tzCtWU
         0Hk4sI6+hHzMiE2fEQB35DvVYMsBNa3S9QOEHZswcBuMK0jAC8eZqsmsIyA8ed9fa0Tr
         kK3TeI5AQAanJmL/0Q/DszGvlYa8aQjt/QLbccXeI10xqAta0JgsWgY/MiLQNMhzJiCk
         aqHBnajaxi0mt0zYEYQlDjwwE+Axl7D2YYNWI8zezcUMqE9erN2O6s3TVS3dBjtMKbD3
         UgUQ==
X-Gm-Message-State: AOAM533o7T0aYkMyyhWgl55tlO5o7JbvJF46wXt94LR3yiICOsmjtZyr
        lcbZyksT3w2RvHbMt+7IlOXx1w==
X-Google-Smtp-Source: ABdhPJwzsEOaAz8FEYD/FCGvQDiTqfuGHJVDEOeGeJfBiOFJp+9FcqX2X2S2s/laF7R43xWlcO8G5g==
X-Received: by 2002:a05:6808:1a11:: with SMTP id bk17mr6539822oib.0.1632889167751;
        Tue, 28 Sep 2021 21:19:27 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p2sm240861ooe.34.2021.09.28.21.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 21:19:27 -0700 (PDT)
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
Subject: [RFC PATCH v2 1/2] RDMA/umem: Change for rdma devices has not dma device
Date:   Wed, 29 Sep 2021 13:19:04 +0900
Message-Id: <20210929041905.126454-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929041905.126454-1-mie@igel.co.jp>
References: <20210929041905.126454-1-mie@igel.co.jp>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Current implementation requires a dma device for RDMA driver to use
dma-buf memory space as RDMA buffer. However, software RDMA drivers has
not dma device and copy RDMA data using CPU instead of hardware.

This patch changes to be hold a dma-buf on struct ib_umem_dmabuf. This
allows the software RDMA driver to map dma-buf memory for CPU memory
accessing.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/infiniband/core/umem_dmabuf.c | 20 ++++++++++++++++----
 include/rdma/ib_umem.h                |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index e824baf4640d..ebbb0a259fd4 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -117,9 +117,6 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
 	if (check_add_overflow(offset, (unsigned long)size, &end))
 		return ret;
 
-	if (unlikely(!ops || !ops->move_notify))
-		return ret;
-
 	dmabuf = dma_buf_get(fd);
 	if (IS_ERR(dmabuf))
 		return ERR_CAST(dmabuf);
@@ -133,6 +130,8 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
 		goto out_release_dmabuf;
 	}
 
+	umem_dmabuf->dmabuf = dmabuf;
+
 	umem = &umem_dmabuf->umem;
 	umem->ibdev = device;
 	umem->length = size;
@@ -143,6 +142,13 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
 	if (!ib_umem_num_pages(umem))
 		goto out_free_umem;
 
+	/* Software RDMA drivers has not dma device. Just get dmabuf from fd */
+	if (!device->dma_device)
+		goto done;
+
+	if (unlikely(!ops || !ops->move_notify))
+		goto out_free_umem;
+
 	umem_dmabuf->attach = dma_buf_dynamic_attach(
 					dmabuf,
 					device->dma_device,
@@ -152,6 +158,7 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
 		ret = ERR_CAST(umem_dmabuf->attach);
 		goto out_free_umem;
 	}
+done:
 	return umem_dmabuf;
 
 out_free_umem:
@@ -165,13 +172,18 @@ EXPORT_SYMBOL(ib_umem_dmabuf_get);
 
 void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf)
 {
-	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
+	struct dma_buf *dmabuf = umem_dmabuf->dmabuf;
+
+	if (!umem_dmabuf->attach)
+		goto free_dmabuf;
 
 	dma_resv_lock(dmabuf->resv, NULL);
 	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
 	dma_resv_unlock(dmabuf->resv);
 
 	dma_buf_detach(dmabuf, umem_dmabuf->attach);
+
+free_dmabuf:
 	dma_buf_put(dmabuf);
 	kfree(umem_dmabuf);
 }
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 5ae9dff74dac..11c0cf7e0dd8 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -32,6 +32,7 @@ struct ib_umem {
 struct ib_umem_dmabuf {
 	struct ib_umem umem;
 	struct dma_buf_attachment *attach;
+	struct dma_buf *dmabuf;
 	struct sg_table *sgt;
 	struct scatterlist *first_sg;
 	struct scatterlist *last_sg;
-- 
2.17.1

