Return-Path: <linux-rdma+bounces-16908-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOCXNvXakmn3zAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16908-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:53:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD0D141B2F
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A437302B3BA
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A524E2773E4;
	Mon, 16 Feb 2026 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="sCqp/mhh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2E27A92D;
	Mon, 16 Feb 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231937; cv=fail; b=PO5HHbyXYAiXcB5huMc8Nj/aPFli5B8GQKB5HUxZiSCTyHSuKh8EqANA4NCIED0obLCZCiBEJWij/56nyMPOpb6Ni6/rhdmjpipzQVhCY+toe7X7nYOf57a8NPR96ncf86ukEcu+aKMX9J/Xbrn1vqLfRT8nGAuxXEESdx/wzIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231937; c=relaxed/simple;
	bh=8o+Zdru0NMY7nmrOlkRfFhPXh4Cb8YTcSTN4eYUcrho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFda11dtBji5KtpnSZrmndwgnEKtJrVfWnIr/vDJ4/ujHyfaCK6eKFb73DDNUXw0cm4cpCQJoqr7YI3j4h2qfLHP3Gb72n17Q5sZ+y0n75qs2JdKR0sVftKVfLxv/rTZ1HVqiuW0DhTwe5UjDwuazH5sMC3EcP6/CwSaee3jq7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=sCqp/mhh; arc=fail smtp.client-ip=52.101.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3z/PTrUx6H8IdzDgiXtzuiEY1cN5iPNnTjUXWkRP/L9TZo2Au0vDdP0BQGcktZfuY++FGo1YZq5tjGk7aXpcXCqgJ96pt8Kd9qimkIxOWFjLnGO+h8/LwCBnPqWrzIutqA3/Rh8AZ46Ox2op6JqBTNVMcMVbHVvBdz0Yw656VHIpKVTAcgzRC+y9HmkixzXY2ct6u913GFWRZ+ODDz62Y3JY7VrIWHALgw4ZwhxzBi80Xr1NWf4MuVxevQdDaH9R/SgaKDnKf/2FvR4qW7L072Z45gW3Fiz3LJ7ZyXH716/OrWjAzctQqFheEnwF5W20Sg09wlCxZ2WuhjfW+pUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkiLU/cu5i67/f9AD0r/zBCzKzABLamcZXlG3t7vAoM=;
 b=XcXj9wdxVkt6VW+FCSZYi5KLDSU88yQYAdsJPnMC4doGvl7OXpvf9lniql+ZqIUeK/NG8H7ANRfUj1Vo4Ba5qFwlhyAduiWxSZ96iCzew6YxDu4Tp2Vc13RIpHCW0E2mvD8il9/4OFJ5lull43pDmFAbhoSTEl8ATZbQLMSS6Ml18iW64A4qajcI+tFLuU++HzlYCDZGCXepghopBQCzZcc4RI90ot5cKFk2Hqo91QThfAzFxJe8s7YULJ7QZ+ktQ3ls/r7w/LgCmoRorUUnBsBpkGTdq0tD1mD8Pd6A5cl5M21aPvgIAVEvlsZxsrvVKaQym4xvt1KmoUlTGAemmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkiLU/cu5i67/f9AD0r/zBCzKzABLamcZXlG3t7vAoM=;
 b=sCqp/mhhbp2itNln+1YOe+b5yCA9bCpnryMdc9c/ELLFye37ZmvK3K69Qq6/qKWVzdJZ4BcXZAN4ztTJdI7EgXkeh0uZkmAznWkty25hHPISglZ/iQXJr3ptS0u5i1jJIoV4eZ8X7f1+NyyvgIKCRt0+tPcqHDjWgyfwpDQV+2GW4ih9JVC1Vc5FZ+1WkYbF5O8LxBOonsGHIW9/h0k01qF6k1PplihyhfsZuahQjSsvQ6ICCPmKSxnTp56uggkDq//9CwXwC8ilQKFR6h5Qbg6aB06eQJIwa3Libxt9GsjD9F+AVkaKn7sl+lbxQxn1Ya1iQnC7Wn9K2iCsl5IKDA==
Received: from AM0PR02CA0147.eurprd02.prod.outlook.com (2603:10a6:20b:28d::14)
 by GV1PR07MB8975.eurprd07.prod.outlook.com (2603:10a6:150:a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:52:11 +0000
Received: from AMS1EPF0000008E.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::bf) by AM0PR02CA0147.outlook.office365.com
 (2603:10a6:20b:28d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 08:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF0000008E.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Mon, 16 Feb 2026 08:52:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 1ED2C1C0030;
	Mon, 16 Feb 2026 10:52:09 +0200 (EET)
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
Subject: [PATCH v3 net 1/3] net: update comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Date: Mon, 16 Feb 2026 09:51:41 +0100
Message-Id: <20260216085143.40242-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008E:EE_|GV1PR07MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: 725079e7-6756-47a8-8dd7-08de6d38ac1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3JseVdvZDZ2b2lsVnRRdUgwY0xqdmFKQnRNNFJBV1lrMkxWSUtIbi9VazNy?=
 =?utf-8?B?SktHQzFlSkdETEVJOVkveFZEdkhvanRMbDlPZ0p0VE53aGs2YzdPaVUvQUFM?=
 =?utf-8?B?cnVaRi83YWtUWEZmZmdHR2RsdTYvaFdIc08ra212TWJLMnFaTnZ0cjRXOThB?=
 =?utf-8?B?TW5FaUpxaFFhbi8yVEhPZllSZUpUOCtkbmpUUzh3dDdxQjh4V1ozaHdBbE5l?=
 =?utf-8?B?dlpEZzJuNlQ0VWJlT3A0K09DL1NQblhXZ1ZPOE1nR0hDMUNPZWI1SWlubkN1?=
 =?utf-8?B?V3FMU29maHpBcGxTeWE0dXJpTWJodEU4Tk02aFczYUJXZkI4QzlxT1hCcUk3?=
 =?utf-8?B?ZXlFNGdjbGR5NlVTRkMvMU81WEFaTm0yVnhtM25neTRXaFU1enhHYzU0bkFv?=
 =?utf-8?B?QzYzbngwNVdqSlY2RHZ6aFg3NytRdnRMNGJ4ekxoRVRFejJJOVFoWmtIMkNz?=
 =?utf-8?B?S1BkQmZKaVlIWldoZWdaR3hRMm96Z2Q1SVQ2VDJEeW5mNDZIY3UyeDBpQXkv?=
 =?utf-8?B?cVE5RFhjZHFNaTBEMW9BOUc2RTBJdFZKK3BkOCtMNVQ1Nm4yWjZhN0F0WWdh?=
 =?utf-8?B?MTJ6c3o0Y3N6ZWROdWYwckxoTTJrSjRvc21lNTlac3daUHBJcmlGNzVpRnd1?=
 =?utf-8?B?OE1iajM2bnArcitRTm1VTGtXZDh0QzlTUjBnaE5USmd1TW44MjdhZlRGUkFk?=
 =?utf-8?B?d3hpd1l4UmNnamNyZTQycjB0aU5haTV3Q2twNFZMeG1wQzF4Umx0WnJBK29t?=
 =?utf-8?B?bTRhRWZpemI4T21HSGNxaks3ZGRYTEhmZ25Xb1Z4SDVVaGQ1eFN0Z2JQbEUv?=
 =?utf-8?B?RW5pUUk0UWw5ZHpHLzBsUCtxV0xhcndITkdXNWt6UzV5L1IvamlyZlIrUGRh?=
 =?utf-8?B?SWRqazBxcUxvQTlLVUpFeXFCbkV2bXlSTE1NNlcyclByMmlGMlk4RHBTdUJv?=
 =?utf-8?B?ZkZNMC9SNldmaXE4dzh6aW5ucUV6MzlhaGtGK0w4Z2s3Tjl6N2tVMUtyT0Ja?=
 =?utf-8?B?WmVpMzFIUCtrTHZDYVNza1R1ODhOZVE1MXY3TFhOYWJNQnRjNUtsL0RGaWJL?=
 =?utf-8?B?dnVmVXM0OVM4a0JUVnZpRDJpNURHREdzcXFZdlpKZ2VKTVY4WmkvZnY2ZS9z?=
 =?utf-8?B?SUVDTkcxWE5QWWdIaTFoRGptMzZnTnFpdWMwWkdjYzRXRE5yb0NwTk9JNXBB?=
 =?utf-8?B?bXB5bmk1N0FRWFo5aDRrVE1jbVVCUE9mZkljUEJPOHBneW1vQWVsVFY0cFVw?=
 =?utf-8?B?REVuQTBURk95cjh3cW9GK3RoSzNDVnNwM0pQcTkrdUpwYUNWSW1TaGNYK2lt?=
 =?utf-8?B?cExnVnBFT0xsdmg5ZEFVV3RoODNpVGQ5Rk8vRU9KVVhJeTBQa2I4eFBxNWlU?=
 =?utf-8?B?OUhNdzM0aUJFcDJyeTFHY0xCT3FrSnNxazVVam5WUGVvTEMySGFPdk1kb1di?=
 =?utf-8?B?OHNQMXdYa2M3U21NSVc5MWtVUFNMRWNzR1pHajU3bW9KN0RmbmUrZTNIcFl3?=
 =?utf-8?B?eXRtNFVuRTdXaitGckRFcUFtczlsczllbklCeGd0YkFydVVEZUdwMmZuTG0y?=
 =?utf-8?B?dmtFeWlFMGxUeEg2eXk4MHlBVzVRMG5Tbmx5SkxXWm44Wm5IM3A4YWRRZW9r?=
 =?utf-8?B?cHZ4clFHOTUxUmo2VFB6dHhxK2JTQTVqNkxkR1p0QjlaRmNZMGpPUkRjbXAw?=
 =?utf-8?B?dGxSbHIwOW8zUlB4SURDaUhIa05TdERlakRsOCsxZjM4eksvbXAzbXhIM3lR?=
 =?utf-8?B?K1JJWVlzOG9DeUltN3hMbmllUDNYaUtSeFRQUU1SaDZrSjdLOFd1TEJyTTZn?=
 =?utf-8?B?T3ZlM0kxZDJ3UUVJNDhtWTNYZW5mSnN3Qm50T29wWUQwa0JoREVRWk9Wdlly?=
 =?utf-8?B?c3ZMUHE3NURsT3BMWnlRUnZERldEdXB3am9oZGFJZ3BRMDhoeGlGd2ZMY1FU?=
 =?utf-8?B?bG13WlJJdkxvUlhKZkl4NTdlYmdrZE9zK1h4bjR2RUdTQklMV1JVUHlmeXhV?=
 =?utf-8?B?aW4vZzFpK0svVEtpWkQ4UVNmejFxZ3lzK3liK3d5Z2g3NDcvSGF1ellEUzZF?=
 =?utf-8?B?RWx4RjkvZi9PRkZNemdMUDZYNHBHNm9uK3NXekJKT3hRUGprSk1QRU85RitE?=
 =?utf-8?B?U0djd0tod1AyT015UFZpS2l0THExV3ZZM2lDcUtNQWtwZ2FTYVB2OHg4Zy9k?=
 =?utf-8?B?YTRwMkkwRVdkeXB5WDBZY0Ywa2N6eXE3UGVyNGlJSGp0cHFOTzhFOHp1QXVn?=
 =?utf-8?Q?vuGLByWFIOSohjaAnec1JTzk/RhqaHDu53SPD0fbls=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MpXGepHaJRnYnnR8iGvuYzPcGxmzpQCjuD3bRt5XHoSVw8QLVsuAU1JCZqlu7T0klKEFVDhfzL9bzXp0nsXARkkXXUi0BM7NiIpqC5aF2FiU3hZc3eZOMz3LoOyvrMfBx40+03a/7e0aEGMfR/McwERC+cIBDdayeh1ezYJbaNbEXkKoiHy9xyOI5MChowZln5ESiw7haGFlFaysbY2b5grmVr6JKFZmGctCdeVGU6IqWYy7C/pFDVBka3zpnaUi9DuwZw2R87+Cvac2I7xYpfJs/nkzq1uTvWnOXZWpDSLw/KgnvoKqIBKvOV0rafXQrBze0cl9BJGZADdR8+7e5KHlNmXqftRDdN5wRlzf8GUtU/rYNLpVb4p5EGi+Bg5vydqub9q4vjHOVxUVGaQLZIn4LC0o0KWl72UD6IFtO5WxOXl78OBJsOaHisv/sBIM
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 08:52:10.5299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725079e7-6756-47a8-8dd7-08de6d38ac1a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB8975
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-16908-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:mid,nokia-bell-labs.com:dkim,nokia-bell-labs.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3BD0D141B2F
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch updates the documentation of ECN‑related GSO flags, it
clarifies the limitations of SKB_GSO_TCP_ECN and explains how to preserve
the CWR flag (part of the ACE signal) in the Rx path.

For Tx, SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN are used respectively for
RFC3168 ECN and AccECN (RFC9768). SKB_GSO_TCP_ECN indicates that the
first segment has CWR set, while subsequent segments have CWR cleared.
In contrast, SKB_GSO_TCP_ACCECN means that the segment uses AccECN and
therefore its CWR flag must not be modified during segmentation.

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
index daa4e4944ce3..8c94cf8cf2b5 100644
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


