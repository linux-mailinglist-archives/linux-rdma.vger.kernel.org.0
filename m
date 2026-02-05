Return-Path: <linux-rdma+bounces-16593-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGZaKJ6qhGk14QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16593-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:35:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EDAF4149
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14C643066800
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75FE410D18;
	Thu,  5 Feb 2026 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k5ZieIIC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4440FDB3;
	Thu,  5 Feb 2026 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301901; cv=fail; b=vFKtr8HNNbAOFIpAQkMu9t/SphR6eZ3hTDIKrwDANg0fwtbiIh1p5OjmpkCs2Xwxt3ObL+yDd5SUAIal1taBY30rGjxfsEvkrUX2p4+HZZH39JK0v06eG3ms9QDEZsupLKfl8upqoBT6x0bq5P2o+FryrA48DMn3jqyRTztb7/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301901; c=relaxed/simple;
	bh=OIPX0xt05fu/q8tBhc8+I9Kldg4YGPPpzk1VZfTmmXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ct/wB+lCf/rl+NnRWUkysLu9c25vvD+waI7RR3MexKuPZit8QGig+DceRUS5EGBpjM/OO/tdg2tWKl1p0IhQn+e2cNVWIMbx8kJWa5EUn0RR5VtXBkDMJc0oAEjUACNKBeD/uvDeC1EGGajDzjYLOLrsgVAgGuIs13EDBz5yzmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k5ZieIIC; arc=fail smtp.client-ip=40.93.196.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQD/yDfn3doKn/hkkoT7RfBkiojMDPFmepwRhRQzjEf/ahWHkfS+pJTAj+wWTqo2tyN1Hr5LbTYz9DQdEYnFNuGaum/H7AYS2esmJAOsIq0H32kstI8QdZ/56+HC/zFDLUsuOFPx1Zpp+yaUmtHqgMMffsR9xxWLuokjES+vo1Pbf54NndxySYhNOYV9pRS2Rp0EDDXuOdelgwz43nMzQkOXCctfd3188L5M63mPmcVQILiFhr53vR3mm7SaDCtRrEHNwbUe3sssxgIlRTVGLif8eCvYXa3R+aRXYEKuDu4sgIXuLVApEJwgSg51hTOQk22oSt1OfA6u7DM062tHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwFBdd1/fnk3/+Uc+8q4WubDGopMvojSBraL0buVbUU=;
 b=kXW/pW9kqHkJg+pVEnpB04Oabz/W8y8E9J1azP4ReEXxSWhPyiU+9eOSE+8qb3XUZBceJsBsQshsvbzelchYsw+GEozL/6YF5SL6IT3/RC4YBKOmgMhCX6/F+yUVYP06E7PYbK/ef6h9S8xT93s9MDNxX2reNYn1o8v1qFvmTrxc8GMDEGETUhjjpdTw67RYxwgfvKjVAmoAv7K0S+HKWTURc9ft12+rb+QRPyajQe3S/J8zx93M6N372/qAk77r5thew/b/DULSn2Xd2EYmDK8JVI6OrEsFUMgpkRmlwz65l4Rl8ZLGstxdgu78z61Sn62Io3E3voKja4ZS6YOOyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwFBdd1/fnk3/+Uc+8q4WubDGopMvojSBraL0buVbUU=;
 b=k5ZieIICJ7WklMUCQAgYsY3R61W2qpC+zy7XNJFEKZPyLq37/KskfqoD64EIi4pH1Wb+R5ZujEJTeknkcyZcH9eyKm+7GsUWLfd76PdaxV7VhRaMlsLFu77ddfd/bZovplPqsR3ss4g0DpQ7PmN74vm2voR5Cwm+WMTyM5bqIIdyRe0tLxI6/zWn6BcbrKAmIr9uRg9Cwq5l6yWT68q87GFvkMYbXeHsDszTzX+1giSbeP2VRABmrwSf+tueWMD1bzcmNQnGflmtoNrvzKmB2TiHKBSxozIlmWZIFhF4QWMqkfm4DAi35zD/LAdV6wZ0YtolzWKLnR6OGw8NlT2hBQ==
Received: from CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::29)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 14:31:36 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::5a) by CH0P221CA0006.outlook.office365.com
 (2603:10b6:610:11c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 14:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 14:31:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:31:09 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 06:31:08 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 06:31:03 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>
Subject: [PATCH net-next V2 5/7] netdevsim: Add devlink port resource registration
Date: Thu, 5 Feb 2026 16:28:31 +0200
Message-ID: <20260205142833.1727929-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260205142833.1727929-1-tariqt@nvidia.com>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 3622dcf1-f3f6-4664-6224-08de64c34474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8USKXSKnRFeCKWcZ7fUY6qEnzTx0aa9Fzs/g5dLOSV7iiVrouuzUmluJLtvB?=
 =?us-ascii?Q?Kd0c0lyJi95k06vOnbiYSykGOJpI5siBGjmAPXbt9Jgy3sUa/QSg7GQVknzg?=
 =?us-ascii?Q?WZk0eKZcgSG0Ifce4hYlKc+4nZPeEGHyXcfbSzALoBM6r6jw46ry5WzwsA4j?=
 =?us-ascii?Q?DP7jLkETPbFD83eDEdk0W/6RGnTa4ye7HzslbcN038Y10TCUz3ko+SOGmwT0?=
 =?us-ascii?Q?fN3NHAT/90Ooysq7bzKyqKwpDazSTZYn6qVNTtFGVFRvH44Wq+GLrmmI+hCf?=
 =?us-ascii?Q?vx/0OuIBfWU5vNvdTBc10XA4foPtE65RTyjOjIgUTxeIedqICVxt7A2zVPx5?=
 =?us-ascii?Q?B2kR5hjGqGku9d37tBhcCx2o/OhloRKR366pHvUc8fG4Zh9p//weyUkkHvhC?=
 =?us-ascii?Q?/eeM3caTFN+8JT6dIhS4OL/fZMyxfWdD3Cyg6pfyifj9gCs9Fh6KbFlVYUoa?=
 =?us-ascii?Q?swD6/b6G7rwTgHAuq7YUAOU8Ksckf9+N3S6MYVA0B152tyoAN/0m3lqOmp5g?=
 =?us-ascii?Q?y5G1aIXztNDi6E7us4dyBjXT/qo+LBUHpIs9bUEsEp1wPpHQpFspqiiTt53Q?=
 =?us-ascii?Q?/uNkXa9I+21LFn97JA9yc84iPcvRVsDzZ9klb1affqgCiNNImM4GujqxMaET?=
 =?us-ascii?Q?5jDHLXMAL1JB15KMifvFdAVpD5zaBJmzI5iQ5MI4vbE3g+WYNAEfwCe03UV8?=
 =?us-ascii?Q?+Tp+xuYn9n8h8BnfqOjNOlZK4GzD79/NszG7kExYf0ifvMfynH7WeCPaEtW/?=
 =?us-ascii?Q?Kta66mmMAWq/nj9eBk1CwcxhDja4TCXfWewm5iOPdUBbm5Mb8IfXQF6YULSm?=
 =?us-ascii?Q?zYaHPAImpsZ4EJdK/d6QfRooiqCFq7OJYsptm7TKGmBVkcu0NDPxh2lOrvsP?=
 =?us-ascii?Q?zVH3sX3jBy5rI8Zn09BlnheiqZVVdPfubYq/SffQeYr0fvVbqHIzrbVvll6C?=
 =?us-ascii?Q?PYuU8t+RJtplZyLgpc0vURSpEHIFjJKHPV19b9qXCLbK2dPJ81B6QqYOAb/Z?=
 =?us-ascii?Q?9JwFGXpWcmRakyO3EN8+BLf3Q9AbuwWo3d0u3R66B52BtDZzGpY16jb9DbBu?=
 =?us-ascii?Q?kosHI9j0WzKSWWOVPJaiuzDtQHHXHgOh946mN2BFenTtJKENn2r/zlpFTgdH?=
 =?us-ascii?Q?PseRVTe1+edJnvuraII3zRVob49tZS8Q2b/xIgoBb0G/yItX1DFpM5QSt8jP?=
 =?us-ascii?Q?twYPLjj0D8oNNuZavvDNmRGpRHv3qo3zukDWwygXPq5pNyhmp0fRjI9TCCf8?=
 =?us-ascii?Q?rCvTRCO1Wchqb6nG+yHk9yy841G26o5rhBybL+XE8Wo/nOkUO+/DOEHwqM0W?=
 =?us-ascii?Q?wvZcQLao8nr9i/sw6VFGzSxOFUESAMnbxXXDwJRVl3qdrmxN+X9H4ubvFYMQ?=
 =?us-ascii?Q?2v10vfqDCnp0FrVAc8y0g9/Ki0Sxg37Wy9MKvvUOVgab74VTi/V6SdoqyMXK?=
 =?us-ascii?Q?rgv7KcxPQ/joVAvrrgnh4p+dbYMgR9jW+sT/biZYyxFGpsUiQjn2ix0nwFxT?=
 =?us-ascii?Q?UYgMp190X88Ty48QwQIKUjvVIP/o0i5YqCI2C8q9MAlAYdF7RF5fSKQEuDUR?=
 =?us-ascii?Q?q2+SdR4H1MiKHE7LYeExkDp3+C9ov7M/dfCXDShpMZfaBP0ej3oCqKCOiMwh?=
 =?us-ascii?Q?yWvUFOg/g4Iq9AGXHKnWp9ppd2aW1bQiPe3ZeAV5/n+d04abp6tokPZx4YKV?=
 =?us-ascii?Q?zMavzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XylCK/E3OLiMrvxpfLcWnCN9mQGuxYMuDkA6Af+gnR6W7FyrgZq40taIps231LNI0HFLs/kP2KhvleSbZwbV9bUr4EKdSInqIRMGW6RylxlSCQfa8X1/iQUr0ogJpTbnLVeQIfjavyEXff3zILv2ZRtJjTlVc1VTyxuybKRPGzAt1OmvD9ZXPJS6VTc9XreY6Cc+Hj3E8afN8zD4k+lPGtKSbeGQXeLQR7CjeKzu9sdKvipy5yWfXF44mjnHK3XLZ9QcGb2VPL3TjBzcGEU1VuN3I1kbZbeAM6y0zm5DilKoGUVXkzCpuyRyoIoXgdXwmdWdDOqo7i5/UrIwlP4xIOh0AKobU43xlLPJF88wSaz6G1biH73vycbskUxarL+bolLocnn5/EzxmMvoaokhWziHxqHZXX/CvG04kkNuGMC0W86gahL/3oPprfn10xCD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:31:36.1770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3622dcf1-f3f6-4664-6224-08de64c34474
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16593-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 63EDAF4149
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Register port-level resources for netdevsim ports to enable testing
of the port resource infrastructure.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/netdevsim/dev.c       | 23 ++++++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |  4 ++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index dfd571b22107..da600b756fab 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1486,9 +1486,25 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
 	if (err)
 		goto err_port_free;
 
+	if (nsim_dev_port_is_pf(nsim_dev_port)) {
+		u64 parent_id = DEVLINK_RESOURCE_ID_PARENT_TOP;
+		struct devlink_resource_size_params params = {
+			.size_max = 100,
+			.size_granularity = 1,
+			.unit = DEVLINK_RESOURCE_UNIT_ENTRY
+		};
+
+		err = devl_port_resource_register(devlink_port,
+						  "test_resource", 20,
+						  NSIM_PORT_RESOURCE_TEST,
+						  parent_id, &params);
+		if (err)
+			goto err_dl_port_unregister;
+	}
+
 	err = nsim_dev_port_debugfs_init(nsim_dev, nsim_dev_port);
 	if (err)
-		goto err_dl_port_unregister;
+		goto err_port_resource_unregister;
 
 	nsim_dev_port->ns = nsim_create(nsim_dev, nsim_dev_port, perm_addr);
 	if (IS_ERR(nsim_dev_port->ns)) {
@@ -1511,6 +1527,9 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
 	nsim_destroy(nsim_dev_port->ns);
 err_port_debugfs_exit:
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+err_port_resource_unregister:
+	if (nsim_dev_port_is_pf(nsim_dev_port))
+		devl_port_resources_unregister(devlink_port);
 err_dl_port_unregister:
 	devl_port_unregister(devlink_port);
 err_port_free:
@@ -1527,6 +1546,8 @@ static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port)
 		devl_rate_leaf_destroy(&nsim_dev_port->devlink_port);
 	nsim_destroy(nsim_dev_port->ns);
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+	if (nsim_dev_port_is_pf(nsim_dev_port))
+		devl_port_resources_unregister(devlink_port);
 	devl_port_unregister(devlink_port);
 	kfree(nsim_dev_port);
 }
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index f767fc8a7505..985530486184 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -224,6 +224,10 @@ enum nsim_resource_id {
 	NSIM_RESOURCE_NEXTHOPS,
 };
 
+enum nsim_port_resource_id {
+	NSIM_PORT_RESOURCE_TEST = 1,
+};
+
 struct nsim_dev_health {
 	struct devlink_health_reporter *empty_reporter;
 	struct devlink_health_reporter *dummy_reporter;
-- 
2.44.0


