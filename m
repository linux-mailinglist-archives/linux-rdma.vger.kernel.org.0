Return-Path: <linux-rdma+bounces-8753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED4A6554B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 16:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508CE3B5A44
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EC323FC42;
	Mon, 17 Mar 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGahoi2D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AA15442C
	for <linux-rdma@vger.kernel.org>; Mon, 17 Mar 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224611; cv=none; b=S2sy01J8Ugzzc+0WqI7B0kHCKS21D8RtTj8GIC96z+WYTTFdGuyG2STk8mQ2Y6sLIy08hQgVicFrCmP8VU3uiFSikNeLOn59I/jw0bLubTOPVWQt7FRqdOIB3LkNnu7jm/Hwg1zUFW9WXqty4TVdvmMvhRpwpcgA7BTOdsBPFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224611; c=relaxed/simple;
	bh=04tKKufKa20R9b387LUCyZ+68oviqMpABoU5vNN4Wzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GLH+u3BvnwVVuhzUUZQHBLptTU1I0TdDw1DQb0TMq27EMT3TqFWuQYHsmZU7S7PXWPgqUFgKN0VMNM/nKPvaNmTZvDwgQEHzTTUS/u6F1EohV3MD67tPGGFOHHxupqg5m3ruhkLrBvaOf9iAftPPctJ4foYJ0wY8TUuiZgF1yFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGahoi2D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742224608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzRZI32PvG1jM7oaHs4LUm1pa2tu5/yx3DzI4q+HHBg=;
	b=TGahoi2DAXBWMxyFbkeVOVUnKvvDoh0GUFSuCprjd0dKL15mf8xM7YOVj00ewXgoeCop0G
	XWAjkpEtqSDUiDC0dvyVo3me6hq1lfx81nRtjda9znfqSo+yw+EcnC2h6U2VKreW6SnksH
	zkxeKrEQ0X5VMjngIwOR7lx1tUpcAjs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-X9oy5_JoPhWzuNpZHKEltQ-1; Mon, 17 Mar 2025 11:16:47 -0400
X-MC-Unique: X9oy5_JoPhWzuNpZHKEltQ-1
X-Mimecast-MFC-AGG-ID: X9oy5_JoPhWzuNpZHKEltQ_1742224606
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30bff0c526cso24850881fa.0
        for <linux-rdma@vger.kernel.org>; Mon, 17 Mar 2025 08:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742224606; x=1742829406;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzRZI32PvG1jM7oaHs4LUm1pa2tu5/yx3DzI4q+HHBg=;
        b=BQqQ/3y4F7mj7sYi0178Rt09ecziZlOmz+DVj9bqiMOJn/CEQsTHDkyaqErpME4+GJ
         /W6gAW7w+AuJdQ0mI44U490CRN9rkcTyR41BKJDZ/1QxvVX/FCrTAP0FLYt6OD2UMkdm
         w8WjeP06XPRtrTANrJkvUmcp/tKK++NIF22ePKivm7V3KAWLfxsrJ7OItPQyzwx1jExn
         SXpGgEZBZa8YLhgETAq43NOxrt43+9v2VnONLpAPPU9UaeCScO+dlJv4Txymr0mplcso
         fCQsGJHC2mhFIHPnOtK4W46nhHREvqDjgXf2aAuemm4xWP9ALXC0XHoHCVvv9VUIUEAA
         7DEw==
X-Forwarded-Encrypted: i=1; AJvYcCW6ae5Owq+RGUkTMhhtCEK7tjqCmg//73EBAXqpb+a3Un2zmB7WvHEg4FibFKB0Sh/Mkdiz5bHgE7ke@vger.kernel.org
X-Gm-Message-State: AOJu0YzNk8GOwojThE0AjyE2RrkAOhxz6AYgMBfJYjdkAMp2o3Ho+qXv
	E3vZdBOFB3unfbmgnLYa1rlRgS2Oi0Y1x+EpSzkOoYQAfxt/UC6VCMrvSwrKUOriZOcyss5x7WU
	cmeexbA05XbDDMagecX/vCC+XGvgoG9l8MnOkptFnYXae0o/pRcFX7idqpTo=
X-Gm-Gg: ASbGncusIDBYkQaxzdRsjFcdbB66todux0nbuAK19hFRKOFnX4NZCoxoqFMRUnKx+wA
	S20GcbzofUOgT6cGKP1tAb/Vjbk8RICx4YqRwL8Z0810zCU+NC8MS6iESD7c9FdVJxLEB6n11G5
	SpubeicfPZf3T9pLgbVtKUWnXhKxr8X63pWCKvPgyEUWYwT/oLP+0BUOCcZ3j11bTYHDfjxOL4c
	pKebQ9oyNBOfEsRJ7Bt6DAD58iUfbE+XWzw9nYWlQEbOv5AYR710IX89bV4ck66cZ5itm9ficlO
	ll0aQlttV77S
X-Received: by 2002:a2e:740a:0:b0:30b:eb08:53e3 with SMTP id 38308e7fff4ca-30c4a8743d9mr64207421fa.17.1742224605614;
        Mon, 17 Mar 2025 08:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSi8cQyOlG/W3LR4YI+3jPWVFa3/mQXBuzJDNH22ZWPZDVglcHs63ffS5X17IwRGbk4plwDg==
X-Received: by 2002:a2e:740a:0:b0:30b:eb08:53e3 with SMTP id 38308e7fff4ca-30c4a8743d9mr64207081fa.17.1742224605112;
        Mon, 17 Mar 2025 08:16:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f116a4asm15789761fa.58.2025.03.17.08.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:16:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DBB6318FAED8; Mon, 17 Mar 2025 16:16:42 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>, Matthew
 Wilcox <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>, IOMMU
 <iommu@lists.linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 17 Mar 2025 16:16:42 +0100
Message-ID: <87jz8nhelh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <yunshenglin0825@gmail.com> writes:

> On 3/14/2025 6:10 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> ...
>
>>=20
>> To avoid having to walk the entire xarray on unmap to find the page
>> reference, we stash the ID assigned by xa_alloc() into the page
>> structure itself, using the upper bits of the pp_magic field. This
>> requires a couple of defines to avoid conflicting with the
>> POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
>> so does not affect run-time performance. The bitmap calculations in this
>> patch gives the following number of bits for different architectures:
>>=20
>> - 24 bits on 32-bit architectures
>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
>> - 32 bits on other 64-bit architectures
>
>  From commit c07aea3ef4d4 ("mm: add a signature in struct page"):
> "The page->signature field is aliased to page->lru.next and
> page->compound_head, but it can't be set by mistake because the
> signature value is a bad pointer, and can't trigger a false positive
> in PageTail() because the last bit is 0."
>
> And commit 8a5e5e02fc83 ("include/linux/poison.h: fix LIST_POISON{1,2}=20
> offset"):
> "Poison pointer values should be small enough to find a room in
> non-mmap'able/hardly-mmap'able space."
>
> So the question seems to be:
> 1. Is stashing the ID causing page->pp_magic to be in the mmap'able/
>     easier-mmap'able space? If yes, how can we make sure this will not
>     cause any security problem?
> 2. Is the masking the page->pp_magic causing a valid pionter for
>     page->lru.next or page->compound_head to be treated as a vaild
>     PP_SIGNATURE? which might cause page_pool to recycle a page not
>     allocated via page_pool.

Right, so my reasoning for why the defines in this patch works for this
is as follows: in both cases we need to make sure that the ID stashed in
that field never looks like a valid kernel pointer. For 64-bit arches
(where CONFIG_ILLEGAL_POINTER_VALUE), we make sure of this by never
writing to any bits that overlap with the illegal value (so that the
PP_SIGNATURE written to the field keeps it as an illegal pointer value).
For 32-bit arches, we make sure of this by making sure the top-most bit
is always 0 (the -1 in the define for _PP_DMA_INDEX_BITS) in the patch,
which puts it outside the range used for kernel pointers (AFAICT).

>> Since all the tracking is performed on DMA map/unmap, no additional code
>> is needed in the fast path, meaning the performance overhead of this
>> tracking is negligible. A micro-benchmark shows that the total overhead
>> of using xarray for this purpose is about 400 ns (39 cycles(tsc) 395.218
>> ns; sum for both map and unmap[1]). Since this cost is only paid on DMA
>> map and unmap, it seems like an acceptable cost to fix the late unmap
>
> For most use cases when PP_FLAG_DMA_MAP is set and IOMMU is off, the
> DMA map and unmap operation is almost negligible as said below, so the
> cost is about 200% performance degradation, which doesn't seems like an
> acceptable cost.

I disagree. This only impacts the slow path, as long as pages are
recycled there is no additional cost. While your patch series has
demonstrated that it is *possible* to reduce the cost even in the slow
path, I don't think the complexity cost of this is worth it.

[...]

>> The extra memory needed to track the pages is neatly encapsulated inside
>> xarray, which uses the 'struct xa_node' structure to track items. This
>> structure is 576 bytes long, with slots for 64 items, meaning that a
>> full node occurs only 9 bytes of overhead per slot it tracks (in
>> practice, it probably won't be this efficient, but in any case it should
>
> Is there any debug infrastructure to know if it is not this efficient?
> as there may be 576 byte overhead for a page for the worst case.

There's an XA_DEBUG define which enables some dump functions, but I
don't think there's any API to inspect the memory usage. I guess you
could attach a BPF program and walk the structure, or something?

>> +			/* Make sure all concurrent returns that may see the old
>> +			 * value of dma_sync (and thus perform a sync) have
>> +			 * finished before doing the unmapping below. Skip the
>> +			 * wait if the device doesn't actually need syncing, or
>> +			 * if there are no outstanding mapped pages.
>> +			 */
>> +			if (dma_dev_need_sync(pool->p.dev) &&
>> +			    !xa_empty(&pool->dma_mapped))
>> +				synchronize_net();
>
> I guess the above synchronize_net() is assuming that the above dma sync
> API is always called in the softirq context, as it seems there is no
> rcu read lock added in this patch to be paired with that.

Yup, that was my assumption.

> Doesn't page_pool_put_page() might be called in non-softirq context when
> allow_direct is false and in_softirq() returns false?

I am not sure if this happens in practice in any of the delayed return
paths we are worried about for this patch. If it does we could apply
something like the diff below (on top of this patch). I can respin with
this if needed, but I'll wait a bit and give others a chance to chime in.

-Toke



@@ -465,9 +465,13 @@ page_pool_dma_sync_for_device(const struct page_pool *=
pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if ((READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_DEV) &&
-	    dma_dev_need_sync(pool->p.dev))
-		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
+	if (dma_dev_need_sync(pool->p.dev)) {
+		rcu_read_lock();
+		if (READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_DEV)
+			__page_pool_dma_sync_for_device(pool, netmem,
+							dma_sync_size);
+		rcu_read_unlock();
+	}
 }
=20
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, g=
fp_t gfp)


