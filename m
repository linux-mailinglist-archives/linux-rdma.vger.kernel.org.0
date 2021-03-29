Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F7B34D1F2
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhC2Nzp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:55:45 -0400
Received: from mail-mw2nam12on2105.outbound.protection.outlook.com ([40.107.244.105]:45024
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231639AbhC2NzK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:55:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPDpLZUFQ4wOKkJCR1dVlJQpeHQPqEvFdpOomqb4S7ztuUcG5smDnjm0VifQaaoOOEmxi3mVUqD0Qqq6XPumgxEmQX2m1UjmPYibYkpv9tayP6Fayt6xAkX9a3bTh5adyoD0ToCgIqDcNlsMdvGY/yCstOPSc1UkTvr1bsTDX2v3RgHnJSmiWFt1Fa1coiNC6CJ29Iz+1ABRFc6d6KQ8T5CK8rvB8zHztp2K28k6PZxMfRVvrUEZ36QEPU4sEON7BsanTspHDD9F9z4nfRbUbnoYeBTp7VlTVQosVWczfR7x5bDEYpvucnXVByB82rgBoh7eQ/aqXcfQSQV14mwNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NzrF1Sqv2HWrKDIDpjb29M49Kx4F4GAB7lXGc+tvYo=;
 b=LfGoyd4iRIHq692hhGHxZGgmvtNxGoz7ZP2Y7qbd5wFvq9k2YeShKdcZJrQwdbfMxki9QSvRetUQJ75lCbTae3MI+ZDATARulV4GeudOHlOMKRESid9AgqdAXErOiy9kqC3gf2Rb/nI7GkqmsSjS1cCDHBrFME4CZQMyNirU8xyVrsbVTx9ON0eP0RnvSs12Hp3PGWV2YaLKG5p1tJBIy/+hNiNZ6BIZ6MVXw2d9Hy4yWzrbZgqgmEEdHeSv4VCAe0GNWLuw10NNkiUL1FSYBWFzUGk8Uvo3ruDXlQzTqKWEGmNI4gFBYiLicDA30XpEsfoJE+qDDoV/Uum7cOZ45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NzrF1Sqv2HWrKDIDpjb29M49Kx4F4GAB7lXGc+tvYo=;
 b=UNunO8kHm3VQ5WSSCYTR5QpnOrbkc77pXdOoeMn5WMuLrlLyq/JsQqtj2EkJiXD8Eu4QYMxUHo7I4wL+TRjp69cGziR9uqRLqpu9Pb9dUx4pl1Ej3UEWkTLEsM0fViQ5GVdYE8TV62OBBzDxm6We+T8aXL4dEuHyxo0MTMqIPOG+HEg3ZUUSrwb94/SvNsMXPLziUEex+0CcMQutC1FeO5n9t4oDPxgRvpV0BQkLcyVZeyb0vWzAVZVXrePEip/R4smGvWO8L9ufKXNJ01SNoC6T3g/R279S+2qsGygW0hvnfeNr2u2JY130gzhbObPRkq+yWbH39Iyq2MoUnFsVSw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6729.prod.exchangelabs.com (2603:10b6:510:97::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32; Mon, 29 Mar 2021 13:55:09 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:55:09 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Kaike Wan <kaike.wan@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next 09/10] IB/hfi1: Remove unused function
Date:   Mon, 29 Mar 2021 09:54:15 -0400
Message-Id: <1617026056-50483-10-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain
X-Originating-IP: [198.175.72.68]
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 13:55:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 665c120e-6320-4557-e05a-08d8f2ba43ca
X-MS-TrafficTypeDiagnostic: PH0PR01MB6729:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB67297DD152A847104327FFD5F47E9@PH0PR01MB6729.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEroH+/hNWYoIfkn54u/vGblnyJQRaUH/wxXTYcA5XdrPFaHm+f8QEw4dnfgTS8cpzwDnzLw3F8h0fU3Xc4oTw9xTSwcWADgTT8osXvA3Dj0pBevrp6epsB+9tAoqJrLdgQ15uqNZyRNoxfbPVV9NIAKJF35FbB/jntO0DrHQXhGq24gKa88+u6KURYjUK0r4DPJ6pLHE5owM1JCrbOSf2SkIWjMgJ5LM0hSzTHWBYmkyt1AdGhVtOE72NR9lAGOzZCgXMtD1xkhx5gj6F3VXXT1fwuCLVoj8ENG9Z4gQhSnqC4EdB7WOY7HlgFmWCNKZ0BpxPRdryQXJ4bese1BHeS+CQIfaP4VVflJVzZloHYNA3NO+edIXu9327mo3Cm6Pc0IjIAxaYTqsg9AN6a6C/W6oPUSm+8Nwy01BoNdCWZXNkQSvR26pkkB5pzH1mr8MCOMvxTU0Cah8tCUd9SQsTv7s+Lj6AWy+Ue6hj4YKFsfV3naLBKDbk3sUSORxFrFs1jMB5jKvpFE9v97QbDtm+fbGnA1ZVVfSTtSxILDI/0sJcs3jgcaMTDYmgXBkpu8R0Rvd1GwmqkI2dkgBLNhu8Sd1twa/Jgzo8+eATVHVc1bEpzf5iq2fXe7iOfYYmBEkr0Gw7a7fDYc7lW9HRJs+zgBguEm8U0M1+pE5lrJWU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39830400003)(9686003)(52116002)(8936002)(8676002)(6486002)(38100700001)(66946007)(316002)(7696005)(16526019)(186003)(2616005)(956004)(66556008)(4326008)(26005)(83380400001)(2906002)(478600001)(54906003)(36756003)(6666004)(66476007)(5660300002)(107886003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C0C8zxxDq8X6QN21FRmttYJWfCKoKFJJugpyGBSRcSoT3uHWa810TfrrvuJH?=
 =?us-ascii?Q?jkL2fADuTkOAIKVNd1m+47RH0TrLeQU/KC9b5ejAQ6gq+YnBJQ24+/hWeSE6?=
 =?us-ascii?Q?TeTrZ9/ItGuELeDMAG+bn5+El69W8NKKC71qOCzGiDNkLaBPK5UVj+BjsOiZ?=
 =?us-ascii?Q?s0KC7FsHQk6dgRqSvJPfAWfmRj/NIiCsOv0xP+5LQ7v0lF7qdgeTWo0al4Gs?=
 =?us-ascii?Q?8CoE8B3laxGwyfkjunvACQ1e3jtVzxu/hqjbvmuP5mQU0YNRIaWDwyRZmDty?=
 =?us-ascii?Q?nyTa8/u2R7VVap0Am9268sdApZRJtx/D7dV4f3Ay7bc1ifqTln4IpKLs0WjV?=
 =?us-ascii?Q?vahE2OydRCkhWZImfzbceHK3rmueFvvqTxaPENqUh6DuIi4gQ7nmvEtXl/UF?=
 =?us-ascii?Q?vzLKY20Bx2xFx1KzOsVh2RNcDR9joNTXMYmHObTVX97sE56f++DcNQIE1ZR1?=
 =?us-ascii?Q?nVXvQADX33wNmGWTWQ4+x5qWRv0ge10oVBySrs0CqBrxcQqoo2bKJcNO9LBQ?=
 =?us-ascii?Q?rx+bI7GqFqj1Nwu6h1paQleNR/642dfMO6TC+KkO5pBf39q5sQbmjBOFhQxt?=
 =?us-ascii?Q?AJjGtBnpc5yGt9PDwUvLZDDKTfmGeMbDVr2zJ9IAc9z6tUlS5d1ipmgzy9KN?=
 =?us-ascii?Q?AyMIo52l5j0ts0LqliH3Uf21UpeOWiWi52AzbI6EwjcI5i5YBAbReTUCapbd?=
 =?us-ascii?Q?EF1m07Ry5VLJvfYElbEyJguEO4hzXvD/UqSYrsBK3mMYscwzEWElwFTdolTj?=
 =?us-ascii?Q?GZnsjmi6xsTFW/bVSo9JCrYxaUUFrAnoB6bsAH+tFfpU02xSgmWerFev3s9k?=
 =?us-ascii?Q?3uVndI28EKVi7FrPIRVQNFXUd68mfgHyAx5yMFnGgDKbzfWu/8S/zoKlPR17?=
 =?us-ascii?Q?NlCyniRc7k2HC/u/eU20sVHLynZwEZGx2E0QwriJhY0tCiVArSHRrPq3bzu8?=
 =?us-ascii?Q?uXi+EwWT9RC93mRS1CTPzuZOOl0BjYBe74fk5Wrf6l2Kaul6bTee2iR9mNMl?=
 =?us-ascii?Q?nlfwzVXvOaNbD8y34Hv5eafk++xz+ijwsB3VVnNsYgv7S7XxTDlilwZ8QmrY?=
 =?us-ascii?Q?QcYPf/XLiO6eRhOD6rhnrYn71HbUd2Pho7gTptyr5UPNymzj3+7aGxBg/Kkn?=
 =?us-ascii?Q?Qh2kvAaVM6QyYT6nZIS2iknwndwQ1TV4N8vaXCzJESlMuI9G65zkVL5tBPx2?=
 =?us-ascii?Q?o4dcm7cVDopGh7FjHrd5n85KL9Td+yzxy2z7Gc6YwbyO16Jwoh8V4Iph+KM4?=
 =?us-ascii?Q?srl4Z3x5vgltmAMNBjrRwu3ccHwF3S0ggiJXXIGjX/4D0960UfiETDNRLmhf?=
 =?us-ascii?Q?RbHHn5boLiM58rwhKW3r8rEo?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665c120e-6320-4557-e05a-08d8f2ba43ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:55:08.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5oGdyqvfNiRYc5Go2q+Wrurx0Xa5R06L0SHHuPtaEmJlZVhlrPs2VSWnBUi5andwCTyN5L9T4gtJ6GmiDRbzIvcA8q0Gdtob1odbtT/rmvGIZlXYFySCv8Wks5tJ5tx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6729
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

Remove the unused function sdma_iowait_schedule().

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Kaike Wan <kaike.wan@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
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

