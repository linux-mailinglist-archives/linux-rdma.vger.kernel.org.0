Return-Path: <linux-rdma+bounces-6746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C1F9FC9D0
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 09:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62847188350E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BFB1CEAB3;
	Thu, 26 Dec 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HinYL/QO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F114A609
	for <linux-rdma@vger.kernel.org>; Thu, 26 Dec 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735202515; cv=none; b=TQzQJqE9Eua+/jxw6fdW7w4sAuiW769UehLWjDyBIqgy01KztJenVsbX72Yj2a1YriX1MoH5h3dPthk8lZ+Dv8tXZQ3Om9t3j4x+oJCxcwdg3u74vktTlIYCrumpFlEmpyGRbxIwqgE1Vvkjm8TQXU4xT9G0jVbK6K7kYA01E+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735202515; c=relaxed/simple;
	bh=I/Nw8VRubgilFK82JSR2f3N92gy97AlW9HustgKXXoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMcKHPk8lhOohKVhGTfxOHCz+zzPgy2C1+Xhqm4c4Vvjwt4nwDS5yLVRsTNKJCxc7B9VjbTNWJ+PeUjrnI2mFN6F4oRw8fF9FydPi3d6fci1TcJM9HpIr6tdlmmhm9CgDksKpL374vfV+9i1qhSzIt3MJilYVoEWxahLXugC4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HinYL/QO; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735202504; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VoyQleDJpskEXLRTNq1YQJO3Tytm1tcqPfIkJWJ1RMo=;
	b=HinYL/QOE7cJwjXNvlSWk+dBZKG6+eJRSxolmlpNmsQdqPpr7S0KbVe3CYy9jF79IA3EtwnacXUwYjDgAl4RDW77/Dk8f8q1M6P9olqGpua40/QFtGW26as25oUT16YNv/yYZnunihzA7BiCOnQ6F1mi+Md7qyhZKISS3q3XliU=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WMHWDlB_1735202503 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Dec 2024 16:41:44 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next 1/4] RDMA/erdma: Add missing fields to the erdma_device_ops_rocev2
Date: Thu, 26 Dec 2024 16:41:08 +0800
Message-ID: <20241226084141.74823-2-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241226084141.74823-1-boshiyu@linux.alibaba.com>
References: <20241226084141.74823-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the query_ah field to the erdma_create_ah() function and set
the size_ib_ah field to the size of struct erdma_ah.

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 51cc8b17b9e9..29505bc11168 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -486,6 +486,9 @@ static const struct ib_device_ops erdma_device_ops_rocev2 = {
 	.query_pkey = erdma_query_pkey,
 	.create_ah = erdma_create_ah,
 	.destroy_ah = erdma_destroy_ah,
+	.query_ah = erdma_query_ah,
+
+	INIT_RDMA_OBJ_SIZE(ib_ah, erdma_ah, ibah),
 };
 
 static const struct ib_device_ops erdma_device_ops_iwarp = {
-- 
2.46.0


