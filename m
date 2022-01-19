Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800AE49373F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 10:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352915AbiASJ2U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 04:28:20 -0500
Received: from mail-mw2nam12on2100.outbound.protection.outlook.com ([40.107.244.100]:42193
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352766AbiASJ2R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jan 2022 04:28:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDFdGNFBhzO8qyTsHefWwx3RAeuQ4MdnyObS2GpsmxOkDga9DlfIKJLvdXsrrn1zbIX6vX6bcoU5Er96+8iGdonSj2rD56u14AfBvKyCuNOp3XcSQbjXHQa8ZMpr6iyqmafr/tuoPRFKRuITDGSB6n+yilHtNrnAhZSIlSiNAZXN3SK+x0USfAOrXUFqO79a7GtGpMhaYVVxGY+DHWMzsmVzEuFtvg6DevsHLNezPmvoe0SwXBSCVbvsnb2H94kq2jVoOnDXkVoKIlmLPDd82QrLCCxJwZH1OM33Oz9PKw8swQxg93ZAGyr0+coVLhM3aYSPp2mJr5+9LAy8083CjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80HOw9eqypyBm2Znu4gDsA02PmnZMaad4QOjCLo0JQs=;
 b=T9ZGrNy5PrFaQflZTQiAb8Px72e6+Gynxc8Lrh4VF7Ye/XPjpRsoLvlajsztToUZaq275Ys+/9wuIqT0SeBDqxlfgi2LuV+xv/I9HPA3NgtKcwUZ2t27R/SMt+FXzqFFhCCrlH7O2nk+yTptXNbZCAxO6wJYVPMMQsty+fwmoBIMLsVpZ2JfKsPYLOZl8BtSKVS8mHTYtmxcpZNXEoogMrEqQZIkwksI9PwQNExa0K5PbOZ4wmXVOiQptKoe8FOeMWq/XN74QI2ENeUUlPnvlI1e7K+PdoNXYmFFntgrBqXUsw3QNOIke3NW10kuJ+mE8Ax8Vf7Emcrc6/ph/OLeVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80HOw9eqypyBm2Znu4gDsA02PmnZMaad4QOjCLo0JQs=;
 b=iuDOzW26/Np8JbGLqOnXlt/A5IdWjUdtNlT6nqRvLQ2rsVC67dkHMkerIajBv8qYiyUbrYq31nZJQbo9VmzNO5nYIfAkdFeGuvlGL0zeJ2tp0TKU3ts7zgoOmQPAfXlWe8rgtaW5ETtHN/lLpc4GgupY7dPVltMn5a81+/Lu7D6c+ALe8EtPv7q8tWixYoyOGb3QMOY57zlli9mQ+I2jdxyPafNb7ZMY+XndnWHgqqOcsHXGtyLBCiKa3rnBOE3cFko8sdOu6sBMorYtFbO4LoycJFXlWsJnDStnasp+oZ3vk4/KJ4N86KVavzvBstfzLF9+P50NT+aE3ep2v7HgdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CO2PR01MB2134.prod.exchangelabs.com (2603:10b6:102:d::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Wed, 19 Jan 2022 09:28:14 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::110:392e:efd1:88d0]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::110:392e:efd1:88d0%8]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 09:28:14 +0000
From:   mike.marciniszyn@cornelisnetworks.com
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: [PATCH for-rc] IB/rdmavt: Validate remote_addr during loopback atomic tests
Date:   Wed, 19 Jan 2022 04:28:09 -0500
Message-Id: <1642584489-141005-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:208:15e::31) To CH0PR01MB7153.prod.exchangelabs.com
 (2603:10b6:610:ea::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb08286d-14be-4454-112e-08d9db2e049f
X-MS-TrafficTypeDiagnostic: CO2PR01MB2134:EE_
X-Microsoft-Antispam-PRVS: <CO2PR01MB2134E1CEF3BAB2717537E07AF2599@CO2PR01MB2134.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzmkONB0eYoJqUmdn/RF+doX7iU1A+eikxYaFA3CV5sQPZU7c1yauTNiJGxgE9/6fOYjvWRQbR/QlELVjg8Dq4RPPcNzSxoQFUpMX048F5hDgTHoB7l4ejMBYeSt9K+iPJz2WcwmErtw5t5yTlXJbOygOf3UompKNeo5C83h/MhiGWNdlhy3unwDlZ74Oghd6YSzt7yF92KV4HpQbb8F/kEcpom7HfBI1cwuDxFQfjxzke4s9YcCLaj979rDjGGFHio2NKGoQ30oPnbNv1cQ8Vsqr2QV1Cp8QO5IdOlbcmITVJMv+gd4Tvz+1X380vc7fRPt/sO6qo/Cd4vXmjohESAinhj7QWycoGFzmOUYd2vXNX7fFGS+jw/QV9GZcfgsGGAn+y3wPnzf3FSUSzynZAy8riN+VMG0Qnm3sicIKECIUQevgsNc/ejkSNH8Xm1SqWso9UpZXKORwBIlPNBd9aXYartwqF9/aVHpCQQNO5Ldk0VqOvCx/OraEVKzqspdXdlpSJ5YpTO+IBQO1qlfHLYEERa3vSgF9wUphQwxPWv0mQeMaUR6khZXA2Q/P5rain3OrRf+Q6ueqyJkD+udLnf97dMoNhzmXNcy4X+V4cRxkQbQ7Ys5f6v//H902lyNxmmIRSgHxH/sjNryR3oKxDzOGHYWlUwnXwAEmxxdyoRroYrVbryRWdDbm3bLYYaShuA8YMu07J6X9dqOBGGCNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(366004)(396003)(376002)(136003)(346002)(186003)(9686003)(6666004)(107886003)(4326008)(2616005)(6512007)(66556008)(66476007)(66946007)(86362001)(316002)(38350700002)(6486002)(38100700002)(83380400001)(26005)(15650500001)(6916009)(8936002)(508600001)(36756003)(52116002)(5660300002)(6506007)(2906002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8gjBTBUJ2Tn4ubjXu473Z3Pbg6PIpgcZxXSm+/V72oICipNiGwTCK/zQWscj?=
 =?us-ascii?Q?pH3FVDrdvegpyNl7bThGOHyJPczWGgtMRaFV7yFtQHxwe6nul3XxGxRVBKi7?=
 =?us-ascii?Q?zoJiCCHSHpfxou4M9Oz4xrKO2OS5dd/lHXT9cBTNWzrNekpdpH7N3iCondoO?=
 =?us-ascii?Q?a45yEOYaG4/6c1yQEwQN1m5C6+Xkb+2R7tyim8CmN2gW3pQBUYQ9JqlV9w0B?=
 =?us-ascii?Q?ZGuXjIz0c8Sbf71db3RSBX9s2pCIJJGY3+Y/FI/6aH2W8PqJyu4TRFaBO/Xy?=
 =?us-ascii?Q?RRTRMubf3JhP5gdbXkKU1X6rmmvBf1opB+IxmNl/0OfOjRWBRtThtL/6ks4J?=
 =?us-ascii?Q?ZyvKZCaLWBwnZ90tvHHDk7J0LYOhY2pLHsHg7GnYtEs4QONyJXOZyOSfkrfu?=
 =?us-ascii?Q?MiRKTLy8XzslzQa/sNLGeuiC3ugsoBGmVdWx4lVUv1P91hnZPRD5Xtul5Pit?=
 =?us-ascii?Q?cj19isPpv+af9VQi1qSjTXKXgxqyReddr4SvlNLLaPba4ECNTbW8dpOevu5I?=
 =?us-ascii?Q?4ttIYduDULJ5L+VgcjMpHLQCKazPEcEVIX2XMXCGqnMwfwsoxkMnYaEEWFvo?=
 =?us-ascii?Q?/fvaZxF6DgOR3ynbMTnTmqiEGJe1kCLrln3os01NcdonWxFk4ntK9iTD4R8D?=
 =?us-ascii?Q?9JP3udVduTNDYaulgX4SOCLEjFqTcohcKU+BcwEGwpQ0nyrdi6SVobNQ3oic?=
 =?us-ascii?Q?4LNzHOY5c51FQe07SDZiKJgULWqFotmEunD7aRV6EBKkuEBRjfGdDW8U82sx?=
 =?us-ascii?Q?GtPaP1ISP9i6ds7jG/kuMYjdaGL6FErJIFoiC4As8alic/cJB52ujbv946RY?=
 =?us-ascii?Q?eF6dQmYEodDo1AKJc4tEKpz+BfDKlDq9YBLTLtblmDp7tAJPm9rJYSZp+4R6?=
 =?us-ascii?Q?tBxbp2DsLObV1iYo725Qhoz/YVFKFwjsGHrccKeC77RCnWOFnxwlDep2eV5j?=
 =?us-ascii?Q?0tsKYOyFmsT5pG4bZjocpHPHMigK5atO0logbJGrkvqGaF5D8frPG3kPhlBa?=
 =?us-ascii?Q?QdPIQNk0ADZAWUsd4JoGU+LuJ0Ym4P8DOYBp1L67UrdWYf/8+yWoyzDNnkjs?=
 =?us-ascii?Q?fMR435piVD3yMbXJWFC0LIR5KQYobvXG/psHYvS8MzGyxYNFmZT5rWD8fdX6?=
 =?us-ascii?Q?7qTvtyHBhZ7CCqJzqsby6tNRIE4kD94fU1u2RVzKTvjcPBV7C5qnHJXhNjNB?=
 =?us-ascii?Q?GEs2Znl8ZHXcq2+V5vAt2W5TZ6pgmkqdnbvL90STNOrvE7XyyTmAD/hVcLWW?=
 =?us-ascii?Q?Su0dZw9U0E4AMSVOjbSILr86hqFIYnY1bXsh+QXySEcEBvT1f7nwo2aqAmYr?=
 =?us-ascii?Q?OeVa4VhtyxmfIGRgPa5nCjYVF51C9Sxk/ElZnMkGz07VydTJwsEtqmlWtNJt?=
 =?us-ascii?Q?ozKXsyYNFxwfv7k3wpZWMfaPGrHdXnF91vTDAszfgHbnGk2qie3WonrT0a/7?=
 =?us-ascii?Q?Qs325NKr+bEnoti8xzAEh0ZulTGB3KZOnYpZLIZduxFQdFJw5k9j3bv/Mz5M?=
 =?us-ascii?Q?XE/Wmk6tbA85Zy8gQdb5zpMx+cGuXxvD5EMQ9Q0OPMG7BrSa58ifZl0GjrO8?=
 =?us-ascii?Q?5eFdJXy2x+cqa60Id6SBEugTYu+BDpL5aIXLgkiXgV73BojcSSDmlNWZmj1x?=
 =?us-ascii?Q?/6cDeYULxQRW+MHjunmeyFHrHNvJ3C+QXRLWaKqQ75LExuMjIFY3gNDgIEHR?=
 =?us-ascii?Q?cjj+cnIoGsnD2UVt1pgUFvCj/KHrOv//vcWbXXvvgwj04Qm5Ac523nQ4teXC?=
 =?us-ascii?Q?sXa+UFm7Bg=3D=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb08286d-14be-4454-112e-08d9db2e049f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 09:28:14.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlNh3Qt38CQP/7P0XZx9pzmD1I0Mdmo+qxvDWwsV5xk9NsM0xWnWU9UjE4EBC2rfN0/8sxJ5PZ03DWcus+jNcqRg+CHnnTM8THzEC48H4ucyieuozb/OAvrn9QLFEDIf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2134
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The rdma-core test suite sends an unaligned remote address
and expects a failure.

ERROR: test_atomic_non_aligned_addr (tests.test_atomic.AtomicTest)

The qib/hfi1 rc handling validates properly, but the test has the
client and server on the same system.

The loopback of these operations is a distinct code path.

Fix by syntaxing the proposed remote address in the loopback
code path.

Fixes: 15703461533a ("IB/{hfi1, qib, rdmavt}: Move ruc_loopback to rdmavt")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
---
 drivers/infiniband/sw/rdmavt/qp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 3305f27..ae50b56 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -3073,6 +3073,8 @@ void rvt_ruc_loopback(struct rvt_qp *sqp)
 	case IB_WR_ATOMIC_FETCH_AND_ADD:
 		if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_ATOMIC)))
 			goto inv_err;
+		if (unlikely(wqe->atomic_wr.remote_addr & (sizeof(u64) - 1)))
+			goto inv_err;
 		if (unlikely(!rvt_rkey_ok(qp, &qp->r_sge.sge, sizeof(u64),
 					  wqe->atomic_wr.remote_addr,
 					  wqe->atomic_wr.rkey,
-- 
1.8.3.1

