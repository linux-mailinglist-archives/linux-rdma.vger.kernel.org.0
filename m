Return-Path: <linux-rdma+bounces-11767-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006EFAEE631
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE1A17966E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758362E54DF;
	Mon, 30 Jun 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="FUIQ+HM/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2093.outbound.protection.outlook.com [40.107.93.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4C29827B
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306295; cv=fail; b=p4QZGP+ikDhJ8dd1x4IVhshsiSBoVwW+oaUPcJsAi5Wx5hewqcsoQY/k4UPfx6WpQB03hg8NacY5LBl1g+VFz6bK0ysFt+lGpIPcpMRbP7SuwRodKjDCNmnSmLixj1TNOYo5sPQ1xSd0Azh9uLvHMJg4GQExsdExFFZcPgHOfLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306295; c=relaxed/simple;
	bh=lVDroHVbHpSjzk8KvWuPl6d6PNK7W/C0sr2IavoFFPY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+0OhlW4Z986zvOlVcZInfciY+fHJEiz5zyRPUU2ItV+3nVlycyKOcZ1c94Eq+sL73YZC3n4sRdhRno297DxADvNOrBusHfk5V3MYB8c21TNKUHTdIwRFOOuDEcitfjT4DkeI4PT09m7MjzTaarMB3dUBjG1F7pK40q7X+56kn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=FUIQ+HM/; arc=fail smtp.client-ip=40.107.93.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYItHdwLzhFTynHHgtwtQRk2bQsGFLApeLbN2UF13X2r9guFk9n+vH+KBC0HU1Jo0FVaK438wP2G65c54+Zt34FzOjYerg3EnueqfC/2N7MkjgJ7VMJ3G1FJ0QFRecEW6ErWPjVPV7NeZDd8f71scbL2BKC6mALRqLMl1LhThaFxySPP3e2bZS5+HFm8Nbzuu+JWyoWOvfCwGHkIV6RoiOdPHej7Pk0jARurlPLNWdeCBd5mPA++JH22N6JhDWvzt6+3YGpL2fNxdhfSWxwkJeyLY5Dtl8IbR23EKY/8g6pBZJ1LOphClI8QmdhzV0os0N1/HKYq9hE8ojLkNK9rLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/1dPXp+3Ia7VS4Lprro8klfLVswwFWt4Xm45hZMYrQ=;
 b=eAHsn4ijsUCo3E8R3stfjrdFfrIOYrc3/15DSewn6nPbkVuQBwK5W1vqEKTQuhhmDc3Oh/fWzXAY5J7KwS+iX0wTGgNEeDI+Avs78N7ApxSursMbfU4WtLk4noXfK2OEpv2SSn+YAz2v7noE1EORQn9JmXZLiZWnrwsFyeUEiMMdIjLZuu+Ow2wmMN6Zs6rZy9bY58W0hHqJld02xKtGRzMNGQSKhkfHn45/4H4NNvEjEKUIpLVenbg/I+8hGktGXb1u9EKFCQCv+1wp9QuwiGYlMy/95pASxpnIkmIG81x4fu7F8gXyRs7AKijEgDG/5cuOMx0T9OcXwnqCfiAXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/1dPXp+3Ia7VS4Lprro8klfLVswwFWt4Xm45hZMYrQ=;
 b=FUIQ+HM/9MoiBbNWa2shMl5F3xEudufG1VueehiMni0XMEkQwhktgJOuHqRyzqUOFNJV19ov9mVvBHavzNzl2o4Nk3PqFv5kINmuhas35ZFSu86c0ORo57QNh/++xNjJnijenla7VEWGPNI2Qevh/nKlT0jc/TUJwLD8/l7b7n6CDX+f+BkOqi4hsgicxEhepcQbM7iJIXGdjP9xiIKB2birT+7Y8bSxSXNMTCxTWCWXFhPzGnCOGXg6JKMbrpustFFufhnZMuE3D1kDQTn3n1GXXwqWLJzeAEXdtTzMUogHf3kt/hOltyvLhOt/RVtz8EzvpkZBlcnk/1Pxy+6ijA==
Received: from MN0P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::10)
 by DS4PR01MB9385.prod.exchangelabs.com (2603:10b6:8:2a6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.26; Mon, 30 Jun 2025 17:58:10 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::23) by MN0P221CA0007.outlook.office365.com
 (2603:10b6:208:52a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Mon,
 30 Jun 2025 17:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:09 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id CF48214D726;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id B64BB1811CE6C;
	Mon, 30 Jun 2025 11:30:02 -0400 (EDT)
Subject: [PATCH for-next 03/23] RDMA/rdmavt: Correct multi-port QP iteration
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:30:02 -0400
Message-ID:
 <175129740268.1859400.1068067040264442447.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
References:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DS4PR01MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 667f31c8-2e8b-4807-c58f-08ddb7ffac7f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzNuVFpFTzlzUFhoaTFRb1kxR3RISEFmbGJVbmI4ZXQzem4zWEFoVDBTaEha?=
 =?utf-8?B?QTBsTTNoTTNVY1pwRFY1SGNjeE1jdm54Q3Y2Q05RcC9QSnc1Y1lzbEJUczdo?=
 =?utf-8?B?WDJCTXd2SnAzZXZvbEU4VFh6SlVsYzFVNFNkbFc0M2dCM2xWMGJmVGpaZmZH?=
 =?utf-8?B?MUFnSms0ekc0M1F6dWhONndtcWMvK3FpYjFzVElZVXl4WC9XS1RvQnVpcmQ1?=
 =?utf-8?B?TjlFV1hITzNWWm4rNXBjdmNoVzJhSWJKYnlPQ0JMVmtGcUdMWXFXWm5ESU5P?=
 =?utf-8?B?bjF2U1laVHNsZk81WlhZME16V1JENjkrVG9YeEVLUzl1VTZxT0plZXZTc0Ev?=
 =?utf-8?B?NFg1Q0hJU216WXc5MmhVMGU5dy9CLzhQajlQSXRpeTJjWFFSSmJwMGRTYTRU?=
 =?utf-8?B?SjM5bmtvVUZnVlJQWndnZHJYazlHbzRScExpdVJXcm1EMWpYM1lrTUhpUi9M?=
 =?utf-8?B?N2J3OE9vSEkxV2k0SVhIQjBsdGZJWkZvUEY2WWc1SUtPSFM3eU9UU2JlZGxI?=
 =?utf-8?B?dmg2cHF2YmxYblZsdiswRVVaYVVHOEhCUlY0ZE91enlYOXpnRCtpZmtJeUhZ?=
 =?utf-8?B?dTBhL21Mb2ZQbFJjK3IrZ1NBYkRlNlpYakZzYzYrR2EyMUM0bnhkZjBwZHVW?=
 =?utf-8?B?TTVyMmZtVlg0QVBWQ0wwL3BTaklCWTlTd2FGOHMyUldHU082L2QyWGxGQzRk?=
 =?utf-8?B?OTB3SE4xKzBacTg1Z01FRVJWUGxQV0x4ZjRQbzhoSWtyRmVJVUxqWmNlMUhT?=
 =?utf-8?B?UjJkdFBHNDc0YzFtMDljNm9ERDMvWHBqRGR4VzhicXpwcGVUaGFOUHUyV0NT?=
 =?utf-8?B?eWJmakZYajZCMU8wWk53UHJINGRNL1ZtWmpkaWwvRGUyUkJYNnRUNlM1K3lQ?=
 =?utf-8?B?aWhzNDhhbzRZZUFaeERDYWxKNlU3VyswRFJIcG94MGJjdS9tZ2FOdW5WNDht?=
 =?utf-8?B?VmJoL1RSMHNyakNqenhHRjNkck83eWJpSnIveGQwaG50blNiS3VGcEE5Q0lo?=
 =?utf-8?B?SkNDemxOSXU0SEU1bVluWHJMVElWbks0Um5rR3U5RE9scGFtWFhHckJGcnpp?=
 =?utf-8?B?UEZqemc0Y2FDcFBUUk0wYjdrQTR5YXczVzl4d2l0UDRac1F1Q2F0VENsczBW?=
 =?utf-8?B?RW9UNDV5a0YwbU5EM3RwaFBpU0EvWUlKZkpqdGU3TFhOMDFqc05IYnlQN2xP?=
 =?utf-8?B?NnBvTzV0aVNjb2JrWFpYMkhWNHJ1MHllN1BYVzA3ODBuTGFLb0FraEFpRDJ0?=
 =?utf-8?B?L0JwN0g5NEhXeGN3QThia3llNzJmU3Fkdk1zQzVGMk0zK2txaWJaV2VCNVh2?=
 =?utf-8?B?dGVBWlQzcjd0bTZIVWpsZWxrWlN0Y2xqTlk1WVpzZlNTR2RDQ3JMUzZMNzZl?=
 =?utf-8?B?blV4Zk1sQm1ZbmZVT2xDRURUQlFKWjkwQVlxTEJEMy9ZcEhZOUJtaU5IVEoy?=
 =?utf-8?B?WTlBd2p1RjAwNmU1Y3lVWm5yVWxnWG9jNXFPb1BJeGloSm1maE4zTjFUdHFO?=
 =?utf-8?B?ekdnVUJDV3lQRk9RMXpDM1JoNjV3UkVCWU1tRzR0eVQzRVdyWDJPUks4Q0dy?=
 =?utf-8?B?NVl6czVlTmFyZUs1K050UUNSYm8wWlhiejQ4a01PcGlBS0RXU3JkM0RhTlIx?=
 =?utf-8?B?azNoc3hIWDJiVkxkNzY1RTlWb1NUNE5vemlSUXRCTXJFTGVmN2VFblVsZDha?=
 =?utf-8?B?Y2Z3aTlGaEd2TFNOS2VCeGhyNHI0by9YbG9RcjZwOHo5S3owNHFqYWhtTXFP?=
 =?utf-8?B?VDRHZDVDeElHd1cyMTVPWXhseHZvNmsyeDluYmRRTFZmWVlDM2Rqc0JsbHRM?=
 =?utf-8?B?L0dHVkN0TzB4Z2NUai9OVzJBZ3VQRXlVRkNrbjRtVWlQdVdpMXdNYkFnNE1o?=
 =?utf-8?B?SFN4ZXlqV1NxcklEdDhQUDFzYllMUENIVXl4L0J3RkdWTVNQKzNtNHBiK1Nv?=
 =?utf-8?B?dkQvamE1M1p0NnlRekRHVlR0b3ZnMzdrMmswYVh4WmswRnhYNmZzZ0p6WURN?=
 =?utf-8?B?dFZKVWhOY1ZMcVBlSlJUai92R1BXSVRPeStaeDZNRXgrYmlNY0xFcmZxbWw3?=
 =?utf-8?Q?OE9UB3?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:09.4341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667f31c8-2e8b-4807-c58f-08ddb7ffac7f
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR01MB9385

From: Dean Luick <dean.luick@cornelisnetworks.com>

When finding special QPs, the iterator makes an incorrect port
index calculation.  Fix the calculation.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/sw/rdmavt/qp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 583debe4b9a2..464005c74750 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -2708,7 +2708,7 @@ int rvt_qp_iter_next(struct rvt_qp_iter *iter)
 				struct rvt_ibport *rvp;
 				int pidx;
 
-				pidx = n % rdi->ibdev.phys_port_cnt;
+				pidx = n / 2; /* QP0 and QP1 */
 				rvp = rdi->ports[pidx];
 				qp = rcu_dereference(rvp->qp[n & 1]);
 			} else {



