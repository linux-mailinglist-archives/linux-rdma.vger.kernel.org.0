Return-Path: <linux-rdma+bounces-6702-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C119FA96B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 03:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD741885F4E
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 02:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6778C91;
	Mon, 23 Dec 2024 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GABjmykS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F2A2BB15;
	Mon, 23 Dec 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734922641; cv=none; b=WmGybyQcekcC54JaE+k+dCXGFP2qLyY5lxh+E7I6aHff7Pk77rlpd+Xrwr8qkcO1u5TtnXe91IjJsOsWAdKs/+cy43eq4c7Qo+8KszzP5tV9KBjD/CuwGMCekFi/l+dQAxXiUmLPJ8kcsPBbvKDIrMJDvhvFpoYbvtsWwjs6A0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734922641; c=relaxed/simple;
	bh=aW1Ts21ePnqwZmKD042bdVOwmMEH+v5/Y1PQJHL6rxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iQBjSozAMhI8sS9gRHHU4CedEIPTqxAwyi8suY5wR53Uq5f/sB5PqVR2jNK98mKMm/xSDKO/r/UAoVACyVeZlrdrmqf3/ckJkhOgkY32HJNq3wWpPc1QrPWCxaVoQoZE+O9aZtXBswB6IRx5nxJJ6gL+t9k/OfDaZ953f5YrMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GABjmykS; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734922640; x=1766458640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aW1Ts21ePnqwZmKD042bdVOwmMEH+v5/Y1PQJHL6rxY=;
  b=GABjmykSdyA8yt9GKe23eyNqOrx0CCjrlyzvbym39umhYlQ0iZTpsimg
   PIUzlmW8NH04zJjaDXD0NhPOUVFR2xj0fAx0FyleE49tZFaaszMo65dBi
   Q06Pjhywm2b1j14rfYW3yJDDXuWszZRbX0so7EWpRkbwcHxy1qMTy4gIm
   hMtYs1uTNV0XcH322mJOQ46qlTjY7KT39JBqHevlTYUCgOIQjyT35au3Y
   JquXId81GJ2/LzNxVmQhYgMc0jJ3/LOowKvMEoUf3OT0I4LGD5JJ+rk5S
   V3Iz507J9+RLOvmP27UvXterzSpeMtXN5eLdpmzAbh+9sJM5Y64sjbA4e
   A==;
X-CSE-ConnectionGUID: Eh2APx07T7a9f+fqRVw3XQ==
X-CSE-MsgGUID: 6gwPgewPTAOmAWZD3viEiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="184636150"
X-IronPort-AV: E=Sophos;i="6.12,256,1728918000"; 
   d="scan'208";a="184636150"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 11:57:12 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 76F31D4F5F;
	Mon, 23 Dec 2024 11:57:09 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 46AA9D5043;
	Mon, 23 Dec 2024 11:57:09 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id BA70920076D12;
	Mon, 23 Dec 2024 11:57:08 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D08AB1A006C;
	Mon, 23 Dec 2024 10:57:07 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: haris.iqbal@ionos.com,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] RDMA/ulp: Add missing deinit() call
Date: Mon, 23 Dec 2024 10:57:00 +0800
Message-Id: <20241223025700.292536-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28876.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28876.004
X-TMASE-Result: 10--4.307900-10.000000
X-TMASE-MatchedRID: 2wfub8HDRfOPo+6vQMop+jYTypjB3iDVYjDXdM/x2VNx1I8cSFvoV5Ky
	Pf1j7t431DGesiNkyfju5J7i9V7QtWMAzi+7d0ch/sUSFaCjTLylLADMASK8x6fDpVD78xj9B82
	GyGpZHXtF+l3+KzhDQcoAVnIK3cw/BXY0oXpqJ14ReM8i8p3vgFQQ0EgzIoPRuqWf6Nh7tmFuKp
	6bV95JA+LzNWBegCW2xl8lw85EaVQLbigRnpKlKZx+7GyJjhAUk/4+qv9A0SbXO9DU31GxuP46y
	66IWMlzZBb9N2wM/+1q3cvp/9h/GIQjiHxb+vggwcQABRoFCs1+w0a95oRHeUvDW9RnLTnDmw0Q
	aktp+ussz+cQMs/Tnp75MOLIf/j3DF+QsB+Q01JoBmTSwRxjXg==
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

Fix it by invoking the `deinit()` to appropriately unregister the IB event
handler.

Fixes: 667db86bcbe8 ("RDMA/rtrs: Register ib event handler")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
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


