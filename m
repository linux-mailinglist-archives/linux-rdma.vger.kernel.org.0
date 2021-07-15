Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B5F3CA1D5
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 18:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbhGOQHo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 12:07:44 -0400
Received: from mail-bn8nam11on2117.outbound.protection.outlook.com ([40.107.236.117]:14913
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239701AbhGOQHo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 12:07:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQq01qwKZ6HCrbKqCiTX7zjzwNKVgGC6rmJq+KhCpZGabuxCcejXx25Ip66w494bQZgpmb6GopZfYkdZuuCR/OvHNtkc2gjhVvWADYfE1yBkaaJb2Vor+F3WT3MSh5ZtESPFNBlgbyUqFltkR9Gos8FDfLB5WJN+gdtSoGGPJNJh7SYpt+/SUrpl46ql6qliN0ieq1R6mVbnNoXPfweU3DVBPSrR28df60xK+NPHr5VfytejNtB0+iWY5g25SlkNhjLbwVY2EI4MQedmbWkkF/BM03qDmG2yviDJ/Yia1kIBCXr4tj6FvKXcwSYUkd+Y4TeRA3yXFA+l9PtLzYtllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tx9KDnNCUZzWOtiC3xOouBbZEBcgEIKnGIIlp6M4HY=;
 b=Z7DS4qOXeYCJ3mBU4m6Ok7PH6qiYmQxgkYFgQ6SVo9SfCr/KxlCfZ9Ws4oyVJcF0+53TuN0Pnvh22nHrjN6LxkDD1naPfNfxkDHkGSOPU2BaVN5jsk2BayUCRvMuKOPPMDb+YDADnn3XXk+6FrojlDGw0F6hhGVeXaLfCSQGAudEov618PhTBbNYdWSUw9z1u2NoKZvvJh37lOdLVOr2YhnaKsaby8lpfrifjy86kaMHB1dD1a4E8xqxqL6UfIGiymEPgFvMIqkVoJzVaufpBrZZ1aFXNwI/nwdCVnWJhBlW20HScQks9zr8kzYizlm+WJN3tvBWpqheg0yLpaQfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tx9KDnNCUZzWOtiC3xOouBbZEBcgEIKnGIIlp6M4HY=;
 b=LauYggBkOZ/hEJA+NMMfkWD/i9Yc+LvxXQ8ez/pzr9qgHzFdnIOHivwF0iQiyxcdji8l7qIe//WS9Cr0+mNVVLo2Gr/MXSwecCC8B3a+3/y7SVKZTBWhDI/CjglYYbAVi3idGlTnuwqUyemgKR2Rb5V5MJRn+rLu6RKz3oipA88hGBdVj+54faAEcL9AkNJYBOKvcLHdnPBZBJXZDvQtOlmCQe5pQFEMGvRcuv+Hg4NMkamTEsqIyid6WdlC7kLLWaaSzuEiWUVIx0nEOWFWTjOJcTMZT4CZ+rpG4AMvGwAWrbQUCo0V8IaGw6u3W9WBjcAblvS2XPLfCAZyzv43IA==
Received: from MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30)
 by CO1PR01MB6678.prod.exchangelabs.com (2603:10b6:303:d9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22; Thu, 15 Jul 2021 16:04:47 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::4a) by MW4PR03CA0055.outlook.office365.com
 (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Thu, 15 Jul 2021 16:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 16:04:46 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 16FG4jcZ146756;
        Thu, 15 Jul 2021 12:04:45 -0400
Subject: [PATCH for-next v3 2/2] IB/hfi1: Adjust pkey entry in index 0
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Thu, 15 Jul 2021 12:04:45 -0400
Message-ID: <20210715160445.142451.47651.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210715160303.142451.38503.stgit@awfm-01.cornelisnetworks.com>
References: <20210715160303.142451.38503.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83ba7c85-ed31-429a-0738-08d947aa4474
X-MS-TrafficTypeDiagnostic: CO1PR01MB6678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR01MB66788E90F5C798EE7202426DF4129@CO1PR01MB6678.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPMv9zKigFE2JOuKB2/Z0SBop6CeZPVlyuy/CaDaZBNanhymIcfEDtPIca1h0n7XANRgkc6n1F5ilTF5rbs1hsX1m1WkPkxG/7MmwSvypgoTZxMJ9As+tO8SV7N8qK6HIg8WAH5Rlxd8sOtygD0o2FWAQ5Dpo6Ru63h4JT9UAaTSs1iqShAmrfFpRTBJfg8pDLaQcc/LPAx8W8I3hSxH1VsP7X2nGAEny8nOaRIoXNNeEKrlJiaPmQ23qTHUYyzQ/PyxzGxa/g/qzmZGFyItJFE+jqXhpX17dBEEgnT2fOkWgWg1KqKKjg4wFVzncrmo6/eVRTeV2vfc3mvAFKTbRDloa38fbtV/XleEloEQgjlPBLcT10O9j66c8pT/lvIUC7uoHrfLOpe6lJe63vZZjqypcUwGDyp3nA45g4U3xEPDkdFXQaJIGnsMhNi3EzwH/7LwZa+lNoyYzGeHZpv1vkSiCEiFq5AZEpw0vWScnKTWOp5PWaGRLGNk/ROBS2b5vY7iwLozayOSS0yrjIQR1ZRt8aRCH/iRuQfDIZHVPQz26Jp7+YUL3GfXz+VUQWOmQvmCzvcITlszDrRuKPqgnFpUIcInSjyiL0Ld1Le5KMXDxs/TdBLeLqFs7upiFL0dRYAERURAY11yPWttSaUOi4zHuGf7sA20oJ0Bl5UfKpGZA4bBHowYbazWanGp+QQaOPzMzZEuLPg4Ze4eEsh8On8g3iLDjNCNdgOAO1SM2F4=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(47076005)(7696005)(86362001)(70586007)(70206006)(186003)(1076003)(426003)(36860700001)(26005)(478600001)(55016002)(8676002)(103116003)(4326008)(7126003)(44832011)(81166007)(36906005)(356005)(82310400003)(2906002)(5660300002)(316002)(8936002)(83380400001)(107886003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:04:46.6453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ba7c85-ed31-429a-0738-08d947aa4474
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6678
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

It is possible for the primary IPoIB network device associated with any
RDMA device to fail to join certain multicast groups preventing IPv6
neighbor discovery and possibly other network ULPs from working
correctly. The IPv4 broadcast group is not affected as the IPoIB
network device handles joining that multicast group directly.

This is because the primary IPoIB network device uses the pkey at
ndex 0 in the associated RDMA device's pkey table. Anytime the pkey
value of index 0 changes, the primary IPoIB network device
automatically modifies it's broadcast address
(i.e. /sys/class/net/[ib0]/broadcast), since the broadcast address
includes the pkey value, and then bounces carrier. This includes
initial pkey assignment, such as when the pkey at index 0 transitions
from the opa default of invalid (0x0000) to some value such as the
OPA default pkey for Virtual Fabric 0: 0x8001 or when the fabric manager
is restarted with a configuration change causing the pkey at index 0
to change. Many network ULPs are not sensitive to the carrier bounce
and are not expecting the broadcast address to change including the
linux IPv6 stack.  This problem does not affect IPoIB child network
devices as their pkey value is constant for all time.

To mitigate this issue, change the default pkey in at index 0 to
0x8001 to cover the predominant case and avoid issues as ipoib
comes up and the FM sweeps.

At some point, ipoib multicast support should automatically
fix non-broadcast addresses as it does with the primary broadcast
address.


Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Suggested-by: Josh Collier <josh.d.collier@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/init.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 0986aa0..34106e5 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -650,12 +650,7 @@ void hfi1_init_pportdata(struct pci_dev *pdev, struct hfi1_pportdata *ppd,
 
 	ppd->pkeys[default_pkey_idx] = DEFAULT_P_KEY;
 	ppd->part_enforce |= HFI1_PART_ENFORCE_IN;
-
-	if (loopback) {
-		dd_dev_err(dd, "Faking data partition 0x8001 in idx %u\n",
-			   !default_pkey_idx);
-		ppd->pkeys[!default_pkey_idx] = 0x8001;
-	}
+	ppd->pkeys[0] = 0x8001;
 
 	INIT_WORK(&ppd->link_vc_work, handle_verify_cap);
 	INIT_WORK(&ppd->link_up_work, handle_link_up);

