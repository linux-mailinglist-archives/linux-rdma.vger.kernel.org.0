Return-Path: <linux-rdma+bounces-16296-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AZwAWSIfmlkaQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16296-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 23:55:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA3EC445C
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 23:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C870301E987
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 22:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9FE389E1A;
	Sat, 31 Jan 2026 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="OWeQkTKL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E46328B56;
	Sat, 31 Jan 2026 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769900119; cv=fail; b=TaZNqtd2ZExydZqk/Lp2JCQGR5Dn54DyTGBAR5dQE0KrzNsadPj2hwE1WGVSKjSvaCoJLOtHcISCLmhcSqYK6zotFAAvqD5q/q4RAQjTFFGjDz8oVcuXddDzleIlqHmiy0hShAaEY25avbNYwlDfYZ7s94sI9jEYxuaJw782GsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769900119; c=relaxed/simple;
	bh=nmUJZ+x7JfX8haGbHzXnpFdBNcLUQ0uw48kGgR576kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RGjE27gTH3lW7kleWWw6QfsXXc2O9vgSsXjPaN+dKlr5UCSSfLpJFGFGQqL1VYBaYtuXjgKnhcjEJ9r9n0j8tWRcAmNGpHA+uMPbLy0BdKNXBSUgZwkl7DtKGXmjILzYoozg784sRK7nV7XlGbhfYblzQUMFzWoi+KK8+qaDSws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=OWeQkTKL; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVgfWTZctw+kpmUtj6sZMm4gdDu3o/snOheuLZVyqD+ANcrY3aRORbvbCdQGTMrrDSD8G5cFxzux7//jQlukejVCslaJJXpNgeAH4UkU9fOSARu6V/lM1rbsoEm2eavpA6QSrmlJ6aVzCnpxXZL4vxNpUjZr+K40k9asni21Nve+Y5YWMIsYsPZsAhCtNkdRkqoXa1EfyzajAJvY38JaHbt2uonpIsWNaYEMHj9yf7AohPPXKMyqLueDvi6d3PbNrVuwvFEEAa1/5h8D8OVwjhUXVtaEfaAoyRaZ4O9vgu8GBuKzbPCfXK+BkUcnimVucK6nzCmQ/PhAsf3VeW1XjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOqq4zHj54pE0k4jawDxclevSvVtUXkXzC+Lzm93I2U=;
 b=jVyRIhyIOJMlOkw7aAKDhR3wdc6LunmlhHpfSu7sQECPTKQNwnFxluOvWv4IYTC6eurOPL/zQ0duWJXIuVFZqg4YhwfCfUn4Kcky/yF6cfta4J7Oeoy1aGtmBfz6nCWS+Cm2gO8XotpO9JfsCfGWE1ohXDd5bKQi5fkXZ7IsZcfK092IQmHbBNIJBR87peLus6CrNRcsWsuHzab3M2+Dd4kRftkbqFP4g3yZDooX1NmexJCD+xforjSdVvvdSKp0kfRvv0Vi/SMw5cQqCQqCClZXKG0eQm+Pl5yBlhy5kfBlt35F/vAFo7Br8I8Rsjk6qo5F+lY3IrQKBdJ52qYMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amd.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOqq4zHj54pE0k4jawDxclevSvVtUXkXzC+Lzm93I2U=;
 b=OWeQkTKLe8khDDneAjM0EfeFD/O0CglSLJ6dPTndpdTLA5PKZ4VdFv/BaNYTEtvEtpj757nBTdRTf8bMD8Cl8GJFxznFNKLis/7IRHjwj8Ep0jnuN3J9VeErvuwM587F4xAqWsWRIt+G4hFUavFEvNc+3qtfaosKMaxl5U8sn6nd7BnMEKbEILZYE6slRpae1qc8Ny/aT16Js62T4pQjRtVyY4q2Gfz42ChMi4IsEa1zoGom6OcFqNDmXUV4ccrzMZ7pg3MNguBf0zogpptvZpyLFwqPiR9JZ2/xHugx2xAEcOL9CV63egzQTr7oaltE4Z70Z8o+YanwVVat/1AnfQ==
Received: from CWLP123CA0208.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19d::13)
 by PA1PR07MB11366.eurprd07.prod.outlook.com (2603:10a6:102:558::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Sat, 31 Jan
 2026 22:55:14 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:400:19d:cafe::df) by CWLP123CA0208.outlook.office365.com
 (2603:10a6:400:19d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sat,
 31 Jan 2026 22:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:55:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 01B3D1C0031;
	Sun,  1 Feb 2026 00:55:11 +0200 (EET)
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
Subject: [PATCH v1 net-next 0/3] ECN offload handling for AccECN series
Date: Sat, 31 Jan 2026 23:55:07 +0100
Message-Id: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A62:EE_|PA1PR07MB11366:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a1a2f9-c0b0-4299-67df-08de611bcb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFpTN1dYWnZMQi9SNDEwbmsweGVjK0dnK0Z3T044cVl6czNzQzdrNlFaNkJn?=
 =?utf-8?B?N3AxUmxKWU4zaU5tK2lVTE9xRUJBdGxGY01lZXZFRlhZa0hHcDNlUFoza0dD?=
 =?utf-8?B?OVJiQVEzU21NNXdKd1ZqUTNmWDdBYnRPS0JRSzFvdjBjRXVDY0dvaHQ5elF1?=
 =?utf-8?B?ZDQwdmpOeVFOMFNMYTZOOFQyaGxRcURxc3dKZjd0UjBUK3NNUlZQbmxqUXdY?=
 =?utf-8?B?R2pwZjJ1UUNIeFVzelg1ajdUc2RUeDBmVXN6V2JYMGREUjJCcCs3b3lhdUEv?=
 =?utf-8?B?aXQzdVc3RTVWemJkMEF5WUFQM1VFMGZvUUlWam5WdUo0OGRuVjJxNlZDUDBT?=
 =?utf-8?B?K2JaRG5SUjdsbGZxQjJSZ2dlYnhaU1Ztb1VYaWQzazNkUzR2aGxUUEF6RTBm?=
 =?utf-8?B?bkJGa29DUVFXbnJscktoMEtCa21GRW5DSUdBWmFmOEhENFphTE0yQk02dDZj?=
 =?utf-8?B?c04zTUNwalNtS3ZybFg0aE5NZjMrL2tMY1lWQTNibDJiRktEbFJUQWNwc0NG?=
 =?utf-8?B?TGQ0WjJuTkVXSkhlakxGODZsSkRrRURhSmNxZGx6VWtvUld4OWVOYWR2SnV2?=
 =?utf-8?B?Y0VVTzNuWmEyclcvcnljanhKOGt3c09YZ2N3T1djSVNzcnJqZWw4VDRxWWVp?=
 =?utf-8?B?eS8vYkcvNWlORDEzalZsblNqWDc1TkhXVlBxKzRMbENHeFIzRFhObW1tRzRx?=
 =?utf-8?B?cTNvV1JJODl5bU44WFV4c3VUZ3RDWFZQem9iRGMrTENUaUd2OVkwS2k2VWpv?=
 =?utf-8?B?LzV5QUVNVFZyK09EY1NMdTViUXN2TEdoQ3B6TlBVNWM1eGpQc3ZOZDEvajBp?=
 =?utf-8?B?SXZPT2U3VnQyemNESjRTRnRyZzViQU0vdUwrQUVIeG5jQnpaV3FVekdpRXg2?=
 =?utf-8?B?bkN5bzdOb3JuZmpOdTd0VFgrQzNZSDgxNHJUa1RlTjFCYjIrRlNLWVJ0NFNu?=
 =?utf-8?B?dWhNdnpIcnArZW1Sc2hPU2lNSVpJaFhGT2tNU1Q0YXU3UTUrNU1jUVEzVlVL?=
 =?utf-8?B?OGp1V0JJMm1XN0VORWFadFlzVkNpc1VLTWVkKzhDbCtyLy9LK3VTQVNGV24r?=
 =?utf-8?B?dm05Szh6TWJwZnNLK1I5eUZhanlxc3FhbnlnelRSQWZXS25NSmpqRmJXR2du?=
 =?utf-8?B?STdRV09lNGVnOGp0ckJrVk5BOWNsaFhKN0llUmk4azRJeGcrbnJGRkpKekVl?=
 =?utf-8?B?a01ZZ0FjclV3M1hNMWJEV3Q4WkpJZGJVek5aMVV1WExFOTIxSHpXV2JjTWtj?=
 =?utf-8?B?Vk9RSFV1eGhOdytNbDExU05zQXJjTlJPQWhRU20xYjRpRXJZMUpCTjFPTHlF?=
 =?utf-8?B?UE1PNHVqWHlhS0RIUWhHd0xRNllnT0RWQjlQVkRUZHdjLy9VM1JsMExVQVNw?=
 =?utf-8?B?anR4TnFOblhMWGRaLzhUM24xNE1ZS05VMHpxaS8rYksvQ2x6eWpHTjh2M1hp?=
 =?utf-8?B?N3Ryb0NxYnZ4SUcwZExEbkZFeGxzUC9JbzhhK2E1OExsN0IrZlJCN2Q0QnF3?=
 =?utf-8?B?YUdqTm1XakRwb1Z6ODVJblRaNGtjTkJBbndhdzZFRXovVGhlSEt2UFEvUDZB?=
 =?utf-8?B?YjZ3ZFJzOE12WFdSTG1xdnZ6eW43Yk1hZzVGeUhXa1p5eDlxa2Nld01FYmc5?=
 =?utf-8?B?ZVc1a3N3dStaRmhGNlV2VDZXZXFkMEhSNDFGVG05S0ZIWW0yU3orWTVaYWtr?=
 =?utf-8?B?MzVwNThnRUhoSzVtNGpyRUs5WUlpWWVrVDhhT3g1by83cHp5R3JTdW02bklV?=
 =?utf-8?B?ZWVWWmVDUmR3NEdjVXU1OEg3bW02UUF1UEV2V3I4Y29taVZWVW1hSFY1c053?=
 =?utf-8?B?L05JSENMQWlYZmJlcHFPVFpwMXBhT3luK2gzazNiNHg1NmZ0ejc0UFptdmJ0?=
 =?utf-8?B?NHh4N2M1dkIxU05FZmE4L2dob2pMU3dBSmVFTXVaM3RrYzlkaFBERTk0UG42?=
 =?utf-8?B?eVpmcUFhUlN6NGljaFVxUkdJaEVFYUg5VjBBM2s5c1V5c09ISFdyOGRuQ1dB?=
 =?utf-8?B?M3p4K2pKWFZJcTUyZURKVnM0amRIMGdob25PSmh3OVEwYjJnUTFpZDlwc2Vl?=
 =?utf-8?B?WC9qd0U3aHluSUd6cGZGeGxpZWVtMlJZK1RVdXNFVXFveWFnOEFNVFd5akZ5?=
 =?utf-8?B?Z1FmZjI1WDRFU3ZUdm5hNThHcGZCOFluR1RyeTVpZTV2aVNyc1ErcGpzejNM?=
 =?utf-8?B?ejVHTTdMUXZlZWNMUWZhQlM3Nk1SSDZBcmIzc2N6aHVGSmcxNHRRck95WlNO?=
 =?utf-8?Q?SGyLAbAZA4mwntStwrsNyn4C3lOQw4cYGpW56MWSSg=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/X/3CrqLIVFWcgRwI2SdfgwjuQQ5ZoDuz69CfcmZpgA7IfOMD773kvI6SQ5Nd2vPMmYulz/Gv1b9jXGPKh+x3WN9yd+XNRLKfS9PybzG5DO7dD+IFds4wXPt9LlJ9+VYzThUUAx9J4qou1gM2xGQhXkldVuJz004s6/6/Hkp8D/Y25EeS7tuRpEl4JaQ3nsXg/KbMwl6wCghUWpFub8NFsoFi+yft+q7IRTGY2tLQZdS2ZFlZGf7YVjvC5mLajSGj7moq4E6Wd96In73ofOHcZC/9y1BOWu/Wblf1JNlZgFXnnigQLiC6dBcazWLzkr2RLaRMLwlE7Lbw9/oj6p5gzQSVFH3a56eNUaZuxDnjDgo/R0mBG57DFz/dycbpauzbIEVSs0l8szYes5zJ5R6aHrTcIyGfJh/6QoX0hSxwz29/gm+BlYXnc2xRCtvs7Xj
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:55:14.0620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a1a2f9-c0b0-4299-67df-08de611bcb9d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB11366
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
	TAGGED_FROM(0.00)[bounces-16296-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ACA3EC445C
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v2 ECN offload handling for AccECN patch series. It aims
to avoid potential CWR flag corruption due to RFC3168 ECN offload, because
this flag is part of ACE signal used for Accurate ECN protocol (RFC9768).

Best regards,
Chia-Yu

---
v2:
- Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS

---
Chia-Yu Chang (3):
  net: update commnets for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
  net: hns3/mlx5e: avoid corrupting CWR flag when receiving GRO packet
  virtio_net: Accurate ECN flag in virtio_net_hdr

 .../net/ethernet/hisilicon/hns3/hns3_enet.c    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c    |  4 ++--
 drivers/net/virtio_net.c                       | 14 +++++++++++---
 drivers/vdpa/pds/debugfs.c                     |  6 ++++++
 include/linux/skbuff.h                         | 16 +++++++++++++++-
 include/linux/virtio_net.h                     | 18 +++++++++++-------
 include/uapi/linux/virtio_net.h                |  5 +++++
 7 files changed, 51 insertions(+), 14 deletions(-)

-- 
2.34.1


