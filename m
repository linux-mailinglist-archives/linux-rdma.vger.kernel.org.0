Return-Path: <linux-rdma+bounces-6785-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2EA0030A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 04:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBAC162EAD
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 03:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEBB1537C6;
	Fri,  3 Jan 2025 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="qQhfnz1B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB51322B;
	Fri,  3 Jan 2025 03:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735873808; cv=none; b=DoEuSiX/Yj75XkFrDONcRphAmmi4nBF7P+Zt2H/84CXyK01li2sRfiqqcHbhop2pOdyFfuoqPkFymZUgjKQLnCu1uRTqUeaRbXr+hQgK2us+p+PmlzDbNUj+MbEmgXaHqLO6ZiQS11OefziaMqiTKJZb6PY3M05PCxMIaOK78ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735873808; c=relaxed/simple;
	bh=rrv+pW2tut3qXQc0fYbw1PYnFr9IHtYdWWzowaxPxTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gcUWJ56hA3eacTLY9fOCnTUe60WxhPLM8DsZKpZl2ITKOX/hVhJIhThFcWJ31YzE/1vyTRGQXaEhnBrwhZUB1s7+5xATOx1KLs3T3EmDthii9iAel4rq25iUzxtcA+ep4FcITBo4FN9PtNZcESQr3uLbPDpAbeqO/DS6upUCMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=qQhfnz1B; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1735873806; x=1767409806;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rrv+pW2tut3qXQc0fYbw1PYnFr9IHtYdWWzowaxPxTQ=;
  b=qQhfnz1Bb6NtGMppwlEBNlQvwANqgDqapZcY0ErQIGjfQAQRP8clUd2D
   amOgSEs9qZCEErQt/o+iH2YVhUFVvYMboXI02fIQul4+YbDQKGpvvFsYC
   TQS0K1AZ7klb3hLXs/pKB40kXTiSdtvlLb+WY4cea+ZMeBwN22maQnmPL
   O1RdqKoaXmDo5wv5lt5Ve4SZZfWLW2PSj0PJGYoY+AyERMqFSQ4b9HAC2
   aHSxo5NGTctaNdiZHDS4VTw2JAFjWdOTcwQzqm+5x75L3z6/NrVVzG1Mp
   Ic4TCnPCG/rNfkG7w4q81kcpqGYMe4tY6kpnh60hnPCl2PBmR/TVLZhKZ
   w==;
X-CSE-ConnectionGUID: 52LSqsY2TrKKzXD3DJDB3w==
X-CSE-MsgGUID: PUoOg87ZRp2wnXqOtW/3pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="164407839"
X-IronPort-AV: E=Sophos;i="6.12,286,1728918000"; 
   d="scan'208";a="164407839"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 12:08:54 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 913AED4807;
	Fri,  3 Jan 2025 12:08:52 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6A86AD8AE2;
	Fri,  3 Jan 2025 12:08:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id CC94620076D0E;
	Fri,  3 Jan 2025 12:08:51 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E20651A006C;
	Fri,  3 Jan 2025 11:08:49 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: haris.iqbal@ionos.com,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2] RDMA/rtrs: Add missing deinit() call
Date: Fri,  3 Jan 2025 11:08:39 +0800
Message-Id: <20250103030839.2636-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28898.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28898.004
X-TMASE-Result: 10--9.606900-10.000000
X-TMASE-MatchedRID: NGDYxnKYxb2Po+6vQMop+jYTypjB3iDVYjDXdM/x2VNx1I8cSFvoV5Ky
	Pf1j7t431DGesiNkyfju5J7i9V7QtWMAzi+7d0ch/sUSFaCjTLylLADMASK8x6fDpVD78xj9B82
	GyGpZHXt/AvQEPGhyUmNqS7Qg+z0PK6km+od/UDyC+Y2uxPjochmyTBaqiJvcMoh6scCF9jG/BR
	68O365bn9eOltIlLtrgiRLZTsVNVvp8tqiL6KWRJ4CIKY/Hg3AaZGo0EeYG96fFcoYkBpBrUkpb
	iYOUmwxIAcCikR3vq+GY9zUGYLvX9HMQYZW2gWmUyNZuXbnkzSLKblv5Dg4LWzMvNNZ948p
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

Fixes: 667db86bcbe8 ("RDMA/rtrs: Register ib event handler")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: update the subject 'RDMA/ulp' -> 'RDMA/rtrs'
    update commit log
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 4e17d546d4cc..3b3efecd0817 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -580,6 +580,9 @@ static void dev_free(struct kref *ref)
 	dev = container_of(ref, typeof(*dev), ref);
 	pool = dev->pool;
 
+	if (pool->ops && pool->ops->deinit)
+		pool->ops->deinit(dev);
+
 	mutex_lock(&pool->mutex);
 	list_del(&dev->entry);
 	mutex_unlock(&pool->mutex);
-- 
2.47.0


