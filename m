Return-Path: <linux-rdma+bounces-16581-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKH6DJ6mhGmI3wMAu9opvQ
	(envelope-from <linux-rdma+bounces-16581-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:18:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 809B6F3DCA
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3F323010170
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666E3ECBD4;
	Thu,  5 Feb 2026 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="HI71dJGB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012035.outbound.protection.outlook.com [52.101.66.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6A42AA9;
	Thu,  5 Feb 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301043; cv=fail; b=e7UEy2tgxC9b3BXlYYYBBkd+20CUB+cY3L6iGRlamgnMq4ZeBIZKvB8Biv/bLv5H16qnH9UQ9ghenWQqG5XAklxRpUUH6s+nKcZ2ub5bvgsewl/tBHlCtAADOTl3BU03UDZDfZ/gg3A1Rr4cm5LeS7ne+uAhpKw22V34u+OnhEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301043; c=relaxed/simple;
	bh=3nzftweehYxsETag0j6kacwVvBv/RmCc3VB9RLyGcHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pS1jRWp+LGub5pG5WJet74lxyNxmmJs9q43mOORMU1WaZpIkPcDhGKORSERYlDL/NWsHbB1AEsptgyBNyJDARVu429//1+3oOflXQNA8pmbVUg5ha/iTgkA74Y1qdiQctdn6ceiErgvVN1cAjQ1gh5LWXljIJVa92IoycO9n1KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=HI71dJGB; arc=fail smtp.client-ip=52.101.66.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7EpujgPoWIXpZDh0+CCfltNbs01vs+RfvzfIInBzHkpVTtk7ftp79drjRr9Elylp8gCofERv5Xdh260T1HHr8nkci8ihb0aGr8Af3HcNgqQy66SkOaPFAwo62XVm/PV1iC+aAosXx3+QiaSeMWmHocaKTeAtk2XV1DMEc0jq3ThKFL09AruNBj9XoTIzDfdOTIDe+l9TLKuRtrlidUff/nKXLR4uzmzeK9tzW+UCnYY2XEuC8FdWvyxmDtGa2TOytqLc+DoCMUN10UIyAppdJEZxP7DmKp1vlM8zGxzrlLdJAayL6Rg55vXuSl0K7uTO6lhWWTBRR/YOTGn4dC9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ugdyv8YJJ6EXRvh72q90L6R+jmx3Ei9oy+B4TGBXU9o=;
 b=Kbg9ojQQnxYHmyO8ndHeXpSK4eGLBEsvoL43AJHeKaiqknShtB+otFWNeIDVo0QkiwDgMuFd7sc9cYGMvCi2ypIMNnPhQGVK6bAv7Nh9HJROQk0hOne0XBSwmW338YSuAskWBTncB4NdzPSk97Vcg800bM9sZkCSE+0YBIbo9M4dBR68nr7ZX/yIr1sWxOLk113jgFI4WaeniZEXQZ9egaFHCVOeyHo1ZwhQiUL5nLJzPi+9rUSWloYg7ui9/hhuAkhdjxIrtIQodVnMRuqwYsgnJPDoxJZHaohpjvGhl3rm5Vbs/mOhNO/yiY0SqLrBExlAob2PYAPOxa7dswzKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugdyv8YJJ6EXRvh72q90L6R+jmx3Ei9oy+B4TGBXU9o=;
 b=HI71dJGB7L1QK95A+RpQkoo6yjlNJbXYBGtx21TtHC8eP4GE2YdnNHSfNuOpIeWNrlKkNk/ThoE6yW2kTxjzBgF9biTbhrB5vMPShcgNhPN+h5Rn3pYkJU8PTGMNX2olkY20e7bJnId/EQbBzjo367MRb2qFUxKTyyWT9v9tDJUNuQYKomWkyOs7wyGHlk2UFZwd7SidIlXuEG7b/EtVLigpBuOYF0eh7XIn97rwCukUF+IlDDYKKEzJQ+RqDWQ1p/c2UtCtFHZpFGTOJVA920yF9s6k+bi8MLVdR/MS5tkSg8WkaLd9Hfa5JkU8cjr6amNb6xA5151DvQ5gRkmjTw==
Received: from AS4PR10CA0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::19)
 by AMDPR07MB11168.eurprd07.prod.outlook.com (2603:10a6:20b:717::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:17:18 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::45) by AS4PR10CA0019.outlook.office365.com
 (2603:10a6:20b:5d8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Thu,
 5 Feb 2026 14:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Thu, 5 Feb 2026 14:17:17 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id F21762366E;
	Thu,  5 Feb 2026 16:17:15 +0200 (EET)
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
Subject: [PATCH v2 net 0/2] ECN offload handling for AccECN series
Date: Thu,  5 Feb 2026 15:17:08 +0100
Message-Id: <20260205141710.12609-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A61:EE_|AMDPR07MB11168:EE_
X-MS-Office365-Filtering-Correlation-Id: d14bad75-aaf5-4e93-a6a3-08de64c144a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZENQazZXeVpNcnhKeGNPTWxLc3d2MVlYVy9mZVFkL1dsczdHNWNEd2JzV0Fz?=
 =?utf-8?B?Y203bmxsWUlaZ3dWSktkSGpLMVNPNkdhM3FoY3IxdFQxZHh0U1RvenJ0L2Nv?=
 =?utf-8?B?YWRkWlVYTWdSNzdKQytIQUJqcnBUZFNDaEJhR2FqNVB0d3M0cnB2dFF2bmlu?=
 =?utf-8?B?TFQ4ejhpOUwxQk1MTGpaaWdTY2JoaGt0R1l4WE45aHhFN3RZeTQ5TURHL0pY?=
 =?utf-8?B?T3VkTGpseUpZVncySEFza0g4ZGNsOG1xTWIrWEVFL2VveERld29LbHdFOUcv?=
 =?utf-8?B?Z25OTkJJcEdHR3NyV3VkdGRZclE4SGFmbUw2cVJ1ZitjNUhkVHZUQVAzQlJT?=
 =?utf-8?B?bWNSTTdmSEhYUjhJRGpIc3MvSzlMOENSUGhSSnJ4VXhZZXJIM2xOb3VScTYv?=
 =?utf-8?B?Z1hVaXZxQVdMcjFPSUZCWEVHQTV6K2Ricy9ZaEcwTnVhTW93bzVpMjFYRUU4?=
 =?utf-8?B?aVhZVnFja2ZCV3ZtL2FSaXNOVkRTd0phTUVQTzViM3ZkMk5rc29KbWNQY3d2?=
 =?utf-8?B?NGxGVGN2QkRySlc1b2tVbUM0MHY3SUU2U082cXYzNmFaVHFKdUp6Y2FsOTBr?=
 =?utf-8?B?dzl6MVozdTdPVk1QUEEvS053d09Hb0t0NWNpcldsZlRwRStPbG85YzdHRm50?=
 =?utf-8?B?S3dRUWZtVjhybGVVRnEyN0ZudUlTMkRUVSsvczIzZTRlTWZDM05tWjhvQXNi?=
 =?utf-8?B?UTloWVE1NFdRdTcxZ1RUamF6Z21aTWZlZVF2K3dZdlFNK0RrczFvMnBVZlVj?=
 =?utf-8?B?ZWlIL1o4NHRNMWdQTXRwbGY3d0lUSWlIalpEVXBHL211aUFIaEJyYU5nOHox?=
 =?utf-8?B?b0Z3MG5IV1phSWwwNUhMK2JjaWZNR2NIZEhMOUxFREF4UThhQmVLSWRwVExk?=
 =?utf-8?B?QTYrNUNjVENnV21yNTNFM0pKakJkYVNyTURyTXp6UjJoak5TOVc1Qk1ITE1N?=
 =?utf-8?B?b3NBbFVSYnErN3pUKzRzeDhMOE1La1VLczIyWFRSaW1lMDFra3FyeGp0bktT?=
 =?utf-8?B?MmhKSUFqVTNnWm8zTndwN2VYbC8rd1NiQ3pkbitxenFYUjVSR0hsek96WDR5?=
 =?utf-8?B?QmptOWl0ZmMxeEljS2QrYzlhWjRIYzJlUUMvR0tqYkxHNTdrNmpucGhwMDBu?=
 =?utf-8?B?czJMQkllUUUveWVWK2hWbjdHZmJJejVoMTVNTU56bi9EeU5GQVpxSnpxaGtY?=
 =?utf-8?B?S3RXTDR5YnJxRnlQY0pmNi9VdEd3Sk9JV2JxRU0rNGYvS0IvY0JnTmF2Wkw2?=
 =?utf-8?B?ZzhreENEa0JlT2xMdlA3ZFNCakZ3bE9VaVZjeEtKdWsxaXlOUWl5VU91L2g5?=
 =?utf-8?B?VVd2WExtVitKSUxkSndXUlZ0b2pjRDBldHdmWEQvN2ZTU3d0ZkoyT28zWno4?=
 =?utf-8?B?SmJ0YzV5L2IyRkZXcmZhbStLWXhmQmFjdUxaZ0UrRkt2aU41elBCeVNqaGNv?=
 =?utf-8?B?ZUpDZm5rUytLYk5XemE0N3hCWFVhV0lKY2c4RWsvUlFTSGZBa3BYRHdTS3pM?=
 =?utf-8?B?TjZ0OHFHeVRnYjBkYldKcDN0bE8zaVByREh1Um5Ic2NGQVJodlJvVDdsMEFF?=
 =?utf-8?B?SkllNnhkdFpxUGpLakJzMll0U0lxRFk0MTZvL2NURWR2dUU5N0drYWwzTHlI?=
 =?utf-8?B?WkhjSXpoaHVNdURFQk12REpvVFRVR0JSaFRnaU8wUG1qelRHcUdicDI2cXlR?=
 =?utf-8?B?ZENUaVZVelVGN1o2OGwzSzNlbDI1ZTRVWFJITkFOYmhCSjdXelo4SDNORzdH?=
 =?utf-8?B?ZWFEZ1M4MkNRWEQvQ3lrQkJ0TG1TRzFqTDVRSkozS2N3eDhFR1RUazRTODIz?=
 =?utf-8?B?KzR1clA3ODdmcEhCWXhNdTUrUlJrMkVHai95Zm14U1d4bzFiOWw0NWdsN3dP?=
 =?utf-8?B?Ui8vQWpVcFNtNThYR2sveHNwWGYyM2xzWHcwdXh1RkU3K2lYKzZPWnp5NnhC?=
 =?utf-8?B?N3djemdYa0R3YVN2QThaMWpZdHRsRmR4RDE4M0g4YmcwMHJKTmxFakpidjdw?=
 =?utf-8?B?VHdzVlJyWFE5MWtxVjlVNU1hR1BncXhkUXpMRVpmTjJhODBVQlhrV2RPbDJO?=
 =?utf-8?B?ZzA4NE1XUEpROFNJb3BnUFMrUzM3WVUyZG1SclBpN0ZtVmxINXJEUGxVTnBF?=
 =?utf-8?B?Q0t6R3FsTWxzbVhYUlJRQzJqcWlXMlV6MkQxMXRiblVaYldCSVJIMzFpVTRF?=
 =?utf-8?B?SnJUb2VsVWFqaGMwMnY3dDZkMWdIODNHYUZoZHlpWHovUGZWdnd6eUxyWFNI?=
 =?utf-8?Q?QYaa0slFJemUyJm/DiIZGfJmLb6MF5wue2BibNOcUk=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yxbiu6wMiTertCvtdXygWJ0M4h22AatoVQ0E3wWjWfmJ5T4tkHVwVCtrC8ijWk+JRuUld+k/8tb1axx6+W8tScNVa4fuh+6fZ3E43HeysTdud7BQ6ZD2p11dZkLIuQsCU4Rejr43FoPD+hV0pkjC7vE4Zd6OUfqEYTXAlocEuu+JsczAWJDMNr1npIw1qZClJFPZaANzygb21gpxsRfeiblS3OGhTF4FdUTjrp7Z47wPSYVhGsUzxk+1kRLBWqHXf6aofLy1ORzGCSaBGfbsNoA+Jaud+kwBPN7ngapODypUQkPnRLNOrCQPW5nUGWBOce5dGqudQawVa72sQTJ9z4MZdZJV/SsrM9mAWV2JCzQy85KIFQONVuTsGvissbFT/lAjo0575SuURS8zIIxjq2fKppDbb/iYXqER8mqEZcNt75XOF67HXj/+ZVWGThA/
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:17:17.4963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14bad75-aaf5-4e93-a6a3-08de64c144a0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR07MB11168
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16581-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 809B6F3DCA
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v2 ECN offload handling for AccECN patch series for net.
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
v2:
- Fix commit header title type

---
Chia-Yu Chang (2):
  net: update comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
  net: hns3/mlx5e: fix CWR handling in drivers to preserve ACE signal

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |  4 ++--
 include/linux/skbuff.h                          | 15 ++++++++++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.34.1


