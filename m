Return-Path: <linux-rdma+bounces-16530-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEwHLRhwg2lgmwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16530-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 17:13:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE00EA03B
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 17:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 487523025D1C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2CA3F076C;
	Wed,  4 Feb 2026 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UcJj2FOg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61383F0746
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219509; cv=none; b=TW2ICKI70EMrjFUY5lB5odetM/mRa8CaBFVX3TY3CQwL73MA4195gLqribB9KZpt9RffTEK2IW9Ab3jVCJloHNDIVvjORmNzwnrB+KW/oytOUHYNQ9MMikuBWbgYQlJ+Wp3ckzDZ7LG+4mgde35JDfCOvZiaRSG7K7j/RH3HTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219509; c=relaxed/simple;
	bh=cKHHmzxugmDBNAg6RmH8ZEM3qt5Na3WobBTp7YVq3WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTgfjtzk+XmIoF8OcF8KtmaY2KGug3lH7hyBWLWwnq8E+3Vcc3V8i6a1NB7GkxGpfDStcXA0ds0UmWXUHu2+5ksLLXSB5FeZVCBB6qh1BB24PZIFVPAmD29Wvafga2Mj8dnssP+W84DDhyUNRwfrXN4T4d3ziPJaRdJfn7YH3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UcJj2FOg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee07570deso59617415e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 07:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770219506; x=1770824306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gdwx9qMhU8Mv08dQCrnRQMly3tLdVV2BAcHhUVaJiBk=;
        b=UcJj2FOgRDZUmRO/t/m9E2ACpIq+VR0TLxYJL4xJ4k453707I3q+zVBrF9qou0rTHg
         3nGglKe/UKJ39Q6wgGKPNePPEj4q2zs/OM04O5/nqHiRqIvTsJXgQ8ctU//pjz2gjO/9
         4fIZ6LPFUCP8rlb9ymqCh2lZxlPnp5WAAxV+MWoqI0OoF2t8ODRg375J3+l7lLlet1o2
         TsQScsnQ0eKMRsCKDhLTpa6Mxok1axWlZaIu2VfkpsbbfMniZe1IKQvMi2KsI0JSjBlu
         VAGRcA5cmQYAdxYBww54DHcuGb646Wq5CWUzRb6eNmHiDTFVr1X/0Uijf0bhFU8XxHRu
         VUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770219506; x=1770824306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gdwx9qMhU8Mv08dQCrnRQMly3tLdVV2BAcHhUVaJiBk=;
        b=ZM72eSVSfZjFciEakfmhgxD6pNqQsoocbJ+bGi6X/DBjY6ZXxywkUMUI7rckEeloP8
         EjhlChqpLscHdct+jsGFKB1m1Fhwv9SmeC113ZFTjK9Z0zZk4Lw3M16MzTe9OdUJt7TQ
         m2uYMTPSb6gxCXBtus1/GqOBcoVQ0/QG723ojysxkLumPA0dC+rdSEyuyJeiu9npVT/C
         tpWxCPl117azNiccLh9v7kz9U8SB4gfzk519NdFYeplmxqbzy5C0jg/jUWFiGKD8CL5k
         XZ3J7nyEAAfS1XI6wMaYZtDdlIFCf14C/ZodTmTP55AyQ4JT7yN+xYO/sAPcb8gmlztF
         g6lA==
X-Gm-Message-State: AOJu0YzQhawZr96AE5JWreYthYbZEmRfp7HrnIVNuygGE5Bqt+FNvux3
	73UBe0nyaUZIYTWUmq3adp13VNHK5RUSHBYuEaKyJrAtVjSC2K/2+0UguRLVrp/nWeY=
X-Gm-Gg: AZuq6aLw9YQ+/FislVzgXgI33W5SP6+D2dgFFcyY3dttpqeEF0vNsuxU0SIPBUNiklS
	emgNdWzrl80PQS7caPd8WeXHMXHTxYA08c0s6ew8vMm9IILnfVvlMFzwxJgUEFKFLqYO8HEOm3J
	7Y//XJ88xyVjMFqD8Z+3xWka66qJYizd+guuMBNJpvmj/siRMCm68uuoKZ1c/kEJLj75VrvTHvw
	HbZ/R5Pf547YN2l6ykR4gcr1mmv7BCuP4ej3EO/rT0C9x9d3WeoM9j3mdOtMlq5Yr5y3cTCwT4F
	1d/9anGwNYE+UifrjEcdRVKusXYL9NdL+e208JrftnpQKaTQBIOb5sMdOpkm16baakVU4T/afrl
	dJsAafRpibH+/efnfFSuPFNh9ASzD/2ne0ioMG/8wDVbit4zDuH1RF/S+ExsYLvdyU5X+GvE8dx
	eUe4VjoMzSnyp4NQTXw8MtG6Q=
X-Received: by 2002:a05:600c:4753:b0:480:4d38:7abc with SMTP id 5b1f17b1804b1-4830e94c94fmr49376495e9.11.1770219505772;
        Wed, 04 Feb 2026 07:38:25 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831084dd88sm53766815e9.6.2026.02.04.07.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:38:25 -0800 (PST)
Date: Wed, 4 Feb 2026 16:38:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <q4cc35lcpl2xrziu7c7hkebib6mc4bnapztckk3duzv5uzyjv7@f4nqhsi57wi7>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16530-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: ECE00EA03B
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
>
>So maybe mlx5 adds some NULL assignments on its error paths and less
>convoluted drivers can use a simpler option?

How about we have:
	int (*create_cq_umem)(struct ib_cq *cq,
			      const struct ib_cq_init_attr *attr,
			      struct ib_umem **umem,
                                             ^^

			      struct uverbs_attr_bundle *attrs);

And instead of taking ref in the callee we just do *umem = NULL? :S

This would help to cover the error path vs destroy path differences,
Tt could also be used to make sure the op consumed all umems; all
should be NULLed on success.

Makes sense?



>
>My issue with refcounts is that this isn't a refcounted structure, it
>has very well defined points where it must become freed.
>
>Like we can't get through detroy_qp without the umem being freed, that
>is illegal.
>
>Jason

