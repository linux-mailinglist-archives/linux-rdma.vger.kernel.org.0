Return-Path: <linux-rdma+bounces-16451-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF0pCufvgWlAMwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16451-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 13:53:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81956D9643
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 13:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8572930D0A58
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 12:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E808E154425;
	Tue,  3 Feb 2026 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NxtjhD3u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9AD33EAF2
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122791; cv=none; b=pLUMRPfaFPDUIvoDvxGdwAcfiT7Tcu5x5wbc6KrmsbkH9MwKYcRiIkr16lOfv4yVuy1WPmcTnTmBwNAwgX7lBdB8ZFWX11Z02Q7kpgcB9GVyI8Aie247dh0Bo293H35QeFSZHREhtJycJ5TshCtFHRFt8WfsHShAYx5PK7P8zwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122791; c=relaxed/simple;
	bh=/93phg4CyZMFqS0WutGAtCPjMzrJKzxjKgHiPLVvTIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx/5T/obnkSn4ecbL9z/1djth3P2zPrHBzKSRiqs1iMFlW0B8V1YBmKfZqh0qLpAAAg5yY7nDcE4Gfekn+OsH/hB7Z7YCUIE5bZDD6Gmm7Vbbq1RUdQNktugSJqCf6Ycd4V86MD/nqpIM3B3qmyYcrYGRv/muKNRT+FiDUjXqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NxtjhD3u; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43246af170aso482618f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 04:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770122786; x=1770727586; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=54ELjmrXiS83xwXVfZxCNrOPPzvj2zatPFhLcTtyJ9Y=;
        b=NxtjhD3uF0JZN47P+OjtUQ2vgDg5K0exCWcoIRPt+GXDm87iNbVnQhFn1BVQutEXas
         XsgKPvVtfo9ljVUpjDTAdhYwzKN0H38aq/Q/CxhnxeJ+0X22PN5ut+/Fn7WQOkbq3W5f
         6VdPb6jj2XIvhjsE5SzsZ+nwKt9PWUyI51GYODYJa0v5LWToqNb0p9Enxs/3iG4U5m1G
         yv4zYFpivyJ/8p767MjcImRmmOAH0s/aRv8uLyyhEJcMv3MLmgTOVbuzTOtDzLUhB26h
         OtlshDD1mLghb0m99Ew0O2ZjZ9R376RiDMbN13qKYLjihx/nRcgRaM41k1GMKf2h+2EQ
         kaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770122786; x=1770727586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54ELjmrXiS83xwXVfZxCNrOPPzvj2zatPFhLcTtyJ9Y=;
        b=bmCpjwC6bM04SB82B1nij9+TGNJOrSOfYbGPiP/gTY9CPEpUbJPaRhZO6oTFH2bxcZ
         t2dDwGRIfJe0QJuDQY558fOK9lYemCLywhPn91CaeKXO2wGSHkcvuY2184xzFV1+KEMx
         SIbcjaMaXl1SqO0Nzn2DIDeQTv3Xs/4dTvE+bQ9wXiYxhACSSYF3zdSv1DLSwtYt59yZ
         YWxONSsYX6GL76cVz5Fz36kqEuA0ZeabGpHYQN1Z1c65+1z+fzlMIdc1PbM25buTQR8u
         KVl1ZvRmowLejIfXvSsqBPaoVWKEHvS96wbPBwJUciOhTSpkGf6/rYg44ZINOT7c443P
         hTmQ==
X-Gm-Message-State: AOJu0Yw8AnX/883trFnUQBQI2P+2lt+0iJEzofr9t+EDhbDCyRjGS9CG
	zGQh4pcK0+W9WV1WBiEu8XNCV3HN8jufDsdNmP0AHEufXNv7+V8niTxVsgdCtOOudas=
X-Gm-Gg: AZuq6aLMeGOkDpTZt7FiAkVn1X82cbKYSeq1LaUGBmVHdLAbuTJEvYGjJhRZQWwYqX8
	tWgErfiu6kmKW7lwpEuA/Wem7yTUmvJoBcB93Hgfw/s32TcQIXnmc4t0VFm2de9FKbVNyMq/tV6
	ow/QYiOEmWf9dfvVOy9LCQw+z0sBPA4f95xCwKfYm6CKXQmZjLuqHHD6RMwz9KEQON6fu0bzmmR
	ioBwVFSTG7rWd3Pk9MgHcZFXbJJ4iSIlfSVdYRVB7nf5gX2CxcjGRlP3oTVc2/Vmpge4ChNxXop
	TOt8z7wBHb19/z+LMaLc8cSgX4d/PiG2eu990nu6PMsXl7cliT77ylp+c2Ns2erIoFzWwIwoMC6
	8/QYWN1w1SyIoYoJrwCTLL97J5Xn9W7XNkhLEQA9Ep64DIKyDf8C+3WRYphGSTFmbYCE6zQjknN
	zzQUBDKYNIO1LDrOQWNbMJUB4=
X-Received: by 2002:a5d:5f43:0:b0:435:db93:72e7 with SMTP id ffacd0b85a97d-4361130b379mr4767758f8f.3.1770122785264;
        Tue, 03 Feb 2026 04:46:25 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353f8bsm48411570f8f.39.2026.02.03.04.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:46:24 -0800 (PST)
Date: Tue, 3 Feb 2026 13:46:21 +0100
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
Message-ID: <uixv7cu4qe5vqkl3dlsd4smbxvflo3syoseuwtf4v7xhwgziul@gqlnz4geufth>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203100327.GS34749@unreal>
 <vw3hrr5fsamtsgydvydoewd4fnglas5xzickgfpjgp5y44gxkm@dmmvo36blqtb>
 <20260203122618.GT34749@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203122618.GT34749@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16451-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 81956D9643
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 01:26:18PM +0100, leon@kernel.org wrote:
>On Tue, Feb 03, 2026 at 11:11:39AM +0100, Jiri Pirko wrote:
>> Tue, Feb 03, 2026 at 11:03:27AM +0100, leon@kernel.org wrote:
>> >On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Introduce reference counting for ib_umem objects to simplify memory
>> >> lifecycle management when umem buffers are shared between the core
>> >> layer and device drivers.
>
>The lifecycle should be confined either to the core or to the driver,
>but it should not mix responsibilities across both.

Okay, I can re-phrase. The point is, the last holding reference actually
does the release.


>
>> >> 
>> >> When the core RDMA layer allocates an ib_umem and passes it to a driver
>> >> (e.g., for CQ or QP creation with external buffers), both layers need
>> >> to manage the umem lifecycle. Without reference counting, this requires
>> >> complex conditional release logic to avoid double-frees on error paths
>> >> and leaks on success paths.
>> >
>> >This sentence doesn't align with the proposed change.
>> 
>> Hmm, I'm not sure why you think it does not align. It exactly describes
>> the code I had it originally without this path in place :)
>
>There is no complex conditional release logic which this reference
>counting solves. That counting allows delayed, semi-random release,
>nothing more.

Again. Without the refcount, you have to make sure the umem is consumed
by the op. Actually, check the existing create_cq_umem. On the error
path, the umem is released by the caller. On success path the ownership
is transferred to the calle. Consider various error paths in the calle
some of which are shared with destroy_cq op, some umems are not actually
used etc, it's a nightmare. I had the code written down like this
originally, that's why I actually know.

Perhaps I'm missing your point. Is is just about the patch descriptio or
about the code itself?


>
>> 
>> >
>> >> 
>> >> With reference counting:
>> >> - Core allocates umem with refcount=1
>> >> - Driver calls ib_umem_get_ref() to take a reference
>> >> - Both layers can unconditionally call ib_umem_release()
>> >> - The umem is freed only when the last reference is dropped
>> >> 
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> Change-Id: Ifb1765ea3b14dab3329294633ea5df063c74420d
>> >
>> >Please remove the Change-Ids and write the commit message yourself,
>> >without relying on AI. The current message provides no meaningful
>> 
>> I'm new in RDMA. Not sure what you mean by meaningful information :)
>
>This part of commit message is clearly generated by Cursor:
>With reference counting:
>- Core allocates umem with refcount=1
>- Driver calls ib_umem_get_ref() to take a reference
>- Both layers can unconditionally call ib_umem_release()
>- The umem is freed only when the last reference is dropped
>
>The above paragraphs have clear AI pattern as they don't explain why,
>but only how.

Why is explained above, isn't it?
If you don't want the "how part", I can remove it, no problem.


>
>I'm seeing the SAME commit messages in many internals and externals
>patches.
>
>Even my AI review is agreed with me :)
>...
>"AI-authorship-score": "medium"
>...
>
>> I'm always trying to provide it.
>> 
>> >information, particularly the auto‑generated summary at the end.
>> 
>> Doh, the changeIDs :) Sorry about that.
>> 
>> 
>> >
>> >Thanks
>> >
>> >> ---
>> >>  drivers/infiniband/core/umem.c        | 5 +++++
>> >>  drivers/infiniband/core/umem_dmabuf.c | 1 +
>> >>  drivers/infiniband/core/umem_odp.c    | 3 +++
>> >>  include/rdma/ib_umem.h                | 9 +++++++++
>> >>  4 files changed, 18 insertions(+)
>> >> 
>> >> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> >> index 8137031c2a65..09ce694d66ea 100644
>> >> --- a/drivers/infiniband/core/umem.c
>> >> +++ b/drivers/infiniband/core/umem.c
>> >> @@ -192,6 +192,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>> >>  	umem = kzalloc(sizeof(*umem), GFP_KERNEL);
>> >>  	if (!umem)
>> >>  		return ERR_PTR(-ENOMEM);
>> >> +	refcount_set(&umem->refcount, 1);
>> >>  	umem->ibdev      = device;
>> >>  	umem->length     = size;
>> >>  	umem->address    = addr;
>> >> @@ -280,11 +281,15 @@ EXPORT_SYMBOL(ib_umem_get);
>> >>  /**
>> >>   * ib_umem_release - release memory pinned with ib_umem_get
>> >>   * @umem: umem struct to release
>> >> + *
>> >> + * Decrement the reference count and free the umem when it reaches zero.
>> >>   */
>> >>  void ib_umem_release(struct ib_umem *umem)
>> >>  {
>> >>  	if (!umem)
>> >>  		return;
>> >> +	if (!refcount_dec_and_test(&umem->refcount))
>> >> +		return;
>> >>  	if (umem->is_dmabuf)
>> >>  		return ib_umem_dmabuf_release(to_ib_umem_dmabuf(umem));
>> >>  	if (umem->is_odp)
>> >> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
>> >> index 939da49b0dcc..5c5286092fca 100644
>> >> --- a/drivers/infiniband/core/umem_dmabuf.c
>> >> +++ b/drivers/infiniband/core/umem_dmabuf.c
>> >> @@ -143,6 +143,7 @@ ib_umem_dmabuf_get_with_dma_device(struct ib_device *device,
>> >>  	}
>> >>  
>> >>  	umem = &umem_dmabuf->umem;
>> >> +	refcount_set(&umem->refcount, 1);
>> >>  	umem->ibdev = device;
>> >>  	umem->length = size;
>> >>  	umem->address = offset;
>> >> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
>> >> index 572a91a62a7b..7be30fda57e3 100644
>> >> --- a/drivers/infiniband/core/umem_odp.c
>> >> +++ b/drivers/infiniband/core/umem_odp.c
>> >> @@ -144,6 +144,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_device *device,
>> >>  	if (!umem_odp)
>> >>  		return ERR_PTR(-ENOMEM);
>> >>  	umem = &umem_odp->umem;
>> >> +	refcount_set(&umem->refcount, 1);
>> >>  	umem->ibdev = device;
>> >>  	umem->writable = ib_access_writable(access);
>> >>  	umem->owning_mm = current->mm;
>> >> @@ -185,6 +186,7 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
>> >>  	if (!odp_data)
>> >>  		return ERR_PTR(-ENOMEM);
>> >>  	umem = &odp_data->umem;
>> >> +	refcount_set(&umem->refcount, 1);
>> >>  	umem->ibdev = root->umem.ibdev;
>> >>  	umem->length     = size;
>> >>  	umem->address    = addr;
>> >> @@ -245,6 +247,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
>> >>  	if (!umem_odp)
>> >>  		return ERR_PTR(-ENOMEM);
>> >>  
>> >> +	refcount_set(&umem_odp->umem.refcount, 1);
>> >>  	umem_odp->umem.ibdev = device;
>> >>  	umem_odp->umem.length = size;
>> >>  	umem_odp->umem.address = addr;
>> >> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
>> >> index 0a8e092c0ea8..44264f78eab3 100644
>> >> --- a/include/rdma/ib_umem.h
>> >> +++ b/include/rdma/ib_umem.h
>> >> @@ -10,6 +10,7 @@
>> >>  #include <linux/list.h>
>> >>  #include <linux/scatterlist.h>
>> >>  #include <linux/workqueue.h>
>> >> +#include <linux/refcount.h>
>> >>  #include <rdma/ib_verbs.h>
>> >>  
>> >>  struct ib_ucontext;
>> >> @@ -19,6 +20,7 @@ struct dma_buf_attach_ops;
>> >>  struct ib_umem {
>> >>  	struct ib_device       *ibdev;
>> >>  	struct mm_struct       *owning_mm;
>> >> +	refcount_t		refcount;
>> >>  	u64 iova;
>> >>  	size_t			length;
>> >>  	unsigned long		address;
>> >> @@ -110,6 +112,12 @@ static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
>> >>  
>> >>  struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>> >>  			    size_t size, int access);
>> >> +
>> >> +static inline void ib_umem_get_ref(struct ib_umem *umem)
>> >> +{
>> >> +	refcount_inc(&umem->refcount);
>> >> +}
>> >> +
>> >>  void ib_umem_release(struct ib_umem *umem);
>> >>  int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>> >>  		      size_t length);
>> >> @@ -188,6 +196,7 @@ static inline struct ib_umem *ib_umem_get(struct ib_device *device,
>> >>  {
>> >>  	return ERR_PTR(-EOPNOTSUPP);
>> >>  }
>> >> +static inline void ib_umem_get_ref(struct ib_umem *umem) { }
>> >>  static inline void ib_umem_release(struct ib_umem *umem) { }
>> >>  static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>> >>  		      		    size_t length) {
>> >> -- 
>> >> 2.51.1
>> >> 
>> >> 

