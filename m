Return-Path: <linux-rdma+bounces-22417-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GjVoN08uOWopoAcAu9opvQ
	(envelope-from <linux-rdma+bounces-22417-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 14:45:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B276AF875
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 14:45:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eqfWTanM;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22417-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22417-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3893C30517A5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 12:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6EE3ACA77;
	Mon, 22 Jun 2026 12:42:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF03ACA51;
	Mon, 22 Jun 2026 12:42:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132156; cv=none; b=f5WF1n1DllTnrGQ+IdZahzQ1T9KWbmfc7QnKuqB2lFsqkGQuIaCLG29eEegBKj3gHE8cAhwm1aH+XhyAVDI1+kySUuFLWISd4hJrPJmiDezR9hMN8m8cYPjTwM4NwyDd1RyJzLfOfI5V3GbI5KbiDw9mRv6r3daTWhPYZ+u8Auc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132156; c=relaxed/simple;
	bh=7N2TAafp+SmVEnFS/PlW2wcFbqKinOTiwEw8rfZSR6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UjDa1mgerkVJjCR/5mvz9fEiuP6ngQnvwaUFLyU4HDJt/uJAHsA0tf2p8MinXm60oZSPuC6r8uHiB9UTTaWibKqM+l/784HefhmVuRa7LthwmMYeDtel5Qoj6Qq8wrmQirl8NOZiH0lOuhk4rqZuXZdP8EC7q3w5BF0p3dQMrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqfWTanM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CD61F000E9;
	Mon, 22 Jun 2026 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782132155;
	bh=CgKo/nqGF/gxh7rMoUxHIPw+Kwmsxo0ahLadQcPxeRQ=;
	h=From:To:Cc:Subject:Date;
	b=eqfWTanMnrzYj7XiReTwHaFp12eloCG96U716NFElnvA970BTuSY/ZaB+rC2CE2nr
	 qZXQHN4Fo0l7OsVDzTrkUSqc0HUfFGnZVPJMacTn6wPg5ogvEXk4L9Q6b+Qoi3agLW
	 B7u6GuYKp9zDRC/50VKMdUR/iBeg/xUuJIHtew+Z2wWujh4Fd9wM8rrYK0i8VbxmmY
	 I49YhAyj8rc7bs+lNZZjLB3fxuTAuq5zyyMdTpzTZxUWGv1F4EfG7B9jZWps++96be
	 TBrTZlqMvpXTkXyPd9Xo+1Ek/s9R43RKB/fwJYtpaUYRWedz/IqdLxVsaYzjq2uGHW
	 xNUNYNt6qo7EQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [net] eth: mlx5: fix macsec dependency
Date: Mon, 22 Jun 2026 14:41:07 +0200
Message-Id: <20260622124229.2444502-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22417-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sd@queasysnail.net,m:arnd@arndb.de,m:daniel.zahka@gmail.com,m:rrameshbabu@nvidia.com,m:raeds@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:danielzahka@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[arnd@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,nvidia.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50B276AF875

From: Arnd Bergmann <arnd@arndb.de>

Configurations with mlx5 built-in but macsec=m fail to link:

x86_64-linux-ld: drivers/infiniband/hw/mlx5/macsec.o: in function `mlx5r_add_gid_macsec_operations':
macsec.c:(.text+0x77d): undefined reference to `macsec_netdev_is_offloaded'
x86_64-linux-ld: drivers/infiniband/hw/mlx5/macsec.o: in function `mlx5r_del_gid_macsec_operations':
macsec.c:(.text+0xe81): undefined reference to `macsec_netdev_is_offloaded'

Fix the dependency so this configuration cannot happen.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
First seen on next-20260615, but probably an old bug.

I could not figure out what caused this error to appear, I have not seen
this combination in many years of randconfig builds that look like they
had the bug. My best guess is that there are so many other dependencies
that it is simply very unlikely.
---
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 9cf394c66939..ba944763a737 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -144,7 +144,7 @@ config MLX5_CORE_IPOIB
 config MLX5_MACSEC
 	bool "Connect-X support for MACSec offload"
 	depends on MLX5_CORE_EN
-	depends on MACSEC
+	depends on MACSEC=y || MACSEC=MLX5_CORE
 	default n
 	help
 	  Build support for MACsec cryptography-offload acceleration in the NIC.
-- 
2.39.5


