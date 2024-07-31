Return-Path: <linux-rdma+bounces-4126-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C0D9423F7
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 02:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172D81F252D2
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 00:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1301748F;
	Wed, 31 Jul 2024 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="V7z02oyS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A0D4A31;
	Wed, 31 Jul 2024 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722387046; cv=none; b=OTfsGKBKdIU45azKFYmAeBCex/m3Rg5AtoWxSBVD1sLeXb2S6BE4hT3Ku7XwXR2NM2XoFcpVoYkDjdEBAOgq9XbKFD4Zi0BWRpqU1TvqOcpzTSIx4nK4k6eGxdlhOXHktbu7wV+aA6FRhtdIIXfPpDu9CasFFb2Ao/rtcbhP31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722387046; c=relaxed/simple;
	bh=crKea1BY/Y5bzrH/WetbK/4UoshvtgJfabiX2tiXG8M=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=fWDzTtbSr3g8XUjxPfb0WSHx6cU2JzyIP9f0ZNyxeGOjS5kcIXSXYWAMaOyqnp3s2fILMQwZ3bY99ylIiwiowKyklijplc4RSjIy1COcT/VkwBJcqCFS4TMjdnpnYQyUeXlgoYucWYD9RI4w2HxwSmkKm6M5dV8lN74U4moTVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=V7z02oyS; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 46V0nshL014346
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 31 Jul 2024 02:49:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1722386999; bh=XQ6htkADcL0Fn3yEmpuuTxZJ4harjK3uzRu/HLO2bUg=;
	h=Date:From:To:Subject;
	b=V7z02oySo6wQ3v96BSsCVTxGwQke3lJdK3MDfAqthrvDdM6vZLSBaoRgUQjj+gd7p
	 2EJXIcobkhznWEFhjMO8+0C7NEz5c6Uo24YgRzw2yBpw0ry3Imdmo9Kv9N2zd4pAtJ
	 Gil1Z0bKSKYVb70Rh4Lm1rSugG+XNOMvQda2dbY0=
Message-ID: <b17c5336-6dc3-41f2-afa6-f9e79231f224@ans.pl>
Date: Tue, 30 Jul 2024 17:49:53 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org, Dan Merillat <git@dan.merillat.org>,
        Moshe Shemesh <moshe@nvidia.com>, Michal Kubecek <mkubecek@suse.cz>,
        Andrew Lunn <andrew@lunn.ch>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH v2 net-next] net/mlx4: Add support for EEPROM high pages query
 for QSFP/QSFP+/QSFP28
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Enable reading additional EEPROM information from high pages such as
thresholds and alarms on QSFP/QSFP+/QSFP28 modules.

"This is similar to commit a708fb7b1f8d ("net/mlx5e: ethtool, Add
support for EEPROM high pages query") but given all the required logic
already exists in mlx4_qsfp_eeprom_params_set() only s/_LEN/MAX_LEN/ is
needed.

Tested-by: Dan Merillat <git@dan.merillat.org>
Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 619e1c3ef7f9..aca968b4dc15 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -2055,20 +2055,20 @@ static int mlx4_en_get_module_info(struct net_device *dev,
 	switch (data[0] /* identifier */) {
 	case MLX4_MODULE_ID_QSFP:
 		modinfo->type = ETH_MODULE_SFF_8436;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
 		break;
 	case MLX4_MODULE_ID_QSFP_PLUS:
 		if (data[1] >= 0x3) { /* revision id */
 			modinfo->type = ETH_MODULE_SFF_8636;
-			modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;
+			modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
 		} else {
 			modinfo->type = ETH_MODULE_SFF_8436;
-			modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+			modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
 		}
 		break;
 	case MLX4_MODULE_ID_QSFP28:
 		modinfo->type = ETH_MODULE_SFF_8636;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
 		break;
 	case MLX4_MODULE_ID_SFP:
 		modinfo->type = ETH_MODULE_SFF_8472;
-- 
2.45.2

