Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E342034D218
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 16:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhC2OH0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 10:07:26 -0400
Received: from mail-dm6nam12on2122.outbound.protection.outlook.com ([40.107.243.122]:28775
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229822AbhC2OHI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 10:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZbcWhvifn8bY/+2I6cZpJdBHp63s/8/0LmCmsXOJPZ+vHOrRGLg+VjPGut6rOyJE0hj2H3smzHGvJvf4M5h6KAF1FL1lfjSHlawpxSiTO4MdxCNjdaQ7zIZWbksUqtpE0pjLqaNof3hbMF8S0dzSydal+LhWlgEp0zvYI5EaYMjL7tpoK9hHYxKH/mUNCg26c5FydF/iuwabQBENzuTwumgt2avqOEiS3Bm9M2z5xEQ7+I/TAdh67oUCgAEfK3oaM5GKm5ixfCribsxF4MsTuwf5XM8/oksXlZvsbdMYRSQzUaAlbQPi0nEZEEMcWRl0/QlusJVFGHjo5UdvW5fzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1zVsQxI4j/X5FP3zk/2ewDUsYymk7HczKlwEDo9JlU=;
 b=AuTE2v/vk9QWg1Tt7Nn+9zQRqkH13Cq/cfJIMsxqHu6sr9N+Wrq3UFgXowKqiCIuWUeQe8USH8IumOrMerHDeROBBZeU+S16me5zokxtF0JiiAaFgkskckyhgxBh8nne45uitp3c7O6mLTIGjir4mxxQGfMNp9ayNbI2OMoE2FPhbRcrYopUU8nwAcce0fhfgzUj9h36FXtVMeR2yZ9qTfk3jupKvOE/lTDfC9Re36UmMu38jxb23WQpKh9+TxvYgMM/n9znwzDVYjMWgVlXD6oROi1oesifKp0uqLnfvTI8kEyJr6Y20ID6ttOuyA7iRGgaWDJ5jZirmpOgWBNmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1zVsQxI4j/X5FP3zk/2ewDUsYymk7HczKlwEDo9JlU=;
 b=GfIrun3ssml09WNroTDiTYiZ1UIaJ/rHqQLrf+It2YDAOBhJg5dTSWPQBoYa168qonR1Vo2WDz3A5vRM1Ld7Ao+764gJUCscFpGCApqKTa+QQrx+TIpNbGn9zlZv+/WSdqXdkJrzzK27qh5NgyWIQOucolxLO6oGlDm/1VMIdIVt3L+Pon+vI90EWF3xZsdQ6ZTin7Vp7wNO+y8aBvQncaiG+195maA31Gkp9CLHN4tGfY07BtnRpbhsrYIU1z5pka4+qb71b73bBtDU6/WL7zJmqOabFWjhme2/HWFlRgWCjz/OGnjfcPgnNXEfj2HRDsrDFq0jXoPL6YKGtGFnCQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Mon, 29 Mar 2021 14:07:06 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 14:07:06 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next v2 09/10] IB/hfi1: Remove unused function
Date:   Mon, 29 Mar 2021 10:06:31 -0400
Message-Id: <1617026791-89997-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617026056-50483-10-git-send-email-dennis.dalessandro@cornelisnetworks.com>
References: <1617026056-50483-10-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain
X-Originating-IP: [198.175.72.68]
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Mon, 29 Mar 2021 14:07:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ddaa41e-9563-44fe-ce22-08d8f2bbef24
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB67614063C0078D96B81FABB9F47E9@PH0PR01MB6761.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGAcSZjNs0B8mouZL0DN2UR4dBLo+WjOW8cu4FNAivgwXu197nfKO/cwZ57TdLzKiNVetooIj6AtQaZjNAFAOeBcUTa5ARlQ7NGI+bj9RJJf1/wLYLJOywRJJ/bqAuMG/26q9owMUiIGwQr6/PLdlkJsuaOaHKnFdb7nNirW+gUo5XBREY4ICgREkmRJUS+XY4reDTI4zs0dx4bXeE9Y4RF+XAiJzbg2fa29FWVrPgWviD8BO7VpU3kIiKX4EdNAnLziMRGval6O1GoowtAWeXPDCq9Iy4LLRXRIn28fa5d05TCyKbz15LpMZnaDUoVBS7pPfQ4warHS2oY+o1AcTmmnQufSP8b27SzRqs/2zxLCyHc1W6AuIAAkS8iLSWLRc4PRXhvESJjXJGnS3Dq5Z2A+xTJbP+3UHJ6JiHlR53GFXn0IJKJioR8sCryBHc9nh3tT1RX15xLjBaQESmFJsoN57GT4L52NcqObxmRwEjC9wAlk+OK/S/A9QvikHMaU1oEdiHI3jWBOHpP252+f5KIXy1J5ox9KjV9xS1IsA/dtmGO4IaV0bdn2E7FdX6MaT4qYmGzPhrwYfPHRBoEr0csCLqSNpQoLWWwWGR3wVrPn4yYxlB27DkUe9CjpDnanuIMOZlFJ1uWKrh5ii/lAOgf6rl8ItySS2gY/Upeav0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39840400004)(136003)(396003)(66556008)(66476007)(83380400001)(66946007)(38100700001)(478600001)(6666004)(9686003)(6486002)(26005)(316002)(8936002)(36756003)(8676002)(107886003)(4326008)(2616005)(956004)(52116002)(7696005)(16526019)(86362001)(5660300002)(186003)(54906003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?deX0Z67xfCvcqFWdT2EY3tUjcyf7Lp9cGzfx5kIWtijo4suZz5tUH/4SmnRh?=
 =?us-ascii?Q?uTvqYovGumztsCiz2eHUOLpLtGhMY2oPdO0220jCIbWtrUq0I5MgHSyCGm71?=
 =?us-ascii?Q?MnqEtFRTnYBO6ad2UFyZB/ttkQVtkCd/PZbrNyuUMI8aIdbciNS4Dz2S+pmD?=
 =?us-ascii?Q?dYg8i72klxyLPAu0y2yhJ9vVTRPuNbEGypAnvoq5Djvytuy+g4Pxh8/BqE6H?=
 =?us-ascii?Q?sF9ZAI1vkBNxmpL3+yDt557cT90lN5e4RgBQbIMIRWfBDgf6zOGQCqeFPnTc?=
 =?us-ascii?Q?2UFs2/Ige1CVcFcPlwFH2IVX9D5vNeJQALXpypGEwNwWuGS78wrafYFR5yRF?=
 =?us-ascii?Q?zs8pNbj+dnorWEAfNdCxBZ2mUpFdDJcrzvK+wp7oaIThYJnr3ZODIOcGOaod?=
 =?us-ascii?Q?DuiuN5OLTI33hkyo0jewkcBI0dTI9fyLXN47H/5foBX7q+R/++BnO3rSZugS?=
 =?us-ascii?Q?5k0UIW2D7a+F5OO++sTZcfCtNSN43TLSwaz5JUa9FGYJKb0MmLj6X3vrR53f?=
 =?us-ascii?Q?Y+6xkSSRJhgX8+4R3fauuS1x5wK/hXdt2i2/CYyTySgVX3SRUbevmeKXGOp7?=
 =?us-ascii?Q?UjoJKouriLqg1xh+7zfmZ0MNaZLxThWNT6H7HAID8I2EO5WXU10zerYDmye4?=
 =?us-ascii?Q?oSmo4XgoR7HcDglAYkSJhHUnjvNz+FdpLbAr8EaU83Q8FfPY8tmaxJrbxFTe?=
 =?us-ascii?Q?8Q6SWIwcH03BJLfk5JXJYIdKGzyvGqJO0YmXnhnmQgGeISa1hXdYtPLj13IJ?=
 =?us-ascii?Q?gl9p1tmqjOpza57ci+Ht+zyWDUNOByRX+r1AEqmV/cqwwruyKWK8G5szpaSh?=
 =?us-ascii?Q?U3Vg/EmvMAI2RLpAtPmKlz7zzHi4gCn7+NWKKzF4qoFJBXSOltCwlbVcLzg6?=
 =?us-ascii?Q?LR3X4KcD7kmhiaTkTwT3Vgq115DqlF1mH34qe2nRU/LPEF7Qv3cw6h6mF4JH?=
 =?us-ascii?Q?w5OOS34eKT9E0KRsI2qN9mJdhGSOj2sXfGbenrD67keIVFK7euQMOGOVJx9J?=
 =?us-ascii?Q?prcszG8HC+iKffEYmVdZks8DcQNjaAASd2QUEHqdy0ZMdwxMPbX5YXd8pZDU?=
 =?us-ascii?Q?cVmt1uZ1P5U1X4PmweEsSJtjnfOv0WY+MpReo3y3tvYPEUJjCw4nBuWXbkF8?=
 =?us-ascii?Q?bVh7kcSxEfQf+4SCXMSKQXvjFgndYV5XlD1rV7sIJTrb+akUwY7euPMxdt1I?=
 =?us-ascii?Q?6trU94QWHdKgg7P89Yoi1U3yVmJvwxjGHaIsie+MPzZSTPq4KdleMc+H8Y5o?=
 =?us-ascii?Q?1bWtqQJdeA4YNNu5/LVTEm6V6BOnHXy3d22NvSe3sKxQ6f2Bh1gL361SCzaw?=
 =?us-ascii?Q?qe3GuFh/frv8IvOQgB4HWmsc?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddaa41e-9563-44fe-ce22-08d8f2bbef24
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 14:07:05.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIWlEyVCDMTDq0FEw4r5xDoEfA+EXYFXi1vU3g6+Y7CTh8sOuQF5v3stmaCoHouDg4xK/X/C4AvJntMhmsfJNBB0morjgDVNtZ/y9pIHZlKpQV4MvJiz5+PxfsQYP9TB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6761
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

Remove the unused function sdma_iowait_schedule().

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---
Changes from v0: Fix Kaike's email address
---
 drivers/infiniband/hw/hfi1/sdma.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index 7a85119..f57d552 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -907,24 +907,6 @@ static inline unsigned sdma_progress(struct sdma_engine *sde, unsigned seq,
 	return 0;
 }
 
-/**
- * sdma_iowait_schedule() - initialize wait structure
- * @sde: sdma_engine to schedule
- * @wait: wait struct to schedule
- *
- * This function initializes the iowait
- * structure embedded in the QP or PQ.
- *
- */
-static inline void sdma_iowait_schedule(
-	struct sdma_engine *sde,
-	struct iowait *wait)
-{
-	struct hfi1_pportdata *ppd = sde->dd->pport;
-
-	iowait_schedule(wait, ppd->hfi1_wq, sde->cpu);
-}
-
 /* for use by interrupt handling */
 void sdma_engine_error(struct sdma_engine *sde, u64 status);
 void sdma_engine_interrupt(struct sdma_engine *sde, u64 status);
-- 
1.8.3.1

