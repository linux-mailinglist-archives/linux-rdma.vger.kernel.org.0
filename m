Return-Path: <linux-rdma+bounces-11872-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBD1AF7ED0
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E43A3AAD6E
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152B8289E3C;
	Thu,  3 Jul 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Yj22ejvx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355F288C9B
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563623; cv=none; b=tkTpsN6oRTeh66aTwPOJUbK0i2FQ55n/26RuYKf1P5KDS8VmUuc/NuRhIokVjWVbk1xpUN3s1JVFSKH1pen5CBeNe3TfvwiTE2h2Y4nZNr/VYCnA3ikSbDqQGE7Bff/VypqLcMIuhZSsI5XMlRMG4hbd8yUvsaV71FBaqD5f/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563623; c=relaxed/simple;
	bh=NHYdKNB6Snp+Y4bSHTcN9fArSweJ37pA2U4m5YKbEwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BeGOZ1ZxJG5ILrP422MgN3PoqtQUOAD9eWptdwNAdHOqHP/xdgmB9UXvjDCcjNCyDipKwnAod3dKz2BQUeZHbaZj7GfOqeWRZuzbnftUtoj++FoxHPxPXO4dEWyMbkWhhS2dxzbwhEKvfBHRGSNuuEAEAPlwHWuCNWdlRGoEQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Yj22ejvx; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-Id:Date:Cc:To:From;
	bh=g5KVGZefrv7sGYM8KMYJrC6fgoFU7XK2/y1NlsHoPCM=; b=Yj22ejvx02wO/ZWCtIKBluQKUa
	lI3HnjG4KiZQzKXab2vH4f4Rk/22mtod52jWoR4BPN6UgMzjoSgWesJ5VQn1O7RAmyw2eM3SWKora
	PNnLZlC8cJDt12S2kVtUM2ARvpfhlbiaJ1CiNAHirwaMngogkYbo2raD+84FMgN5zmaiBgP8FfwAr
	iK2nNB4WaN3G86rBcLdbgM2D2hhKeOgQlzIinAc94hzeFOJVIjn7ra/YMpn1MmMWCn6z00XhBa//a
	T/vpyuG748Gv2famllFfQHZJfDvj7hy5eVw1ZXf4F8JUw6ZhloE2/1Aq0OXm5d3wkyGLSc0NM98qm
	TSn/38j8suQtwdULLL1kLdt5d0WYv8DQzQqhJ//nhKPKj3aH/+pDlVR6sg0Mu8DvSpc7Dv1Gp8Thp
	jRYKtYWQYOrkPegg6Ho+dSCSgdTk+Afdv1jJ3y6sON+mXpBPipqKIWfSO1lRw75DlYljRbiSEAmPW
	0ljDrwnSzcjNnXqr7QilRSNr;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uXNi7-00Dp2P-2Y;
	Thu, 03 Jul 2025 17:26:59 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 2/8] RDMA/siw: remove unused loopback_enabled = true
Date: Thu,  3 Jul 2025 19:26:13 +0200
Message-Id: <d0f0ddbf86e2570f51d32ccacb612336a820f855.1751561826.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1751561826.git.metze@samba.org>
References: <cover.1751561826.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices are created explicitly by the administrator using
'rdma link add siw_lo type siw netdev lo'.

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/sw/siw/siw.h      | 1 -
 drivers/infiniband/sw/siw/siw_main.c | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 3e04357ab197..3bdc17eedbe7 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -490,7 +490,6 @@ struct siw_user_mmap_entry {
 /* Global siw parameters. Currently set in siw_main.c */
 extern const bool zcopy_tx;
 extern const bool try_gso;
-extern const bool loopback_enabled;
 extern const bool mpa_crc_required;
 extern const bool mpa_crc_strict;
 extern const bool siw_tcp_nagle;
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 4e1d29832ac8..ba238b0b43a3 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -38,8 +38,6 @@ const bool zcopy_tx = true;
  */
 const bool try_gso;
 
-/* Attach siw also with loopback devices */
-const bool loopback_enabled = true;
 
 /* We try to negotiate CRC on, if true */
 const bool mpa_crc_required;
@@ -94,8 +92,7 @@ static int siw_dev_qualified(struct net_device *netdev)
 	 * <linux/if_arp.h> for type identifiers.
 	 */
 	if (netdev->type == ARPHRD_ETHER || netdev->type == ARPHRD_IEEE802 ||
-	    netdev->type == ARPHRD_NONE ||
-	    (netdev->type == ARPHRD_LOOPBACK && loopback_enabled))
+	    netdev->type == ARPHRD_NONE || netdev->type == ARPHRD_LOOPBACK)
 		return 1;
 
 	return 0;
-- 
2.34.1


