Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4E03BDC3D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhGFR0e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 13:26:34 -0400
Received: from mail-mw2nam08on2120.outbound.protection.outlook.com ([40.107.101.120]:2783
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230348AbhGFR0d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Jul 2021 13:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7uyAru/7JTUT03f8Cm7d5B36DpGzh8Nh/LOsMAqa+PoLarzz5IjIsfngjG8eOui8JAOBbsQSZbpJ3J2jHyUPLsXDCJ2/7qjAhXH67YGD0X4SWD1+PuWO7OmOr0BkLaZNyK1YfQhS160lEsznISJOTYWMIvN92aQnBnwlb1tKe4igkYWaZxka/QiUzggurH/vkdNyP9VVIgMJMgXgww1puciJ9qFlYFIk6lVxU/E237ceCOG2IBmsw17B1wUVF27pr4fpQY1xBQbn6/BMSfqp+RkxfiwjRR2VwaCERySvyrtT/67VMz89J3Q134nHxKlf9mh6Wb8E3MPoaaoOpoooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tx9KDnNCUZzWOtiC3xOouBbZEBcgEIKnGIIlp6M4HY=;
 b=YE+r/K7CEwae5rGuw3KkAQQ6Aj9yElnbCxX6seCEpldmrvjI8KTjQIZ+Ww5zvQk907LaMREpP3I6Jm5pBdCxAzX3+T/WmbWctXM60wZeIyZDJCoOfcEfqBZcc4USJIqKi5cmAw4PAATwysVOpW4NR72uvULuKwHxGjwOQ72AHcCmB8X85uS23oDLN6tPiufRJcfAtFCgUFvSO27NvZ8LqBHzgHaY8AJjIDuv7+8rxTr3J8+03nZcMQD6E1IbaDNSVkK+G+oBi48sUwVq7KSeonrV79VIjzz6b/IQoSUpfq0QO4X8iIu3A4Z/5gVBXRnxWuWDxfqO4NfODhwBlz4UOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tx9KDnNCUZzWOtiC3xOouBbZEBcgEIKnGIIlp6M4HY=;
 b=kikZ7a2fmOQn2sKYwFebNw/WclkFp5wqaT8y5MJpjVpzKa18/PvEfdQsMIAvP2+BAE1+eFBv6Wvz5pCROipmhESosj8bHLha4FqcGzioknwjGuaQLETmauGK5A75ArLuoNAWn1lCtfxExnUfJ4rLhsYo3iCxobKTIXqqdKsK77xqehM6aTIo01S98DeAzzeX8czxtOiSKqeLZ0rrNt05DjOqp5RrK5dBgJ/V/z8brDf2yPphot6JtP1FzMufWfCpiYg3uz6ITB8+RM8mLPCYngd552qJLFQgC14dVWGaiW4Jrh2kmRVN/hIehtMrVL5c6005gUUqLR+nt3SoqnzFhA==
Received: from DM3PR08CA0014.namprd08.prod.outlook.com (2603:10b6:0:52::24) by
 CY1PR01MB1963.prod.exchangelabs.com (2a01:111:e400:c618::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23; Tue, 6 Jul 2021 17:23:51 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::a1) by DM3PR08CA0014.outlook.office365.com
 (2603:10b6:0:52::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Tue, 6 Jul 2021 17:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 17:23:51 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 166HNowK059137;
        Tue, 6 Jul 2021 13:23:50 -0400
Subject: [PATCH for-rc or next 2/2] IB/hfi1: Adjust pkey entry in index 0
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Tue, 06 Jul 2021 13:23:50 -0400
Message-ID: <20210706172350.49902.57258.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210706171942.49902.72880.stgit@awfm-01.cornelisnetworks.com>
References: <20210706171942.49902.72880.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8440bc57-e7bc-40a0-4609-08d940a2d2c3
X-MS-TrafficTypeDiagnostic: CY1PR01MB1963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY1PR01MB19639BD12AE806B0632A384BF41B9@CY1PR01MB1963.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wKLLpUKOrV/ZSenwTzCRUgxcavEz76SoJDTpG/L8TTbiK3clKHBG1G7arMn9+kz8vPMPTZE8MAAgPpBbI4sjoYDI4rC1Ah5PqI/f7XNaFlBFfcQhElAHrBzM4J9tqEKaRDbQpU/9/uhb1YLzkXPN1XdEHrbcZhm0bLn15SCJi+fK1ayeC8CiNSzx6kRbz6HvoDb2gOOiJ4V7t0ow6QI+NQlzO+d1vaWMy7Q1sT/C+PtB9orD85nXLA2qyXaxKrGESntnG8uH//vCzTVDzxK6SWMjgt/uu+Cxbdp1jvvexVqnWxl9chKSSmTPXl7CvEDX9szPHhhvEJb0B5Y5hkiNkKXVbkaauhQSPD5HO3uk6ZVJ9+sbBp76YWPWUOzMmD8DHDoLb4rMOvujtPdJK/Bm0t3Y1x3WBcTCE04MeR3Cp3oa5/3SJqUsTXIj38FxiAsEOpNh4kM539jB96UBz0M9hENffl2Pzom7L3aSg1240wu/flwmNhwViq5Tz+V0WzQER9NGd4LaH9Od3gU0Y/DwczDxmUnbV9iq1eYScRVC/hc7SmW9rHKlcq7ANR1Te48Ch0Fb3wNKwwhfjVM+l3q6yTkJS+sq+mxTcmFhc/FcJwchhpzOBxAqLTWnSSdUC8p57RH3ssRCawrfkrS/wUCBByJXCofwB2NrbZFM8pIVb+4fWxlwNuqUD5i4Me/EQduN5K24Vn8Vf0oi1MJY5t4ekFe1yjfeNj2bU21nt67D9fOETTUoDU12KvBYQCPKMMeztGYHNPyPrn0HR7A7Uji7g==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39840400004)(136003)(396003)(346002)(376002)(46966006)(36840700001)(47076005)(478600001)(1076003)(55016002)(36906005)(107886003)(82310400003)(34020700004)(336012)(426003)(4326008)(316002)(7126003)(36860700001)(8676002)(81166007)(7696005)(186003)(70206006)(8936002)(70586007)(26005)(356005)(5660300002)(2906002)(83380400001)(103116003)(86362001)(44832011)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 17:23:51.3778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8440bc57-e7bc-40a0-4609-08d940a2d2c3
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB1963
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

