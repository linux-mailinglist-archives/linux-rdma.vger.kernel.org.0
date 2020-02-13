Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0CA15CAD3
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 19:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgBMS7L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 13:59:11 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.202]:36908 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbgBMS7L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Feb 2020 13:59:11 -0500
X-Greylist: delayed 1465 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 13:59:10 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 60E2312C2B7
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 12:34:45 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 2JK0j1NvQSl8q2JK1jjpCr; Thu, 13 Feb 2020 12:34:45 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+18p4uN9DK6dRKJWk5cR9EvFxREWiKNZQXUu8xY4YP0=; b=gtG1qJTtH1YieKQThWW4u0Ri6p
        YtfZtnun87pbLIu1YGRozG6O2Ubk4vVKRNAgnex4QoyFI974320vwKGYZ+NuQzPxpBgrOnqwUqDOE
        ZihyrJ9j1tQlatdhd3LdpoAYahtOuHlCqzR5Tocg+Ylgxo0FbSK1Ev/PPUA73bMX8OZzUX6i8/Fgz
        NKJG1CCMMyIfEjYGT7SG8FPVWZlSvutvMhNLI2X/rWvauQhXQl6kJTUBTwNAllBT43cR3rbUXDrqc
        Krc9c0qhe8ImxnjOgqL1kdTNUpMVQM1KqQEcis4UmssbPg1LI7g3FSFKlXvzJ3kSY9u9kvCVGsYC6
        Xc5Rk97A==;
Received: from [200.68.140.15] (port=6289 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j2JJv-000X97-0B; Thu, 13 Feb 2020 12:34:39 -0600
Date:   Thu, 13 Feb 2020 12:37:15 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] IB/core: Replace zero-length array with flexible-array member
Message-ID: <20200213183715.GA19636@embeddedor>
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
X-Source-IP: 200.68.140.15
X-Source-L: No
X-Exim-ID: 1j2JJv-000X97-0B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.15]:6289
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
 drivers/infiniband/core/cache.c     | 2 +-
 drivers/infiniband/core/cm.c        | 4 ++--
 drivers/infiniband/core/multicast.c | 2 +-
 drivers/infiniband/core/sa_query.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

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
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 68cc1b2d6824..8424abe83607 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -197,7 +197,7 @@ struct cm_device {
 	struct ib_device *ib_device;
 	u8 ack_delay;
 	int going_down;
-	struct cm_port *port[0];
+	struct cm_port *port[];
 };
 
 struct cm_av {
@@ -216,7 +216,7 @@ struct cm_work {
 	__be32 local_id;			/* Established / timewait */
 	__be32 remote_id;
 	struct ib_cm_event cm_event;
-	struct sa_path_rec path[0];
+	struct sa_path_rec path[];
 };
 
 struct cm_timewait_info {
diff --git a/drivers/infiniband/core/multicast.c b/drivers/infiniband/core/multicast.c
index cd338ddc4a39..9c2d8b7f1af9 100644
--- a/drivers/infiniband/core/multicast.c
+++ b/drivers/infiniband/core/multicast.c
@@ -71,7 +71,7 @@ struct mcast_device {
 	struct ib_event_handler	event_handler;
 	int			start_port;
 	int			end_port;
-	struct mcast_port	port[0];
+	struct mcast_port	port[];
 };
 
 enum mcast_state {
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 30d4c126a2db..74e0058fcf9e 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -101,7 +101,7 @@ struct ib_sa_port {
 struct ib_sa_device {
 	int                     start_port, end_port;
 	struct ib_event_handler event_handler;
-	struct ib_sa_port port[0];
+	struct ib_sa_port port[];
 };
 
 struct ib_sa_query {
-- 
2.25.0

