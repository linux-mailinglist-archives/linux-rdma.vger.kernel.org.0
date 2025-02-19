Return-Path: <linux-rdma+bounces-7868-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB64EA3CB98
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 22:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A75A177919
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 21:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B9C2580ED;
	Wed, 19 Feb 2025 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sKzajk2P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6282580DC;
	Wed, 19 Feb 2025 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001006; cv=none; b=s9PtbOI1giCCE0Nmvk6SsSGzMjhPVF1v/GpXqVt2vo1sBwOjMPm8JzA0zcr+L1NWdjB0fgm+tAXnDNMM/f02BlhqYZ5qnLACE7IKyM+lfxUSJyqsAbF6DrVqHvTFFwPKJWZcYu+bEiq4cs6NLzxiPIA5VTHg/IEIqL+IbWP8Qhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001006; c=relaxed/simple;
	bh=DIcU1uig5I4dPitBVIdvL40b2CK1pCK/SuKGFIo/NHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZZFRPaThHoynMnJRsGsww/FdHQiiQqSu3BKO+KjdvUx+hxLlszEJkyMri13tvjm0cm9F2EhUPpE6NOxQF53Q+FAkDbTtotIp0O7+Tl9zAzAtubRSNyTREP9k0sk1pKGQo/qc4f17q8QMULncEOf4v9e62uXROoi7/mupEpiNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sKzajk2P; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1E62D2043DEC;
	Wed, 19 Feb 2025 13:36:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E62D2043DEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740001005;
	bh=Q75Z4qe0KB1DGcu4mQDnDhnSTzwOml5U+Zz4/sYRLuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sKzajk2PsVNTIubnGc6W9a5mBNhQBgJc/6XhKcHKZFGds606jBJaICbaHAluVa7NY
	 PgE/o5gB+Vmvo2ZpHKtruV+Q58LCadPbPTeLhDiLA5BLXTVg5GQWgbxeqT/Rx3zURj
	 3ViTYuJUGsyAb40nssY7NEQfGkiT7zzNxFHaCSVk=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 19 Feb 2025 21:36:39 +0000
Subject: [PATCH 1/2] RDMA/mlx4: convert timeouts to secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-rdma-secs-to-jiffies-v1-1-b506746561a9@linux.microsoft.com>
References: <20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com>
In-Reply-To: <20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com>
To: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies(E * 1000)
+secs_to_jiffies(E)

-msecs_to_jiffies(E * MSEC_PER_SEC)
+secs_to_jiffies(E)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/infiniband/hw/mlx4/alias_GUID.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index d7327735b8d0d4dd57d44ab1c71554ebf11ce6ce..527f52e41577af3dee60e695f25741f824762fd3 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -437,7 +437,7 @@ static void aliasguid_query_handler(int status,
 		queue_delayed_work(dev->sriov.alias_guid.ports_guid[port_index].wq,
 				   &dev->sriov.alias_guid.ports_guid[port_index].
 				   alias_guid_work,
-				   msecs_to_jiffies(resched_delay_sec * 1000));
+				   secs_to_jiffies(resched_delay_sec));
 	}
 	if (cb_ctx->sa_query) {
 		list_del(&cb_ctx->list);

-- 
2.43.0


