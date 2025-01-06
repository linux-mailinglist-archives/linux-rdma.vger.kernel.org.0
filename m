Return-Path: <linux-rdma+bounces-6819-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5796A01CE2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 01:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297C51883711
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 00:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8313C3596F;
	Mon,  6 Jan 2025 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Ovmm+/B5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CC38DC8;
	Mon,  6 Jan 2025 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736124335; cv=none; b=iVG3OUU3Lm75vfMOuU8/hZgY7Jv78CYHh6UiVxHa3LzyguZxKv4zQN6H/Fj5xARA7sPN/T3w3MYeRHe7XUNcsxMIAnKV4CIvvBnl0GYGHTNADqxx8GmH14TGE37DoRX0qTqFqz218TBb4qPatYYKnqPuNDpM1sMKu8TrtiKJjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736124335; c=relaxed/simple;
	bh=dozYCh/1LLPEgGHTX0cNzDx7PJPGnJa7OHe4e8f8wek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XTkZJhejwFm0PoFOes3hYZft4+YDszC/QHl8r+FMo7StvfDb1T9EjvWJLIQHsw1PV6VWAUXehGLu9nPV5jlvtLss1RdGeEyY1gPT/ybAsWRZPO4Py6ptYso7U+tIZ4rBT6fZ0hd1jilE0yVg5T2lAgKqmw1FCf7deP8pSTSmd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Ovmm+/B5; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736124333; x=1767660333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dozYCh/1LLPEgGHTX0cNzDx7PJPGnJa7OHe4e8f8wek=;
  b=Ovmm+/B5ViJwiLAZXKvsCu0PGFLII9h4wYs7kTWBWszY0lENFYyZ2aWv
   YpuTcOnMWBRsYUWDwIV8zukbpXLHGMAjOAMQ5cvhje2laaIt63fblwMFv
   DJMaz9mFGu7nNvtgoZ+DkqhMAqu0L+lAINiqAfdF/GOTEYM8W6VyaSR7T
   2UaCyQRr9RRbMiNos5MMnPZyf+tq6UdLOrSaUV3S6L16LOlUuCg4I+fts
   tOyE/CqkXA2ZkyEBYcu+bOXiFxdvu5uUFHTlWZcyJwzqtBzV5f9DeaRlW
   3F92bMTnJkRskSG+U87rBHJIwNEzt5wRUlEtm6pnv2XI9vm8jHBIygGx6
   A==;
X-CSE-ConnectionGUID: OqOoWF/GQM2FMPXRED6wQQ==
X-CSE-MsgGUID: KKu7r2N+SlKL2AwgAydSDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="165085273"
X-IronPort-AV: E=Sophos;i="6.12,291,1728918000"; 
   d="scan'208";a="165085273"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 09:45:24 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8B712C2262;
	Mon,  6 Jan 2025 09:45:21 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 60F8BD7726;
	Mon,  6 Jan 2025 09:45:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id CFEFEE3682;
	Mon,  6 Jan 2025 09:45:20 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E4E9A1A0071;
	Mon,  6 Jan 2025 08:45:19 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: haris.iqbal@ionos.com,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3] RDMA/rtrs: Add missing deinit() call
Date: Mon,  6 Jan 2025 08:45:16 +0800
Message-Id: <20250106004516.16611-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28904.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28904.003
X-TMASE-Result: 10--9.606900-10.000000
X-TMASE-MatchedRID: NGDYxnKYxb2Po+6vQMop+jYTypjB3iDVYjDXdM/x2VNx1I8cSFvoV5Ky
	Pf1j7t431DGesiNkyfju5J7i9V7QtWMAzi+7d0ch/sUSFaCjTLylLADMASK8x6fDpVD78xj9B82
	GyGpZHXt/AvQEPGhyUmNqS7Qg+z0PK6km+od/UDyC+Y2uxPjochmyTBaqiJvcMoh6scCF9jG/BR
	68O365bn9eOltIlLtrgiRLZTsVNVvp8tqiL6KWRJ4CIKY/Hg3AaZGo0EeYG96fFcoYkBpBrUkpb
	iYOUmwxIAcCikR3vq/Y/rURGXevJh0ets+KbtqZC0PHGGDroHd4b6nPxxecQJcJI0VVsJHe
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

A warning is triggered when repeatedly connecting and disconnecting the
rnbd:
 list_add corruption. prev->next should be next (ffff88800b13e480), but was ffff88801ecd1338. (prev=ffff88801ecd1340).
 WARNING: CPU: 1 PID: 36562 at lib/list_debug.c:32 __list_add_valid_or_report+0x7f/0xa0
 Workqueue: ib_cm cm_work_handler [ib_cm]
 RIP: 0010:__list_add_valid_or_report+0x7f/0xa0
  ? __list_add_valid_or_report+0x7f/0xa0
  ib_register_event_handler+0x65/0x93 [ib_core]
  rtrs_srv_ib_dev_init+0x29/0x30 [rtrs_server]
  rtrs_ib_dev_find_or_add+0x124/0x1d0 [rtrs_core]
  __alloc_path+0x46c/0x680 [rtrs_server]
  ? rtrs_rdma_connect+0xa6/0x2d0 [rtrs_server]
  ? rcu_is_watching+0xd/0x40
  ? __mutex_lock+0x312/0xcf0
  ? get_or_create_srv+0xad/0x310 [rtrs_server]
  ? rtrs_rdma_connect+0xa6/0x2d0 [rtrs_server]
  rtrs_rdma_connect+0x23c/0x2d0 [rtrs_server]
  ? __lock_release+0x1b1/0x2d0
  cma_cm_event_handler+0x4a/0x1a0 [rdma_cm]
  cma_ib_req_handler+0x3a0/0x7e0 [rdma_cm]
  cm_process_work+0x28/0x1a0 [ib_cm]
  ? _raw_spin_unlock_irq+0x2f/0x50
  cm_req_handler+0x618/0xa60 [ib_cm]
  cm_work_handler+0x71/0x520 [ib_cm]

Commit 667db86bcbe8 ("RDMA/rtrs: Register ib event handler") introduced a
new element .deinit but never used it at all. Fix it by invoking the
`deinit()` to appropriately unregister the IB event handler.

Cc: Jinpu Wang <jinpu.wang@ionos.com>
Fixes: 667db86bcbe8 ("RDMA/rtrs: Register ib event handler")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3: Move deinit behind list_del # Jinpu Wang <jinpu.wang@ionos.com>

V2: update the subject 'RDMA/ulp' -> 'RDMA/rtrs'
    update commit log
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 4e17d546d4cc..bf38ac6f87c4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -584,6 +584,9 @@ static void dev_free(struct kref *ref)
 	list_del(&dev->entry);
 	mutex_unlock(&pool->mutex);
 
+	if (pool->ops && pool->ops->deinit)
+		pool->ops->deinit(dev);
+
 	ib_dealloc_pd(dev->ib_pd);
 	kfree(dev);
 }
-- 
2.47.0


