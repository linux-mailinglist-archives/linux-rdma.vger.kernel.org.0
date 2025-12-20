Return-Path: <linux-rdma+bounces-15116-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 254EBCD298A
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 08:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A653014600
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 07:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0EA2F5A35;
	Sat, 20 Dec 2025 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqjUwU9Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20E2F616C
	for <linux-rdma@vger.kernel.org>; Sat, 20 Dec 2025 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766214468; cv=none; b=VP1EOdQxLlErnDiTKlTLZhcyUiVjOR/yPq94DABpfZ8aox9QFx2VYu9HNP7UvYqqHedHFOxXxZGFFv7PCQj5q9Oap3ryZB7b7YLSgFjTIsclb629FMS5fGnr9TEu5p7rhdtp0PI32natQ/URlZZLRUzFyW0rsl9AvtiI9VlfAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766214468; c=relaxed/simple;
	bh=x2cZeTt8nfXahNIgP5U//Vv6JqbmrMLmOmquVJbMeiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNEsgWXibWMoYBzmgmiD9Fu5nvXCtOmwEbW4WYVNqDYQ4PuR8D3tDvs4/0d/Nl/lu0gymDT5VuTlW2PJDJEElyZ+50ZqxRvTvb3wzJtjuGWQjgkpfiFEDcr/zPIDuBDIv3kV3ZL4RAFJwULzC+c8pmUbWb9g6lOXyOUJ3HFAdU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqjUwU9Y; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ee5a3dbe-af8c-46e5-98ea-8165fbeeeccd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766214449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUR73nv2KAuFsmcIH3gF6bSkayK0unPfWf5p0TiVjAg=;
	b=RqjUwU9Y1KAuHQ1VKk0KdcGlIPuEIp7HZ69zu2eptfO7tmZia6188/YVg45pmv5FHDGIal
	83RYISe8fJZ+uK/3aJY17xrg0dlj8nriVvOTC/QdB/FeI8wJnnJSqBaZVgsqk2pSmjgQf0
	jomiDVFCdCCkkfKVBgNlr08+hdi3weI=
Date: Fri, 19 Dec 2025 23:07:21 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Zhu Yanjun <mounter625@163.com>, Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251202181334.GA1162842@nvidia.com>
 <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
 <20251204130559.GA1219718@nvidia.com>
 <80620d09-8187-45b1-a490-07c52733ac21@linux.dev>
 <2191ee0f-a528-4187-ae5b-5aba18741701@linux.dev>
 <7e3a294f-5dc2-4e8c-aacc-0286c1592038@linux.dev>
 <20251218155623.GC400630@unreal>
 <5d950681-7f16-4b1e-a512-b118c747ffd7@linux.dev>
 <cbb0ec98-0291-4ec4-9633-690e9199248b@embeddedor.com>
 <6f15e334-8902-4d1d-adab-aa9ab8f009d6@linux.dev>
 <d569b5fd-fcca-4dd0-b94b-a6df4e52d940@embeddedor.com>
 <01b419f6-264e-4faa-b4df-480fdf952d14@linux.dev>
 <8470c362-8c41-4b99-8c05-0903285c1b6c@embeddedor.com>
 <1bef81ba-be81-49df-9d86-3cc0cc4bf864@163.com>
 <ad8987ae-b7fe-47af-a1d2-5055749011c0@embeddedor.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ad8987ae-b7fe-47af-a1d2-5055749011c0@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/12/19 1:55, Gustavo A. R. Silva 写道:
> 
> 
> On 12/19/25 15:59, Zhu Yanjun wrote:
>>
>> 在 2025/12/18 21:48, Gustavo A. R. Silva 写道:
>>>
>>>> The struct rxe_recv_wqe is as below.
>>>>
>>>> struct rxe_recv_wqe {
>>>>      __aligned_u64       wr_id;
>>>>      __u32           reserved;
>>>>      __u32           padding;
>>>>      struct rxe_dma_info dma;
>>>
>>> Expand struct rxe_dma_info here.
>>
>> Thanks. In struct rxe_dma_info, the struct is
>>
>> struct rxe_sge {
>>         __aligned_u64 addr;
>>         __u32   length;
>>         __u32   lkey;
>> };
>>
>> But in your commit, struct ib_sge is used.
>>
>> struct ib_sge {
>>      u64 addr;
>>      u32 length;
>>      u32 lkey;
>> };
>> __aligned_u64 is a 64-bit integer with a guaranteed 8-byte alignment,
>>
>> used to preserve ABI correctness across architectures and between
>>
>> userspace and kernel, while u64 has architecture-dependent alignment.
>>
>> I am not sure if we can treate "struct rxe_sge" as the same with 
>> "struct ib_sge".
> 
> Just notice that the original code is the one actually doing that.
> See my response in this same thread:
> 
> https://lore.kernel.org/linux-hardening/d3336e9d-2b84-4698-a799- 
> b49e3845f38f@embeddedor.com/
> 
> So, if that code is fine, this is fine. If the original code is wrong,
> then that code should be fixed first.

Thanks a lot. Because struct ib_sge and struct ib_sge is different,
struct ib_sge {
     u64 addr; <--- u64 has architecture-dependent alignment
     u32 length;
     u32 lkey;
};

struct rxe_sge {
        __aligned_u64 addr;   <---guaranteed 8-byte alignment,

used to preserve ABI correctness across architectures and between

userspace and kernel

        __u32   length;
        __u32   lkey;
};

and struct rxe_sge is used in rxe_mr, it is working between userspace 
and kernel, thus, I want to keep struct rxe_mr in rxe_mr.

But in other places, I want to replace struct rxe_sge with struct 
ib_sge. The commit is as below.

In short, the commit "RDMA/rxe: Avoid -Wflex-array-member-not-at-end 
warnings" && the following commit will work well. I have made tests in 
my local host. It can work well.

Please Leon and Jason comment.

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c 
b/drivers/infiniband/sw/rxe/rxe_mr.c
index b1df05238848..390ae01f549d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -341,7 +341,7 @@ int copy_data(
         enum rxe_mr_copy_dir    dir)
  {
         int                     bytes;
-       struct rxe_sge          *sge    = &dma->sge[dma->cur_sge];
+       struct ib_sge *sge      = &dma->sge[dma->cur_sge];
         int                     offset  = dma->sge_offset;
         int                     resid   = dma->resid;
         struct rxe_mr           *mr     = NULL;
@@ -580,7 +580,7 @@ enum resp_states rxe_mr_do_atomic_write(struct 
rxe_mr *mr, u64 iova, u64 value)

  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
  {
-       struct rxe_sge          *sge    = &dma->sge[dma->cur_sge];
+       struct ib_sge *sge      = &dma->sge[dma->cur_sge];
         int                     offset  = dma->sge_offset;
         int                     resid   = dma->resid;

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c 
b/drivers/infiniband/sw/rxe/rxe_resp.c
index 711f73e0bbb1..74f5b695da7a 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -283,7 +283,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
                 rxe_dbg_qp(qp, "invalid num_sge in SRQ entry\n");
                 return RESPST_ERR_MALFORMED_WQE;
         }
-       size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
+       size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct ib_sge);
         memcpy(&qp->resp.srq_wqe, wqe, size);

         qp->resp.wqe = &qp->resp.srq_wqe.wqe;
diff --git a/include/uapi/rdma/rdma_user_rxe.h 
b/include/uapi/rdma/rdma_user_rxe.h
index bb092fccb813..360839498441 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -154,7 +154,7 @@ struct rxe_dma_info {
         union {
                 __DECLARE_FLEX_ARRAY(__u8, inline_data);
                 __DECLARE_FLEX_ARRAY(__u8, atomic_wr);
-               __DECLARE_FLEX_ARRAY(struct rxe_sge, sge);
+               __DECLARE_FLEX_ARRAY(struct ib_sge, sge);
         };
  };


To this commit, plus the above commit, it should work well.

Yanjun.Zhu

> 
> -Gustavo
> 
>>
>>
>> Leon and Jason, please comment on it.
>>
>>
>> Yanjun.Zhu
>>
>>>
>>>> };
>>>>
>>>> But I can not find dma.sge in the above struct. Can you explain it?
>>>>
>>>> To be honest, I read your original commit for several times, but I 
>>>> can not get it.  Can you explain the MACRO TRAILING_OVERLAP? And how 
>>>> can it replace the following struct?
>>>
>>> This is clearly explained in the changelog text. I think what you're
>>> missing will be clear once you understand how nested structures
>>> work. See my comment above.
>>>
>>> -Gustavo
>>
> 


