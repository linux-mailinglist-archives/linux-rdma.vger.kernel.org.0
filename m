Return-Path: <linux-rdma+bounces-13087-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B06BB43E3E
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 16:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A367B4464
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE23090EA;
	Thu,  4 Sep 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tssltd.ru header.i=@tssltd.ru header.b="JeeYWEfX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09612222AC;
	Thu,  4 Sep 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994963; cv=none; b=FnLD1Na7P3EMbBsduQoYB2sUt6PL6E26Fms0tiDJfJu8UnqsH4buxm9r4UwqGhJUV8eLn3lD38UGRZzydzvYWAm/7dl7ilq6R8RkydEZlirPDCc9lqSzB/668OVY4/bVfFjYVsTPxFD1AzXSD+N11fMpnKtJSTMXSx2/0LidOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994963; c=relaxed/simple;
	bh=MtJ9KgMwz26k/1+wjpdw/Jk4ZIf8u8I9hjoiEfwx0+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIBwu/0IP/sA/ZUYy8bM4HBFtWeymgcqUFD1N1227ryLemlF02TMq3F64CLn75ZeZjOW+K6bcv4julR4QwJwnDerfyBvJXl9gQvWJPWi288O20hXlZIkIAo2N447wiZqGsYbyf81VGRfUPS0v3qeEWxHxFM4V6X0qHH6xy3fcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tssltd.ru; spf=pass smtp.mailfrom=tssltd.ru; dkim=pass (1024-bit key) header.d=tssltd.ru header.i=@tssltd.ru header.b=JeeYWEfX; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tssltd.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tssltd.ru
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2d88:0:640:6173:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 512F480753;
	Thu, 04 Sep 2025 17:09:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id x8iXiBDLxKo0-2Wh0E6L1;
	Thu, 04 Sep 2025 17:09:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tssltd.ru; s=mail;
	t=1756994951; bh=pgnRYU/ABbfiGY5eazdRv6n0kD+q35Mnv95WLpyh9j4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=JeeYWEfXASoiMR08/NTKd4il2TS9ukPHa8VN8a3w/WVoH52DlLmC70RA+8vUBU/K1
	 C+VAyuz+rEoKz7H2EaYQ8OEWDK72pmpd4MoR8pQqedGdVn4yzR8FgTclTSgYnCqklr
	 tNIceVi0At7mMdzCT7U+mHmC6QUbVIEF43tXsTxA=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net; dkim=pass header.i=@tssltd.ru
From: Makar Semyonov <m.semenov@tssltd.ru>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Makar Semyonov <m.semenov@tssltd.ru>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] eth: mlx5: fix double free of flow_table groups on allocation failure
Date: Thu,  4 Sep 2025 17:08:56 +0300
Message-ID: <20250904140858.1690639-1-m.semenov@tssltd.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In macsec_fs_rx_create_crypto_table_groups(), when memory allocation for 
'in' fails, 'ft->g' is cleared once. However, the function returns 
a non-zero error which causes macsec_fs_rx_destroy to be called. 
Inside it, macsec_fs_destroy_flow_table is invoked, which attempts 
to clear 'ft->g' again, leading to a double free.

This commit fixes the issue by setting 'ft->g' to NULL immediately 
after the first clearance in macsec_fs_rx_create_crypto_table_groups() 
to prevent a double free when macsec_fs_destroy_flow_table attempts to 
free it again.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Makar Semyonov <m.semenov@tssltd.ru>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 4a078113e292..5e86c277f33a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -1066,6 +1066,7 @@ static int macsec_fs_rx_create_crypto_table_groups(struct mlx5_macsec_flow_table
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in) {
 		kfree(ft->g);
+		ft->g = NULL;
 		return -ENOMEM;
 	}
 
-- 
2.43.0


