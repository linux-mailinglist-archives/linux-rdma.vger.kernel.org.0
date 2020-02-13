Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4C815B6BF
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 02:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgBMBeV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 20:34:21 -0500
Received: from gateway30.websitewelcome.com ([50.116.127.1]:18797 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729289AbgBMBeV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 20:34:21 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 57B4EFE74
        for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2020 19:13:02 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 233ujCeXHAGTX233ujOn70; Wed, 12 Feb 2020 19:13:02 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UeniUbGWJBBT0KfdU4Phj7oirIhMUxWtMEICDs+UUbc=; b=luWkpuZOAHOBeP3hzt9+2sVjY9
        Oh99k4/astn8cTmIvl9lR+TsyG2zn9Pc4E0iBcaSHkL4s/PYbz+h/DJX5gxngBuKrY+TOb5N3q0JI
        z1TBwOvGnDASVVuqgwySR/FaQpUUaT+MmLlmxyN5ceIr2zQOMz14XD2ud9w+5K/dGahj8SERJdYyU
        w3muOr+obfgZsuq4lU6bKZoxc8nukhue4zzo0nH4ng+pBTGNqsIOj5qqIYyr29CBsGDhvyHzVL5qn
        kFmEgokbxNymlJtV38eQShXh9gppnz79twb12YIsaEYl5/zX8zt4WO1vjJQHDBRKyroCU5fp7PdNB
        F1/tOpGQ==;
Received: from [200.68.141.42] (port=27417 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j233s-003yhS-91; Wed, 12 Feb 2020 19:13:00 -0600
Date:   Wed, 12 Feb 2020 19:12:58 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] IB/multicast: Replace zero-length array with flexible-array
 member
Message-ID: <20200213011258.GA14874@embeddedor.com>
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
X-Exim-ID: 1j233s-003yhS-91
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.42]:27417
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
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
 drivers/infiniband/core/multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.23.0

