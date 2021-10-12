Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE9F42AB46
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhJLR50 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 13:57:26 -0400
Received: from mail-mw2nam10on2104.outbound.protection.outlook.com ([40.107.94.104]:15508
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230522AbhJLR50 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 13:57:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrELiUJW40IdajMlp3mSCZ9+HnWW94x/Txw6uO7YAqq3PJBtq+JNM5KX8q59R8V0cyi8lH+4uIPe9Krz8CIkbyP/pESENp634lYVn5MgB8xIuT36MyIOH7mhq2lK48EEOKant+jO1Gbqy+vO+77hGrOW6UoiROxwqDBgGfF27B3uyEuA8Vxxb4tR8BEvdV1IhuZc2MKwZWXKexh0pvXAgc3183VuXjVR6Kn1uzxag034knbUeNrXJ9f41mWP2bIyyRkP0isME57ni6YobTFG+fJsKWnlhss0jQsZJRJcRBibUEa9Xu+w7XNmfR6ylLLtB2aQ5NeQJ9gdL7f31KscIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JShHR6PXohQi/ci+X1HK3poOXqe0/OSjGj0xTa9gE1k=;
 b=Muu5YhSMTUEiND0ITwKCppYdp0q++irwNmOYsJNW09hl1wac1k1MsC2+RMOvVNa/lMg+dC6sfRmyR4PIpYecAcf+TZOCB/EOpaKHLlbS3GAINp0LD/7db7D0edJxTRyWMVHxG4hjWSbbd44E0hLg74lW0FFfZ7WbQdsiLHHyfnyMASo8h+fT9GwzGbCSuJejIJbXMOX3n7g09Ipwm6EwevuO7zJbUshcdTf+p0xObzPNvgtAukwIyCgc4JAEdkf00uJg60A/EPdTDAscxI4YTlr6NoBE6KIwxe9Nh8jF8K/2+Bsjz5X5V2u575DvhHAwpG5USJiA9BvShwA9/27Ntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=ioactive.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JShHR6PXohQi/ci+X1HK3poOXqe0/OSjGj0xTa9gE1k=;
 b=hPV8bDf3IXjfrtoI/NMi01bKgdwURftDgqZy3GA5E9QYohyRUyYc4NpGrFzF+SGUIod1EqN8erEAmCn0M38ytyc27m/WxzdAL3pEoY2yLojN1aLefkLeCI45c73V12oV252AyTFw5YRuVypcnLKjL8dBk/OFGl3TMVJEdjLK3xyOCCrJ/bQ9LByZ6XsgxKrVS3QgNjBNdvxlSBE8g6BMg4T7oHE9wkhNTpDvhDPgm5h88d7z19wuHm9AXe22LsR86i5wElGq7tsZG+Wq75f8VCsCjcuZgHsKGQ4VYUFDPc3X9X3uJuPb1ZOZosZlDCJ+Lktw1bWdrHNzWrRGLdrpjw==
Received: from MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::28)
 by DM6PR01MB4092.prod.exchangelabs.com (2603:10b6:5:23::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Tue, 12 Oct 2021 17:55:21 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::d5) by MW4P223CA0023.outlook.office365.com
 (2603:10b6:303:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Tue, 12 Oct 2021 17:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; ioactive.com; dkim=none (message not
 signed) header.d=none;ioactive.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 17:55:21 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 19CHtJjJ007328;
        Tue, 12 Oct 2021 13:55:19 -0400
Subject: [PATCH for-rc v3] IB/qib: Protect from buffer overflow in struct
 qib_user_sdma_pkt fields
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>
Date:   Tue, 12 Oct 2021 13:55:19 -0400
Message-ID: <20211012175519.7298.77738.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 269d051d-0c6b-4a57-dd98-08d98da9759c
X-MS-TrafficTypeDiagnostic: DM6PR01MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR01MB4092756FEFCA958EA754941FF4B69@DM6PR01MB4092.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBl7wsuLtc0vvRDlaqhvfbjJBVd74jJ3hrMfX1Lq+1dthEBD7WJvqV9oK/ngbX9JtqsyboDGm2wWWzBwHHIqFPNwhwxXtVfeJN2n5wRBkM4tcuHREAFqU0kV6COksJc+4Q/rjKPmC3jnEtPUSG+bk8CjkFK5dNkucDgH6WklMLeH/kEG7zBF+/kbEXeM8nLcNnDTGPktOvczQB7oP3wWwR4wOB22jTFMTEtbk0vvD7JbagnV4df2OWCUhStYOGO7mtAs+k+o0vDhkaJkIBDW1uORRUrOowlJj3eBM3HmTP7tDBo8KiYynR7C9nuVZ255vabhEVeVKSs5l57Li5nSXKD3JIdlRfZCQj1YMNXUf1liRVCro3UPRkVnqZu0s8oxAemwdzAtgq4rkTUVFYES2NPEZk7bZjgzJ3og8Xlq4AlDEyGRtfYrVv1AwuexhQq4oBpNRNVlk/wXqsWEpwk8Vbj7U56zRH3tazlZOBM8iv9Kstjf6Agj2cbKQdspJ0Vpgv7zXiyXed0I7AfrYVrLeFBiSwx4jGF2pSrKplC1YQUuDMI/rwyANskqSrcjkkSt8OvGapAkWdi5XHGV55JXsouwYCwBPY5WPHhfUdxoDyBOGnnQuhzjIxXNpbggZ9jx1WPfNgOUpsyTWawhQyzWZ/vEMgvgUc8KHo8lic/kcYQOfh2ww1iT7oHPzxu7VSJitd62nEnmBmTHhdTEJBqiVFkemxOp/BR0cC4sP/Sxoks=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39840400004)(346002)(36840700001)(46966006)(36906005)(426003)(8676002)(83380400001)(8936002)(336012)(82310400003)(2906002)(1076003)(70206006)(7126003)(186003)(70586007)(54906003)(26005)(5660300002)(7696005)(55016002)(81166007)(36860700001)(47076005)(356005)(508600001)(86362001)(44832011)(316002)(103116003)(4326008)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 17:55:21.0210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269d051d-0c6b-4a57-dd98-08d98da9759c
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4092
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
Changes from v1:

Incorporate Jason's suggestions and update commit message. Also added on the
fixes line. Mike identified a different commit that is more directly
responsible.

Changes from v2:

Remove unnecessary hunk.
---
 drivers/infiniband/hw/qib/qib_user_sdma.c |   33 ++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index a67599b..ac11943 100644
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
@@ -904,8 +908,7 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 		}
 
 		if (frag_size) {
-			int tidsmsize, n;
-			size_t pktsize;
+			size_t tidsmsize, n, pktsize, sz, addrlimit;
 
 			n = npages*((2*PAGE_SIZE/frag_size)+1);
 			pktsize = struct_size(pkt, addr, n);
@@ -923,14 +926,24 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
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

