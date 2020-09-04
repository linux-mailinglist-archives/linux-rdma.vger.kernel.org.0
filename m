Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A4925E3DA
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIDWmk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:40 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:26704 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgIDWmh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:37 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2ce0000>; Sat, 05 Sep 2020 06:42:22 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:22 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 04 Sep 2020 15:42:22 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:17 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHDCPqJEC9MZgXtTIJRMcE9znxGahr4WqD1+mmgAI/DyDg27YWVUJwICUWBB18Et0mdqHAaBKAoPpuDQ3TxcBxvrYyrkdCCpQeOcYmRY2noFRECuJHmmwB0NmsA1r7jhQWfYWlSXLOZnWF7pLqgctpcOy9URuMipsqHyDXGJ8zWhnafb/ICoYusOyWjYdDFhXYNcbSj4d9ywVbxFX1+nsxBQsfslaMjl5idvN+Wwht+UBbJRyNp2xc0IPq0V3VuvQUuurnqX8x5LHPempVXrOSCqfwhvzEJuuD66eUtsf+qNBu0+v1GKgVXm324CwPExgC42NEPlXHgeBj+EtFUcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D00Qzxhzhdr5BPLAZrw/Ap5G4iWy4TiReUTYKXLhA/Y=;
 b=fLMm9s4t3SyWR1PMK6nS/Zw58NuOYMstugUk5VNGANZG3ihO099OLqyBOO4MAHO2m/vWUgrktObhdOxh5DBP8+EWZeKK5z/sUpJHryKp31/ft/PvQifJsRUBJ433HFmQ3H0JPIG7953/DX/OKBJUD+k3beD4XzuIPjs1pzBjoVJRy0Odw5CZlvG5E0Mit+vguCw8Y2h+Fd52JZKiIFjhg1cNCluBpPiZblT0fJ0UXubBbccqsb7mfA/Pgr6nMicXcVGIghk8F1vPXg4x+5DqH+xH6CM/AxfcJzGjFMOgByBmRRn0zfuLKKbehYadP4QCODpsQsxtlj9Kn93IfTsGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2856.namprd12.prod.outlook.com (2603:10b6:a03:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 22:42:10 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:10 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 17/17] RDMA/ocrdma: Remove fbo from MR
Date:   Fri, 4 Sep 2020 19:41:58 -0300
Message-ID: <17-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:207:3c::35) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:207:3c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 22:42:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP9-001vD1-Bp; Fri, 04 Sep 2020 19:41:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df0056ca-8376-4d57-47ec-08d85123c040
X-MS-TrafficTypeDiagnostic: BYAPR12MB2856:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2856EFE67BA6D8E66AD78607C22D0@BYAPR12MB2856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppcPRkj5iA/InNhv2FsM/AOKoqDJlsNEg6V9ne9GBSUAOVscIXjCkaJ5uVVbNMk5TpA3FWG70nwFt7uM6ojdjPlMPJPw4zpYfAWHmCtF4//y54RN/QkfPPlu71vQdzbl6cFTKZe4NNICy+pVjwchh/WJIXGirJcnIe7Lnfk86YnoAfxnqHlHil+NZ5Z9G/ix0JSmxZtVZ/2Xsy/Ho+Sx6UNk2Nr4tOzN88PiuvlhBbgP7z0bN9WqMgUKYZjq9LH8mYNCsN/35V3FVBDe+Q40bbaSjUjBNrSuTMjlqtmZ2Q/e1xf4RMxxgmAfwu0xF7S2R92jIAsheISTaXrcJt4xKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(36756003)(8936002)(8676002)(9746002)(86362001)(9786002)(5660300002)(2906002)(2616005)(66476007)(26005)(186003)(478600001)(83380400001)(426003)(316002)(66556008)(66946007)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ntdgy/7KAj5wQrVvbdV1WhDajh3r8Ow0MQI1rQqqnvxrNmz3QLkRtc6aya/pm9iIi9QgBTBqEDMffvrvETo6Ls5BBLhGUBJQsBb3xDQUfuuHCau0HmqzPLVIQkj00SYYe01gJlVMYHFNCKgKLBJ/HUNs34m6Jm5HajBFo/VSh7y8NDRvorHEqWtRMh9Z5pWSnCij0JyncVUClEfwob/LCkFrkHgMVw2VNifyHcGyieC7oVYwt7j6mJrluCYFvrU3hm7X/M56485N39pJpTLU/I3TiLGRksaO23LH7/p2SgtrU9BColU0eEaeh8kj5r996JufRUcZ0uSKy33m+S7vX9gsp1FvStYdzex5iBJRzE8+ZybxzUyCkAwBAz4qhS1W6wWlBKR7ACMKI57uN9v0oOsMvQk63GuWMn6eLGt/fs/Zo0dJMXUL9pGv//nUDjqhQQROzPgPfA6tIZJJZeUMdHXRUsHz7lbxzEf59riTGO/2FYqBhPZNofj0a0toGwIiCheBqNuEBkY4ydyhXRG17AFB8O1UOzeJpGJSvrlbZJCIXkqoJcscyv12XRiGUH5XRbHFa4S52JAJcZ/bCrOXzpfsPIzm3gAF38ZdI9H1HlzFpDxUO3B9ycqqWmzdyrrvCZ/WjMJrCsfECTQ0r7w+Ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: df0056ca-8376-4d57-47ec-08d85123c040
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:06.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqGgfj7UwowaC7O0SN8VgG7AgF3K5tL+eq3uzbbWyJSYrd/JWqdTBfmbAhohW8lD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2856
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259342; bh=yWthnRm084FwnQf6BP4XrXIENEl6mNz2DAIec3GiXd0=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:Subject:
         Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
         Content-Type:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=X5N7OfbdgSzGJww4f7mWhOe4VtM6P8ThZozVTBNBd+o9Oxz3scknLd2hR8s0WjZ7o
         5TbgQo1Ye8HywWtezdtHQQI8A9TFsLjGPmWYWTAYJTFIcPka7WLXjpEjIj9/jkLUlH
         apQXanwKa7N0M3nGi6vPfeRHiqREG7Uuxk7OFPwLbYM+whSYrEdJsLH7YEtA6/UAY8
         D+b46z8LkEaPd8oiY/80Aww3vITikThQxqYA0gsKC5fFkpUhGLUsedivXZX7BcBAhY
         hjPbix2h97004LnqwBc3p7MEDQEWZ5tDUZm/csC7ddkLgl1IwWxydX2FXasFGRyspr
         hjX/zi6FCHJDg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is always the same value as IOVA masked by the page size, just use
that clearer calculation directly.

It is unclear of ocrdma hardware can actually support a true fbo, if so it
could use a different algorithm to compute the best page size.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma.h       | 1 -
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c    | 5 +++--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 1 -
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma.h b/drivers/infiniband/hw/=
ocrdma/ocrdma.h
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
=20
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c b/drivers/infiniband/=
hw/ocrdma/ocrdma_hw.c
index e07bf0b2209a4c..18ed658f8dba10 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
@@ -1962,6 +1962,7 @@ static int ocrdma_mbx_reg_mr(struct ocrdma_dev *dev, =
struct ocrdma_hw_mr *hwmr,
 	int i;
 	struct ocrdma_reg_nsmr *cmd;
 	struct ocrdma_reg_nsmr_rsp *rsp;
+	u64 fbo =3D hwmr->va & (hwmr->pbe_size - 1);
=20
 	cmd =3D ocrdma_init_emb_mqe(OCRDMA_CMD_REGISTER_NSMR, sizeof(*cmd));
 	if (!cmd)
@@ -1987,8 +1988,8 @@ static int ocrdma_mbx_reg_mr(struct ocrdma_dev *dev, =
struct ocrdma_hw_mr *hwmr,
 					OCRDMA_REG_NSMR_HPAGE_SIZE_SHIFT;
 	cmd->totlen_low =3D hwmr->len;
 	cmd->totlen_high =3D upper_32_bits(hwmr->len);
-	cmd->fbo_low =3D (u32) (hwmr->fbo & 0xffffffff);
-	cmd->fbo_high =3D (u32) upper_32_bits(hwmr->fbo);
+	cmd->fbo_low =3D (u32) (fbo & 0xffffffff);
+	cmd->fbo_high =3D (u32) upper_32_bits(fbo);
 	cmd->va_loaddr =3D (u32) hwmr->va;
 	cmd->va_hiaddr =3D (u32) upper_32_bits(hwmr->va);
=20
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_verbs.c
index 1fb8da6d613674..3b98a3b3e2272d 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -870,7 +870,6 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u6=
4 start, u64 len,
 		goto umem_err;
=20
 	mr->hwmr.pbe_size =3D PAGE_SIZE;
-	mr->hwmr.fbo =3D ib_umem_offset(mr->umem);
 	mr->hwmr.va =3D usr_addr;
 	mr->hwmr.len =3D len;
 	mr->hwmr.remote_wr =3D (acc & IB_ACCESS_REMOTE_WRITE) ? 1 : 0;
--=20
2.28.0

