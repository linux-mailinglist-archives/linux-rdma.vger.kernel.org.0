Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254981C99C0
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 20:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgEGStQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 14:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgEGStQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 14:49:16 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456A724955;
        Thu,  7 May 2020 18:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877355;
        bh=3zqkOg25IOb4epiOZLlDxGqlvC/e+9jul0mU4G1ZBWg=;
        h=Date:From:To:Cc:Subject:From;
        b=pDveR0FQ+qhDTp7BEwzmuNKuZ64tFbpTfedYqemjhpWjTVws9B5xp5nw6XobhKWIz
         9wVzylCa7ldLNXFTWxpqVaeAte4AvYrLll9Hk8dZ3T+TXW/cHeloK6kTwEJPK1W3Hb
         TOqRjRYKMElxAUGVJ+sLVx4wuVoR0O+T8vLmCLH4=
Date:   Thu, 7 May 2020 13:53:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/rdmavt: Replace zero-length array with flexible-array
Message-ID: <20200507185342.GA14476@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/rdma/rdmavt_qp.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 5fc10108703a..982bf2340840 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -440,7 +440,7 @@ struct rvt_qp {
 	/*
 	 * This sge list MUST be last. Do not add anything below here.
 	 */
-	struct rvt_sge r_sg_list[0] /* verified SGEs */
+	struct rvt_sge r_sg_list[] /* verified SGEs */
 		____cacheline_aligned_in_smp;
 };
 

