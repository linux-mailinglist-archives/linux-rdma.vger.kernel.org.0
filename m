Return-Path: <linux-rdma+bounces-569-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA18828221
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 09:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB3F282866
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B7329431;
	Tue,  9 Jan 2024 08:34:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C339FE2;
	Tue,  9 Jan 2024 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="145557037"
X-IronPort-AV: E=Sophos;i="6.04,182,1695654000"; 
   d="scan'208";a="145557037"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 17:33:05 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id DCC19CF1C9;
	Tue,  9 Jan 2024 17:33:01 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C1D09CB75;
	Tue,  9 Jan 2024 17:33:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id AC3CC2663B9;
	Tue,  9 Jan 2024 17:33:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 33F2B1A0099;
	Tue,  9 Jan 2024 16:33:00 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next v4 2/2] RDMA/rxe: Remove rxe_info from rxe_set_mtu
Date: Tue,  9 Jan 2024 16:32:53 +0800
Message-Id: <20240109083253.3629967-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240109083253.3629967-1-lizhijian@fujitsu.com>
References: <20240109083253.3629967-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28108.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28108.006
X-TMASE-Result: 10--5.745700-10.000000
X-TMASE-MatchedRID: zpx2FW2iGB3cT4NrftwVHs69emDs42dd0MQw+++ihy9D0XHWdCmZPOEO
	iHvBs/Z/eG7OVGjdOcqcRHJVf0LsQ32IKB5eohESEhGH3CRdKUUKW68eInZ/hd9zZd3pUn7Kuk1
	3zQ8GyD0XLN9wFHzBy+affHI8kAmiHY/bzRmIaZEK3Ma88LL+bn0tCKdnhB58I/9UW5M5dRM+8F
	JNGdxYq/cUt5lc1lLgkU6UkIr/V+20QRlrBF3eZfPX17vy9WxtWKHSPEaK1CJ1r8k7N0D4e8xvQ
	1RqHRamwYJE2kpDEyQ=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

commit 9ac01f434a1e ("RDMA/rxe: Extend dbg log messages to err and info")
newly added this info. But it did only show null device when
the rdma_rxe is being loaded because dev_name(rxe->ib_dev->dev)
has not yet been assigned at the moment:

"(null): rxe_set_mtu: Set mtu to 1024"

Remove it to silent this message, check the mtu from it backend link
instead if needed.

CC: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V4: Remove it rather than re-order rxe_set_mtu() and rxe_register_device()
---
 drivers/infiniband/sw/rxe/rxe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index a086d588e159..ae466e72fc43 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -160,8 +160,6 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 
 	port->attr.active_mtu = mtu;
 	port->mtu_cap = ib_mtu_enum_to_int(mtu);
-
-	rxe_info_dev(rxe, "Set mtu to %d\n", port->mtu_cap);
 }
 
 /* called by ifc layer to create new rxe device.
-- 
2.29.2


