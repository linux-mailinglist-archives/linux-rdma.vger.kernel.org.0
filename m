Return-Path: <linux-rdma+bounces-22616-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hTOxA8nDRGoV0goAu9opvQ
	(envelope-from <linux-rdma+bounces-22616-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:37:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 839E96EAB7D
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:37:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=njYxvkqS;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22616-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22616-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A1A303900A
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F00D3BB137;
	Wed,  1 Jul 2026 07:35:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773613B6BF7;
	Wed,  1 Jul 2026 07:34:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891301; cv=fail; b=KBojxIDHvmiDGEwBelB/tK1wNJfEYSI5vQ0po7N+/BJ7JtFkbLI6XjYS0hfpE4woFe83gwE8yEPYr8ZEtZCZUrN4isv9dLQZae9gIAsLKYZQVZhtOss8BQq5TxMW9U3fAPoaCk0w1IxfeFaK69Z+HprDFRYIJksjYhynyE1KRR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891301; c=relaxed/simple;
	bh=BeibnZzFAZcTglLiYwhmBRTeTJiyGt+Lv5fgztT7ft8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzMUJpAOK/1XsfIbC61DnsCevKthTmaeUvW2bU6rhvDfVbI905wYL9gwk8r0PBKSjsMyGy6nTSrSB27hRVtSzAwnXHQNWDy+Ii/zKZt5e59HIOT+GzJ8vcFZmyf638SMZiYPNPvcDQwcrPNvJELpm8r7BKAX0w0KJGrvGzQC8uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=njYxvkqS; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH3P0k0hIvdUqoz3ovllG84gjMnAp8Wbc7VwUhNbHktaIP/vVsPTV8bii5ZnpfHZl7IzLx+DJMRimwFIxZrrzaMNxKHTgJqrW7ws7TR5bMdMkaebtawiWcJUN4a+T1FJ4WFt/EzFE7N2W1wRvEVMlwS70yD74byMo/F138jryP7AZ7wUPf1kgaF4xNCthOFFKaa6DEK+hgAoF8pjG3nN8khHijqZdU3kjc1MYjiA9ZVvdpTbpl6i7iO4W+8S1i4fzp2SdWZjWigQjpF02LGIHquho9ei0e9cypnCjMCpwWLHTAB9oepc05Pl1IjKLjpV6E1dwR4sIDHbLri1sRYjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti/gHfiOTh1r8TNHBnp3PXz7HqN0+6MedjYlgJ5KE3Q=;
 b=Vl0G5LNKMd20uiJoT0nMMTc/U1XvQohHXtRCYtSBvtsji6WnvXTcJnXhd+7t/kLC+9PdN3Eej2AOH4lrRx0rn3rK1SpZo/YX+DeWCzGCUoWJB2h9kN0TzMnmvoRIOG3pS4QO832faCpkHRh5mKQV0EMfUbFpo34sdHus9s6GhA94oXaMmnRLEu3/DDXCrbesjeBRXJSE8dtUmok8IUE/A8nxTczQpdR+FVCG5c1vZ5GBIAuIrDTIvxuO5C+4sqfzksFaRMZ0qLhv4KuuK43LSeZjdYl9tTMcIguSlVOTMGjphNMueorbFu4G+txEpe/AjORm92ZJ4AQlcG+YHgLqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti/gHfiOTh1r8TNHBnp3PXz7HqN0+6MedjYlgJ5KE3Q=;
 b=njYxvkqS+mSFf3ezXxhy8bHHNWfZWHHVBChjfBtiVXe5ToMea0AtTBvqyARSpkf/B/pKL9OY8stdodVTG0HY+zaWiycUdAUUYiubfL0GHE0Nbri+wgTE5MZa2gNzs38UaImK8AalT6IVy9fPf6QifRqV1pMnmApAjTh2WimEvIaFZ1YURsEdIvO+m+bBX/MCt2pCHWttnrZ24xSitlz0+GwI8ODss1OLH6LF9r5yP/eXcg21O6wILnTMeOJ6ZMPzNADT9ObIzS/3CsK1qXn2wa76NlHLiL/uIiFJYhYdPmGyrp8PBy4YlY1IaK/X5YxNrARBWzO/wNlHuB2RZORKOQ==
Received: from DS7PR05CA0035.namprd05.prod.outlook.com (2603:10b6:8:2f::18) by
 DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Wed, 1 Jul 2026 07:34:48 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::26) by DS7PR05CA0035.outlook.office365.com
 (2603:10b6:8:2f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 07:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 07:34:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:34:25 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:34:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 00:34:14 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Adithya Jayachandran <ajayachandra@nvidia.com>, Bobby Eshleman
	<bobbyeshleman@meta.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, Daniel Jurgens
	<danielj@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, David Wei
	<dw@davidwei.uk>, Donald Hunter <donald.hunter@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Joe Damato <joe@dama.to>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ratheesh Kannoth
	<rkannoth@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Shay Drori <shayd@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Tariq Toukan
	<tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V10 06/14] devlink: Allow parent dev for rate-set and rate-new
Date: Wed, 1 Jul 2026 10:32:46 +0300
Message-ID: <20260701073254.754518-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260701073254.754518-1-tariqt@nvidia.com>
References: <20260701073254.754518-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: aca7660d-4b7c-4830-e581-08ded7433a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|6133799003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4TQwBatp1ksdCXG99JL7UHyftkGPS3vmUWZXB6BwB9GddYodUlWY407x5F3+8TmTWuK5SEFDVt5hUrU9L/amDkJpY7X5jQ0HvxAYWSuDFztmU5MAansKHOnau0dHjirBiZd9QA1IKnGfj/H1UKEO+iaF0KcSJzUr2VN/y9GmmEEDlGYvOE9DObQOdwZ1W6iaeKPP7jyPzdvR0GjNm/wuz+8QUvhcyyoPsMR2S1FL50O20HAl6Ip8S2LycY4IrCfWsPQ1BsmDrJadKu0oyc07esE950b1rf4VR4Uqy8bFqJOwxfIajKe+nVkPjryECVhCpIyUXWd3np7Meni5iEfHNSv2hRthVVEc3+9AkrmC4BIClxdCvFY+AYcftgKUgJJE15NYlL6yITL311zrfqtUDvVEzMcr0vKT1WLCYrWhSeOpeU+txtPQYh6TSTbFjQMI341BN7RAi4UFbGJbFFei8C7I2KRVOq1Jp45Zbw92pk+6392xI6iaIsVmZ7YQ1SCEZYe/c1PLD2wl7Lj/DBlu14WISOcsU2BabsB3YJv4YHr/N0Py9Ucep76rtEliR8rLdLY1nCxYRs2S71YRIhUHW1/Gc1pjOmRqRIstDS1Y+ryr+kD5IAUTWeejI5pCg4vlN0Tp3nLkJqDNriYkitLAKjssCZoRkLH+/G5gaL0sTSP8revoqpGQzUtCiAVQgdpYH9OHPaFvkY4cc9THZlshXQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uZGTQAGF1YnrsJKBtM8DS5326GFoJV2JL1ooxaa0wQIJRLx46BBdPDbnvHjb3qL2hi5ZSsExb8i5QVJklJgi7dufSvcWgosAXN2WjPnsmhR2VZPx+l/cOqmJ4K24z9r5S9cr1cAy9BLGiaaSmoJ5vlJYpc7mw2ZF6zR31VYdvhRXqePH14T5I/fhHJy/yWk41Q+tH1tnum2ksoq95otF+FFsdZPY9Ysnpyd1zHJA46kFDU0VGZHT7uG/e+/cRIDeq745sIz6ZAnwYlbC4WVm954EzvvUDLh9eqE4HXhvXKyklamjOqR24DiqW/HjE2x2JxClzds6uIi6HmJ0z6ryQeCTd7EMPMRn/iXv0Yr+hMokHDEFt0/Tz8GKcXhYtznKIGjx1XmBTRNrzHqVQyjpEKnIyK+YouKtxTr1xgiybiCUaXBDPddA5VHbhnCkYVPr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:34:47.5201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca7660d-4b7c-4830-e581-08ded7433a8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:bobbyeshleman@meta.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:daniel@iogearbox.net,m:danielj@nvidia.com,m:daniel.zahka@gmail.com,m:dw@davidwei.uk,m:donald.hunter@gmail.com,m:dtatulea@nvidia.com,m:jiri@nvidia.com,m:jiri@resnulli.us,m:joe@dama.to,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:saeedm@nvidia.com,m:shshitrit@nvidia.com,m:shayd@nvidia.com,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sdf@fomichev.me,m:tariqt@nvidia.com,m:willemb@google.com,m:gal@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:donaldhunter@gmail.co
 m,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22616-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,meta.com,iogearbox.net,gmail.com,davidwei.uk,resnulli.us,dama.to,lwn.net,kernel.org,vger.kernel.org,marvell.com,linuxfoundation.org,fomichev.me,google.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 839E96EAB7D

From: Cosmin Ratiu <cratiu@nvidia.com>

Currently, a devlink rate's parent device is assumed to be the same as
the one where the devlink rate is created.

This patch changes that to allow rate commands to accept an additional
argument that specifies the parent dev. This will allow devlink rate
groups with leafs from other devices.

Example of the new usage with ynl:

Creating a group on pci/0000:08:00.1 with a parent to an already
existing pci/0000:08:00.1/group1:
./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/devlink.yaml --do rate-new --json '{
    "bus-name": "pci",
    "dev-name": "0000:08:00.1",
    "rate-node-name": "group2",
    "rate-parent-node-name": "group1",
    "parent-dev": {
        "bus-name": "pci",
        "dev-name": "0000:08:00.1"
    }
  }'

Setting the parent of leaf node pci/0000:08:00.1/65537 to
pci/0000:08:00.0/group1:
./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/devlink.yaml --do rate-set --json '{
    "bus-name": "pci",
    "dev-name": "0000:08:00.1",
    "port-index": 65537,
    "parent-dev": {
        "bus-name": "pci",
        "dev-name": "0000:08:00.0"
    },
    "rate-parent-node-name": "group1"
  }'

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 10 +++---
 net/devlink/netlink.c                    | 40 +++++++++++++++++++++++-
 net/devlink/netlink_gen.c                | 24 +++++++++-----
 net/devlink/netlink_gen.h                |  8 +++++
 net/devlink/rate.c                       |  4 ++-
 5 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 13d960b3abb1..38b1190f3d26 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2309,8 +2309,8 @@ operations:
       dont-validate: [strict]
       flags: [admin-perm]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2323,6 +2323,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-new
@@ -2331,8 +2332,8 @@ operations:
       dont-validate: [strict]
       flags: [admin-perm]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2345,6 +2346,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-del
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 5a057dc86b0f..300580c1a217 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -243,7 +243,29 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 struct devlink *
 devlink_get_parent_from_attrs_lock(struct net *net, struct nlattr **attrs)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	unsigned int maxtype = ARRAY_SIZE(devlink_dl_parent_dev_nl_policy) - 1;
+	struct devlink *devlink;
+	struct nlattr **tb;
+	int err;
+
+	if (!attrs[DEVLINK_ATTR_PARENT_DEV])
+		return ERR_PTR(-EINVAL);
+
+	tb = kcalloc(maxtype + 1, sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return ERR_PTR(-ENOMEM);
+
+	err = nla_parse_nested(tb, maxtype, attrs[DEVLINK_ATTR_PARENT_DEV],
+			       devlink_dl_parent_dev_nl_policy, NULL);
+	if (err)
+		goto out;
+
+	devlink = devlink_get_from_attrs_lock(net, tb, false);
+	kfree(tb);
+	return devlink;
+out:
+	kfree(tb);
+	return ERR_PTR(err);
 }
 
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
@@ -322,6 +344,14 @@ int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT);
 }
 
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info,
+				     DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV);
+}
+
 static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 				   u8 flags)
 {
@@ -348,6 +378,14 @@ devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEV_LOCK);
 }
 
+void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					 struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV);
+}
+
 static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
 					 struct netlink_callback *cb, int flags,
 					 devlink_nl_dump_one_func_t *dump_one,
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f52b0c2b19ed..dec00133178d 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -46,6 +46,12 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 }
 
 /* Common nested types */
+const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
+};
+
 const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
 	[DEVLINK_PORT_FN_ATTR_STATE] = NLA_POLICY_MAX(NLA_U8, 1),
@@ -608,7 +614,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_INDE
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
@@ -619,10 +625,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_INDEX + 1
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
@@ -633,6 +640,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_INDEX + 1
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1290,21 +1298,21 @@ const struct genl_split_ops devlink_nl_ops[75] = {
 	{
 		.cmd		= DEVLINK_CMD_RATE_SET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_set_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_INDEX,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_RATE_NEW,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_new_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_INDEX,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 20034b0929a8..a70e0e4769aa 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -13,6 +13,7 @@
 #include <uapi/linux/devlink.h>
 
 /* Common nested types */
+extern const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_INDEX + 1];
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
 extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_ATTR_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
@@ -29,12 +30,19 @@ int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 				      struct genl_info *info);
 int devlink_nl_pre_doit_dev_lock(const struct genl_split_ops *ops,
 				 struct sk_buff *skb, struct genl_info *info);
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info);
 void
 devlink_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
 void
 devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 			      struct sk_buff *skb, struct genl_info *info);
+void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					 struct sk_buff *skb,
+					 struct genl_info *info);
 
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 295f4185fdfd..78a59d79c2ea 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -663,9 +663,11 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *rate_devlink, *devlink = devlink_nl_ctx(info)->devlink;
+	struct devlink_nl_ctx *ctx = devlink_nl_ctx(info);
+	struct devlink *devlink = ctx->devlink;
 	struct devlink_rate *rate_node;
 	const struct devlink_ops *ops;
+	struct devlink *rate_devlink;
 	int err;
 
 	ops = devlink->ops;
-- 
2.44.0


