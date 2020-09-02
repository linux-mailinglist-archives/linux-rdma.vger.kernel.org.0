Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6D525A25C
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIBAnz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:43:55 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4702 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIBAnr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:43:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eeab50001>; Tue, 01 Sep 2020 17:43:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:43:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 17:43:47 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:46 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6EAMY4YbcRoIdycxTkBaxA/XPAKmNxmJdl4Mn9G8OSxi9VkXpMBI1eJ6u7BPY/IMhIAzOKJjGvbBQYMsz+3FfALRM7hA33kQnEvZ42P/t7s26nXXBU/Sl/KYhXC/zGdDKlUAr6bVztx/BAE4dI0+50NTyyqQupyarkuJoCmgS15NfiWwEwh7cCw/NRcs/imAB2szoWIzUJyPAWC1W/3BCugRPKv5jXXyP5bW+gESkz0lXK/IfNWjiT0fQwOmbL7D6VMUDSpvnVM3H4hxgaS2Hj0m7dCURFfbpJuaboBl2fOYbkdYg2b5ulzW9ZWs3q1TCTt8vR3sdQQ2gsobHMFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWlwu5h/Hpbzo+YuKOPphOqPYXKBsn6BeIKELN7PbAw=;
 b=WjZ0X8inVwp9MFOr+j3UlyaBRSSH6I06yufjSXFUbY86uU5XQJcnFqPw2gYp5GzniZJURt8C3dN0EOQbsqzcRIXgCLW1PwaUd0PBdTQ/pvBeSFTCLH0vzlOfUsTub1b6NQQMQc29IPDe1o4Rrm2JciRVuq5SALwnzqtbD3j9PKa5ychsIPiFzYRQch6hguttATYsJd9Jzdvx5pRua5rBVJKlxB8ckevVNAKCKMi2q5lNMrQNEBXFbiOP4yijyxOaXgn1zdJXUybu6EJ1LaVkGJwIry+TSnurIYR5ySB7/aMGKMQH28scEPTYK6tvTtOyySWGOGty4TmKLjer3nCYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:45 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH 13/14] RDMA/mlx5: Use ib_umem_num_dma_blocks()
Date:   Tue, 1 Sep 2020 21:43:41 -0300
Message-ID: <13-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0036.namprd15.prod.outlook.com
 (2603:10b6:207:17::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR1501CA0036.namprd15.prod.outlook.com (2603:10b6:207:17::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 00:43:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsJ-005P1e-AM; Tue, 01 Sep 2020 21:43:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aee878e-298b-418c-080d-08d84ed93f0b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB383469AB5477AD674E0C30A9C22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjf25/BhJq2BJzZUyCpNZgIGKS1xl2gu/C3q+G7nNovFkPdZu8x8/qPha51nLvX3tuenGwyDnfhdI/Xj7mPiLik8YM8KdI8UKRhXmew2iktnyLG3vApuw92JM2/88Ip66msOgYjYw16++W3zEGT/fIVXslD7T2xNLk4E1ZBEDo+7baCjOR8/GGpZOHZ5jA5LeJzhIXNAknwlOgfa1nOQa0JpfDcq4cISxU3sVGoxuLw23bN8aZuUZ8zhv5J7qfRTd8xuxrB9GECAQ1YEXNvEV4SKOSxDE7qwwCLSxHyUazyeuO80/iSiUrNJ6Gze4nk7QGbkO6ot4NOIJ+klHQojKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(6636002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +uAsEtpZO00RxYkTlWpGGLc/qR2k07TH6/FGV0ZdvAFM/T6ia4CCYVkDgeHivpNUpl4wK/Vs6iIxk1YyUKr9nEX4aCdi5KiAnoM/BzJdda1VLnAnyncY8Ir5gJMz8aDEIBSm24DmGRoGDDD2vi7lU5OH5NpmsZb0FacJHTyaM3+T2wE5c9Y5BBUkPSmwwWragdsAJJk6mGS4UD+EtWV0uo44Jo2ODKWZlpmSeCVknyw0jIKCQ9ym+9Jb1P9B92dIzGdx3rP/5N6xHwycIIOj6tr/N8KN8SSvNgXrKThZJrCY6anv0tpvk7NOX+fs5LJ+utUBABTLTbEziExAD/x67jCzrBfTZ2O//5xMCDOFYy8WYGSZcwWsEdxk3KbWoKrCgpBRcav6PcF9454abXEtHRmTAPX98FwSkVzEkNE6SYVXQcCxz0h3DvX1OUDpclRLxYDyd+EhR0mwQEvc2Suqe68IpercVOlPiKym61sKgCsJwQugnqGbe9tQoFfBEBg4RSQNlkWo0kpO/zO2dljaOmJtYLsSZ3RCFv5R+YRcHKfYP6ldvUItEvVhB2czLEq9f1fRQp/bw310yhEP5pupbev577rVz1S8LfCrJVpd77gmPQRuU48Yy9CQAFUmeqd5ehd+AXc6JwiXMUAH0/TFMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aee878e-298b-418c-080d-08d84ed93f0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:44.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ev+h5TvDEA9G4sXz2JRARduKOsFRSWlLD+qopAHHDDg17VPjCGTsP+67U2WUvcCV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007413; bh=w+DN43GNbyoUX+NTByLvYb4kdbJ93uF8IMUQLU6AW2w=;
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
        b=E8OJTYEE/nzK4B8+exFtQhfttjgX+K/P7trqbzBej5VbRdpk/NnGQRv+ZoQni5XKD
         xnGqHUmp+ujsDem6C0SkUuDgv1xAh3o5XOnWsEjZ2h9ACIjCH2E9rjyhWL1K759MyJ
         ZZCsDakJfyV9cyqgfYQxQy3D9+2XAwQ8h83Ltrgslj8Fulcq8y0h5WQl5lIYL39cue
         DbmOwCI9TPQoa9AAY2rdc6gyx0kmM3n7xYM1tBj9Y+i0qzQjmioa4CtDq/6q38P0YJ
         EPwLEp/iKh8IKjA57ILpRMYa/szMsdo44p1KttkDIvTphEhRDdaH9gvwIH9MbhJiiQ
         ghyR7BHcXSPSg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For the calls linked to mlx4_ib_umem_calc_optimal_mtt_size() compute the
number of DMA pages directly based on the returned page_shift. This was
just being used as a weird default if the algorithm hits the lower limit.

All other places are just using it with PAGE_SIZE.

As this is the last call site, remove ib_umem_num_pages().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/umem.c       | 12 ------------
 drivers/infiniband/hw/mlx4/cq.c      |  8 ++++----
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  3 +--
 drivers/infiniband/hw/mlx4/mr.c      | 14 ++++++--------
 drivers/infiniband/hw/mlx4/qp.c      | 17 +++++++++--------
 drivers/infiniband/hw/mlx4/srq.c     |  5 +++--
 include/rdma/ib_umem.h               |  2 --
 7 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index f02e34cac59581..49d6ddc37b6fde 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -346,18 +346,6 @@ void ib_umem_release(struct ib_umem *umem)
 }
 EXPORT_SYMBOL(ib_umem_release);
=20
-int ib_umem_page_count(struct ib_umem *umem)
-{
-	int i, n =3D 0;
-	struct scatterlist *sg;
-
-	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i)
-		n +=3D sg_dma_len(sg) >> PAGE_SHIFT;
-
-	return n;
-}
-EXPORT_SYMBOL(ib_umem_page_count);
-
 /*
  * Copy from the given ib_umem's pages to the given buffer.
  *
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/c=
q.c
index 8a3436994f8097..3de97f428dc63b 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -142,16 +142,16 @@ static int mlx4_ib_get_cq_umem(struct mlx4_ib_dev *de=
v, struct ib_udata *udata,
 	int err;
 	int cqe_size =3D dev->dev->caps.cqe_size;
 	int shift;
-	int n;
=20
 	*umem =3D ib_umem_get(&dev->ib_dev, buf_addr, cqe * cqe_size,
 			    IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(*umem))
 		return PTR_ERR(*umem);
=20
-	n =3D ib_umem_page_count(*umem);
-	shift =3D mlx4_ib_umem_calc_optimal_mtt_size(*umem, 0, &n);
-	err =3D mlx4_mtt_init(dev->dev, n, shift, &buf->mtt);
+	shift =3D mlx4_ib_umem_calc_optimal_mtt_size(*umem, 0);
+	err =3D mlx4_mtt_init(dev->dev,
+			    ib_umem_num_dma_blocks(*umem, 1UL << shift), shift,
+			    &buf->mtt);
=20
 	if (err)
 		goto err_buf;
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/m=
lx4/mlx4_ib.h
index bcac8fc5031766..660955a11914e7 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -905,7 +905,6 @@ struct ib_rwq_ind_table
 			      struct ib_rwq_ind_table_init_attr *init_attr,
 			      struct ib_udata *udata);
 int mlx4_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
-int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *umem, u64 start_va,
-				       int *num_of_mtts);
+int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *umem, u64 start_va)=
;
=20
 #endif /* MLX4_IB_H */
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/m=
r.c
index 1d5ef0de12c950..19b2d3fbe81e03 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -254,8 +254,7 @@ int mlx4_ib_umem_write_mtt(struct mlx4_ib_dev *dev, str=
uct mlx4_mtt *mtt,
  * middle already handled as part of mtt shift calculation for both their =
start
  * & end addresses.
  */
-int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *umem, u64 start_va,
-				       int *num_of_mtts)
+int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *umem, u64 start_va)
 {
 	u64 block_shift =3D MLX4_MAX_MTT_SHIFT;
 	u64 min_shift =3D PAGE_SHIFT;
@@ -353,7 +352,6 @@ int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *=
umem, u64 start_va,
 		pr_warn("misaligned total length detected (%llu, %llu)!",
 			total_len, block_shift);
=20
-	*num_of_mtts =3D total_len >> block_shift;
 end:
 	if (block_shift < min_shift) {
 		/*
@@ -409,7 +407,6 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64=
 start, u64 length,
 	struct mlx4_ib_mr *mr;
 	int shift;
 	int err;
-	int n;
=20
 	mr =3D kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
@@ -421,11 +418,12 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u=
64 start, u64 length,
 		goto err_free;
 	}
=20
-	n =3D ib_umem_page_count(mr->umem);
-	shift =3D mlx4_ib_umem_calc_optimal_mtt_size(mr->umem, start, &n);
+	shift =3D mlx4_ib_umem_calc_optimal_mtt_size(mr->umem, start);
=20
 	err =3D mlx4_mr_alloc(dev->dev, to_mpd(pd)->pdn, virt_addr, length,
-			    convert_access(access_flags), n, shift, &mr->mmr);
+			    convert_access(access_flags),
+			    ib_umem_num_dma_blocks(mr->umem, 1UL << shift),
+			    shift, &mr->mmr);
 	if (err)
 		goto err_umem;
=20
@@ -511,7 +509,7 @@ int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags,
 			mmr->umem =3D NULL;
 			goto release_mpt_entry;
 		}
-		n =3D ib_umem_page_count(mmr->umem);
+		n =3D ib_umem_num_dma_blocks(mmr->umem, PAGE_SIZE);
 		shift =3D PAGE_SHIFT;
=20
 		err =3D mlx4_mr_rereg_mem_write(dev->dev, &mmr->mmr,
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/q=
p.c
index 2975f350b9fd10..3113d9ca112771 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -869,7 +869,6 @@ static int create_rq(struct ib_pd *pd, struct ib_qp_ini=
t_attr *init_attr,
 	struct mlx4_ib_create_wq wq;
 	size_t copy_len;
 	int shift;
-	int n;
=20
 	qp->mlx4_ib_qp_type =3D MLX4_IB_QPT_RAW_PACKET;
=20
@@ -922,9 +921,10 @@ static int create_rq(struct ib_pd *pd, struct ib_qp_in=
it_attr *init_attr,
 		goto err;
 	}
=20
-	n =3D ib_umem_page_count(qp->umem);
-	shift =3D mlx4_ib_umem_calc_optimal_mtt_size(qp->umem, 0, &n);
-	err =3D mlx4_mtt_init(dev->dev, n, shift, &qp->mtt);
+	shift =3D mlx4_ib_umem_calc_optimal_mtt_size(qp->umem, 0);
+	err =3D mlx4_mtt_init(dev->dev,
+			    ib_umem_num_dma_blocks(qp->umem, 1UL << shift),
+			    shift, &qp->mtt);
=20
 	if (err)
 		goto err_buf;
@@ -1077,7 +1077,6 @@ static int create_qp_common(struct ib_pd *pd, struct =
ib_qp_init_attr *init_attr,
 		struct mlx4_ib_create_qp ucmd;
 		size_t copy_len;
 		int shift;
-		int n;
=20
 		copy_len =3D sizeof(struct mlx4_ib_create_qp);
=20
@@ -1117,9 +1116,11 @@ static int create_qp_common(struct ib_pd *pd, struct=
 ib_qp_init_attr *init_attr,
 			goto err;
 		}
=20
-		n =3D ib_umem_page_count(qp->umem);
-		shift =3D mlx4_ib_umem_calc_optimal_mtt_size(qp->umem, 0, &n);
-		err =3D mlx4_mtt_init(dev->dev, n, shift, &qp->mtt);
+		shift =3D mlx4_ib_umem_calc_optimal_mtt_size(qp->umem, 0);
+		err =3D mlx4_mtt_init(dev->dev,
+				    ib_umem_num_dma_blocks(qp->umem,
+							   1UL << shift),
+				    shift, &qp->mtt);
=20
 		if (err)
 			goto err_buf;
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/=
srq.c
index 8f9d5035142d33..108b2d0118d064 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -115,8 +115,9 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 		if (IS_ERR(srq->umem))
 			return PTR_ERR(srq->umem);
=20
-		err =3D mlx4_mtt_init(dev->dev, ib_umem_page_count(srq->umem),
-				    PAGE_SHIFT, &srq->mtt);
+		err =3D mlx4_mtt_init(
+			dev->dev, ib_umem_num_dma_blocks(srq->umem, PAGE_SIZE),
+			PAGE_SHIFT, &srq->mtt);
 		if (err)
 			goto err_buf;
=20
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index ba3b9be0d8c56a..4bac6e29f030c2 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -73,7 +73,6 @@ static inline void __rdma_umem_block_iter_start(struct ib=
_block_iter *biter,
 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 			    size_t size, int access);
 void ib_umem_release(struct ib_umem *umem);
-int ib_umem_page_count(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
 unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
@@ -91,7 +90,6 @@ static inline struct ib_umem *ib_umem_get(struct ib_devic=
e *device,
 	return ERR_PTR(-EINVAL);
 }
 static inline void ib_umem_release(struct ib_umem *umem) { }
-static inline int ib_umem_page_count(struct ib_umem *umem) { return 0; }
 static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_=
t offset,
 		      		    size_t length) {
 	return -EINVAL;
--=20
2.28.0

