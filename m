Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C055E1967A3
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgC1Qna (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 12:43:30 -0400
Received: from mx.sdf.org ([205.166.94.20]:50065 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbgC1Qna (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:30 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGh7mA016099
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:08 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGh78v026162;
        Sat, 28 Mar 2020 16:43:07 GMT
Message-Id: <202003281643.02SGh78v026162@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Fri, 29 Nov 2019 17:42:15 -0500
Subject: [RFC PATCH v1 05/50] net/rds/bind.c: Use prandom_u32_max()
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

max_t(u16, prandom_u32(), 2) generates 2 three times as often as
any other value.  Operating modulo 65534 improves uniformity.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: linux-rdma@vger.kernel.org
Cc: rds-devel@oss.oracle.com
---
 net/rds/bind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/bind.c b/net/rds/bind.c
index 5b5fb4ca8d3e5..8293044767b83 100644
--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -104,7 +104,7 @@ static int rds_add_bound(struct rds_sock *rs, const struct in6_addr *addr,
 			return -EINVAL;
 		last = rover;
 	} else {
-		rover = max_t(u16, prandom_u32(), 2);
+		rover = 2 + prandom_u32_max(65534);
 		last = rover - 1;
 	}
 
-- 
2.26.0

