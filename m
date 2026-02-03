Return-Path: <linux-rdma+bounces-16467-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAQfFEEegmmhPQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16467-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:11:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F012DBB81
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9655E303F8C6
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295E3C198F;
	Tue,  3 Feb 2026 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JbMxNii9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D63C197B;
	Tue,  3 Feb 2026 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135100; cv=fail; b=FRAJ6UH2bTlbrKDluwtUPTWolNsJrVeVYh32+mdglZnM8OwxTVjkrF3rcqyenQ0NYUpISzWBDJB8deDZxuHiZh8ZbLv6X64XljaM8/Nl/ExvoO5c/w6xUGfdIK1r/BmpnHsWWEEKPJprlX0oTsjTXBPEBz2yrcBsdKODLLBOBsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135100; c=relaxed/simple;
	bh=3jNJG53JoiiNxEAV9L9e6Oqlvwbtz3KZPMJawOERlFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9vPRiJ4GGSb3e5aOFwzN8Nq+w8Rqf7M0OQeTqZ7TXDYNmRkApUaNHaX9EmhkxAxHouwWqxk/oZYIsngQbV12KP97wa0/JPSJGxiFWXDt6URNO013T+ajVWFKvNiyqhdKFlseOAcdezBtMdaTftuc7kaJw/Jm6NfHLSw9M9eyvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JbMxNii9; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x85CWG9NXEjXx3WAeZDu2X8ya2FxHvg79h4+OBI8+n88mnqjE2JUM07Gfnz4WsP4E1s5Q1fGefhLutma2PJZnSeZk+kDqj51jballICgJbIUUk/tEOyGFwiU6H2lo3s+FYt3J1RFHybo/0PAsICqA6sz4JbjEFxrKGwoTkeKxuFhvkDlv59hhrAPEZkM93vXFEAPnSnYxmXsg/HviZZq1lC5QWt/AfuDLTnzrj5qqs4ivi0/ZnXWWtBxe4d6SYDt6EF+lf3PkhcM0cX3dp87DsfzehBCic2FCKryvp+KDPGjCu78eDKCCXAI6a15rAMOdZ0/jylfJ0E5rjo/7YtbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIILJKc3Uf6TO/B3aa8LInxJ/4kMKg6ghKM0bxNfV1k=;
 b=QDqQcLGb97afetNBCDoz3piiJNflud/gHh5oaSUShro8058AUiaLCQGcEh/qEUiaWKxB/yaz/zQjbrzhQa+jVXU17tMF7GKpfWqPreTADNaRlELNCPshqTygvwTxJDvtPdC39X5R1D6/V69DAMCmffvIkSrKgGtHF6l/Xj7SyQkaKDRHy0OtjZZ+cmaPpq3Y0gDYOSJXQsvmjIcpfeulJ2+1DsqO8XjGf7LoRlzugfeigASOFQiqOGsxJz86NcWG/2205FwtH83BRjVQgXfXC6Y3QjLu28FRqDWJ0mxnodcXEikKP2clI0VuH5asvlNdcOgmBp6ASeMKaIVdntfztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amd.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIILJKc3Uf6TO/B3aa8LInxJ/4kMKg6ghKM0bxNfV1k=;
 b=JbMxNii9jpGlBdWrcUb2KVXEURG4qFhznmSxPczpd52A6x0tbg/lME3xp6VxF0y2+bjOmLHCpxrCtY8xuHMh/G4e3ojrBkwN3HnQJSE0bGjps2diRKCbIBz4Q81bxUBI12mL+xhWWo2So6xFnpHceL6MIzBqD+hj+HsoHfVv1uKA2lAAjUQkugr0Uk55Df6fFOulmRk6wssLLrdIxk1oIH92XnDHnCO1RqASu4kPnlO0SdeRJV73e+vBKDYB79nP4OA9898eY/HYYQKAbCHjfcgzoVXR75mnTfilVXvn+9bySo8S/bmY+2B2Fletztr/cew2lPkHIBD19peh7+mtXQ==
Received: from DUZPR01CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::8) by AM9PR07MB7140.eurprd07.prod.outlook.com
 (2603:10a6:20b:2ce::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 16:11:32 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::99) by DUZPR01CA0065.outlook.office365.com
 (2603:10a6:10:3c2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 16:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 16:11:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 580D42373A;
	Tue,  3 Feb 2026 18:11:30 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: tariqt@nvidia.com,
	linux-rdma@vger.kernel.org,
	shaojijie@huawei.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	mbloch@nvidia.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	eperezma@redhat.com,
	brett.creeley@amd.com,
	jasowang@redhat.com,
	virtualization@lists.linux.dev,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
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
Subject: [PATCH v3 net-next 1/3] net: update comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Date: Tue,  3 Feb 2026 17:11:24 +0100
Message-Id: <20260203161126.2436-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203161126.2436-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260203161126.2436-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FF:EE_|AM9PR07MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 642d1156-ac1c-4619-4100-08de633ee59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vy9SL08yZ0E5VW04S0Z0TWIzV2htRWFLL25vdVQwYkxNN1VxTW0wdjMrRkc2?=
 =?utf-8?B?SWxwQ09DTU1vYUxhSWxGdmZMcG1IK2dwT1dENis1cGQ4dHcwSlNpNE1CWkk2?=
 =?utf-8?B?d0lpMHA1bE5Fc3lxUlluWjRUdit5QlAzVEZMWWdaV0tvZWpJYmN3dzVEQ3kv?=
 =?utf-8?B?Z2xJMUphNFVwZlFkQ1M2V0N2V1ZpQk5MaTR2amw3eVlMOC9aVTR1cktnZW1z?=
 =?utf-8?B?S21DTk1vOUMvbXJ1TnIvbjF2aWlVNkxCTXRIYlExOFBqTjdLTEdtOHZubG15?=
 =?utf-8?B?Y1BUeW9ZcmxPNkE4WTVkOGIyZG1Idmw1dHdLLzF4UnR2TVpkNmtoYi8wVTFF?=
 =?utf-8?B?YnNRYUEwYUdTN3lqZVFBTVcvU3JDVmN5b1ljRkhxQ1dXc0h1NHZKSlFndDEv?=
 =?utf-8?B?ZFRqbEF2blQwM1JDY2N2UFhZcmgxYTBNejR4c3VaU3BLcXNyVlJuTGorODVt?=
 =?utf-8?B?Zmg5ZUJLdnlmWnh3b2ZnSFJySWVBNkt4TXQ3QVVaMlB6QUpXUzNKT0ZIQ2Ja?=
 =?utf-8?B?U1lzVndnajF2QXQ0WHUreWt1Q2d4cWtORGpuNFFkZS9LbnJIRzB6UW10N1cr?=
 =?utf-8?B?eEF4UHFsV29rSGNibmwzUHljVmNlV0EveS9VdnMxRFA2cDBDdnVJSmQ4cytB?=
 =?utf-8?B?VDlqazVSSHd4R2UrcjlrNTNkanRxcmk5UXhEV2JUNGMwb2dkM0VqRjZKL3la?=
 =?utf-8?B?eUNLUUMvV2NBV3gwV1JYZVkzMkZ6SHBlM0o2SVFLZ0ZTbDBCcnJqU1FnRXp4?=
 =?utf-8?B?eGhBaS9QL2R4ZDk5TjNkOUtNaHlHQ3NrRlNPY2xjOE1vZS9BVjNpMHIvRTRE?=
 =?utf-8?B?VWpkVWRBTFQwMERUM2xsNFo0V2hZN1J1WEVmTUErSXlETjZ3dmdRQTE3ZkJj?=
 =?utf-8?B?RmJjK2Ewd3ZPRENCMzhDYjFLdkdMWUxnVlN0RDYzM2xmU1Zub2tSQzFPUUt3?=
 =?utf-8?B?V0thZTB6TXFlcUEwZVRTRlEwYUJ1Z0dVYWRyWGFMZ0VFYTJxenBISE5SVkU4?=
 =?utf-8?B?MmNwSjRLSGR5R1lia21zUHlFUUsvNTJjcFlOemk5ZDM0NUhEM1kwajMwWCtq?=
 =?utf-8?B?UnR3ZUt1bUJNYnQ4MzZCNzVTb3YvM2ZmR1lhMzBxQ3JjV1dGUE5icnhuSUJ3?=
 =?utf-8?B?UDJ1Q1JHRElxTHBJdGEwaVJpQWVMRXFiQlU1UTkwTG9kby9ZNC9qSGxtUkE2?=
 =?utf-8?B?eFp4UUdETWFYaUdqZVJ0Qk5DZjZVVElPMDVHTjlsN2p0aVBzcEdCVWlrdzJT?=
 =?utf-8?B?aTQ0dThaWFJrTHJvdytDdVh1T0hzVFZRWmxLYk1sOG0vZ0tHblZydlZVSDlW?=
 =?utf-8?B?dkYrOXdlNjdvakd5YWk3SEoweFRrMENvOElZcUFYbUVaNDJ0ckh2NGNCcHlx?=
 =?utf-8?B?RGN3blZtcHhRemIrd3hpd0lrMDlzWHd5aFhVa2NwTU5hRlFTY0kxK3pjUHVY?=
 =?utf-8?B?MS9UZUxwUlYzcVp5aGRSK0FGbGxPSEhPR091R3QzY2YzdXEyemZ4UjNhdWhF?=
 =?utf-8?B?VFdNTGQ3aGhKSGJ1d3dDK1pmUjRWa0pDcFZSS2M2SUVqUTBieWxmbEdNVFJk?=
 =?utf-8?B?SEFsK0wvNDBJU3JsQTk2Y3FuYXNZRlFyTkVlSEh1V0FDNzEyWGdBdVpua2sz?=
 =?utf-8?B?Rzdwc1pmZ1Vya3doMUJzQnYxVGR2RVgvejBKVFVQd293REhYaTlBRGxTbU9D?=
 =?utf-8?B?WFdWS2U3alhPNVUxb2hCZloyUldSL0hqYW0xTVU0dlFYcFRjZi96VFliZWJx?=
 =?utf-8?B?ang5NmMvallneDdMYjJ2Q0Z0dVZJZlRGRnJ6eGNZQVNzTmR6WWVQZjVvaDFr?=
 =?utf-8?B?WmV6WEFvWGQ4QXVPdnpVWWJBLzhqT2ZIelBEQTJ2dXd2S2tmMFVoYk5lbGdX?=
 =?utf-8?B?TjlMWEVjNGZ2aXV3V0hTdU9reFYrY3h2UFV6M3AvdHVQaENkVHdQUzZYOU93?=
 =?utf-8?B?ZFJwTmtMSmFKanZlZmJyR0E2TnBuU1gzS3V6TEIzcWlHQWhhRzYvRXIyVFJJ?=
 =?utf-8?B?R2ZvZXprL3FmODhHOWl1WW9tL295YVFLblNtdGR6Y0NNS2pMSmNLcDdBRloz?=
 =?utf-8?B?RlQ5bHdaNTUrb0J3SExSYUpoUnBnYXozVk1EMDYvYm8rbkhTYnFFQ2VtVjVH?=
 =?utf-8?B?RHhRVzFHK0d5SW9OU1NMZ1Z5RkNhSUwyVW91VTdWbGx6TmUrcmJNTEtrM1cy?=
 =?utf-8?B?Njc5NndJbnk0Qy95b2ZWUkNBVjBxT3hzYW5zOGd0QUEvaXpua2dOZVN2c2ty?=
 =?utf-8?Q?rrN1ijr0qBIQbP+j1zlQ9odXGtrcA1YrcOanwefEOg=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p4+Rq1Nx7y56niXWINS3/xFDcAXcI1xen8offCvfaeowRLZUCrveBQ7NzDGBBHNh1mUbng1sGqLjp0H99Hhm4eFWEMFN/Alc58UqcB6UHTzClFQXp58Fw3IbF4Cv75Qa6a/Ygmg2s0V5VxeXU3jEsvFkmGjYRU5WFsPK0LNZXSTDQUcqX2G7xBAwLS42s6x5qsDIWZ48bcXQr8LAR4DLHiE5N6GrRhngFGcEjcS223M+ALIhIHRGI0mwI116Ww3oJp3TXv9BK4wbgWFR3XiZymlUlC3zkDDCmQsaVl0WHu0nCoiSrkQpWSBeX0jySdJDqLaVyqTsIgRhHqIVsor8aNVLjzJbOb6Foizifix2k1ZTmK1MsYKGw35KcylQ7hPXf4PRBDJwmJQo5E3pyPqEoHz/pMXPCG9YnFDrmXbJry5N5vU2TGev7DIqosOsGIuv
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:11:32.3848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642d1156-ac1c-4619-4100-08de633ee59e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7140
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16467-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2F012DBB81
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
v3:
- Update commit messages and documentation for clarity
---
 include/linux/skbuff.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8b399ddf1b9b..c59f0ce414d9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -671,7 +671,13 @@ enum {
 	/* This indicates the skb is from an untrusted source. */
 	SKB_GSO_DODGY = 1 << 1,
 
-	/* This indicates the tcp segment has CWR set. */
+	/* For Tx, this indicates that the first TCP segment has CWR set, and
+	 * any subsequent segment in the same skb has CWR cleared. This flag
+	 * must not be used in Rx, because the connection to which the segment
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
+	 * no RFC3168 ECN offload can clear the CWR flag. This is essential for
+	 * preserving ACE signal correceness (CWR is part of it) in a forwarding
+	 * scenario, e.g., from virtio_net RX to GSO TX.
+	 */
 	SKB_GSO_TCP_ACCECN = 1 << 19,
 
 	/* These indirectly map onto the same netdev feature.
-- 
2.34.1


