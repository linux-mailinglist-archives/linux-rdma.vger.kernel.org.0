Return-Path: <linux-rdma+bounces-16474-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HUwKksrgmlFQAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16474-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:07:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30ADC7FC
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCEDA30E3099
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7BB3D3492;
	Tue,  3 Feb 2026 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NbCTrYsy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5C318B9E
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137982; cv=none; b=aFNBr7rfU0GzmSZSz44J5VXIviq5TCI6O0o3aontXFjNRaf8W5nnDjzfhLBZ4Peh+Ub7RDgM+n6KmQK/VzdgjrLv+cH0MYlRT8x/Kt512GhOAhzKWQJu1CbwjjEvee2IjrpCNbczXVFDFC06LPSq4X0Of+bLUeiWeCFHO+7EcC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137982; c=relaxed/simple;
	bh=jKLZqyhxLKqkncCIJZxdQK3XQmPv5iUfHAGsvEghIrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT9EJ0LwaxOvO6MDpIHtqvTNfvVhpbxP5ocKQrWUEPzzLaiW52vaQOJ2sbgdiEqnGucrTK+7h54GyxIhVDRiESP5BPcRMbOIKK2EhYBdmSbC1eOuRXTrxDZRBIeReBOvlHO+NMXaPZvP2RdSCvoMPcZ1eQ5DzqzTvV0N4lm/3Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NbCTrYsy; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88888c41a13so74583476d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 08:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770137980; x=1770742780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=loi6AzuvySSY0D+o5CKs37GcyMaudKjwmzY8HCc3yiY=;
        b=NbCTrYsyyK7ADu1d/MjIlKoHOh3nPQO+yWptsIjyAvYPatSyTtAa9kIlVDVSe4+itC
         Rnqpfg+AdgdHiKC6jah/M/1njkPK2rRl4wkEM/ERk3/l3r7EwxJbrGE8KCYDZno/hTnm
         //XwgENB41lCB4976U35c0YNyU0AobmG2BnxqX8H35e5/6z1oaijkHDG6s9r3+DmRVJq
         xSk2tego6I485oQOSwwdD3SCcUQq28REqSqS778bLxlWcGofMqRJs3EaWt5/2ihEMswH
         5WjxVmGFy4OdPvFpBZeaa+3QsdjcUx5us5fT5VqpnIUUbg6NtgE7qFW9xpsMbYBw7iMf
         GYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770137980; x=1770742780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loi6AzuvySSY0D+o5CKs37GcyMaudKjwmzY8HCc3yiY=;
        b=LA559VJhDpT7uhHi9oQqpTT8B14FfKmyeJxvvRCKGuzhZmD4sjp/t51jQQ2/hO1W8e
         o7jPAn0LgOuGbqzKq8QVb1OBlSC7+Oo8pAtrqH2fHC6boZ07MZzHz3u5NAJjrGfEhb9f
         4qO0hJV4R9wM3wutBPZ9HV5z0/p1PlnQKQfAw1jiZIWWHNNNYRybdYiv5LkJ2NrGc0AN
         v6cy8PXZxJ2/pIEOErftOLYE9/hTe0h2K7iNRfWq57K8JXnASbsLQ8Z9fjZsoj6olO6T
         ZA223dJnXxGIiBziKr1TEYR3S+1P6CjhHg4xTLsjTYZNhk0OwGUD1hcF/BNysowuIJ6v
         S5jQ==
X-Gm-Message-State: AOJu0YxMtTeAQPy1EKTAGdazniYFOG8h9h9UFnAXfgwXZXEjFt6iAglc
	hV8UliLwqSafVwaCoOZYwTxWDLGiGfAq30NgysSkHs5fHpg42Glb25XVn5UzOzbMIZE=
X-Gm-Gg: AZuq6aLP8b9kwnVYOdmCOwtOcZla6XrTe4cLtht0z3ZL0p4L9C6etU/wN7in5wwiptK
	s+ASth1gLZwr+l4srKNLZBgKJOxBlM5f6rEi/vadpL6sMi2wvZbkTIhTjHuP9icxozGCwsLBUzm
	WTuaWyA0f8wwkUfwMj9NOSFtmSiQV+yrGmnEhzu2IDN9coJHaGXiIIlFRGyR+YugnNJHtsm1ogI
	AqXJceuP2XkSh4Mpy0w5PasrQ7yABWlt4LF3K7A7g9Ze7UdmAoJ2mKRMncMNPxxYvsld0qdAZNF
	YDIbElsb3KfMX7LI2CclU8XR1rp3vRUGAxQRHJ3EY6vDzuBONkVQvxLjDK57mInFsoYmzv2dHPb
	qmgM2Tj2XnWU8ct0bOtaLIHRG+8Li2CqnIqj+yL9MxyXhnrhavs66NjuspLiv4usBqR78qRDQsG
	9Lr11ya1vLrhVfTET3u5lIONx3GVk5GtEJyRdDMoXE+zcMeO9UUmM74X07MBvDSoQS818=
X-Received: by 2002:a05:6214:1249:b0:894:7eda:2003 with SMTP id 6a1803df08f44-895221087cfmr1342006d6.2.1770137980064;
        Tue, 03 Feb 2026 08:59:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2cdfbsm7903185a.34.2026.02.03.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:59:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vnJkY-0000000GZnN-3rwr;
	Tue, 03 Feb 2026 12:59:38 -0400
Date: Tue, 3 Feb 2026 12:59:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, wangliang74@huawei.com,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com,
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com,
	edwards@nvidia.com, sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <20260203165938.GS2328995@ziepe.ca>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203145138.GQ2328995@ziepe.ca>
 <424kifntiluu2rrsqea6k3aatduoqemjccmsun5z6rvx67xo43@6q4t3r44ql3e>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424kifntiluu2rrsqea6k3aatduoqemjccmsun5z6rvx67xo43@6q4t3r44ql3e>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16474-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,ziepe.ca:dkim,ziepe.ca:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 0F30ADC7FC
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 04:39:52PM +0100, Jiri Pirko wrote:
> Tue, Feb 03, 2026 at 03:51:38PM +0100, jgg@ziepe.ca wrote:
> >On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Introduce reference counting for ib_umem objects to simplify memory
> >> lifecycle management when umem buffers are shared between the core
> >> layer and device drivers.
> >
> >I admit I have reservations about this too.. The flow should not be so
> >convoluted that a refcount is necessary. The lifecycle of a umem is
> >not uncertain at all.
> >
> >I imagine'd it would be like:
> >
> >core code:
> >  if (ops->create_cq_umem) {
> >     umem = umem_get
> >     rc = ops->create_cq_umem(umem)
> >     if (rc)
> >      umem_free(umem)
> >  } else {
> >     rc = ops->create_cq()
> >  }
> >
> >Driver:
> >  create_cq():
> >    copy_from_user(drvdata)
> >    umem = umem_get()
> >    rc = driver_create_cq_umem(umem, &drvdata))
> >    if (rc)
> >      umem_free(umem)
> >
> >   create_cq_umem()
> >     copy_from_user(drvdata)
> >     return driver_create_cq_umem(umem, &drvdata)
> >
> >   destroy_cq()
> >     destry_hw
> >     umem_free()
> 
> 
> This is how it is now. However there are couple of challenges about this
> flow:
> 1) umem usage. For example, create_qp_umem at the end of the set gets 4
>    umem pointers. sq,rq,sq_dbr,rq_dbr. Some driver may use only one of
>    those, 2 of those, 3 of those. Depends. mlx5 actually uses 2 or 3.
>    If what you suggest, the current approach stands, the user has to
>    always take all pointers, store them and eventually release them on
>    destroy_qp path.

Userspace passing umems that are not used by the driver is an error.
Fail the call.

> 2) error path. I found the error path quite odd. Then create_cq/qp_umem
>    returns !=0, core releases all umems. However, standard cq/qp
>    destroy path takes care of releasing umems. Since a lot of code on
>    error path and destroy path is shared, it has to be informed to
>    release or not release the umems. That is not nice.

Generally I would not assign to the driver's umem storage until the
creation is completed to avoid this. ie it stays null until committed.

But looking at mlx5 that looks like quite a maze there.. Yikes..

So maybe mlx5 adds some NULL assignments on its error paths and less
convoluted drivers can use a simpler option?

My issue with refcounts is that this isn't a refcounted structure, it
has very well defined points where it must become freed.

Like we can't get through detroy_qp without the umem being freed, that
is illegal.

Jason

