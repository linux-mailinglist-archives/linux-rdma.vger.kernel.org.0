Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8C3B9443
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jul 2021 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhGAPtj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jul 2021 11:49:39 -0400
Received: from mail-co1nam11on2132.outbound.protection.outlook.com ([40.107.220.132]:56160
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233828AbhGAPti (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Jul 2021 11:49:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcPvyaeXhjm21TZ011rmPIOK+l1pzby5O+nUqXyOYIXbvj8yjny9BC5boYau/tOwAJADRonPdiEO1sUSio0wcuaRq+7Xlnc2ely65ETnw2ZxfBk7HRsT5AWrpXsFZhjXXbcDyTkqt+Is48T4H/QK8QuNdtHilHxFi71y7JeDmhiDB3GyMA5LwgxsuCEyilNbMkOEd5N23p+VSpU8tN1uDwwBEjRD72T1XFM8STpgIln8aBGDRo8+ckcMBXeV7wRAyERSN5RfJ+g2+GUDO7rfV4XCh3ThjHGKYXrzeFOxm2vjckTb3/wN+8z2GRmq7FhBm3YXtgaCz5O5THYLs7YGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLKzO6hAZuCarD9+VYB0YruqudUKlW2Rbuh00GfOFtY=;
 b=BiTJnlgTemEbeiivdtORfLDSsofVGMdwzdOV++hqoQE3NT2Xdba3DEpt1wKLCYZbIS2fYx6MTaF4xV88eLBTKn2Og9DxrIteNEfwWa+H8syTZQFJCs+awaR1/qAR8zbuu0EzsiI16WLKW1fJbLo1/ZOf2Iy5IStWOt8nql+D+jD1fnBcwaESFgzxOoYXJzFyoww+Eg9mgP3+Ue+k6OUrDhN6qHrfri2o2yUKMoXo/ZCMqCD8o3TsuAnifuFhliME11bpeN243INkF56PW+/ff/wCGSk/EGc6Gomj3m27H+r/8mjWjlLGZGZTQDS3ycQbrcuI8G0daRO8UQV6TtuTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLKzO6hAZuCarD9+VYB0YruqudUKlW2Rbuh00GfOFtY=;
 b=Svqc4mTqzbeHauOd3NDJrO5ls6KRTHQMm+ulW06sGmNm8gjLCCkWdfPiZympCOi4o4KOWeWJdM8rNt6+fSH4YbO5Eprw1jW7IIpsMGAZCv87kM0NZZwdJwuCbckiQpnDlQD+Ac8b/vqBl5wuDUJ68DscePiU5GtRABZUzWwsSePrB40tySjDYDuUSM62HXPnrQ+qUbH0YYnx1p9Wx4CHrcI9SqZq1BoRgSrtS/d6pzNtBQB1aRgKybCwl9nIikmh6OjPjjeTE2U/1JpE+D0UzbIENPVLcvRTnlwcZBO+/IHM5M+zre028y4hQdiCLzACd94o+/LSItBIdPpkE+EFVg==
Received: from DM5PR15CA0059.namprd15.prod.outlook.com (2603:10b6:3:ae::21) by
 DM6PR01MB5098.prod.exchangelabs.com (2603:10b6:5:5c::30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.26; Thu, 1 Jul 2021 15:47:06 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::47) by DM5PR15CA0059.outlook.office365.com
 (2603:10b6:3:ae::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend
 Transport; Thu, 1 Jul 2021 15:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 15:47:06 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 161Fl6L1102418;
        Thu, 1 Jul 2021 11:47:06 -0400
Subject: [PATCH for-rc or next 2/2] IB/hfi1: Adjust pkey entry in index 0
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Thu, 01 Jul 2021 11:47:06 -0400
Message-ID: <20210701154706.93459.5955.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210701154318.93459.18982.stgit@awfm-01.cornelisnetworks.com>
References: <20210701154318.93459.18982.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d87e798-5afb-401d-7eaf-08d93ca77ae7
X-MS-TrafficTypeDiagnostic: DM6PR01MB5098:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR01MB5098CD9A671C0923BA96421FF4009@DM6PR01MB5098.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQCWsunTq3BjYXakXbxVQfVOzbYSooQ4/pEOUzpVNkyjrBpVmNRtZKgqdiF46PT1Af/iuIvSsr+H5GHAod0EJHO8xUnJrcWVl85BlrvUm9mHqBPBmwB0/Nd1gvaJJqzCEffan7vBSpsIvdgRdH6aCbDx3bf+pIgsg8uyjqVdYrXXd7DvmaZ4Y58sQ4ust+VXuPHMJrJozWRmhZt6jBoPnlMpLySDd98L7LgN1MBdNwi0fjKTUfwy2Wf/koRxt65PVUyULMr666HKLvwLouZB7kSaXE4O8ah5Z8h0fK/P8gOHvfkSjB2IOcPxmgN7wFz4aiDsqqP8mUBwzkgJQOG8blZy/Hm6WD3MVP0bfbxwMrSgjvR+CtB+N0t/XYU01U3lpYh91Bb1aCtTx90kmt6NiQXe10opufqhgjSBjr2mubajF/RGgD0T++mlt6b+/QseW5Bx8eR5bBfyuzB07ssGU8hnbK73DGJbS3WS1QHh4TOOuzmOmM00Wb35IX+mk3JUbWrTJo9UFoEKAb7NWXZ3bh9U/o/9Ifyf9B5Un9R9CColwqp16TV82kLSrtBseU8GBYE4uQMgOAF4mGDKwM4Jl5+53YnsFpiUiZAuuWgMrzWHjJLgw0esfIz6+HshtE1lYWQbjnDW7jboV8ueh0h+4baVkc6VVPtzOgoit00jVmwVzKRbTe6jpgUehbZzXS2bvg6oh8a3evRCYbEVFbE4v2k5A3nS19NJYTp7+A2Jays=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(376002)(39840400004)(346002)(396003)(46966006)(36840700001)(26005)(70206006)(186003)(7696005)(70586007)(81166007)(5660300002)(1076003)(55016002)(478600001)(107886003)(4326008)(2906002)(316002)(103116003)(8676002)(47076005)(7126003)(426003)(336012)(36906005)(83380400001)(44832011)(36860700001)(356005)(8936002)(82310400003)(86362001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 15:47:06.8002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d87e798-5afb-401d-7eaf-08d93ca77ae7
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5098
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

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1=
/init.c
index 0986aa0..34106e5 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -650,12 +650,7 @@ void hfi1_init_pportdata(struct pci_dev *pdev, struct =
hfi1_pportdata *ppd,

        ppd->pkeys[default_pkey_idx] =3D DEFAULT_P_KEY;
        ppd->part_enforce |=3D HFI1_PART_ENFORCE_IN;
-
-       if (loopback) {
-               dd_dev_err(dd, "Faking data partition 0x8001 in idx %u\n",
-                          !default_pkey_idx);
-               ppd->pkeys[!default_pkey_idx] =3D 0x8001;
-       }
+       ppd->pkeys[0] =3D 0x8001;

        INIT_WORK(&ppd->link_vc_work, handle_verify_cap);
        INIT_WORK(&ppd->link_up_work, handle_link_up);

External recipient
