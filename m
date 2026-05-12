Return-Path: <linux-rdma+bounces-20474-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL1LIur1AmqfzAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20474-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:42:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 060AA51DF3F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BB0C3062DB5
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCBA368D74;
	Tue, 12 May 2026 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JZARelot"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C4228A3F8;
	Tue, 12 May 2026 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578860; cv=none; b=nmnkMsG3moLtDRpbJ3RDpWrOTDlb1VeAODPJTIqTo+2/JCS42kHIjFOZL+Cz28xj0bN9l8NeVX0IgeA5yjOouOyMny7Ty+fr9dDhirjJ+GgpsxYLLFcQqG9hdJPJpTGyZqf5y64bD12venQIJZgR0D5cNGhCkwoolZpw/JMRg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578860; c=relaxed/simple;
	bh=Xd/mVS+Jxp0+Vw0Ci0gL7YtydwscZdfP/nISbhk/WXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jP95mf9nR9GgkWFw7HPYnDLxaMkTKZumxCTrxlZC1QrnnfQBBYib2XIvn6FtagHkraENHc2GVyNKKor9nY7I0pZ/sFjP4hTYFjz0mZ6vNjGt8ode7Hcq4r7QPvVfhWdcNo+G/OYo+WY/o6mFQ9ObWtJpprSqbhh7FxZmloIW5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JZARelot; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id C3B3320B7166; Tue, 12 May 2026 02:40:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3B3320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778578856;
	bh=yyIn0PUcqGmgv6EzlMUgFGnK/vQDpGEyuNlEe+4xQTs=;
	h=From:To:Cc:Subject:Date:From;
	b=JZARelotzi66/srGsdydU/OlW2FNHoZxqI0m51FVLyik4zzWdHzp90mvOGgN4kiFh
	 Mm/8Il5f3ubgt5T3za8JId60qhksoe+CwDTL84NmLmHXfc43maXybSVX/9AM//KxDW
	 zsHIB2E/hDupu1YH+n2pldjPWXhvZqMN/hF+yr5A=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mana_ib: Use ib_get_eth_speed for reporting port speed
Date: Tue, 12 May 2026 02:40:56 -0700
Message-ID: <20260512094056.264827-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 060AA51DF3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20474-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Shiraz Saleem <shirazsaleem@microsoft.com>

Replace hardcoded IB_WIDTH_4X/IB_SPEED_EDR with ib_get_eth_speed()
to report the actual link speed in mana_ib_query_port().

Fixes: 4bda1d5332ec ("RDMA/mana_ib: Implement port parameters")
Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index d4dfbec..9af92a4 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -633,8 +633,7 @@ int mana_ib_query_port(struct ib_device *ibdev, u32 port,
 		props->phys_state = IB_PORT_PHYS_STATE_DISABLED;
 	}
 
-	props->active_width = IB_WIDTH_4X;
-	props->active_speed = IB_SPEED_EDR;
+	ib_get_eth_speed(ibdev, port, &props->active_speed, &props->active_width);
 	props->pkey_tbl_len = 1;
 	if (mana_ib_is_rnic(dev)) {
 		props->gid_tbl_len = 16;
-- 
2.43.0


