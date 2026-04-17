Return-Path: <linux-rdma+bounces-19408-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK9PESi/4WnixgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19408-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 07:03:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8797416F6E
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 07:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C8AD31103B8
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 05:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9A30AD1C;
	Fri, 17 Apr 2026 05:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QgISqF3C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4CC1643B;
	Fri, 17 Apr 2026 05:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776402175; cv=fail; b=vEZmqcl7eghxNb+JMUPPEn97Q2+s8j3tTbpFsqC4Sw21sJh/YDoQ6E0xITny5caQ3wv1MVjmQBR+9+NmYbL5vcOMZkopn0NMuYWONHCWLxxZYk3mmQ+/N5ARJVFuKfyxFdJhSUHtyzTnro6tfraWDLZ1SQWkK9DKnek/oJLlisg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776402175; c=relaxed/simple;
	bh=aHdUTAz6Ttm2p15b7T2wkoohnSRkA8Kggq8W7MvpdIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D2/tF99LnHi2nimOLiM6twVpPRRu92pv79Mb790cCkTjL0AIClLBwxFp6TvGzeL2eM87vcsAFWTVSNxv8dqUzndDSQ6SO53IzlXt00cSfEnnfiTpQJj8I/2+dpHTUyzWrXCMlDHOkZaQwQ+2F0BiZRzZ2iErQ4lZxQyZ/tT0MAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QgISqF3C; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zmtn9/x6Ko6Av0/nD71zXbdtOFgNoP+VlW1WTHGbsKiQb5TxJvmYeLLGp+OqNzD2LqbKjqLzmpcALiRPJmNEYgzBum3fa1ElAmUkJzcV+BxOT27ef4p7Sqo7MmPh+l2hbyFjzPHKmD7ogKXAsAz0UjngWk5nRU6UM9juMiztiwa8Xhpuswa9iFopUVvVJsFGfQpQDfGB6hA51odAoqoLYagJ89XdeQkJqccr6uwRI9d9uiFcinqLDE9oyS6g3wepLJG/1M7YEAlDaGmmq+kud6Aj8W8/Vfv2/Y6ubhk0OGFcorbitefl1Hr11zavGds7WlmYMEByxMO66sd3kkHdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeMkwaLEh/CN+M1ogeJjZoHdKALd4AkA2DdSNwkdCz4=;
 b=VXy8kgkDjSQSbeGC56TcbgpV0qlUPu6eEU6KT5d5gdwOerrOkWxU3iMKlIZv8P/X5R+KR+EWK3HUQsSnciMW6P5uG8FfVkwq7GzcaoXmRfaRZbQXTeexMzNhWANlsWjoRFf/YpsjKoVrTwYlhiAarW2+7nGsgO1co6NQFZpnVGCYjrg4AW8FRaU7Xn6aYxZ+203O2SW0PaKBw6EyxDMJY6k4xtPmJa3vcmUTmNAY8Zhauk0dct8dQWL87GdxcaAH/ljCzUeJBr8Cu5G+79dKYBUEjZo0PE2hsNh/1Br57tfwvIaUYcJtlHB54TqAiryscN5TwNNqsbHzKvaIEDscAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeMkwaLEh/CN+M1ogeJjZoHdKALd4AkA2DdSNwkdCz4=;
 b=QgISqF3CAxBSPug6F8Y0f5DUTADbQNon4kfy0rBCs0PklkR4czRyjrXAwXoyGM13HhxIPLt5LhZaeO5wo2UEsTsfBaQbct35Bt4jrSwhFnaBZs6H4kHZhdDY7HrPCMWsovpDd4ur1XlIL8kIRDpUbk4cHc+aYIWOxfyrzDA68TCbquKvK/VfyKyw8eilb7IRAOUT29MfNDlmiyq4uZqlnNX+vNcf7zmtAjRxQgrhu4HQWmG3KF0fEP4wnOCqNdm+DvYCMgUXbHpL3AcRV8an6EHuSdPUlCQdDqKDaf8g2aq9vWF2TTsG++G2o8uWCWOcIoTt3GvAXJNCiXDTDbG/Tg==
Received: from PH7PR03CA0011.namprd03.prod.outlook.com (2603:10b6:510:339::12)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 05:02:49 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::10) by PH7PR03CA0011.outlook.office365.com
 (2603:10b6:510:339::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 05:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 05:02:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 22:02:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Apr 2026 22:02:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 22:02:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Kees Cook <kees@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 0/2] mlx5e PSP fixes
Date: Fri, 17 Apr 2026 08:01:59 +0300
Message-ID: <20260417050201.192070-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 235cd585-e326-443a-6fbf-08de9c3e924e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6MjjLgExf/72AfTGkphTyC0lhWFJrSOB0o3AxMaWW6+PUIkQpxFzNhnqccri5+SpA/yUq1ifaTZwWGytZlVe2X231jFMxSXZ5lLdl9VYkqey6Mm6f/BrQ4kG6j4PfH6jfB7fzqxqbT6B9ujGEePLw8/qsCthb7A93ZCZxguiFqktoC0YHw6Irm2/LsATFciwKVsh3zx2npBpAADKXRb+FYYM6a2d9lnp04Kvzija39LN19pOqkVULVjtVTieDnPVw74J3Kz6tO6if9nmxjrqKGn3XYbvIe3FYAWglxaufvu7HLgPFIauhlVb2ECsA7V1IgyO6ruAW5Sf4G15CiwzamRe/Mg6L2rLFqQ+VByJtrWvJ2BEFuq7UNLcs6TsumwMdildvfuGb1vvVLY/iWdeSAoOU6/5xZ2aQ0qw8tYikIn7sILncqOaQGjxwp485d4fP8BqUcQhx1bIdEmuxw3zupBlkKLuQyOvSp7/LNNUoqhdEptjKpmNVBdSVHGwdQk+Gq09oFYX7c7vq7YsUk3LoAqASRyi3kofuHfJHmSD3O7DffUPfn8NXkyImwEJXBGwJMjJ8VfMriDQayi+euW0U/ufSaVeDV7CxNhHip6hOAYSbjUe7+CkSwSDZOle1P72LKRpHJFzs12wPk3N0BLcfQz+MEnnR4tjXWn/IJ0v6KwoUhnl6dgNayQ3WglWyDzXcTGHPXus949dOKmBOVp6KXWdRCm/ITCYGw/aH6xE8zHQzIJYcxjdY7TjBdJcZJT5jhItwpV0E68NCpoMxCopTg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OEtx0Qll1Qn6Qpd/uqThAjsBJL6oaqsodP2yhjBPiO64/g7CWDqtr1vR9OV64tQwznKKIrRhQCp4Watnaf23lyqN6VQ55pLmejNMGTpOrAvGOmqSj+ZfKZlYHtDGSYbrT9PMig2SgOWkikte84wEsASjEPkuhXCSx+PsKx11H76yvpoYVsUFJM2MOiVrlQPDL9tfKdmujUjM5KqCTNWFTKjotrwfuBV22OotVWd21czUa0Fe6itf7G0B3DIsJ+RiQFVYMZ62/NHTvZd+YrsccEHiHocImTiBmlvI2TXZhrYO5kJwxLHUSACFgD5ADW4dfprP6Y5+1kM1ECOsAeC/Nx36o5OkIlfizmsK+ZYBuet5dRJ9p3VXfl5GT2j948ABrceimNUt6yGdqx7ns6CtKz//j+UDPjO//vSw783fCJe5ctlGqNICGPmb0Eo9n2nl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 05:02:48.8463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 235cd585-e326-443a-6fbf-08de9c3e924e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19408-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B8797416F6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patchset provides bug fixes from Cosmin to the mlx5e PSP feature.

Thanks,
Tariq.

Cosmin Ratiu (2):
  net/mlx5e: psp: Fix invalid access on PSP dev registration fail
  net/mlx5e: psp: Hook PSP dev reg/unreg to profile enable/disable

 .../mellanox/mlx5/core/en_accel/psp.c         | 36 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +--
 2 files changed, 22 insertions(+), 18 deletions(-)


base-commit: 82c21069028c5db3463f851ae8ac9cc2e38a3827
-- 
2.44.0


