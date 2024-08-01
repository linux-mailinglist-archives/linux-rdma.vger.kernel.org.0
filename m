Return-Path: <linux-rdma+bounces-4160-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D63944B7D
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 14:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B011C255A6
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183431A01D5;
	Thu,  1 Aug 2024 12:38:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577415252D;
	Thu,  1 Aug 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515912; cv=none; b=FbRpoFvbfe1ceynvVpQ/f4hjosaH1K348VvYck8uGh7uA0Bo+Lkgp6gDR16b5CwHYfuNMW7rCYFALjm8XHGeRpcXk+Izsqdl6yJvXxI6jq4NNEv9/yrLZANB7Sm1wsd2pZHcBMQjrZgtNqEEZwstealBAyDStpsSEdZj8DLC7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515912; c=relaxed/simple;
	bh=x02eljObgUrujzqWdEVMMHSIGgKeTAl+hcGM7tnLa48=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tSVbfw+/S3GEdpzVWuwPVbeh4GfbqHe0o8PsoZskkhkAblkv633yuS6hvEBr5yy6fOgcae2KPmI59OgdD0VuLiPQCO9F5JLL7k/GV04g8P88hI6aoj36nAOndI1+DYyaPmEyxWMqbO24to751ZSpD9KUUll4z50J5lgxcgvO/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WZT5d5hNQz1L8rq;
	Thu,  1 Aug 2024 20:38:13 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 80CDB18006C;
	Thu,  1 Aug 2024 20:38:26 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 1 Aug 2024 20:38:25 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <bvanassche@acm.org>,
	<nab@risingtidesystems.com>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<target-devel@vger.kernel.org>
Subject: [PATCH v2 for-rc] RDMA/srpt: Fix UAF when srpt_add_one() failed
Date: Thu, 1 Aug 2024 20:32:53 +0800
Message-ID: <20240801123253.2908831-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Currently cancel_work_sync() is not called when srpt_refresh_port()
failed in srpt_add_one(). There is a probability that sdev has been
freed while the previously initiated sport->work is still running,
leading to a UAF as the log below:

[  T880] ib_srpt MAD registration failed for hns_1-1.
[  T880] ib_srpt srpt_add_one(hns_1) failed.
[  T376] Unable to handle kernel paging request at virtual address 0000000000010008
...
[  T376] Workqueue: events srpt_refresh_port_work [ib_srpt]
...
[  T376] Call trace:
[  T376]  srpt_refresh_port+0x94/0x264 [ib_srpt]
[  T376]  srpt_refresh_port_work+0x1c/0x2c [ib_srpt]
[  T376]  process_one_work+0x1d8/0x4cc
[  T376]  worker_thread+0x158/0x410
[  T376]  kthread+0x108/0x13c
[  T376]  ret_from_fork+0x10/0x18

Add cancel_work_sync() to the exception branch to fix this UAF.
Besides, exchange the order of INIT_WORK() and srpt_refresh_port()
in srpt_add_one(), so that when srpt_refresh_port() failed, there
is no need to cancel the work in this iteration.

Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9632afbd727b..7def231da21a 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -648,6 +648,7 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev, int port_cnt)
 			ib_unregister_mad_agent(sport->mad_agent);
 			sport->mad_agent = NULL;
 		}
+		cancel_work_sync(&sport->work);
 	}
 }
 
@@ -3220,7 +3221,6 @@ static int srpt_add_one(struct ib_device *device)
 		sport->port_attrib.srp_max_rsp_size = DEFAULT_MAX_RSP_SIZE;
 		sport->port_attrib.srp_sq_size = DEF_SRPT_SQ_SIZE;
 		sport->port_attrib.use_srq = false;
-		INIT_WORK(&sport->work, srpt_refresh_port_work);
 
 		ret = srpt_refresh_port(sport);
 		if (ret) {
@@ -3229,6 +3229,8 @@ static int srpt_add_one(struct ib_device *device)
 			i--;
 			goto err_port;
 		}
+
+		INIT_WORK(&sport->work, srpt_refresh_port_work);
 	}
 
 	ib_register_event_handler(&sdev->event_handler);
@@ -3264,13 +3266,9 @@ static void srpt_remove_one(struct ib_device *device, void *client_data)
 	struct srpt_device *sdev = client_data;
 	int i;
 
-	srpt_unregister_mad_agent(sdev, sdev->device->phys_port_cnt);
-
 	ib_unregister_event_handler(&sdev->event_handler);
 
-	/* Cancel any work queued by the just unregistered IB event handler. */
-	for (i = 0; i < sdev->device->phys_port_cnt; i++)
-		cancel_work_sync(&sdev->port[i].work);
+	srpt_unregister_mad_agent(sdev, sdev->device->phys_port_cnt);
 
 	if (sdev->cm_id)
 		ib_destroy_cm_id(sdev->cm_id);
-- 
2.33.0


