Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466E5662FD9
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 20:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbjAITEl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 14:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbjAITEk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 14:04:40 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2115.outbound.protection.outlook.com [40.107.102.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848593750A
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 11:04:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vj+C8WJn8lWEZ8vbzmyDhsVTf7R9Cg5+cWUiR8K8z/oSNKHdXPtrEGj7OOe4sp4eimJvGY7AbHbKI3TiILG09rIs1Z7Bfg9z4u1HhqLM3Vcg2SoWgML+sxDg1U01U/MnPJr9OxT8hk4cb0NXRgnp0jeZGCSGxgeWd6JEsPelGStYUm775cL1Nky3/fjEcojy2O7IZbOBGAkDcWoRSPluFVGYREUMbRAFNWNeMzgHNHnlpWvzvc9lz7Ey7wvHEjO0578JwDw4GMCRS2dRZWmf84c3ti8lkKJK8CCJAT70P9YkoWExSB9CNmFrLKv5mFiTBrpNenoJRHA1Mp8Z9aBlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9Gr1MsbFyYrCMFVhwONQDiOyHg5fvC7SXU/PPekGLc=;
 b=Z48nZiEpK+zHkqzYfxV+58UVCKwF5BiTz9xy9hxpSqtPnvOP36yWCQ/jgLrd46fIhfRdJ74ehseu1Guoa/lu5rJwSTAUxuSix3okUojv3A1SveBSMPMS+2Mm3z2VBUHVkb3xEIWc6isgF88JOCAb9UoTSKoUwLgB3TK1Xz7Ear/kxRn+E+FjxUVilAGclJ/QQPSAet0/AWus7H1LSHqqp6OTDtC/vE80wAz0fCsVaPKbdxn+w0D/d9OvpnK4wkEOzBwNyNQ11tWURBAGEgvQ78DEYluiHxyVnv0jXDyq9TB8t8adLO+4ZRKrIrJiqKRcd6jALvA4xbRMYyTsrbT2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9Gr1MsbFyYrCMFVhwONQDiOyHg5fvC7SXU/PPekGLc=;
 b=FDBBYVztGhl6Tg4BmpH8cLvFPH4B1nhpA84ZZZF42hkfS6CVRFJHWySKv6wepL8hAZiIzMTr0fvurAWftLUqmPaOWPuUVWL3Iwlr55sRdXuc4PYeemWRASYZiDH27MuFFKsH2L/s9KmF8vPzA+e8o7BQ3DPGBQ8tg/JhBaah3iG5Z+K+8RaI1KB0OXouFm2TsowzCP4X530M1Vst4PSMdoLvkkBVSiwY+aRsSHAJUHWVvySyjBuy/Y2+VBTpyzN2H2z90G/UqhBlQ4+HMMajHUFel7KDmHnEBTLguPaYOQXwXS9xGm8H1pJY/ywXUeP0jGAzgA0pqYdTHCyah9yjhw==
Received: from MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::17)
 by SN6PR0102MB3391.prod.exchangelabs.com (2603:10b6:805:2::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 19:04:36 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::cb) by MW4P220CA0012.outlook.office365.com
 (2603:10b6:303:115::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 19:04:35 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309J4YGA1477954;
        Mon, 9 Jan 2023 14:04:34 -0500
Subject: [PATCH for-next 7/7] IB/hfi1: Use dma_mmap_coherent for matching
 buffers
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:04:34 -0500
Message-ID: <167329107460.1472990.9090255834533222032.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|SN6PR0102MB3391:EE_
X-MS-Office365-Filtering-Correlation-Id: e01cdcea-252c-4670-509c-08daf274598a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJj5UrSFA8SXMKQDfM/9oSOHShq9f2BMesnilK0VM8n/hWwX6EZDjgDyzxJ6Oc3lgyh9T9yQyoHy3M+Z0HRuSuDJ3QEL1ITGddCwa8MPFK+bCIpQ5/VlZtM+UyrA5bJfQDM3kyrhbzuCRrHBn6QfpnR8wd3W5yOWuShCOM+Ym0kJ2Zab1PhA94GtDcqNpETws+GLUwIM2LbJWxk2kQ5WiqKXxr+ZGB171vi2uh/tYhxcdIWXuUizOygictnlL9tTly5ngTgnNR3slo9vpwx1TZM2vOkqAuMoRz7ptv2fciRQkJw3y+x07fn+CUmF4gUNrF+rw7Rc1BbsG1JV8YM5m+ESJcH+C0913tPE0Fax6ft4T4hzqm22TSiyueH6RWIcY1svsW97LlSZ//3azQqmjRPLmyWGU6c388TDRdaopmc5uwFkJQ6WYdlzqEE/FLSAnp94SM2e9I5GXvgMt7o/Cz4ffcZBAnMw1S0pxWPEUuNOVF9Itu3ZKuM2Uw+V7xoWmpd8TwQxKwIrRlhIK4V38hgFVG6y+SAdl16uhbgpAJmtIWmJwItwTYNndengwHBqWtY3ZPg9jP9P/0t1eAUuhzApWSPhk7zNlsXBdcDoyjZN98Dre0YzGbcDhPEq3pj/Ko/p5p9ZH2R9JGSEjRykcEWiLQMI5wr3NVSzH+NFZZ6qm2bIXSbx/ZmsvYtXVOEu6yQaIHVCojzQ1TBRxWk8pOJQxufoirtjS9LypaMLvKo=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39840400004)(451199015)(36840700001)(46966006)(83380400001)(2906002)(44832011)(82310400005)(47076005)(336012)(36860700001)(426003)(81166007)(7126003)(5660300002)(55016003)(7696005)(40480700001)(26005)(186003)(8936002)(478600001)(70586007)(70206006)(8676002)(103116003)(41300700001)(86362001)(356005)(4326008)(316002)(36900700001)(309714004);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:04:35.6992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e01cdcea-252c-4670-509c-08daf274598a
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR0102MB3391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Dean Luick <dean.luick@cornelisnetworks.com>

For memory allocated with dma_alloc_coherent(), use
dma_mmap_coherent() to mmap it into user space.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/file_ops.c |   81 +++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index c9fc913db00c..9703e863ef06 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -306,6 +306,17 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	return reqs;
 }
 
+static inline void mmap_cdbg(u16 ctxt, u8 subctxt, u8 type, u8 mapio, u8 vmf,
+			     u64 memaddr, void *memvirt, dma_addr_t memdma,
+			     ssize_t memlen, struct vm_area_struct *vma)
+{
+	hfi1_cdbg(PROC,
+		  "%u:%u type:%u io/vf/dma:%d/%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx",
+		  ctxt, subctxt, type, mapio, vmf, !!memdma,
+		  memaddr ?: (u64)memvirt, memlen,
+		  vma->vm_end - vma->vm_start, vma->vm_flags);
+}
+
 static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 {
 	struct hfi1_filedata *fd = fp->private_data;
@@ -315,6 +326,7 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 	u64 token = vma->vm_pgoff << PAGE_SHIFT,
 		memaddr = 0;
 	void *memvirt = NULL;
+	dma_addr_t memdma = 0;
 	u8 subctxt, mapio = 0, vmf = 0, type;
 	ssize_t memlen = 0;
 	int ret = 0;
@@ -334,6 +346,11 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		goto done;
 	}
 
+	/*
+	 * vm_pgoff is used as a buffer selector cookie.  Always mmap from
+	 * the beginning.
+	 */ 
+	vma->vm_pgoff = 0;
 	flags = vma->vm_flags;
 
 	switch (type) {
@@ -355,7 +372,8 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 		mapio = 1;
 		break;
-	case PIO_CRED:
+	case PIO_CRED: {
+		u64 cr_page_offset;
 		if (flags & VM_WRITE) {
 			ret = -EPERM;
 			goto done;
@@ -365,10 +383,11 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		 * second or third page allocated for credit returns (if number
 		 * of enabled contexts > 64 and 128 respectively).
 		 */
-		memvirt = dd->cr_base[uctxt->numa_id].va;
-		memaddr = virt_to_phys(memvirt) +
-			(((u64)uctxt->sc->hw_free -
-			  (u64)dd->cr_base[uctxt->numa_id].va) & PAGE_MASK);
+		cr_page_offset = ((u64)uctxt->sc->hw_free -
+			  	     (u64)dd->cr_base[uctxt->numa_id].va) &
+				   PAGE_MASK;
+		memvirt = dd->cr_base[uctxt->numa_id].va + cr_page_offset;
+		memdma = dd->cr_base[uctxt->numa_id].dma + cr_page_offset;
 		memlen = PAGE_SIZE;
 		flags &= ~VM_MAYWRITE;
 		flags |= VM_DONTCOPY | VM_DONTEXPAND;
@@ -378,14 +397,16 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		 * memory been flagged as non-cached?
 		 */
 		/* vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot); */
-		mapio = 1;
 		break;
+	}
 	case RCV_HDRQ:
 		memlen = rcvhdrq_size(uctxt);
 		memvirt = uctxt->rcvhdrq;
+		memdma = uctxt->rcvhdrq_dma;
 		break;
 	case RCV_EGRBUF: {
-		unsigned long addr;
+		unsigned long vm_start_save;
+		unsigned long vm_end_save;
 		int i;
 		/*
 		 * The RcvEgr buffer need to be handled differently
@@ -404,24 +425,34 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 			goto done;
 		}
 		vma->vm_flags &= ~VM_MAYWRITE;
-		addr = vma->vm_start;
+		/*
+		 * Mmap multiple separate allocations into a single vma.  From
+		 * here, dma_mmap_coherent() calls dma_direct_mmap(), which
+		 * requires the mmap to exactly fill the vma starting at
+		 * vma_start.  Adjust the vma start and end for each eager
+		 * buffer segment mapped.  Restore the originals when done.
+		 */
+		vm_start_save = vma->vm_start;
+		vm_end_save = vma->vm_end;
+		vma->vm_end = vma->vm_start;
 		for (i = 0 ; i < uctxt->egrbufs.numbufs; i++) {
 			memlen = uctxt->egrbufs.buffers[i].len;
 			memvirt = uctxt->egrbufs.buffers[i].addr;
-			ret = remap_pfn_range(
-				vma, addr,
-				/*
-				 * virt_to_pfn() does the same, but
-				 * it's not available on x86_64
-				 * when CONFIG_MMU is enabled.
-				 */
-				PFN_DOWN(__pa(memvirt)),
-				memlen,
-				vma->vm_page_prot);
-			if (ret < 0)
+			memdma = uctxt->egrbufs.buffers[i].dma;
+			vma->vm_end += memlen;
+			mmap_cdbg(ctxt, subctxt, type, mapio, vmf, memaddr,
+				  memvirt, memdma, memlen, vma);
+			ret = dma_mmap_coherent(&dd->pcidev->dev, vma,
+						memvirt, memdma, memlen);
+			if (ret < 0) {
+				vma->vm_start = vm_start_save;
+				vma->vm_end = vm_end_save;
 				goto done;
-			addr += memlen;
+			}
+			vma->vm_start += memlen;
 		}
+		vma->vm_start = vm_start_save;
+		vma->vm_end = vm_end_save;
 		ret = 0;
 		goto done;
 	}
@@ -481,6 +512,7 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		}
 		memlen = PAGE_SIZE;
 		memvirt = (void *)hfi1_rcvhdrtail_kvaddr(uctxt);
+		memdma = uctxt->rcvhdrqtailaddr_dma;
 		flags &= ~VM_MAYWRITE;
 		break;
 	case SUBCTXT_UREGS:
@@ -529,14 +561,15 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 	}
 
 	vma->vm_flags = flags;
-	hfi1_cdbg(PROC,
-		  "%u:%u type:%u io/vf:%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx\n",
-		    ctxt, subctxt, type, mapio, vmf, memaddr, memlen,
-		    vma->vm_end - vma->vm_start, vma->vm_flags);
+	mmap_cdbg(ctxt, subctxt, type, mapio, vmf, memaddr, memvirt, memdma, 
+		  memlen, vma);
 	if (vmf) {
 		vma->vm_pgoff = PFN_DOWN(memaddr);
 		vma->vm_ops = &vm_ops;
 		ret = 0;
+	} else if (memdma) {
+		ret = dma_mmap_coherent(&dd->pcidev->dev, vma,
+					memvirt, memdma, memlen);
 	} else if (mapio) {
 		ret = io_remap_pfn_range(vma, vma->vm_start,
 					 PFN_DOWN(memaddr),


