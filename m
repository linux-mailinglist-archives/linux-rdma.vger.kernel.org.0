Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702B82AC4AB
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Nov 2020 20:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgKITJS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Nov 2020 14:09:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:46851 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgKITJS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Nov 2020 14:09:18 -0500
IronPort-SDR: /TJuhfovSh1s4Vwu/VlKKJrKY/ioPe/OV+u4UVteziXzbxA57D/4z1T1nqT0cWRkMPCur8TMbU
 MriWuk8a22wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="234021169"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="234021169"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 11:09:12 -0800
IronPort-SDR: XniuvPadEvO05b5r0EfhCtbwkxIRmNx1RHP8ILdHHGPLXWnqEfAUQAwxv2orW0hIrWGmChJaGd
 7KoQbTV8lm8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="365175188"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Nov 2020 11:09:11 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH v9 5/5] dma-buf: Reject attach request from importers that use dma_virt_ops
Date:   Mon,  9 Nov 2020 11:23:01 -0800
Message-Id: <1604949781-20735-6-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604949781-20735-1-git-send-email-jianxin.xiong@intel.com>
References: <1604949781-20735-1-git-send-email-jianxin.xiong@intel.com>
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

