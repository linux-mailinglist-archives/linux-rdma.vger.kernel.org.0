Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB81420A79
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhJDL6X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 07:58:23 -0400
Received: from mail-dm6nam10on2104.outbound.protection.outlook.com ([40.107.93.104]:25186
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229778AbhJDL6T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Oct 2021 07:58:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5az2Thd8VRFL+6KMBoMZ3Uj5WL+35b4YT++NS/CXQd60S4Rs+mG6Sgh/0mnBvqYeQa9SZuL+fSL+mRYUSQuDi334q2RCK0oALhX/b1V80/tOsNUAn7lMEFE/xqXoapIBzYxFwbsLp9sd5r+5yUxoPtSzXJhgu204Y16fdG6mBIIAUVaBbS+olCRoTbmWItG7EhxcMTYzUZR/uDXoowUqPGzFta9bn5nTdRvrXJ4d8dK0swK9Zc34KdrIuJHyffU1ETMYnurgmdCS/FPns+IQT7F1TNi6jioWkljl5QaY7kr8ck7qgczG1hFEzxVTd99sqL4ylB1mV4RUDUihSyvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX1UB5ovhoneFCSxvILcyrQPRZhSl28j+aHi2MxVCXw=;
 b=geaT0rcGO61DAL0/1vQIZVO0mAu0XahpY+gtINGgZE8M8IhuAvt2/rOgpFPgg0i+HRvsJmtangqn1ArLRnVjFEhDYVmY5mE9qxIDQMN63h5G3jfLO1xSZVYTFt2FIgppqETfa1386OWTvavzzusiYoSE5ujL1HaUxY7FWbunwvNTNs1ks6tNxbCpAbTpW7hkh5vSNiMh6EN2afSe+LZKZLiXr5zP3/8R4gmzdNo8c5AnsVokDJU8Nfx9y6a2iIiKk5+h+7jzQnnxYm7+vI/xkoXjioswbHoMFHvSNkut6FJ6tUKnTku6bxNE2R5JCho93iX6s/fmPAVT/9U4L8Ex6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=ioactive.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX1UB5ovhoneFCSxvILcyrQPRZhSl28j+aHi2MxVCXw=;
 b=WzJQ06CLxjcHuSnUv4WMXz4Y+XdvVCUceuEGAJfUzGqH3WiP7fe+6R+erss5wKdGSS6xyrEqwm8p2Xhc++6Z1Qi4ZJBr8dBDRgovxRfy7gyfPMqQx/QOwnIQNGp6xB4RUUuwvWykQwtow2Kf+b4YdGeT3dltR7Vau7QG57ZnpaIl72OJoASjJ6bGZB+TC2bYA+w9BJJvj5nYp91VWim3ZivXqhZsfACWT2zHGlXoS1aLVlo4vusvD+RC9AfWVQ2FKwx3pPNrbhon138NtCnvwf4VanSl15E8QIudDoh4TmuyaaM5i6so72E8iCDkD4TieyeYVW+YOCbGUbVLpnB38Q==
Received: from BN0PR02CA0035.namprd02.prod.outlook.com (2603:10b6:408:e5::10)
 by CY4PR0101MB3111.prod.exchangelabs.com (2603:10b6:910:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 11:56:27 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::80) by BN0PR02CA0035.outlook.office365.com
 (2603:10b6:408:e5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Mon, 4 Oct 2021 11:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; ioactive.com; dkim=none (message not
 signed) header.d=none;ioactive.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 11:56:26 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 194BuP7V119004;
        Mon, 4 Oct 2021 07:56:25 -0400
Subject: [PATCH for-rc] IB/qib: Fix issues noted by fuzzing on the iovecs
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>
Date:   Mon, 04 Oct 2021 07:56:25 -0400
Message-ID: <20211004115625.118981.81200.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84dd99ae-c330-4dd0-1268-08d9872dfebf
X-MS-TrafficTypeDiagnostic: CY4PR0101MB3111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR0101MB31118CC8FF6F8F4E8A05F90CF4AE9@CY4PR0101MB3111.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3b44d/CkZdjs+DNTBrzSBGR/m/DV4iABZE14DMhlSBOJwjteE+Qsonu4LW810mgqCj8BIuZIsxLkz32UBqpQFdrbfU9x9M8Mo0RT96khevr3DvOlP3OXtE3mzYGxWFtgQGJNv16AEOxUshfevBh2T7hCbmQopHlI5WabW7Mgg99vL29bACPC476nddWrGujpRK7P9qXlRuZRRw0LQXnNUBofil/Dx02JkLqHs8q83auun0pW2Pk15N3ccl5wrSiWr5H54E1rLIxla/GkcWaT1ziZ8G7GP40Z8UKqG0xjIR2ryfjCRtImPyjDEkeCgO4ATRYOe13XZWl9OC8Ythbg3l49B7jVabXWYaZHUBS74+peaVtP8NTjhm6Y2LiryCBmjN2f+wCz3dM1KKp93w30vtG+LvcQSwgBl04CRos7RLA7usQ3Ru52LPQX4bsuJArI9aYfqb2sEEuH8EbIi+H5ffUUj1pJhiUtKAQVPBM+EvaxUAdbKrNiXPltPW8Ls2hBsMLq/x7L1yv+kTEvDGokgfUS8DRiKGC9t4wCuOjLwQo79jF0mrSvwcRIjMln/Xky2HxVtu6DgUX3u/zJDB7bwFbUiaWq2aKwt5/fvwUK/3ULNGACo49lO65+U1OE5XxDgTKcIfnDpbDATkU9XWxPIHexWg7KzhYmJgCcwItT+AdSqylCUcowuGxM0ub60enXGGlG4jU/9myYeWkG50Hk4vXfZFjHYnxfnhhjxzjjPw=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39830400003)(136003)(46966006)(36840700001)(47076005)(2906002)(86362001)(36906005)(83380400001)(44832011)(508600001)(54906003)(316002)(8676002)(7696005)(186003)(81166007)(426003)(55016002)(103116003)(1076003)(36860700001)(336012)(82310400003)(70206006)(26005)(4326008)(356005)(5660300002)(7126003)(8936002)(70586007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 11:56:26.6459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dd99ae-c330-4dd0-1268-08d9872dfebf
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0101MB3111
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

Add protection for bytes_togo and n to avoid going beyond variables
in PSM pkt structure.

Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/qib/qib_user_sdma.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index a67599b..144c3de 100644
--- a/drivers/infiniband/hw/qib/qib_user_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
@@ -602,7 +602,7 @@ static int qib_user_sdma_coalesce(const struct qib_devdata *dd,
 /*
  * How many pages in this iovec element?
  */
-static int qib_user_sdma_num_pages(const struct iovec *iov)
+static size_t qib_user_sdma_num_pages(const struct iovec *iov)
 {
 	const unsigned long addr  = (unsigned long) iov->iov_base;
 	const unsigned long  len  = iov->iov_len;
@@ -658,7 +658,7 @@ static void qib_user_sdma_free_pkt_frag(struct device *dev,
 static int qib_user_sdma_pin_pages(const struct qib_devdata *dd,
 				   struct qib_user_sdma_queue *pq,
 				   struct qib_user_sdma_pkt *pkt,
-				   unsigned long addr, int tlen, int npages)
+				   unsigned long addr, int tlen, size_t npages)
 {
 	struct page *pages[8];
 	int i, j;
@@ -722,7 +722,7 @@ static int qib_user_sdma_pin_pkt(const struct qib_devdata *dd,
 	unsigned long idx;
 
 	for (idx = 0; idx < niov; idx++) {
-		const int npages = qib_user_sdma_num_pages(iov + idx);
+		const size_t npages = qib_user_sdma_num_pages(iov + idx);
 		const unsigned long addr = (unsigned long) iov[idx].iov_base;
 
 		ret = qib_user_sdma_pin_pages(dd, pq, pkt, addr,
@@ -824,8 +824,8 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 		unsigned pktnw;
 		unsigned pktnwc;
 		int nfrags = 0;
-		int npages = 0;
-		int bytes_togo = 0;
+		size_t npages = 0;
+		size_t bytes_togo = 0;
 		int tiddma = 0;
 		int cfur;
 
@@ -878,7 +878,7 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 			const unsigned long faddr =
 				(unsigned long) iov[idx].iov_base;
 
-			if (slen & 3 || faddr & 3 || !slen) {
+			if (slen & 3 || faddr & 3 || !slen || bytes_togo >= (U32_MAX-slen)) {
 				ret = -EINVAL;
 				goto free_pbc;
 			}
@@ -904,10 +904,14 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 		}
 
 		if (frag_size) {
-			int tidsmsize, n;
-			size_t pktsize;
+			size_t tidsmsize, n, pktsize;
 
 			n = npages*((2*PAGE_SIZE/frag_size)+1);
+			if (n >= (U16_MAX - ARRAY_SIZE(pkt->addr))) {
+				ret = -EINVAL;
+				goto free_pbc;
+			}
+
 			pktsize = struct_size(pkt, addr, n);
 
 			/*

