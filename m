Return-Path: <linux-rdma+bounces-16454-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mETxHT72gWljNAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16454-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 14:21:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA615D9D83
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 14:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10E643064917
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282FA38736D;
	Tue,  3 Feb 2026 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pm+Kwr1Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B9F50F
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124855; cv=none; b=NHOHj6qWcGyjFO7lQH1o5WjoxM2sk6tHMas2wNEG3UcJceHoFUpAee5e5ZmQFIiFRgOhWOperxKW4iJZh46YkSQVODZFtjZfjVQCSl03eNc4GkBLLTozreJzjAhHgUlrF9Zevzz6Dcm+vlkDnYyq5UhF7Nf33yg+s4x251Jww1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124855; c=relaxed/simple;
	bh=Cd2DCjZRQBaYZxUbKmIF2U53DrdzOXpB/N/48RuwLRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+IWqcF+RUgZmQkyBc25r3HsUt0ECANgxm1JCqGzvc7t9AmCeeRR+y9/2tyH4KfoNrnwAzl49zVF+p7PUDh++cBZ28ApKX1tshXLOxLlulF9Wen5vspXD2Zt2sPsxy/BA2gkq5//X9mqpqEBMcva0aJ23QKMQfgzLoNCa7Lri8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pm+Kwr1Z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso8225035e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 05:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770124849; x=1770729649; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tnDDGUltc7DTxq081ymDJ+GzyGmfnaB5OtIqHh5IsRU=;
        b=pm+Kwr1ZkeCxab24b/6YE2coGkyt2kgFb+WKpkrkxq5YT6k+zhW9X9dGqQcb3l9lXl
         NbU5Z1Pda8j5xQ9ZsbwjOS0i0lc+q+cdDNXH84H8h0hvZTkCRFIM/BxaommnNs3kA81R
         fBozgg7p02X7xdGQWT+EfUIZ8YrwTQ+mTSXLZF1zPiFjY1bt37p5PhaVsR8P/wgcBHyb
         dYzCUspl2zqyPTfr4dyEYZjypHEQ2TW6AuMRZhA/hZ2Sq6HZ3Nh/fTlJjPth1xC92Dpz
         FavIvOUYrlvJBFS1wcXCmIyK9X5FRB7okRlJJIb+AEpatKvsYsfVgFlcJtCQ3plLMLuZ
         Mnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770124849; x=1770729649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnDDGUltc7DTxq081ymDJ+GzyGmfnaB5OtIqHh5IsRU=;
        b=j30lHBBTe6y/y2g3rO/sDq5CvnSEJr5vomXFB0yGkKC8UTYJmW7hwk0Z7gUogD/CYv
         wy6ad10EZ7V+/J8bevnJKwMJnI30V39pr1QJisRO6g0Y51RQye016KX6uvNxyPXpSoTB
         vyQass7C3aYQVpdG+gipO+nGCOxeWLSWaM5Fdh7jq9B7U1F9JDY0AjFr5ZgA2y82eNcO
         7hutQ3f65zITIN1fJvotCNjIKVcGoGY1mejAGYHwxkkvHgEjErUf4ms7Z0S9Bu3SFq2F
         SJA9C3vfKRKCunnebda+RsnPNncMEqPMszAitrbzPDmqHKVAsjC/LuYkwnlMGc8q29co
         NJFw==
X-Gm-Message-State: AOJu0YwbwpJYFd2X+JLonZaTi1a+bJaai6GlOJ1yUfS1/Q3bt/uRT1A6
	hFs1Zf0es2ESWMwAQHE8eRZD4wl8hSBbgtl0KbOl/q07rHf7Zr+XghyQb87ZI0HJQqA=
X-Gm-Gg: AZuq6aIc0fgfVyCt8VN+IRH4h/jR3+lzB+mQgrAJz85N9Sz1MzacL4mlMcRo9qTD3wD
	Le1TeBjt0OjCeB0d9L1qTZPc0TLK0fpqtHh5ThfaREvYTktFNLIU1ANKqu8hJWjyq/SYXlLgP65
	6GcWfwAuGMTtt2iWYZYbc+NsGOoDQIMahpETJFq5hRxmpIxUq8sEdt/RxTPvJYJ89n9kUmNZ2KA
	e8FDaOILX0rd6LBTMKszDMF96XnS8X37T05fvZoHPMqQTWA23I707lR7cJSuN5DaUIuGqzOG1uj
	4NC0k272/wNz7gEQb6WC5+Vg/mp60hOUT+fiV3oiXRQwwhM+q/8J5gb2azQN50tcvu15/VF/cKr
	qk+6wIyy1xrb7PJ8K4k+Og4CmNTEwU8S6iqvhdC57gVvlBTo2xbBKhnp1inuam2QVmQhcXcc6aB
	6TAxOoCaSBFPo2ZtQ6X4GfeWw=
X-Received: by 2002:a05:600c:5643:b0:47e:e452:ec12 with SMTP id 5b1f17b1804b1-48305171930mr25173515e9.15.1770124848841;
        Tue, 03 Feb 2026 05:20:48 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da903a30sm148952485e9.1.2026.02.03.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 05:20:47 -0800 (PST)
Date: Tue, 3 Feb 2026 14:20:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, wangliang74@huawei.com, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <56arliffs27lqgriymsnysnh672joz7ihndkeffqee32vvwxby@w6qhwezufrrc>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203100327.GS34749@unreal>
 <vw3hrr5fsamtsgydvydoewd4fnglas5xzickgfpjgp5y44gxkm@dmmvo36blqtb>
 <20260203122618.GT34749@unreal>
 <uixv7cu4qe5vqkl3dlsd4smbxvflo3syoseuwtf4v7xhwgziul@gqlnz4geufth>
 <20260203130335.GU34749@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203130335.GU34749@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16454-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: CA615D9D83
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 02:03:35PM +0100, leon@kernel.org wrote:
>On Tue, Feb 03, 2026 at 01:46:21PM +0100, Jiri Pirko wrote:
>> Tue, Feb 03, 2026 at 01:26:18PM +0100, leon@kernel.org wrote:
>> >On Tue, Feb 03, 2026 at 11:11:39AM +0100, Jiri Pirko wrote:
>> >> Tue, Feb 03, 2026 at 11:03:27AM +0100, leon@kernel.org wrote:
>> >> >On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
>> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> 
>> >> >> Introduce reference counting for ib_umem objects to simplify memory
>> >> >> lifecycle management when umem buffers are shared between the core
>> >> >> layer and device drivers.
>> >
>> >The lifecycle should be confined either to the core or to the driver,
>> >but it should not mix responsibilities across both.
>> 
>> Okay, I can re-phrase. The point is, the last holding reference actually
>> does the release.
>> 
>> 
>> >
>> >> >> 
>> >> >> When the core RDMA layer allocates an ib_umem and passes it to a driver
>> >> >> (e.g., for CQ or QP creation with external buffers), both layers need
>> >> >> to manage the umem lifecycle. Without reference counting, this requires
>> >> >> complex conditional release logic to avoid double-frees on error paths
>> >> >> and leaks on success paths.
>> >> >
>> >> >This sentence doesn't align with the proposed change.
>> >> 
>> >> Hmm, I'm not sure why you think it does not align. It exactly describes
>> >> the code I had it originally without this path in place :)
>> >
>> >There is no complex conditional release logic which this reference
>> >counting solves. That counting allows delayed, semi-random release,
>> >nothing more.
>> 
>> Again. Without the refcount, you have to make sure the umem is consumed
>> by the op. Actually, check the existing create_cq_umem. On the error
>> path, the umem is released by the caller. On success path the ownership
>> is transferred to the calle. 
>
>We need to fix it. Exactly right now, I'm working to make sure that umem
>is managed by ib_core and drivers don't call to ib_umem_get() at all.

Should I wait and rebase?


>
>> Consider various error paths in the calle
>> some of which are shared with destroy_cq op, some umems are not actually
>> used etc, it's a nightmare. I had the code written down like this
>> originally, that's why I actually know.
>> 
>> Perhaps I'm missing your point. Is is just about the patch descriptio or
>> about the code itself?
>
>Description and the code. UMEM needs to be created by ib_core and
>ib_core should destroy them.
>
>> 
>> 
>> >
>> >> 
>> >> >
>> >> >> 
>> >> >> With reference counting:
>> >> >> - Core allocates umem with refcount=1
>> >> >> - Driver calls ib_umem_get_ref() to take a reference
>> >> >> - Both layers can unconditionally call ib_umem_release()
>> >> >> - The umem is freed only when the last reference is dropped
>> >> >> 
>> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >> Change-Id: Ifb1765ea3b14dab3329294633ea5df063c74420d
>> >> >
>> >> >Please remove the Change-Ids and write the commit message yourself,
>> >> >without relying on AI. The current message provides no meaningful
>> >> 
>> >> I'm new in RDMA. Not sure what you mean by meaningful information :)
>> >
>> >This part of commit message is clearly generated by Cursor:
>> >With reference counting:
>> >- Core allocates umem with refcount=1
>> >- Driver calls ib_umem_get_ref() to take a reference
>> >- Both layers can unconditionally call ib_umem_release()
>> >- The umem is freed only when the last reference is dropped
>> >
>> >The above paragraphs have clear AI pattern as they don't explain why,
>> >but only how.
>> 
>> Why is explained above, isn't it?
>> If you don't want the "how part", I can remove it, no problem.
>
>Commit message should provide an additional information, which is not
>available in the code itself. Description like "Core allocates umem with
>refcount=1" has zero value.

:), sure


>
>Thanks
>
>> 
>> 
>> >
>> >I'm seeing the SAME commit messages in many internals and externals
>> >patches.
>> >
>> >Even my AI review is agreed with me :)
>> >...
>> >"AI-authorship-score": "medium"
>> >...
>> >
>> >> I'm always trying to provide it.
>> >> 
>> >> >information, particularly the auto‑generated summary at the end.
>> >> 
>> >> Doh, the changeIDs :) Sorry about that.
>> >> 
>> >> 
>> >> >
>> >> >Thanks
>> >> >
>> >> >> ---
>> >> >>  drivers/infiniband/core/umem.c        | 5 +++++
>> >> >>  drivers/infiniband/core/umem_dmabuf.c | 1 +
>> >> >>  drivers/infiniband/core/umem_odp.c    | 3 +++
>> >> >>  include/rdma/ib_umem.h                | 9 +++++++++
>> >> >>  4 files changed, 18 insertions(+)
>> >> >> 
>> >> >> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> >> >> index 8137031c2a65..09ce694d66ea 100644
>> >> >> --- a/drivers/infiniband/core/umem.c
>> >> >> +++ b/drivers/infiniband/core/umem.c
>> >> >> @@ -192,6 +192,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>> >> >>  	umem = kzalloc(sizeof(*umem), GFP_KERNEL);
>> >> >>  	if (!umem)
>> >> >>  		return ERR_PTR(-ENOMEM);
>> >> >> +	refcount_set(&umem->refcount, 1);
>> >> >>  	umem->ibdev      = device;
>> >> >>  	umem->length     = size;
>> >> >>  	umem->address    = addr;
>> >> >> @@ -280,11 +281,15 @@ EXPORT_SYMBOL(ib_umem_get);
>> >> >>  /**
>> >> >>   * ib_umem_release - release memory pinned with ib_umem_get
>> >> >>   * @umem: umem struct to release
>> >> >> + *
>> >> >> + * Decrement the reference count and free the umem when it reaches zero.
>> >> >>   */
>> >> >>  void ib_umem_release(struct ib_umem *umem)
>> >> >>  {
>> >> >>  	if (!umem)
>> >> >>  		return;
>> >> >> +	if (!refcount_dec_and_test(&umem->refcount))
>> >> >> +		return;
>> >> >>  	if (umem->is_dmabuf)
>> >> >>  		return ib_umem_dmabuf_release(to_ib_umem_dmabuf(umem));
>> >> >>  	if (umem->is_odp)
>> >> >> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
>> >> >> index 939da49b0dcc..5c5286092fca 100644
>> >> >> --- a/drivers/infiniband/core/umem_dmabuf.c
>> >> >> +++ b/drivers/infiniband/core/umem_dmabuf.c
>> >> >> @@ -143,6 +143,7 @@ ib_umem_dmabuf_get_with_dma_device(struct ib_device *device,
>> >> >>  	}
>> >> >>  
>> >> >>  	umem = &umem_dmabuf->umem;
>> >> >> +	refcount_set(&umem->refcount, 1);
>> >> >>  	umem->ibdev = device;
>> >> >>  	umem->length = size;
>> >> >>  	umem->address = offset;
>> >> >> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
>> >> >> index 572a91a62a7b..7be30fda57e3 100644
>> >> >> --- a/drivers/infiniband/core/umem_odp.c
>> >> >> +++ b/drivers/infiniband/core/umem_odp.c
>> >> >> @@ -144,6 +144,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_device *device,
>> >> >>  	if (!umem_odp)
>> >> >>  		return ERR_PTR(-ENOMEM);
>> >> >>  	umem = &umem_odp->umem;
>> >> >> +	refcount_set(&umem->refcount, 1);
>> >> >>  	umem->ibdev = device;
>> >> >>  	umem->writable = ib_access_writable(access);
>> >> >>  	umem->owning_mm = current->mm;
>> >> >> @@ -185,6 +186,7 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
>> >> >>  	if (!odp_data)
>> >> >>  		return ERR_PTR(-ENOMEM);
>> >> >>  	umem = &odp_data->umem;
>> >> >> +	refcount_set(&umem->refcount, 1);
>> >> >>  	umem->ibdev = root->umem.ibdev;
>> >> >>  	umem->length     = size;
>> >> >>  	umem->address    = addr;
>> >> >> @@ -245,6 +247,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
>> >> >>  	if (!umem_odp)
>> >> >>  		return ERR_PTR(-ENOMEM);
>> >> >>  
>> >> >> +	refcount_set(&umem_odp->umem.refcount, 1);
>> >> >>  	umem_odp->umem.ibdev = device;
>> >> >>  	umem_odp->umem.length = size;
>> >> >>  	umem_odp->umem.address = addr;
>> >> >> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
>> >> >> index 0a8e092c0ea8..44264f78eab3 100644
>> >> >> --- a/include/rdma/ib_umem.h
>> >> >> +++ b/include/rdma/ib_umem.h
>> >> >> @@ -10,6 +10,7 @@
>> >> >>  #include <linux/list.h>
>> >> >>  #include <linux/scatterlist.h>
>> >> >>  #include <linux/workqueue.h>
>> >> >> +#include <linux/refcount.h>
>> >> >>  #include <rdma/ib_verbs.h>
>> >> >>  
>> >> >>  struct ib_ucontext;
>> >> >> @@ -19,6 +20,7 @@ struct dma_buf_attach_ops;
>> >> >>  struct ib_umem {
>> >> >>  	struct ib_device       *ibdev;
>> >> >>  	struct mm_struct       *owning_mm;
>> >> >> +	refcount_t		refcount;
>> >> >>  	u64 iova;
>> >> >>  	size_t			length;
>> >> >>  	unsigned long		address;
>> >> >> @@ -110,6 +112,12 @@ static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
>> >> >>  
>> >> >>  struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>> >> >>  			    size_t size, int access);
>> >> >> +
>> >> >> +static inline void ib_umem_get_ref(struct ib_umem *umem)
>> >> >> +{
>> >> >> +	refcount_inc(&umem->refcount);
>> >> >> +}
>> >> >> +
>> >> >>  void ib_umem_release(struct ib_umem *umem);
>> >> >>  int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>> >> >>  		      size_t length);
>> >> >> @@ -188,6 +196,7 @@ static inline struct ib_umem *ib_umem_get(struct ib_device *device,
>> >> >>  {
>> >> >>  	return ERR_PTR(-EOPNOTSUPP);
>> >> >>  }
>> >> >> +static inline void ib_umem_get_ref(struct ib_umem *umem) { }
>> >> >>  static inline void ib_umem_release(struct ib_umem *umem) { }
>> >> >>  static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>> >> >>  		      		    size_t length) {
>> >> >> -- 
>> >> >> 2.51.1
>> >> >> 
>> >> >> 

