Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621D02AE1B3
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Nov 2020 22:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKJV1c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Nov 2020 16:27:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:54360 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731657AbgKJV1b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Nov 2020 16:27:31 -0500
IronPort-SDR: 28+EG9fki/VjzvlzwIC0cqUZkAb2njzM0356+kBAuUlIwBmsFciAIRioJNC5TbJLkV8/vW6HmE
 fm8xE9v7vp/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="254762137"
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="254762137"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 13:27:29 -0800
IronPort-SDR: 0NS6aqzbuIqjlXBVxN7ajmtLstwKmkSe/I+jNmp4B05cgZBS6lE5JvIRmrlc7sL+cjw6uo8Fxq
 KGoGPbSHX2dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="541500552"
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
Subject: [PATCH v10 6/6] dma-buf: Document that dma-buf size is fixed
Date:   Tue, 10 Nov 2020 13:41:17 -0800
Message-Id: <1605044477-51833-7-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
References: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The fact that the size of dma-buf is invariant over the lifetime of the
buffer is mentioned in the comment of 'dma_buf_ops.mmap', but is not
documented at where the info is defined. Add the missing documentation.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
---
 include/linux/dma-buf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 9dcd569..92da98b 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -272,7 +272,7 @@ struct dma_buf_ops {
 
 /**
  * struct dma_buf - shared buffer object
- * @size: size of the buffer
+ * @size: size of the buffer; invariant over the lifetime of the buffer.
  * @file: file pointer used for sharing buffers across, and for refcounting.
  * @attachments: list of dma_buf_attachment that denotes all devices attached,
  *               protected by dma_resv lock.
@@ -404,7 +404,7 @@ struct dma_buf_attachment {
  * @exp_name:	name of the exporter - useful for debugging.
  * @owner:	pointer to exporter module - used for refcounting kernel module
  * @ops:	Attach allocator-defined dma buf ops to the new buffer
- * @size:	Size of the buffer
+ * @size:	Size of the buffer - invariant over the lifetime of the buffer
  * @flags:	mode flags for the file
  * @resv:	reservation-object, NULL to allocate default one
  * @priv:	Attach private data of allocator to this buffer
-- 
1.8.3.1

