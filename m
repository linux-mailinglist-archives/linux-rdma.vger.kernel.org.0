Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE3449AE9C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 09:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452668AbiAYIwS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 03:52:18 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36081 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1379440AbiAYItA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 03:49:00 -0500
IronPort-Data: =?us-ascii?q?A9a23=3APsRfMqjD06gg8s80yNMz3INNX161bxEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUPxmYbXD3SPP6PNDSnLdhyOYjloUpQvZDWytVqTANuqnw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUbS?=
 =?us-ascii?q?ZYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14NFMp5yxS?=
 =?us-ascii?q?wYgOIXCheYcTwJFVSp5OMWq/ZeeeyDv6p3IkBaun3zEhq8G4FsNFZcA9+9tGmZ?=
 =?us-ascii?q?I9eQVAD8IZxGHwemxxdqTWPhulNUhdpGzZKsQv3hhyXfSCvNOaZTCSqPF+tJex?=
 =?us-ascii?q?Do2iehOAP/BastfYj1qBDzMahsJOBEICZY6ne6tnVH+dSFVrBSeoq9fy3TUyQV?=
 =?us-ascii?q?qwv7iKt3Qc9CYRsR9n0CEq2aA9GP8ajkeOduZ4TmI6HShgqnIhyyTcIsSHae/8?=
 =?us-ascii?q?PpChkOSym0aThYRUDOTpPO9jUW+c9RBKkAV82wlqq1a3FCsS/HhVhmgrW/CtRk?=
 =?us-ascii?q?ZM/JUEusn+ESOx7DS7gKxGGcJVHhCZcYguctwQiYlvneNntX0FXl1vLicYWyS+?=
 =?us-ascii?q?63Srj6oPyURa2gYakcsTwQKy8virZk+yBnGJuuPuobdYsbdQGm2mm7V6nNlweh?=
 =?us-ascii?q?7sCLC7I3jlXivvt5mjsShotYJ2zjq?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AECNPFa9lIFVl9OBpiVpuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,314,1635177600"; 
   d="scan'208";a="120839373"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jan 2022 16:44:32 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8F9FE4D15A5C;
        Tue, 25 Jan 2022 16:44:30 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 25 Jan 2022 16:44:30 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 25 Jan 2022 16:44:27 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH v2 5/9] RDMA/rxe: Set BTH's SE to zero for FLUSH packet
Date:   Tue, 25 Jan 2022 16:50:37 +0800
Message-ID: <20220125085041.49175-6-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
References: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8F9FE4D15A5C.AF2B6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The SPEC says:
oA19-6: FLUSH BTH header field solicited event (SE) indication shall be
set to zero.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
V2: said -> says
---
 drivers/infiniband/sw/rxe/rxe_req.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 708138117136..363a33b905bf 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -401,7 +401,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 			(pkt->mask & RXE_END_MASK) &&
 			((pkt->mask & (RXE_SEND_MASK)) ||
 			(pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
-			(RXE_WRITE_MASK | RXE_IMMDT_MASK));
+			(RXE_WRITE_MASK | RXE_IMMDT_MASK)) &&
+			/* oA19-6: always set SE to zero */
+			!(pkt->mask & RXE_FETH_MASK);
 
 	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
 					 qp->attr.dest_qp_num;
-- 
2.31.1



