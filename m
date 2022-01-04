Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7BD4839C2
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 02:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiADBYS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 20:24:18 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:62276 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230227AbiADBYR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 20:24:17 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A2IBIV61XjWRRKtaTJ/bD5Ttzkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ0T9002AEyzQYCGHTaf2DYDb3eNF2a9jjoEMCv8Ldzd42QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfjQHeKnYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2NnsJxyddMvJqYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPQXqeWcfCTh2SCU5wicG5f2+N18HUMkLI9Cor4vKW5?=
 =?us-ascii?q?L/P0cbjsKa3irg++xxpq4R/Nqi8BlK9PkVKsbu3d93XTaAOwgTJTrXarH/5lb0?=
 =?us-ascii?q?S02i8QIGuzRD+IdaDxyfFHabxhGEkkYBYh4n+qygHT7NTpCpzq9p6U4y3rSwRR?=
 =?us-ascii?q?8lrPkWOc50PTiqd59xx7e/zyZuT+iRExyCTBW8hLdmlrEuwMFtXqTtFouKYCF?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ab1CUa6H8nxVEPHC6pLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.88,258,1635177600"; 
   d="scan'208";a="119923546"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Jan 2022 09:24:15 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 7F4414D146D4;
        Tue,  4 Jan 2022 09:24:12 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 4 Jan 2022 09:24:12 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 4 Jan 2022 09:24:11 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH v2] RDMA/rxe: Get rid of redundant plus
Date:   Tue, 4 Jan 2022 09:24:06 +0800
Message-ID: <20220104012406.27580-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 7F4414D146D4.ACA08
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Li Zhijian <lizhijian@cn.fujitsu.com>

Get rid of the duplicate plus in a line to be consistent with others.

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



