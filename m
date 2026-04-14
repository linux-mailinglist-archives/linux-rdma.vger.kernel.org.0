Return-Path: <linux-rdma+bounces-19336-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLfxEug03mlWpAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19336-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 14:36:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DEB3FA06D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47500302880F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE653E0C49;
	Tue, 14 Apr 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b4/PYCHy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F840DFAF
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170078; cv=none; b=W3MsPDeY2uNDZCJDXNbLfzpnobvVGBKkEvrzKMrTFpEEUe8AND4SnSRaC6p+8TFT7S8qnayABLNJuaJOHpbGiAjvncWoJK2UqOsDmJf1Gb9RHLbqSSsUlWEYHChgHxSU9f7u++wR5mE89nOm3UPXpVxDZGVn3hg9RsDL0ZOekTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170078; c=relaxed/simple;
	bh=00INFD2KaahQryHFcJqAX1zy3o/2tFB3OoOSh81p3b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDhmavHpZMIUbfLLv9bG9sJCxiWd1XrmxSQG22kk/6cRjxhJYUbJHTN5kjcvjn2cP0wN3dbOQFl+ySc9jpnwDLOdhGQ3KKBS5e/wbX1TtXzYEroFYMLRqJ8OY88BlJGIdOqlOZmY3zAK4eeF7yHvGC2ZM9V290gTHwc7E9QIHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b4/PYCHy; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb20bcff5aso511448785a.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776170076; x=1776774876; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vs2cErzGbPOSqSOECJHt6u4fxYSy6069r6cg3yzhlcY=;
        b=b4/PYCHyg9DZpXfYm+/DMhfM8r1Ezz7FXrxNN9XxkUnDUFE8h+Xs+Ai3GRqiX4giZF
         7hQWNiTfdgnYR4aLwUzdTUFI/4+/7Put1ULuo1LC2eHsNSIGI+TLsw1um5GmoFNI6wou
         JXVuDHEqhvjZg/9U+UHTygPglsvBb5Zx6EmlvvEVGmOaGdPDdvRgp43TpDu6i/HDHj83
         94lioCrs4Af0CvdmY/lrOoj3iksVrVEWLkoLvKuXN3u7VyR7yNZ8NQyN3GaVBenJnT9X
         XGcFuFWbk1dkdFECeNfdp2ZYpkjOQg0ltsh7e8hYOxEZ237iBCYlpAoyjcjaGA1yrRA6
         NSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170076; x=1776774876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vs2cErzGbPOSqSOECJHt6u4fxYSy6069r6cg3yzhlcY=;
        b=ii/iZyCjZfMjVZ2b0W9967VyLiphioadD+SItO9FBWcIRmGD6AtWFrfzg49+Mx/QKB
         gj3ppOX37NIZzWg5sOHEsAPaL+N2yUpBYaxe1KwuVG1LA2fiTkW/sqMc/mP+a2ufg7D6
         CkQACpeN/PffrK+JNHJtIPwd5EygI8qw6GKIkXp53Qc/M4i3Me8RUdpOvpB20oXJ5knI
         kqo34d290nZCsoXr276D3xneXVZJIggguIBej+ulCoiqK7TZJuYNSDNxdp2K2MoDOzjB
         KY6FI4SNJtjVkWaXk+JZiEDLJ9V8r7DbCOKPyTRRlZqIcr1CVXDaxcd9HRAz9R7mS46J
         q37A==
X-Forwarded-Encrypted: i=1; AFNElJ/ZSdOGHtmFIsx5U6kbGrnnhkFRjWpqKP162K3+zdc70K0eEzetSxsUwpS6ljIiJieNLabu1TM85HOD@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmXCFSfdOyp1WwY/HTMifARnSYxDUYkijPw2lfY4Lr9caqZFA
	gZyG8ep8wYNFWea2CkHLFgrUTYsgUKSm79T0YhHICjZiit667QoVoUvueo4aRiZ82dzzjjnhjAH
	fmZ58
X-Gm-Gg: AeBDies1LZdJ9YsOWc4Jjs3X9teG0/WJWkMMM1DvLuMancEKwI8FJPl+7lAo0BegaH7
	kQHJe5MGpXkCxbGR2yYpHotRKs3KPEpkKLCyctfAoIs5aZv+hBoOFVNHY/wPWw1oDg/GfXYl9fD
	nz2q0tiQmcn6Lvrvh3lKBqDqBBt84VTumgCrPe8J7nqhz3hsw+sjDVJZruaZhDoMEzqCqUELn9l
	9+Bz4azo67lGGLtJLUaNs1AITGCBK4pwi+sYUg6/PFiX6a4t2E5GilP/7klWNBFl4CpC6lXWQ6W
	owcMrEXEOXVROCqRkGd84L++5hEieSobQzWe7ur7mBnirjG8iA9qCeRyYiKrvDbU6LQipw1flGP
	tprBQ8ALVxhHqC3cDMCf/+/cCMG6pKT7m4d7LTKBCUK6Rfs3GZI8aYpqIW85W5FuVJwww3pL8Tt
	zj6uMfwinv0M0Wp3+oLB9IAhPcH/n2nEkd2F76ObWMFP6i4QbMvgIJBhHu0MGAqzetL4azVyi/+
	7XwtQ==
X-Received: by 2002:a05:622a:5a86:b0:50d:7aa1:f405 with SMTP id d75a77b69052e-50dd5a91b14mr255369811cf.9.1776170075776;
        Tue, 14 Apr 2026 05:34:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539b49dsm113087691cf.6.2026.04.14.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:34:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCcyQ-0000000AgqT-23gN;
	Tue, 14 Apr 2026 09:34:34 -0300
Date: Tue, 14 Apr 2026 09:34:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v2 8/8] RDMA/bnxt_re: Enable app allocated QPs
Message-ID: <20260414123434.GX3694781@ziepe.ca>
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
 <20260327091755.47754-9-sriharsha.basavapatna@broadcom.com>
 <20260410152752.GY2551565@ziepe.ca>
 <CAHHeUGUwCBjho3oJLJdOeTSF3cp1U_DYsN_satsCo4_aEKLWOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGUwCBjho3oJLJdOeTSF3cp1U_DYsN_satsCo4_aEKLWOQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19336-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:email,ziepe.ca:mid]
X-Rspamd-Queue-Id: 92DEB3FA06D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:43:51AM +0530, Sriharsha Basavapatna wrote:
> On Fri, Apr 10, 2026 at 8:57 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Mar 27, 2026 at 02:47:55PM +0530, Sriharsha Basavapatna wrote:
> > > The driver supports a new comp_mask: APP_ALLOCATED_QP_ENABLE.
> > > The application sets this comp_mask bit in the CREATE_QP ureq
> > > to indicate direct control of the QP. The driver goes through
> > > the required processing for app allocated QPs. Only variable
> > > WQE mode is supported for these QPs.
> >
> > I thought we talked about this, no weird names like this.
> Are you talking about the comp_mask name or the wqe_mode (VARIABLE)
> name? We used the comp_mask name (APP_ALLOCATED_QP) because the
> application allocates (and owns/manages) this QP memory instead of the
> library.
> If it is the comp_mask, how about one of these alternatives?
> - USER_MEMORY_QP
> - USER_MANAGED_QP
> - USER_CONFIGURABLE_QP
> - EXTERNAL_MEMORY_QP
> - DIRECT_ACCESS_QP
> 
> For the WQE variable mode, please see my response below.

Still no, make the flags reflect micro functionality relative to the
kernel operation. None of the above in any way explain what the flag
is doing to the ioctl.

The only thing the flag does is this:

> > > @@ -1734,6 +1734,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
> > >               return qptype;
> > >       qplqp->type = (u8)qptype;
> > >       qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
> > > +     if (app_qp && qplqp->wqe_mode != BNXT_QPLIB_WQE_MODE_VARIABLE)
> > > +             return -EOPNOTSUPP;
> >
> > Give a sensible name for whatever this is and use it only for
> > this.

So what is this even? FORCE_WQE_MODE_TO_VARIABLE?

> > I kind of thinking you can just fully drop it? What is the point in
> > checking userspace set VARIABLE? It isn't signalling HW and it isn't
> > protecting anything.
> VARIABLE wqe_mode is not something that we introduced in this series.
> It already exists and is understood by the FW/HW. In
> bnxt_qplib_create_qp(), hardware is signaled through flags.

Yes, and it's fine, you added app_qp and the only thing it does is
check that userspace set VARIABLE. Why?

Jason

