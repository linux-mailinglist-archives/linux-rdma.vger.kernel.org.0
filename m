Return-Path: <linux-rdma+bounces-22937-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5HhOBkJoT2qXgAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22937-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:22:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD94172EDB1
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:22:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Wzp5ehyT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22937-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22937-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CAC430418D5
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E53FFFAD;
	Thu,  9 Jul 2026 09:07:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004823A9637;
	Thu,  9 Jul 2026 09:07:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588030; cv=none; b=oIpxCtdaG3KWqnndsav/S9R7Kj19cS/gr6v4nwvwzAkNRVp/dJm1i31hS1U7V6rimFnLWfYzoFN1HUY1YjDSWcJh+4aT2jNy/f/MsN4MUFXgyUTPxmcLyHntAr7UKPFZoK8wcjfdAlQmBW4g2c9scfr4GqX2DgR9E9hF+IwKXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588030; c=relaxed/simple;
	bh=YqGTFXXwaBxejDhGIlAmgJGgYNQNb2l6zWVKumm7B3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSdTDl9NJBNX8QImlQUDxM5mQMM/YBXVZmBhmzzEUTm9WvcRqqO6zMZ89be+GqLMPK9sGuZPvp4CBLPZrDG2PbswOAxMbcgBbhBmhHQ3a8ZZ26AEqTJ7ItnsoGOCOKfW+QbKOdgJbNbYApRBNYcGgaY5heaDop/vODzMWlCA7pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wzp5ehyT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9886B1F00A3A;
	Thu,  9 Jul 2026 09:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783588022;
	bh=U3XOGRaR0N21rRliS5SFngFh7cxtdsXZfiNTup9fft8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wzp5ehyT6lCOqDIzn7EO+I0kcJtqJrrLmBB2TsLXhkvCg+5meUCl4F4xiiOjatch9
	 9onBVkDX6PBGX37lpIl57lHGLG4CNQD+9kCYKope9srIFuYg6ksBkg/WECjiPnypPS
	 2hZ1DReVKdb1gceCopKmdNzV09m9aAS5W6uzKrgXPkhEyg0o3w2ZYnN2n82yGmLAQ0
	 27AcrplfdXrv6RefQCCdPnf+eK1sBPDh1Xz1C5GMSZ9P3tc5ZS38ghSrVYL7+CqZ83
	 BA8KNdzpP4YppljYQQltE/HlBkmBLXL/cbKXnfRZg4K8ZBDu4WMVITw4FpXX3rkDnk
	 tclLFxflX8t6A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH rdma-rc 2/3] RDMA/mlx5: Drain RCU callbacks during module teardown
Date: Thu,  9 Jul 2026 12:06:48 +0300
Message-ID: <20260709-unload-rcu-v1-2-fccd27211e5a@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709-unload-rcu-v1-0-fccd27211e5a@nvidia.com>
References: <20260709-unload-rcu-v1-0-fccd27211e5a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bigeasy@linutronix.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22937-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD94172EDB1

From: Leon Romanovsky <leonro@nvidia.com>

devx_free_subscription() can remain queued after the last DevX event file
drops its module reference or an auxiliary driver detaches its devices.
mlx5_ib can then unload before the callback runs.

Registration error unwind has the same risk because driver registration
can attach existing devices before failing. Wait after all drivers have
stopped.

Fixes: 6898d1c661d7 ("RDMA/mlx5: Use RCU and direct refcounts to keep memory alive")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Closes: https://lore.kernel.org/linux-rdma/20260708092316.Qb39F_B0@linutronix.de/
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 02809114fc79..4ff6cca7e581 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5538,6 +5538,7 @@ static int __init mlx5_ib_init(void)
 dd_err:
 	mlx5r_rep_cleanup();
 rep_err:
+	rcu_barrier();
 	mlx5_ib_qp_event_cleanup();
 qp_event_err:
 	destroy_workqueue(mlx5_ib_event_wq);
@@ -5551,6 +5552,7 @@ static void __exit mlx5_ib_cleanup(void)
 	auxiliary_driver_unregister(&mlx5r_driver);
 	auxiliary_driver_unregister(&mlx5r_mp_driver);
 	mlx5r_rep_cleanup();
+	rcu_barrier();
 
 	mlx5_ib_qp_event_cleanup();
 	destroy_workqueue(mlx5_ib_event_wq);

-- 
2.54.0


