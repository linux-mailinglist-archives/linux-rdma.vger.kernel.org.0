Return-Path: <linux-rdma+bounces-9055-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489CDA7745E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 08:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCB13A87A1
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 06:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE3D1DB366;
	Tue,  1 Apr 2025 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="kBJe710r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D44690;
	Tue,  1 Apr 2025 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743488199; cv=none; b=pnAXOzD7wP2n1tb8y4Eyc31xzImojNiPxwa/9vxECZCo2IiEZWIMIb5IGOW2nYrruzrtmLG31JIvCaVuKpw/ueRZMTi2AI/PvpcBiROCJ1bqY7eqIZf1MDllN7eOrxXaf+7m2daSic0tZjqYWVPuKbCLW79Ei66pqEzLK8lPrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743488199; c=relaxed/simple;
	bh=Z8NqerlcGoOG+aaVto1jZC3JJTU9M/lUypli3aT8rjg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GRRnCQSpwRuPCnEgxNhZc+PquolynGTiDn6VfA8i/cU/Jgnzh/1crcGoSpuRCcXuToQAvOK3EORciMjqR7nFNWZ1Joonhb/EA50/KPPihzynE1zeah0TNS9jCKi4UdXJmhIH6EvzL2Qm9ta2vv0aYWWM1BvCilJdGaeQCLgXpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=kBJe710r; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 5316FqG3023749-5316FqG5023749
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Tue, 1 Apr 2025 09:15:52 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 09:15:53 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Tue, 1 Apr 2025 09:15:53 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Tariq Toukan <tariqt@nvidia.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] net/mlx4_en: Remove the redundant NULL check for the 'my_ets'
 object
Thread-Topic: [PATCH] net/mlx4_en: Remove the redundant NULL check for the
 'my_ets' object
Thread-Index: AQHbos2F9RohqMpRK0mdORQAbVJ5/g==
Date: Tue, 1 Apr 2025 06:15:52 +0000
Message-ID: <20250401061439.9978-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 2/17/2025 9:52:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=X+FeLn4yQ3EuUGa91ttWBxCVvRzj24Ap0XyairhLOG8=;
 b=kBJe710rNp6XE77GRLslW/h5oCWwYT963XzfEx3vzgnEw0c/ycheVu3EiX6DEredBQEOw9xgJ231
	H8GOsKetqxvVxXGh2lmh9S6zUorJUiLzQ8nbT8rVSuSoUwKuRJIiV8+NC8Rb9vt6QbSs7iT2mpMI
	ONI0tht/5K77fDn0AprIdI6Bjp5VWYxVSvbBLYR4q9VfFSB5qZPxp+Clp4aucl3O/jVQfV1uuILu
	ZBr/UwxQ03jA+0K1zzAEEfPFb1lsqV72HAsKeXE8SVSC/soRAWvNQ2tAPJnNTR274d18ABlmOlkB
	jkJWqY3grNBhAXZy8GhG1ZDSq3EnOFzhQ58AtA==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Static analysis shows that pointer "my_ets" cannot be NULL because it=20
points to the object "struct ieee_ets".

Remove the extra NULL check. It is meaningless and harms the readability
of the code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c b/drivers/net/e=
thernet/mellanox/mlx4/en_dcb_nl.c
index 752a72499b4f..be80da03a594 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
@@ -290,9 +290,6 @@ static int mlx4_en_dcbnl_ieee_getets(struct net_device =
*dev,
 	struct mlx4_en_priv *priv =3D netdev_priv(dev);
 	struct ieee_ets *my_ets =3D &priv->ets;
=20
-	if (!my_ets)
-		return -EINVAL;
-
 	ets->ets_cap =3D IEEE_8021QAZ_MAX_TCS;
 	ets->cbs =3D my_ets->cbs;
 	memcpy(ets->tc_tx_bw, my_ets->tc_tx_bw, sizeof(ets->tc_tx_bw));
--=20
2.43.0

