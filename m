Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBBF1A25FF
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2020 17:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgDHPro (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Apr 2020 11:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbgDHPqd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A06372078E;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=dzEvyUMT+6iAL0bVATxxLcY08y7xtxW1DkpC2XHSTsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSAqqCvgTqXa/uXKmv6EtznA69C4V8DH+7tAiOQNLcwtHbDUgP+TAlPo8teTWKDnM
         dC8jqt6R8V70H20R2xBLozYWzJEo+P1t5Z0t4qINbz+1i1Q9o/HBEt19GSNv210olW
         4Dzs/4ExuoIJYGl5mAM8SIJF6Fw0DUiAD8BAIus8=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBm-QI; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 19/35] docs: infiniband: verbs.c: fix some documentation warnings
Date:   Wed,  8 Apr 2020 17:46:11 +0200
Message-Id: <9f9212db13dc19e5d80e3fc94ad26f3b9798d154.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Parsing this file with kernel-doc produce some warnings:

	./drivers/infiniband/core/verbs.c:2579: WARNING: Unexpected indentation.
	./drivers/infiniband/core/verbs.c:2581: WARNING: Block quote ends without a blank line; unexpected unindent.
	./drivers/infiniband/core/verbs.c:2613: WARNING: Unexpected indentation.
	./drivers/infiniband/core/verbs.c:2579: WARNING: Unexpected indentation.
	./drivers/infiniband/core/verbs.c:2581: WARNING: Block quote ends without a blank line; unexpected unindent.
	./drivers/infiniband/core/verbs.c:2613: WARNING: Unexpected indentation.

Address them by adding an extra blank line and converting the
parameters on one of the arguments to a table.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/infiniband/core/verbs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 56a71337112c..3bfadd8effcc 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2574,6 +2574,7 @@ EXPORT_SYMBOL(ib_map_mr_sg_pi);
  * @page_size:     page vector desired page size
  *
  * Constraints:
+ *
  * - The first sg element is allowed to have an offset.
  * - Each sg element must either be aligned to page_size or virtually
  *   contiguous to the previous element. In case an sg element has a
@@ -2607,10 +2608,12 @@ EXPORT_SYMBOL(ib_map_mr_sg);
  * @mr:            memory region
  * @sgl:           dma mapped scatterlist
  * @sg_nents:      number of entries in sg
- * @sg_offset_p:   IN:  start offset in bytes into sg
- *                 OUT: offset in bytes for element n of the sg of the first
+ * @sg_offset_p:   ==== =======================================================
+ *                 IN   start offset in bytes into sg
+ *                 OUT  offset in bytes for element n of the sg of the first
  *                      byte that has not been processed where n is the return
  *                      value of this function.
+ *                 ==== =======================================================
  * @set_page:      driver page assignment function pointer
  *
  * Core service helper for drivers to convert the largest
-- 
2.25.2

