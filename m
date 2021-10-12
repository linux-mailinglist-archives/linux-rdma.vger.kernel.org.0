Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A9A42A3F6
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 14:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhJLMLf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 08:11:35 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:53355 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbhJLMLe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Oct 2021 08:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1634040574; x=1665576574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DH/iEl6RdpnlT684JdFoMTd6lB/TOY1gGLwBRIAkw2M=;
  b=p3Kce6p3zFM7e/et/XDvM1GptQy3D5+lyDIjE+LUI1FlUx1G7YuPJsEM
   lUa/Rq1PSlKXM68CPDSEExteQoDFehBg88OruQ/csVE81c8XbH8R41/3a
   0ekuQwBkGXTW7YyJBuPV9/LjqzpvqaQG+gULn5asNUqn+ZI7ZCy4OKogA
   4=;
X-IronPort-AV: E=Sophos;i="5.85,367,1624320000"; 
   d="scan'208";a="153045402"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 12 Oct 2021 12:09:25 +0000
Received: from EX13D13EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com (Postfix) with ESMTPS id 6D5C2C08C4;
        Tue, 12 Oct 2021 12:09:21 +0000 (UTC)
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13EUB003.ant.amazon.com (10.43.166.55) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Tue, 12 Oct 2021 12:09:20 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.212.21) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Tue, 12 Oct 2021 12:09:16 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Firas Jahjah <firasj@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 1/3] dma-buf: Fix pin callback comment
Date:   Tue, 12 Oct 2021 15:09:01 +0300
Message-ID: <20211012120903.96933-2-galpress@amazon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012120903.96933-1-galpress@amazon.com>
References: <20211012120903.96933-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pin callback does not necessarily have to move the memory to system
memory, remove the sentence from the comment.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 include/linux/dma-buf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index efdc56b9d95f..225e09caeb98 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -86,8 +86,8 @@ struct dma_buf_ops {
 	 * @pin:
 	 *
 	 * This is called by dma_buf_pin() and lets the exporter know that the
-	 * DMA-buf can't be moved any more. The exporter should pin the buffer
-	 * into system memory to make sure it is generally accessible by other
+	 * DMA-buf can't be moved any more. Ideally, the exporter should
+	 * pin the buffer so that it is generally accessible by all
 	 * devices.
 	 *
 	 * This is called with the &dmabuf.resv object locked and is mutual
-- 
2.33.0

