Return-Path: <linux-rdma+bounces-13079-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57517B43A9F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 13:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BFF16DB96
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984C32D3A6A;
	Thu,  4 Sep 2025 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tssltd.ru header.i=@tssltd.ru header.b="nox8eHut"
X-Original-To: linux-rdma@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A24F5E0;
	Thu,  4 Sep 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986441; cv=none; b=iMLupmluEGtcdhnfknwgb/DFErAZs6xnTnlnvKfOf9Zz7nahp70zr1O+0iR7mrNTZSv39vRST7IZNjdRRXlLTh7x2zORq+LCrptuhDgWXQ4pLxubawfOG45qTY3I+sF8mxzB4U4yVxVQhU9cYAODSBf9vr/bMNTV204muDGIAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986441; c=relaxed/simple;
	bh=eU0pAAUSTEMk1Ip9oUp5tHbyh9N2PF1Q+GJ4mSibmEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D69141/KiTaFewDjCRz9tocDJW0GkuZAkiA9qpYODlmkeiXFsgRQUYlHh4LomrjIBJ4L03lhZzHq75PGbei90pgNfKBIwch/vZCouC0gZJwfuFz3+3/bBTuQuLd9Vp5P9fwi3Wb95D+m8Sk3fJLM0gh2/HxY6veX6mfyMlk2Des=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tssltd.ru; spf=pass smtp.mailfrom=tssltd.ru; dkim=pass (1024-bit key) header.d=tssltd.ru header.i=@tssltd.ru header.b=nox8eHut; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tssltd.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tssltd.ru
Received: from mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2804:0:640:a3ea:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 01D4BC007F;
	Thu, 04 Sep 2025 14:47:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wkfpU3BMrW20-SDqaNxRz;
	Thu, 04 Sep 2025 14:47:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tssltd.ru; s=mail;
	t=1756986432; bh=N8JZ1L+AwE+5TOAbWcWZrSZZ6n49/LPiJFmkjDn8898=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=nox8eHutnenZSyFHc25zlkvb9vKbhVsf6v8ijnym6lLUhv8q5ltC42KzGrvwDxDLe
	 1D235tlGY0KhXm/oA7WxKlflkMFffdIq/wk+gGpmo/+VnhG+dSEKE/tteuU/k6t4lS
	 VN/5NI/TEN+3LjppHlS9xSjEeOiJBkCHE1tbQpUI=
Authentication-Results: mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net; dkim=pass header.i=@tssltd.ru
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
Subject: [PATCH] macsec: fix double free of flow_table groups on allocation failure
Date: Thu,  4 Sep 2025 14:46:54 +0300
Message-ID: <20250904114655.1674691-1-m.semenov@tssltd.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In macsec_fs_rx_create_crypto_table_groups(), when memory allocation
for 'in' fails, 'ft->g' is cleared once. However, the function
returns a non-zero error which causes macsec_fs_rx_destroy to be called. 
Inside it, macsec_fs_destroy_flow_table is invoked, which attempts 
to clear 'ft->g' again, leading to a double free.

This commit fixes the issue by setting 'ft->g' to NULL immediately 
after the first clearance in macsec_fs_rx_create_crypto_table_groups() 
to prevent a double free when macsec_fs_destroy_flow_table attempts
to free it again.

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


