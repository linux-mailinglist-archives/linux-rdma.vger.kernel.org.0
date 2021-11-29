Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B426E462054
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 20:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbhK2TZP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 14:25:15 -0500
Received: from mail-co1nam11on2135.outbound.protection.outlook.com ([40.107.220.135]:11648
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229452AbhK2TXP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Nov 2021 14:23:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkXrNwnpsTECUbQg1WtmxnEJtq7ivuvpwWpN4GngPk8QCMSvdLt/vMjO6lNq4NXPsFg68O1RzISok2Eel+eKPwjjZ6+HhxMSZiE4wxUIW5KlkgKobu694mnTGd2rvhJSxzhZ876F/R+WzeuVMuTMl3DfGhSPmuublmydtE5HgWKglnomBqJSM2O/aWGnJf6wnf/A3h6ln8EdgImf9LGj8X50vWjPu+4bT9byzujnEq65nSrxRp0/hK/qnM64IDxmaIHi2S7ogsp2zGN4ryNl4EGQQL01J8FBBdKDHv/T677Dfs+yVkoNap+Uq4uApVuF+YQsm3fR0L9E8q495BELIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfK0T8V/t4iWM4h9LV9bI31NKRkqOmzwxf1eV/KhBEM=;
 b=JPR+kr0cjFfOWeIZKUMvFD5JvFgt0BbRdUDlxIwivQKwRp6Ju5y6g+0tEfzqx0jmls72xpXB9VRl5H+TfTpwbGmA5cZyvsnqEPO+8BUEfwxsFhHbxKtZsiXlXCQffCrdAzDTs2ErqypA9o0CfsZOngYooApDrDlTSADklpCb4ieQRRzIM7xGha4VeIqG0yR8rbaFYPKZHA8JPwPg4GnoUaxe70gyOfYSj9HhTTEpzZhYZCpPyOpnue+jS4gTfGjr+QtQ6y6L7wNoLIh6Oynhd7TRMftAHKHOoXy1e8afoD2sN/3F0lFr9zFIEoP/6fHPOtVCFc1t3puMYPilPUyWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfK0T8V/t4iWM4h9LV9bI31NKRkqOmzwxf1eV/KhBEM=;
 b=RR3C76FVc5yUo/TomyVNOw05E5mkqxCL/0Q2I6yQLK3iSfTORxzAx8/yJKeNrsq2MeMOVEr4aRuXpMLp4sqvcTqZNSNUikbrACuH0QQ+t1nvrHgk2O5vqTFD1FM7nGnszUwHg1nNx0GiBrYL8uLDh6yx8nv75dbsZ4mVMjY8p2Kjx8InZWWujfoDwdTRRhtqwHGN5GR3sT54R9dC5lPZdO9go1TG+TdzfFx8oDJmJ/HBqs3Lz0iP2E17PDKPpqN/lFRI0NFbJlxSkgE0UIKYWT34OaGAbeiXbjHIMmOEK2pZfnt/HKACTknoocq2n4rCd7lCNZIfNX6ZS+s2kea+SQ==
Received: from MWHPR18CA0032.namprd18.prod.outlook.com (2603:10b6:320:31::18)
 by BY5PR01MB5939.prod.exchangelabs.com (2603:10b6:a03:1cb::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Mon, 29 Nov 2021 19:19:54 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::58) by MWHPR18CA0032.outlook.office365.com
 (2603:10b6:320:31::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Mon, 29 Nov 2021 19:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:19:53 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 1ATJJqHF117689;
        Mon, 29 Nov 2021 14:19:52 -0500
Subject: [PATCH for-rc 1/4] IB/hfi1: Correct guard on eager buffer
 deallocation
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Mon, 29 Nov 2021 14:19:52 -0500
Message-ID: <20211129191952.101968.17137.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20211129191510.101968.6259.stgit@awfm-01.cornelisnetworks.com>
References: <20211129191510.101968.6259.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6de52d1f-d3fd-4773-0eab-08d9b36d390e
X-MS-TrafficTypeDiagnostic: BY5PR01MB5939:
X-Microsoft-Antispam-PRVS: <BY5PR01MB59390D755119E2AFF1876862F4669@BY5PR01MB5939.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFJxVTOzckBLMqZFJaMlkKCDFoPF7UjnaouQkC1qEG1CileMVPeFeaNp2S67QT8EnFljiy/XJnX8sKaN4v+2/gu/br7IMUoxUKY4PDPd8rZXhiP2iKeVdPXPnJIV0rHP4SfQTAVoMwTJw0YlVc/2A/D9F5ThOWpJ+0aCCKE4b27UBS5tZ0H33Kk4/rVKagIKWerzSR6GgI6dQ/nE0/Qd/G6O9XyWtjg59yVD9k15BGGp82m07X9Skp31UphqzIpSpv/cK7K91MO0PrmC0Y6ini1X6TeEuuaFP1/aNx02mg915YDsD+EfT3qMkeUss+x65PBJkF6MBkZoUesyywS8IBxnQzDI0Azr+b0RVvEIpd1FFyJBSaHA+0OO+sP/scKmMvYfy+crXRmUD5N47eLPNSu9x1UeZXL9/Ck0VP188tGrSKqZehe0PWR44+gQXCW6T2uJ0eeCqWUD3eSmDliIoAnJ5emhNcgTHBKT9vZF5FwcNlnr4AbKFLnEmnBGBu1yhzkp4mqnrOZx2D5j5IH2yx/whYrFlDFDhVSX3a1stpyEFcZBiHDEkl1rgwl+5bWsHs7Re5KkIFSqTc/W8B9hhL36UdGsHhWzWmT4gG9wpxue56wuRzhFKpYDud4ULdoCne9tzAIrtyw1JSM7tRkk+8L4q4sMPetAV305gm38QCexYprqt+GhhCLRvbU3taDUnw55Vrp5wwcNc4XAenvO69Gbcf6M+k6VevaSpcknCpk=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(26005)(83380400001)(336012)(1076003)(316002)(44832011)(2906002)(5660300002)(7696005)(186003)(36860700001)(55016003)(4326008)(426003)(70206006)(70586007)(508600001)(8676002)(8936002)(6916009)(81166007)(356005)(82310400004)(107886003)(86362001)(103116003)(47076005)(7126003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:19:53.8098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de52d1f-d3fd-4773-0eab-08d9b36d390e
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5939
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The code tests the dma address which legitimately
can be 0.

The code should test the kernel logical address to avoid
leaking eager buffer allocations that happen to map to a dma
address of 0.

Fixes: 60368186fd85 ("IB/hfi1: Fix user-space buffers mapping with IOMMU enabled")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index dbd1c31..8e1236b 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1120,7 +1120,7 @@ void hfi1_free_ctxtdata(struct hfi1_devdata *dd, struct hfi1_ctxtdata *rcd)
 	rcd->egrbufs.rcvtids = NULL;
 
 	for (e = 0; e < rcd->egrbufs.alloced; e++) {
-		if (rcd->egrbufs.buffers[e].dma)
+		if (rcd->egrbufs.buffers[e].addr)
 			dma_free_coherent(&dd->pcidev->dev,
 					  rcd->egrbufs.buffers[e].len,
 					  rcd->egrbufs.buffers[e].addr,

