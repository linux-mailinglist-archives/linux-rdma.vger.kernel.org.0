Return-Path: <linux-rdma+bounces-20593-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLl5CC22BGplNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20593-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:34:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B56445381D7
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63B7A300D35A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3D4DBD84;
	Wed, 13 May 2026 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I4gXFbmh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A74DBD70
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693631; cv=none; b=N6b88ySNR17o8w7VwFLMcBCsMR5lVTiIcvrCW8nY5BPwFni1f9L5232D4pABMFzmFN96Fb1nsGZilishDpFoQaH7Mg5NOd/1971h1vJnLk7UuKX/0jGD9sqipWhUyK7cv+7VyMw/m1Frq57rmL/LWquNNKam1rE2L8bSRfWBF2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693631; c=relaxed/simple;
	bh=6+//5xbs2U5c98ruGX3IkyvtQMNVGFA0COBWCq6cV7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjHDyM3QW/jmz+eo8istYqDoZdEX6PupjPRX1AAVkfb9DUN2bKu6KUCSGyfvBo9AZcU5KdziyxLmzAvBqCS2raIDTv2O0SsU+hOMguh3cumUTaAUHGvVs0FNltue79Bacw63r+tv16sPTDDkBxIm4YDv/obthy9CrBR2KPQ9LyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I4gXFbmh; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso79220956d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778693629; x=1779298429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvwJ7ch3aZL+KQYhipNLpJA1LXJaBKEt1lxzWeg2J2E=;
        b=I4gXFbmhXmyA3QQMNqBXUoMYwF0ry+5XNnsbzq62oaDs0voUhfVA1OxndR5ng3GAGF
         9wvyc4Yo4Vbyf+mLl5px2wGKl1MiAbS+VX4YdXh7uM+DL8oMwHOHE3Psl6XBfbTUcQYr
         nfEG2hZWU/o3DSwMfx7AFvndvD01P5ZKLL/GxwDGUGiAWlBt3D47WpYMbSU0/8ra3Cv1
         QE4HNcYS29vuUTn/oETB+kRWkLdXL1kJf7Z46fKdjfx8cPxHh01pemj3CDuTHQ8fedpO
         /sSBq3a4MGw9phrRH1GgapPpCEAVyv7sNd2A2uBXDULuCO86BMleGMRoKh5Asf0wvSnu
         A9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778693629; x=1779298429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvwJ7ch3aZL+KQYhipNLpJA1LXJaBKEt1lxzWeg2J2E=;
        b=tLa89M+zTTLN7bP2+rPOeNSMXO23+1074Mj4ni9iH6XaFJoaXwQsC5IOkirkHYybbe
         FPo2NykJMH2o+LTxV0d/j7v1PJrhMI0/D3ZJXa1mXA80Okjf0QVrPM3mUCrpm8bLozVo
         zZh1WQS9iVnndauq1IkfbSQrMiobQYdKJAshjglqztMxkMwLbQ4ynKGQmP7cLn+aWvNo
         0l6t2W9Dpf59nbBR2Z3ZKdzHn6cIuDnrqzHEVFvLZZu3cXTai0/iGDNFM68B7nDb6Zm1
         3MdSCPbmmXq3abgeRms7VblB6U7h9g+LCPMFBV4z3ouSZDKU0Nmc+3DbVwoBY+1JqY7v
         kERw==
X-Gm-Message-State: AOJu0YxNXfPUJ7KRWZShGLfpYUe5jakHPxc01QxrDeM7st+pkwq8H6NA
	mnk0TUsVOuEeQ7iM+u9dMWYtMLEYDk24ZIboGkZylBeFsQwUcweWuNDfFThihP6qRqA=
X-Gm-Gg: Acq92OFI63l0Aq8ooPlvFW1/3zBZSD8eHmI5Xb11C8YzTPU9FvmAMvDPndAzu2ylR+R
	zffUmHBVB+pQeO6NM1sy4cXr2CHZlF9aFebki8cdlMEv16nSzJsYblFWohe3m+hq4DhsL7oSNiH
	j0VCRsKLRYrkc53LzIQy4v72n0OvWBknvxyq/uU8Rmxa/rXp0+vVw327A9AWxjDV8VTiqHM/q2G
	QpV4vcQLc9OX2k23V+5q2HfxUPCLadGO5VeZla1thjAEBiFJuJNZm8u+xsn25v7h3aBZTeWukJ5
	Urph+tVvNCG1na9QO7wkyXlyCE7c9YK567DQw8/b8W166xRuJ7XIs/HNtjYoRkLkDBi0a3mRcTC
	5MckRqVPBOf7myTZbBoBPeTIjhEsTcaFPEEgTgMpgAB1L+Bq1HjdCwhNJcgB5pcMPTN9H+Y9/Es
	VB/G/hB5SDZ1CJnZDRcW49ZigSHbY4VCWhhJWake8XKdNM1mvLT2LrGDv+i5FJf0K8HJ9V1Adx8
	hzoG5k/foIhItKj
X-Received: by 2002:a05:6214:5b88:b0:8ac:b3fe:68c4 with SMTP id 6a1803df08f44-8c8ff636dc2mr6394876d6.36.1778693628952;
        Wed, 13 May 2026 10:33:48 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c374469sm1191336d6.49.2026.05.13.10.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:33:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNDSs-00000003eNz-2jcU;
	Wed, 13 May 2026 14:33:46 -0300
Date: Wed, 13 May 2026 14:33:46 -0300
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
Subject: Re: [PATCH rdma-next v4 05/16] RDMA/uverbs: Inline
 _uverbs_get_const_{signed,unsigned}()
Message-ID: <20260513173346.GS7702@ziepe.ca>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-6-jiri@resnulli.us>
 <20260512175142.GH7702@ziepe.ca>
 <agRj4QyKHBUI6yum@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agRj4QyKHBUI6yum@FV6GYCPJ69>
X-Rspamd-Queue-Id: B56445381D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20593-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,ziepe.ca:mid,ziepe.ca:dkim,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 01:43:29PM +0200, Jiri Pirko wrote:
> Tue, May 12, 2026 at 07:51:42PM CEST, jgg@ziepe.ca wrote:
> >On Thu, May 07, 2026 at 02:52:20PM +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> uverbs_get_raw_fd() and the related const helpers expand to
> >> out-of-line _uverbs_get_const_{signed,unsigned}() exported
> >> from ib_uverbs. Callers outside of drivers (for example the
> >> about to be introduced CQ buffer-desc filler in ib_core's umem.c)
> >> therefore cannot use them without unnecessary extra dependency.
> >
> >oh. This is actually a systemic bug, the intention was no driver would
> >depend on ib_uverbs.ko because it was supposed to be loadable
> >independently of the drivers. This has become slowly messed up over
> >time.
> >
> >The file ib_core_uverbs.c is supposed to have these functions. There
> >are many. So many..
> >
> >I sent an AI off to fix it, lets imagine we won't need this patch..
> 
> Plan to send it soon? I would like to respin the patchset and send v5 as
> early as possible.

The AI did not do a good job, but I just sent something

Jason

