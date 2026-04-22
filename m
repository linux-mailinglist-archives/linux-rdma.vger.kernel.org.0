Return-Path: <linux-rdma+bounces-19479-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBzTCJz56GnLSQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19479-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 18:38:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 730EE448C6C
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 18:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA229305BDFD
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9829DB6E;
	Wed, 22 Apr 2026 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EXUSuHKy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27B37CD28
	for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875559; cv=none; b=p5u1f3ZO61bKBIgLQQ1vco2jVwmgv6RSNnFekuDiKgQ8N4QNCvPPLzpidD5shwaWnNfsw4S5Y2wv9NFnxvCy84T4t8wlV5kavCyh7IBk/JFJtraUZ+eu2p+wUk8YTwoNJgm5soGytdJ7HwM6AwfnIHuvP1z3IHWk0FLNUyGWPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875559; c=relaxed/simple;
	bh=sTeWVt4tNQW6cov/Ni6vpltv6OWDVVxugDEL0ZxnuVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+NpqnazhuYS0X+tGXOydh++Zo6PtA+bWndlRnP9SCfyZi75hi2LX5fncZhpHS004xHUa5RBhI+6tTrYcUWvc1w8nWcqiL87zUfJ6Gb9PVNTWIiV8xadDw5yiRpzUnFkyKXvSzm2lVqtQZaaMyRVMDfqxK25xt4MCqUAJI5GFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EXUSuHKy; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d65f4073bfso758244585a.3
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776875557; x=1777480357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mykS7qLlzh2qCqiePbD1KVJCHIizaniXX+eiihca37Y=;
        b=EXUSuHKyovm1x5drFfXgBBkMU8Qs8uZzjzYehdXinNlcojjgsbaVyRv7TMRnlbtq8E
         zWSXtQh8WJdixrh6XQbXPb4XXfCstwrwGbZEHiw8YWlQxsRf7fBRzDKaNDEivg0ywE5l
         lr+lF3HkZMA2GFWNHrovrij6BUygiBCNSB+qImMUvQQN+SM58MEJvwmcCfbR1keb7bLL
         AIUXMGtGdWsiXCJjl/+PQpZx9FNF8c0MRYAa9OSeMxJlBt5mXAKxMJR+EXgA0QQg82A0
         WECrUiOl9zL4PkN4tFwRZK8SKxYHMjnWhP89cYTs8De2tvz4rbfCsJyT7Fov9xjXcY7w
         6+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875557; x=1777480357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mykS7qLlzh2qCqiePbD1KVJCHIizaniXX+eiihca37Y=;
        b=ZhcI9dVXleg/KQwv7kDcEtKRx/NCppPDspUcz2kyHigcmP0rkBjvscctDDPzusXkQU
         P2WHMxMf9K5aqia9etPMATSLgD2T+Ze21F9Zys+J9b7FdgUl7MBJ386UZks6sz29maC/
         CznWn90T9x/Hbk4gqHaBOdXv4nwUEcqFnG8rzAXKKcZ5MOHNHDv/Z7Zc2tB2cmCKSJNE
         m6OyjJEtKOlJjlJSKYBCyZO5hTLgZNorpQXP+CxvBLhLMGvk/LeIVDmsN1Q6S6bxc5tq
         1w589BOpxyIK1ibb36uVVNEzhRewNeRo031DO1hNeJ6oLhz3AzH3T/gXw74INaXRWaw2
         23dA==
X-Gm-Message-State: AOJu0YwAXpvpyGNw10urkAYu881RovTaOLlE42prClRcPDih1isP0obT
	d1oqfZA2nsYJuTkughIl4qSzBqm2QOSfmHVJ1emzHhK/0o4kCpxDcWMoN+i/JMH/HnQ=
X-Gm-Gg: AeBDieuroOQrW98pvMvTG+Ge1/Kh6uqWE2FlrU1MScnoICeCWFrRiEig2Z8Z1a2vGcS
	IK9Sr8LEDd8/3hbYijZWL1Zih1qU63qWATMsRuEi41Alatx1aqWYprm/XwoZkkGUSd3wtn5U50e
	aoyNDtMzIiiDF5Klc0qOhx8UfURpgndMHFnxj332JGAEfnADCwbau6KBAyYw7k2FBqWoKwtDpmN
	mUeDUVQByEhBDFsRgxn2imPuHabOb0d4kkscBWgbCvWMv5xrEv5yGXb6pGQytLOCa8S4XFMa3LG
	8n/qgVjoWZIE9LExt4mch1alOFjHWiH76wNJpq0pTAmnKjGNl3/1u6eNKmI1N+syCKf4RJ97EJd
	KN7B6aupsASJ3R8O9H4Q6ohGcWxtNH1XgiIa0+az7VpHjsuipDQLh/+n6uSA1RkzxcDkh/+H7l+
	+3w/6bCaEWjj+Q9u/gsYciOXLOevgGeGUF9tWL18y/8rG2NINlzGwnM0ucfXTPbwme634HJJqGj
	PVbokmm//8h+hBG
X-Received: by 2002:a05:620a:45a2:b0:8ef:f1c0:ab7f with SMTP id af79cd13be357-8eff1c0b5c6mr425481685a.24.1776875556518;
        Wed, 22 Apr 2026 09:32:36 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ef47be2d91sm335228185a.12.2026.04.22.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:32:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFaV9-00000008d3U-1xBx;
	Wed, 22 Apr 2026 13:32:35 -0300
Date: Wed, 22 Apr 2026 13:32:35 -0300
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
Subject: Re: [PATCH rdma-next v2 02/15] RDMA/uverbs: Push out CQ buffer umem
 processing into a helper
Message-ID: <20260422163235.GN3611611@ziepe.ca>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-3-jiri@resnulli.us>
 <20260421132532.GA360923@ziepe.ca>
 <7hbhqdwc4vboiwi5d2yqpqgxhvouqmuxzar3dzvkxhll2eb23s@43ftpwsavstd>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7hbhqdwc4vboiwi5d2yqpqgxhvouqmuxzar3dzvkxhll2eb23s@43ftpwsavstd>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19479-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 730EE448C6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 12:56:52PM +0200, Jiri Pirko wrote:
> >Broadly I'd imagine introducing a new uattr for CQ to pass the
> >ib_uverbs_buffer_desc as well so the end result of all this churn has
> >the option for every umem to be described by ib_uverbs_buffer_desc at
> >the uapi boundary.
> 
> Wait, I'm missing something. I'm already introducing the BUFFERS attr
> that passes a list of ib_uverbs_buffer_desc. What exactly do you mean
> here?

Yeah, that's what I mean, however it is done every API should get a
ib_uverbs_buffer_desc. This series does exactly that with the BUFFERS
attr.

Meaning it would supersede the existing mass of single attrs in CQ,
that design doesn't seem to have turned out so good unfortunately.

Jason

