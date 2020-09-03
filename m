Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D693325C8F3
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgICSs7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 14:48:59 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:40670 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgICSsz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 14:48:55 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f513a930002>; Fri, 04 Sep 2020 02:48:51 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 11:48:51 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 03 Sep 2020 11:48:51 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 18:48:37 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 18:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqVKqnncd7KMC9RZuN0+ahGC12hsvc2nFno+B3AAaOo3/pn/gHZH5zwyhwbHBxYWejGok6VarWJmqYuPddjtBKZzvyPm6bSexAimPsGRruhLeqUzfgBpoNVtVl1FKAnSpU+2AfzNNvO4zpkoIKHBzIUkdHFEPYabeLJx2h5szF/yBJeljIlYWU/ZcdhUISWQ2Bw131cYKZRCsiJq9p7n2LH2k1+xzExAUsOXpfwGMG81tZDhaKgGrkkDGHFYlc6SbUApu1vypQEThfEQgYqWTh+VTx8bEirvbdhAa0/1rWQZsKYjDsNqfTKk9NI9D0Uojq85cGCol6YeZnmXy7bplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H9XoietyiOsBLUIFn6H5oXHz1xqKqJTIEqnk6Hc0UM=;
 b=ZD+PGhXDh7rbp8h3xhAmmzMuSTqYUDibmbWw8JQuIO9Rj+YPVvO/pJ5KyWjhQ3acRiAcsWjPmCrDxnHlRSot4mA/04oIUrqqSDj31iLUJ70EQ20NAOZusdr3BN8Btn9MeyP4ZLLZnsK2EkcucUiQt7ZHfp/u4tl/abPQCMy9WTZlVIEZ0GODcO6AR1kR4li/u2xZ2/aGZ8a+9LntfH3Zh/u4dYESqwxGZA0+kAS3rD/cTp4GVcFH9wrJFYu2OI6vaaZFEXgHMM1axbWlfFMYnLhcBNv5QdM5CEzmbJgXxR3iT8GUp3+6y+A3KkzLVm+xw6Ch4kkngRr05eO4p6exJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 18:48:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 18:48:35 +0000
Date:   Thu, 3 Sep 2020 15:48:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ariel Elior <aelior@marvell.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Zhu Yanjun" <yanjunz@nvidia.com>
Subject: Re: [PATCH 14/14] RDMA/umem: Rename ib_umem_offset() to
 ib_umem_dma_offset()
Message-ID: <20200903184832.GA1575084@nvidia.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <14-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:208:1a0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 18:48:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDuHg-006jCO-Kr; Thu, 03 Sep 2020 15:48:32 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28008531-4d69-4b0f-d53e-08d85039f5d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB445112BA8B913EC030425B26C22C0@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kF6/nwv6lTK3yUfXGWQwvqFN4CDsoIaUIP2PnDGDF8/QW1FboZA0L6lLz6cFhlVAoWWxC5SjoRtJUG4xTv1O6x0XOVFx8mkOQwzf61vqugE8D7iyA0HL+cBwBlKemVntPnbjTteOjfNqZzyrFaMsdDMbFAJ/4lu9M85KULy0M/a2SDmHJ56qJNPLlAHjWwHGmYqXMbB315BwSsQXYxrPYk1IeCYw2tWZR+CpQGhgzeleATj4R0QHkrxgGl0v1GG06pLwfcxqxpXo3lYLUJd1gAsG0S9jD8Ec7ZaK7n5ZoFE2MFD4pobpnxGVaSycm6k/9bDs3C1z2VQ+UA0zmLuopg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(36756003)(426003)(33656002)(8936002)(110136005)(478600001)(5660300002)(2616005)(1076003)(186003)(6636002)(66556008)(86362001)(66476007)(83380400001)(316002)(66946007)(9746002)(26005)(2906002)(8676002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: w7JdKPHszl7YomiPwMrTOF41P5e0tA8mqqD+eJ3/aA4bnztz1igdHE7YQOrjofMCs1Afor07+U3AK8Tj/PtgLUww6qovoVxJURkuO2sbjn+99LXYH/oI/azXgMYa+JkXyvKDCEOV9N98470hA4FSFZbQXbLdtOKM4xFrfOj83qg3dsvGDe4pcuEFy/8CfMQ5iNgLx0NwOrrmfqaf8Y2O4E4rPN5QJP4jU2U+tUs8PMZdBq/bZSJYHDxgRt4iFBE/4nesznI9VBXtCBcQVfblMpY0LQbfH581kQ9d4iVP2I0QmK1oujQa4NXwufhtgjrNU0n774aPmkR+aZ90dFMru9CYKxCQuzu9DjLYE26DOZd9sfdXvHiVsK1bQKgEnv5WHfCmoVFJ19Kqg+Iw5vwJV1U/9GERVwznjervGOpVd5XovexTE9VCRsZgOThwj6ABz7tn9BvusFLQ3hTrvQSvqb6dLI81e9H9sQLtk0bU4isytrueFmaUdvrgEHuqIofQgVl0ggDGL+DuAMXRNrD/Yq2ZCK83FFaTNTEiBqGW+bramc+VJQ7HztEU3C6a88fIwU7aMC4sdGJsxcyVL4Eas9DnScvIdhjtYwXVEQRYzNbq1Vh5kuuzI/5rsxNUykVwP2TDek0DRKhL/LxL0ScDyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28008531-4d69-4b0f-d53e-08d85039f5d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 18:48:34.7136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBz5t4130isjUOylKEI9jWGuou3loQN5QaP7dQ8xdKDvzkmpM2Fm19NSoSTcc1GJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599158931; bh=3H9XoietyiOsBLUIFn6H5oXHz1xqKqJTIEqnk6Hc0UM=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=GsvbSpjtaxBIi2FwSXKMk2Ppg9ehn0El8spqffkeCKAQ4hUZ9CzS73C5dDC57WvXj
         5Ebd6x43VzMsPotj4+8a6VW9N5Wpp3XwvheHbf5lZ7Nyal/uj1q3xTEDs+JlLYriCd
         15YRxnlO64Z6v6dM3KMoiLV76q0TumDeNRsvm6EfdCa/mwcRGfLs+1wYfKV7Zgz1LR
         8xyLzJhkXcEJKqX3R74BfHO0+tCgYs9ekD1stn/vOJDu0tbGCedcWIkFTjFxjIjGKn
         ukysSMnEZG5YR00xYAUGqOkXdlldFnR1tRLUwB+VEd1Mlm+AMG/cavdhY9q6MjhKUG
         P2oVXWBgM5AVw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 01, 2020 at 09:43:42PM -0300, Jason Gunthorpe wrote:
> +/*
> + * Returns the offset of the umem start relative to the first DMA block returned
> + * by rdma_umem_for_each_dma_block().
> + */
> +static inline int ib_umem_dma_offset(struct ib_umem *umem, unsigned long pgsz)
>  {
> -	return umem->address & ~PAGE_MASK;
> +	return umem->address & (pgsz - 1);
>  }

Actually on greater reflection this is wrong if pgsz > PAGE_SIZE, as
umem->address has nothing to do with the SGL, and certainly doesn't
reflect to anything in DMA drivers. It should be IOVA.

I'm going to drop this patch. It looks like the only two drivers that
use this should be using IOVA anyhow:

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma.h b/drivers/infiniband/hw/ocrdma/ocrdma.h
index fcfe0e82197a24..5eb61c1100900d 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma.h
@@ -185,7 +185,6 @@ struct ocrdma_hw_mr {
 	u32 num_pbes;
 	u32 pbl_size;
 	u32 pbe_size;
-	u64 fbo;
 	u64 va;
 };
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
index e07bf0b2209a4c..18ed658f8dba10 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
@@ -1962,6 +1962,7 @@ static int ocrdma_mbx_reg_mr(struct ocrdma_dev *dev, struct ocrdma_hw_mr *hwmr,
 	int i;
 	struct ocrdma_reg_nsmr *cmd;
 	struct ocrdma_reg_nsmr_rsp *rsp;
+	u64 fbo = hwmr->va & (hwmr->pbe_size - 1);
 
 	cmd = ocrdma_init_emb_mqe(OCRDMA_CMD_REGISTER_NSMR, sizeof(*cmd));
 	if (!cmd)
@@ -1987,8 +1988,8 @@ static int ocrdma_mbx_reg_mr(struct ocrdma_dev *dev, struct ocrdma_hw_mr *hwmr,
 					OCRDMA_REG_NSMR_HPAGE_SIZE_SHIFT;
 	cmd->totlen_low = hwmr->len;
 	cmd->totlen_high = upper_32_bits(hwmr->len);
-	cmd->fbo_low = (u32) (hwmr->fbo & 0xffffffff);
-	cmd->fbo_high = (u32) upper_32_bits(hwmr->fbo);
+	cmd->fbo_low = (u32) (fbo & 0xffffffff);
+	cmd->fbo_high = (u32) upper_32_bits(fbo);
 	cmd->va_loaddr = (u32) hwmr->va;
 	cmd->va_hiaddr = (u32) upper_32_bits(hwmr->va);
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index c1751c9a0f625c..354814b2978d51 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -878,7 +878,6 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 		goto umem_err;
 
 	mr->hwmr.pbe_size = PAGE_SIZE;
-	mr->hwmr.fbo = ib_umem_offset(mr->umem);
 	mr->hwmr.va = usr_addr;
 	mr->hwmr.len = len;
 	mr->hwmr.remote_wr = (acc & IB_ACCESS_REMOTE_WRITE) ? 1 : 0;
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 0bdfa300865d57..b7ef05618993c4 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2888,10 +2888,8 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 	mr->hw_mr.pbl_two_level = mr->info.pbl_info.two_layered;
 	mr->hw_mr.pbl_page_size_log = ilog2(mr->info.pbl_info.pbl_size);
 	mr->hw_mr.page_size_log = PAGE_SHIFT;
-	mr->hw_mr.fbo = ib_umem_offset(mr->umem);
 	mr->hw_mr.length = len;
 	mr->hw_mr.vaddr = usr_addr;
-	mr->hw_mr.zbva = false;
 	mr->hw_mr.phy_mr = false;
 	mr->hw_mr.dma_mr = false;
 
@@ -2984,10 +2982,8 @@ static struct qedr_mr *__qedr_alloc_mr(struct ib_pd *ibpd,
 	mr->hw_mr.pbl_ptr = 0;
 	mr->hw_mr.pbl_two_level = mr->info.pbl_info.two_layered;
 	mr->hw_mr.pbl_page_size_log = ilog2(mr->info.pbl_info.pbl_size);
-	mr->hw_mr.fbo = 0;
 	mr->hw_mr.length = 0;
 	mr->hw_mr.vaddr = 0;
-	mr->hw_mr.zbva = false;
 	mr->hw_mr.phy_mr = true;
 	mr->hw_mr.dma_mr = false;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 03894584415df7..0df6e058775292 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -1521,7 +1521,7 @@ qed_rdma_register_tid(void *rdma_cxt,
 		  params->pbl_two_level);
 
 	SET_FIELD(flags, RDMA_REGISTER_TID_RAMROD_DATA_ZERO_BASED,
-		  params->zbva);
+		  false);
 
 	SET_FIELD(flags, RDMA_REGISTER_TID_RAMROD_DATA_PHY_MR, params->phy_mr);
 
@@ -1583,15 +1583,7 @@ qed_rdma_register_tid(void *rdma_cxt,
 	p_ramrod->pd = cpu_to_le16(params->pd);
 	p_ramrod->length_hi = (u8)(params->length >> 32);
 	p_ramrod->length_lo = DMA_LO_LE(params->length);
-	if (params->zbva) {
-		/* Lower 32 bits of the registered MR address.
-		 * In case of zero based MR, will hold FBO
-		 */
-		p_ramrod->va.hi = 0;
-		p_ramrod->va.lo = cpu_to_le32(params->fbo);
-	} else {
-		DMA_REGPAIR_LE(p_ramrod->va, params->vaddr);
-	}
+	DMA_REGPAIR_LE(p_ramrod->va, params->vaddr);
 	DMA_REGPAIR_LE(p_ramrod->pbl_base, params->pbl_ptr);
 
 	/* DIF */
diff --git a/include/linux/qed/qed_rdma_if.h b/include/linux/qed/qed_rdma_if.h
index f464d85e88a410..aeb242cefebfa8 100644
--- a/include/linux/qed/qed_rdma_if.h
+++ b/include/linux/qed/qed_rdma_if.h
@@ -242,10 +242,8 @@ struct qed_rdma_register_tid_in_params {
 	bool pbl_two_level;
 	u8 pbl_page_size_log;
 	u8 page_size_log;
-	u32 fbo;
 	u64 length;
 	u64 vaddr;
-	bool zbva;
 	bool phy_mr;
 	bool dma_mr;
 
