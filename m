Return-Path: <linux-rdma+bounces-22847-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CelwI348TWrbxAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22847-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:50:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E5571E6B4
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:50:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=iMzDqxqq;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22847-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22847-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3087A3092FE4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393443F4BE;
	Tue,  7 Jul 2026 17:46:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D873859FD;
	Tue,  7 Jul 2026 17:46:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446385; cv=fail; b=JEpcMC/9cuGDx7GnBiJz0xoq+k0znOtJf0HFI7uVH1PEmDT11d2YEqBMAut+CaPu1AL98DqDic4jlLnPTfnpzIfP/AvP6+EeLYgZoKqK4/pu7SDkp+4fBxhZ6aKvuR1/l5IKqZR9UOKBde3BNwSmnIOfxTSdecxt71YPU8Ikclk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446385; c=relaxed/simple;
	bh=D7y1w1hAd0iotSyKh7CxtFC4/yc2h/GnCKbOuoAwXZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llrVzm4xRf2sGQ2xgdXAV9krFXJK2/R7XcyU3whYiOkfPaMbzntPubkO7siNxEnl6H04vC/Ckn/v/keLqvDAyaZhLt3HfKI1PHnRoxzL9/Z7N985O/yNUY4tR5V11KXV1LbUxMkhhlTYrdYiPoGLVPck08sI8ii5WZXWtGbSPr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iMzDqxqq; arc=fail smtp.client-ip=52.101.201.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiiZQ5+HdDQ3+OSUddg2oymm4J/z25OIl9yCCEJkwRDBF9U3bKcy6aNmD7NANojk9XLvTnYb5bSdsoXfGDeUU81gDoD3gn9zw9v4tZjTkKp5d6o0NizAC+NQeCR8rrEVsEdfCstmv2GXbANwF21rxEHYht6EPBj4+QCxPOwvQ2HCxfzniGQuUBJZ5XFUBOg//yRFBzGmuLKSdBFq8Npd+GiXGC6/uKSkE33QjWEZjsMpd9nrvNwP0W9PlKhWQwJr/RiJbXpGCyWwoI8+7T5JClDAnSjX+gsTjP5tuCCBpE0JtShwfajnBda5Nd0wgqH4jzGrQ1Q/Ras5ukGC1rfNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YruQRGdooAus926mXQ5iORF2/vtVgeWZuFRhOiiAGHc=;
 b=AR0YFkTfDDbeJY1QNKY8VDG7gRaoAtooWBRUCu3xIok+79Ol7HciRhTmNlXjI1YHQikpHwhxXT3WSREDxXalWRlx1qDHqgQMTEwKDJ9MBwXcfIkRI3PEU8dFYfLDXSf/uIi+0lwtvmwEO8gNgFqP/Cv6iUItyTAmMIKTE7KjK2yEGtNicp/q0nRAoCQpapMSIjwby2EaDR1QVkD1d7uEJTud3F0HG7m+XXBWq0jebQ2voA0espSdEepa+/7azUkOh4HGjhVtl7Wx0Ef1aKnqEWTeU+poEoQlJkXJYbUueyTxsymaTe523V8zuTbgdDuHulfeuRkScwHS8m1qpXCV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YruQRGdooAus926mXQ5iORF2/vtVgeWZuFRhOiiAGHc=;
 b=iMzDqxqqnVRsym6noIrTuLgzyLlqZFU0w7bV0+Kzq5dfOA5z90SxWfM1ppdduUS8xL/CrekQALSYbmc1Ajm//KFfkhnsWKpXL/dCsoxlyXDZTLNyarKVcUpwQYqLpEWYkDuPaZbVgY0Yo8euEYyEu3rW8Ppv1qR8PRAeAHIcSufpbTJuYFxzSS6eEv2w2i0ahP+GLKCd9SwuyfGrMzJp3JRc7btMWd2VVvLjVOj9AmzFiXVzOwA5Ye8xKGRBjRTNm6rYNewCtN/HQGXlie270XNR1ddSovqporw7AA+B/K0ypazrp1LroTWvllk8TRk+2zo/QxSe6RMog35hqpp9aw==
Received: from CH2PR20CA0016.namprd20.prod.outlook.com (2603:10b6:610:58::26)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 17:46:18 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::7c) by CH2PR20CA0016.outlook.office365.com
 (2603:10b6:610:58::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 17:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:46:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 10:46:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Jul 2026 10:46:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Jul 2026 10:45:57 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V5 6/6] net/mlx5: Apply devlink eswitch mode boot default on probe
Date: Tue, 7 Jul 2026 20:45:27 +0300
Message-ID: <20260707174527.425134-7-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707174527.425134-1-mbloch@nvidia.com>
References: <20260707174527.425134-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: b232b0a8-5110-4bbc-e378-08dedc4fa52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|1800799024|36860700016|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zV/3cf9neZZwqObYjx1Xq6bFFaHGlk2J20b/ggFA3HTwnbZhpHOfFzX5uievavJTmXTHeCUCmRtxj1RitTBQnv2uEhNvVIAWVLacY1l5UEbQRXF0zg8rfTnkpwS25Gyf5OZzTsf3e5f05hEsXQ5kxqF8NCv5QXDEqzFZvHLjFdAuzr5771Z14p7fLBE9ChGIXtGNlHKm7ZUdvKqFhuJIKNteA+fNOQmBLId/5isV0X+Zgf2bPDDs+rIykvQLKrD+CORMMWZGl9sJoNGVG5P9sNm2ZWJxH3e6cDdKExym437GBU7W4eEwGJKlNtzea8+3YmJeu0le7Y/jDj1/M3kffHo6DYQTcfErHz9vbCisEHa/fczriqZhZhL5ZJzrHaVv+7FAGOPTgcIWzHJkBmdbbTzazulVkH+NPktzciGsui+Dc8hzFkWs+ntbPtpE9wP2sHdupwJYjmBDz+OSjWRKD1HQLmkVgaFrHkLQ0ch7u22Wom1BwR8wkafIC8DwegaX73Nv2il3cRvg7jUn1Jv1IlCatwb4vd3z8aPSCfR8GravKekMEi+7WNuwzXOoCpu/UnpakGOjdfIApCrDS7nHdfGVUhEFH84fiIvSblj8CbQ4SU2nZX3RLliWfMxWuPmXJe3xvAcH9NjDHu+uLF+YMMzD1Z2cHt8PLVagVdX91wpHL9v2zugK+Gi6KcxPce4bZDH1HrzTwsVB3P2B+La+eQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3lXWpWmaIrMYuv4qvXf+2c7SLFst7bdRjH+eYiBKVJ+eJq+ryyKOn1riurCEHhX8SDEB3WuPMGS5vVJN5HtxEwQUNgEkFB1FVyxdP1tcfwwoWYg1x6xIqGt79fB5D5D9rfGmhSWJ2/pT81DrVpo99yrUCguJi1QbMTefzGsFVqpD3mmCerhBtgr1MOA4/ycdwJVd1wWj5LWMzo1bhlgGNht71S+d1Rd1+PSVenU/XP3U3VyAe/vaaf61gSaL+MSyD9im6iSHTSKFzMHgTGqAMQ5s72Aaxt2/j8YOPokTXAPaI5cEEaxeVcazJjrys89sbP2RRWwZteR7J0xiqVO+EhkJ5sXV9ErQrrBceT6tWcSndBFAqBKSnwkpYCn+kfSZGJjhl1ATTPlsSOhnf2765zlQn86NWaFXlpSDvKKEw1HLZwZOizhEJcWfZLTKk4LA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:46:16.3508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b232b0a8-5110-4bbc-e378-08dedc4fa52e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22847-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:mbloch@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3E5571E6B4

Apply devlink_eswitch_mode= boot defaults for mlx5 after the initial
probe finishes device initialization while holding the devlink instance
lock.

At this point the devlink instance is registered and mlx5 can perform an
eswitch mode change. Calling devl_apply_default_esw_mode() also clears
any pending default apply work queued by devl_register(), so the queued
work will not apply the same default again.

Keep this call in mlx5_init_one() rather than the lower-level
devl-locked init helper. That helper is also used by devlink reload, and
devlink core already applies the boot default after a successful
DRIVER_REINIT reload.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 643b4aac2033..0712efea74cc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1392,6 +1392,17 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
 }
 
+static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
+{
+	struct devlink *devlink = priv_to_devlink(dev);
+
+	if (!MLX5_ESWITCH_MANAGER(dev))
+		return;
+
+	devl_assert_locked(devlink);
+	devl_apply_default_esw_mode(devlink);
+}
+
 int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
 {
 	bool light_probe = mlx5_dev_is_lightweight(dev);
@@ -1471,6 +1482,8 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	err = mlx5_init_one_devl_locked(dev);
 	if (err)
 		devl_unregister(devlink);
+	else
+		mlx5_devl_apply_default_esw_mode(dev);
 unlock:
 	devl_unlock(devlink);
 	return err;
-- 
2.43.0


