Return-Path: <linux-rdma+bounces-16299-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPlPJHiIfmlkaQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16299-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 23:55:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2716DC4490
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 23:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19DBB300B186
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 22:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050A838B986;
	Sat, 31 Jan 2026 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="KrIv3XFw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970F378D6C;
	Sat, 31 Jan 2026 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769900129; cv=fail; b=CeYqU0cTe2tQV+gl+v38qRRAmXcJ5A1eGxgwbo8SvHhC7aI6GsgbZWAi0N5Cy6M58Ye21Dc8ebSftGaf/OVK49W9k15YQl6rbQR7H+ztAuP5PhdhhLBxlYoSn92fBQR3rXIdL4SYxpEH/XTRORMr3Ws60WjXy2Dj0+xFuKcDdf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769900129; c=relaxed/simple;
	bh=rsc2JAUHgJcuqSbFLNiDrBxlcCl2e+MFULKA+CikKGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqVSjrWKJpaKTobCflrgB2DZy069qunOQkYyVjg5yjejkP0wxDo4cd1bQ5apMNo++TL7qlNp8HXCv+u3zp9fk6rIDBvVQHjNofa9IresuZzRkdo8hUNrXC+Ag7rmktRaVSPW3FtbzRbPl+Pz2bSW9AjGTal9tZBNr1XMVJFI1Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=KrIv3XFw; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhtEoPRHIHpVld7YTEXLjPboLCwU0XFEMzyXZJXmJ84WXi4ljsnQJMdGxEOsRMYUsO3/b4GAi51fSCbXdEcLxphJzZj9CDOf13digPSVhnXdCknyDBVECxnHoFSB56wRNYiyA1JsnVLzzxwSCYZnIuc+0EJX0vR1msu1YKyN5TGcsUDKNEFyNnScH5AOaxUyyHLHiykweZhvhncufCQIPhoddUdUCq4BLGUKYtD56RPe8mQ+X9lpy7bVZC7DEGBnDhpk0TyMzhewOGNSIundty1c74LvrBA0LJD6SPXmdnwaIwe4tMW32fOggILOdt1dECgIIap8rh9NIe89GOPwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h22MDVPmjsd4CfECj4fvXfXT+dXAhRiuk+V1dMdOzo=;
 b=kJT7zX8ZdnLRjpBKMVfY8B+IBDSmczsYgO9c+h/ii3/t377Rt1qhrA3+SKOHCs5rITbznQ47EhFemq2Wbbfb+kHn5vSCWAwDTW01Ggfle0Zy+ZVzW/K4JmETFx9X5xRpb3+0VkXZavJIlF6huL312buOCaNKkeTUhGJw6oYR71GSEV35iOFjdKngNI9IVZjqhPHqucO5A+dVYNn31dwLyuOQay17ywZAOZb9Ih5tJAF3wbqPCMxE88Uo4L3qzqvicknN0xHCoOtWUNaNtA/zV3aXv7+1gO9NMExlZHTjiCIH6PTKjXvVK571QO+sgtHGZIo18t6c76DEIZygVTWOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amd.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h22MDVPmjsd4CfECj4fvXfXT+dXAhRiuk+V1dMdOzo=;
 b=KrIv3XFw7Aez7LHaYqpYXM5OLl9sx3n5jT1dPYWOuDNeiCfynTgKRR55zjvaQWDh4HUIofVC8szehU4t0+nzEjAmcJXfp8PGEMMbPctVMGY3X7R4yc8zV9m6CNEwc0wAucSCgFwFQ2CZSG//s7UJZ+0xypmoKNEfDr9SZgcAmPFxmW6hzKsFD6qQUYC21NbBp7JE07h6WWn2HoE5Z/MHFe37t1+c57PVzlIDEt/5Zs2NQl4j+JxyiuAbin+T6un4UTZRExgwgf5C2UNvYPU+ms5Tiybs+R/Soqwcx7ghZ7waLMyfhlXTMXWw4yDUYYmCIQyxjEyqFJgLYtRP8OKB0w==
Received: from DU2PR04CA0301.eurprd04.prod.outlook.com (2603:10a6:10:2b5::6)
 by DB9PR07MB9651.eurprd07.prod.outlook.com (2603:10a6:10:2ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Sat, 31 Jan
 2026 22:55:21 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::8d) by DU2PR04CA0301.outlook.office365.com
 (2603:10a6:10:2b5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sat,
 31 Jan 2026 22:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:55:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id A65AE1C0031;
	Sun,  1 Feb 2026 00:55:19 +0200 (EET)
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
Subject: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in virtio_net_hdr
Date: Sat, 31 Jan 2026 23:55:10 +0100
Message-Id: <20260131225510.2946-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039234:EE_|DB9PR07MB9651:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2b60c2bf-dae4-4b6d-f3c9-08de611bd02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UcKeiLfWXbvSieRqsfkaj2w9mFjW5xG/1CnQ6Z2aEc09ABcHEP6TQWkxR37j?=
 =?us-ascii?Q?XKTXyKwObjJAO+uos4Wvu02aHRuURbR0DqHFojKwCrzRE4nPs8lhsuyvnzsa?=
 =?us-ascii?Q?MBEfUq7qDzZqrI90k9pkjRSr6B6Yh9aTuD62uhIMhChofY+3ztU2IPr5q9q6?=
 =?us-ascii?Q?mJvMmINP4/zmw2jItf40ghYZ0pplNmVUYZIPeIyteEZQaFn7X93ZfHw4P2zZ?=
 =?us-ascii?Q?IeqQqrEXcBq8s6nbopyNA28R7Z76W4rdeGx3SdKpOJbW+R9n6ZJCeXjDa1N/?=
 =?us-ascii?Q?e2ZbnSd1uhyvV2BwUm8R0eFdcAO0yArvvJ3fnYPSc6qm/jhBBqhJgrgF6sg4?=
 =?us-ascii?Q?K4nVZ88zLz47FAbNtqJvJXM6VwOTNgpl9n3meKO6Z/CoM5FvyiY9aP1H3KS6?=
 =?us-ascii?Q?h0he5zKJp8k9mnCWZR8wCZwdEIwoZz4O+bf9sHReGZeVb4xevq3YzYuzle1u?=
 =?us-ascii?Q?yVzaSKcfhMVcdguUHoN9r3CX9E1uY8fh+v3lgWMbASct0Zz2R0NnxsRxGxXp?=
 =?us-ascii?Q?8KFeupQ+jrO/qAG+988Ltu73klGYe15yDFB+iocm3M4+pTs5B4Y/gYdsCkPh?=
 =?us-ascii?Q?01JvFrLH/qwmZj7c+l4BE2JPMQX2k2DdOAxzozQENH8a28vvUGB88CXSBzSW?=
 =?us-ascii?Q?WAv7h29gHsLTXjnBYUVsKs5gJLivt+lvkHq3OP+P5R70Hifaj4MU4tatMnCY?=
 =?us-ascii?Q?G+PqXN8OwoCio1qxL7dXGD4Ys+qB6vluPqOPpAcEmd/rSMyMO04CxXLCRxda?=
 =?us-ascii?Q?HxK8zCaVxfPwesUkvxF3fMKbUwjmQ+28xOItp4IfLQMXzMDyLqGArI8lnZq4?=
 =?us-ascii?Q?hclp/ap/zzK1lW5UzkX+kQzSXGRjYGYmCo7CH1tXftCvYErcYHGz97I4DyJ7?=
 =?us-ascii?Q?DOy6ina340R16I+2oWtuiPV2DrbBcgf8pPRybZDg6XSp95B1xyqw6ZQReLeJ?=
 =?us-ascii?Q?RAGe5izCBAfDsJqc4IwcT9AU+gRtffVVydh/gNBbSTFOjfooeXhV1s3cGSfF?=
 =?us-ascii?Q?5w2cGz/U8H6poIpoc66wINMZQkfJ7efScSG0Efo4cCjJgUumtMXhPt5ioI9s?=
 =?us-ascii?Q?p0IBzREzZHFfSMdwTyqjbCpSu2vSYLpuBfsednc44g6G5FnFYlRTYky5Y9mO?=
 =?us-ascii?Q?qfDfiXej3iUiDRFM+Y70+LWHYF9eSnNzQU1LhES+sNGVRgg0TLeryDA5gNfu?=
 =?us-ascii?Q?Pu5dpbIMJuw7bGiwU2VFpjZvQDXn6bPvcPzhniCFVVzsVnlT1udae02+eH1e?=
 =?us-ascii?Q?B3WbPhAm0bH4wZpz3rjlty3+v6dh3DhRrEyuEFLcv/xLWmbgI+SNoK7N3qkD?=
 =?us-ascii?Q?JmsSVOkw8wv6/8foQZG0CN0SaSWjaTosmyn71idvdLMbp4wOln4L6Yy528r1?=
 =?us-ascii?Q?sP/ZEHOy/+EHlKTnAWNjvcIohUMePwlQXbffy323eEG8dwLVlAJ3lXmT3xa2?=
 =?us-ascii?Q?bcg/bk/28yBDx6U4nrL5q1StjdhWFRyxewCPRXdVn5zvxSJfr9yAk5/CI2ta?=
 =?us-ascii?Q?1Kc+dFzmU1L81EoG9Otf8NY44YG0ezvoo5xu+eHP3m7BwLeRX7+Uzwz7+nqI?=
 =?us-ascii?Q?k/COd3E1oH1mHIKG4BiMZ8kY1JJ92YnP1+fFMVrFMU85405HOqA7R0ByQtkX?=
 =?us-ascii?Q?swo2Dzmks+2u/PxAaE0fkgswguCwCHLDRGXfpbCKEJSt+DI1ywS081cRchJp?=
 =?us-ascii?Q?Pg3cFsHpdUeW+aaC+lbksXjzVvc=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5YMIjbvNooAUs+11e6vTfvc8t0qm2VwkWH+QysKPqGETF6rxm4eirgnRZ0wyX5fQMmEV5PwmR2da4k8jNCKWEonvCRn8FgIEKYHLIdStOQJRMb1EheV2VYl1qGJp1i3/Mhq5VaQWZ0x90QBXZ2zzWR6Rt+WKUV78Vt29cInpQaPmYntAC7XqwCd2b2yGzYUcZUXn30ebyRnOG1dDiDmZHjWbJ7hR2SOOJ99HYQezXf4A0o0KwUGLQP/lZF48wJQ1GhASdUel9Q0rcnfmcdlr82WapRAATcayJDW4KtmaGC2nO2YmM25n2vJHwJt0zVlvQdcFhT4YY+gcJRFhsgaLuBbhQPwQKwsUMSvlT6lxEsClMK9y3VQnnY8nmv4W7ahSudxN/scGpkdrtOdCh2VCgrJokEKuo/vZ09naoGtNPAmB4rqJz7FvbJzbJkSRwMPt
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:55:21.7093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b60c2bf-dae4-4b6d-f3c9-08de611bd02d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9651
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16299-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2716DC4490
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the ACE
field to count new packets with CE mark; however, it will be corrupted
by the RFC 3168 ECN-aware TSO. Therefore, fallback shall be applied by
seting NETIF_F_GSO_ACCECN to ensure that the CWR flag should not be
changed within a super-skb.

To apply the aforementieond new AccECN GSO for virtio, new featue bits
for host and guest are added for feature negotiation between driver and
device. And the translation of Accurate ECN GSO flag between
virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is also added to
avoid CWR flag corruption due to RFC3168 ECN TSO.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v2:
- Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS

---
 drivers/net/virtio_net.c        | 14 +++++++++++---
 drivers/vdpa/pds/debugfs.c      |  6 ++++++
 include/linux/virtio_net.h      | 18 +++++++++++-------
 include/uapi/linux/virtio_net.h |  5 +++++
 4 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..103fb87c690e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -75,6 +75,7 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
+	VIRTIO_NET_F_GUEST_ACCECN,
 	VIRTIO_NET_F_GUEST_UFO,
 	VIRTIO_NET_F_GUEST_CSUM,
 	VIRTIO_NET_F_GUEST_USO4,
@@ -87,6 +88,7 @@ static const unsigned long guest_offloads[] = {
 #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
 			(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
 			(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
+			(1ULL << VIRTIO_NET_F_GUEST_ACCECN) | \
 			(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
 			(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
 			(1ULL << VIRTIO_NET_F_GUEST_USO6) | \
@@ -5976,6 +5978,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	    && (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ACCECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
@@ -6635,6 +6638,7 @@ static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
 	return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ACCECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
 		(virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) &&
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6));
@@ -6749,6 +6753,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 			dev->hw_features |= NETIF_F_TSO6;
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
 			dev->hw_features |= NETIF_F_TSO_ECN;
+		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ACCECN))
+			dev->hw_features |= NETIF_F_GSO_ACCECN;
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
 			dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
@@ -7169,9 +7175,11 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CSUM, VIRTIO_NET_F_GUEST_CSUM, \
 	VIRTIO_NET_F_MAC, \
 	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, \
-	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
-	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_UFO, \
-	VIRTIO_NET_F_HOST_USO, VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
+	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_HOST_ACCECN, \
+	VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
+	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_ACCECN, \
+	VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_HOST_USO, \
+	VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
 	VIRTIO_NET_F_MRG_RXBUF, VIRTIO_NET_F_STATUS, VIRTIO_NET_F_CTRL_VQ, \
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
index c328e694f6e7..90bd95db0245 100644
--- a/drivers/vdpa/pds/debugfs.c
+++ b/drivers/vdpa/pds/debugfs.c
@@ -78,6 +78,9 @@ static void print_feature_bits_all(struct seq_file *seq, u64 features)
 		case BIT_ULL(VIRTIO_NET_F_GUEST_ECN):
 			seq_puts(seq, " VIRTIO_NET_F_GUEST_ECN");
 			break;
+		case BIT_ULL(VIRTIO_NET_F_GUEST_ACCECN):
+			seq_puts(seq, " VIRTIO_NET_F_GUEST_ACCECN");
+			break;
 		case BIT_ULL(VIRTIO_NET_F_GUEST_UFO):
 			seq_puts(seq, " VIRTIO_NET_F_GUEST_UFO");
 			break;
@@ -90,6 +93,9 @@ static void print_feature_bits_all(struct seq_file *seq, u64 features)
 		case BIT_ULL(VIRTIO_NET_F_HOST_ECN):
 			seq_puts(seq, " VIRTIO_NET_F_HOST_ECN");
 			break;
+		case BIT_ULL(VIRTIO_NET_F_HOST_ACCECN):
+			seq_puts(seq, " VIRTIO_NET_F_HOST_ACCECN");
+			break;
 		case BIT_ULL(VIRTIO_NET_F_HOST_UFO):
 			seq_puts(seq, " VIRTIO_NET_F_HOST_UFO");
 			break;
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 75dabb763c65..0cf86b026828 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -11,7 +11,7 @@
 
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
-	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
 	case VIRTIO_NET_HDR_GSO_TCPV4:
 		return protocol == cpu_to_be16(ETH_P_IP);
 	case VIRTIO_NET_HDR_GSO_TCPV6:
@@ -31,7 +31,7 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	if (skb->protocol)
 		return 0;
 
-	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
 	case VIRTIO_NET_HDR_GSO_TCPV4:
 	case VIRTIO_NET_HDR_GSO_UDP:
 	case VIRTIO_NET_HDR_GSO_UDP_L4:
@@ -58,7 +58,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 	unsigned int ip_proto;
 
 	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
-		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
 		case VIRTIO_NET_HDR_GSO_TCPV4:
 			gso_type = SKB_GSO_TCPV4;
 			ip_proto = IPPROTO_TCP;
@@ -84,7 +84,9 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 		}
 
-		if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
+		if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ACCECN)
+			gso_type |= SKB_GSO_TCP_ACCECN;
+		else if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
 			gso_type |= SKB_GSO_TCP_ECN;
 
 		if (hdr->gso_size == 0)
@@ -159,7 +161,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 		unsigned int nh_off = p_off;
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		switch (gso_type & ~SKB_GSO_TCP_ECN) {
+		switch (gso_type & ~(SKB_GSO_TCP_ECN | SKB_GSO_TCP_ACCECN)) {
 		case SKB_GSO_UDP:
 			/* UFO may not include transport header in gso_size. */
 			nh_off -= thlen;
@@ -231,7 +233,9 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
 		else
 			return -EINVAL;
-		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
+		if (sinfo->gso_type & SKB_GSO_TCP_ACCECN)
+			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ACCECN;
+		else if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
 	} else
 		hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
@@ -282,7 +286,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 		return -EINVAL;
 
 	/* The UDP tunnel must carry a GSO packet, but no UFO. */
-	gso_inner_type = hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN |
+	gso_inner_type = hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN_FLAGS |
 					   VIRTIO_NET_HDR_GSO_UDP_TUNNEL);
 	if (!gso_inner_type || gso_inner_type == VIRTIO_NET_HDR_GSO_UDP)
 		return -EINVAL;
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 1db45b01532b..af5bfe45aa1f 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,8 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_HOST_ACCECN 25	/* Host can handle GSO of AccECN */
+#define VIRTIO_NET_F_GUEST_ACCECN 26	/* Guest can handle GSO of AccECN */
 #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
 #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
@@ -165,6 +167,9 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 | \
 				       VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
+#define VIRTIO_NET_HDR_GSO_ACCECN	0x10	/* TCP AccECN segmentation */
+#define VIRTIO_NET_HDR_GSO_ECN_FLAGS	(VIRTIO_NET_HDR_GSO_ECN | \
+					 VIRTIO_NET_HDR_GSO_ACCECN)
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
 	__virtio16 gso_size;	/* Bytes to append to hdr_len per frame */
-- 
2.34.1


