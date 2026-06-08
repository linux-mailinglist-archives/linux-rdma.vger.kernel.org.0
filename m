Return-Path: <linux-rdma+bounces-21987-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 22csFrBEJ2qeuAIAu9opvQ
	(envelope-from <linux-rdma+bounces-21987-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 00:39:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF865B02F
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 00:39:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=FjJ+SKc0;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21987-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21987-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60D36307EEF4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E813B3896;
	Mon,  8 Jun 2026 22:39:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBB3AF66C
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 22:39:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958345; cv=none; b=WDsGHVymCEf+LTUaQeo7FRRR+0opsfrjSkWHu0Vk8q5TRsIGxNShgJJDv/6+3dY9DDtblOjPnqMk4FZ5MD8C+ufeOnKFtp6syHCy4BM7+0VjMHAc7NCgEsfbamEtJAQ19+OfwcOEEzJlGAD41GIW4/RpMpFr2ZUCOIEKItadjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958345; c=relaxed/simple;
	bh=B38Yul90LSZo0cGkliS/GfsPhioOiokBBuCkxDKeA+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5TXGHUkFcgz1mJVX9ogz6a7PAHQ2ZxW4qK0mrTca8upXdGJST/i+4umkqC53vrh72KwEYcgkf+eTiNd3BP0QNwcDfIjnefnuB+Xlc71Y1eocifhbK1Wrp6tDewvhtFxCvikd7sTBNCJ6DHMUgEQtmltt8afUTBCyc1vVmwq2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FjJ+SKc0; arc=none smtp.client-ip=95.215.58.179
Message-ID: <22629c63-ca98-4af7-9e3b-480b89be6ce1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780958331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsMGa7C/qI7GXavChWSxY7UqoXopVpbWUaHr6eY8dLo=;
	b=FjJ+SKc03d6gNs35mSU14MrmFANRZ8G6efWRp1Bx7YGsC+DNOeNKT/uGShtknCh6AXgJ3z
	sXtZpKjNy5gIN2XrUoyJhYbM0QYMMCTJYwgYYinhz8a7GVK4Jq2ZyFLK0wtFwOxy9w05pp
	H9nqL/Fr/CSH2QYVJnZb3blCFQIBL3U=
Date: Mon, 8 Jun 2026 15:38:32 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA: During rereg_mr ensure that REREG_ACCESS is
 compatible
To: Jason Gunthorpe <jgg@nvidia.com>,
 Junxian Huang <huangjunxian6@hisilicon.com>,
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>, linux-rdma@vger.kernel.org,
 Chengchang Tang <tangchengchang@huawei.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 patches@lists.linux.dev, Philip Tsukerman <philiptsukerman@gmail.com>,
 stable@vger.kernel.org
References: <0-v1-06fb1a2d6cf5+107-rereg_access_jgg@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <0-v1-06fb1a2d6cf5+107-rereg_access_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:huangjunxian6@hisilicon.com,m:krzysztof.czurylo@intel.com,m:linux-rdma@vger.kernel.org,m:tangchengchang@huawei.com,m:tatyana.e.nikolova@intel.com,m:yishaih@nvidia.com,m:zyjzyj2000@gmail.com,m:yanjun.zhu@linux.dev,m:akpm@linux-foundation.org,m:david@redhat.com,m:leon@kernel.org,m:patches@lists.linux.dev,m:philiptsukerman@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21987-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,hisilicon.com,intel.com,vger.kernel.org,huawei.com,gmail.com,linux.dev];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,redhat.com,kernel.org,lists.linux.dev,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EACF865B02F

On 6/8/26 9:44 AM, Jason Gunthorpe wrote:
> If IB_MR_REREG_ACCESS changes from RO to RW then the umem has to be
> re-evaluated to ensure it is properly pinned as RW. Since the umem is
> hidden inside each driver's mr struct add a ib_umem_check_rereg() function
> that each driver has to call before processing IB_MR_REREG_ACCESS.
> 
> mlx4 has to retain its duplicate ib_access_writable check because it
> implements IB_MR_REREG_ACCESS | IB_MR_REREG_TRANS by changing both items
> in place sequentially while the MR is live, so it will continue to not
> support this combination.
> 
> Cc: stable@vger.kernel.org
> Fixes: b40656aa7d55 ("RDMA/umem: remove FOLL_FORCE usage")
> Reported-by: Philip Tsukerman <philiptsukerman@gmail.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/infiniband/core/umem.c          | 16 ++++++++++++++++
>   drivers/infiniband/hw/hns/hns_roce_mr.c |  4 ++++
>   drivers/infiniband/hw/irdma/verbs.c     |  4 ++++
>   drivers/infiniband/hw/mlx4/mr.c         |  4 ++++
>   drivers/infiniband/hw/mlx5/mr.c         |  4 ++++
>   drivers/infiniband/sw/rxe/rxe_verbs.c   |  5 +++++
>   include/rdma/ib_umem.h                  |  8 ++++++++
>   7 files changed, 45 insertions(+)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 786fa1aa8e552b..4b055712b0d0db 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -332,3 +332,19 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>   		return 0;
>   }
>   EXPORT_SYMBOL(ib_umem_copy_from);
> +
> +/*
> + * Called during rereg mr if the driver is able to re-use a umem for
> + * IB_MR_REREG_ACCESS.
> + */
> +int ib_umem_check_rereg(struct ib_umem *umem, int flags, int new_access_flags)
> +{
> +	if (!umem)
> +		return 0;
> +
> +	if ((flags & IB_MR_REREG_ACCESS) && !(flags & IB_MR_REREG_TRANS))
> +		if (ib_access_writable(new_access_flags) && !umem->writable)
> +			return -EACCES;
> +	return 0;
> +}
> +EXPORT_SYMBOL(ib_umem_check_rereg);
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 896af1828a38de..25bfd3970f5b6e 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -300,6 +300,10 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
>   		goto err_out;
>   	}
>   
> +	ret = ib_umem_check_rereg(mr->pbl_mtr.umem, flags, mr_access_flags);
> +	if (ret)
> +		goto err_out;
> +
>   	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
>   	ret = PTR_ERR_OR_ZERO(mailbox);
>   	if (ret)
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 17086048d2d7fc..8cd4275328052e 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -3803,6 +3803,10 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
>   	if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS))
>   		return ERR_PTR(-EOPNOTSUPP);
>   
> +	ret = ib_umem_check_rereg(iwmr->region, flags, new_access);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>   	if (dmabuf_revocable) {
>   		umem_dmabuf = to_ib_umem_dmabuf(iwmr->region);
>   
> diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
> index 650b4a9121ff6d..6747bca3067770 100644
> --- a/drivers/infiniband/hw/mlx4/mr.c
> +++ b/drivers/infiniband/hw/mlx4/mr.c
> @@ -209,6 +209,10 @@ struct ib_mr *mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
>   	struct mlx4_mpt_entry **pmpt_entry = &mpt_entry;
>   	int err;
>   
> +	err = ib_umem_check_rereg(mmr->umem, flags, mr_access_flags);
> +	if (err)
> +		return ERR_PTR(err);
> +
>   	/* Since we synchronize this call and mlx4_ib_dereg_mr via uverbs,
>   	 * we assume that the calls can't run concurrently. Otherwise, a
>   	 * race exists.
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 3b6da45061a552..fb40b44496f47a 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1179,6 +1179,10 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
>   	if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS))
>   		return ERR_PTR(-EOPNOTSUPP);
>   
> +	err = ib_umem_check_rereg(mr->umem, flags, new_access_flags);
> +	if (err)
> +		return ERR_PTR(err);
> +
>   	if (!(flags & IB_MR_REREG_ACCESS))
>   		new_access_flags = mr->access_flags;
>   	if (!(flags & IB_MR_REREG_PD))
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 4d4891dc28846b..4cf04a44189c64 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1319,6 +1319,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
>   	struct rxe_mr *mr = to_rmr(ibmr);
>   	struct rxe_pd *old_pd = to_rpd(ibmr->pd);
>   	struct rxe_pd *pd = to_rpd(ibpd);
> +	int err;
>   
>   	/* for now only support the two easy cases:
>   	 * rereg_pd and rereg_access
> @@ -1328,6 +1329,10 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
>   		return ERR_PTR(-EOPNOTSUPP);
>   	}
>   
> +	err = ib_umem_check_rereg(mr->umem, flags, access);
> +	if (err)
> +		return ERR_PTR(err);
> +

Thanks a lot. I am fine with this.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

But I found the following problem. I am not sure if we fix this problem 
in this commit or file a new commit.

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c 
b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4d4891dc2884..3b99649c342d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1319,6 +1319,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct 
ib_mr *ibmr, int flags,
         struct rxe_mr *mr = to_rmr(ibmr);
         struct rxe_pd *old_pd = to_rpd(ibmr->pd);
         struct rxe_pd *pd = to_rpd(ibpd);
+       struct ib_pd *old_ibpd;

         /* for now only support the two easy cases:
          * rereg_pd and rereg_access
@@ -1331,12 +1332,18 @@ static struct ib_mr *rxe_rereg_user_mr(struct 
ib_mr *ibmr, int flags,
         if (flags & IB_MR_REREG_PD) {
                 rxe_put(old_pd);
                 rxe_get(pd);
+               old_ibpd = mr->ibmr.pd;
                 mr->ibmr.pd = ibpd;
         }

         if (flags & IB_MR_REREG_ACCESS) {
                 if (access & ~RXE_ACCESS_SUPPORTED_MR) {
                         rxe_err_mr(mr, "access = %#x not supported\n", 
access);
+                       if (flags & IB_MR_REREG_PD) {
+                               rxe_get(old_pd);
+                               rxe_put(pd);
+                               mr->ibmr.pd = old_ibpd;
+                       }
                         return ERR_PTR(-EOPNOTSUPP);
                 }
                 mr->access = access;

Zhu Yanjun

>   	if (flags & IB_MR_REREG_PD) {
>   		rxe_put(old_pd);
>   		rxe_get(pd);
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index 2ad52cc1d52bdd..49172098a8de14 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -156,6 +156,8 @@ void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf);
>   void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf);
>   void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
>   
> +int ib_umem_check_rereg(struct ib_umem *umem, int flags, int new_access_flags);
> +
>   #else /* CONFIG_INFINIBAND_USER_MEM */
>   
>   #include <linux/err.h>
> @@ -230,5 +232,11 @@ static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf
>   static inline void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf) {}
>   static inline void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf) {}
>   
> +static inline int ib_umem_check_rereg(struct ib_umem *umem, int flags,
> +				      int new_access_flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   #endif /* CONFIG_INFINIBAND_USER_MEM */
>   #endif /* IB_UMEM_H */
> 
> base-commit: 323c98a4ff06aa28114f2bf658fb43eb3b536bbc


