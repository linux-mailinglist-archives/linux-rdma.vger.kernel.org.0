Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3F476C1D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Dec 2021 09:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhLPIoe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 03:44:34 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:21443 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229539AbhLPIoe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Dec 2021 03:44:34 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AghyTsKuAycabnUMOTc9NlO09OufnVI9cMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3yjAbCDyAOPiNZzf8Ld4jOYW08xtTsMCEmNYxS1M//y9gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuClUbS?=
 =?us-ascii?q?dZHgoLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1JtI6wS?=
 =?us-ascii?q?AUoN6vklvkfUgVDDmd1OqguFLrveCHu6ZTIkBafG5fr67A0ZK0sBqUK6+RlEGM?=
 =?us-ascii?q?UraRAAD8IZxGHwemxxdqTTuhqm9RmL8TxOo4bkm9vwCufDvs8R53HBaLQ6rdw2?=
 =?us-ascii?q?DY2m9ALB/rbbuIHZjd1KhfNeRtCPhEQEp1WtOWniVHtcjBApRSerMIKD8L7pOB?=
 =?us-ascii?q?q+OG1doOLJZrRHoMI9nt0b1nupwzRaiz2/vTGodZdzk+Ruw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AQPNZ3aE5jUy7VCHbpLqEAseALOsnbusQ8zAX?=
 =?us-ascii?q?P0AYc31om6uj5qeTdZUgpHnJYVkqKRIdcLy7V5VoIkmskaKdg7NhX4tKNTOO0A?=
 =?us-ascii?q?DDQe1fBODZowEIdReRygck79YET0FhMqyLMXFKydb9/BKjE8sthP2O8KWTj+/Y?=
 =?us-ascii?q?yHt3JDsaE51I3kNoDBqBCE1qSE1jDZo9LpCV4c1KvH6OYnISB/7LfUUtbqzSoc?=
 =?us-ascii?q?HRjpL6bVojDx4j0gOHijSl8/rbPnGjr24jbw8=3D?=
X-IronPort-AV: E=Sophos;i="5.88,210,1635177600"; 
   d="scan'208";a="119003731"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Dec 2021 16:44:32 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 13A134D146C3;
        Thu, 16 Dec 2021 16:44:31 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Dec 2021 16:44:29 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Dec 2021 16:44:31 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 16 Dec 2021 16:44:31 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH] IB/rxe: Get rid of redundant plus
Date:   Thu, 16 Dec 2021 16:43:44 +0800
Message-ID: <20211216084344.539-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 13A134D146C3.AB0E4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 3ef5a10a6efd..79122eeb4d82 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -879,9 +879,9 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 			[RXE_ATMETH]	= RXE_BTH_BYTES
 						+ RXE_RDETH_BYTES
 						+ RXE_DETH_BYTES,
-			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
 						+ RXE_ATMETH_BYTES
-						+ RXE_DETH_BYTES +
+						+ RXE_DETH_BYTES
 						+ RXE_RDETH_BYTES,
 		}
 	},
@@ -900,9 +900,9 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 			[RXE_ATMETH]	= RXE_BTH_BYTES
 						+ RXE_RDETH_BYTES
 						+ RXE_DETH_BYTES,
-			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
 						+ RXE_ATMETH_BYTES
-						+ RXE_DETH_BYTES +
+						+ RXE_DETH_BYTES
 						+ RXE_RDETH_BYTES,
 		}
 	},
-- 
2.33.0



