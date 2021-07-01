Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE873B9442
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jul 2021 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhGAPth (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jul 2021 11:49:37 -0400
Received: from mail-bn8nam12on2101.outbound.protection.outlook.com ([40.107.237.101]:45345
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233702AbhGAPtg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Jul 2021 11:49:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZmfRvKCM1KeiIHElb9GXK/lcwIeT9ySmFC0ktehhq+8pl171jow3uYRz4CjWmRBZsU0triFlNdPRJZ7kGpBp1ZREEJ02RyUviHZpqeZQobGHkHvG93f5G8mcQR7kO+zXpy/OEKbYANcesotskHh1WqcwC2FucxY76yHIBmUyPddsvjfFs1q43BKyL4CmiYJE6vtRN+h/5HutOpbXgQjfErGIPOYJ37LhdjwZg45V5pv2xpqjcBPBsyc5Prt/ANMIF18aHLmD8vbm7IYsnycVbnJfCM9jzQwT7kvJdI1wlmtZjPqq8D9dCkD5enqKcyo9uiBSUPIKHfXeqP37aiulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEdDncfcTlCiUO+viW70pS6dpWNyVBoJ9kx7UV0+0gY=;
 b=FbEWZL35KCXc4c+gjap+4UDni39q90Ul+DscUN+64OMwC4UT1tZDZAWMzp8/bvXLsIuNXrZyWSSQtav5epVC1V8WJi+tmpSUEda+FAm5lZ+c+yWR4o8SHh85i3k7NoJ5sgcXD0N704H1wnzSYSn+rFxanSPLdGLLchUE9J7tmZYomz4AfWe06+2l9WZm58uxHDKaDhVZyHOFs8tfiUKZLP3jO7z5/tpfwcvVYkldTBMeFrIkrttkVznPhGPJ6Q93VBdmcjWqPOcUElYwd9RfL+Z3XNRnK56+WOPhKqaxGqU6WgIYoXsUgIfu6BSTo0a3kvVYWhV6OhGq+Upd9OoW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEdDncfcTlCiUO+viW70pS6dpWNyVBoJ9kx7UV0+0gY=;
 b=GuGOfAWX1lFo0qPmFPmWSBYmpaXwm9pnLjMWqY5/DnUrOhRTQnw6aseQVDuGbJgWNmDs4WuBMpMHtcgr8RZ8uyNAOAE5WROF/6h98qhiXe2UCqdTSlCRGBfJ8NEYi0igsWRQc6jldYhXo6e9gOxXsW7XUKFCOK1c/MyFubDCkeafYccUqzSbnMFtCMeLPqKiJQbrMsZA7+RUuxV/nZ7cJ+c3bNQTH6y/MouB3XebpifwlI64kqj1RGtDNwDdmwdzrJw3UBIN716S4aKL8DU68p2om+qhYtvfFdpvg2z0mGUTKPFKDoKtxXOn1BQzEs5BgicY+wFBNPsKBdqIlWF8ZA==
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by MW4PR01MB6242.prod.exchangelabs.com (2603:10b6:303:71::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Thu, 1 Jul 2021 15:47:01 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::88) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Thu, 1 Jul 2021 15:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 15:47:01 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 161Fl0Vl102197;
        Thu, 1 Jul 2021 11:47:00 -0400
Subject: [PATCH for-rc or next 1/2] IB/hfi1: Indicate DMA wait when txq is
 queued for wakeup
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Thu, 01 Jul 2021 11:47:00 -0400
Message-ID: <20210701154700.93459.5335.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20210701154318.93459.18982.stgit@awfm-01.cornelisnetworks.com>
References: <20210701154318.93459.18982.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c230db3a-e1d0-40bb-5017-08d93ca777c1
X-MS-TrafficTypeDiagnostic: MW4PR01MB6242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR01MB6242B7592B2E55C45D88E7EBF4009@MW4PR01MB6242.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Z+bKFibhCn3VZcASsexVIKViy+SuhKX+oWeRXf23i16Bp9KiasQyib8oGb0ZANTXXBeUlfuof1zvj3JROn6u78Hgfiww9vt+lnHnCemvvxm4+c4OlEeczOgzMefh1hL+Cfi5KNDMFzElRZomjEZggEXHDAph/nMFfMS38EoWNSGUUhzkfxmICDqZUC80xedaBluJ1Jyouyf3ug0tQqtFLRgvBQ1J6B4sn4CojUI/NxvzFZ4SqHneUDf/defw5k5ohgKfxP+VXVDOGfJY9ZJDyGj0obxfD3rwRRbRR1voROcFU3I7PuKvVibaGdxrf5VfMgYjScY6B8ihoV4PC+NCkKRvC2nXsOtdCOwCGObntlInxtjVmgRKuDu5R8t/8A5x+YpOIbZaSBWWVBXzT2u1hn4OxCyfXo4VKl+RWe7VKUxWgsBNuZrWBCYpMtnPAIFD829rJ2cfTMctEA+ffM9jSfNrshPsE4iqMzAnmbhAxpNg8+huJG28YfcRu+LuBAVQ9ahVy7oT4hwnlUb1UkYvujGnzX3As6lWPqFDclEMLn7YM/KiI+1qjm4H6biFmNka0uZka88w3TYh2hJ5cJ0gehKISwHxiEBMUcSUiaEwamljdROa/HzCKlVYOThSftUmmR98kBJko1n3Fxjb42rGW55XRxUZTHprPUrdlcjkPxkOEndkCB8sXJ0bCFy/NrJnHku24TondqtR8KjI7KjY7LygbyuIwHt86gdkRF8Pls=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39840400004)(346002)(136003)(396003)(376002)(36840700001)(46966006)(1076003)(5660300002)(70586007)(26005)(186003)(55016002)(103116003)(8676002)(36906005)(8936002)(47076005)(7696005)(86362001)(107886003)(70206006)(82310400003)(2906002)(478600001)(81166007)(4326008)(83380400001)(426003)(316002)(44832011)(356005)(7126003)(336012)(36860700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 15:47:01.5218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c230db3a-e1d0-40bb-5017-08d93ca777c1
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6242
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

There is no counter for dmawait in AIP, which hampers debugging
performance issues.

Add the counter increment when the txq is queued.

Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib pac=
kets")
Fixes: c4cf5688ea69 ("IB/hfi1: Indicate DMA wait when txq is queued for wak=
eup")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/=
hfi1/ipoib_tx.c
index 993f983..e74ddbe 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -644,10 +644,13 @@ static int hfi1_ipoib_sdma_sleep(struct sdma_engine *=
sde,
                        /* came from non-list submit */
                        list_add_tail(&txreq->list, &txq->tx_list);
                if (list_empty(&txq->wait.list)) {
+                       struct hfi1_ibport *ibp =3D &sde->ppd->ibport_data;
+
                        if (!atomic_xchg(&txq->no_desc, 1)) {
                                trace_hfi1_txq_queued(txq);
                                hfi1_ipoib_stop_txq(txq);
                        }
+                       ibp->rvp.n_dmawait++;
                        iowait_queue(pkts_sent, wait->iow, &sde->dmawait);
                }


External recipient
