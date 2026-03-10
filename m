Return-Path: <linux-rdma+bounces-17861-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPuoIyP4r2mmdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17861-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:53:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00923249BDE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 469F330CBD7F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A8C38735E;
	Tue, 10 Mar 2026 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsO3MvX5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582863859DE;
	Tue, 10 Mar 2026 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139727; cv=none; b=WmFSbcK67kxyRmloRFKc824T1OGztQCOnOU+eA1IgHhLyHcbrY9iUwFcaWykVoa6ifxCvDdUnV0sxvwOBu3YU6AGQVEJEPKFHxZDHt4Faj2pnMPttVBDgV4JDBT7hhMsTyjUWgTow9THsRTA4FyTZrq5EKuWZjaM+Dqa4GdDlSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139727; c=relaxed/simple;
	bh=gQD72fiJ8PyerPFoC9XHgV0ULHgkxGnVvcLiv8h3rIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBdkj2SQNokvI5jAEe8T1x8KsFJzWiNIxl9Ui3Ug5bFChkyEwAhBOG99kuc8CiWmDXT9Dp2lX+4kfxrSZF/oRPaCZokw1tjYREHs2jTW9m+0QE0Lu7kZ413tMyT1vOHSMf78fZAqy7PflLH4o8COJ1j0GIynesrtAj6zRJPSqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsO3MvX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6B2C19423;
	Tue, 10 Mar 2026 10:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139727;
	bh=gQD72fiJ8PyerPFoC9XHgV0ULHgkxGnVvcLiv8h3rIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsO3MvX5y6wfvDvWCv2pbgT/3hsKUKYKXyy1M8F0//zlZIhZxzMpVrirZ/s8TNz0d
	 rBq4P9/cfS2IvLUOrdxXr/y76H7BcbXkrZw0S/0b7AGJPl7CK4RDfQB14C9t0P8CIe
	 kzDe5Vdlo64sx/ZFvHnUo/XAunisyHx30E3pDxLQR2b79rUoYlbYBKvguO2GJzoVih
	 aMzMqoIZTM1gw/24y0W/BjF1ktohSViHV1yjHhqTYioe/SR/qXfHT72jdBJuEG7cx7
	 SKcCg0Z7mm0czTU/TuJVqtvZ8C4q6RipQgDmfz1D5ZQvxTxQx0+uWHv8jJL9l611oq
	 JW6aqdmlcwy9Q==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Danielle Ratson <danieller@nvidia.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 09/11] MAINTAINERS: Add entry for ethtool loopback
Date: Tue, 10 Mar 2026 11:47:39 +0100
Message-ID: <20260310104743.907818-10-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104743.907818-1-bjorn@kernel.org>
References: <20260310104743.907818-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00923249BDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17861-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,marvell.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,marvell.com,bootlin.com,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Action: no action

Add a MAINTAINERS entry for the ethtool loopback subsystem covering
the core loopback and CMIS loopback netlink implementation, and the
associated selftests.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a38fe0ed7144..37b134feffe9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18392,6 +18392,12 @@ F:	net/ethtool/cabletest.c
 F:	tools/testing/selftests/drivers/net/*/ethtool*
 K:	cable_test
 
+NETWORKING [ETHTOOL LOOPBACK]
+M:	Björn Töpel <bjorn@kernel.org>
+F:	net/ethtool/cmis_loopback.c
+F:	net/ethtool/loopback.c
+F:	tools/testing/selftests/drivers/net/hw/loopback*
+
 NETWORKING [ETHTOOL MAC MERGE]
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>
 F:	net/ethtool/mm.c
-- 
2.53.0


