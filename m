Return-Path: <linux-rdma+bounces-16507-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPtuFlcMg2k+hAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16507-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:07:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 823E8E3914
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E404301CB33
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ABD3A1CE3;
	Wed,  4 Feb 2026 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="gUcooxmU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184CC3A1A5F;
	Wed,  4 Feb 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195843; cv=fail; b=T4fpMpIFdT2TU4+6eVxJ1MwiRDEN2iILMhacddGnynvJ/6UURCmCWRaMoWltdGXHBM6s9GOzxeAE1Hj6Deu+kfNbT2vVoRwAOxefe802kTVb+ZNU6HYLYoDHcZb2ObauwauVUgphmUcJd1vyOx8p8jw+p9eQgSpjJqy5NztSJLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195843; c=relaxed/simple;
	bh=HbZFr1IXZHKBMWQqRxhJfwaFIa1drw+T4GLg8Wi7pp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o62bv8qfY0GgJNBn60214Py5yqKwxRB9I8rHfJHBW4/Cun42g4mLLkjxw9Y9m6Vddfb8y35Wmj5YCpFxopsjkH5+VNuP2yTx5W+/hGk794Uyzbrz+usuZ232Xn1KtJQRAAz1DAw/NG5cPh2oBhjWU2GpImuOEe5U7630dl0RgeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=gUcooxmU; arc=fail smtp.client-ip=52.101.84.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJzZBzeeSO+vceI+6s6+BtxGVmf3cZYmGRgWZEMlmnLvUY9R402+uEy4NpzfifDocqJAlbBgMVCUF9Ys5kcSyWFF0qWIZhXytuTBmIwg+M6r/6yfeZBnWQBBKazoGVWNdZ54W9vgmJ+SHHgjbZm15somsgTfOgSaoIE5vaGYN/S2ZPS5p9A9AHLYmnsN/g/WIl5XAxgT9sKmr0Uoicmpbh5Pzolba2/SLedSTWvxzxNTD5bDTr/ND6ZkmDAuu434sm0DWYgkN3ccHTRSh+R17iwTkiYzrrcZm/tWD+04Z+xEhmo5k7dknA5dEPRYhiA+dHWZVWbepWTxDp0ONIcxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlAGOse5DlQdBTlwKelc21cMkgYfalu5DNglZaWAdrs=;
 b=YMGTP8PQkNFk/3QN+FtTg6nHxVQSmINUyWwiMQX/qwMPtc1+j4XQnQ/2cF1kiKc74T6Aa5qJLHU/Yg4jLlxSIOcJeiKVDUV3432LPuqPxFlzC9RCPMp+kA/s8zpwTFUD9wa9veK8eIWs+hyORvtHKlPIp89s0fD0h1fny+mvifKRpV6FAqnwGO8TSXJbq+/2IKmzZ22aypV+AQY8ix6DZxv0hGLkXyJHmZcafcwaHRQ4wAEDbGmd6GbwhPsZj+9jYDKojLQpBS9Xgn53xEiX+rLPhxy6ZZf3i8YfdWf5DgCV8JSyXKs98q7N2+epC4CuQS9lYyOiG+b3frLtAb7shg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlAGOse5DlQdBTlwKelc21cMkgYfalu5DNglZaWAdrs=;
 b=gUcooxmU55bOCfU3glD46YtNh2lk80zEnNptSMboWR/FHjhyvJOhtxJH4pah/pOzzFXHREmpInaV4nE08najG2I5hQ24utTUfhuIAB6l/AxdWOBMi9ZZHZspnKx2rVCzdzrrqCsGgzLBbE5g+ByWyB9t6XikzirzAoWlKeXCg5j//HvnRSGfVR6fcodzSUUiLKILnmJnv6UoOJdsOY/qxsKnQf0PbNDOXx5ZTw1DVnCjZVOHFpABn6dndvgXtg51FL6FwKEhgdHj7V2SCpUwJZRhWwFKyr5S6D8TfG3rhE9peRGQ4htaovR2/OYSW3gfZ2SZrRZIYXXZZnhZ7fEQBQ==
Received: from AS4P195CA0051.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::17)
 by PA1PR07MB10835.eurprd07.prod.outlook.com (2603:10a6:102:4df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 09:03:57 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::10) by AS4P195CA0051.outlook.office365.com
 (2603:10a6:20b:65a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 09:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Wed, 4 Feb 2026 09:03:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id EB56A20165;
	Wed,  4 Feb 2026 11:03:55 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: parav@nvidia.com,
	jasowang@redhat.com,
	mst@redhat.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v1 net 1/2] net: update comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Date: Wed,  4 Feb 2026 10:03:09 +0100
Message-Id: <20260204090310.7528-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204090310.7528-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260204090310.7528-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|PA1PR07MB10835:EE_
X-MS-Office365-Filtering-Correlation-Id: 606961dd-1e0d-423c-d843-08de63cc5462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnR5TnNSUUlNb05qeVUyYlM3MkRxWnU2dVY4bTI4ZHlzVVRxK2I3OENxUjhK?=
 =?utf-8?B?VnVKcWVCREF6aDk3NVNqNmN1NkhrWGNBOG0wcC94OGtwaThWa08yRDBVQlFW?=
 =?utf-8?B?NEdhemQySkxIR3ZUY2c1VHNaUE4zR3FBMGNGMmFaVVJTbzhQaThHM3VrR0ti?=
 =?utf-8?B?WDFWY2sxbFZRNy9FcHppYTlPd2ZIeHYxd1RaQTNIWkZYMFBkRUxOcm1LVThL?=
 =?utf-8?B?NXlkVlF0WnhUSXZlQTY0Zno2eGh6a0x4anF6YnBjemQ1V1V3YkYrUXc1UFIw?=
 =?utf-8?B?OSs1ODNZYjVZQ08yY3dhNDhGc3JEOWgzMkptMWJheUNwc2dTZFI3M3p0bFpq?=
 =?utf-8?B?WEkrSGFlaXJORzMzRWhrbVFnemJZQUxzNUZlOHR1a0NOaUM1WHVtaC93K1pp?=
 =?utf-8?B?TnBDVTcvZ2xXemJaVjRlbjdlOEthTXRQeEdzRUlMNkRoNmg3ZzlMZU03SFYx?=
 =?utf-8?B?Z01rSFIwVm1hZXg5aTJlbmJZbjR0dWpnVHVUcGkvR0NMNnRYUHV6Nk8rRVZH?=
 =?utf-8?B?cExyRWNjRTFzNG1VMVpoRU9XcVFwamgwaXd6RFJ1V1grRXBXWjhHRmFLVEF0?=
 =?utf-8?B?bzNkSWVnYXJqMlE3SFJWbUY2eTF6Q0trb2p6TXQ3SXRSeHBVcjZ6RDIrS1dS?=
 =?utf-8?B?MjAwRW1oSGtnTkFaYWx1QSthWkZCYVFpMU4wU3ZkSm81QlpkQTBLckxJdmty?=
 =?utf-8?B?ejhJUUc4bHprdUd6ejNnNXdMOThSakx6Rm40eFFOMXpLTnVBUWpDejdwWGlH?=
 =?utf-8?B?d3NGN0l5VkJrQ3lLdDdDYjVIQjZBTHNSVUVuUWxOZWVFMFBjenZIblREZkNR?=
 =?utf-8?B?L044QWpCcTYwYUNwakRocW9YTjhhTlRRQStwcXM5SHJvb1R2OWl0NzczMzla?=
 =?utf-8?B?d2U2T1JXKzhlQlZHNkVYVDVNaGJZajBQNWVBek82dlFVNjBQYXhyYVFMS3ZC?=
 =?utf-8?B?eldXMzhMZFhhQVpsUEErV1BGcTRjZFVqb0hwdnkxT0JHdFBTcWlqdFNGb0xv?=
 =?utf-8?B?RHBsd0U4bG5jWDVLcGR4K1d3NnlzbHR4M2RUdlcrM0thSE90dDF2MHk4U1k2?=
 =?utf-8?B?MzczNVdSODJGUlYwZXpDalBLMzY2RGdoQXQ5dlVXSHlBellZOGJ3ME13L29U?=
 =?utf-8?B?VGdrN2x1MFV5cTFvd0FLc1RZNGptZzByZHFNYXlRZmx6MlBxYkJLQ0dJMjFO?=
 =?utf-8?B?anJ6b2hTNDRPd0NXMkVMNTRlMndEb2tOVlRPSHdibFhVWnY5R2MyZ3ZTRGxG?=
 =?utf-8?B?R3o3K1d0aW1FRjJuR3U4TzVSL2plcUhlZDduWFRTZjZka2ttZzU5MDBSaElP?=
 =?utf-8?B?Y3lnWWlJMy9lWU14STFkaXhSL1ovUmlKMFc1MklBa0dFVjM5VG4xb3dTQ0NI?=
 =?utf-8?B?L1VDZ2J2bkE1azRkaVZyU1MxYzFtL2JPTTJVNjVXTmdQNVNBMGtuNnQrMzVM?=
 =?utf-8?B?eHMxUnkwc0RZL2QxQk9iM1BOMHBqSWFvaWxUZCtYeUZUWTRkbU5NTmZKbUZx?=
 =?utf-8?B?Zy8yUThGdy9aMFdHeHFkaVl6VGFSYkhuWTQ0SC9DbFFib3dJODNjVzMzM3lB?=
 =?utf-8?B?aGFVdjh1MUZTZGk4VHVPNSszOWc5RjU1WHRtMUJCR3NTMmo0c1d5QTd0YXpa?=
 =?utf-8?B?WVY4dHhZQzJDdU1kUU04ZlZkZm5qcllyNWpoVWs4N3F2b0pIdVJjOHA1MHJx?=
 =?utf-8?B?N0Z0SFpjVEhadkZxeUs0R3Ayc2ZRVkpWMVNteTZNb0NIY29ZM0hLMXNxVkp5?=
 =?utf-8?B?OWYvSWl0dGVVWEgvUGQ4YnZZRmlzZjVHUFBZdURMdURXVk5QQ0cvdkppaENz?=
 =?utf-8?B?Y01ScnB0R1h2cXNxdVFjbWJhL1R6MzRwZ0p0UERiNzhzMmV2SjMzMjVLWDMz?=
 =?utf-8?B?Z3pGNXVQVDhXOEIvaUZIcTBCQmo4NmdaNkFaWTBOaGhZUEhoVWFFRnZxVHhM?=
 =?utf-8?B?eVNZZzFsQ3F6UlhPVHV2dmdaV1NVM1dMaU5QaXQzcHVmcTdJMFVha2JjbUtZ?=
 =?utf-8?B?VFpWSDdpYmdRMGdtZHhsUGswK3FEWUR2TmJxTGhOL1hpcW1YQml0YmFSUFNm?=
 =?utf-8?B?U1l6VlUvcDQ2S0pNUDBLWDlnSU0wSFRhV3lwT3daZGt0WHpKenBNVUc1NEh4?=
 =?utf-8?B?Vk9zOTFTYmpsMTVDbzlhTkVWL0w2TG9ycVVNZTZrWXA1VnVBa1U5VDNyOHFn?=
 =?utf-8?B?R3g4QUZxeVo1RW5OcFlkTEhaQmF2ai94WnBaWkJNUTNiOFFsNDBHVWMxZm02?=
 =?utf-8?Q?X+RsWU2UeyliKU8WPrbx7XX/zowPYAITrjefzP4bc4=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AnNvuOaOCp8PJEO4r31iypBPXPAeiNLwtt7CEwiNBLf3103H7oL8LA364nMPl/aJ9TKA4xpk1je/ZGfqbDcShhIVXQdcsXJ7cBQEF6tK/3Vqba8pvWpsTiecEEu6UTjHHrl7nLId9zlx9DTZCn8BtY8wTbqqegGmRj1GpVAyNuamR7lPYlQ0ApW+J12kR/NIco/X5t9HMVkZLQ1P8WpZJJkqezkNBbA+2TF+Lgr/Rr0OV1gMgmZf77pR2M9zrqr2cTfrlt/SiLVdvrwGQY47Gr47CUiDBtue2B5OGygykCjyYf5bi0ZNdUldloIbkGePIeNPnzxs9MJIaFt1jNiJ7pvoYJv3zJV74MwuTz9nippfU9ZcTHTalhxREF3pDNoq8jbI0SnisObUiar0mQnjklrmTg97spwJG84nFg9YyPbMO3CL2VV+ilr0PwMgoaMc
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 09:03:57.2524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 606961dd-1e0d-423c-d843-08de63cc5462
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10835
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16507-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,redhat.com,huawei.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 823E8E3914
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch updates the documentation of ECN‑related GSO flags, it
clarifies the limitations of SKB_GSO_TCP_ECN and explains how to preserve
the CWR flag (part of the ACE signal) in the Rx path.

For Tx, SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN are used respectively for
RFC3168 ECN and AccECN (RFC9768). SKB_GSO_TCP_ECN indicates that the
first segment has CWR set, while subsequent segments have CWR cleared.
In contrast, SKB_GSO_TCP_ACCECN means that the segment uses AccECN and
therefore its CWR flag must not be modified durging segmentation.

For RX, SKB_GSO_TCP_ECN shall NOT be used, because the stack cannot know
whether the connection uses RFC3168 ECN or AccECN, whereas RFC3168 ECN
offload may clear CWR flag and thus corrupts the ACE signal. Instead, any
segment that arrives with CWR set must use the SKB_GSO_TCP_ACCECN flag
to prevent RFC3168 ECN offload logic from clearing the CWR flag.

Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/skbuff.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 112e48970338..85ec9632af58 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -671,7 +671,13 @@ enum {
 	/* This indicates the skb is from an untrusted source. */
 	SKB_GSO_DODGY = 1 << 1,
 
-	/* This indicates the tcp segment has CWR set. */
+	/* For TX, this indicates that the first TCP segment has CWR set, and
+	 * any subsequent segment in the same skb has CWR cleared. This flag
+	 * must not be used in RX, because the connection to which the segment
+	 * belongs is not tracked to use RFC3168 or AccECN. Using RFC3168 ECN
+	 * offload may clear CWR and corrupt ACE signal (CWR is part of it).
+	 * Instead, SKB_GSO_TCP_ACCECN shall be used to avoid CWR corruption.
+	 */
 	SKB_GSO_TCP_ECN = 1 << 2,
 
 	__SKB_GSO_TCP_FIXEDID = 1 << 3,
@@ -706,6 +712,13 @@ enum {
 
 	SKB_GSO_FRAGLIST = 1 << 18,
 
+	/* For TX, this indicates that the TCP segment uses the CWR flag as part
+	 * of the ACE signal, and the CWR flag must not be modified in the skb.
+	 * For RX, any incoming segment with CWR set must use this flag so that
+	 * no RFC3168 ECN offload can clear the CWR flag. This is required to
+	 * preserve ACE signal correceness (CWR is part of it) in a forwarding
+	 * scenario, e.g., from one netdevice RX to other netdevice TX
+	 */
 	SKB_GSO_TCP_ACCECN = 1 << 19,
 
 	/* These indirectly map onto the same netdev feature.
-- 
2.34.1


