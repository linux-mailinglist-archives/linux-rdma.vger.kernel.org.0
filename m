Return-Path: <linux-rdma+bounces-3881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB46E932456
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 12:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742DB1F23286
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735D81990CF;
	Tue, 16 Jul 2024 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XSouoMzh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B931990A5;
	Tue, 16 Jul 2024 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126898; cv=none; b=m84AJHaP9xQF7Vxwgl85D2/KsG9vMSl9TNWgnHfoE1S6pOE7hxU4e1q2i6znEu0yh0oZwGnz/fLF0wy8KkJtzce19Ix9815tkjx4N7Pbfwvkhelw5Ae8uIbBdu18qJEO2CtHTFXL5eWh770G+J0kSc6EGSe4OwrXBhhKvmRWtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126898; c=relaxed/simple;
	bh=kwXnYYTsPZ+8OivTVHdA3Z6bLGGc94C90/HgcsI2wSY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EAVYdjNuYp3juZCmYIJFfcVeT2hVgX4XBuNBm7Gx3klgEngABBEl/5wlGxTunIKgeS6rhEvYwqCUJm0kX0sZMPM4UtppAWWGXyb1Jca59U2QiKsCW/ekAfxigXQkLyotxJkY0rpODG+eot0mbb0cRfQU21s8OzehYAQvaRWWATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XSouoMzh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7AC7720B7165;
	Tue, 16 Jul 2024 03:48:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AC7720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721126894;
	bh=NL5QveyFxdWLVN7pf6xhONza+87pjRbnwVTLPqWyvso=;
	h=From:To:Cc:Subject:Date:From;
	b=XSouoMzh6o/aPbJo308wypaCI6IsJ+QFR0ujihdaLGkd6byfn7UxrMsAlL6/Sn/iH
	 JEoDqI0UGuYL9kA3VtJ3jJg4Nw9Bgc1aSY6CS5YsVoEq1k+QL+h+QDipVUej6Mt/UC
	 D42WwIcq6qlkhkR2hbdmxDAEL6RAROHfR4e8nstw=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	weh@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that inline data is not supported
Date: Tue, 16 Jul 2024 03:48:09 -0700
Message-Id: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Set max_inline_data to zero during RC QP creation.

Fixes: fdefb9184962 ("RDMA/mana_ib: Implement uapi to create and destroy RC QP")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/qp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 73d67c853b6f..d9f24a763e72 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -426,6 +426,8 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	u64 flags = 0;
 	u32 doorbell;
 
+	/* inline data is not supported */
+	attr->cap.max_inline_data = 0;
 	if (!udata || udata->inlen < sizeof(ucmd))
 		return -EINVAL;
 
-- 
2.43.0


