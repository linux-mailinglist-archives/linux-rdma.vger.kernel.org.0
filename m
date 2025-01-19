Return-Path: <linux-rdma+bounces-7098-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117D8A16356
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 18:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CEF1647E5
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715B1DF741;
	Sun, 19 Jan 2025 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T1aDKv2F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B041DE3C0
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307731; cv=none; b=WIqcF+YJBW4XADkXwOrs94L92kMzClkfAeSN7pN3KA+TQMgDDT+kalr39J2YQtAA77xj2MgaGJaiwEJAkrmF4QWPwSxMBHdXqJPWOCPTKsVVUIKIhy6jo3SiS5CH+hIIRFT+Xa4lxWHSlih/U1/QB9af+YuH+1OqBId8/0NtW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307731; c=relaxed/simple;
	bh=UYbyGJxbae39QdCHBlx82fxQ3OIJ/siHvqgNQcw55s4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=egoBgxWRZK4kPFqZrIe0X76dXJ0mBT5+ZUPG1eZfApEjmIvTexu0EbBqx8emoF784l6hpgL3v0XIdqXzcIwNhFfexSAFTtrUtMWzOChgvFi5sDdcup9XN5laWHR8GyDD+Vl0i5LHmustU3hr4P98VdM5KDK0w+/F++PxzIXKJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T1aDKv2F; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737307726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxFtoELoh2q96fSTltOY5jcoD8o3DkX8pBrT/0Q3xAg=;
	b=T1aDKv2FagUZqqIxdC7+9AGDYBnoR99+UvgFO4B72ScHW4lvx+04SF+bjOVn21oh4Kt80p
	Qxq7L7fG7rSVBK3+mFY7jAE1axcQhS5uZTQSUX914FNRtO7rDpKDhDiica+JaLHHI3kYWl
	nGveyEf3owJARHyI5w2CJZ8mbRYaIMw=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH 1/3] RDMA/rxe: Replace netdev dev addr with raw_gid
Date: Sun, 19 Jan 2025 18:28:29 +0100
Message-Id: <20250119172831.3123110-2-yanjun.zhu@linux.dev>
In-Reply-To: <20250119172831.3123110-1-yanjun.zhu@linux.dev>
References: <20250119172831.3123110-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because TUN device does not have dev_addr, but a gid in rdma is needed,
as such, a raw_gid is generated to act as the gid. The similar commit is
in SIW. This commit learns from the similar commit bad5b6e34ffb
("RDMA/siw: Fabricate a GID on tun and loopback devices") in SIW.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c       | 15 +++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  4 +++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 1ba4a0c8726a..432e54a29b99 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -78,8 +78,19 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	if (!ndev)
 		return;
 
+	if (ndev->addr_len) {
+		memcpy(rxe->raw_gid, ndev->dev_addr,
+			min_t(unsigned int, ndev->addr_len, ETH_ALEN));
+	} else {
+		/*
+		 * This device does not have a HW address, but
+		 * connection mangagement requires a unique gid.
+		 */
+		eth_random_addr(rxe->raw_gid);
+	}
+
 	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
-			ndev->dev_addr);
+			rxe->raw_gid);
 
 	dev_put(ndev);
 
@@ -125,7 +136,7 @@ static void rxe_init_ports(struct rxe_dev *rxe)
 	if (!ndev)
 		return;
 	addrconf_addr_eui48((unsigned char *)&port->port_guid,
-			    ndev->dev_addr);
+			    rxe->raw_gid);
 	dev_put(ndev);
 	spin_lock_init(&port->port_lock);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 8a5fc20fd186..837566cd682c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1523,7 +1523,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name,
 	dev->num_comp_vectors = num_possible_cpus();
 	dev->local_dma_lkey = 0;
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
-			    ndev->dev_addr);
+			    rxe->raw_gid);
 
 	dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_POST_SEND) |
 				BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 6573ceec0ef5..729a6ada46af 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -376,7 +376,9 @@ struct rxe_dev {
 	struct ib_device_attr	attr;
 	int			max_ucontext;
 	int			max_inline_data;
-	struct mutex	usdev_lock;
+	struct mutex		usdev_lock;
+
+	char			raw_gid[ETH_ALEN];
 
 	struct rxe_pool		uc_pool;
 	struct rxe_pool		pd_pool;
-- 
2.34.1


