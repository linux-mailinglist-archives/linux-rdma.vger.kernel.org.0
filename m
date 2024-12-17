Return-Path: <linux-rdma+bounces-6562-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 591A69F458D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 08:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFF016C4E5
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472DD1D63C4;
	Tue, 17 Dec 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="INX7Y4QS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A4A29;
	Tue, 17 Dec 2024 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422175; cv=none; b=EO+/Owgvyg0XbCh2IBgmfQlgHvkoqy9T3+kwMC0qZHP341q46v914wGQwMPwh2PXwDgf65w57+rYNH5CN0qM9rx1VmxKccgFfXIDGPDW6nUhM2VqESDY1SqNHh11OpkBN0RkvkcLxs5kkBVW4y1s0mZekXhVWm02qbFCwUjopWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422175; c=relaxed/simple;
	bh=BwcP21tQkxLKS1noATp5ZwYvzvZWpXAPS91ac0YK+ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IoAZSkvk2CqtFHSut6JQNM5ocqoD+ln7GD0wrpDMHim0S2JgQgswb2keXTY2Tlhwkq9Fdo3WHnwx9rtgHfCLoqyWynVsoZvruuLss83ahRylDuoBwSCUB6rxc8kNZwsdYJqvdTnL+Zb2xpUWH3KCAfJ+BUOIbuWgqPzYAg2WOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=INX7Y4QS; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Jni+N
	qq9ZhLhAcR6lFqnnFsxAP48f+BhrROL74A+7Z8=; b=INX7Y4QSe0FaYd6q6AF8m
	XKyXg4ALe6G3E0968E2YXQnTjzToCwf/op3CXr7fY6xQNNUj36CMd/BowwStA6DJ
	qyyjKvxfhutgGAeHtellwIDtIievcTv5GGj46o86FnmviXfIyOrPOxcUsxkJUHmE
	oiD17Car3SshPVZ8lMNiMY=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnz7x7LmFnjtdxBA--.22023S4;
	Tue, 17 Dec 2024 15:55:46 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: bvanassche@acm.org,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/srp: Fix error handling in srp_add_port
Date: Tue, 17 Dec 2024 15:55:38 +0800
Message-Id: <20241217075538.2909996-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz7x7LmFnjtdxBA--.22023S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr15JF48GrWrAw48ZFW3GFg_yoWkZFc_Kr
	4jvr92gr18Ca1ktw43XwnxZr1Igrn2q34fXrZ2qwnak3y5XFn7Zwn7Wrs0yr17Za429r1U
	JF13Gr40yr45KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWGQhUUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRy4C2dhI2DBTgABsx

The reference count of the device incremented in device_initialize() is
not decremented when device_add() fails. Add a put_device() call before
returning from the function to decrement reference count for cleanup.
Or it could cause memory leak.

As comment of device_add() says, if device_add() succeeds, you should
call device_del() when you want to get rid of it. If device_add() has
not succeeded, use only put_device() to drop the reference count.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: c8e4c2397655 ("RDMA/srp: Rework the srp_add_port() error path")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
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


