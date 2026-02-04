Return-Path: <linux-rdma+bounces-16520-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHmHAx1Dg2nqkgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16520-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 14:01:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C06E61F0
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 14:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1E103011C67
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9191407597;
	Wed,  4 Feb 2026 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVEVU1cH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AB3ECBCB;
	Wed,  4 Feb 2026 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210063; cv=none; b=LaH6alHNNsPzubOU5gpXhZ/7kwLwKxbtZNJNoy5ckFVah5GkNUJI9BbWPXxJ8AWE0gWMYgCN/DExu+yInSWpQIW8Xo8LzsLFHZpWn3IAN5hkZ73Ux/doCURvmRR2+ur6vGLjw4gMk4h0oe1MTTKdhREngUNVbzLxUoSLk3eaWeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210063; c=relaxed/simple;
	bh=KwTfWpq86D9sO12JLnK7XQva4LmKulNdCMUHoaxRzRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E2FZkiwQN2eKEvPKR9QLHUKy03wvvNlHAmra1Xyq0S3BPamjTtUTaxjHH68y/68f6jl67I6oZ9zGFGG8rZl3SJBSjfVgZ1+m8eITNHuxBAb7KjWNLEOI6bOCR37okWyV+ikAqoTaV8L/RmrcKeQia2O9t6CTcbMq1om+DkrzuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVEVU1cH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD33C16AAE;
	Wed,  4 Feb 2026 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770210063;
	bh=KwTfWpq86D9sO12JLnK7XQva4LmKulNdCMUHoaxRzRE=;
	h=From:To:Cc:Subject:Date:From;
	b=AVEVU1cHdK/2ASt2v2RhR9lCuJMc76zYzPdqZlvRTwAMGWCAexUnw4HLGpTWXlPX3
	 z2H8H47glj4k4rQEiUSY4NjV3uTtWgf2G8BvcLk7lh6HMfF7Vv/vaQIaRasp5moBRy
	 eAkqCSWnOENQG3gjcGbGHBptwbp3wwp74nxU66lZKGNzHl5FlHFpPYDt4cKK+EaS50
	 rIh1rmphvJxsGKUMWp//T0ElO3WfsXoDA0GJou1B6M095KfeBOQtMaO8Mj1iicRzZ2
	 FrPx3i2DEFPeaRIx7Ra3XKVjUl1zoDHTHDeUfcyYLxD7O5dCJjHD37C4TYaBAIMQxz
	 TXPrJ1DyLTl3Q==
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
	Jianbo Liu <jianbol@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next] net/mlx5e: fix ip6_dst_lookup link failure
Date: Wed,  4 Feb 2026 14:00:49 +0100
Message-Id: <20260204130057.4107804-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16520-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38C06E61F0
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

Changing mlx5 to call ip6_dst_lookup() means it now fails to link
when IPv6 is a loadable module but ipsec support is built-in:

ipsec.c:(.text+0x1061): undefined reference to `ip6_dst_lookup'

Add a Kconfig dependency that removes avoids this configuration.

Fixes: e35d7da8dd9e ("net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC init")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 9cf394c66939..c298efe93f97 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -154,6 +154,7 @@ config MLX5_EN_IPSEC
 	depends on MLX5_CORE_EN
 	depends on XFRM_OFFLOAD
 	depends on INET_ESP_OFFLOAD || INET6_ESP_OFFLOAD
+	depends on IPV6!=m || MLX5_CORE=m
 	help
 	  Build support for IPsec cryptography-offload acceleration in the NIC.
 
-- 
2.39.5


