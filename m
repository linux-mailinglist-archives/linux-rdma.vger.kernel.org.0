Return-Path: <linux-rdma+bounces-20596-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM9jJEa6BGplNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20596-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:52:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCB153858F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDF71301B15A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9124DBD76;
	Wed, 13 May 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="APfmK5Kw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928BA2F0C79
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694688; cv=none; b=bD0gizS3KEvEb6KkEoy8dq98qsf76uQ/t/d5fos3coZpJedn2y5afI+jKoW9IuEcsktNS6m6evX/bUd4fGmU0ltG+N1ixgROTvEjkNZ7OiXCWx3Fz4tIDKGhIN1xwh5CPp1AJT5xyvf/Z1NuzaQYYmObK2e5vakYqF8Fs288uk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694688; c=relaxed/simple;
	bh=XBlVanYmPUSKCatDQ1fSJ8nulgVyx9789Hu24t66qkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CygsExaqzRX4+2aEscRuJZIORqrPUGjeAL/KrH/S8T5pxZo6vNiaSsdv1rJFJvd28+1IO8KcPtWH+kh+GVz06wD2OppaNXsOR+2j9QKU7HA/tm4n9b+PiOuJq170Ulv3dyKiXlsu76GFr33ubX9vPYuElvt1uXGsfX4KsE2MDf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=APfmK5Kw; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so76892826d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778694685; x=1779299485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z82faOZNqKH6GkEdC8nc9lpXFRjbXPgxF0rvDv5mP/Q=;
        b=APfmK5KwXaL48UymdZDAWEnY5kGBFojvWdtbzRUMtVVC593sv+jKJVpNH/rtgbtbMO
         Zc/h4er/osguP5h5YdElnKIUichONrzLriEsLTZ/yoo8f0eN6gp7+08FmKXKPa8oXTYk
         FcADyv2J2aFbSzP5XWCxhHgv6jKTwXIZiPXJkvjoMutAd7ae+dFBDzotcyPkpaClFixt
         mtLBb3+0tpA7XHDqBqfTO7rUa9dBLh3XFdICOgKyTEZ7Gr5uUC/IUn0oYIdjSxIo/he5
         9a7I7A0NjtlafxGq1WqFkz8WqYTbLmv3LhbUdjqN2m+owXHiRDmH3yCG6aBiAOPrnyD8
         7kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694685; x=1779299485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z82faOZNqKH6GkEdC8nc9lpXFRjbXPgxF0rvDv5mP/Q=;
        b=neBXX0BUftMXryUA8rWSygh4tsWgqCuBBoyMZ4w0GHREb26Kkmqq4RAXiSuHZ6OpbP
         rqBYyJCtRlRhDqdDrS7Z+bI5uIkqNmbs6lntN4xsH6rxcfbimpBLX0M5h006xJoJM9AG
         n5cdQK+XlgyA/Pbd2uKENObJ+6lL9+UdQyKBlFTSFfEmcIlWA9/zSYBerI5JmN3lcj58
         yxTR1gb1pqguXHiq5+Wv9UV/dyhUAcRgvvsDjJEdEA7j8ujuV7ye+tulB10N2TGagtUk
         AG6Dyat+NFDMN1D34p/UgVl+E/WQK7PZOB77Lq77Pjbysqo3BaRcn6KCJdfwwBVon5ps
         hMJQ==
X-Gm-Message-State: AOJu0YysmK4pNqCk0KvdkmieaR9P9J/fY8qLQWs01QM5+/dHCm1csSoj
	VuFgqWxsQUl8JAYDMkemFpYnSGoBBGpZ8tfMJcFOlPYlqkj9J3d7VbCQj5WleKDPReY=
X-Gm-Gg: Acq92OH0rCT416vGbwfWF9GYjSKFbB2KT2Hgh02coZaeJhtYhd1MX+URAKfihO9XRmd
	aNCBa+fy2prQ1aN3kLhUwcIlTu9Au9aIglGwlVgTqGwdoFXRagZkMTzQzFAgAx5O9M/IEw+Tua8
	Z1tr8Lgtj5RYfzhLVvsHMylKkDjOF4dmWTCno+ROXjcEXjaxsXySovA1ZrvrJYcbyizine5na+S
	Ny95dfC0fEGT8o6EWoG8060tSgDajTyu5gxNMIV2n0QOi8tAYJKRGfHeWrLy827q8IMSBJaILc9
	LY38vGyMgpqTdl6V8nSHBKKG1rMYzXLUvaCd0pmJ62eOI+Ky9Yi/S5HyImKiJPPdpDH8bJ7euKD
	UOccLGKm11R3HIiWPrp8ED/aEv5zkYgkV0MZxcxGqHiaswEfPCC1DBW2LXjWGC+P1gJUUx5CoqT
	Fm4yFtwlqZe6Pp33fKdP12kC3AVQl+Uppolk5LuBIMlPbkbpmTEBXazWF4G+d5jItRkD51hypbM
	qllCA==
X-Received: by 2002:a05:6214:202b:b0:8c6:5828:5551 with SMTP id 6a1803df08f44-8c7bc62b98fmr70297756d6.24.1778694685393;
        Wed, 13 May 2026 10:51:25 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1d2e7sm2123976d6.16.2026.05.13.10.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:51:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNDjw-00000003g1Z-1aRP;
	Wed, 13 May 2026 14:51:24 -0300
Date: Wed, 13 May 2026 14:51:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
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
Message-ID: <20260513175124.GT7702@ziepe.ca>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-12-jiri@resnulli.us>
 <20260512182927.GJ7702@ziepe.ca>
 <agRinwoVkaPujATb@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agRinwoVkaPujATb@FV6GYCPJ69>
X-Rspamd-Queue-Id: 0CCB153858F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20596-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:email,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 01:38:07PM +0200, Jiri Pirko wrote:
> Tue, May 12, 2026 at 08:29:27PM CEST, jgg@ziepe.ca wrote:
> >On Thu, May 07, 2026 at 02:52:26PM +0200, Jiri Pirko wrote:
> >> +	cq->umem = ib_umem_get_cq_buf(&dev->ib_dev, udata, entries * cqe_size,
> >> +				      IB_ACCESS_LOCAL_WRITE);
> >> +	if (IS_ERR(cq->umem)) {
> >> +		err = PTR_ERR(cq->umem);
> >>  		goto err_cq;
> >>  	}
> >> +	if (cq->umem) {
> >> +		if (dev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_SW_CQ_INIT) {
> >> +			err = -EOPNOTSUPP;
> >> +			goto err_umem;
> >
> >Huh. this is getting pretty hacky.. The driver wants to memset the
> >user buf to 0xcc for some reason, and it already has a nice flow that
> >if that fails it tells the FW it fails and presumably is Ok.
> >
> >The issue is it passes buf_addr around insead of having made an
> >ib_umem_memset() (which can reject dmabuf).
> >
> >Looks easy enough, change sg_zero_buffer() to sg_fill_buffer() to
> >accept the 0xcc, ib_umem_memset() trivially calls it, remove the
> >buf_addr from the call chain, directly use the umem in the
> >mlx4_init_user_cqes(), remove the if above, use the
> >ib_umem_get_cq_buf_or_va() in the driver..
> >
> >Leaving it like this just means the driver won't work with the new
> >uAPI with normal VA which is not desirable..
> 
> Agreed. I would like to fix this in a follow-up patchset which would
> look more or less like this (Claude generated):

That plan seems right to me, lets just get it sorted before anything
starts using the new uverbs flow.

Also please look on the Sashiko report, I saw some interesting things

Jason

