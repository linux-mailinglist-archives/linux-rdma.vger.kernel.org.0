Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F74A2AE1B1
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Nov 2020 22:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgKJV1b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Nov 2020 16:27:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:54360 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKJV1b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Nov 2020 16:27:31 -0500
IronPort-SDR: X7l/6yL+iYfOtULxEnI8xjcFurdeC/VLNl5a4usAGbsP4RWKCVTm7eVoFfMCmTdQ8fyIGqlxk7
 XI5/8GosSTGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="254762136"
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="254762136"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 13:27:29 -0800
IronPort-SDR: w1t2RCjaEkKMe8h2hPQdsApSLGj/vp5wtGdQhWZqToBmPn6tcu6Umf457wAMIMgfV8mG482reb
 +HyeXEwvfOag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="541500549"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga005.jf.intel.com with ESMTP; 10 Nov 2020 13:27:28 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH v10 5/6] dma-buf: Reject attach request from importers that use dma_virt_ops
Date:   Tue, 10 Nov 2020 13:41:16 -0800
Message-Id: <1605044477-51833-6-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
References: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

dma_virt_ops is used by virtual devices that map pages / scatterlists to
virtual addresses for CPU access instead of performing DMA. This is not
the intended use of dma_buf_attach() and dma_buf_map_attachment(). CPU
access of dma-buf should use dma_buf_vmap() and related functions.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
---
 drivers/dma-buf/dma-buf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 9a054fb5..ba2b877 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -686,6 +686,11 @@ struct dma_buf_attachment *
 	if (WARN_ON(importer_ops && !importer_ops->move_notify))
 		return ERR_PTR(-EINVAL);
 
+#ifdef CONFIG_DMA_VIRT_OPS
+	if (dev->dma_ops == &dma_virt_ops)
+		return ERR_PTR(-EINVAL);
+#endif
+
 	attach = kzalloc(sizeof(*attach), GFP_KERNEL);
 	if (!attach)
 		return ERR_PTR(-ENOMEM);
-- 
1.8.3.1

