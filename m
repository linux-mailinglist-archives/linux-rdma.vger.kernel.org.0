Return-Path: <linux-rdma+bounces-19509-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKaXAkA36mk+xAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19509-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 17:14:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B18454256
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C4AD3012C57
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E5131717C;
	Thu, 23 Apr 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dz3YQFHH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B926738D
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956920; cv=none; b=JFEiWkh1GkJBcTW4lQSIJt/aqOFXBap/u2JC+ICBEM/cTpNIHu+sS/aWXe00PhAoJWtTuB+9l1AvCFR7Eiwu17M03xbefswKRkIZWSOrdPKAFoDogDFmyJ+fffO7Rqr2HP4AF2pob2pqnwqEOIbHkfF0HrmuAR0rsmnfvBaDWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956920; c=relaxed/simple;
	bh=RFf14Mly/KuL3GoLbGe2v3c9YYoacq4Dtyel5tdHjqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVskmpM1L8VDKmUKltsRrrMiVaK78UwgMWm1CsJy9nM7vsVzacObu9iD4uQERESqkMvvc3SmhT4YYkMewA+r0LZUge9Z/QNxvTzUNu3tHKCVQSVw8yTD9vLG09vjmKBNs2grDKvqHl7UrDjJMGl3h1N5ohKOqrWGWqgZP5B1K2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Dz3YQFHH; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89f1e767f92so61249746d6.2
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776956918; x=1777561718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gT4fBfREI4EbUvRMDcsfz2FSeQDVu7NLlTzNc3RURjs=;
        b=Dz3YQFHHzz76S2CyxasyvS3Lw/MipJ9MPsumvUNySYevRhaoCv+d5qKG0GQIiw71RW
         lCV2dHzpYUULNZTRhskQ8cTj5FNTzTfMYl/lOKHC45tD5K6e+oZca0rDh00/fjnC6059
         OnqHOxuCDTq60U6/sVMW32PAjdjdL7Wk8efwXW2Bx4hSGGTz+CQrkMUnn375UhC3RlDa
         0Xg3UO/a0McZXYKhwOmP6DyHUG3UQRG0EJKsE8jkVVvm1A9iWg+6OTrNaMegXuiM+HOe
         SeZ2BO4tsZP5psK7Xb0XSA1y09VnmZr6LGwiCA21gU8BspN9yIfgdFUzt7fRSlUbO4Db
         ZY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956918; x=1777561718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gT4fBfREI4EbUvRMDcsfz2FSeQDVu7NLlTzNc3RURjs=;
        b=tD8hRl0vjjr/Xi3z1vG27M5CiRqdFGohiWlM4B6ZvKbeP3ddGxWOUm0ItQnx16AEXW
         beCXTjAaeT83v0tUBlRRkr/gJczppBm+U5QhzyhhPGdkmhLRMRTrLPmdsaoKkj2sjHIk
         hILXu9yDm62Fk5QlrZ8Cp/dtZSIWZfrMpyXfC+aYAdMgIMXNypI1pvUWjXh2pdavmyJL
         uE0E997fIx4R/7drmJAtRY1ej2lw/DA85VgvKD6JcnKeu73rIF+6MjLXCluQ/rX7NwSa
         wlAMOsKViF1iUZeT37Xf2iAUvlkxLd0nxeWPmaJXJbqyxtsoqQzL3fR4su8TEtOfHDEU
         045w==
X-Gm-Message-State: AOJu0Yy8WHHc5iD7GN392oJgd7Ty0otWKzoGPModkoev5aNPAhuaw182
	oZ+Hwh2OHhzwsR84VWpYj5Kga1H2CXgIOjRM31Hg2BFWaQW9gGuLKBaQHDDK2AlhQGY=
X-Gm-Gg: AeBDiesnm9LBb6Qap6pD9mgl9gBtk0/B2Gsoevr2WnNHyg//TdgWY/9EV8yQ1GT8jZE
	R3EmJ2J/+SxqivdTTlo6KiSKhwse0hJiE0eo20aBB0WvWi0lQPw6ANw0uw+RvglqwdCsjzFY3Bo
	MksmnQ9yLsVQ1+NExZSzKHltwdSaeE/Fo2doB2OwQHSH16um726sAFujIfABYW/w4BzEXnM5jKA
	ZccI7bWT3faGOOIWsLUbIHc7xMeamMx/umpkj8yAl+KycHfN5msHKqtKddmGzW7Cnn/bZXh0nUW
	Y7oGPE/yIcDQDuwZGS0w+J+aC2KWaO7tezHO9ZL5Gdp658mD1CFKStJrqYJnYPIksaYjWMdROJZ
	zYs9hXyYiSUQI9J+mvEf8NgXaD5sGWtBDrEwnQ4DGneRynTd3FyCDNI0AJTJ/5UK0qDjg6sGMHC
	jvypNGD8qtOXwMHSzlXuXVk3Qz51zZg/7GTp0pnBy7eOGcAc8JuNy3vzpTnG7zcvq8qTUxCpAkv
	sLk8NQd7I6p2++b
X-Received: by 2002:a05:6214:2587:b0:8ac:ab13:8f0a with SMTP id 6a1803df08f44-8b02804d2afmr437597536d6.11.1776956917754;
        Thu, 23 Apr 2026 08:08:37 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm162173406d6.30.2026.04.23.08.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:08:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFvfQ-0000000EQVf-1Uhs;
	Thu, 23 Apr 2026 12:08:36 -0300
Date: Thu, 23 Apr 2026 12:08:36 -0300
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
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260423150836.GR3611611@ziepe.ca>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260421134635.GG3611611@ziepe.ca>
 <pun4bxcclwqmurxzxuqlkv5qdpiqcxqjpbhrz7vtsjf2paallz@6f3w32ww4gl7>
 <sdmwjrxzgbg4iz5cspcdkvvdb7rjgdggkw4njct3pkdsvhsq24@qstis6jnplap>
 <20260422165101.GO3611611@ziepe.ca>
 <lyzh6ftbtjoznz2vrswoofy4tv5fqoqe6ajrlqdpqbd7aemtw4@lz3ilcid4vsx>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lyzh6ftbtjoznz2vrswoofy4tv5fqoqe6ajrlqdpqbd7aemtw4@lz3ilcid4vsx>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19509-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0B18454256
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 03:08:19PM +0200, Jiri Pirko wrote:
> >Whereas if the driver has to define mandatory attributes to pass its
> >unique ib_uverbs_buffer_desc I'm not worried about future ABI because
> >eveything is now clearly labled and the uattrs system already has a
> >built in way to reject using a future kernel's driver attribute on an
> >older kernel.
> 
> Hmm, but the attr may be optional, yet silently ignored (for example by
> driver that does not support it). I think we still need to sanitize such
> silent ignores.

The kernel schema describes attributes as mandatory and optional. If a
mandatory attribute is missing then the ioctl will fail before
reaching the handler.

The userspace can also describe the attribute it is passing in as
mandatory and optional via UVERBS_ATTR_F_MANDATORY. If this flag is
set and the kernel does not have the attribute in its schema then the
ioctl will fail before invoking the handler.

The only remaining case is where the driver has an attribute in its
schema and doesn't actually use it for some reason. I'm not sure this
is so important to worry about, at least from an ABI perspective
everything is properly labeled and there won't be forward/backwards
compat issues.

Jason

