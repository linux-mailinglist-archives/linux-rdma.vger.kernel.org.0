Return-Path: <linux-rdma+bounces-21156-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJwXDF1GEGpqVgYAu9opvQ
	(envelope-from <linux-rdma+bounces-21156-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 14:04:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB05B37E9
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 14:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 814613008FC4
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9903ED5DC;
	Fri, 22 May 2026 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cqOu+LeV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A913D4123
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451037; cv=none; b=akMGhk7DLwAUMkJK7hnm1+uMVE107+dQXX1qQS/UKTtmWNoI33/uijqo8cgRDaHO3QwOrF1TnKaZtEk/HTAgIDm3kiJDQAO9mhZSU7peYxZoeqIR7k6ik1DmgSSUnfumMN2tw2obVKecHNSzQjNPEWguuiQdz3kLyuCozuVJWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451037; c=relaxed/simple;
	bh=6tvxIS7FLjMHmZfNZR/hbPJfu9d0JkNnJ9jgq3ginww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS92DRWrhyCOOaiJqyQTZxwYxW2YwIFY9Qo/Wz2UnW2Vh2QOc0RHOQNrZWXAgXey6OBfD9CCaiFLOKdgc2dJcWqV2jUd+pxplU3mxw67D3k2I+/8vg/CEToz5JjA858Dzz2urt30qKMl7Or6lRVgh1d2rQpIFI+JsOxzfVMblos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cqOu+LeV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5165195c8b0so79934681cf.0
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779451035; x=1780055835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YkHQK33jn1Rtl0mlmr2Mkk3GZgvr1uqfKL/EdZiy8dQ=;
        b=cqOu+LeVoWeMigBVb0tZ/8Lxr663ldPogfhoBkNw/Y7IOZ15pMziz1xQHfIt2YDYcF
         eFO+2s5dpZSvwYnsXPqNt+gj82LZNGB/9EXEXMjB1Y4SfP0Q8ed1SXz5cexV2VWZC97w
         EcQ03cFD2br7P7Ya0yhudh4N7vgc55+iNynWZIxafzSQJto341NnzwRbOhzG0rywDUXD
         7kXgC4jFv+ef5KDLJCrRhe5w+cLSzc/1XY+g/Kljcya0b9T8K3dYvoB7BsmpIhT3OVeD
         Tno/8SQhvKNAP9S9eiStqt8BVqWzPTE9jykmzdSYiriLxPVGNB3MdhxmrWIdNvg4ZT9P
         TqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779451035; x=1780055835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkHQK33jn1Rtl0mlmr2Mkk3GZgvr1uqfKL/EdZiy8dQ=;
        b=Xrr3QGJY5c639aONJQf2L7EWJA2yRp8Z2CYNh+kzctCD8nUU7JnoWKsaGWb1iBVZfo
         xEUngxELAushHighKdpOLuT8VhI38a5+OG6Qt6slolqsh2hbyRHr9gDCqz6ix83dDjwH
         8oAutEpV893+XFo8ECcYyd90StmPqZxB8G7LhFZq391VfMQBC/bgiiGDi2gvQea/4SXq
         psHqUviuIOu1wsXM2xTQAH4GZLwPiEWvEK4JmWb/TZlhbfvJ3SBnCuntF/njSF+Yy8J1
         6qmb+VxlHmfs40EJCuK1L+JChhD7CB0creBSGDqn+UBnqfeYw7nvCuffRMelP8BgJlWz
         SRHg==
X-Gm-Message-State: AOJu0Yyn7pzRgpJwVGPOW/PvimcOuCUvk9DXPOU1EMX0MrLadNtwUEz+
	3DFLvAYdutk5CsRcV+iwhykLlC9+mPHTDY6vpLfC8RI0KOgvXeqzLIj9jgPGbNDbUWk=
X-Gm-Gg: Acq92OF+wC3vrQnfTUVDunfIbZRk+KiSAbX5XknLaysijsaWT8b61XJpPGWqBKYH88b
	B/oNDSnq4oyGRuZKNZLyq4YBbxR4UtUUz3Oi/oecdoKDndKUYu1wOipeUI9HgEsbz/OLE5qvHSa
	Rznopkr3wo/EX7StcODhyEyA4BnpHi7feS+1p00Edyivw19mgEYrY4uywYeBqdeCJe2GL4qBrpk
	Rn9UdoCAZtdMzvSZG1zewPEbRborSvpAsl1jNDH9z29IKBSH+zyX7l8+u00GZuIL6gOmCXG21vA
	Foi0bm89L+aw6Q+dJs9K8ANXF7e4Tw/io7vtaYad3VrgRmPr4i32UWB00eF/LWmN9L0K/z7nIjS
	dFCRuIHRfDeTA3KQm/K6LGR9ZEestjfFsstsO9SvER/NoDGjnnjymiiNhvWsvgrEec1Ot6LvDT3
	ONFUX+A0OxKExsHjrlI3/VmjJcMRtx4UicoQxTVHyszdymVIn802a6xi7T15oS00rTfcGC0Aj9f
	NcEeSCczmk+gVUx
X-Received: by 2002:a05:622a:5a91:b0:50f:ca25:fb48 with SMTP id d75a77b69052e-516d46048a6mr43896981cf.55.1779451034619;
        Fri, 22 May 2026 04:57:14 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b45768sm11786761cf.13.2026.05.22.04.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:57:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wQOV7-00000003YtA-1zvF;
	Fri, 22 May 2026 08:57:13 -0300
Date: Fri, 22 May 2026 08:57:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, edwards@nvidia.com,
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com,
	yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v6 03/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260522115713.GB7702@ziepe.ca>
References: <20260520101129.899464-1-jiri@resnulli.us>
 <20260520101129.899464-4-jiri@resnulli.us>
 <20260520160844.GW7702@ziepe.ca>
 <ahAK4bTnyK3Iswef@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahAK4bTnyK3Iswef@FV6GYCPJ69>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21156-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EAAB05B37E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 10:31:43AM +0200, Jiri Pirko wrote:
> >I also want to think about how we can discover if the kernel supports
> >this new path from userspace..
> 
> This is problematic. This is up to the driver if it implements
> specific ATTR (may be generic or driver specific) or not. Not sure how
> to do this. Per driver list of supported ATTRs? Idk. Ideas? One way or
> another, this could be easily a follow-up.

Yeah, a followup is fine. I had a patch somewhere to allow userspace
to query if the kernel supported a uattrs..

But also maybe we should just convert all the CQs in all the drivers
and flip a global bit, then all the QPs another bit, etc.

Jason

