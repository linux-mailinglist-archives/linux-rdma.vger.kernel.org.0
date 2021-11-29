Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49048462053
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 20:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbhK2TZJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 14:25:09 -0500
Received: from mail-dm6nam11on2125.outbound.protection.outlook.com ([40.107.223.125]:18209
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242568AbhK2TXJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Nov 2021 14:23:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJut6xIJrUIo4/udx/pg12uYxKEAX1vhd+kqR64T4PkaZZr4ocP63Y9lByAbDTABsHnw9J8uprFn1tmNvGro17GaOIEnGy0+6mrYRUzVzlt6Gjyxm45nOjRPqnPzc172ylLpFPCg9+ayTlJPzLXuqFDDMrgOIG41MIulGfLSuDggXXm09mKh/bjVrtVFSjIjJd2XB7Fhfc5qwkCqTYV54Og2Lhs2vlYxzMU73BPAn5hRU25fZ8TFw18zs9M6SMuYL46dKGWtozeR8f+Jg7WD7q8tPE9ajCZku7H1Jx61Idjgj2JJHxmf9EHK8EsZqS9bDxpXO0aaV3x4wQWQRHhvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIwsUo/EO10kS9FxheuIuvQUc2B1JIcTJFsSfhsa7FI=;
 b=TB0YNFzi14cFVPxDhGVTWI0PDBgveovOH/WAqaPcI02f03PJ9i1stYyIJQb2vSQxqDMKv8UIvjhsggTvTQv5zf8qRiJGX9eBl8lWuYOAr6WtiH4T1vLdq5yTT8L3m1YP6KJJAZXGatmEpBbgY6XQswXrgLwwinUR2KunZYVvT4zCfWjawvtmgYvgTBz/INQUpDqDm8A9pHxqoJzxVRcupaaAH08QS1jfUpR96U9KZuy5JdLIaxr9QXvh5LGqocZQdWH0YszevepPYZPBtppgiXcXFiQoT17aobMiSwNCnLkZLL4l0yAkDRTdmb8BFAwgsEY1NemM9ZumpkIlJsw1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=ziepe.ca
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIwsUo/EO10kS9FxheuIuvQUc2B1JIcTJFsSfhsa7FI=;
 b=kewmihRovyimD/0BSQS7pQ/9AfTgTKANJKxi4OBF3V66FWWyEvVqrN74JTY6qWxFPNED7hPPxP+D12YQ/gFKfUbAP8Vl0+uN60YXZBvFkqVfJZYQg5D4QhmDibzfbSmDcmcPH5vSAl3aU67HwislD/EHtAUqHJ/OedjRIGX7gvhabLzHcF/Kx6HPL2mPVRWCd0pTbilp7VEMRs/HqigWYhEEz1S5QOzNxTYFIgXnXWfi3WWH61USj0sVH8emMPkbmkec1y/KpjJGOzJ3gxFuu+uCQZ095uY1QwVjql4dzkxsoDLp1HdOhhvR/0PB1lScJwKQtaNDe1X8D7/2R5cZUw==
Received: from MW4PR03CA0129.namprd03.prod.outlook.com (2603:10b6:303:8c::14)
 by DM6PR01MB5722.prod.exchangelabs.com (2603:10b6:5:14f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Mon, 29 Nov 2021 19:19:49 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::24) by MW4PR03CA0129.outlook.office365.com
 (2603:10b6:303:8c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Mon, 29 Nov 2021 19:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:19:48 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 1ATJJlEg117383;
        Mon, 29 Nov 2021 14:19:47 -0500
Subject: [PATCH for-rc 0/4] Some more RC fixes for 5.16
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:19:47 -0500
Message-ID: <20211129191510.101968.6259.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66074ab7-3a35-42aa-7c61-08d9b36d35f2
X-MS-TrafficTypeDiagnostic: DM6PR01MB5722:
X-Microsoft-Antispam-PRVS: <DM6PR01MB57221840949F85BBC6B82A73F4669@DM6PR01MB5722.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPsBIyqJz9bnsR/Lm2TT1Z1AXDAHzCM05dMkFoFCaSkipbcpto2+qj79ccXanr3s8lWvZoVb8qgAtsK3doSqHDgKzCy1E2nSPjxuP5iJClvO2prk16R0om6GJ0vN818Jd9rRjw+uR0Di9D3yiIkDkmgRvjhx00XhCekCrx5NmcrhOZyJLo3C5oBE8EzgRfefj7rYb5TADXvLaLs01b/nJiXYP2E78ib/at/gH41eItxAoXjAd1VH3MXrO0f0ajIeCN/HaNsCPfGThNxYDk20UD+VsygBhj73xPzUf9Oa6Sv9Ppd8/jo/D5zixTPyGn0q7d3znF/Ur4SNFd6kyvducHMF8Kc9AZDgnrfnGqnYhV1O3zAtmaYN/B4tlRfIwNsuhrrmy1tUJmB/ka7oScZnWakTGURs3zm+xTMb5bVUfo0AKPCCFNriW7sEGCWjYvWkW0kBZJYW0UuofSso9AK2sO7vqXg+eGkVHkBfQ2b/TAAdZnCvWZXPYrTE17cmsyGIjtGdA6c9F7FtYvSU5wIgTIBCe2PUfLQAxNx7PpEfs0pwyrkSUFlkU4DmMGLS4obYM6NMlQzDaG2mlRDQyawVqJF1yNiOr40pqDGVLZzrDgDXJTfFiNyav6pQ3fZ9odcmg0GstVa+dIPmaw2Y8UbQDizR8dHgo9XjWu20DROJySAVbGSchYIpVUa2JarkP2oGgLEyct9KbO5SXNGWAmlbiRNhVteOqNB+gCUq7RnqaSY=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39840400004)(376002)(36840700001)(46966006)(70206006)(186003)(6916009)(8936002)(82310400004)(4744005)(83380400001)(508600001)(316002)(2906002)(1076003)(7126003)(55016003)(103116003)(5660300002)(86362001)(36860700001)(356005)(4326008)(8676002)(426003)(26005)(44832011)(81166007)(47076005)(7696005)(336012)(70586007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:19:48.5947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66074ab7-3a35-42aa-7c61-08d9b36d35f2
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5722
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here's a few more fixes from Mike. Two of the issues were found through code
inspection while working on the panics. The BUG is a long standing issue but
just now surfaces in 5.16. He has marked 3 of the 4 as stable so we'd like to
get into the RC if possible.

---

Mike Marciniszyn (4):
      IB/hfi1: Correct guard on eager buffer deallocation
      IB/hfi1: Insure use of smp_processor_id() is preempt disabled
      IB/hfi1: Fix early init panic
      IB/hfi1: Fix leak of rcvhdrtail_dummy_kvaddr


 drivers/infiniband/hw/hfi1/chip.c   |    2 ++
 drivers/infiniband/hw/hfi1/driver.c |    2 ++
 drivers/infiniband/hw/hfi1/init.c   |   40 +++++++++++++++--------------------
 drivers/infiniband/hw/hfi1/sdma.c   |    2 +-
 4 files changed, 22 insertions(+), 24 deletions(-)

--
-Denny
