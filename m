Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7535D153D2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 20:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfEFSqk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 14:46:40 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:24075 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfEFSqj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 14:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557168399; x=1588704399;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=xsGBPZlIne63Ytr231ws6wJgXFwY/WEd6QZ4UcBmXeU=;
  b=RUnQ0bhvH5aN40boUAzqEfovO5mxKeDTm9bAs1CN7XlUZrF8wdhvnyfa
   ZTGiitoN38D1qFbkb82FsurvrXeoA1n9ET9QksLiyGgdDrFiPEgVM9QdA
   VUPLyWQd42frUKLFrA4oKWsZCkMTbJ+uwzvWKh9v5J7wrT1yb4fl+QOrg
   4=;
X-IronPort-AV: E=Sophos;i="5.60,439,1549929600"; 
   d="scan'208";a="798158296"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 May 2019 18:46:37 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x46IkZXv031692
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 6 May 2019 18:46:37 GMT
Received: from EX13D19EUA003.ant.amazon.com (10.43.165.175) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 6 May 2019 18:46:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 6 May 2019 18:46:35 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.85.92.236) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 6 May 2019 18:46:29 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
Subject: [RESEND PATCH v2] lib/scatterlist: Remove leftover from sg_page_iter comment
Date:   Mon, 6 May 2019 18:02:56 +0300
Message-ID: <1557154976-8070-1-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit d901b2760dc6 ("lib/scatterlist: Provide a DMA page iterator")
added the sg DMA iterator but a leftover remained in the sg_page_iter
documentation as you cannot get the page dma address (only the page
itself), fix it.

Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
---
This patch was sent twice to linux-kernel list with no response, I'm sending it
to the rdma list as that's where the cited patch was sent to.

Changelog:
v1->v2:
* Reword commit message
---
 include/linux/scatterlist.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index b4be960c7e5d..30a9a55c28ba 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -340,11 +340,11 @@ int sg_alloc_table_chained(struct sg_table *table, int nents,
  * sg page iterator
  *
  * Iterates over sg entries page-by-page.  On each successful iteration, you
- * can call sg_page_iter_page(@piter) to get the current page and its dma
- * address. @piter->sg will point to the sg holding this page and
- * @piter->sg_pgoffset to the page's page offset within the sg. The iteration
- * will stop either when a maximum number of sg entries was reached or a
- * terminating sg (sg_last(sg) == true) was reached.
+ * can call sg_page_iter_page(@piter) to get the current page.
+ * @piter->sg will point to the sg holding this page and @piter->sg_pgoffset to
+ * the page's page offset within the sg. The iteration will stop either when a
+ * maximum number of sg entries was reached or a terminating sg
+ * (sg_last(sg) == true) was reached.
  */
 struct sg_page_iter {
 	struct scatterlist	*sg;		/* sg holding the page */
-- 
2.7.4

