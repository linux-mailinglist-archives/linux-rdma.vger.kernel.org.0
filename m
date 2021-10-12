Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DAC42A830
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 17:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhJLPZi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 11:25:38 -0400
Received: from mail-mw2nam10on2098.outbound.protection.outlook.com ([40.107.94.98]:57185
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233270AbhJLPZi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 11:25:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOohjtUmqJwc2vUME+UQ28bE4q6NRvhSeJ7KO5nyaUjB8zQCCTsUoQMwSLr5OYfbyw0ya7CIYl2H1eJdeCUqTJkfDzUe6RgBiosQHQsvMlbiXKJ8aAkMjT7y4OhWzSI1NP/HOL6oEOehKNsLDFj8RNYCGy1cGfrWPOZw5SEuyU6bdNfQcFDK8fsT6bZrk9g/55M6HK1Iw8rpVpDL425lYMklCwUHiBCe4xQWnI1lkhkT5PHISBw21DpSz/hflViFUT5rozrkKF4fR8skRJiCevMbW4Fk/KC0/EUjICQjMY2zj7a5fqY9TCG1x+9XINgYFesRA/XqkAPk/65m8dZ2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR9kuSSX/DmzLC8kX/fWAuF8ge+aC92yFlp+vh2dkB0=;
 b=LsxGG4vV9OOTOVfibEUcZJr4ItqXby1l1Hl/9RKXDkFiV7ZP7/AywLXkx9FWjniEtswerAoSQQ2BYdd/a/2uhQ7iK94xZvZOA2pqoQQkbrYcej4qZzjpGMEEh6DCKu9+5T29b8tzDx/qeEWVz2xuVXBsGkZ0weiCr9q4YVXlDU+4nYOEZ4kjw8czMMSErz+Uy3h4KZH9AvAAFDY2bz+0NxtLtX6lOyi41bbrUjCGTUxzJLw1Oqj1iZmX0I8/vBPfvoddl8Aboo7X2JGYKEYhHQDd9RCAOz/CRbCOofBBpqesybDNUkqxWf5IYyawIy7mo5Cse3ZzsWeMOv5dpong2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=ioactive.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR9kuSSX/DmzLC8kX/fWAuF8ge+aC92yFlp+vh2dkB0=;
 b=KV9HvrOHH9E+2wTcvv67PnoBdBdskIE+BebEh1QRxBAyuCuFMyOd3GZ2H49kkv6/os9nea+YXscNJbt/cA+KX2JmQiV50q+gcitZjqXawbQu4rfC42Z7op6sSvpi+4QazI2O+4jvllIYL3OZRubrCqvsNWLDjw2uLzRF79cjSVPvphj/VSoF/5OKGNzF8mGRF+EKOeVUOx9/njP1aSl2SiKgqOINOrQGkf6DlN5Olr23O3/DQHUb73wiFrBJK8kMpgo7363g6fN7NxsVEfMUPQVH2sn+4hRAdHzsXpsUMBUoWhLZItYRppK0dlTQW0dqsFJvDvOhz69b2VcPB3yAPQ==
Received: from BN9PR03CA0100.namprd03.prod.outlook.com (2603:10b6:408:fd::15)
 by SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Tue, 12 Oct 2021 15:23:33 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::81) by BN9PR03CA0100.outlook.office365.com
 (2603:10b6:408:fd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Tue, 12 Oct 2021 15:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; ioactive.com; dkim=none (message not
 signed) header.d=none;ioactive.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 15:23:32 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 19CFNV9Z064364;
        Tue, 12 Oct 2021 11:23:31 -0400
Subject: [PATCH for-rc v2] IB/qib: Protect from buffer overflow in struct
 qib_user_sdma_pkt fields
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>
Date:   Tue, 12 Oct 2021 11:23:31 -0400
Message-ID: <20211012152331.64324.70193.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9288bd3c-7c61-4cf5-a1da-08d98d944050
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR01MB44450EE8CC5DCE9615F93460F4B69@SN6PR01MB4445.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLmRrO17XcijSCauzSh57WXYcwrrZTBI6S4Baro7U7IRGZQh2hf8QcgVBrSS4c1Mvx2K8B0m/nE46YXfZ/KhtNz8ojJUatSCpUyMDMBKP3ZiIQkZwkSPwMhUUJUtjUipmZQoR4PiLsgPyal2H66YhmrlO8L78kA45QKMEosPjZVYmbSGtbOWUWvf1ErStwuP46PpXVEzBrnliB4vSVg9uKm75d3qtrtvzVL/tR0XZKlXlSMy/rxrf9AkQ0oHC5PDkbFm1eIKJb0NIavku9rmB3SZfu2SjtZ4djb6o+1EQlnvSPypPi/ze/KewfS9QKoCUPrK5aYN3Ws+BeAgBIMMVst9Fiz8zVCLKU6sIOciZIk2IyCWATegWfqrK4S5Ay1aoZxLikU7Y+uxhmIqDj0hbaBaHDBXQf7pFwjcXvbursTWSbzytwrsU+gxM7CzmI464e1PP5ZdI9ByB5dwR7lFKWgKyexRbTkq25Wk7PiLXDa1onDtYF8zcmpIKyviQDuQocBzle408mZyjgrHF8sX/z07FifW6hDoa5IvrHrjPsblqbyX2/ejWWI2QBU7g1W2IuizLMi4zVdSuE8nJ/dEldBhQNFVCGBA0+i+U6W1O5DO+4+bBhAm/vmWJwuE6zwoGA+WYWLOblikWHutRumdFILnoNrmvFGPGJh+C2V1xlRwJdAxAeTHQoRIRv5kn4U5o7TgFV/GpB6BeW3wVsWXcvvbQqOgHN/EYz1bJAmSYSQ=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39840400004)(396003)(136003)(346002)(376002)(46966006)(36840700001)(426003)(7126003)(82310400003)(1076003)(55016002)(336012)(83380400001)(2906002)(7696005)(508600001)(26005)(36860700001)(54906003)(47076005)(8676002)(44832011)(70586007)(5660300002)(103116003)(36906005)(8936002)(81166007)(4326008)(86362001)(356005)(186003)(70206006)(316002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 15:23:32.2928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9288bd3c-7c61-4cf5-a1da-08d98d944050
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4445
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

Overflowing either addrlimit or bytes_togo can allow userspace to trigger
a buffer overflow of kernel memory. Check for overflows in all the places
doing math on user controlled buffers.

Fixes: f931551bafe1 ("IB/qib: Add new qib driver for QLogic PCIe InfiniBand adapters")
Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---
Changes from v0:

Incorporate Jason's suggestions and update commit message. Also added on the
fixes line. Mike identified a different commit that is more directly
responsible.
---
 drivers/infiniband/hw/qib/qib_user_sdma.c |   38 +++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index a67599b..6af9764 100644
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
 
@@ -885,7 +885,11 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 
 			npages += qib_user_sdma_num_pages(&iov[idx]);
 
-			bytes_togo += slen;
+			if (check_add_overflow(bytes_togo, slen, &bytes_togo) ||
+			    bytes_togo > type_max(typeof(pkt->bytes_togo))) {
+				ret = -EINVAL;
+				goto free_pbc;
+			}
 			pktnwc += slen >> 2;
 			idx++;
 			nfrags++;
@@ -904,11 +908,15 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 		}
 
 		if (frag_size) {
-			int tidsmsize, n;
-			size_t pktsize;
+			size_t tidsmsize, n, pktsize, sz, addrlimit;
 
 			n = npages*((2*PAGE_SIZE/frag_size)+1);
+
 			pktsize = struct_size(pkt, addr, n);
+			if (pktsize == SIZE_MAX) {
+				ret = -EINVAL;
+				goto free_pbc;
+			}
 
 			/*
 			 * Determine if this is tid-sdma or just sdma.
@@ -923,14 +931,24 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 			else
 				tidsmsize = 0;
 
-			pkt = kmalloc(pktsize+tidsmsize, GFP_KERNEL);
+			if (check_add_overflow(pktsize, tidsmsize, &sz)) {
+				ret = -EINVAL;
+				goto free_pbc;
+			}
+			pkt = kmalloc(sz, GFP_KERNEL);
 			if (!pkt) {
 				ret = -ENOMEM;
 				goto free_pbc;
 			}
 			pkt->largepkt = 1;
 			pkt->frag_size = frag_size;
-			pkt->addrlimit = n + ARRAY_SIZE(pkt->addr);
+			if (check_add_overflow(n, ARRAY_SIZE(pkt->addr),
+					       &addrlimit) ||
+			    addrlimit > type_max(typeof(pkt->addrlimit))) {
+				ret = -EINVAL;
+				goto free_pbc;
+			}
+			pkt->addrlimit = addrlimit;
 
 			if (tiddma) {
 				char *tidsm = (char *)pkt + pktsize;

