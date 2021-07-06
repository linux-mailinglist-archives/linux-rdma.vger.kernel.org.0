Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24733BDC3C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhGFR03 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 13:26:29 -0400
Received: from mail-bn8nam08on2108.outbound.protection.outlook.com ([40.107.100.108]:3296
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230408AbhGFR02 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Jul 2021 13:26:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrlZcmUoFUys1mGnb1HLGdhtFLtPsBMCWiufwjZ6LhckiinSHA8gd/isig5zDNWJCaZC4u3Eng+e+io3oTbO5xD82aU4AR4BJlJkgNfnNck6AClT1wQqXjP5uJ+O8s4Y3mtQLKfTtfzZ5Q0V+/Ei4nY3clvcnxfKxO8nXP6yHBWXZAzpR66R5+bcD1lojRzLTsad6PYuDSAEHcoDpoCfeXZTrsm1EU3eOCA/adveOJVnffm7z9/bu5jC1kDrvJuBZ/WSZqJ9peAjYLQOyShoZtR024wVDOEaLqH5bHLkH9uI4RE0TMnjKxjJlzB/zHIrasQ3FU7SPnOZC6OTuoAGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKfEK7L2nNqi9f2OMG0ucDgYjgL/IB1HuU9jWgK7IRE=;
 b=X3zG8LH/3jvny9sDigQ8lbjptlssS2zBAv2WH3L13MV0uxkVxXrmw8DvveJmGjQsuzZ8O1B/gk/qWGeKDsBB024OetVuMHOQ6s5nNQ+KZt9zNLybWpzamgPuOj9ow7W11Z8R7M047MIT8hdplwNYpiEk6qxLfljLJG+q8rPtXQC6PhnFAAP9JjUz+dWypc4en8wnw7gAp/l3yh57xZgdcLnp7zYH8QUXwtxs3piBY0d4gR2M1b7+eIHMQk2KiLZlMK/dn9f5yDj7jjOTF/aeenG8qRVjIjzvnNUOlwIH5FqfhHdxNx2w/GYohrYaOIB1x6P1Wh9I63Y9FI0w/JaZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKfEK7L2nNqi9f2OMG0ucDgYjgL/IB1HuU9jWgK7IRE=;
 b=XSMN0sL2zmCV+Dm+yX7x7+5u0J+TFT8I6vrb0K12c1WE4wxjypgrXBdSibSGeeJNdPEZufybd6rMfLVuoohMiT0cWaViLdzIObwrMWgkSo0wd4Y1GbWVy8t6P161fQ4aiyPWHc+iH5FnDpmRANGWA7bc4oTE0r/GKMe4/Ub7jgQtEtmx6BW8mOfQfP8+TdYD0REg9kaqbiX9t8gurKb/B3w74nE5MAqVlpc91z6RxhduIH9b3B0k1BRxz/5zJWzxjGgTP0F5im40l3LkkztDJgVs5yRNU7oXl6AjOHFpieR9jKAvtE0INFs0/TbvO/V7nrrDG3ZlD8YCL5GC7/2h0g==
Received: from DM5PR10CA0006.namprd10.prod.outlook.com (2603:10b6:4:2::16) by
 MW4PR01MB6275.prod.exchangelabs.com (2603:10b6:303:75::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Tue, 6 Jul 2021 17:23:46 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::3) by DM5PR10CA0006.outlook.office365.com
 (2603:10b6:4:2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 6 Jul 2021 17:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 17:23:46 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 166HNjQl058971;
        Tue, 6 Jul 2021 13:23:45 -0400
Subject: [PATCH for-rc or next 1/2] IB/hfi1: Indicate DMA wait when txq is
 queued for wakeup
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Tue, 06 Jul 2021 13:23:45 -0400
Message-ID: <20210706172345.49902.10221.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210706171942.49902.72880.stgit@awfm-01.cornelisnetworks.com>
References: <20210706171942.49902.72880.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa50bc8b-8094-499c-c78d-08d940a2cfa9
X-MS-TrafficTypeDiagnostic: MW4PR01MB6275:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR01MB6275BC4BE2032D963814835DF41B9@MW4PR01MB6275.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iv1NKRumdoPPZOBQbbGYGbmf/9x6bBqVGmSWEyGSXmH3cDpNeselYExbYgwZyWVDqVlou7OK1XP2PoVfbKgL0bnw4Glh6dS8yrZ5bfXqFLYQb2nJFoQO0EK4m8UHvOFu848p0UtSA0EuTRjullmum//9APtZxYm0DJnZD1VxtFeL5mFBlyY/5x/9y9yHnbEXwVC/fbPhoWkKXbRg25FerHRzbcdG4cr3jybZyAGd5NVvB/k1VQgoJStD7/GaXiuhGjUpBi+I6kHfPfSweNRJbnn0gDioWtdN3PCaEx3ftbBEikfgWqJ2DDoKAzG1PjqwXpW5wYy5nkBbKx3W3V5Ld6oKcZiISQdVsjhy6uQN+ZC+OHW2Ik6tFlOdRwb2iIV9q9aLC4I+2oYc8gv1KliI5b57ptJCApdALqg5zrai2cOwTJltHVAOCDkhEx4wycs/7U2mZWbLdxYKBQFOrusukkfjFfJe3Yf6RaYv4E4ZfXOI5ZfK2c3jg0AMseiOdw3t6CdHegunV8d3wYk4FPYSwnUlFJhlO0+v1x6jzq2CuQ//+smGxFJGJpQ4PqQXhotD5wvRTyEftZCDV9YesrFoidQNw26Sl5Uy2MzIfaRml3V0OA8W5eRN6r1MHtxFP9W/oDSsn+EL/NRl1/JuLfKs+A48xPthX6aJGTMaT51OKck43l4x0ag/eyC9Z+ILQdFX97TPtRbUuUSyFk8VSbSFaQ3OLeNVEY+/6ph9cvQK3qnOk6XQ5kggOUfNHZWiKn9OwHv00RtbDP3TXs71HJwi8g==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(376002)(346002)(46966006)(36840700001)(7696005)(1076003)(107886003)(70206006)(44832011)(70586007)(8676002)(26005)(103116003)(5660300002)(47076005)(36906005)(55016002)(8936002)(83380400001)(316002)(186003)(426003)(336012)(4326008)(34020700004)(36860700001)(7126003)(2906002)(86362001)(81166007)(82310400003)(478600001)(356005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 17:23:46.1816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa50bc8b-8094-499c-c78d-08d940a2cfa9
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6275
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

There is no counter for dmawait in AIP, which hampers debugging
performance issues.

Add the counter increment when the txq is queued.

Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
Fixes: c4cf5688ea69 ("IB/hfi1: Indicate DMA wait when txq is queued for wakeup")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 993f983..e74ddbe 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -644,10 +644,13 @@ static int hfi1_ipoib_sdma_sleep(struct sdma_engine *sde,
 			/* came from non-list submit */
 			list_add_tail(&txreq->list, &txq->tx_list);
 		if (list_empty(&txq->wait.list)) {
+			struct hfi1_ibport *ibp = &sde->ppd->ibport_data;
+
 			if (!atomic_xchg(&txq->no_desc, 1)) {
 				trace_hfi1_txq_queued(txq);
 				hfi1_ipoib_stop_txq(txq);
 			}
+			ibp->rvp.n_dmawait++;
 			iowait_queue(pkts_sent, wait->iow, &sde->dmawait);
 		}
 

