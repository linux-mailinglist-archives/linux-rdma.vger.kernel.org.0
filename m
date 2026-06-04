Return-Path: <linux-rdma+bounces-21783-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MR9GHciIIWpAIQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21783-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:16:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E962640C11
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:16:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b="jf/A2ekO";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21783-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21783-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3639D30B067F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20CE48095F;
	Thu,  4 Jun 2026 13:55:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E847ECFF
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 13:55:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581317; cv=none; b=Km38oJemF6RZ6iuZE8B55xKTv+uX0nSw2NOT1O0J4F5u+mOZEuq2de+Cff/vuzc7dkVsiYvS/dx8puvC44cR+8AR/DETCqxluc18RDYVHAs3JQvmY8RKFx+K/R6SmeZ4jON27U34mFtOcdKb3eyA/beWZ9OdvjaWvJJLF/uXF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581317; c=relaxed/simple;
	bh=iF7WCv4wmE3jhYpLVuN3TOW+xLwQtrOWCAJnqZuqxcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6eicQo2taWBgHVHhfAjlXnM8Wq5+RRSJ2ryOCqr6Yetvxa2amTtgKzkETeB98G/BSaFy5vd1l3Huy5kYIBm+DoubSpLhKF150Ti9HpG56Wqh94V9nAkkETjNObVjEkAIuagS7Wl/woYB449s1GQQCtbltWOvPE48FaPpuMKtSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jf/A2ekO; arc=none smtp.client-ip=209.85.160.181
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5174a3a025aso6946511cf.3
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2026 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780581315; x=1781186115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2gwWaDWtdfpLdLmO97cF7KayysA1VPOkDxjxrlqS/U=;
        b=jf/A2ekO2aTUp3BmaM14X1wDQsLGFMqEQbO80bIXLPyMmkzVKj8aVuEbwJP5V5kp4R
         7CqGE8k6PYKrhfhKw6x6gwG0XnddmB7huKvWy34EFbKpu/MsngVju9AxgMiLTkv3v/sH
         Rn+ibf4LElgp/l8MLRwn8gi6ahGVl/6ipEP5vlaVksDkoK0I1O5AhVki9Tn4nsdUx/Fh
         59NLaLve6usTOLP1OSXb/qqLx9h86m0S4fGH4AHTHoqnxKzHQIHt/2SwQZQz6xiKS/V5
         /NlQE2OKuvqK0NMTharxZBR+tJGlbUOwKk91blrMczto5yK2oATzUGCPm+YxWKUY7VDj
         BT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581315; x=1781186115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2gwWaDWtdfpLdLmO97cF7KayysA1VPOkDxjxrlqS/U=;
        b=FYrdOotWuslxRJUw297aPxT/+bqNh57JF7nbIPphv2kTBOVcApeYIb/LbLetXMHd9h
         kQtZzb58JNutGhge47PCw/vxEIcb7Txom+vTRbg54efjVklAgG/6EZBlKrEUNqwC9T1A
         VousPNxSe+FlHwJlZ7eoYcEx7pHcGtxir9miP3T6odaqt3rHpu1S1Q1U+189wxnwLWxd
         AmuO1wm6mFkPaAU8ZzNk7I8Y+xMAPIX0y4EIWx21FMOWmdFyzGyTg2UAiotfs0YEn0o9
         YIA+17PWeV1M+cDmMtrC75YqOqdTQQPfUj3xFykVSHdYsT+y6BjFImnQU8qjXHcYgIov
         bleg==
X-Forwarded-Encrypted: i=1; AFNElJ/Lu89S0WvHERYDC77xpk2r4Th+Ks3HfZe7xgWg9IOSJFQwIeQoevY+j7AIBQsesSAINerp0l4+lQgV@vger.kernel.org
X-Gm-Message-State: AOJu0YwCiyPWhPN+qC6Zfj583ZLcsuqFM6jzHitp14Qw8yWnZlC70b5W
	sefBWXqA5aNvvGbat56uv9BeO9Zz8gR2dIz2+VguKYON+mo0XEHSpyhC7KlL1SL/tW4=
X-Gm-Gg: Acq92OG6/+w+mPjXcYDWjKmc4CwWa7v0Biv03CdAbbLH/2bQfAZznuzMF0BEoeNPX/h
	HcMszl9iG6f1jLCsTzpJoY5b0FqLY1iqJHzCsgX1oLqpyywgJwBYyjgfbNB30F1sdYvXIjS3Gk8
	slHEcMRwjjuij1H2mL9cfvW7zvWONds1yO+eCkmp3GtC8xGq+zTodXzWufAXQmQIHtx/fqPROSr
	+xO1xg3CM63j2wu3+B+mBCOQW8evScvDmhbD5EkuTNMKgs6VEriESIreg52hWEDCJMEZ7yoOq4w
	FUMYuyWdfu4HSW+q3S1dCz5JLX6Y/KklkL5j4E5W20L9QW7ueUlJQB5CwsE1zgSSElbldc7c59T
	F9mHGdB+KdXpQODZCnBfd0r0PmwAJo30ElBg1zNH6EppCOXyOztEZ0YvwckwYYZFkCMmPOJ5t6s
	9OSGyY8Voe2vMz9Qxv0COswN+RgfVl7Ovp5MupLBJ8G+YmjVLUIAtKdrd/AT4S2vJ+bCG/4Viv3
	NaI4kyGVrqxAvul
X-Received: by 2002:a05:622a:1c19:b0:50e:5ffd:deb9 with SMTP id d75a77b69052e-51778696aeamr109514391cf.31.1780581315064;
        Thu, 04 Jun 2026 06:55:15 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd263003sm53394316d6.42.2026.06.04.06.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:55:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV8XR-00000008FXK-2ZEe;
	Thu, 04 Jun 2026 10:55:13 -0300
Date: Thu, 4 Jun 2026 10:55:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: Gui-Dong Han <hanguidong02@gmail.com>, krzysztof.czurylo@intel.com,
	tatyana.e.nikolova@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, mustafa.ismail@intel.com, shiraz.saleem@intel.com,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] RDMA/irdma: Use acquire/release for CQP request
 completion
Message-ID: <20260604135513.GU2487554@ziepe.ca>
References: <20260604083440.426033-1-hanguidong02@gmail.com>
 <CAHYDg1R=wPOwZnC3XnnrTB0DjkBoiD++ihV9Ts6k8zDYaXkwQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1R=wPOwZnC3XnnrTB0DjkBoiD++ihV9Ts6k8zDYaXkwQg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-21783-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:hanguidong02@gmail.com,m:krzysztof.czurylo@intel.com,m:tatyana.e.nikolova@intel.com,m:linux-rdma@vger.kernel.org,m:leon@kernel.org,m:mustafa.ismail@intel.com,m:shiraz.saleem@intel.com,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:from_mime,ziepe.ca:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E962640C11

On Thu, Jun 04, 2026 at 09:41:24AM -0400, Jacob Moroni wrote:
> Makes sense to me.
> 
> That said, I wonder if we should just get rid of the wait queue + explicit
> flag and replace it with a completion?

Yeah, then you don't have to worry about this.. IMHO the driver was
following a fairly common pattern for wait event that is indeed
probably incomplete.

Jason

