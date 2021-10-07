Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829CB425157
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbhJGKpa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 06:45:30 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:62696 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbhJGKpa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 06:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1633603417; x=1665139417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2ZVLg4Jy7B6SNUP9NZf09cgn6Nym/KNFycKDss4WsM=;
  b=gYw+BbLoAnxipWJgd2nc/NZuZMD92XWwQelDC1DhRTVIcvmaWJ85R2Sy
   MwkDgQlqUeeQg8N2se2uavskOch6tVuiP0Zw7AIbkDYXP/oOnIeGnKG7Y
   mpRwTd+oi+dktG9PfcsXGCaMvJ8dKCV+KwsO+rjICRpyB1tD+KQWGQREl
   s=;
X-IronPort-AV: E=Sophos;i="5.85,354,1624320000"; 
   d="scan'208";a="146048507"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 07 Oct 2021 10:43:26 +0000
Received: from EX13D13EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com (Postfix) with ESMTPS id 30681415A8;
        Thu,  7 Oct 2021 10:43:25 +0000 (UTC)
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13EUA002.ant.amazon.com (10.43.165.18) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 7 Oct 2021 10:43:23 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.213.27) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Thu, 7 Oct 2021 10:43:17 +0000
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
Subject: [RFC PATCH 1/2] dma-buf: Fix pin callback comment
Date:   Thu, 7 Oct 2021 13:42:59 +0300
Message-ID: <20211007104301.76693-2-galpress@amazon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007104301.76693-1-galpress@amazon.com>
References: <20211007104301.76693-1-galpress@amazon.com>
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
 include/linux/dma-buf.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index efdc56b9d95f..93830731a9a3 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -86,9 +86,7 @@ struct dma_buf_ops {
 	 * @pin:
 	 *
 	 * This is called by dma_buf_pin() and lets the exporter know that the
-	 * DMA-buf can't be moved any more. The exporter should pin the buffer
-	 * into system memory to make sure it is generally accessible by other
-	 * devices.
+	 * DMA-buf can't be moved any more.
 	 *
 	 * This is called with the &dmabuf.resv object locked and is mutual
 	 * exclusive with @cache_sgt_mapping.
-- 
2.33.0

