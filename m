Return-Path: <linux-rdma+bounces-16498-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK8vCdvugmkifQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16498-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 08:01:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEB2E2781
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 08:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5EAF3014C1C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 07:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DCF23E320;
	Wed,  4 Feb 2026 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ohu9i2MK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED01D6AA
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770188499; cv=none; b=VjEF2l89nfOqkRIr6RwSM8zWalCf9udftJlDE8/ihVsBFWas/WCSH4OIWRsfx6m7Y9c2wxh1G7LP7tTnwFSDFPXcq2nOPf1CG11DuNHHShTGrwxMhaRAi96ahNYC5JGXMGWJ8/vVC7+P6kAf+OmylR0U3boPnXC+5NzsrV2G3Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770188499; c=relaxed/simple;
	bh=/2EBBTU89uuKCNOfuS+snDmLqngyqDVtGc6DkuBgh3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpF5MHrcmkjC2WKPAFZEta2u8jXq+rl3pZRlrJXzkk8dXpYCiVYhKfK7HmGHNtkdVi7wY2zoje4+uW7hviLJQYgYSvdCgL4eVBHtKdvmqPgODcF4D4KgNN8Odq2d4BFBPxqdG8yMvFmYcK1ZwsO+g4M8mBYrBs6Z8v1zWGjvrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ohu9i2MK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43591b55727so5640240f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 23:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770188496; x=1770793296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZeN2Rop/Zpv51b8dvtttZgOgu72IkKDLaoUljyWknk=;
        b=ohu9i2MKS48hVX8Fnw79qqLDeF5DievNGaacm4SbRLhg4vk8D3ZdMLhiAu1y8wi7Rs
         3lPfnaN2y0RuBJiDO14B3d683Uvcvm7xwNNj4texTnQj8rrdkJO+DfYxRQJIfUE+Ziqz
         QVLgjL0I2OelnyUHET9um9uPV0Q2CAsu9MpsdavLE6IZQV892wwRF0HRsqx6jr2OhcuE
         kcQm7YUKEInau4T6sCbMYG6ai7jgakj3fno0Z66JQD5jCid1RfwrK5GUsObCHwFBN+iK
         LjH55ZbfduVDbgVqjZRPFtU/xhJcODsgw6Ktq3c8o7Wo2yCV1x2gIroIzNM1nsq/hRj2
         Ivig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770188496; x=1770793296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZeN2Rop/Zpv51b8dvtttZgOgu72IkKDLaoUljyWknk=;
        b=nCqzOGZnFSYDZY/2+Ol6/J7Gd/gLP63UrqbZdYYMscWUWzR6ZXR6h4kjbavdE3RCuE
         ZRifdMQNpQXeuNTM5y+xA2sOF8XIkGxQgd0VaK80p6e+Bk2ArA0gfCnK5LDlmTp7FtmS
         bLdAgiuzyZH0QP4SeSeVQbatPGRrBFYJ9+iWYGCRof6VnbRRoNsHq1IG15CW7AOUom+B
         DKoAXXr3tskP6WjTNkQVr6b1R45an+7c9eUQcFXb/g4HJ/8eMUjTn9E8rEvL2PCtHn8K
         Zm/q5wJHO7Om9vhqZinuLfq4XTRBxe+uvz6Qc4Kef3TQEpzao/PbTVFq6V/5S4NW1v7p
         nR6A==
X-Gm-Message-State: AOJu0YwzEr/ZORoCBT47rzkujEcsfXYt+HHyUNunzGGYCJ7kZLWu+yb3
	d4zLHSHByUMdNAApeRR3uJ/q+brqZard3CRbEM19kyASptqkLOFLapoAUazm7MPIpWc=
X-Gm-Gg: AZuq6aIMf/xyoMdBJbKMn0+HVueVQbgCUvsxLkW6ZsyZ5evppKVXPsGQzAHTK5J+PpH
	ZyJmjA1JvVK4xz7vXCS9wBpVmhoTj49k+YVrv9pJaCRYVDu/qx2oEIdLahpu9Q9ek3MzsZulG24
	y8EWzwkN59hTfIV19SWueCfco5FXE0FdIrZ6MSM3gFmd7OZ/oKo7MoDo22Qj+jwQ/OItn+51d6H
	pCPYrNdOHPU0yHAiDsZHqPKEpwjQ2lzyPaaTg8ktsNChlCcs7vI0Kwz61/ytSYN71yeDjwz/DeK
	odK36b3z2QS0T+cgl6d2QqbO4FHnQJsYjh44xzSghXJb3HVBmJqdzRGSCGBGS84aVDKpyerj/DU
	xrbDJQKLoyaEnbHzwb6d1gtR9qvc3zk/ktkIXJufCaae5otz6enoS4iUYVyJYfdTCFqkCtT4si7
	ydrVx+yJJkz5d5nOIHc/DK7TqJxg4n0uZ1tO5zqargKQ==
X-Received: by 2002:a05:6000:24c9:b0:435:b089:4f46 with SMTP id ffacd0b85a97d-4361805cf3emr2386705f8f.50.1770188495412;
        Tue, 03 Feb 2026 23:01:35 -0800 (PST)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:9519:b02d:f49f:3f52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e38e38sm4292085f8f.11.2026.02.03.23.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 23:01:34 -0800 (PST)
Date: Wed, 4 Feb 2026 08:01:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, wangliang74@huawei.com, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <ab5xbswwmttn6kzyqfwulpd4k2mynkuajo5nysw5sqjucqkfw3@r7eh2hmti2x2>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203145138.GQ2328995@ziepe.ca>
 <424kifntiluu2rrsqea6k3aatduoqemjccmsun5z6rvx67xo43@6q4t3r44ql3e>
 <20260203165938.GS2328995@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203165938.GS2328995@ziepe.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16498-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 6DEB2E2781
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 05:59:38PM +0100, jgg@ziepe.ca wrote:
>On Tue, Feb 03, 2026 at 04:39:52PM +0100, Jiri Pirko wrote:
>> Tue, Feb 03, 2026 at 03:51:38PM +0100, jgg@ziepe.ca wrote:
>> >On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Introduce reference counting for ib_umem objects to simplify memory
>> >> lifecycle management when umem buffers are shared between the core
>> >> layer and device drivers.
>> >
>> >I admit I have reservations about this too.. The flow should not be so
>> >convoluted that a refcount is necessary. The lifecycle of a umem is
>> >not uncertain at all.
>> >
>> >I imagine'd it would be like:
>> >
>> >core code:
>> >  if (ops->create_cq_umem) {
>> >     umem = umem_get
>> >     rc = ops->create_cq_umem(umem)
>> >     if (rc)
>> >      umem_free(umem)
>> >  } else {
>> >     rc = ops->create_cq()
>> >  }
>> >
>> >Driver:
>> >  create_cq():
>> >    copy_from_user(drvdata)
>> >    umem = umem_get()
>> >    rc = driver_create_cq_umem(umem, &drvdata))
>> >    if (rc)
>> >      umem_free(umem)
>> >
>> >   create_cq_umem()
>> >     copy_from_user(drvdata)
>> >     return driver_create_cq_umem(umem, &drvdata)
>> >
>> >   destroy_cq()
>> >     destry_hw
>> >     umem_free()
>> 
>> 
>> This is how it is now. However there are couple of challenges about this
>> flow:
>> 1) umem usage. For example, create_qp_umem at the end of the set gets 4
>>    umem pointers. sq,rq,sq_dbr,rq_dbr. Some driver may use only one of
>>    those, 2 of those, 3 of those. Depends. mlx5 actually uses 2 or 3.
>>    If what you suggest, the current approach stands, the user has to
>>    always take all pointers, store them and eventually release them on
>>    destroy_qp path.
>
>Userspace passing umems that are not used by the driver is an error.
>Fail the call.

Okay, that makes sense. I just wanted to ignore it :)


>
>> 2) error path. I found the error path quite odd. Then create_cq/qp_umem
>>    returns !=0, core releases all umems. However, standard cq/qp
>>    destroy path takes care of releasing umems. Since a lot of code on
>>    error path and destroy path is shared, it has to be informed to
>>    release or not release the umems. That is not nice.
>
>Generally I would not assign to the driver's umem storage until the
>creation is completed to avoid this. ie it stays null until committed.
>
>But looking at mlx5 that looks like quite a maze there.. Yikes..

Exactly.


>
>So maybe mlx5 adds some NULL assignments on its error paths and less
>convoluted drivers can use a simpler option?

Yeah, I wanted to avoid that. But sure.


>
>My issue with refcounts is that this isn't a refcounted structure, it
>has very well defined points where it must become freed.
>
>Like we can't get through detroy_qp without the umem being freed, that
>is illegal.

Sure, even with this patch that never happens. But I get your point.

>
>Jason

