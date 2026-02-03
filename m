Return-Path: <linux-rdma+bounces-16466-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCEKOD0egmmhPQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16466-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:11:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE8DBB7A
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAE3E3008D00
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E8C3C1988;
	Tue,  3 Feb 2026 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="q9neB3HA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3609190462;
	Tue,  3 Feb 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135095; cv=fail; b=ivWkvxnU6gxbBg4ggEYCbdPLtknr4ISgd0EnH+iFB2p+pfXBP9xpz8uQS0rXk/5KTR2ED2iIE5ncVsSPfaYr/X0uHtU5/ZHAXk6d3VQgU2oygR81cJX/8vQPdbXU5g/EJOYaViLYkWEXxoGKJQogpmlvyreP7Rw+lOS0OYlWakc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135095; c=relaxed/simple;
	bh=BEk3kud8WH/Gr7UdWfR6sU0wWh6JFyuIniAD6Q058YM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kScRuGUGTKt27TBw5nCvbtYMjF5QKnqVNOZZZfOQXMVmjA9buaEpRxS7hk/4tbh1JPxrWFuXxnbVjs9Eo4T6qNYbBCUYDoZ2a7/OwLHkxi4tDBqveUSQyxYsHmRYMFU7VI5dGdYMvNxJcr+hn5Fn70bN3r2XN+MZTY3wSUnABN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=q9neB3HA; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJlFVSRo+wVv2x8YSplT7+jvEBORCONMvT3ZjxmpZZUuTNu/eXu9mramh/Hw/XOMYnGPvGBd2KSmDimPq1UBky0+veUI5hqX4mDhL6QQF/TjspQXoLz8BgtNx95HdqWOY3RXpycoE05zR6FYyHpYtn0SsjF6Sr/0rzQuqCUA5VcE4QUQ0vKiRTYA0TWFvnNrtzj00Dr18Hnh8lBXuioJrDlADq2KmiSDbTbR3nqLrnsqcb0ihw69HNm6+qTfl4EK2a7qoKrssxFjvelzL78N01so+3gyScGhjxJOEWPggmAhLMEvXSv4kWTCKFDsVOdTHPLvyN/1pqk/srKMfZTe0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGH0AU9itcjDXtMpLvn4ygdcu2M3WlM2jhV+vj3MV+0=;
 b=gl0gdg8M/W6wHQTXr0yXE9TCbB+9InNBojnE4IWz50oBojM7V+S8vI7yYUUGFASDf28miFXJgoAndL5BtZRyy7mj7Y1olC1d6H70qGOPIKnM+aggojZlvyrsP+/SArqL0+FNb2/sW56tlRp/vrDRFGxt8jv2hLhSRJI/LLigrsvZEXEVxdl0mmMR8cMtcAm3uD6az+zv+SY0LF54LyPk3yX711/cBgHSEtZhq6k+k/ZhFYxHprEwOOvkVlPSXvLMvC/X9KwiPYT6o7mOy16+WDfb9J5Xwx42A/1UDMz3re0BQDFv+/EmHf9USDN8yUbABjXgHAQnY3EtDzmB49aiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amd.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGH0AU9itcjDXtMpLvn4ygdcu2M3WlM2jhV+vj3MV+0=;
 b=q9neB3HAMEhaB51rPF8zZV+u+lFzERP4F7Y5yTQ+LdcQspeJrqkqmimegO/pM4RSSpylDrCkna7VWBkTT6nhn/Vr4iADIHfT/IVn6+KxEjqaVsoRfS6GceuEBby5H2mAnAkkou29MjwpNhi2XFka6FMbLQt0L5EyOXyu6MLoc4XxTBfkpBgqMs81MMLgdEDd0MK57+o/kIvulBuSiUcNt9/rkwO+/Wb1p3P2PNHoAhog5j2eEcK0vgJeQgPjaXIocYYrQrS/lLCKY87ExpVFKUp8UnIiwy20jF2Z+qYDrKeZBrk1HfXkXOWFbmr+1tBCM7VY82/0IrDNU27pbEUJWQ==
Received: from AS4PR09CA0006.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::16)
 by AS8PR07MB7223.eurprd07.prod.outlook.com (2603:10a6:20b:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Tue, 3 Feb
 2026 16:11:29 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::75) by AS4PR09CA0006.outlook.office365.com
 (2603:10a6:20b:5e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 16:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 16:11:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8E68623738;
	Tue,  3 Feb 2026 18:11:27 +0200 (EET)
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
Subject: [PATCH v3 net-next 0/3] ECN offload handling for AccECN series
Date: Tue,  3 Feb 2026 17:11:23 +0100
Message-Id: <20260203161126.2436-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|AS8PR07MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: d3eaa5de-69c4-4c3f-0edf-08de633ee3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3pheWxHQUtkWlpNQzAxc0I2aktJZ0ttV0pESnhzRnNhZGtQclQ3RHFvdUdx?=
 =?utf-8?B?NDhVRDlBRktFTEFsYjR4NUFhWWgrM0NKYzhwQnlwRzU1QXpoK0tSdFNBZ0tE?=
 =?utf-8?B?ZnFtdnAvSE9uM3g2T0Vubm1tSXJWZ0E3dWZ2bUlLTm9hT1ptemxHc2ViSG5x?=
 =?utf-8?B?MW5oc1piOXhWVEttSFpUTXV4T3NsWXMxMFkzV1ZqWHRuRXlyNGpLWWYydjJr?=
 =?utf-8?B?OGtHNDRENWg1WFJtNTNFZ3ZZejd3Ty9ZVnY5b0dWVTVONHplY0pUY2hhWmQr?=
 =?utf-8?B?enQ1SEVUbXg4ZHJyMGFVS0FnWGV2blN6RVpiWmVhWGM5SW1lRXI4cXFoelVq?=
 =?utf-8?B?UmNvcDhvUnNJUEZ0bG9jbkFyZ0x6WDFSblVDTkpTcW5SUVU3K2JpWHZkeG1T?=
 =?utf-8?B?L2pYenVIaG5NcFlsTHFRTk1BQW13aE9ub3ZzeHdiOTZFbGsxdldCTkRIWW1G?=
 =?utf-8?B?WFFOWEQyQ1V5Q3VsUW9PRDB5Sk5sdFRwS0FPTUJOSFB1OGoybG01a0tvUW50?=
 =?utf-8?B?VVE3dzBHNXE0UXFFVitGeFUweS84bFF6YlNDYW9uRTFLbFcwamxrN1dUdU5J?=
 =?utf-8?B?WjVMdGlnNFZVUFRjaFptVUNFeFZVcmdVQ0NHc3dRcElhM1dwY0cra3E5QzNt?=
 =?utf-8?B?bEJxSDdxUk5Mc2wreXcvdHBmSlg4VUlCTklkbU1GUHp2ZmlVSjdHb1QrVjkz?=
 =?utf-8?B?VVl3aG1SeUU0Y29VYk5RS3pHRVZFN2ZpZHMvQjkxTk0xdnlkcjhRbmhXa0JR?=
 =?utf-8?B?Z0VpekVuelZNQTdFYmgrdWRic0RkVVAzZ3ZyNGw3ZVNaM0JnNXczZXlOWXNl?=
 =?utf-8?B?dVF6c0pGYVBoOEl6K0cvU3JTaTk4aTMweWtaeFhBa2EyWnBGcjY1bk8rQWNy?=
 =?utf-8?B?ODc1dXhDaDNsN0U0MHJ0MFpYOVdDQ0NVa1VRMVEremxENHlacGMrT3NJNEgw?=
 =?utf-8?B?eHlveHpBMzh1TTZ4UHZjbDJoZXMwS0IrZGJPb3RiS3FKN01tSTQvMEc2N296?=
 =?utf-8?B?L2VGU2Q1ZzNoblJoUm5xZzBQUlZweThTc1Rzdk53S3Y0ZEMrbVRybEtNcU4r?=
 =?utf-8?B?TE96alNXbElsSG1GNlhlekFQSktiQ29lcm9WejlRRE81cHp5c0ZTSFBkZ0s2?=
 =?utf-8?B?dUt2bGdER3FFdURYb2ljMWFlcEhWaU94R002ZHFaUXBUMFkwN251UldMUlFp?=
 =?utf-8?B?VkpwTmdUWWRNT1dPL3c1dml4eG5CNFpJS2tOVmU1c0pSaGxEalFMTmR5RzBq?=
 =?utf-8?B?SFA1ZzV0Ty9Tc2svNk9pbVRrNDNxNkxvcTdaSndFczFERVFQUlpzNGxjWDNB?=
 =?utf-8?B?b0JNMnZmU0VFR1c2STBXeEo0SDlIeklrcW5FZG5wcWh1TVpBK044WVB4eWwr?=
 =?utf-8?B?VTI3M1NxRWppcWJyU0phOUY3N0UrWlRtcFdYbXg4c08yWWxDNGpPdnBCRkRq?=
 =?utf-8?B?QUI5QW4yMVc5cGk4SENUNzI5NEhjMDZqeGdGZW9aT1lnSk5qeGpLVkx0TFYw?=
 =?utf-8?B?SnNIdFlCalNIRkEvcHBBQlFWQlJuclROQUl5YXJ6ckY0TkJsWnFtWGhkTThN?=
 =?utf-8?B?VTlWR3lwbi9ObXAwYTZQcE5YTC9uVmwrUzNpU2RuL2FMTFVFaVRLTmZZMVdI?=
 =?utf-8?B?RUJTN3RVNGdwNXplWkdZalRpMDJleU0vRmJNWU1HV2ZoMGJONmQ0dU51THNJ?=
 =?utf-8?B?L3VjS1B0VjFXd29zbGM3LzFwaW81THlZT0hUWDJnNXFBcCtGOWYzcE56M1B6?=
 =?utf-8?B?ZHhPamtPWS92VnB5YnR4QVlLVmxMY0NsMzlvMVNvdUU1K3Y4WUkvTGRtUXJk?=
 =?utf-8?B?Sy9NOWNFY1VzaGd0aUdZNEM5M05sMUZrTTNkOWdlUnc0OWVOeHgvQUQvNENX?=
 =?utf-8?B?QkF0MDNoSXdDWklMdWY5bTJqK0s3LzNSSzFxVWVzTEh6NHZkVVFpNVZRK0cw?=
 =?utf-8?B?RkdDKzJ3dC9YS0RFT2JBUHg5NHJPK2VjMklWUXVYSmxGTldyaHRPMXN0WDEv?=
 =?utf-8?B?aGhqQVN2ODdwaTFOYlZ0MzF2cEtkaGNUQUZVU1dtbFd3Skw5NUZ3QlJOWHpv?=
 =?utf-8?B?ajVQbWdDV3UrMUthS0NqV2lST3htYXZ6RWkyUWFxRVJIME9iOVQzU25QbUZr?=
 =?utf-8?B?c2pLYTVMWUxrS0JHaUlZelFXem9Xc0krRmd5WVNlSjBGeFluN1hJOElwd0R0?=
 =?utf-8?B?dHdPdW5VOE9hbmFDYklDNWVmUEZQaHVYdXVtd1oyZWtDcmZWRHZmcUJ0VEhP?=
 =?utf-8?Q?9HLatZNREWtCO6zR+CEgcO4MH7q5i89IH5Z0CpgcHM=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zyqfy0vtxQzFOvQv8Sgaq27v1GUlpU2u1Cdx6+jarUMKY2YllmE4xNcRswTwsJCqgtzmU1PPpAaWj1YyLHRQXdWDKiZE6kh33+Hry2a/BMI0g8uLbdd+g3nASiQAw5fCy40HeVUnHan8xgvYbhyYB+5YIVprMoqtCJHuwyBs5h+pah00CcgeBPoizIadcr9yUhapuJBIIbI8F1tiOofu4Sn1675f1Cm9LfSh/UQipJDpVZ81EcTXAUOmyQ2phvZrIqGK1RpnGUJ1TKyAlc8j5tJbtniPvJtL55tH4BGfye6B+UmTzKy29pcGpCkc76yNYvwP4w69AgwMa5fXw5Xn6uajp99B/vgAvnkVVF0YskDW3t43JHhZHSR6TVV0lO1m9wicX4JDsaQIjaUPdjIhUkz5ufaIFrIRIUp0UeVY3haZNAjTskAuMBkwGuHNxRrb
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:11:29.5318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3eaa5de-69c4-4c3f-0edf-08de633ee3e8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7223
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16466-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 07AE8DBB7A
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v3 ECN offload handling for AccECN patch series. It aims
to avoid potential CWR flag corruption due to RFC3168 ECN offload, because
this flag is part of ACE signal used for Accurate ECN protocol (RFC9768).

This corresponds to discussions in virtio mailing list:
https://lore.kernel.org/all/20250814120118.81787-1-chia-yu.chang@nokia-bell-labs.com/
And it was suggested to clarify documents of SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN first.

Best regards,
Chia-Yu

---
v3:
- Update commit messages for clarity (Michael S. Tsirkin <mst@redhat.com>)
- Update commit title for clarity (Michael S. Tsirkin <mst@redhat.com>)
- Update cover letter to include discussion in virtio mailing list (Michael S. Tsirkin <mst@redhat.com>)

v2:
- Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS

---
Chia-Yu Chang (3):
  net: update comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
  net: hns3/mls5e: fix CWR handling in drivers to preserve ACE signal
  virtio_net: add AccECN feature negotiation and correct ECN flag
    handling

 .../net/ethernet/hisilicon/hns3/hns3_enet.c    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c    |  4 ++--
 drivers/net/virtio_net.c                       | 14 +++++++++++---
 drivers/vdpa/pds/debugfs.c                     |  6 ++++++
 include/linux/skbuff.h                         | 15 ++++++++++++++-
 include/linux/virtio_net.h                     | 18 +++++++++++-------
 include/uapi/linux/virtio_net.h                |  5 +++++
 7 files changed, 50 insertions(+), 14 deletions(-)

-- 
2.34.1


