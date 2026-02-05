Return-Path: <linux-rdma+bounces-16582-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMQfKnymhGmI3wMAu9opvQ
	(envelope-from <linux-rdma+bounces-16582-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:17:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F981F3DBB
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CC06302419F
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4373EFD07;
	Thu,  5 Feb 2026 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="e/3aa4na"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C3E3EFD26;
	Thu,  5 Feb 2026 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301045; cv=fail; b=q5Nlq7Jhg9oKjw/Jyii72wPxAfvXUTM8OgVW1JTpOvUQ4puow//Dl2FNnV7j1XaAsmTVm0PbYNXw5ehiX1OQHc55lOe4LtXSgilbi4XU3LsnpzYKURt73rVs5z03Ek9MiIknG2XM1vaN7fk1RaG+F5MKVeDncVFLZwW3Mf00cWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301045; c=relaxed/simple;
	bh=Bm0/2Oczg9pBo7ZnIPAx3yP9LXYV3mH7KGNeQ3JwxxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qs3azBwvRx6Q87eY/Hb+HcSqr2jY/TRMpZl/8rkUKiscDhaIFSSWizyAFrCA/FpUaLsgmDNr+lT1/SLbPYuSpii/naufVJ/VCeuAEKfZGf1mk9snkhEAt+pHy1DueIRArF4mXYHI0LcqxAGk1gULBrDSdr2I3cU/Ra+XUT0CQOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=e/3aa4na; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzgtFW1eI1+o5mRCnue40pzD0/Bf3mJBMHZkKouYB6VLUl9GTIQVUJOEig3hjFfJ0YEjUnob2Xh/UKBiqLGP1eVnrjwHw3UFWd5Z+QLKpx+ViHhuNhM/iHu3T2EAnC9KKmIfLaNOiYAvamIKNU3+eZDxQJoa510J7yr1n1XPUJs61fJ649Fls4K+zRh3VtSDFmmCtJ4EdOSlIMhLkcliAef5n4IfFMZSByjRJ3cHnhy0lmoJdx9Bynr6TEeIBMO4clC9IOuaXHzdOfJ/1AvfQFws+f+P878mQPRcTRI0GAbja7cvBd96VCKdoKM1MaJksOXKnYCCP3OPJjTTRLZgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uulx5U6P0zHq5I7SklgKDbucTUhWLMDZpFkAI9Zla6U=;
 b=PZUcdpWyWWU0tRRoKItrHXbnBfoel60HA0D++WSE1MrPLxcv3XbtHOHoCGAkNDc4d+s66cDrpZHETyEzgeohc0M+Cy+ef2Mb06PM7hlmSF2QVVC9kQ14w99Z/pcWPj7xlajR2pRKGXsquX6UeZQ8cL4dCPF708Nvjt5cyYYRrdjxNVtTPw86J6gOqGzuYgsoFALDEBaorWM12+PdpPT9P1cd/SsfXZHzyCqZZxhTSU3+CxtN9KagAH6VyJx9Y5wUT7KrYBiy5CXWu5Y8jEgScAaYYb0w71aUlwOsGnnKvOC3DhpplK57CgK/WRzbkh5IAY7cg6FI3zoX49nYo472Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uulx5U6P0zHq5I7SklgKDbucTUhWLMDZpFkAI9Zla6U=;
 b=e/3aa4naE9mktgRFD9uDb6JdLElHOeQ7alhcg4vCY1ZydEJw8dHtp6t2pCCd2+cOfauDRigp0pva8YbsTR68zEghSrYsG68UkRfF1vIQJO5+sSWD4zZ8yZIpTYaWqA/A8wiMFth4k+DbbXHqfsFS+IrzSnudHUYw7P9Y+JlmJaTumRqXMKUvKHZ30cAYyY1RhxUuP4wgf/g5HTMLhCr5bbOQYsqQV0bna+9e0i6ismam3z7PtO/rAE1l1JHT7CEVLVG9jqkBgbjieazrPvPGU/07y+E8xyeOLtz7OCN1kZPLKNiv31rqKPnGp36+DtiKidbDWzBJX8w0y9MUfsQlDw==
Received: from AS4P195CA0019.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::6)
 by DB5PR07MB9478.eurprd07.prod.outlook.com (2603:10a6:10:4a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:17:20 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::28) by AS4P195CA0019.outlook.office365.com
 (2603:10a6:20b:5d6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 14:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Thu, 5 Feb 2026 14:17:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 3E6AD23688;
	Thu,  5 Feb 2026 16:17:18 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: linyunsheng@huawei.com,
	andrew+netdev@lunn.ch,
	parav@nvidia.com,
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
Subject: [PATCH v2 net 1/2] net: update comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Date: Thu,  5 Feb 2026 15:17:09 +0100
Message-Id: <20260205141710.12609-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205141710.12609-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260205141710.12609-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A60:EE_|DB5PR07MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: c23d41ed-e2c2-4c11-7b4a-08de64c1460d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGtHMXRzekhIRUtzeisvNk5WNXNhZlNxUmNuNENiUXFPUGJCczRMd01Ia0Ew?=
 =?utf-8?B?UVZoZW9yOFdMUWROUFBHaGRXTkk1M2JDa0hYc3hxMndzTWUvbmxaRUg0aG9E?=
 =?utf-8?B?VkxvSzh4UlVJSVl0ZVJGNnZVUnVwM1hyMVh5dzJxeG5rOUJrbVhKeCtGK3Bw?=
 =?utf-8?B?ZEpyMnNwRWFGaFNNZm5sdWZEbFlod0dJUVF6bW1TdWE4UE85dVEwOCtoQU5r?=
 =?utf-8?B?THYveCtiV1FhSmFIcTlXOFBUYnhIaFo1YTUxYWxBNy9nWDNaeVJNWDFrZC9x?=
 =?utf-8?B?bkhpS1o5VnVxL1d2M0hhbEVvbUl0cFRaWk9yK1VEUVUyYWRyQ2VPRkM0cHV6?=
 =?utf-8?B?bEV5QTNvWDJuUUhMZlFEVDVpTkMvVVZnakU3RGxHQndtdVR4SUw1aWFEVzE4?=
 =?utf-8?B?TjhTdW5XcHZFdXhMeEdwS1Rna2ZSRWpFN0x1KzN1VkdQZTk3Y2Q3WGV5cEJn?=
 =?utf-8?B?V0hSc1k3Slk1akJNNWp2ZkFEbk44Y1Z1UFVHdS9nN0VQcThITkJSNldLcDd3?=
 =?utf-8?B?QVhmZkp0ZzI2Z0s5L21jbVp1QUlLUXl0UkZiN0tFWHY5eU93amZwRTgyd2hk?=
 =?utf-8?B?aWVOc2NTV1BxbTB0RCtCaU9Ed21DK1Z3QkZwbG51ZkdDcGlvcXB3d0s4bFhW?=
 =?utf-8?B?MWNsWDRjald5M3pCM0hYdVlBbDdhd3VyRXZyMjNwejJpYnZUb0ZOOWZxdjRT?=
 =?utf-8?B?V1JuNmtJbi9pODIvSnhNaEsrV0JpQjBYQkVGM3N0TzNkUzluUTdGOFBzSnYr?=
 =?utf-8?B?NmRmNU5jSGphb3JkN2tJMzk1d0hLNE1YZEdYaWFMRFlNa0I0V29TSHBYMjcw?=
 =?utf-8?B?Z3E5bGNobVQyS0t1YXhTRi9XWk5OSmFGRzRDUzNPVEF3Z1VvN1JkOGtpTTZG?=
 =?utf-8?B?MzRWQWFMTzYxUjJDS0prbGJqemxMdDFudUtDYmJ1cDRiSHBrbG50SStFb1Ba?=
 =?utf-8?B?cEhGUmhXdnVjMzkrcnd3ODdzTTYyTk1Ed0lVYzRBWGNiMFFWajdQSi8yLzcy?=
 =?utf-8?B?cDAvNHZmWlo2V0wxdE9MY2lLa3NUbWp2MzZ5Vm14TkJ3b2NtdmJ0c3JFWWRM?=
 =?utf-8?B?NlZuNkZXWDV4dER0WlpHU3hVekY1TWU4SjcwQVd5V2kva21aUnRQVzM5UFBy?=
 =?utf-8?B?Y2tSWXFnUkQ3YmJyNFM1aktNM1Z3TU1xOWEyWSt0ejZUODBkSitmZ2k1R2hp?=
 =?utf-8?B?WW1lOUxZclZVM2VTamFWTVllQzJHd21wL0VwdHVtczNvMFRKNkNuWVQxR0xZ?=
 =?utf-8?B?TkFuYzJzZno1cEh2UExMMEIvalRzbUpYR0tpYzE1YTNSdW9Lay9qb1B4TmtE?=
 =?utf-8?B?L295K2lmQzJEN3VBUVdlNnl0M0xaNkZ3emM0Zm1ERXQrTlludlUzNXZWOVBE?=
 =?utf-8?B?aDVNdEd2U0xHbFNMRUl0TXZlV2w4SVpxTnE2eGZyYlRFU1JOWVd4MzJ1M2lp?=
 =?utf-8?B?amtHMlNaWmpUOEVaeVBpa2ZlZ3ZwYi9tRENmSTE4cTVBVjk5OVV6LzRsWXBi?=
 =?utf-8?B?LzlIVEVwd3FNWjN4S3g3SW85UzNWa2tJMElQTjFlWTdqZG9uMmtCVkJmdUwv?=
 =?utf-8?B?bHNRazZrajNTVGV6UGw5Mlh4TmJYcERwNW1GeGowb1JqS0FVbTFVakhCVmRh?=
 =?utf-8?B?OE9MOTZPa2lXZ2VLTHJiRWc4dEh4alI0VHo4QWk2b2xZU2lxd3g2Y0hjdlRs?=
 =?utf-8?B?d3A4Mzhrb0hqYTdNMUlHUnFaZVN0aEFaUU4wLy9IVFMxZTBLcFhzM0FpTmhu?=
 =?utf-8?B?L3BIUjZKRkUzL2VMVHM2M3RLNVVsU1dvbis3RGc4c3BWYVRvYW1oZ091WE1J?=
 =?utf-8?B?SS9nTzhiTkVWQXBCVmxUdGJIdDNRSHR1bDJlcE5iczJtYXNlczU3bDBldHM1?=
 =?utf-8?B?bEdyQU50bDhLTUdOeVRFZVY1NXQ5cEhmOXcrRW5uQXVpRTJoa0JzZ09YQVUv?=
 =?utf-8?B?SG54WEtRc2E5Ti92NkZueHpMT2tRUTdRY25CdFlrTlloTXc2a1hIWGxmL05h?=
 =?utf-8?B?bVFFWkZqclVNTVVzNGVsMnErNk1Md1lUVSsxL2FZQ2VpUmFaZXBjRERYblBi?=
 =?utf-8?B?eERzWEFmWlBuNWpGN2lWS24xNnBpdUpOVW9IME5mOG01NDN3UG9SMzFGdFFB?=
 =?utf-8?B?OUlTdi9aVmt3bm1KQ09TVWw3Wk9BK1A2eEJXbUFVQVpjSWZCZERhbG1LN0py?=
 =?utf-8?B?Wkk1OXVXN3FHcXZPbmo1cGpjbGhoSlpyN3RkcjA3bzVLV0VQclBydEVuMURk?=
 =?utf-8?Q?O9GAq6O/CDjIxtO6CA8q75NcptWfS69ajW9VIV/j9M=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N6kfd2RzZH0X2THWDwIycVlta/4uC1qGR/8yb+lUV6uTFYZesuLqewwBkd2lQd+mS2Kk1upNSh74xtSXdiNg6+cW163iNDe4zbvo1scIl6yZ6DA+KAXSF5W8ZcpI8v1EdYnXpXERsFNfbCKj/+Kipif1gEjg+u6u+MIx2msujV67x1eCax0q2+Oh9RqYSTshSICEgYSPXdMmxSah+fS68jQCOPxUCGgbXueKHqb3QIJAttNfY9rNkqj78YGFKaa01wkP6eVv0uA4UUNsk8A9Rzh7cx+6m6afFHh2f/Ju6oGA8ZstJPlyybyZlLhThxPCX538IMcaNlvoidCLm5ZL4JM44onJPECdeAO78JHzySCzpV+RL0ct93PcZ2JnMe+1NnSSK0GMtM56A2V8MeeddLxDoXchRlH+4xWSRk8/DL24K9ulNGJ9ADz8TfqpCDhR
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:17:19.9007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c23d41ed-e2c2-4c11-7b4a-08de64c1460d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9478
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16582-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F981F3DBB
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
index 112e48970338..7ece0616dd5d 100644
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
+	 * preserve ACE signal correctness (CWR is part of it) in a forwarding
+	 * scenario, e.g., from one netdevice RX to other netdevice TX
+	 */
 	SKB_GSO_TCP_ACCECN = 1 << 19,
 
 	/* These indirectly map onto the same netdev feature.
-- 
2.34.1


