Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E31842C2C2
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhJMOVM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 10:21:12 -0400
Received: from mail-mw2nam12on2121.outbound.protection.outlook.com ([40.107.244.121]:58368
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229562AbhJMOVF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 10:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibs0JPSEo0L5h05DN0/8b7bh3oMz6iywro+Jmf77uIh0il6jFdizC3hA75kLqCgkXOSfbhvlC35aC9dBIHIV4ppBt+dGqxdBkFrBNbparzRVp4Cz7Bd6blxxgB3pRRgiGu0zP9xeNpCUjGnMP+q7qbIiT+TllfhvqFaXlmpeoNTY9EU07asoZl1iUWT7cBET5pbRvB2yQegDA7PhD8DNRMLajnqhpEnYsbL770aEAC9oAUdV+yPqpolKxVuszPY9DY/UPHSQrZkOd3vQPDWYocsDsRW2WYIOyQ4nFwQ0w8tlduHzbnIBQr+ULwscLezPXn4NdLa5dVVbFg4CW6GGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqhAu3wp/H5GMkbZ6+xRBj+qGqfhh445xeS3g45xwwU=;
 b=abl1pQJXKl6ytAKh5p8ccD34xg2mr8pXVggrGjKN1n14R1gO6w122tokN8G2sEwZh6zetCRTo+RnJ4I/GQYoqyDgxYPvvZDiBPkl5stuDk6jRHwHqpw1XAz97wXRPrFUJEig//FESRI+e11jkQqTWvHBC6ooYFcNJqvDsPZuXsjIHA2NU7n/fj45LvZzRETbH+9NfhxaHASOERqJI22XYsJO8Lfx+AeZU4lVeVRJS4SWzFKlYJFqYdb8u+tbcI6HE10KMsMlKk9hNPldNNly/4WgdHIFMf58FE36i3SvjkEnP39zDKfrmCoqi/1+Mm144SjroDHqpreAAVNMIqdIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=tsinghua.edu.cn
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqhAu3wp/H5GMkbZ6+xRBj+qGqfhh445xeS3g45xwwU=;
 b=h+x3xZY7QG34Zf5FYFC8O80f0cU3uAgHYLOt7FY5Kc2WxekVwK3tQe008FH9Np0xsAdpY8na4MgwfK2+t5oGUTGK+zyESK9ctyVwil92gmXk6Kv82hsrc6SeIy2UDszKBdRxbWflHsGpRnT7eFLWFKJqA9TA3Zqp1r5MSgzIE4tklENqakQmmkHVASerCppOfr9bhU59ojUAHC259vIRCpa2Dr8t7BgQS/bYiKZkxN2dQZY4EnF9XIwB6+lEMzi+xASiEnhsc9AVu9UpqleTcGvaGVhrYWZc9hHmfm2KH3jI24LdNEND6GUhqsIdpcIVJgtj0qP+KwN69iPrOFPt5Q==
Received: from MWHPR22CA0061.namprd22.prod.outlook.com (2603:10b6:300:12a::23)
 by BYAPR01MB5000.prod.exchangelabs.com (2603:10b6:a03:7f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Wed, 13 Oct 2021 14:18:56 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::3c) by MWHPR22CA0061.outlook.office365.com
 (2603:10b6:300:12a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 14:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; tsinghua.edu.cn; dkim=none (message not
 signed) header.d=none;tsinghua.edu.cn; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 14:18:55 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 19DEIqUH128130;
        Wed, 13 Oct 2021 10:18:52 -0400
Subject: [PATCH for-next] IB/hfi1: Fix abba locking issue with sc_disable()
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, TOTE Robot <oslab@tsinghua.edu.cn>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Date:   Wed, 13 Oct 2021 10:18:52 -0400
Message-ID: <20211013141852.128104.2682.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c548a87-7914-4128-2b13-08d98e54644a
X-MS-TrafficTypeDiagnostic: BYAPR01MB5000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB50008D6F332A2326C5FFBA8BF4B79@BYAPR01MB5000.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYr+6GfudQb7345MN7npsG2GoHunx5upv9OZwMNIhGZEpZN7+RGQeLDXSv3qxOAKGUv9FNXUHObqf0yRrP2adyiiJsqWI5PDLkjS1E4iBd82bhiITogHTgFEPgvbnFra1ZQWLy2LJ9Afz3uJb9ucQ4s+Ng33BH+aDjofeDZFn17HBQSwUB74/yTjh5ibLoHZ6fHxqReJF3eMACrc5XIGxDWF+g4+Jc14Q5Ismo9IVPkDFA90OOuvbX0/wndK2yOzDbpHKpV0DJv2L1oJc3vpzzOGNeyl5RUmPu+REPQy9SbbKStC6dCWufuWtBuP2T7BAmCWTLHA+SHOX8DCtLdN6MFqW+749dvo5xHf24Za7hVjMw4mBTS4wwe3KAeMtkBds/5FVs1cU/PTVzmDykEa3GYZ8Rud/ehmejzUJUQrfnc3ZUa8X7HZkIE3YgrA1y6jJ91brG3wPhipPtqU9Qts/AP3ZJrBYDqkf4Vky9UXZne1A3T/inJCQhxW7+8aOPe6Ae0ZXbGpq+3wAh47hvebGIxj3em0RfmENccDgnQQ9ZRz6hyk9lWM6SNCfyzo7quypDnbxiSxHWuWl4L6E6ZUs4aTaRF1ARb6Y5vI9qJFPLkgICCCforGLgQ54HhjGCsFmouMEM2/EDYFcP4K1ip3wuO2ZvI2O4ko4S6M6og9ct4TqA+sTSrGb/0fz8XRdRcXUIKDYlTuAQqlBskAbXRdcSHia6aBfEbs4WD682kHiuA=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39840400004)(396003)(346002)(376002)(46966006)(36840700001)(2906002)(316002)(4326008)(86362001)(36906005)(83380400001)(36860700001)(7126003)(336012)(186003)(426003)(8676002)(7696005)(44832011)(103116003)(8936002)(47076005)(54906003)(26005)(508600001)(82310400003)(5660300002)(81166007)(70206006)(356005)(1076003)(55016002)(70586007)(107886003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 14:18:55.8996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c548a87-7914-4128-2b13-08d98e54644a
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5000
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

sc_disable() after having disabled the send context wakes up
any waiters by calling hfi1_qp_wakeup() while holding the
waitlock for the sc.

This is contrary to the model for all other calls to hfi1_qp_wakeup()
where the waitlock is dropped and a local is used to drive calls
to hfi1_qp_wakeup().

Fix by moving the sc->piowait into a local list and driving the wakeup
calls from the list.

Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/pio.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 489b436..3d42bd2 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -878,6 +878,7 @@ void sc_disable(struct send_context *sc)
 {
 	u64 reg;
 	struct pio_buf *pbuf;
+	LIST_HEAD(wake_list);
 
 	if (!sc)
 		return;
@@ -912,19 +913,21 @@ void sc_disable(struct send_context *sc)
 	spin_unlock(&sc->release_lock);
 
 	write_seqlock(&sc->waitlock);
-	while (!list_empty(&sc->piowait)) {
+	if (!list_empty(&sc->piowait))
+		list_move(&sc->piowait, &wake_list);
+	write_sequnlock(&sc->waitlock);
+	while (!list_empty(&wake_list)) {
 		struct iowait *wait;
 		struct rvt_qp *qp;
 		struct hfi1_qp_priv *priv;
 
-		wait = list_first_entry(&sc->piowait, struct iowait, list);
+		wait = list_first_entry(&wake_list, struct iowait, list);
 		qp = iowait_to_qp(wait);
 		priv = qp->priv;
 		list_del_init(&priv->s_iowait.list);
 		priv->s_iowait.lock = NULL;
 		hfi1_qp_wakeup(qp, RVT_S_WAIT_PIO | HFI1_S_WAIT_PIO_DRAIN);
 	}
-	write_sequnlock(&sc->waitlock);
 
 	spin_unlock_irq(&sc->alloc_lock);
 }

