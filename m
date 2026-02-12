Return-Path: <linux-rdma+bounces-16786-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGqPM5+tjWmz5wAAu9opvQ
	(envelope-from <linux-rdma+bounces-16786-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:38:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B43212C94A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA3AE31DF785
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB72F1FD2;
	Thu, 12 Feb 2026 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ccK+St5m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671022F39BE;
	Thu, 12 Feb 2026 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892418; cv=fail; b=Ftd+/Zrmun114p+EcBokeQgzIQcUmnh9sZ00sOQoqJ15trBuHvCT5H7kS1/E2mEy/XCydvfdvwi3JyBRdAG23KOUHtAxIC3VMUbBllZGsNkVsiFgVsm2oUqxg0pJHmq1kmHo6aNrqYCo5WGvo0+camL1fNGq2ZYRPEUovhWAkN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892418; c=relaxed/simple;
	bh=F+1igmQWHROJl6DcqekvaXXZC/bcBOmy2zUluU+gmCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YC8lJEOH4ki9aU2/aYOOE6qUHXLTHA7UBRyTFNqVQcouuO0sgU2C3oKRLrOO1NjgIfoff7B+Zt9+4e49+cWt/0tAIdWZaCNX19Hx1H4RmhT3OOXwldRuoEEhwO0iNpJLN7d4NsXfGGk8dWO3/8+/VuSOQu0XYCJZqaiKO+DpI/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ccK+St5m; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDckltxBFl9bNmXxDRAcxi1LC/P3svswlX0eqbg0NZjdwf3U6RXDfhGSpox9dtZDPxTkOKEIzweu4tmHXq/NsMZS9vut7VD4917O/KS3p2GRRuhfNRi9vpe8PTGRCvyEw/wg/GIKXAPzca2D/y6PkdgDbYIaKElXYpSZvlDue8u6gLQ2ouq5p3x7Pa94pWflZVVp9tWxAOC42Xk25tyGGdwnEA5XAWVv+Y47LQ1ydrN9MQh2pjjszJK1mSrZ6Y+aToqiGekIjwYBaLziqJnm8f/UzL8GCKWfXu3aDbnzrZCdkleeDHgI8WAHU7HpA4EOSDWkAI3DYfxDbTHAoUsV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDhkAhy23HFXwIOvrjEYJ/5b1jG9R+M04ZyzkVbmiSY=;
 b=Oy7j0nX+ikJchbeJrn72mWicvt7FM20MwOc2Q8y4DVzwEmv5rkSpLlK1a6EUXILQ1teO5nVQzieGjhK2XiSSpkS7lS3DmdXNb/WgoODKX7616zKITnLIcFwV0o/tJ5+Dfmvln43SPCr96rbypFeGQ1S5l25V92e/F3LNbPml17D3FV81G4l0eLphWSvFr3sRZnSQn/qGYZpC6yrSKk3PZkoJLnj2Rko/qwaxDGhNfqiTCUOMoDiP3ZM8oiqzacr7nRqAVSICxh8kxQQ+DtjyENWRufxbud7xgieh6U9FqsDs0FTwBxAxpxxYJh0+F9sbPW7ITXWHgKk26IWnguqYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDhkAhy23HFXwIOvrjEYJ/5b1jG9R+M04ZyzkVbmiSY=;
 b=ccK+St5maU289kWgk3UCigxUfj3aN61mtLGeqw0eqQKL6oDnXdroogzvMm5eVwfSVMg7ZCibXsRIpGpaN/w7IzERYVuizlR2fTiBDpgJ30TzJrNHakfY79GdbCStn2/H5CeKeH1zPHo0u5UNVeckrXMzXhbLK3gkFycVS/b2AD3DFJ0v1ghU3ngp0J+v0yGG7F++Pz7WOWnAutTplx3naUnuLoOaYcMMlJCjl0SJY1+wni37i+2tlaABsebsGSCzT342ar1Goit00q3cT0o34yGye1UNRvBoUbC9Mq/DY1+FD0badLMQU97UYyoEami7gItiDqURvAEpMUIgVkHK/g==
Received: from CH0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:610:e7::10)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:33:32 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::a2) by CH0PR03CA0215.outlook.office365.com
 (2603:10b6:610:e7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 10:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:33:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:33:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:33:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 12
 Feb 2026 02:33:15 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net 6/6] net/mlx5e: Use unsigned for mlx5e_get_max_num_channels
Date: Thu, 12 Feb 2026 12:32:17 +0200
Message-ID: <20260212103217.1752943-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260212103217.1752943-1-tariqt@nvidia.com>
References: <20260212103217.1752943-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: b02ba699-b5bb-4774-0d7b-08de6a222b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkVtMjhxNmNRV01scVRWRlpYTS9KYTZleVNLSmhDdkdwTkVxalpiL1FoTGRq?=
 =?utf-8?B?Y0ZtVmFIT1J5VjMvMk5CNjl4WFdxdWRlN200T1Y2RVU2QzFXcTRTUFFublpK?=
 =?utf-8?B?QXVVcEFhOFZSUnlnWGxRc2RCWGNSRFd2cFY5NlBGbk5wSDVJTnpzT2R6MEhs?=
 =?utf-8?B?QnRGbGlaNWhXYkV1SVhqUHdTNGxldEx0Lzd6Q0t2bU83RVVzUmRvTHdHNW1Q?=
 =?utf-8?B?azBXQ3BkRGV1VVpsU2ZTb3M1azBCZE55QTBnRnVmQ0FYb2lmSU0vMnVmY09C?=
 =?utf-8?B?NGFTb2lkMDhOTW5rK21LbnpZTjR4aFhvbGlKNDJwY0VwQjlCSWZvM3I1YWJP?=
 =?utf-8?B?dHlaaCtPbUx5UVdrazVXc25yd0V2T1Z2emZ2akI0QTlYM3lxcE9qOGVUL05r?=
 =?utf-8?B?Y1B4U0JHc1F0Rlc1ZGN2K0dQOW5kK2NUcS9IVjh1ck85cUxsSklqSStIZ0Zl?=
 =?utf-8?B?ZjFDc1djbkZhOGtvSmVLMDduaEIwdHNvZlRkTTdwaExucGs0aW1KTlg5T2d2?=
 =?utf-8?B?cmZadnhhOHo2SFk3SlgzWi9yQk9jQWR3YVlRQVV0dkxxSGFhNWYxZmtGVzY0?=
 =?utf-8?B?N1pCVWoySTE1OGw5UVV1a1RmVjRkTzQ5dFNPdXQ5RVkyTGxnMFVDc2Q5SmRm?=
 =?utf-8?B?ZHMrRkFyQTlLZ3M3aEVwUldLU1l0TnNEM1lGaGZTdVkyaFdzaXluSUszOGJL?=
 =?utf-8?B?QmlwYkVxczQrYUhuL25MSmVGaTB4T0JNSUQ1eCt3MURNekhPdFpkclVjMnRs?=
 =?utf-8?B?ZmZjMCswYUdmNHQraHdBWTVDblpMcGFaMHFrbnd3Y2p6Z3RaU0Znc0ZGQXZi?=
 =?utf-8?B?NE94aWJ6KzZXNnVmWDVXempmbE5nQTdnSlp5V2hLdHZ1Ni94NjU5QWkyOW1w?=
 =?utf-8?B?SjQ0QkowZlFrdERlYkN5eTU2eExPcC9xUy9tNm9JRGVhblBUN0VEM0Fqa2s5?=
 =?utf-8?B?VDExYURoNEYzVkZ6ZXl0Ti8vcldUOGhCSE05ZTdBWElGWHFEYUlCVmovQ29a?=
 =?utf-8?B?ZFVqSTNxTUM4UkxialY0Y1ZUYW1WM1VLU2k4Ujc5R1A3WDJESjU5U29tKzVY?=
 =?utf-8?B?VmUyMm9uYVdsbVJzVkcxTjNqRVpFYjU0SVZ1VHJYdlBvQVdOdTR2cTduZEVv?=
 =?utf-8?B?bm9PNVZMUkgyNEVXb0FoREcwWklRc01XUzg2bVJITklMNUIzTXhNdWVyMzVM?=
 =?utf-8?B?ME1mQXlOc2xtVEhQanRFbDlmVS9VcmhPbXpDNXR4RlpmYW5uVlRkRlVlOG1B?=
 =?utf-8?B?WE1tMDJGa2ZtMDBOV0NaSHVzZTFjcUEvUElMbVVpVmtrZlNoQzVLY0NoeWRS?=
 =?utf-8?B?ZmkyWnBJK28vZXRnV1k3S01vS3VpNTczemxhSkpxNkpuSUFZL0IvWEdmeGhJ?=
 =?utf-8?B?eUgwUHpDcTZZWnJiZEhObjVKS1pZblJ0SytBVlBDVzFyZ25mMWVXZjBRUlpP?=
 =?utf-8?B?Y2JPL0QrSGNwWGd3cVRXaVhjR2lYc3NQMWNHNTExOHk3M0piVnVqRTNYU3dK?=
 =?utf-8?B?SkNsam40bGRtR2dnbkdsV3N2Z1hJN0gwcUFreDE5aDkyYXQ2Zmx5NFZhRXhX?=
 =?utf-8?B?YkxmME54bkpuZVpCNDlOZjFGcHM2aDVlYTNiWVIrSFRRTUVzdW8xTFNKU3BR?=
 =?utf-8?B?bXRXNUJiS0VLRHZUVFkybXdCTUd5Wm8vUjNSeXhRWDI2cmI5bkdjOGxVaDJu?=
 =?utf-8?B?Tm5OdEZwUjM1QnFwQkovYXE0S2ZRd3JhYkZaaHNkazRqcHQ4STRKN0FmQWla?=
 =?utf-8?B?b2VZdXFMMytaNEpqcTNlNlFzT2xVT3JlTzc2LzRPSkU4eTRqWmdqa2pYMGpJ?=
 =?utf-8?B?b1VsN3B4bm1aNTRNaUJnZnlKNkg5SEtiM1VqT0UwTzdIZ1JMWDZzbUlFYUM1?=
 =?utf-8?B?RGNKRzdCMVFlVW9pYWMwSDAxOW9XSWthNUJ6MExEWUpJNlFBT1Q3V09oR2ht?=
 =?utf-8?B?WWpNdyt6Y0J0RS93WWh5QVNBMkpqdnBaVjBOa21ISzJyWDUrSWpjWTduQjNN?=
 =?utf-8?B?VThPRzZveUhGZk03SENZT0NFS296NWNOVXR3NEVOd1Q5WEs2bnoySWRhUGxQ?=
 =?utf-8?B?YVF0c0lzN3laWWtjV2lQQ2FmVEIvRC9wUkFlNnd3amZCSjZkcCtqclpTcE5u?=
 =?utf-8?B?QWMyU2I3eW41Umh4SnYxVDlFckNSWDRIL2o0ajZmQ0lpbCtseEZKbFkrVlY0?=
 =?utf-8?B?ZVZWcGtZeDBWdmVBVFVvMHlBZEx5ZDh1U0dhclo5dzF3aHZoa0toZTg3cmNp?=
 =?utf-8?B?K2NXaWVsUnhkbFNqd3lqUWtxS0JRPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4lQBRSZEIDPbS5i5BIilVXXczefEuabtkqFCBT2nCSqZCmScn7FkUglONi1VcKDCbfeVKsO5SrjsKl6pAnLsffN6lIQnHAEkOyv1QPazV4OXbgdyc98LPQFlB/ZtNvlX+I68JtDBgWSFNYg9BFT3kMut1nFbOBVWEQTRD1Ik2cbWBjJRr4U/o56lL/NwDwU7lTg8a0dns+7ocmrDgJFt5BV5H6dfFuLCyVNaU3ddy0jsrkbKzESZJtgj8aFmLhcH32WqHaFnUnnVoMdfFIfJvM2Ej9xJo1i2m45KVcXf4MglqD0PWLdAv7sOzA5vQTZFZ+/kn3g1/H/yer9B6lxyQGghYdo78IH0z51vzJuRYPSX/J+hGLdzdT+M6zk0aCdmNrBEcBJ0MpBOmJyjPTU7+OMZR+kKhoQ8rhf15k/rZa09P3Fwajs6DvEzSb6r6iQM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:33:32.3892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02ba699-b5bb-4774-0d7b-08de6a222b9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16786-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7B43212C94A
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

The max number of channels is always an unsigned int, use the correct
type to fix compilation errors done with strict type checking, e.g.:

error: call to ‘__compiletime_assert_1110’ declared with attribute
  error: min(mlx5e_get_devlink_param_num_doorbells(mdev),
  mlx5e_get_max_num_channels(mdev)) signedness error

Fixes: 74a8dadac17e ("net/mlx5e: Preparations for supporting larger number of channels")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index ff4ab4691baf..a06d08576fd4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -179,7 +179,8 @@ static inline u16 mlx5_min_rx_wqes(int wq_type, u32 wq_size)
 }
 
 /* Use this function to get max num channels (rxqs/txqs) only to create netdev */
-static inline int mlx5e_get_max_num_channels(struct mlx5_core_dev *mdev)
+static inline unsigned int
+mlx5e_get_max_num_channels(struct mlx5_core_dev *mdev)
 {
 	return is_kdump_kernel() ?
 		MLX5E_MIN_NUM_CHANNELS :
-- 
2.44.0


