Return-Path: <linux-rdma+bounces-22413-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RLrOCegcOWodnAcAu9opvQ
	(envelope-from <linux-rdma+bounces-22413-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 13:30:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 709406AF14E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 13:30:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=VT3IB0Yx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22413-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22413-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFF613037DEC
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC952BE7DD;
	Mon, 22 Jun 2026 11:30:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB245BE3;
	Mon, 22 Jun 2026 11:30:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127817; cv=fail; b=DCRfGGNjTm75g3CM4wIbuT9JbBJIPr9QNzpoP56SeAv6UJ2GfkNo7KSLkZlVcR67Go5/PLcRbCKy2+qRnC3G42KUwcd45AXGGxHmktWSRJXZe1vDj2f8OaiGFouGc7Tu5DRhfVMBQl1M0lGMXNaEmGVPcoa90/JFnWj34KecST0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127817; c=relaxed/simple;
	bh=VoZ20OHm3kxlI5UtgXMpV44CVmZwbPX2KiMdfSCJRXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJoFpUiVinFLqapOkMwnxa/2l0UwpR31yGdYyIcLehwDRcAQWauJdBkQ7k+vVA/yCcR0p4fqbYvLMMDQ4a1cv7cp+Z8iTbn6TCr1Bnybri7t99OcNVLyTwTQSGNyaxzS892Yp8TDYdkCY8k4WNEO0XX/bmNUXg3J4yOzOz2ASpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VT3IB0Yx; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5yehYWw1ye57o2h71v0729/4Qr9czwU7u2R5ywu3aSjUg0BWy8zL9JodWCFFH3hRtXJLxz32CF68AGlp+BPAQVTfsD19eHj5tgZdFDN/EqJI6AIMn3sdzNC9/Qiz3OVlSR5qlePSHsoJfy0ygh+xfy8GAhr+9F365rFMqhYyw5Gpvraa2jF4nHtRXBa0Z4kY4pWZfVfpRcSDmDff7pJRE1ZEIYEEBmlkNduhJ3REb2zVwsmOPeI/ymYDr7DV6sUwJTM2ec8OJyhGsGqtjs0BtCR/DCJv9CrDO5TqwpzE8zgf/Dxu/Cx1ZRCs30I3Cp3vbtOCdNWQn8fFpnPMkBQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nmCSA95bcnBjLQrGKwiAZhOmnsS0ncR5h46LK+6GYk=;
 b=dre2Ownu68nu4wIanVTP3bskvui+TCYh/WdJUkU881yhtM0lK0jq+5SwtZuif4HCfv5yUdnfwibuLRLFLcF3JaPl/DXA0Hegpj6ET8ljRl2NLSqprD5kdWaPvx/QB2eznogeGFpk1zgHaepK8k7BGschxA1HyaEdCSCoCnv2soa3+UWmTj3rqWG4+S9B7eEOt0s+wLPteQbLGWplI3wOsyiIpFOvSzsNhpIWDzoxg5fotB0bJ2Fvnvh0JBPPKJJoXUcQJLU6z716rSZM3V3ZqAt/DV1tKOsebk+TFqWbwrKIH9ypJU5GSYNkQLid/DwySRI6Q5A3xQHNR+2clB4q+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nmCSA95bcnBjLQrGKwiAZhOmnsS0ncR5h46LK+6GYk=;
 b=VT3IB0YxDPz827dTkbPZMnZDJEdE20qLH8mSwNOOWYC/zzQ9MvNK9TvFxyF/DLwRu8+MWmQ1B/qmIpW5S/QzEvOvaPqA+NJRgz9ZFHF+ofw6GlbXgDz97kuVnP3gRnVMQhv7ZvNmG4DOKfxEG2Cm4+B7O71QTm778q8eXbXUCZ3uhp6mPAWpEdiNI5k3HYlVHYIUzzaCT80MJlJpqNyZedlogl/ZPoD7gob40gCoJbLslr6CmKZOwUy5RxLTTmHncnbEBnDcM/yxvgg0Grsr8Ht2TFZJ/sA2seXeDM73ajRARE3vHuYMWZyE5I7pO+RH9ZjddCAB5Abi1JEg0wU4kA==
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 22 Jun
 2026 11:30:11 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::73) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 22 Jun 2026 11:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 11:30:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 04:29:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Jun 2026 04:29:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Jun 2026 04:29:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Alexei Lazar <alazar@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5e: Report zero bandwidth for non-ETS traffic classes
Date: Mon, 22 Jun 2026 14:29:23 +0300
Message-ID: <20260622112925.624795-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260622112925.624795-1-tariqt@nvidia.com>
References: <20260622112925.624795-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: e74e6205-da65-4fdc-a16b-08ded0519f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b+9NcnGIxoGGr9DfUIJI/OLPtwb9rwxfHk1uUNO/yFfzVU2LCyQZa+ThDLmFwhTzlLmUuYV63w37mFD8uE13+ugzi6PWI5xwa4/wzGGtxxeiaEx/Sqek1dA11FYOyCHF5Hkc4Dg7omhxKCheD99wKpZbOJQjD3HQkeGYgsAWiSFgCmyCmFmu4jPLtGRsBTmxqgGxf/LbosZAZtb3fNfMl2AjOrXhTitrIHuPjy8YLJE3+xcmXPF8RA8IS20AVoF9OKnsqNDdHzeWZ6uXTsgcCfFSak6E8ahCvFw0rlLWwHsn1y7Oucgx2JhWRQYCF2Q4QDzTxs1KeQbC1wxSmrZ5JVQ9XGLWuHOLwHFUWeZrwClVGvHc4eemaObMeenZM3gGzL72dkF5XjQbG7wka3Ey77lAGqRTtGBgn1k6Matih0nzskaNsbgqZHKfD2TjD8P0iM1AAcgGMJ92b2zphmAFUXpcV+ZpBi8dAUQZ6jNWk+Iqn6F7FZFJq4Q872KyoEstiO2zY/AGH7AWYyHKA0uUcLIztk+j8ddJWpIYEE5tY0xpVrIwV89zVFDC11N0goD/Km5TACZ3HQTbwd3m9z40rei/lgQQFL57uehRzyyF1ogDCScGVrkPBV1i8/aL7DTEPuobgADum5JCkhnq/1+VygZHUw+8ax4wmX1GL9tzJ1kUKhpwx6RbSWghVagYNIo/74wFtiskaYdiZNuMU9EhVA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dh2JH75uydn6wflyyRSg9zM9zvUpPh5jngsHowvcQ/9N9AXb7Pq1OzpwpXTvAtDhw4fZs84dTUTtrss79Oh8iqtkfIoV/LS4Hzp2I0eL0TZQHqjD6Ir0vc6ZdvyCeR3YgMAhZUprhot8I8jceH9OHSQvb0YGQxV6qh7AqhAFgQPSMg9eMO/eq34ldWoB8aBSL7x84ysTyDP1S33sAaC/OTAZlIHTswtwGQXnpgBcJZV2uaaUR7sp91TK9AJXaguwHpjrNkREumF0UrMFei9mKE2Xy1bswrk2g4v76ICFgTUSPAxGIl6R+tUkbl5G9m1ExT+mq4uBrW0peYOC/z7M24Yt0QgR72B7UZvyxdpqUz1XabbVkECkGRsj0aeg0gdIoWIgSo2NkpK50GJUaTeyzCy+3jRtdd2G5jM0B8GccZwpod6CpACz/w4jqYHxeFT1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:30:11.4649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e74e6205-da65-4fdc-a16b-08ded0519f31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22413-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:alazar@nvidia.com,m:cjubran@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 709406AF14E

From: Alexei Lazar <alazar@nvidia.com>

The IEEE 802.1Qaz standard defines that bandwidth allocation percentages
only apply to Enhanced Transmission Selection (ETS) traffic classes.
For STRICT and VENDOR transmission selection algorithms, bandwidth
percentage values are not applicable.

Currently for non-ETS 100 bandwidth is being reported for all traffic
classes in the get operation due to hardware limitation, regardless of
their TSA type.

Fix this by reporting 0 for non-ETS traffic classes.

Fixes: 820c2c5e773d ("net/mlx5e: Read ETS settings directly from firmware")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 4b86df6d5b9e..762f0a46c120 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -173,6 +173,13 @@ static int mlx5e_dcbnl_ieee_getets(struct net_device *netdev,
 	}
 	memcpy(ets->tc_tsa, priv->dcbx.tc_tsa, sizeof(ets->tc_tsa));
 
+	/* Report 0 for non ETS TSA */
+	for (i = 0; i < ets->ets_cap; i++) {
+		if (ets->tc_tx_bw[i] == MLX5E_MAX_BW_ALLOC &&
+		    priv->dcbx.tc_tsa[i] != IEEE_8021QAZ_TSA_ETS)
+			ets->tc_tx_bw[i] = 0;
+	}
+
 	return err;
 }
 
-- 
2.44.0


