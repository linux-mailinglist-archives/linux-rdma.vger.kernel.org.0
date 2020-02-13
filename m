Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE6E15B6B3
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 02:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgBMB3V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 20:29:21 -0500
Received: from gateway30.websitewelcome.com ([50.116.127.1]:49161 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729302AbgBMB3V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 20:29:21 -0500
X-Greylist: delayed 1223 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 20:29:20 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 9391B16E9
        for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2020 19:08:56 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 22zwjnqnxXVkQ22zwjBveb; Wed, 12 Feb 2020 19:08:56 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PMxecW0O4tdkPXbZnFnlCU+Xv/vOEnBfFdnNrRCVmMY=; b=eOm+ryRMFshQWqZPIC5nzWTTT5
        NYoy8rPeuv9a+ALZXbLX093SJAZ7PHUep51y+OiKUbRHVffzTUEuFCEghnYGxhLmg5RY2OFFnaOmL
        Q5M+ciExfhUxzrfxCHyWREyePfOVRow6KUMW3jf++JiOA6NPmaRt54E1+iCGi//eN+CoR99x5nVzZ
        NwxHdNjayqX2GaQowodt1xZC18NLo83cMYTiwZRn4w1ao0CSxkv6Rcceop08O20iUwXmekl8Kw3jA
        wnYPisO9q7kfqNUNw8iRWy9pzzpUQqWBAOWecchmWn9zHHAwFbhsKGTinfTHQZd3j7NaK5Vek30zU
        0ZHq9YcQ==;
Received: from [200.68.141.42] (port=11053 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j22zu-003wxD-Mk; Wed, 12 Feb 2020 19:08:55 -0600
Date:   Wed, 12 Feb 2020 19:08:51 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] IB/mthca: Replace zero-length array with flexible-array
 member
Message-ID: <20200213010851.GA13977@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.141.42
X-Source-L: No
X-Exim-ID: 1j22zu-003wxD-Mk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.42]:11053
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/hw/mthca/mthca_memfree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
index 78a48aea3faf..dc10376f09cb 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
@@ -58,7 +58,7 @@ struct mthca_user_db_table {
 		u64                uvirt;
 		struct scatterlist mem;
 		int                refcount;
-	}                page[0];
+	} page[];
 };
 
 static void mthca_free_icm_pages(struct mthca_dev *dev, struct mthca_icm_chunk *chunk)
-- 
2.23.0

