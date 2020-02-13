Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B91915B6DC
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 02:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgBMBtn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 20:49:43 -0500
Received: from gateway36.websitewelcome.com ([192.185.200.11]:40360 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729333AbgBMBtn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 20:49:43 -0500
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 20:49:42 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 2EAD8406C7CF1
        for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2020 18:18:34 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 22vejj15rSl8q22vejRhdr; Wed, 12 Feb 2020 19:04:30 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X7WylZBkBTQybAsfKQELLh8OusJwNVnNJjq/8R6vA0w=; b=aT/3iMtenf4x2jr8f+I4mCY8Gx
        13AbKBGk/YTG2nN4BgUkFFFPRD8dqSwfLktlFOZKqocD7EgvZT+auwCWDpipsDzMB2Nci2qHLgLAe
        n234VBlMlcKBKyKfQ6AfAs1/Tf7oXegGtqsTKQlqwpbInfuPOUQhdYaXNeZVYVMeSneGJvMG0gM4w
        vzwBk9Q4rJ+F2YkVEQFxFH8bsQixd7om10815zfRH+d0BGboAVyZjmAd3YcCp+OzVDjgcGFlQMkBd
        Iv5u8LoaTIU8JBtPj9cwVwtXcBV2pEkVYiFPsTdTy/hBBSZLavO8pkipa/aaMfyBmqBMz/xmU4Xsm
        jb7kk9eQ==;
Received: from [200.68.141.42] (port=2871 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j22vc-003uuH-E1; Wed, 12 Feb 2020 19:04:28 -0600
Date:   Wed, 12 Feb 2020 19:04:25 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] IB/core, cache: Replace zero-length array with
 flexible-array member
Message-ID: <20200213010425.GA13068@embeddedor.com>
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
X-Exim-ID: 1j22vc-003uuH-E1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.42]:2871
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
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
 drivers/infiniband/core/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 17bfedd24cc3..dedfbe27916f 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -46,7 +46,7 @@
 
 struct ib_pkey_cache {
 	int             table_len;
-	u16             table[0];
+	u16             table[];
 };
 
 struct ib_update_work {
-- 
2.23.0

