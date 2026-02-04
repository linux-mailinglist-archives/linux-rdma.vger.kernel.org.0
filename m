Return-Path: <linux-rdma+bounces-16506-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J9MOecMg2k+hAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16506-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:09:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A777E399E
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B77630CCA29
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669013A1A55;
	Wed,  4 Feb 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="a06knkcQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F913A1A4F;
	Wed,  4 Feb 2026 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195841; cv=fail; b=cRcwbhfSnH+aGuU00M4/8fUN+fwl+T8adc+2Xnx4KfKzy9mlLyPAwOtaguQotQRULutPaIyRcMrKfEf9bBOsX5CdJeIxROkM+vUTOTxotjHawOS7+nZYQLlLp/W70itWwfbrIaMsTy7r5B3iVcTRVRX5bVUfwtA7vSGXXOwbnpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195841; c=relaxed/simple;
	bh=S1i4GzwJ1Pb1bjNQybhFMKq29rRCoQTDfj4cmsGieAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rtTt50zhnDcBepM7RBmKYPL7t8nsGI4q/qUam7jiCFmnVsWlEj7AxsV2X99YerqP7kJKV/0PCnxhsItKyLSb+Q/2+OYIN7skxoc+F3XfVoTeXZnHed0wUZ8sRfaJcn8mVQ+ERliKu8F6XEYqHl18k18Cj2OFzEtp+cFKD71xbkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=a06knkcQ; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URuFt9xH/ErXXaSv79if+UW91v8s+9E8/6mZW4jeww7qXU6D1w3s8bVw/4wlpg6qUs6VUmCFMakamQF81xCbINE+r2WgWELl1btFmFvQ8zueC24iIAc2K59qdGQaGShE3GPXIiByPzZT2KLWcTGKIaIlrt8bY/p+1dxS2lGRoisQs6Bx+3eoSqh9jDZsnXgvAT1YB9R7WwjP/cCLjnY4ktxXq4xwm1M0eFFv0Z0glg6ni4sY1/eiVwelARmEoYtoO6esZKDRBJ2Uz96PYq8llttkXTDV3Lw/R0TVMgixG3PjRfDwMqUe30HIHHyjDO74qeOpncwZYZu+TT9JgXZ4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJhpzwyUZ9bzWXxr50OFSqlFjarn5zAynX6TCtUVX3M=;
 b=wu1qEu2xq3DKb8+vf6AJFQM1wGW3+5oJWJ7w5zdBVlH+t477ndY8CkTiKn1vHkDStQjPqYDLyxgE+MMpKkYS/r4gHpfo12fdeR1NVK7+dsRnZC9+xRz/UYO1c3dt4cIde8dHwPEGcuHAVfhSPBdFmB66SkL/zWV85WgnzJRfzA+ZG1P5+TaYFVpRN7YvPrnzMO3EXGlqsvSdsgvqNvDtFVNU9IGQL5zHg6cx7Zyugv7ltY8BMx6A34cYDtienNpnZdqAQQO27hqY03xtFwhvlNgdlC7dkn91k71Xucvf4KCbnOHtzOLMg5GAOP4EWsJHUnDNvEuf4av0DWDdUiaVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJhpzwyUZ9bzWXxr50OFSqlFjarn5zAynX6TCtUVX3M=;
 b=a06knkcQfpqUkM8qnjX3K+qGSu9rYGKk81r2Jj2tiyBy6ka6n55IOSRwCnloQ73adP7mZwzvssVthfthie2kuVngG/wFp8YZNY838Qz4sMrDM4Ds62QrzEDvHsjxRy3LUxa+8GLRRLDFvX3ezkGcBzz8mcuI1bgNT/pU4dtapOKOWhS1hXRy8om+BuRzsVh9KeUDPqsDNb3fxoxMIRWwoL8rwdE5GsDA8X4hKmjHWCLi03AZSPaDXgII4RBPWDEcBsM+q5jLKkwNHiuOwLErqKloScm2sUrehCfggUN3ZCghBCqvV1HGIydaxj3TfCwmBIPyvMuElqdRCwWEbSCC5g==
Received: from DU6P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::17)
 by AM0PR07MB11607.eurprd07.prod.outlook.com (2603:10a6:20b:6f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 09:03:55 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::84) by DU6P191CA0023.outlook.office365.com
 (2603:10a6:10:540::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 09:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 4 Feb 2026 09:03:55 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id B9CC9201DC;
	Wed,  4 Feb 2026 11:03:53 +0200 (EET)
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
Subject: [PATCH v1 net 0/2] ECN offload handling for AccECN series
Date: Wed,  4 Feb 2026 10:03:08 +0100
Message-Id: <20260204090310.7528-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|AM0PR07MB11607:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7863bf-0b08-4524-d331-08de63cc532c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0o2endFa28vZ0hBOWc2Q1JMc2xmWkJBa3RHN3JVblJXWWhVclhnZmNJL1Qz?=
 =?utf-8?B?L25GUHRxbVRkUlo3b0E4T2pFRFdlQjBmdUZCTms4MUZQazBoQVpyWmpzMm9l?=
 =?utf-8?B?OFU0V3YrTGZDcFUxNXpuZm9pZlhmcXlKSDZwS2RhcHNURkRSSndXL3k4Qk1O?=
 =?utf-8?B?cFY4VlRoaVduR3ZCOVpHQklzUC91bUlWMVpTSXBreGd5cDhiWTRyR2s5Z3ow?=
 =?utf-8?B?M01YSGIvbk1MbTZrWFpLdFZLYTJaNUFjbUZjVFFEeEJiT1BXak1wUVlpMUpq?=
 =?utf-8?B?Zmt5ZnY4N3FqTGFBc3NGeGQ1cGtMYkNFaTZSNkZIc1hXaytTV2F0MUY4aTQ2?=
 =?utf-8?B?bnViazNrRlN2WExGQjZudkhUcTVmbDVnUDcyQkZKQUVLcTFrMVJCbkNUd1dI?=
 =?utf-8?B?TDBvaTQ5ZGV2VWVQcW9vL1RtbHBBbkNPcHl6MHBhSitEbEJXcDdCOHJkVzVZ?=
 =?utf-8?B?Y2xaM2EwNnpnNDdVYlJwS1lvblRWZ25LYTE5UGo2R2c5a0V3aHQzdnI5TFAz?=
 =?utf-8?B?WHc4ei91d2RUYldVM2xIY2EyNWgwZWMxNy9XS0VWTU0yVklsUndDcEFVMmVj?=
 =?utf-8?B?Q09MRFIzS0ZWM2d3Mi9QU0xWSFJnanNaM0tCSU9FQkFnakFlaDFpbFRiejZm?=
 =?utf-8?B?YnJ1SUxaKzhGbEo3U1NDT0FraFc2bU5odFRBb1BwL3IxSFFQQ2dISE9tUFNZ?=
 =?utf-8?B?NGptVW0wbERrRXQzeTZvdmIyZWpXQjZnTTBoOFBYTURjNHFNcHpDeUxqaktn?=
 =?utf-8?B?Zk02UVpJWUlPNllleGxEY29ETUc0djBHSDcxbyszc3BrYlJQekRsWnFhT2Rs?=
 =?utf-8?B?amlyR1N4bjFQN2hDendxVVZIOEcxY21yeFBEa01SZHh6aWlkQ2lVeEdiaFlD?=
 =?utf-8?B?aHR0bXlZRVdVSE91bHBzSG1qWFZYdHU4OGZsMk1Ja0d1NlNWK1AralB3SGIy?=
 =?utf-8?B?eWFCRStYU1FwTFR1dFp4ckt6aDZsR3MzbzY4dGJrMFVabEFBdlVEQXZlQ25s?=
 =?utf-8?B?NldiNjRyQ2FwL3RYOGpOWDV2RXdOWExWdmcwWko3QzZ5cXZWQ2QrMUxBQkJm?=
 =?utf-8?B?QzU4RkNjcHhiZFlJR0JjcURuUEJrK0RBWDhzamR3Sy83VjlFOEl5VlFJY2pi?=
 =?utf-8?B?c1ZreDRjeWljaTByYzREcUd1eFk4bGI1bHFOdFhERzdBU3d0SUNwWDhZdWxy?=
 =?utf-8?B?L24xTmc3NXcxY1NmQlQ4TmdOSzRXRllDclY3cnBrWHoyUzZjTFBhMmp3VUIw?=
 =?utf-8?B?ZVlWWkFDRkV2OWgrd2xGUlpsM1NIbTg0aXlWK3k3cWtzWldvUmV2eDlDWEV5?=
 =?utf-8?B?YW9zZCtmbXZaYkxPU2VnK082QWhaQzYvakVyZURyVFpEdExkTjRuRW9qdlk2?=
 =?utf-8?B?WkN2Q2ZFUjBscHBWQjFLczV5aW1tOERBWUlKK2t5ZjloVWU0Q2dYRk93aG5p?=
 =?utf-8?B?dmNtbjJNcW1DUlVtMTRaUnAxNytaa3lEd3pmaGlYc1A1YWFoUlBvMWR5YlU4?=
 =?utf-8?B?TnZudnJ4SW1tQ2hBSmc1KzgwNnh4dG5vYVpjV2RUalVGNmxocldTbFpUVG5R?=
 =?utf-8?B?bTllRkxMUmtBU2xUMWRnbXQ2QmlJWm5yUlUySVYzTWhHeU9YM2doVSt0SDlY?=
 =?utf-8?B?SXFGWi9KZ3huNGFZOGpkWTR0MElmQW9UelJ1Z1FEbHJrRjhEN3ZZeFc0aFc0?=
 =?utf-8?B?c2ZWb0dEcVlsSGxxaHdEU0pNWHoyT3ppcTNrVEJkZ3NNOU1Fa3pBaEQ2NTkx?=
 =?utf-8?B?VFpBbkVoMkgxVzJIQTI5dzVhVXUzYzRkMm8vazY1dklKVE82WWpNTzE4U2l5?=
 =?utf-8?B?TVZReStmWCthcTdXWmpIRlEwRnc1dEFUb0ZhUFRaU0ltR1VwSjlkcm8xNmFE?=
 =?utf-8?B?bElEKzNkRTMrWkcxd283dGF2djZCZ0pIOXljejFFbGt6VEdocnE4VVFrcXFn?=
 =?utf-8?B?UFVXMWJIaHBlVDNsYk1xVnY4cHJGUktWbEo2bGo4VWRDUzVnOVFmZGNmRnVK?=
 =?utf-8?B?WlZMZjN3ZkloQjBwdzd5dTRSUXBMV3N3QTdWOEduaEkvR3llYVdDakpyM3p5?=
 =?utf-8?B?cU1XaHBDU2RHbE9aaU91Z3JBR2hWSFRTWnZBc0gwQ09GT291QjVtaDJZcnR2?=
 =?utf-8?B?dFNIUldSRE5hYWFRSHdLK3JnUDV5WW1IS3lFT1hXR0I1N2dEZXJndjIreWJB?=
 =?utf-8?B?NXRvaFI3TU0zTmI4SmZTdm5qZEkydXZvdjMwZ1VqOUs1dmllR2QxTGkzU0w1?=
 =?utf-8?Q?vYe7ihruwNjVa/9Wx42CmaoG2Tva+BGGho2H5kC4K0=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6+CKwA9QW2iyKAt4NT0XwpbcLXxAhR8nCnj/P+lhNjHwQzwJ8FKE/BY6JloC+YM+nzAiUeBGdHBi5xWvJKlBPibRhiou8EgzVUis1XYYJVa2jt+ZTAUwM1X3Wd3Uckn4EISF8THaW8/4PODjGSV6Jrg6Mkp5X6KIuoBqp4fX2l/Yp3PZh5Ev8a3Ak2bc4vhygSi9rU7L3pSqLzcjAv4x8bfGQtgniKHeMy5pkjLB3sOBa1TbHaEGOL/RyzEDBM4mN5XcAHmwuNgzEoLbSH7Sh6eXiUSM1DA3UF5VpT3H5iFKBVlMT7vIwd1LT1fSudvaSCIJ6+E+brbutMH+VRZf7rwNH0UCUOUm1TLfQjq1JiwAIJXjqWL+JBK0Nzavt726Rezq4FJM7bfm+SXX5SGWwUlRNWJavfB9Jk44oibdshARahwHHscGF4VY81czX3HE
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 09:03:55.2051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7863bf-0b08-4524-d331-08de63cc532c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB11607
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16506-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,redhat.com,huawei.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7A777E399E
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v1 ECN offload handling for AccECN patch series for net.
It aims to avoid potential CWR flag corruption due to RFC3168 ECN offload,
because this flag is part of ACE signal used for Accurate ECN (RFC9768).

This corresponds to discussions in virtio mailing list:
https://lore.kernel.org/all/20250814120118.81787-1-chia-yu.chang@nokia-bell-labs.com/
And it was suggested to clarify SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN.

A prior submission is made to net-next:
https://lore.kernel.org/all/SJ0PR12MB68066115C5329872316E6B37DC98A@SJ0PR12MB6806.namprd12.prod.outlook.com/
And it was suggetsed to submit the first two patches to net.

Best regards,
Chia-Yu

---
Chia-Yu Chang (2):
  net: update comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
  net: hns3/mls5e: fix CWR handling in drivers to preserve ACE signal

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |  4 ++--
 include/linux/skbuff.h                          | 15 ++++++++++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.34.1


