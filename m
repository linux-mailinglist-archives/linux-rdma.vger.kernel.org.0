Return-Path: <linux-rdma+bounces-16572-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ5iJeaFhGl43QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16572-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 12:58:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D17F2219
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 12:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D3D0301680C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68DC3B9618;
	Thu,  5 Feb 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="uZM0d2Q2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D43B52EB;
	Thu,  5 Feb 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292698; cv=none; b=FbTBVgV9r3ObUB6PKPpEFAsi1AQ73CZw/ibCc8mn8Ftu+GtRqHN3JnUDRlFfnd0Ynd2/nA7goIcg2Dw3bY0LsjW3sfV79ufnNkvUyun46hUkumcUH8UrXGuHxVSCxR25Q1nv4Wi+ZNd+9AgmoP3xL6aTK91e4lQlQBx9sWaftOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292698; c=relaxed/simple;
	bh=Cxwqo1+Ald8SW5wGI3cU9gfdpqeTn5wUlmZNEXeOLFs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mYREgW+Q7gTSQ6Bp1SXvVuxtu0x6IeSEu4T1gXJbsbogc4xb5MTRhVG+6eBuYIhEslln/D34GrMdjwfg9JWpQ5oqDFsk9q7RNOzsGfYt+y25ZzsPHVgJ8g2Fdh2mVyjYjpMv06dKZcze8Y6+cC6s+G3GEx8TdSP3drtxjp+9aRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=uZM0d2Q2; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTPS id 615BgNgF000324-615BgNgH000324
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Thu, 5 Feb 2026 14:42:23 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 5 Feb
 2026 14:42:23 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Thu, 5 Feb 2026 14:42:23 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Saeed Mahameed <saeedm@nvidia.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Drory
	<shayd@nvidia.com>, Gal Pressman <gal@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>, Mark Zhang
	<markzhang@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH net] net/mlx5: return error in case of lag device allocation
 failure
Thread-Topic: [PATCH net] net/mlx5: return error in case of lag device
 allocation failure
Thread-Index: AQHclpR+rj15C/aV2EGrrujnDvpJnQ==
Date: Thu, 5 Feb 2026 11:42:22 +0000
Message-ID: <20260205114206.1763509-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 2/4/2026 10:27:00 PM
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVxYWC48UVlRWFhYWVxaSFlRSAlGHgkcBxoHGAEGKAsaGBxGGh1IWUhZX0gbCQ0NDAUoBh4BDAEJRgsHBUhYSFpIWVpIWVFaRlleUEZeWEZcSFBIWEhYSFFIWEhYSFhIWllICQYMGg0fQwYNHAwNHigEHQYGRgsASFhIWVFIDAkeDQUoDAkeDQUEBw4cRgYNHEhYSFlRSA0MHQUJEg0cKA8HBw8EDUYLBwVIWEhZXEgPCQQoBh4BDAEJRgsHBUhYSFpYSA8KCRENGigEAQYdEEYBCgVGCwcFSFhIWV1IAx0KCSgDDRoGDQRGBxoPSFhIWlBIBAEGHRBFAw0aBg0EKB4PDRpGAw0aBg0ERgcaD0hYSFpQSAQeC0UYGgcCDQscKAQBBh0QHA0bHAEGD0YHGg9IWEhZX0gYCQoNBgEoGg0MAAkcRgsHBUhY
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=tBD1DIuDM76b6fn+eP1KQnG1xb2lizg00yg48aXcuog=;
 b=uZM0d2Q2z7WKW5bGntydI2OPkVD/58tNjdPcyrXdhVcppvHH192qFBJcsbE6pYtDgyPa86zUvYnv
	PF+PAPu6tz1nsVprMduWg3H+kN4Lx/4tszfQVYa8fyFA2fac83VXJnQ3CA1m+Inn8tie8uQpWnr5
	vZy/XjQKrct8m0mKCGZTh6c8dwlBiV/AH6xDCj/3IuZ6PyY+QsQteB+iIk20W5miO/m1xbFlSMEf
	bVkhUXi+40YJif8B6gX54SU3g63ZSpCShI5da4/2zaD2QI9+IU/ZECrMKOm5SpZzS/x01/IDVVfJ
	ovoNFB1MwZLMOn4J5UryKlg25CTyzpeAYl1erg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[crpt.ru,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[crpt.ru:s=crpt.ru];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16572-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[crpt.ru:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.vatoropin@crpt.ru,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Queue-Id: F0D17F2219
X-Rspamd-Action: no action

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

The function __mlx5_lag_dev_add_mdev() attempts to allocate memory for the
pointer ldev by calling the function mlx5_lag_dev_alloc(). If the memory
allocation fails, mlx5_lag_dev_alloc() returns NULL and the
__mlx5_lag_dev_add_mdev() returns 0. Later in the debugfs handlers there is
an attempt to dereference the ldev pointer.

Change the return value to "-ENOMEM" to avoid NULL pointer using. When
"-ENOMEM" is returned __mlx5_lag_dev_add_mdev() will attempt to
reallocate memory for ldev after a sleep interval.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: cac1eb2cf2e3 ("net/mlx5: Lag, properly lock eswitch if needed")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/lag/lag.c
index a459a30f36ca..6e914472a2d7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1392,7 +1392,7 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_d=
ev *dev)
 		ldev =3D mlx5_lag_dev_alloc(dev);
 		if (!ldev) {
 			mlx5_core_err(dev, "Failed to alloc lag dev\n");
-			return 0;
+			return -ENOMEM;
 		}
 		mlx5_ldev_add_mdev(ldev, dev);
 		return 0;
--=20
2.43.0

