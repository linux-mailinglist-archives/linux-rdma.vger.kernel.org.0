Return-Path: <linux-rdma+bounces-2819-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719D68FAF92
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 12:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23871C21F28
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100251448E2;
	Tue,  4 Jun 2024 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="dH0pYbAs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6913D29F;
	Tue,  4 Jun 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495703; cv=none; b=CnmXIGj6cU8HExr2bhXmcJ71LzOuX51Ucbqv4/yQa5uQ85sCiVY2c0YZRnjsw0xLmxCgBYFxcnBtHj4VU7TLOutWtycxApbJSNDlw3rtxX1AfkEWF8B5yTsMUKEbK5eAtGo6tYs7R0010lZORhTXDX0VfaIT1IVgRhRmSQGEsCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495703; c=relaxed/simple;
	bh=6avz5LUZ/inR3Uyxtt0j62Bs3F4d8DO/HyEZ6uiBHac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lk971raWZjq02e5YwdWFg4jSiyb12EamFF+PJzca3+fFMNyrHrQJIs5j4wJyzDYlboW/Z2yUeK9vhiwm1X/Y9ucENN+P7Df4j78R7CTdSjJ50BQo0b3xV1ZTE7vJpLesgkY9m9xhc4oe9qNOIBQIWX4VwE96CR4KibP/dHucpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=dH0pYbAs; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 56B52100002;
	Tue,  4 Jun 2024 13:07:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1717495679; bh=8vE6tl+i2CQkzPeTqs79Tzdv02wtzECjp6uIUogF75g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=dH0pYbAsiDnGl6HYNaimqToe8De/PssZVo8Q8q2TmQ765dUJbpsqpCnmySq16fpo3
	 /qcIpb9REOCOV8u/yT4W65KapglTZ/0y0qUC8Xj3LlC1V4Qy0+h0WUADdakg5YXo5a
	 Za5DO73w4bXlYi6Doxw1PH83XVHNOwPSC6IdRNnR+ckGq+pr/tPnPLzAIpSUPpzgLc
	 KzvwEYscSmOoXAd6nqr1XeGIFkDji1Mgcyd2LvN+Vi4GiAEayVsukYl6Fc6076Fw0b
	 5UEOh2lt64trvM0I9yWleEpez6qj/W2aXFHvavNj9NyXEByueVBo3A64zbaPR9OJwr
	 JbJgc//eVcfKw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  4 Jun 2024 13:06:20 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 13:06:00 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Mark Bloch <mbloch@nvidia.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maor Gottlieb
	<maorg@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Shay Drory
	<shayd@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Jinjie Ruan
	<ruanjinjie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net] net/mlx5: Fix tainted pointer delete is case of flow rules creation fail
Date: Tue, 4 Jun 2024 13:05:52 +0300
Message-ID: <20240604100552.25201-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185699 [Jun 04 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/04 07:46:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/04 05:43:00 #25435061
X-KSMG-AntiVirus-Status: Clean, skipped

In case of flow rule creation fail in mlx5_lag_create_port_sel_table(),
instead of previously created rules, the tainted pointer is deleted
deveral times.
Fix this bug by using correct flow rules pointers.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 352899f384d4 ("net/mlx5: Lag, use buckets in hash mode")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index c16b462ddedf..ab2717012b79 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -88,9 +88,13 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
 								      &dest, 1);
 			if (IS_ERR(lag_definer->rules[idx])) {
 				err = PTR_ERR(lag_definer->rules[idx]);
-				while (i--)
-					while (j--)
+				do {
+					while (j--) {
+						idx = i * ldev->buckets + j;
 						mlx5_del_flow_rules(lag_definer->rules[idx]);
+					}
+					j = ldev->buckets;
+				} while (i--);
 				goto destroy_fg;
 			}
 		}
-- 
2.30.2


