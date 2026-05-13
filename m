Return-Path: <linux-rdma+bounces-20567-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFKlMPhiBGq6HgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20567-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 13:39:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351653269B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 13:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5BFE3035247
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A943F7A86;
	Wed, 13 May 2026 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Boi2iGqx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42A3A5E64
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672295; cv=none; b=qRFQLlQRjP4j9YFQa5vIltaOzLJuDDd4hMFoAowYYLRU7xVfmAxkxeW4jViCfYWsOPvxDKdX+Z1gH374mUHPZESaTTgp9Ibx+XL3r+pyHYwt8q8TySx/Fl4v0srawa8NbA2bDQ6e8FJDvcxggtXsYukzUVj7videGiU1/wagHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672295; c=relaxed/simple;
	bh=bi1LtDseZKiiExJUNCsTzHxTrPBCRAx15vc671Lf+aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbfTqYxIMspNQarefELlnR+AkHlVIs9I8JCC46Et0LKjCCsGOTrL91CxaL/PpfnNMjqiGFsHV9uCHyFTVp+JJMVPgWutu9qEIyxS/UWEs86LW35rZ0d8DGvTNPq7rp892avv5qsk/5UOB9iOPLLQKPKZgvVUPA2rVOD9I3UsIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Boi2iGqx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so3481111f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 04:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778672292; x=1779277092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CqPA2PDnvx8iqKIrh3ub2oUL9wez/Zu+0VoDfgG87F0=;
        b=Boi2iGqxZjnrxD/uzwtkwsebAB1M6vyf0FHRTC0758zme5ZZul0sGqhx7MjfsJq9gY
         O4eoCMKOjyhrZHLiK7fgehLx10wHMsl+BJVkWXa3f6WsDRMdWoXRXCEve+Soyf3p0uOa
         mHGG0GeZUYPogQnUwlCft9CUsYhWseP8JEufB2IOQH3IIJK5ZXZZZT/QBb4lN+OPSUpy
         ru86rOF++I+TRJ9EiJ0XPaA8ersPr0u0ishqObB7jPBHgWA2tR96dIiJVA9H9fmZCBbd
         pDtBQ+jqJ16bSwhBAgSqgFR1rSxgUmsUoEg5rAl+YH0tuBeXEzpEMSr/+7HvxzWh+u2p
         P12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778672292; x=1779277092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqPA2PDnvx8iqKIrh3ub2oUL9wez/Zu+0VoDfgG87F0=;
        b=g/tDsI+Okw30kgoPN0/nqd8yvCUIxU5/OrfBiv2QYE+9j0nK0NUtShl8LFia7tLmIe
         yjadK54yvLc6r49vpED4Lc4TZXoWZbiIKe2TaYyt2ctg+rgRjqVofkEHsCAzpfvmSImu
         YCvheuq1qhLxNaUpHcRQoDLFGG9E5ZxosZzXpkz8mDzHkDfMVFAjLzAvbGzsn+gIlHQG
         Ju8hd6t+tIzjQD8b4QsNvWKK72WFQIWArG4F2IMlShBPKj4TkqZYMA7ahDOpMxZJKWNU
         on/WYN95zkBJyRWGlLxNZm3iY3o2r30th89xVLNuYc/FdAuadIqaGFObxjpC/TKw5ESH
         RSFA==
X-Gm-Message-State: AOJu0YyREky4tG/0L9QCx/p2gB+r3ydJuaQt5Gz8Z2yMMSKiRWkUG6G4
	FsRqsnvXX05SBAYLuo1jV1S81s3T8Gixzs1l1BkU2V3RMotKdm5pP37uNRPGkR0G3eY=
X-Gm-Gg: Acq92OGu3w7m9q31LR0a8NNX0IPNRwUg+CIgM1MocwNg0dXw1UuKvjCAk5/znslofpe
	Zy7Iow19gzYWzEUV4bS2j0oWIf3KfLOjPBnBKTTRshJt7lYDgoLjdjFGNnadIpE9p5l2zM+XLn5
	3cfqrJ5U8MHl5OJWMsZM+paRzA33m55BglWyELuJt9KOVlVRHdLLFVUxRGpEEnDk6AAc4V+GyfO
	VvPMxMywNz75ecdqe3coTNIXV3eeUCWdxIaQiQiz5FMluMfncz/JJ1xgZN4+UBR/FRLh9qYyNC/
	sm59QtnWgaj4euAtUxnTRJ3Y2ydMooezSXnvsGhcpS8/88nzg/vVF0wUf/h872Lk7bRHFM3sYQJ
	RgX8kUeTR7ozPgwi57koMOg7jz82/pGFND9vXQXkXrzX6R2/Rd1KmsoLnuRtVfJ6HQK+ucX1CND
	oFEYTeBeYmLVhJc2KssOj9bjC7mTpMcD/RP3T2Gbo44w==
X-Received: by 2002:a05:6000:615:b0:441:36b7:7262 with SMTP id ffacd0b85a97d-45c58a70e04mr4969604f8f.13.1778672291728;
        Wed, 13 May 2026 04:38:11 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120eb95sm38888282f8f.20.2026.05.13.04.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:38:11 -0700 (PDT)
Date: Wed, 13 May 2026 13:38:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 11/16] RDMA/mlx4: Use ib_umem_get_cq_buf()
 for user CQ buffer
Message-ID: <agRinwoVkaPujATb@FV6GYCPJ69>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-12-jiri@resnulli.us>
 <20260512182927.GJ7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512182927.GJ7702@ziepe.ca>
X-Rspamd-Queue-Id: 2351653269B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20567-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 08:29:27PM CEST, jgg@ziepe.ca wrote:
>On Thu, May 07, 2026 at 02:52:26PM +0200, Jiri Pirko wrote:
>> +	cq->umem = ib_umem_get_cq_buf(&dev->ib_dev, udata, entries * cqe_size,
>> +				      IB_ACCESS_LOCAL_WRITE);
>> +	if (IS_ERR(cq->umem)) {
>> +		err = PTR_ERR(cq->umem);
>>  		goto err_cq;
>>  	}
>> +	if (cq->umem) {
>> +		if (dev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_SW_CQ_INIT) {
>> +			err = -EOPNOTSUPP;
>> +			goto err_umem;
>
>Huh. this is getting pretty hacky.. The driver wants to memset the
>user buf to 0xcc for some reason, and it already has a nice flow that
>if that fails it tells the FW it fails and presumably is Ok.
>
>The issue is it passes buf_addr around insead of having made an
>ib_umem_memset() (which can reject dmabuf).
>
>Looks easy enough, change sg_zero_buffer() to sg_fill_buffer() to
>accept the 0xcc, ib_umem_memset() trivially calls it, remove the
>buf_addr from the call chain, directly use the umem in the
>mlx4_init_user_cqes(), remove the if above, use the
>ib_umem_get_cq_buf_or_va() in the driver..
>
>Leaving it like this just means the driver won't work with the new
>uAPI with normal VA which is not desirable..

Agreed. I would like to fix this in a follow-up patchset which would
look more or less like this (Claude generated):

 1) lib/scatterlist: add sg_fill_buffer()
    Generalize sg_zero_buffer() to take a fill byte. Keep
    sg_zero_buffer() as a thin static inline wrapper around
    sg_fill_buffer(..., 0) so existing callers (nvmet, scsi_debug,
    ccree, jh7110-aes, krb5) don't have to change.
 2) RDMA/umem: add ib_umem_memset()
    Walks the umem's sg list via sg_fill_buffer(). Rejects dmabuf and
    ODP umems with -EOPNOTSUPP. Honors umem offset/length bounds.
 3) net/mlx4: drop buf_addr/user_cq from mlx4_cq_alloc()
    Replace "void *buf_addr, bool user_cq" with
    "struct mlx4_buf *kbuf, bool sw_cq_init". The function only owns
    the kernel-side init via mlx4_init_kernel_cqes(); user-side init
    becomes the caller's responsibility. mlx4_init_user_cqes() goes
    away. mlx4_en and the kernel mlx4_ib path are updated to the new
    signature.
 4) RDMA/mlx4: switch to ib_umem_get_cq_buf_or_va() and ib_umem_memset()
    The user-CQ create path collapses to a single
    ib_umem_get_cq_buf_or_va() followed by an
    ib_umem_memset(cq->umem, 0xcc, ...) before mlx4_cq_alloc(). If the
    memset succeeds, tell FW sw_cq_init=true; otherwise fall back to
    FW-side init. dmabuf / ODP umems fall back naturally via
    ib_umem_memset() returning -EOPNOTSUPP, and the explicit
    MLX4_DEV_CAP_FLAG2_SW_CQ_INIT -EOPNOTSUPP branch goes away.

Makes sense?


