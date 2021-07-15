Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3493CA1D4
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 18:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhGOQHg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 12:07:36 -0400
Received: from mail-dm6nam10on2120.outbound.protection.outlook.com ([40.107.93.120]:43233
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239701AbhGOQHg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 12:07:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHxQbbwT+yUhg5S0V2cT0B3ob6Z0wAc3quxdQkyea8swXDFRgX6wAu636OTa+SZA2pWDn1mYDBpA0TSo1GxoDCqQ2VgDZGD0euRTEpARNlkZefEBdw2S9BtNkP/Pgx2JaF/BtXUn+UPhI11tYg8nj/NKgbaRGU+XQE5/sMesm2FN58NGlnuVlESBBSxHSxcF0hquNRFzsCMamhVD7NO5zAZVKPfgt1yFFp6Y1YZoX8CQh2ceYT/KMr3etdnS20bFl0QqpPagbGVaiyLr3rVfVd/JcPiBNvQHRYAexV+CpQNtnhm07qjO134BWBCQTDW3tthXacz195W+zNywLxMQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvQXCfhbiX5vq5b4kZxUJSpCH0Xb0aoXiwpASEVi+0M=;
 b=GtjOW84d/T0ouO3/KtjB9PgaOghg4PWiA23SRvBEbBOwR311ZZFBegoUvXWYNnfKbUJZi6988FrG6ir8gp/2tJmh8XiTMa6FZnwzFHRYNf28faeIMd0YwfLfUP6hruoaewQX571YMaMCV28qLb7a9UowTPq9NINI6pOg7dO4ZIh6QdrRGBt2oV/8H2zs+xDDutUhmUrSSIFQO+b/Ct0nV4Mw9eugWQ3epxOH3rame7GBHuKGW4cXnOfKOedvvTCzoUmzjveaLKzsMsUQB4s11zH0RTmo9Ber1O+4Qp2LHuE63ccC6YZ+ZYDWQejs38ZPQjsqawyrrHo/A0pVcDlyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvQXCfhbiX5vq5b4kZxUJSpCH0Xb0aoXiwpASEVi+0M=;
 b=M8dTAKGzTYck7pDla0qr6HPZjPhCN7v8jhmaydzYwG5pVnOB1t7gOzsOGQg+c596y4CV2tsDA9C0gtIGYw6k2GbsvcYgfUkkjbQGtVffaDEMZPDmgB2VwyZP2Xg7vUiyFqlROvGBaCX3uary/kBciLS7fPz+CeNyFPl4zMJliWgHnDNyCU1UsKD2wec/DHjFA8CEJzDwrobu03xO3y1AOPpRGSllVfUAc7bHBuoF8NICdLcFhkhszjr1q6a9RapxZHVYhhalMj7xK/DzpBSBzy/jXogDuqV/8kL67rMZQTtja2UIh9fKU3zuuFVQkOILZ37nycte/NF+uQeU4awNnA==
Received: from MWHPR22CA0056.namprd22.prod.outlook.com (2603:10b6:300:12a::18)
 by DM5PR01MB2442.prod.exchangelabs.com (2603:10b6:3:3d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.23; Thu, 15 Jul 2021 16:04:41 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::6d) by MWHPR22CA0056.outlook.office365.com
 (2603:10b6:300:12a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 16:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 16:04:41 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 16FG4eTj146541;
        Thu, 15 Jul 2021 12:04:40 -0400
Subject: [PATCH for-next v3 1/2] IB/hfi1: Indicate DMA wait when txq is
 queued for wakeup
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Thu, 15 Jul 2021 12:04:40 -0400
Message-ID: <20210715160440.142451.8278.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210715160303.142451.38503.stgit@awfm-01.cornelisnetworks.com>
References: <20210715160303.142451.38503.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7279303b-b8ee-4169-b5ae-08d947aa415b
X-MS-TrafficTypeDiagnostic: DM5PR01MB2442:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR01MB24420CFA5DD54F2A0D1E3517F4129@DM5PR01MB2442.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6c+Ad94UHFSe2akmxmloztY1j0y1CIp+nKti6qaF6LRSLKdgsTqp6nC4hdT68o5eF1Q1pf34CjRHrQ7wYGXzqYlmv3C2IMoSgoJD9Vs6x42jId2rcPFb4fB23rbNb7jaFLLlbz9lPtM6KMtyDQ6GE/tRp2zsNAtNQvcJ3Ny1qNrUaEf/gaCxLEuYiT3qqkLhTudry/9X+85+gzLxfyi7Tv05zwtx26MvS1of6mlKtBXwv+0Lp0pJmRGo+5dR7Gm8xMR2eDCjfHLxwODtBmygQAgyERl6R/lJFjD3ctW970oYp5N/0z8/puvCjWuWwDm3C3PkKSmERhNcXAxjMpbElORAYHxooTuBx05U/JPVH0caRVtkjY0xfZTJjLgJJiTnAP4fSIiS3KjmSHQojmSzMrQrhCbjMVdfcjLPR358b9a1A91S3GuhyJRY8WMnLj+VZxY4MVL+JnZjn1yifIcgjAZtviGC9LhstPOmlgJUNucFMyFkaCMMk0xHp1Osy1epS1zSTO6O+82jNRYu2MlRBjIiJZJ4XcVX6gLmOqlz+PQwI+e0ga35qVc9YLCIgiesoeDnxfinQA11DLUglrqiAl11YSPSAhaBNBTMwMNmnol0uU3G03GmPP52dapYYKffleLKXRS/FFJuRv1EBIfIb6uhTMsiSpYjgNaew0rihgbkY4XKPIY/xbxFJfwbiI/atY0LBQYB6i++W+VqMyihsFwvzaeJPlQCxirCElHuYW0=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39840400004)(36840700001)(46966006)(426003)(86362001)(1076003)(107886003)(5660300002)(103116003)(55016002)(4326008)(82310400003)(7126003)(8676002)(44832011)(336012)(36906005)(26005)(316002)(36860700001)(70206006)(356005)(83380400001)(8936002)(81166007)(47076005)(2906002)(7696005)(70586007)(186003)(478600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:04:41.4708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7279303b-b8ee-4169-b5ae-08d947aa415b
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2442
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

There is no counter for dmawait in AIP, which hampers debugging
performance issues.

Add the counter increment when the txq is queued.

Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---
Updated fixes section.
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
 

