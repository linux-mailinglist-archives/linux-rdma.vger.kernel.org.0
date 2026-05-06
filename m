Return-Path: <linux-rdma+bounces-20087-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Jq+LFZT+2n+ZQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20087-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 16:42:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AABF64DC704
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 16:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8940B3056013
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98C9481649;
	Wed,  6 May 2026 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="FyRf/tjZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499F47F2FA
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077643; cv=none; b=LJy5bth5ApQksyAMnA4bJAYOP2sOplSVdDY+lZ/vK0/+04vrgD5WhNMeywtuXlwKv/XWRwwow6s0y4nghwSzwG+ax1fY7GU9TKTwxImGSdrjtuRTn1Bz2+F9ZPona8DqT+Fq0YvjuPPIesmpLq3HgVB7ZhwPNVEMdWQLAAKxtCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077643; c=relaxed/simple;
	bh=ZIU/zdYUXipjln5w3TyiTvVbpWQOnFgjwVAtmBNUzqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i76U21ZimMTgOrYFavGm3XyucfUXqWvKwUr7yL4ACVubOIs8k1+tkK0m4UydHbo+qnw0LT1wjy7VzWaDi3uR30y8PjztMas4BFHd0fXZ5flJvAOH0x+i4e2tROwe6pQhKh5PcjmuXJIbnMHNzFxAxAd37WQU4m4FVtD50Da90OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=FyRf/tjZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso77864485e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778077638; x=1778682438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E+EAE5KMPBpUChB2JDlDp0B0YOBHx5qP1AqgGmn9dQM=;
        b=FyRf/tjZBuHm8K/1MXA2CDelb1BeylVVe60gonXZYY6UXxbwHcfMwouvNkSDuVxZKI
         UffKSXh1uLv00flt9WfYifPWBbzLeNFZY5ddrGHDqFzhF8QXkdMbOGoQdKia+XPFBxla
         1UUh97bby3hT4HbcheWfqyVaOXmJK30J7QIH6qZASb+FgH+OVGUbO3wZni6kq8OaEsco
         9my+RL5jJNvtlFHCDeJF5ho0G8lz8eXKZXumIbrFFYYhyS/OgiSqmjG5IPpjlGMN0au3
         FQsRTGjHsnGRSTGqJAUmUWzsemCFGVPHEEyNulkApXLLqh4DvYfx+at5CioJDbnphaoI
         z0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077638; x=1778682438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+EAE5KMPBpUChB2JDlDp0B0YOBHx5qP1AqgGmn9dQM=;
        b=XmgmK8ky4hVPbl6lg8SnWA7rKNsDDIMUm7mG3I+wJ6s+d4BaemBGMerkMTlUBon29u
         DJ+y8CWNbDizETco9crFOfQnqMSr4gaUDR8aIoa+7CHC/JYiHgZDx4xVx3giYAnp2YLf
         gGy51k4RDQUBcO6GqFt5xCFsH2rmSybGhKcxXb166ojviCypiVnxoftzEfDSKjtnnM68
         3WE+fvjGolBwOo7jOQynJ6KA4H/a4iIiUv5jOW9olgmPH9hClEjJn7xQP6rQ+CmZSZj9
         R7d4IyENkDH1lIgtme+wAlnSjLvPhbRosGMFYh7Q3MzTPE7we9P2HsoSpaLhCVV87a5r
         CE6A==
X-Gm-Message-State: AOJu0YwP7zyiP+FnMBXGWWDD6ed0sL/IKVrlDSqVbh0P/gS9Jwnfudk3
	d6qQnJWZMBz+nVvWhepx+CvOrowjrYe6wxSEzBiR9FOVM/6yerR6fjgRq3K6I20N3U0=
X-Gm-Gg: AeBDievdtxc/zD28KaIoWWK3K+8DH+Ob66E67wBS1jdRDS1cQWcLAAf4qubmvJJDFKc
	9IAmRKx6N/uj7xn325gTlufbTx5R4tojZPckNIt8rNuBbZEWpEsAJlH+LuB5RwalXYPsnZVA4Dl
	iUxx85XSTxB4E3stkvhptMscX5J/b35MP/f2C3IJmkxvBM0PeRzNOz37W1X7IjTi5SWPsGriwZR
	SgfjMEIfCIfsJEp9SlgeWn8RBn6LYvBDu2xAuPqbqLy3qPKeqRQBkz0YtQ8ivpe9mcdqA4RGAQr
	P7B08orCGG+2UunfNJsfvwtata37FHAX+zE67XCQPpBVbM5CsBmKMDdZuTM/mM1aYykvNDFlRPb
	ZF9MxPfT12dhJE6T0fHi5xrDJxtJDNKQlCjIUSuNPYQzhmiH7h4liNakSnx1bPsHKVrlu6oFyNr
	h9cbE5uxYl8NJQw/+cZJX3fb8aXF9qxe7jTaow41bUaNk9IqGLskz7pQ==
X-Received: by 2002:a05:600c:4512:b0:489:284:44ab with SMTP id 5b1f17b1804b1-48e51e1deedmr60931785e9.12.1778077637800;
        Wed, 06 May 2026 07:27:17 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:8c0b:afdd:3d9d:e976])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960973sm12802512f8f.30.2026.05.06.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:17 -0700 (PDT)
Date: Wed, 6 May 2026 16:27:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v3 07/17] RDMA/uverbs: Add CQ buffer UMEM
 attribute and driver helpers
Message-ID: <aftPHNNw0NVFMweC@FV6GYCPJ69>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-8-jiri@resnulli.us>
 <aftGPjxQA1Tcc2ej@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aftGPjxQA1Tcc2ej@ziepe.ca>
X-Rspamd-Queue-Id: AABF64DC704
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20087-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ziepe.ca:email]

Wed, May 06, 2026 at 03:46:38PM +0200, jgg@ziepe.ca wrote:
>On Mon, May 04, 2026 at 03:57:21PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Add UVERBS_ATTR_CREATE_CQ_BUF_UMEM and two driver-facing
>> wrappers, ib_umem_get_cq_buf() and ib_umem_get_cq_buf_or_va(),
>> that pin a CQ buffer umem from it. The wrappers reuse the
>> existing legacy CQ buffer-attr filler.
>
>Did you look at converting all drivers to use
>ib_umem_get_cq_buf_or_va()? Is it just a quick cocinille job?

Didn't check if ib_umem_get_cq_buf_or_va(), some driver may use
ib_umem_get_cq_buf() (like EFA does) but yes, that is planned as
a follow-up patch to convert the rest. Should not be hard.

>
>The QP one is probably an AI job..

The QP, I'm not sure about. I can check that out for follow-up, but
I assume this will be non trivial.


