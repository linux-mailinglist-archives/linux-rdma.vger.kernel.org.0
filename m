Return-Path: <linux-rdma+bounces-19478-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MDMHT756GnLSQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19478-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 18:37:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D217C448C22
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F9ED303FF24
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCF37CD28;
	Wed, 22 Apr 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RFX8aw2r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAAA3563FA
	for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875455; cv=none; b=Mxm+q6Amj4f53VBMMT1c/g4xgaL/Kwj0pusLBsVVzFQdlC0/2p2u5Yp2S1FbxBuninKvDIvI0hzgLZ+6UZsXJFYXpGAC6e2JvJtxUT1Kh6DWOO9mi4VuKETqW5FEIboBkK8v3MFBf6cbZX7kd4NhjhUtnoxO668QtzS6dflo1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875455; c=relaxed/simple;
	bh=rVFsnwP492bBS8p0JK5ZeJlqJLX14PA+ej73TB95W4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCckYAEV+dGejXWlN7CHvSf3iFHyzDF63CtZCmQZI8wyMN4F24bBPJxDkddB3e61ZFMrht3sYrDfr1WlQ1iSAnPBHJKA+H0zIrrYjhf0G6kIefNjxuR/ToB0r1svE4UdUnjF/u1tAhbx7tqO6u0cX9sazOI8QbL9oxpNdRzSbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RFX8aw2r; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a151012558so61343436d6.3
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776875454; x=1777480254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4FpyMzU8xGdCOepUYDlREWJ3yijVrQ+zK+jgdb7uUc=;
        b=RFX8aw2r3GqdVAWq3D3pGIFJrtWS/itrtT6G61qNc8k1HxF1DhrjqN/dcSPkOYx6JR
         MBx6RPIeaV5BK1/+eU66XSLbprr1eYPbOpkpR8/KNKK6YpUoGLnXQ55o1WUnWLeNIVnc
         t7f1phGPA7c5GWu6OF0vb9O0hpnwzjZ8s4aVSllpOJa/BklXyWB5hnETFAdztIOR66Rb
         hxuoa1Xc9c9cqvwmhTx7MVGVpNVfQKBW5pvs8ZCa7a2OmKyLdUFXR6PD0zAOcNpffghd
         1MYMN/96Q7KvHAXdmopdaQeG53yYNpYfBSnpSqUG5e5AzP8tV51wgp1qplPbieikS72f
         B0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875454; x=1777480254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4FpyMzU8xGdCOepUYDlREWJ3yijVrQ+zK+jgdb7uUc=;
        b=YYnAfu6BFijvPQVv8Ap4AsAE1Qcc6PGTv+k6lxNIiens9iBd/wRq+jSmUpoX35jT5h
         NDpxJ1ThVfRtptTDGhpivqyC00PUwCE4Ax6b4jjQJ77bTXoZQOqSwhCVXMTdawhmFoWw
         Ic04U7KeM0Ipm9doVuYFZHT65dzeQMTQ7sihmWzd2BoQT9huIQJV+LPbfYLNJsZUroiD
         tSRK5X6zPb43+mtep2Ej10gGQg7vo79EmRRDiWnU6kDjxZ7y4A3d3aDRqGrP8/srfA0z
         nBm1udRI8eJvIya9chciCb1qPfBGupp41QRWvJzpanjsFpzJLehf2g48ckYGKPY7GoRj
         VNhg==
X-Forwarded-Encrypted: i=1; AFNElJ+IS6b/MjaBD605ZHyHPMIL9sF/AVhtkEZnk4dgemyL8zo+Ov1hl/1q/iN7qrFGmou3JInkeCjgySqV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxma9oT0wb+HftcgcQHzhH3X6Iykmmt02PPeGIcaf+hMNMArtyj
	WiUt79sc/IyMb1RJ+2TpGlJvQJAffGAltT8fv7ftRtIwa9pIRFze3R7R9HfxPiZ2ayw=
X-Gm-Gg: AeBDiet2IzUXIVF5L4UdAOm0a1vhXeAFeMwg9Z/xsZHbvq9+U1e59bIqg5RyJXRghmf
	CeyEq3eVfrpZr8Kvd9VP1PpWykBPacU407kOaxLXHZOcznHGjAHJ8bm6aO2M3wIfXo5cn/i8lhZ
	QJJUbodrnhPhPVyYQrpTwjYX3OX14qbnqIzYovixhPEbTz7t74dOgMif6ZBm1HzR5JfCS/Xh0Dv
	vAecL86isSI+kfbuYatZkBugKRUHRsVwnxyXPF3V2hfvo7FL+BNrTkgKi8dS9+TfEEqOjWgtkKq
	X4qDUZl21wA251i5rg+Ojgw6ixQugPkxD+o3j8a0i3isgGUQWGvChwCcy/tYk39GN8PGO07ryDs
	TXG5OfuQmt+2uC3W2PYf8tbBeG4fg5LeDKF7w/MLNrjIPTGOxvPDQ03FQnRaVwgTKKODqNxIJxc
	nXJILEiDcJPLAuDTaoVb5JelC52SFH2K+b6vgmyqqghsBO9+YmfV/fiJcy65Vj1nQONPMCaOLhq
	HfbrxSXMM0n8uYn
X-Received: by 2002:a05:6214:588e:b0:8ac:a48a:a586 with SMTP id 6a1803df08f44-8b02803f167mr366817976d6.14.1776875453545;
        Wed, 22 Apr 2026 09:30:53 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac6f670sm162283176d6.14.2026.04.22.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:30:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFaTT-00000008cZg-1r7i;
	Wed, 22 Apr 2026 13:30:51 -0300
Date: Wed, 22 Apr 2026 13:30:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Michael Margolin <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	leon@kernel.org, gal.pressman@linux.dev, sleybo@amazon.com,
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com,
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com,
	edwards@nvidia.com, sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260422163051.GM3611611@ziepe.ca>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260412123322.GA5166@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <fzughzkkr5zkr436pdzu6p2j4sdlphtxpbbpztxoerbms6a37f@4dzcxphdyjg2>
 <20260413160232.GA21984@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <dy6nbf2vibl3aeopeb7im7fksh5436isqcmcarghkm5e2ontoi@unvvimhthp53>
 <20260416121000.GA20519@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260421125212.GF3611611@ziepe.ca>
 <3wltr6vsnqqmgopafwjnhfndbbfmsnsxalhvrxjat2qeq72kau@poidixh2jwwm>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3wltr6vsnqqmgopafwjnhfndbbfmsnsxalhvrxjat2qeq72kau@poidixh2jwwm>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19478-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,ziepe.ca:dkim,ziepe.ca:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D217C448C22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 12:32:26PM +0200, Jiri Pirko wrote:
> Tue, Apr 21, 2026 at 02:52:12PM +0200, jgg@ziepe.ca wrote:
> >On Thu, Apr 16, 2026 at 12:10:00PM +0000, Michael Margolin wrote:
> >> > >> >> @@ -64,6 +64,7 @@ enum {
> >> > >> >>  	UVERBS_ATTR_UHW_IN = UVERBS_ID_DRIVER_NS,
> >> > >> >>  	UVERBS_ATTR_UHW_OUT,
> >> > >> >>  	UVERBS_ID_DRIVER_NS_WITH_UHW,
> >> > >> >> +	UVERBS_ATTR_BUFFERS,
> >> 
> >> I don't think you can add anything here as it overlaps with driver
> >> specific attributes. I suggest defining per command attr id and passing
> >> it by caller into ib_umem_list_create.
> >
> >Right, the expectation would be to have a ATTRS_QP_BUFFERS
> 
> Okay. I was under impression I can add a generic attr, I was wrong :/

There may be a way to do that, but the [UVERBS_ID_DRIVER_NS:MAX]
number space is fully delegated to drivers and all the low values are
already taken.

Jason

