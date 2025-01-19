Return-Path: <linux-rdma+bounces-7100-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED93DA16358
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 18:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1489E7A2C3F
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684C1DF977;
	Sun, 19 Jan 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CMR6NlXe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F91DF27D
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307733; cv=none; b=keIqpTQP3WUf7Zd97vRtmupmjD4MloQX2nLdzEwAOJ+XCSSnzKEWegwiWuPkcXP5gpNGUKM2XDWYhl8k/qv7SaO5cVKpsOuvTbHl8doDOAFO05gvE8w6nLMebLhiDCWPNrh9sc0ZSYJu5lS1gUxsW9ZeuKAJWy0OYQy5vhcKyDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307733; c=relaxed/simple;
	bh=OBFEUoexhOVTYJLFAprcRGF5Hj49H1Lk4VDuruGhOgg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UzxgNs9JPY2xDv7+1wFCqxxk39mjsOQu/eKfWGzW5NR5me0Y7jpaIL4YXRxWZ5mhL5RkePLUZ1UQ34ZlBbrmuyuLot9QfOtU0kDc0xJ28EBRJiyW2zFfFHNhc3qLDbFgTRLKf1v6k5IIAw67onTY9pa/Tnxw5gf7CfNZOAguwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CMR6NlXe; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737307729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2LW50jnrPSPan2lCmyQjpi/v5afkYSe9p/W+xJi8C/8=;
	b=CMR6NlXe2b/ZlzuZQ/+cdulAUbfu1/68ZtOetdPTFIKg3NE0UigLhk4GJ+kEa9OHeo5cuU
	kjuwNujakIdrSssrRcBdWatgwuKD6VcxpSSE9xBPHDZnE1lkS7091043aGPGahkYan1AfM
	LLjxTl0sFQXJPwnPBtaNkt3BsRtNgoQ=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH 3/3] RDMA/rxe: Make rping work with tun device
Date: Sun, 19 Jan 2025 18:28:31 +0100
Message-Id: <20250119172831.3123110-4-yanjun.zhu@linux.dev>
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

Because the type of tun device is ARPHRD_NONE, in cma, ARPHRD_NONE is
not recognized. To RXE device, just as SIW does, ARPHRD_NONE is added
to support.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/core/cma.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 91db10515d74..fedcdb56fb6b 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -739,12 +739,26 @@ cma_validate_port(struct ib_device *device, u32 port,
 		goto out;
 	}
 
-	if (dev_type == ARPHRD_ETHER && rdma_protocol_roce(device, port)) {
-		ndev = dev_get_by_index(dev_addr->net, bound_if_index);
-		if (!ndev)
-			goto out;
+	/*
+	 * For a RXE device, it should work with TUN device and normal ethernet
+	 * devices. Use driver_id to check if a device is a RXE device or not.
+	 * ARPHDR_NONE means a TUN device.
+	 */
+	if (device->ops.driver_id == RDMA_DRIVER_RXE) {
+		if ((dev_type == ARPHRD_NONE || dev_type == ARPHRD_ETHER)
+			&& rdma_protocol_roce(device, port)) {
+			ndev = dev_get_by_index(dev_addr->net, bound_if_index);
+			if (!ndev)
+				goto out;
+		}
 	} else {
-		gid_type = IB_GID_TYPE_IB;
+		if (dev_type == ARPHRD_ETHER && rdma_protocol_roce(device, port)) {
+			ndev = dev_get_by_index(dev_addr->net, bound_if_index);
+			if (!ndev)
+				goto out;
+		} else {
+			gid_type = IB_GID_TYPE_IB;
+		}
 	}
 
 	sgid_attr = rdma_find_gid_by_port(device, gid, gid_type, port, ndev);
-- 
2.34.1


