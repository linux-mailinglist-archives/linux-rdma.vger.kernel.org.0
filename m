Return-Path: <linux-rdma+bounces-6573-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721139F4930
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFABC16F3A3
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFCB1EBA02;
	Tue, 17 Dec 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bMkPRocn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444451DFE0F;
	Tue, 17 Dec 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432411; cv=none; b=ZnKjd9cvBmt3J9Ew+H2Cp22AqP+0u3oIVWnJ3RELM4BZUgUfeHCCPlcaKbCmBzW7eCbB5nzD7OaknvrDGEKZJt8eIb7kUzPZChRGdQq6PC197w/xAVV2bCfetmhU3ouzxvY3niq9oUp2DVqNv3QzRDJM+5rrG5yv431/PFZK2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432411; c=relaxed/simple;
	bh=5lyyw0lWpQi2YgVrgXKcaOUXj4vRl5LPW0uHLdmqiV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rgrjjSr2rzUWRDDv08rTXc9y5L1Zpyq2EejDSvDR155T+nhkjvUtgA7Yw+g9qKTpSHMR6PoQScwJSCnjJuRgEWKKqqL+L9CO8XejUBPisWhAImfseANpUTxVm3w4/GwsjRBwhJw5QOiH/PZ80GOY3I8Ggc+AFxG4u56uikBNKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bMkPRocn; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OlgaT
	GFYRjVPm1jcUodWnSy0zASPpTDUGrYjZ8ffJgo=; b=bMkPRocnEofr+wf9vkH14
	ZP/nc5OZHNzK/vDsu+R7uyS1xC7bgU8otV7qI1POPiJfBQChMbJnK7l2jsBu2VSO
	KZnQvSnWTUO/X+JVf109ClTcuO0pgtZ8WPqk9/JZVqTL+/bMcJhX9H7qR8q0LNoM
	VXEA/loKjrOhvfdaXP+zPU=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHz_1vVmFny666BA--.16303S4;
	Tue, 17 Dec 2024 18:46:16 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: bvanassche@acm.org,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] RDMA/srp: Fix error handling in srp_add_port
Date: Tue, 17 Dec 2024 18:46:05 +0800
Message-Id: <20241217104605.2924666-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHz_1vVmFny666BA--.16303S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWkJFyDGF4xKF1fKFy5twb_yoWkAFg_Kw
	4jvr92qry8C3Wvywn3Z3ZxZry8KrnFqryrArZIqr9ak39xXF97Zwn7Xrs0yw47Z3W29r15
	XF13Wr48Jr4rKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXBMtUUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRi4C2dhLpVeiwABsX

Once device_add() failed, we should call only put_device() to
decrement reference count for cleanup. We should not call device_del()
before put_device().

As comment of device_add() says, 'if device_add() succeeds, you should
call device_del() when you want to get rid of it. If device_add() has
not succeeded, use only put_device() to drop the reference count'.

Found by code review.
Cc: stable@vger.kernel.org
Fixes: c8e4c2397655 ("RDMA/srp: Rework the srp_add_port() error path")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- modified the bug description as suggestions.
---
 drivers/infiniband/ulp/srp/ib_srp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 2916e77f589b..7289ae0b83ac 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3978,7 +3978,6 @@ static struct srp_host *srp_add_port(struct srp_device *device, u32 port)
 	return host;
 
 put_host:
-	device_del(&host->dev);
 	put_device(&host->dev);
 	return NULL;
 }
-- 
2.25.1


