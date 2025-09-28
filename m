Return-Path: <linux-rdma+bounces-13698-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00091BA706F
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 14:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD447A7FC7
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7B2DCF58;
	Sun, 28 Sep 2025 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="VVmEs1dM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D392A625;
	Sun, 28 Sep 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759062295; cv=none; b=I9jeJntFSZmlYEEnqyojd0eJsjX4a9NU8IeJn7a03GbNQoyMS12J0rMrZLtqKoS7uQ6NI05dup9wKosJSp29r4dc+NBcK6/mXIS1azCdZhqEvtTyXOqEYa2GVp5SsTv4KVGIvLqSY+htWBThrnN7SzPd0KVQpZmIKAcOSigphIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759062295; c=relaxed/simple;
	bh=sFecT7O3MDYqPD+Z32FePbeObYG9Y83zsOm0NJBIYfQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GB0V0X5DsssJzsIrC7b8bzAZkRQrwnadUG7IZdskx6ieZZGkj0itBCUjin1A6klRcjraF449GRwtMvVS8ECasBPp2AjiOZNd7EaaUAbhIDcrDP4/eXPSYaTKiB969FmsRk5gMpESmMFjNuL4PbgwqZkt3cMDDDTGSMmG/IqJvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=VVmEs1dM; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LQ0oVUoCfOIt+x7Lrmwu8ybl4g7WomzcWHQHXOArN0Q=;
  b=VVmEs1dMHxRYWP6310N3UmeXvTSs2wunfyGQ9e1HWH9ySKoxPVRoQIzc
   qh+IeW7Y8K1OXbjjA/paMTM/x0nsGa6wfqygPZwAkdVsIXC13BAT+WSMc
   jgnsJ/0GdcF3ZFml4uoaD7FDj+nvKD2OFTIAjOknxbeeUb2LDIThfWMcI
   w=;
X-CSE-ConnectionGUID: H3kCSCiFRsiWEEcHmsvPHQ==
X-CSE-MsgGUID: 3KepsOaeTPq4en8K/f/1cQ==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="126750158"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 14:23:40 +0200
Date: Sun, 28 Sep 2025 14:23:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Gal Pressman <gal@nvidia.com>
cc: Markus Elfring <Markus.Elfring@web.de>, Tariq Toukan <tariqt@nvidia.com>, 
    cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
    linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, 
    Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>, 
    Richard Cochran <richardcochran@gmail.com>, 
    Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
In-Reply-To: <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
Message-ID: <7522bdc8-1379-d516-d1fd-f7835453f23@inria.fr>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com> <1758192227-701925-2-git-send-email-tariqt@nvidia.com> <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de> <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-117506010-1759062220=:4035"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-117506010-1759062220=:4035
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

> >> +@r@
> >> +expression ptr;
> >> +constant fmt;
> >> +position p;
> >> +identifier print_func;
> >> +@@
> >> +* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
> >
> > How do you think about to use the metavariable type “format list”?
>
> I did find "format list" in the documentation, but spatch fails when I
> try to use it.

I would suggest constant char[] fmt.

format is for the case where you want to specify something about the %d
%s, etc in the string.

> > Would it matter to restrict expressions to pointer expressions?
>
> I tried changing 'expression ptr;' -> 'expression *ptr;', but then it
> didn't find anything. Am I doing it wrong?

expression *ptr should be a valid metavariable declaration.  But
Coccinelle needs to have enough information to know that something is a
pointer.  If you have code like a->b and you don't have the definition of
the structure type of a, then it won't know the type of a->b.  More
information about types is available if you use options like
--recursive-includes, but then treatment of every C file will entail
parsing lots of header files, which could make things very slow.  So you
have to consider whether the information that the thing is a pointer is
really necessary to what you are trying to do.

> >> +@script:python depends on r && org@
> >
> > I guess that such an SmPL dependency specification can be simplified a bit.
>
> You mean drop the depends on r?
>
> >
> >
> >> +p << r.p;

Since you have r.p, the rule will only be applied if r has succeeded and
furthermore if p has a value.  So depends on r is not necessary.

julia

> >> +@@
> >> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
> >
> > I suggest to reconsider the implementation detail once more
> > if the SmPL asterisk functionality fits really to the operation modes “org” and “report”.
> >
> > The operation mode “context” can usually work also without an extra position variable,
> > can't it?
>
> Can you please explain?
>
--8323329-117506010-1759062220=:4035--

