Return-Path: <linux-rdma+bounces-16297-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLOEHXmIfmlkaQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16297-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 23:55:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE38C4499
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 23:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24D34302F7C5
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 22:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683A38B985;
	Sat, 31 Jan 2026 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="La41gt3z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF49328B56;
	Sat, 31 Jan 2026 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769900124; cv=fail; b=A7xIiX0TmpJW8KmCszZKvNdR+byb8a8o++rwT6OH81k2wJn8JPzkSbjNUrnVHZmxzjyM2ezMl3GUyTWacP5D7DW01ParP2P+KAqrI/DyI7Syt6DFDCCTiQB4QQRvwhHu/Zo5+lL71ddKdiwOvXQABJLV9fdOVQn3fhHS8qqm9fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769900124; c=relaxed/simple;
	bh=ezCnE1xV/pDtEaFxQjpeLGUr/fJqi4NQIkYzXu+TD+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avJ+Y84ycGAYwyPXQIj9m9vgFZj6IktBSbtMcyoTneyNnA73pafrtgeFGWrjsB35dPkal7cy3JM05nFZqS4CoNOboYQa2es51I7BNkJdK4qrSt3I1WRYrrLfEMJRSXikIOuPSq9bp72XUCgKWK9QK/dOSDcBB4jd1WB4wZjKHxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=La41gt3z; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crUZJmko9zZp3Jbxx2P4JYu+ezijSvPRkbmHF/3WY0x4I87emaDr140dC1lc7qD2PKhFPsAQEoCQcLSkF3QKNvxW7Primnp8cd1i4nUEO50VIjNCPbKEpc81i4gJINLRW3yYpZt26FSEJLkQxh8pxA3bir6vUJ8OL2NpzucW/g2sOWZNYXbfiSGLgRlZPOqrWEtf4j1XhTeXHWewTEI7nbyXclL8rQB2z+gVYDMM2rK/m5DaQxr1d2f3spKu8kV3xmJh8D9QTT0i7fS0Iv03vm2b0inErqtU8zgO0L3Tu2eTGQfTffhU+uvEPO4Kyl1hPmJUkp9KoRgw6wNJvcoD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNmkDRYyZ6wm0GJb37/6NHrfr5yIsJM2LTcCAUh3xpM=;
 b=VqONe3I23xSzo23o1aKr5iS4hOq1lOn6vTSrZY4GTNE+Xsj6/4b+mZ0AuvT8Ny8cGySohHNGwYn69mdXDmgaKKnBWPHxM3rgMKDZKGPmeMiExXLmMOmWgNuo4Rj1OVtJcdceAVmYc/toOWyXyqCNbinLHr57l3kuA56Vz6RIkL47geMFA1Jv61si8/sV2APgNtUtB4qOKLm17FT0tozHjB8ZCa33brzc1r/kJF66mKxvXxtU3wD0SRKxYJ6zI4X65dOSwXKmkSxnIbyz+nwuiVcwrFcDzWgjjt9a6/z3RnWwyqDABIqFpguqGnO2qTNYWP91HEDLYWgGUphIeGGr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amd.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNmkDRYyZ6wm0GJb37/6NHrfr5yIsJM2LTcCAUh3xpM=;
 b=La41gt3zOAIdlNUGn9CHdmS9KacaayBKWNHGpZvi3NHMNpntme3Qyfr5vudYKFfwMOXI3kfyhkwkkkTN2vvXk+ibHguv/zUSYgII6ueJlexgprD6ybFUaBC64glix1TOAqI7z1bJo6LzxUNmmbLPEvJFLfvtOzZluXt2I+hxe6s555pkGBOw60RFCtqb/MyZxXxMbIIBDRT2gHZ5ODSBWmrSU7MitnsC4UdtA/jUccQGpEzLwNGetGc+OkXXMsHagA1XjggZGCbxzz6tZKN8vNMceU46M7dAK6uEp2MngyhGE0Eomrs1lT7RpSIBmkcp8b2MTXs0v7vXUlxgSRq/4w==
Received: from AS4P195CA0050.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::8)
 by AM7PR07MB6375.eurprd07.prod.outlook.com (2603:10a6:20b:138::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sat, 31 Jan
 2026 22:55:17 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::a7) by AS4P195CA0050.outlook.office365.com
 (2603:10a6:20b:65a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.14 via Frontend Transport; Sat,
 31 Jan 2026 22:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Sat, 31 Jan 2026 22:55:16 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id E37171C0031;
	Sun,  1 Feb 2026 00:55:14 +0200 (EET)
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
Subject: [PATCH v1 net-next 1/3] net: update commnets for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Date: Sat, 31 Jan 2026 23:55:08 +0100
Message-Id: <20260131225510.2946-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A61:EE_|AM7PR07MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e726e3-0ce8-4f30-ff08-08de611bcd56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3ErRW1sTnFka0ZyNDNhSjN6S1pUL1R2QVJTejIrZXpqMXc3dDZodHpHRzZr?=
 =?utf-8?B?QlNzRUpkM1hhZ3M4cVF4N2k4ajd1aFR1QVByOHA3UG05Tll6TW1HRU5WdWNI?=
 =?utf-8?B?N3ljd0NpbVF4dXp5bS81TVNqaFlyaGcxbEtKYk1pem92Q3V4Wnc4MlhMSW4z?=
 =?utf-8?B?QUEzRExPUXRhUGZzNnd4bVNGcGdPNlRnZUVwQzlwNmQzM1Z1VEVpTzBoSzBK?=
 =?utf-8?B?WU16eFUvZ3N5SkVWKytKaEh2enNlN1kvY0xYQUtZV2NaSk1TaGRtR05IUnR6?=
 =?utf-8?B?MnZRdWFrbnRENytqK1VHVVRRTHZuOTloNUtLRFdmNnQza0NRMWVxMi9SdHFu?=
 =?utf-8?B?M080VS9UQU4zSGFkTXI3cnRHRnN2WmE4a2w4N3ljQ0Y1enhQU3diMXd1UU5o?=
 =?utf-8?B?TEk0T2dNN2NrSGhCSGh4NU8rTThhdzRVMUhuZnZTQUFhQmV3TEswR3JUY3Br?=
 =?utf-8?B?ODkyc2tRTmR3bVJUSld4MUR0QUNpZUUvUFJPRVZUR2JiMnJtQ3k0dFNDSGdW?=
 =?utf-8?B?NG9Uemd0SGVlcDJWOGpBNnVGb3JyK1hzczNYb3ZnZjRvaFpxbUdlWU5Sd0E3?=
 =?utf-8?B?L3Jwd2EvbDY1Tnk3ZkVVbTE5QUFYRml4Wm14UTNYNlNPN0ZlVmdSemZNK2ZJ?=
 =?utf-8?B?d0xEVG13VU1NOFVqSlpWMVRDMWlkakQvTngyYzdnOXVFTXZuang5LzJNY1Vi?=
 =?utf-8?B?MVE1MzBYcG4yeVJiUHpSbUcwdHFxQ2NwY0hrWi8wQUduMmM5R2hxRmJLZE5Z?=
 =?utf-8?B?L29JeUk3S090NEM1Q0x6VVJvNnArU0hocWJmMkx2T1JncGhBQWxnd2E2RDFK?=
 =?utf-8?B?K2lILzVSOEFud0xuWkh5WG5PZVNFZ0VjTk9SK1dQWlIvYlpUY0Y5YXY2NDZV?=
 =?utf-8?B?NDJGbUJEZEZDdmpUWk9MT3lzTk11MGZFOXp4c2pPd1RPNkFWRlRQOGl1eEgz?=
 =?utf-8?B?MnFlWTQ4eUczb0tDczRpUGZtUHhxc05MZ3dPUWNGeXFKeEh3ZW5FLzJRVXJQ?=
 =?utf-8?B?YThQdDJpbWZNL3NwcjRoTElSdFNpZndFNFVKQkVUNHFqNFJtZ2xnQVZEd3BD?=
 =?utf-8?B?eXFoMEh4RGJQeUlFcGU4eGtnL2g5NU00UURwSGI4cFJEZ2JXb2VzbzlyUWYv?=
 =?utf-8?B?bEUzdnZEUDJTejkyVTByamFjWU5Ldmx4OVg2dFRLMEptVmMvcDF0YVBFM0NV?=
 =?utf-8?B?S3FqSllZV29kUXhxMXk4YkRqY09qYjRBbnArZVdJZzVRRnd6OVFYOW1TRDE2?=
 =?utf-8?B?TWhWckJja0hDWG44aWJ2b29HbGM2SmZVeG5mSHBEZEwyR05uZjAwZkpKbkRJ?=
 =?utf-8?B?YlFUeEhVSHh1Ty83bmFKYXhNcXpFR21pMEhxb1R0U0N6UzVVM0hBZW1lREtP?=
 =?utf-8?B?MGdyYXNuSzUyQlRLZ1A1QThCc2FzUUtKYkVhKzM1TmY2M1pPV0Z4bDVzSFZm?=
 =?utf-8?B?UStKZEI1bjNIczFnNk4vdE1TTDUveXo1czdzS08xd3BaclBaMG51ZytrRzVt?=
 =?utf-8?B?YjVSWC9SWmZKUWxlT0hQWWdkRzM3TDFqSzNlQUJIV0pyMXhGZU5LUWRoT1Nt?=
 =?utf-8?B?NGJhUDZ6UFRSM1JhU0pjTnluK3g4c210aDlTWm9reWVjYmliYjNCckNqalRN?=
 =?utf-8?B?SDh2ZnVIUGM5YzM0L0NiQXBvQzVZS3JPTFRZd25PWGN6L2NYNFFNcVhSLzQw?=
 =?utf-8?B?MEtUUVZDVDhGNlVoeGp5SlRJZi9KeHVhTENuRml5VHNMelpnMG41QzBsTlR1?=
 =?utf-8?B?STQ1L3AweDhYbExWVXFDeHEzaUNqdjRIdmgvOFJ0N1l2Wm04QmFTaHpCQzFr?=
 =?utf-8?B?aGNIdEVuWWNtQ3hzU0tvWkNLaCt4MnRyWU05OEdOYUE3YzA1UjhkNTl5Q1ZD?=
 =?utf-8?B?RWcwUkZTd0J0WkNvbktRYlhQaWo5YVVJUDRWOSt5N2NhdUdFRDVQaDZ6TGpl?=
 =?utf-8?B?bGZncWJ5Zm8rd2ZPZEdncHBwcDJGb2NPNVFjakhoQWJKdllHWmRBVWxNVU9v?=
 =?utf-8?B?Y2h6TWw5cDBvYmJHbFQwTkI4UFhmTjlOSTI1ODFUMWxFdHZzM3R2QWp6MVFT?=
 =?utf-8?B?bFhkc29yVmRUVUhxV1hIays4c0xPZnQ3YS90R0QvWm42MG9CWFlwVTdpQ2NF?=
 =?utf-8?B?UnBBUTQ1RXJGZDcxdjNzTFVzbTkwOEhMQjhkMi8xSmpVOWxRN1o4WFlXV0Jp?=
 =?utf-8?B?RDlRZVI1M0pENjVndWVmTDluWllJS0lmd05PQWJKdmZEcHBJQ1hwcnFLbjBj?=
 =?utf-8?Q?ANOTF3QVhSs4uz+zXZocw6dPgO0fIgLku8x2PFL+14=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aLclAV69bEWWs9AHKiy8+Re3MEHJwDSvvuMTmihtfNmBr1IJwNAg/rbHgfcJ3HOa2yi8rWDnpz+/QxDWdhNSizlbxQVJFZ/pHSWNLfDv49YXuq2jzpgdoOweKhJFLa6sJLmUwTLLl1OP5EzdxCTX7UyNYP2BzOcB2OKuCebGeMyNkVj0AZ+WET09d1s7cW+PX6Us6vG+b8xJBiyIs6GAq7YQp72vjGMqSIqNjCM4pv5zyJPDLMHHAR9XiqChIhEmNmeWaQT82c0jKBX/4GoPDlad2qUXfEkZ7Dv8KP/PnPiDSDMCpiVKcz29llvHp75Do7F+9q9btDABhLiTpV1sPG//nXjO8Ep/fXgrV9ybZ/99995ffmopwEiZnIrf7rvHyPo7W+XEO2VRRViumO5s3nXZY5/JcXHbM2Y15TNeVLqNdnnXhEeXjmV4uLzISuPH
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:55:16.9537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e726e3-0ce8-4f30-ff08-08de611bcd56
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6375
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
	TAGGED_FROM(0.00)[bounces-16297-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
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
X-Rspamd-Queue-Id: 2BE38C4499
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

No functional changes.

Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/skbuff.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e6bfe5d0c525..30a8dc4233ba 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -671,7 +671,13 @@ enum {
 	/* This indicates the skb is from an untrusted source. */
 	SKB_GSO_DODGY = 1 << 1,
 
-	/* This indicates the tcp segment has CWR set. */
+	/* For Tx, this indicates the first TCP segment has CWR set, and any
+	 * subsequent segment in the same skb has CWR cleared. However, because
+	 * the connection to which the segment belongs is not tracked to use
+	 * RFC3168 or AccECN (RFC9768), and using RFC3168 ECN offload may clear
+	 * ACE signal (CWR is one of it). Therefore, this cannot be used on Rx.
+	 * Instead, SKB_GSO_TCP_ACCECN shall be used to avoid CWR corruption.
+	 */
 	SKB_GSO_TCP_ECN = 1 << 2,
 
 	__SKB_GSO_TCP_FIXEDID = 1 << 3,
@@ -706,6 +712,14 @@ enum {
 
 	SKB_GSO_FRAGLIST = 1 << 18,
 
+	/* For TX, this indicates the TCP segment uses the CWR flag as part of
+	 * ACE signal, and the CWR flag is not modified in the skb. For RX, any
+	 * CWR flagged segment must use SKB_GSO_TCP_ACCECN to ensure CWR flag
+	 * is not cleared by any RFC3168 ECN offload, and thus keeping ACE
+	 * signal of AccECN segments. This is particularly used for Rx of
+	 * virtio_net driver in order to tell latter GSO Tx in a forwarding
+	 * scenario that it is NOT ok to clean CWR flag from the 2nd segment.
+	 */
 	SKB_GSO_TCP_ACCECN = 1 << 19,
 
 	/* These indirectly map onto the same netdev feature.
-- 
2.34.1


