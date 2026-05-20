Return-Path: <linux-rdma+bounces-21060-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wApwAfHpDWrM4gUAu9opvQ
	(envelope-from <linux-rdma+bounces-21060-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 19:05:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D507592E7E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 19:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FD6A30F9ECF
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840CE344057;
	Wed, 20 May 2026 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b918ia3o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B993431F2
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293329; cv=none; b=rIPPsWVuPhlY3MxKLg9z9NY9OCfPy6yjRHKyQfbeQ10PBVMkJQNiO7wYlNbVqQNZjuMSKhcCP/Rj8nQhi4H37nwJwHrMzeap2fRrw6PLR4muXeVVJ3GTR10m5GQokkXKF/tEUFIf2zadBW5GNDDbgA2JXLqRuVxoPXfsTseOGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293329; c=relaxed/simple;
	bh=Y1CfhrbnnFBhhfflRqIeyVxzaeNeXwcp9bs8idoZvNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbweLhGfDw1d8PVJW27FCS1HHJi0g6lFtzLhCTRl8j1L6tsoBYS+Yl2GJ9GsX0rqtImaC2gVjBYNtZeoz/mnRkxXmxagsYUnEzTFRdeRn9XBdFJjIcFsjPHBhneZLuNmHUpGW1I2YGddWuyMV8VQd3KI/G+4wDiERQhCTMkO+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b918ia3o; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-63130466364so1776392137.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779293327; x=1779898127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dowGHcEKLWPEN+ST0liuzmwCYq+kpIHtZKVI0NeIqd4=;
        b=b918ia3ozMcPkcwBH862fA4GyOSJa01LmDunwdAQ7lKDBHn1WAlGsGif3U0G5VzC5J
         SyUJNlpWIgOW5BgxhErGFLOM1p5FsYMb74mVDDkPSGBzPQ82fk18RxLqgf1vz/+qkZ7x
         gktcwIsNpMiEscfVyOvILxr/a1GBGpkn61ybDG6fnBCy7Wbhj/wsFiW33PbgRZHT/unU
         gNiprdBXw54J0uHsBr43H/sluS2hqDqgFb8lme3mpsnjnbzOmQa7s0bE1rgf528ZBu+I
         YR3sMLuHzBbwX5q2d2WDkz49slrdeCcIeCoFXb/kGdrx6RM5IWSRtgnpvJcAv7iUQr0A
         vdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293327; x=1779898127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dowGHcEKLWPEN+ST0liuzmwCYq+kpIHtZKVI0NeIqd4=;
        b=ku/DytNsyAp6XbYdpUY9bYGlK6VnQgNSFnm/FWh8glaDm2pq6LtbDFiq7Z0eVpvzsT
         RnCbJx0La7UP/q2c/Z0sJWkDWW6kyeVzRosU/x6kzzGQSWq4PaEJoqKQyAB4pLugcdwM
         Tj3CEL4XUHgG5DZIq9ODBD6XyFW1GfgNlRzu96dnvzqbMbUfdwg4XLfwX8zBD7SX8hNK
         acy/81GaHKkfCG+o28LfTCXea0ZWWYxSWYj2mnQTvLtoF2topBMcQQfbEadWWsRdDVFv
         5KZ+FLLtfJyqWy66fxyJ/DprtaCIbk0uF6jp10LmOqp7WCwoebF2qPgVNYKtBcLbV2w7
         of2w==
X-Gm-Message-State: AOJu0YyTRw4aE76evjLXYmIBWDhSZpaAE5I5X5TAVEfXan98IsuNj4K2
	GIHBn/ohBT9POXIXdkH86iKXU1pQydRlqFUTj2MsPdpOW/DXfhDsK5lRviSvVdd0eCg=
X-Gm-Gg: Acq92OFLcTar1NpxJEk2NXHmW7SNLrMti2/PCm/OZXGw3RBDKTNJ1uT8DBgYxnAWQIT
	JW56unsYombzPh01JG9iQpgumbJvtzvkxieYYCwfdPEJ3HsgOoYx3LkByZe11sQhWgOcEWjbVwL
	edD8W2kdQvNCPyBG6OO7GsqTU3es0F+1saHVq+0Z7vEC6Ln9qg5fQjt4oliB98kifVAs10Gtd2D
	yUV0X22gX7yHVsFH8rr62h+KWmEgHg7karHtMRdTRDdFY/ck92XPCNFXduy4Z1hb8B5VJilBWOo
	pJ0fcT4afQWBS40RSyjCmESnv8ktHIJuLFxsPvJNKknWWGk5FNJYylE2DjllpITj2wm0gmTey/E
	Lvh+WvXHBAo02WQN11aa1pmAbNmhpnq48+Yv6r3eUdp+zfTdPIFA0VMtlePi1OMHONvXgqbEf+s
	ZilYfgnJZDEP6hiJcTJ6/AFcp0fL/cSgjLb8H004eW7KEjkKFt8N2ikUg4J7PSVOZdRrE/XtrzL
	J7JnzS3oFVIMy/w
X-Received: by 2002:a67:e70a:0:b0:611:e0c2:1604 with SMTP id ada2fe7eead31-63a3ee862bemr12829136137.19.1779293325742;
        Wed, 20 May 2026 09:08:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm2189342485a.19.2026.05.20.09.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:08:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPjTQ-0000000HOo0-1ts3;
	Wed, 20 May 2026 13:08:44 -0300
Date: Wed, 20 May 2026 13:08:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, edwards@nvidia.com,
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com,
	yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v6 03/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260520160844.GW7702@ziepe.ca>
References: <20260520101129.899464-1-jiri@resnulli.us>
 <20260520101129.899464-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520101129.899464-4-jiri@resnulli.us>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21060-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 5D507592E7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:11:17PM +0200, Jiri Pirko wrote:
> +int uverbs_attr_get_buffer_desc(const struct uverbs_attr_bundle *attrs,
> +				u16 attr_id,
> +				struct ib_uverbs_buffer_desc *desc)
> +{
> +	int ret;
> +
> +	ret = uverbs_copy_from(desc, attrs, attr_id);
> +	if (ret)
> +		return ret;
> +	if (desc->reserved[0] || desc->reserved[1])
> +		return -EINVAL;

I'd like to carve out some space for optional kernel ignored flags
here.

Basically a flags field that kernel just ignores. If userspace
requests a flag through this field that the kernel does not support it
ignores the request and does nothing. 

Then a seperate flags that the kernel does enforce every set bit is
understood.

We've not included this a few times in the past and were sad about
it..

I also want to think about how we can discover if the kernel supports
this new path from userspace..

Jason

