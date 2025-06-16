Return-Path: <linux-rdma+bounces-11326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106BADA75A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 07:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390157A1876
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 05:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AA51AB52D;
	Mon, 16 Jun 2025 05:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="XhHhVosD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.crpt.ru (mx03.crpt.ru [91.230.251.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF51863E;
	Mon, 16 Jun 2025 05:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.230.251.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050400; cv=none; b=N6rj87M5aGY9y5i6gSTIIqpWTsNc4Ppw3kzt9TT3pe0/PaVX08ZLrOAVsnH+9FUNf7YbBtkKlqrfwbPzAnngM6329cD6xy2HRDZLSGjp/JDZk44BheUmvNEAaP/20ju83LZ3HWg9wpGZzqKeHgCQ9mOQFVLPfF/ywfkZyk8FeCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050400; c=relaxed/simple;
	bh=Bc+zA+sHr92wmJmoKBYrXr1MsDN1MT+rlsejLa9BpY4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DvZda3r/SlGhs5fA+197y8Tly77vJ62q8yAgBSkxt4eKlbdtGBXryWcYSIrlPlPI1RlajcfnWKZaB9E3g+9/zxjqxd7xmg1IbedyJ77KgmctLd5so977hoHCtfdZfTXBXKv88YGIUJM8KiSQ8Zaq/axOON1pkg9pWGGcaaw/SAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=fail (0-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=XhHhVosD reason="key not found in DNS"; arc=none smtp.client-ip=91.230.251.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTPS id 55G4oj26030341-55G4oj28030341
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Mon, 16 Jun 2025 07:50:45 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 16 Jun
 2025 07:50:44 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Mon, 16 Jun 2025 07:50:44 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Tariq Toukan <tariqt@nvidia.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net-next] net/mlx4_en: Remove the redundant NULL check for the
 'my_ets' object
Thread-Topic: [PATCH net-next] net/mlx4_en: Remove the redundant NULL check
 for the 'my_ets' object
Thread-Index: AQHb3no3cJA/FSbAVkSNIYVzsV0iVw==
Date: Mon, 16 Jun 2025 04:50:44 +0000
Message-ID: <20250616045034.26000-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 6/15/2025 9:22:00 PM
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVxYWC48UVpaWFhYWFtRSFlRSAlGHgkcBxoHGAEGKAsaGBxGGh1IWUhZX0gcCRoBGRwoBh4BDAEJRgsHBUhYSFpIWVpIWVFaRlleUEZeWEZcSFBIWEhYSFBIWEhYSFhIWllICQYMGg0fQwYNHAwNHigEHQYGRgsASFhIWVFIDAkeDQUoDAkeDQUEBw4cRgYNHEhYSFlRSA0MHQUJEg0cKA8HBw8EDUYLBwVIWEhZXUgDHQoJKAMNGgYNBEYHGg9IWEhaUEgEAQYdEEUDDRoGDQQoHg8NGkYDDRoGDQRGBxoPSFhIWlBIBB4LRRgaBwINCxwoBAEGHRAcDRscAQYPRgcaD0hYSFlfSBgJCg0GASgaDQwACRxGCwcFSFhIWV9IHAkaARkcKAYeAQwBCUYLBwVIWA==
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:2:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=ud.crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=cgljj/Kunki6TqOGaVTTv0LJ3MX0FK/HJaxIZV2Kyag=;
 b=XhHhVosDHFpa6LLLpWv1gcimFJpW3+aw2ct9p+ok3/U6ldQD9ZWeQtqziglmaQzN2CgO9MxizLQH
	Uq5zMH5MUPHg/fAE496b1/ZjWZ2eLo4bzwo+p1/oOZ1vFFzyNVTqtQXu+mPAPL0wSD9AsJhEHg8j
	Sk+fw9FGxX8swe8tw77YUhX6L0mDQxK66/K/8Av4BwxZbCJ/CAuxQbEctyueXonWaLn3LmSx/nu4
	1WYOwQsrjgVhJlLwOy/lmiMSfCCHb09vBsNFLqeNeR7S4FM2W4aPawxfZxj5jdxI2ncU+a1jdPf6
	pSKjO8KfIRZAjutwyl9YoH7TwDjfF+xWyEUVcg==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Static analysis shows that pointer "my_ets" cannot be NULL because it=20
points to the object "struct ieee_ets".

Remove the extra NULL check. It is meaningless and harms the readability
of the code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
Resend for net-next. Link to initial thread:
https://lore.kernel.org/netdev/20250401061439.9978-1-a.vatoropin@crpt.ru/
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

