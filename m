Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF1925A266
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIBAoP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:44:15 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:14272 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgIBAoI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Sep 2020 20:44:08 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eead40000>; Wed, 02 Sep 2020 08:44:04 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:44:04 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 01 Sep 2020 17:44:04 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:50 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwW3xPUktR709nNg7UvmtEhtlTtdg1gDSm5dJ62OJGHL+oWJRZb6cRu3+61HjKGlFcosgl1Vk9rIZab8SIPqlZLNoVyR4Hpl0MvncMaHu+RCNriGKwNR5AbILoKhGMRRgKzyTZEqfjj8VHXf9bjtJrpQwBTwh7IndfZNBtoRVYcAaVMgAcpQ0i9E8pCoioXKYsVvbCD1Qfbz8FAdT/gqWFgJdYHMB3hrLxlPAGzEPudIItJLCFKz6KgbJy+AYe2xzJcAuI/Vp9rG9t5GAh0IsHwOHAS1LbzVi9nTi8jTslLcX9ciqT30Gupkn6x/hfE4a5WdrLmD81A7/NLb7JcuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xd7J3ytyr84NpsCDV99kItcCsLrl1/4KM+yHHz1ysk=;
 b=f3//d5DW6ccAAtXHDMOoL+FeaYQ7QKZ9CmH5ZOEV9VvvcOd8TMKjWDzvkU+vgUHNfOzsxxmPFayUepJ0C1xnVntL7gPxIF4YOT6uWVk1OlLHX+4GMykfshIkOUThuR4Zz3+XkhJ5227ymjaf2S56XiXW20YRIujL+7RgcUCq5UlLr74iUSrVOWZaIU+HO1ihGVLxWiDqwlo3Kq0DusCrGrOndIECeyCOmUUyv7IQLtJwsja/mHJIqfXcyry6zJUuY2Qx712lx9TKVz6Y5lJdAXGZsjqN9trBHzdrp4/DaZoDXZ8Sd62Gd8DYqBFBm17+ZuaslF9Td/79WTwiGbjoyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:48 +0000
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
Subject: [PATCH 14/14] RDMA/umem: Rename ib_umem_offset() to ib_umem_dma_offset()
Date:   Tue, 1 Sep 2020 21:43:42 -0300
Message-ID: <14-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0029.namprd15.prod.outlook.com
 (2603:10b6:207:17::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR1501CA0029.namprd15.prod.outlook.com (2603:10b6:207:17::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 00:43:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsJ-005P1j-C7; Tue, 01 Sep 2020 21:43:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75e07d74-a39a-4dcb-cf48-08d84ed94092
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3834B4DDAE9B49F5CB3ED937C22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIKfdwoIq3PEaOCSDP5uDVnr957b23NvBIcFlBFLJ5iBsQr4P/7tbYPGlStKUl1tEqG7yxaAZ6ehOHpjEBBURVWTFPW7iMaxaEpZt72V3JOoj5zU9pEUrJJ5w3MtsATgG13D72VSPgPWASjULglyFDNd5LAHqrdeir8k+3fPl5hPbQLu+IFotvizjmwHuW8TMbeWNJHd0k7FIyZ0di07/QvT/+6QkAccENoYb3tGpVCRGfaQuU9g2wwkADucil/Acad4GyeqwwAfkoFx8O7+bsoXmgy5OJ9tyYzFc+74uJMBOhXJjdEfac+89eSXqboGeWekATDEhPGyrbuwqnzLsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(6636002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +qccY3+lReE1M6DacgFifRHQNl15Lrt/e81ozHR+3I9oGQ7WF0vl4oy9nHhSqrWa9r1k+jeD5DlAdfRTNb9pOiWo4oUQ3oizxdsJqUir+90N1CD7F+fImMHMDJCW3c+71Xom46DKOCJGGJmekWe//DuKPZykXPtANoXeIfsmfV5KgaG//etrQykoVK2Z+qO/YXO2R1r/0lH2fIHsyVweCV5BoZYRTbXL/qLMDOV1qmBpZDHyXueMZPsMfLYj9N8LL1zy2r1hSUqPAVRnN0eCXF7oFgm+CsytddyDBxrDthL6rgb1MqI5DiasyaeTN7FZQNWiPc2+lzWKvEatgPa3Wzs7sGCnYcAhwwIT12fGHz9WIPN0OXVXg1y1RpTiNJNQALeWwoFAa8TJs+HcKanpepQHNnKC6e8MVX0VNp5SaTeTANG1UC5xTqE8ipAujZLxeoQ/0fip5OEAFnETdsXSFsdkkyN831K2QVumJQ8FsA7SCSduxtJZAc9Xb5xoeC234wYYU1X4FJARohX0g5o1i5mmX7oPSL+3Dtky/1LYpw13+aMjl5n/9EnI5vo2MlpOnMDI51p8iwl7kZG/kTJmtGj5t4RsEqkBQCUR6oAamQ41kiw8cHQutoMepJQbtaDqhc1uMnbtV+gD6y4f2bPRyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e07d74-a39a-4dcb-cf48-08d84ed94092
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:47.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YoDSswzwDa6ieCtpC19m56M0aCKGHexN727/ZDsZYqMIJoqC12MRpqk6fsrhAOab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007444; bh=2Sluy/UhJJF7J5SkPmaAkVXOV8+mAhplUY9Fa74y4NU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:Subject:
         Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
         Content-Type:X-ClientProxiedBy:MIME-Version:
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
        b=c1D1VKlr8H9jfjWPUe0Ej36ZyrZ4poONSmWryMbjL1+kyip+fVXI0OekF6a0/X4LN
         aE1MLs/zJ/3Ypj11KG2HZmzhvyd2S+sPwtgESxvvvYn35MPrOWweqSi71irMzfp5F6
         7fOYJ0Jt+9Y/dd7oqGiUEkrwhXPe6LPg/c/wiJPr6u9fQ8eLGgt1b5HtU4xy8X5poQ
         ffDJLe/leAg4+dHER6iD4Q7Icj0GtvRzGhdHyn/DbHIvhPVT6CtheHcF0oRnAna7hm
         lroBr41CwY8x8yJvyzQMYS2NhfBSPciN7o9/fXkXGctESbPQUZogQFdfYSTHUQMxvU
         7Rv03CTL/SoPA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This function should be used to get the offset from the first DMA block.

The few places using this without a DMA iterator are calling it to work
around the lack of setting sgl->offset when the umem is created.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/umem.c              | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
 drivers/infiniband/hw/qedr/verbs.c          | 2 +-
 drivers/infiniband/sw/rdmavt/mr.c           | 2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c          | 2 +-
 include/rdma/ib_umem.h                      | 9 ++++++---
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 49d6ddc37b6fde..c840115b8c0945 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -369,7 +369,7 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, =
size_t offset,
 	}
=20
 	ret =3D sg_pcopy_to_buffer(umem->sg_head.sgl, umem->sg_nents, dst, length=
,
-				 offset + ib_umem_offset(umem));
+				 offset + ib_umem_dma_offset(umem, PAGE_SIZE));
=20
 	if (ret < 0)
 		return ret;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_verbs.c
index 1fb8da6d613674..f22532fbc364fe 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -870,7 +870,7 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u6=
4 start, u64 len,
 		goto umem_err;
=20
 	mr->hwmr.pbe_size =3D PAGE_SIZE;
-	mr->hwmr.fbo =3D ib_umem_offset(mr->umem);
+	mr->hwmr.fbo =3D ib_umem_dma_offset(mr->umem, PAGE_SIZE);
 	mr->hwmr.va =3D usr_addr;
 	mr->hwmr.len =3D len;
 	mr->hwmr.remote_wr =3D (acc & IB_ACCESS_REMOTE_WRITE) ? 1 : 0;
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qed=
r/verbs.c
index 278b48443aedba..daac742e71044d 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2878,7 +2878,7 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u6=
4 start, u64 len,
 	mr->hw_mr.pbl_two_level =3D mr->info.pbl_info.two_layered;
 	mr->hw_mr.pbl_page_size_log =3D ilog2(mr->info.pbl_info.pbl_size);
 	mr->hw_mr.page_size_log =3D PAGE_SHIFT;
-	mr->hw_mr.fbo =3D ib_umem_offset(mr->umem);
+	mr->hw_mr.fbo =3D ib_umem_dma_offset(mr->umem, PAGE_SIZE);
 	mr->hw_mr.length =3D len;
 	mr->hw_mr.vaddr =3D usr_addr;
 	mr->hw_mr.zbva =3D false;
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdma=
vt/mr.c
index 2f7c25fea44a9d..04f7dc0ce9e44d 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -404,7 +404,7 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 sta=
rt, u64 length,
 	mr->mr.user_base =3D start;
 	mr->mr.iova =3D virt_addr;
 	mr->mr.length =3D length;
-	mr->mr.offset =3D ib_umem_offset(umem);
+	mr->mr.offset =3D ib_umem_dma_offset(umem, PAGE_SIZE);
 	mr->mr.access_flags =3D mr_access_flags;
 	mr->umem =3D umem;
=20
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe=
/rxe_mr.c
index 708e2dff5eaa70..8f60dc9dee8658 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -196,7 +196,7 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
 	mem->length		=3D length;
 	mem->iova		=3D iova;
 	mem->va			=3D start;
-	mem->offset		=3D ib_umem_offset(umem);
+	mem->offset		=3D ib_umem_dma_offset(umem, PAGE_SIZE);
 	mem->state		=3D RXE_MEM_STATE_VALID;
 	mem->type		=3D RXE_MEM_TYPE_MR;
=20
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 4bac6e29f030c2..5e709b2c251644 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -27,10 +27,13 @@ struct ib_umem {
 	unsigned int    sg_nents;
 };
=20
-/* Returns the offset of the umem start relative to the first page. */
-static inline int ib_umem_offset(struct ib_umem *umem)
+/*
+ * Returns the offset of the umem start relative to the first DMA block re=
turned
+ * by rdma_umem_for_each_dma_block().
+ */
+static inline int ib_umem_dma_offset(struct ib_umem *umem, unsigned long p=
gsz)
 {
-	return umem->address & ~PAGE_MASK;
+	return umem->address & (pgsz - 1);
 }
=20
 static inline size_t ib_umem_num_dma_blocks(struct ib_umem *umem,
--=20
2.28.0

