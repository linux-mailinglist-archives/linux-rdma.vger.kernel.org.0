Return-Path: <linux-rdma+bounces-19449-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAf/MKty52kO9AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19449-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 14:50:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5A843ADB5
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 14:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF11F3008454
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141073BE653;
	Tue, 21 Apr 2026 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X6dhICAU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7982D7DD7
	for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775834; cv=none; b=cpiZFzog8sMRIQmrps1dLg2dn/6NstPsk59Los+lJcUbEjODpKbnA57otD9F9ut8fuTiyWk0aIXvpliCVUoA6DoKCIFuz9JKfF2vLMF5T0HANR6i/oKD1r1lELYIdXmuJs8Lme3SWLpTUzQhr4kjE58S6FPnLz5YeAvafQ46zvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775834; c=relaxed/simple;
	bh=S8W5iwx55PGRUAp8tGiCxsYK8vfKYm3enZzdKvvIszE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBnezQl13SEJSv4BSFamP48RwcFBrBsTLQzNvCIcfnuapH5p9oYW1SBO/mxUbR9HgvGp4elCH6ij5G2utcrSx6osUqv/V8uC8xFBf+sm8JBzkxeH/URzLQdSLU4nDTzdmqTCyGN8ynrTuachAnVoGZYrjSwuFPLG/heg0h9y8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X6dhICAU; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8aca6bd57cfso40889496d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776775832; x=1777380632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OTO1cXGFMWSczJtKPTb4+Cc5QISRW8keNKgXNky0T3g=;
        b=X6dhICAUwj9qg4o5fwwa2AaLGA7VidxW/NQIvp9zrk3FeupqUjTD8TFEh++GrbidaL
         tIpqFHyMZJhMM2QWxwuW6poabVY411Z3s5wur7hfP3xkFPrKBK/4//KoAY5fP7P1u9Bm
         yZ72EGPtXmQl197c1uReRy5v9fTbGn+L9kiDSMHJlOfj08PpPA0PtiRGL7LG7xvsZdyq
         pUKN0r6ktcRb0H8FYVtQHFvsTkuQkpbw6onN0jGhiQDprsK19FjmxoAML27zlIro+o8x
         Z0KZjGgSP9pN302o+aZINC0KLrrUz9huqbXPd0Hw+++eUdfrhLaBhNsznOAp2f+h25wS
         TMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775832; x=1777380632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTO1cXGFMWSczJtKPTb4+Cc5QISRW8keNKgXNky0T3g=;
        b=Ka4TN3QC00LnkclonNgp+PJCaQNP7ICf12b4IPrLGnHVLLZkvZ2OUJ2UOpNv/cHDdx
         teRzhaiizRLNN8PBLho0t+g9FrXX9YhG0fNU/F0k+fNDqROL1W2ALgxS7alY7tAA99xB
         b6HZvlck/gIIiRKrzTN9qdYQEVkvPu2jsmVtsWJcqeUHHkjo2fGC6PkEnwmlcUYiD6lq
         USc1af4Hd9Kal0zT1kVjdSo0nS5UriCMIMFgDI7c0nts0SzaXrWHhdSRhjPSOdqtJCBk
         iViCUkNdwe3kXZJZ/YTNxp9BSh75e9EvlmACqE3lLOmYtDuM8FqsryStihxmpEqoSe4Z
         P9Jg==
X-Forwarded-Encrypted: i=1; AFNElJ8HAelPDQ9jPRa4d963aGKuvb4H9oPuMO4lAUa48yCfSyr3nZjj3lw55z7sOFZOL3pyZCoXd+E+Af+V@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeZn7SIwCD0QbpfHTy1Ld32Hwk2SzzbWgQphzV4P8l/ed6D/i
	GaUH7+o5JEOaqw7GT9ndGFZw5nos2HWkhGPORosCQW70pO+z7SEVooVTL7+w44gdnDw=
X-Gm-Gg: AeBDiet/ngMOBxgsYlRKkqB4tZxlI6CRS9/nYTFwD7Z+D74T7Uk1/xO2eh+ZBakBwGQ
	WfrB7uzzFRipF91S6qH9BJGLJwaiP9xTQGSU+ewkaN5Cs2B3bFXVEZlEF+DFEg+8vGXqYqwInBj
	avjH7D1L50MfC/lLE+ifthqlbEXwL1pMRWTsxjc1SKSGGVhi2zqUA/uHpp70ARbKKrtPWB7I55E
	KNqPqj2+x6HowC9qLS8BJ0KoTFh7AVxHfO3dw1KZaRqGXYgEmf4OGHLOs7t5EZ5AGwXfSMFjU3s
	rBrEbh9SO0rKcK/CCqpUnYWP78fWYUsGo273nJvi+IF7FOcT7ZkG8+dCCBM3vkVCndzLT222sN2
	p5b8rrCd0J0NDRp6ADUjdk0u/IeUVuO5cdbYZTgqIFpE2VA0w7EKIX8shEMv89S2gP5DiqkQ9b3
	5N5ObaG7fxvsovhI5J+z5IMFHU+KhLOaWSe3GkLUFuy+ghSq2fjWf3WIMj3TKiezEnAK0oY+/FN
	nS4scpe2y+7oTW3
X-Received: by 2002:a05:6214:1c43:b0:8ac:4fd1:2d4a with SMTP id 6a1803df08f44-8b02811c4b1mr304864686d6.33.1776775832315;
        Tue, 21 Apr 2026 05:50:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aeb04e0sm99107076d6.46.2026.04.21.05.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:50:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFAYh-00000001R3V-0f7t;
	Tue, 21 Apr 2026 09:50:31 -0300
Date: Tue, 21 Apr 2026 09:50:31 -0300
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
Message-ID: <20260421125031.GE3611611@ziepe.ca>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260412123322.GA5166@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <fzughzkkr5zkr436pdzu6p2j4sdlphtxpbbpztxoerbms6a37f@4dzcxphdyjg2>
 <20260413160232.GA21984@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <dy6nbf2vibl3aeopeb7im7fksh5436isqcmcarghkm5e2ontoi@unvvimhthp53>
 <20260416121000.GA20519@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <mxyzifm2htpmyeouhkeycliwo4ye6qov7vs2rhefyn3ghvp7nl@uxadwty5dvtj>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mxyzifm2htpmyeouhkeycliwo4ye6qov7vs2rhefyn3ghvp7nl@uxadwty5dvtj>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19449-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA5A843ADB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 03:34:05PM +0200, Jiri Pirko wrote:

> >Get umem from the new attribute if available or fallback to existing
> >attributes:
> >
> >-       umem = uverbs_create_cq_get_umem(ib_dev, attrs);
> >-       if (IS_ERR(umem)) {
> >-               ret = PTR_ERR(umem);
> >-               goto err_event_file;
> >-       }
> >+       if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER)) {
> >+               ret = uverbs_get_umem(&umem, attrs, UVERBS_ATTR_CREATE_CQ_BUFFER);
> >+               if (ret)
> >+                       goto err_event_file;
> >+       } else {
> >+               umem = uverbs_create_cq_get_umem(ib_dev, attrs);
> >+               if (IS_ERR(umem)) {
> >+                       ret = PTR_ERR(umem);
> >+                       goto err_event_file;
> >+               }
> >+       }
> >
> >Drivers don't need to change.
> 
> uverbs_create_cq_get_umem only works with legacy attrs. Not that
> interesting. How do you propose to handle other umems, when uverb
> supports multiple umems (like + DRB umem for create CQ)? I'm
> particularly interested in consumption validation and life-cycle
> management (that is a bit trickier for create QP).

Having a standardized attrs getter for a umem is sort of interesting,
but you are right it doesn't address the the lifecycle, the driver
would still have to keep track of the returned umem.

The interest in working on the umems was two parts
 - Make more drivers accept more kinds of umems (ie dmabuf) 
   by getting them out of the driver data
 - Have the core code participate more in managing the lifecycle of
   the umem to avoid driver duplication

The latter was easier on the cq/mr cases but QP is quite a bit more
complicated.

Jason

