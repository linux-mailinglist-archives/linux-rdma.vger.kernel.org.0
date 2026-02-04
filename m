Return-Path: <linux-rdma+bounces-16527-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLoeGDBbg2mJlQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16527-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 15:44:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7113E7458
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 15:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D127C30136B5
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3299410D30;
	Wed,  4 Feb 2026 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M/PX4HwC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A6280A3B
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216196; cv=none; b=M21PCzWh3IBqeyPKx2xdcbfshFFg8IQ8b/FKM37CSNYbUwQz+xL4FNqGOOkV0DzbMwwdUvrQWkU45qZ6wzwSb8ZN7enipueh1UNohT/MkjquhFW/HbdQZTd/rvUN/lvf2XusDB5gyZfWR3GWUv4lwBbqW5zGFrm8KbQ0YoQfxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216196; c=relaxed/simple;
	bh=ydGAetvc65GGmio6x7luIunRpIuzbb/mHy7DYWLMXAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk+slz/p4C4IaTEt1tzVVXdUez5TQSqzvvgUPdHFFV+sVoso8Z1rosYrl3/NK6NsmMjVvDazAqtZcV/FtDxnnZAtr8g17xDZuGTAgOpD8hbOEqgYi2PhMHp0fvAIFayL1epTblKihXEsHPIqAwY/iH+S8AjmaWY4PSQnisZL7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M/PX4HwC; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c6a822068eso952389485a.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770216195; x=1770820995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ydGAetvc65GGmio6x7luIunRpIuzbb/mHy7DYWLMXAE=;
        b=M/PX4HwCq4OaIxCRHuo5C6rxDiaKOKX0FqcsezloAkHv+e5EzEAD4P85GO5A919bVn
         5bDBMBdqraPvx/AWLP351gZtDK2sa4Pxk4+N1h2ASiSIjAAW4DtmMpb8MlsS6RHPIH7r
         CX1vi6PRUrMq5+ltQ3x8CGf5VSZd4S0i8C/2prL3MvJIARSgVLjTyFzrwHPuMHMz05kS
         Qejy9NlZKt2CldnNGI0aEIW4cc4SPuaI0xqOESeDlZ9+cMlL5xnUyXunl33mijZtZ4wD
         oGshkiXTFQ8Jp4/nbUxfjVkyjrbqK7l1sTrqpYhx6qet/4b1y06GSwvlZcwe9zjg3Hgw
         ZAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770216195; x=1770820995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydGAetvc65GGmio6x7luIunRpIuzbb/mHy7DYWLMXAE=;
        b=YiffrJVBjLuHDKEzW8YNd5rAdyWUOI4+q9LukPxANyOA8LK3kLVKxnKv7eT4ROg/GK
         ehqw53rdmWNnHvmTcnL173Ho+cEWiTEHZYGkHBR7w18JHGgmu7JJJKqKi2lOGqyEr/1z
         XuqKzdweevnyBQNSriZdYFtb9z+yWY+OB8DRBreJBnxW6JXQcQ4hSqcmRcZTQy3eefz/
         0xJDDH1CeacBXvZk1loDUqQyiNOp5VQuxV9hWVEe7wGAcz5TUJl/0+7Cb0iIRhIMx34d
         QxYgZL4oifWo2DHnqD9efbXxsZg9JdLVfzuJzkyxncLfVvJwckiVh/vR5Akmjhr8qd5d
         gjmw==
X-Forwarded-Encrypted: i=1; AJvYcCVQE7iIl3Se5dUipTK2B69Ud/HsjRgWNevtpkxnCXbamEVEgjlfpT+9p+f0odzTyngft3IQYBWq0qNG@vger.kernel.org
X-Gm-Message-State: AOJu0YyQr6zlp3FPRbNn2UGRONB13j1QZq8zjzGYgQolA5EJrKBx1VRT
	YtFigrRz8H1fS72LF4m4e4CYdUSNg7SSXjwg5Z1GQBiobE2OP3MTXlhKt5mG4RicrmU=
X-Gm-Gg: AZuq6aL+guoW3bbvAfW8oLgn8t6OnT9cuSxoWMXkjKt/nDRfyW6Kpcu9SFqpC1uf1AB
	1w4gK5CmBWAq3v8FocTotLRhfGLp3LcHkW9BLR8uGFjRT+aAsSJe1NJq1mBBVh+xjRVR2tqmzVx
	mEvwMLXjxZnpBdBMo9JBbpPvPgeCa19P0p0AO2g4T8dMN73jFOQi1tOoLI39vlijm3n/N0lR4pq
	nXkyPYzOsIp0KvcWUjxyI9z2az85vdyObeTJSCCqwuYnCVwJRpneRz7kIPRHLlFOjXs173LU7EK
	VJNbuwiY95sZCIEdF8F2zSOo+PFgB0ccxJ+RtIc1xiAQ9/oINyyFkE8zXKf5xdVgzWwSASPjKrg
	k1lFNWRbL3WjrvF7im0KU5hmBaIiAAU+ah5KbsSEPBrX0MJ3l/IHxRsLIFj2ZrqD7wa6oOdytbD
	56JdgMoJmV00z1snKbkDKkwZweMMzP3tw0R62rFezswcA83dBRm1Zj7dVTPsHrkfA8emG6D6/SS
	oUKeA==
X-Received: by 2002:a05:620a:2989:b0:8c7:acd:eec9 with SMTP id af79cd13be357-8ca2f83bd86mr381255085a.28.1770216194868;
        Wed, 04 Feb 2026 06:43:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd4135csm197856085a.42.2026.02.04.06.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:43:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vne65-0000000H2DZ-2xBS;
	Wed, 04 Feb 2026 10:43:13 -0400
Date: Wed, 4 Feb 2026 10:43:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v10 5/6] RDMA/bnxt_re: Direct Verbs: Support CQ
 verbs
Message-ID: <20260204144313.GG2328995@ziepe.ca>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-6-sriharsha.basavapatna@broadcom.com>
 <20260204011019.GZ2328995@ziepe.ca>
 <CAHHeUGXky2H8NSWy8ZwCcqKDQEBn=CkMAzsLDT5gBFnZrn0WYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGXky2H8NSWy8ZwCcqKDQEBn=CkMAzsLDT5gBFnZrn0WYg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16527-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: A7113E7458
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 07:25:48PM +0530, Sriharsha Basavapatna wrote:
> > Here, I made you a branch that takes care of it all:
> >
> > https://github.com/jgunthorpe/linux/commits/for-sriharsha/
> >
> > And makes the required whole flow a lot clearer since it has evolved
> > into something that is far too open coded..
> >
> > Let me know what you think.

> Thanks for sharing these changes, it looks great. I certainly missed
> the point that you were suggesting a kernel helper function for
> structure validation and one that also includes comp_mask validation.
> For bnxt_re, it also eliminates the need to have a separate compat
> flag in ucontext for each type of ureq.

Yeah, after looking at it the state was much worse than I
expected.

> I applied the draft version of QP-umem support patch (not the series),
> followed by bnxt_re DV patch set, updated bnxt_re to use the new
> helper for CQ/QP - ib_copy_validate_udata_in_cm(). Tested it and it
> works fine.

Ok, well let me work on posting this series and you can revise this
one to drop this UCTX hunk and use the new helpers for the new
structures. I wanted to look at the other uapi parts of this one
today too..

> One question (maybe I'm missing something) is, copy_struct_from_user()
> seems to have similar logic to check for trailing bytes when user-size
> > kernel-size. Is it also needed in _ib_copy_validate_udata_in()?

Yes, that is a mistake to have left it behind, thanks

Jason


