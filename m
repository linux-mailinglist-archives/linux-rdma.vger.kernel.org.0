Return-Path: <linux-rdma+bounces-16471-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CUoBG4pgmnFPwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16471-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:59:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0EDC684
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 17:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3037300BC86
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2803D1CB2;
	Tue,  3 Feb 2026 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB5P2h4A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29F831AF24
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137765; cv=none; b=N24eCrcju3jxgXao+nU7mrEL/blI4ilNC/bmtuHnvI+7TFTDhw4TzUdtYHU+teZLJXoueabvXIhJwJDpZMwGtKuXLWJdmTUkGc8ZdU7ZVx2AQ5xfWBQ4zlw1U9tP3/ncKVOKUWpZuGiGSuyGB1V9JeCk4xNGZsZMXcdIg52FLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137765; c=relaxed/simple;
	bh=hTjK2zO9Do4IGLnhyBsPVsuMasUFdDsQCz/cXoHHo5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVeLw4WuaMlN/+6j1qL8Rk5C0KhZNQSYfQNWSxr0i4JO8hkhSK0M3wmrcmGhQJO4ykGz4HhPLFyZXyrd1jG8Sz2M+BF/VeoL4Gdwu+ZnQgw94/SvW97cf3lp7QDSvKTEBcVe8YdYtEKPkX9mpFNrUwKWzlYNeo7f9foRE/K9fag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB5P2h4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54FAC16AAE;
	Tue,  3 Feb 2026 16:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770137765;
	bh=hTjK2zO9Do4IGLnhyBsPVsuMasUFdDsQCz/cXoHHo5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NB5P2h4AWNdTipKIz4AWfooOCQ0Pw0oItXX3YnAXllrvvdPVwE1jF9iJiDwBaudPH
	 LiTf3W2DJ0wfX5URKHyskTd5UnJiUtD7CN0iL6xAy6DkjUFB7QoQpm2HjP8zLtOR6E
	 lVp93mAcENBqzKYVeBiHkwLE60ruj2gAga2Pp9CpBGp+zOVfF+P9lTbP2GzGN9iwL2
	 X9/I0feKcM1gCgDjT+RdKrXscR0kn/3WKFhcozIbLf5WsScUFUvk/eiDlSEsCMAXuS
	 rAYzeEyUFQ9LzZk9JBOjzaUfU16cVt+dsEfe8FUxVF6e5WQvrrCl3yUYXqq5fP/oUM
	 4kvsYFN5bIaDg==
Date: Tue, 3 Feb 2026 18:56:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com,
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev,
	wangliang74@huawei.com, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <20260203165600.GW34749@unreal>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203145138.GQ2328995@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203145138.GQ2328995@ziepe.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16471-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0BA0EDC684
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:51:38AM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> > 
> > Introduce reference counting for ib_umem objects to simplify memory
> > lifecycle management when umem buffers are shared between the core
> > layer and device drivers.
> 
> I admit I have reservations about this too.. The flow should not be so
> convoluted that a refcount is necessary. The lifecycle of a umem is
> not uncertain at all.
> 
> I imagine'd it would be like:
> 
> core code:
>   if (ops->create_cq_umem) {
>      umem = umem_get
>      rc = ops->create_cq_umem(umem)
>      if (rc)
>       umem_free(umem)
>   } else {
>      rc = ops->create_cq()
>   }
> 
> Driver:
>   create_cq():
>     copy_from_user(drvdata)
>     umem = umem_get()
>     rc = driver_create_cq_umem(umem, &drvdata))
>     if (rc)
>       umem_free(umem)
> 
>    create_cq_umem()
>      copy_from_user(drvdata)
>      return driver_create_cq_umem(umem, &drvdata)
> 
>    destroy_cq()
>      destry_hw
>      umem_free()
> 
> This basically moves all the working code in the driver to the
> driver_create_cq_umem() which *always* gets a umem as a parameter.
> 
> If the user uses the drvdata path to specify the umem then the driver
> helper create_cq() creates the umem from the drvdata parameters,
> otherwise the core creates it from the common UATTRs.
> 
> We can keep things so the umem is always freed by the driver on
> success, which doesn't require any driver changes.
> 
> It should never be "shared", this is just a very simple unwind on
> error kind of pattern.
> 
> I think the challenge here is to unwind the drivers into the above
> three functions so they don't have a mess of convoluted error handling
> around the umem.

I opted for an even simpler approach: embed the umem directly in ib_cq, set  
cq->umem in ib_core’s create_cq, and clean it up in ib_core’s destroy_cq.

The beginning of the series is available here:  
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=refactor-umem-v1

Thanks

> 
> Jason

