Return-Path: <linux-rdma+bounces-7474-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD45A29FB9
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 05:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB766188289C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 04:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C6EA2D;
	Thu,  6 Feb 2025 04:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ZHYKIVBs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9D1607A4
	for <linux-rdma@vger.kernel.org>; Thu,  6 Feb 2025 04:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738816655; cv=none; b=lGDTPE6NGoeCwlp0nUR8jJfZ+JfAjQkdOCulvTV8ixdkixE57h2yYS9KGlO8EujVH0FtKE5tn68/hERSqMwNTUYf1FFVeWmRby2NRlcKmHRoRIYF1gYv3Iyg6W2nY+rAxDtcxP2srOZWVnixeKhQrd6emhOjbHySDRzQZE6rnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738816655; c=relaxed/simple;
	bh=N0DvuSe/lIH+kRjwXSdDBh6Fhhbw9RKU+RCtaqaYkfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GR0ef9L0qcewtIL3vGtW+kP6Zwh3ByeP6EUZpdngn8NsEtlG48vwoDtgcPRY+qyISRG7E0PJeQ5B2b+KIYaA9V56K1dIy9RxwPQzcF/XLE23wf8zqqe79xfYc2A3KvT71tnChHgfmeS8RRntyxczz6F/c0rnbKarndttDNm2n7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ZHYKIVBs; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id foOItFE1u1T3hftdmtMFP0; Thu, 06 Feb 2025 04:37:27 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ftdltwF2WlqdtftdmtRfye; Thu, 06 Feb 2025 04:37:26 +0000
X-Authority-Analysis: v=2.4 cv=JIzwsNKb c=1 sm=1 tr=0 ts=67a43c86
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=klVnHSuGmlGqL09SeYAA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UI/rvOkUbnqui88BmNEI08jm0hlJMmOpKKuR2cLnH4g=; b=ZHYKIVBseIV428frTB+avylk7k
	f52Zd+9DPXYVyJ3rW9g8/ucGYGKi+2YiA1TcVgPYyjksxjvasItvmk9or/FNWS3BlW3a0zvcAMkDh
	CHec/2D8cTbn1+BYW5rwQbncPGiMxDfxL3mCkHLUOrV19vBYTTE+S0k6qBMg7K3ewLWhEJe//3wa5
	eseNTMVNKJn4iL6Y5OI6KFhjwO6/RqDcLw6BdzDHBmIC+8SsZ6Uprd/OgBt4TOQuEdLPQfIo5k9Ow
	9NYpOnLs9IpXP5ee3VVOGSrg8P/8wt4Ckj8AgsdT/pL7etGXnpuvTpREUE99Pwo/yZNogfCR5lXQY
	BUgedVnw==;
Received: from [45.124.203.140] (port=54891 helo=[192.168.0.152])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tftdj-000JL1-0x;
	Wed, 05 Feb 2025 22:37:23 -0600
Message-ID: <4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
Date: Thu, 6 Feb 2025 15:07:07 +1030
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z6GCJY8G9EzASrwQ@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z6GCJY8G9EzASrwQ@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tftdj-000JL1-0x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.152]) [45.124.203.140]:54891
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE9RhaIhi+pP88FkKsEO863sB8wihATvjb7eKhay1kWmgReScGi97oQRGvQtHwu7BdJoxWcgBTVhoWxUDS5763SHTm64+NOIX50kCyqifb7pkegkgpCj
 HOPnSLPU/g0vd5dOEnUPuunk0w9JqKxcNTeUaEKgMDEqNbb9UimTtSaIYjJ40bEIzbkEonYccWdZ1fWgKaoZhdbfZYmcsau4Kl31ijJnh6QNOO61GzD6etqN

Hi,

On 04/02/25 13:27, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of other structs, we use the `struct_group_tagged()` helper
> to create a new tagged `struct mlx5e_umr_wqe_hdr`. This structure
> groups together all the members of the flexible `struct mlx5e_umr_wqe`
> except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct member currently causing
> trouble from `struct mlx5e_umr_wqe` to `struct mlx5e_umr_wqe_hdr`.
> 
> We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> This approach avoids having to implement `struct mlx5e_umr_wqe_hdr` as
> a completely separate structure, thus preventing having to maintain two
> independent but basically identical structures, closing the door to
> potential bugs in the future.
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure, through which we can access the flexible-array
> member, if necessary.
> 
> So, with these changes, fix 124 of the following warnings:
> 
> drivers/net/ethernet/mellanox/mlx5/core/en.h:664:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en.h      | 13 +++++++++----
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  4 +++-
>   2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 979fc56205e1..c30c64eb346f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -233,15 +233,20 @@ struct mlx5e_rx_wqe_cyc {
>   };
>   
>   struct mlx5e_umr_wqe {
> -	struct mlx5_wqe_ctrl_seg       ctrl;
> -	struct mlx5_wqe_umr_ctrl_seg   uctrl;
> -	struct mlx5_mkey_seg           mkc;
> +	/* New members MUST be added within the struct_group() macro below. */
> +	struct_group_tagged(mlx5e_umr_wqe_hdr, hdr,
> +		struct mlx5_wqe_ctrl_seg       ctrl;
> +		struct mlx5_wqe_umr_ctrl_seg   uctrl;
> +		struct mlx5_mkey_seg           mkc;
> +	);
>   	union {
>   		DECLARE_FLEX_ARRAY(struct mlx5_mtt, inline_mtts);
>   		DECLARE_FLEX_ARRAY(struct mlx5_klm, inline_klms);
>   		DECLARE_FLEX_ARRAY(struct mlx5_ksm, inline_ksms);
>   	};
>   };
> +static_assert(offsetof(struct mlx5e_umr_wqe, inline_mtts) == sizeof(struct mlx5e_umr_wqe_hdr),
> +	      "struct member likely outside of struct_group_tagged()");
>   
>   enum mlx5e_priv_flag {
>   	MLX5E_PFLAG_RX_CQE_BASED_MODER,
> @@ -660,7 +665,7 @@ struct mlx5e_rq {
>   		} wqe;
>   		struct {
>   			struct mlx5_wq_ll      wq;
> -			struct mlx5e_umr_wqe   umr_wqe;
> +			struct mlx5e_umr_wqe_hdr umr_wqe;
>   			struct mlx5e_mpw_info *info;
>   			mlx5e_fp_skb_from_cqe_mpwrq skb_from_cqe_mpwrq;
>   			__be32                 umr_mkey_be;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index bd41b75d246e..4ff4ff2342cf 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -373,6 +373,8 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
>   
>   static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
>   {
> +	struct mlx5e_umr_wqe *umr_wqe =
> +		container_of(&rq->mpwqe.umr_wqe, struct mlx5e_umr_wqe, hdr);
>   	int wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
>   	size_t alloc_size;
>   
> @@ -393,7 +395,7 @@ static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
>   		bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
>   	}
>   
> -	mlx5e_build_umr_wqe(rq, rq->icosq, &rq->mpwqe.umr_wqe);
> +	mlx5e_build_umr_wqe(rq, rq->icosq, umr_wqe);
>   
>   	return 0;
>   }

Here is another alternative for this.  And similarly to the struct_group_tagged()
change above, no struct members should be added before or after `struct
mlx5e_umr_wqe_hdr hdr;` in `struct mlx5e_umr_wqe`:

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 979fc56205e1..912b97eeb4d6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -232,10 +232,13 @@ struct mlx5e_rx_wqe_cyc {
         DECLARE_FLEX_ARRAY(struct mlx5_wqe_data_seg, data);
  };

-struct mlx5e_umr_wqe {
+struct mlx5e_umr_wqe_hdr {
         struct mlx5_wqe_ctrl_seg       ctrl;
         struct mlx5_wqe_umr_ctrl_seg   uctrl;
         struct mlx5_mkey_seg           mkc;
+};
+struct mlx5e_umr_wqe {
+       struct mlx5e_umr_wqe_hdr hdr;
         union {
                 DECLARE_FLEX_ARRAY(struct mlx5_mtt, inline_mtts);
                 DECLARE_FLEX_ARRAY(struct mlx5_klm, inline_klms);
@@ -660,7 +663,7 @@ struct mlx5e_rq {
                 } wqe;
                 struct {
                         struct mlx5_wq_ll      wq;
-                       struct mlx5e_umr_wqe   umr_wqe;
+                       struct mlx5e_umr_wqe_hdr umr_wqe;
                         struct mlx5e_mpw_info *info;
                         mlx5e_fp_skb_from_cqe_mpwrq skb_from_cqe_mpwrq;
                         __be32                 umr_mkey_be;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 1b7132fa70de..2b05536d564a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -123,7 +123,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
         bitmap_zero(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
         wi->consumed_strides = 0;

-       umr_wqe->ctrl.opmod_idx_opcode =
+       umr_wqe->hdr.ctrl.opmod_idx_opcode =
                 cpu_to_be32((icosq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) | MLX5_OPCODE_UMR);

         /* Optimized for speed: keep in sync with mlx5e_mpwrq_umr_entry_size. */
@@ -134,7 +134,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
                 offset = offset * sizeof(struct mlx5_klm) * 2 / MLX5_OCTWORD;
         else if (unlikely(rq->mpwqe.umr_mode == MLX5E_MPWRQ_UMR_MODE_TRIPLE))
                 offset = offset * sizeof(struct mlx5_ksm) * 4 / MLX5_OCTWORD;
-       umr_wqe->uctrl.xlt_offset = cpu_to_be16(offset);
+       umr_wqe->hdr.uctrl.xlt_offset = cpu_to_be16(offset);

         icosq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
                 .wqe_type = MLX5E_ICOSQ_WQE_UMR_RX,
@@ -144,7 +144,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)

         icosq->pc += rq->mpwqe.umr_wqebbs;

-       icosq->doorbell_cseg = &umr_wqe->ctrl;
+       icosq->doorbell_cseg = &umr_wqe->hdr.ctrl;

         return 0;

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a814b63ed97e..bbd0b888d237 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -311,8 +311,8 @@ static inline void mlx5e_build_umr_wqe(struct mlx5e_rq *rq,
                                        struct mlx5e_icosq *sq,
                                        struct mlx5e_umr_wqe *wqe)
  {
-       struct mlx5_wqe_ctrl_seg      *cseg = &wqe->ctrl;
-       struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
+       struct mlx5_wqe_ctrl_seg      *cseg = &wqe->hdr.ctrl;
+       struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->hdr.uctrl;
         u16 octowords;
         u8 ds_cnt;

@@ -393,7 +393,9 @@ static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
                 bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
         }

-       mlx5e_build_umr_wqe(rq, rq->icosq, &rq->mpwqe.umr_wqe);
+       mlx5e_build_umr_wqe(rq, rq->icosq,
+                           container_of(&rq->mpwqe.umr_wqe,
+                                        struct mlx5e_umr_wqe, hdr));

         return 0;
  }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1963bc5adb18..5fd70b4d55be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -631,16 +631,16 @@ static void build_ksm_umr(struct mlx5e_icosq *sq, struct mlx5e_umr_wqe *umr_wqe,
                           __be32 key, u16 offset, u16 ksm_len)
  {
         memset(umr_wqe, 0, offsetof(struct mlx5e_umr_wqe, inline_ksms));
-       umr_wqe->ctrl.opmod_idx_opcode =
+       umr_wqe->hdr.ctrl.opmod_idx_opcode =
                 cpu_to_be32((sq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
                              MLX5_OPCODE_UMR);
-       umr_wqe->ctrl.umr_mkey = key;
-       umr_wqe->ctrl.qpn_ds = cpu_to_be32((sq->sqn << MLX5_WQE_CTRL_QPN_SHIFT)
+       umr_wqe->hdr.ctrl.umr_mkey = key;
+       umr_wqe->hdr.ctrl.qpn_ds = cpu_to_be32((sq->sqn << MLX5_WQE_CTRL_QPN_SHIFT)
                                             | MLX5E_KSM_UMR_DS_CNT(ksm_len));
-       umr_wqe->uctrl.flags = MLX5_UMR_TRANSLATION_OFFSET_EN | MLX5_UMR_INLINE;
-       umr_wqe->uctrl.xlt_offset = cpu_to_be16(offset);
-       umr_wqe->uctrl.xlt_octowords = cpu_to_be16(ksm_len);
-       umr_wqe->uctrl.mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
+       umr_wqe->hdr.uctrl.flags = MLX5_UMR_TRANSLATION_OFFSET_EN | MLX5_UMR_INLINE;
+       umr_wqe->hdr.uctrl.xlt_offset = cpu_to_be16(offset);
+       umr_wqe->hdr.uctrl.xlt_octowords = cpu_to_be16(ksm_len);
+       umr_wqe->hdr.uctrl.mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
  }

  static struct mlx5e_frag_page *mlx5e_shampo_hd_to_frag_page(struct mlx5e_rq *rq, int header_index)
@@ -704,7 +704,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,

         shampo->pi = (shampo->pi + ksm_entries) & (shampo->hd_per_wq - 1);
         sq->pc += wqe_bbs;
-       sq->doorbell_cseg = &umr_wqe->ctrl;
+       sq->doorbell_cseg = &umr_wqe->hdr.ctrl;

         return 0;

@@ -814,12 +814,12 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
         bitmap_zero(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
         wi->consumed_strides = 0;

-       umr_wqe->ctrl.opmod_idx_opcode =
+       umr_wqe->hdr.ctrl.opmod_idx_opcode =
                 cpu_to_be32((sq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
                             MLX5_OPCODE_UMR);

         offset = (ix * rq->mpwqe.mtts_per_wqe) * sizeof(struct mlx5_mtt) / MLX5_OCTWORD;
-       umr_wqe->uctrl.xlt_offset = cpu_to_be16(offset);
+       umr_wqe->hdr.uctrl.xlt_offset = cpu_to_be16(offset);

         sq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
                 .wqe_type   = MLX5E_ICOSQ_WQE_UMR_RX,
@@ -829,7 +829,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)

         sq->pc += rq->mpwqe.umr_wqebbs;

-       sq->doorbell_cseg = &umr_wqe->ctrl;
+       sq->doorbell_cseg = &umr_wqe->hdr.ctrl;

         return 0;


Thanks
--
Gustavo

