Return-Path: <linux-rdma+bounces-19714-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK3XGXA48Wn4egEAu9opvQ
	(envelope-from <linux-rdma+bounces-19714-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:45:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA48348CC06
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88EFB305AD6A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4238424B;
	Tue, 28 Apr 2026 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtUy9M9+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C5B37F8DB
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416297; cv=none; b=ridv3Wip/vMr57B4o9AmbM4EujwXFfMH4AMP3FuG23rkxojwn0dexSpka/O/kUvzlyvTbaUAHHWvSRmSpTPmFp+Q1B10G9ZfbtEszh7ynYIV15ZB/PejIrrKOJnfoOYbePWQyZaG6ooFW2NrcY9ZGN147uGIIlqQdBm8bgKOMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416297; c=relaxed/simple;
	bh=ai8QUQpe+eGBNcBYzX5wgc4QtQufT5uTE6GhpsaCC0Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ghit+WOszhVUGAqNfELp8CNKHU2d98/OQWQmfuW4Hd9OPuE+LJw4Pkr6jD4VoANif0V0uQHFVsWttP0UBZJDlsHjAWIizDaH/fU8ifkHFo9hXknC102ni2/S8sOX1UCoAKpoMuX/lbbH01ncmWJas1eWlvi7obqc5eGizwtafq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KtUy9M9+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so14721022eec.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777416295; x=1778021095; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4TUkxWmkceVVg+Z+lQyOtJ2XfCE43FvOGg/yLxop1NU=;
        b=KtUy9M9+B3xni5dI9gUq6zNtsKaHFeC6cQ/4AOe6tKCbZa1OrIMPu/TORV23hCT73O
         t4N34CU8YoLuUwuv5sG8UKGA1gkGqr4wMUfN8T9fiY5ZJfZrQ918UJCzKCjeEJdfW/0A
         Ab/LCF0AMzU1xQ01TKSmz9xhXTxyik2JZxC+CE7dvsucEb5eS13nXKHPzVXEsegOBwwM
         HShdGQqJxsKEAinIqalGUFQZpnt/9cz489ZMZVsVRNKAyLYVEa0+hYGi1TqbS8ake+2Z
         nEKdkJ2CDyFicx8Qkt9pxA4awa2QZTBoP4OB0FrpFTPIyNHZ3vfsPmlZErR6aXq9N03A
         ZVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416295; x=1778021095;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TUkxWmkceVVg+Z+lQyOtJ2XfCE43FvOGg/yLxop1NU=;
        b=N/qReiNwXziEfHL1Z33/oqNUDQx9xhnS0aGGrd2k3yzo/oCmbOQGQPTFoN8sWU1lok
         KznawKhvVs1jH22/9XuQUt+LqkcW4GAJis1EAVsLeXXoLHEprjm9dFXpD9Tt+41BCvIm
         XAE200sVUTYvqmD7rSy4n1Myta6KoSKnn4DsBBc69MSa6JfFBs0YYNcqKznmDnRRcsPp
         0+NDA/WJaS1qKoh/cfTXmGEX4xBR0x5YPuv2AI8i34BX0grfUfZ6hen6xC5+rKrFHExY
         +ObYnHZdlERijBl215HkHX+93qHrnKQhO8RXSksU7FyeZDfoqfFqMxcUiJ5QzdPhvtl8
         cwfA==
X-Forwarded-Encrypted: i=1; AFNElJ8Vavl28mZ0jNw1bBABzoF41DNNZf4RLCtCy+z7qc+Pczqi6xAgNYFBLI4zgtyRhJVdcU67D0xLakir@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWVT9g14DF5v2RUgm+1bDMMh9iZMxjBYVwczL+9vq0NSvq/Uv
	dWQ8YD6ABNO9nUH8w1RcJKQpO5AyMFPFy008e1d8QBb4OqSUjgvMo/+Aq2pKORE8wT7C1JpwGw6
	cl2bcK0yRM0QHqwqGoyCMcQ==
X-Received: from dycoh5.prod.google.com ([2002:a05:7301:da05:b0:2d8:4599:1d20])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:d8f:b0:2d8:b814:29af with SMTP id 5a478bee46e88-2ed19716925mr687253eec.3.1777416294853;
 Tue, 28 Apr 2026 15:44:54 -0700 (PDT)
Date: Tue, 28 Apr 2026 22:44:34 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFI48WkC/x3MTQqAIBBA4avErBNKsr+rRITWVAM1hUoI4d2Tl
 t/ivRccWkIHffaCxYccXZxQ5hnMu+YNBS3JIAtZF5VsxHkENT3h0CyaUtVdZ1pjUEMKbosrhX8 2AKMXjMHDGOMHGgZed2YAAAA=
X-Change-Id: 20260427-mlx5_vxlan-715699b8bbea
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777416293; l=3018;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=ai8QUQpe+eGBNcBYzX5wgc4QtQufT5uTE6GhpsaCC0Y=; b=vg5g7vP2EM46YpgEoKVKKpCPrEdNIlWCVg6lGbsIIfELTu4gk8o+Fa/nww2xQIL96DpvPEsWc
 eoaHiL67gr0DIzm5DhBIKIZ4TR7fBMGOajPs2Xar5rRs+twXcU0iEgS
X-Mailer: b4 0.14.3
Message-ID: <20260428-mlx5_vxlan-v1-1-cf666d042618@google.com>
Subject: [PATCH net-next] net/mlx5: Add MLX5_VXLAN config option
From: Marc Harvey <marcharvey@google.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
	Marc Harvey <marcharvey@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: BA48348CC06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19714-lists,linux-rdma=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Currently, there is no way to disable mlx5 vxlan offloading if vxlan
is enabled. We've (possibly) seen some minor udp rr and udp stream
regressions when enabling vxlan, and want a way to disable this
offloading. Also coupling vxlan offloading with vxlan enablement
generally limits the flexability of vxlan setups.

Add a new config option for mlx5 vxlan offloading specifically, so
that users can use vxlan without automatically opting in to the
offloading.

To keep the same behavior as before, the new config option is enabled
by default if vxlan is enabled.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig     | 11 +++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/Makefile    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.h |  2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index 3c3e84100d5a..d2e091bdbafc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -218,3 +218,14 @@ config MLX5_EN_PSP
 	  interfaces to PSP Stack which supports PSP crypto offload.
 
 	  If unsure, say Y.
+
+config MLX5_VXLAN
+	bool "Mellanox Technologies vxlan offloading"
+	depends on VXLAN
+	depends on MLX5_CORE_EN
+	default y
+	help
+	  mlx5 device offload support for vxlan. Makes the mlx5 driver always
+	  attempt to initialize device handling of vxlan packets.
+
+	  If unsure, say Y.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index d39fe9c4a87c..6f2cc5414d07 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -86,7 +86,7 @@ mlx5_core-$(CONFIG_MLX5_BRIDGE)    += esw/bridge.o esw/bridge_mcast.o esw/bridge
 
 mlx5_core-$(CONFIG_HWMON)          += hwmon.o
 mlx5_core-$(CONFIG_MLX5_MPFS)      += lib/mpfs.o
-ifneq ($(CONFIG_VXLAN),)
+ifneq ($(CONFIG_MLX5_VXLAN),)
 	mlx5_core-y		   += lib/vxlan.o
 endif
 mlx5_core-$(CONFIG_PTP_1588_CLOCK) += lib/clock.o
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.h
index 34ef662da35e..67d0c126c2ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.h
@@ -50,7 +50,7 @@ static inline bool mlx5_vxlan_allowed(struct mlx5_vxlan *vxlan)
 	return !IS_ERR_OR_NULL(vxlan);
 }
 
-#if IS_ENABLED(CONFIG_VXLAN)
+#if IS_ENABLED(CONFIG_MLX5_VXLAN)
 struct mlx5_vxlan *mlx5_vxlan_create(struct mlx5_core_dev *mdev);
 void mlx5_vxlan_destroy(struct mlx5_vxlan *vxlan);
 int mlx5_vxlan_add_port(struct mlx5_vxlan *vxlan, u16 port);

---
base-commit: 790ead9394860e7d70c5e0e50a35b243e909a618
change-id: 20260427-mlx5_vxlan-715699b8bbea

Best regards,
-- 
Marc Harvey <marcharvey@google.com>


