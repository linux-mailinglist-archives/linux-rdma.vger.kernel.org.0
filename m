Return-Path: <linux-rdma+bounces-20621-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AdcEUwLBWo1RwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20621-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 01:37:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9917F53C11D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 01:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A963007CB3
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 23:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A46399354;
	Wed, 13 May 2026 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XBzH1o2M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFFD2DC76A
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715443; cv=none; b=cA2krKBjFwet33mlT3hLppmfz56DbFuaNeSuQ/u844v7ptWeOLNinLzNXc5HTBBy60PzIkSSGM50oAacuz7briIYoYO5/bNl6LQWoKqVb6wZrkARKS3vET+2cMu7D99/UaW+4HG7AHeOF48ZODS2mLYIYqX6mv6GBe5GysZfBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715443; c=relaxed/simple;
	bh=gsInmqZrs/JrQ5haNPOvN9CXFIrkQ3iUOrx32xl/f4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWBMD4tPYQhvfzTID2ErsZNx2VQR8S5XRYhy8GssbKuDudfOwI21Ourbm8H0Y7mTPBx98aXAqdo1Q7ifWdGMwf2UpNz38250N+pyFsA0ESSUegdUCRfK7UmgZ3VDvgqlEep11UXmROFscIo8WAYPm04ymV2P4Eufq37fCXmmRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XBzH1o2M; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8dbbc6c16b2so951202285a.0
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778715441; x=1779320241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbHhrJ9cgVwMPT02XyovS94m2TLUk/QHnXXfMMFBi94=;
        b=XBzH1o2M7zrwZT3QDbZcNv6xteQnvw1MknysddMw3FK076Xow9ObMxCnYq5Wom8x+3
         dermt+5uZ1aGz0iea6GFmvN7VmKOsCzn0bjGc3KyEcfcuADqjWvJbh0DF/l+aDijBwYY
         sRIWEF+pEOFBLEunY1YfjpxjCpiYv9F5tPCPKS0alK0hIpmcw0jE3dwhAvjiGdnD0V91
         CzcRwVXi3jij5Gi4/dDvrBP0HdKJ+Tqld0Ql4GkuLAAmqroacY8SeKExbEmio/YhuHd4
         3Jd3qeSYiKwlu/dtTUCFf9GvNUzoJeI/WZcSNY+cELjkLmlVqOzL87ULqAeNMSsZom6K
         SXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715441; x=1779320241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbHhrJ9cgVwMPT02XyovS94m2TLUk/QHnXXfMMFBi94=;
        b=RAw8B/Z1/EAM/zLlGAOhj8+f4D8QaPcnO2Npj4M+gv/c2nVFuvwU8so2igI4Pm8SL3
         Y7sJUVQ7hSt5KCS0fyd9OYC3F4ULP/ozRGWXfWrtzqtxtGDvGBb9BMB2GKKPI42sqDfa
         5q5X+MeBB3KRqBLeuazH7Pyu8Y3UixxpO44axPYUrQUg7W2cHQWE+O/PIuPLvQCTN0kM
         xEUno2sbP1/dOOopWNSjDZvq9KX19Tdc9LV7oyMCYEdDNwcmqGNCwBccI1eO9J5bmQLp
         wtnfO2nSLncNR1es5eQacBYmq4xGPSbLdaAbDaicuty3Q5HWz5FpBYXmJ+VxfqfuoGJR
         B1rQ==
X-Gm-Message-State: AOJu0Yx91/YUoVRHc47rrG6+lkiFKrK6xulMMdRupEHj99QO5t6WQvYz
	9Iph46pPf3U1wCDkpi/coMOEeJCHd1fw2/jSNLLmzGU06nzujWFlQi524g/XtrAWTafHLeCP48t
	RAKw53uY=
X-Gm-Gg: Acq92OFwbZzsxL5WEFVtatipyTZV7FMuoo4XvygqAcuNcy6us5a7LnK4O0ivmuxVWvR
	0fR024Q2XmjhsMALmBhfUmlikuN/wDGWg8FWSTT7bpThwQeq+VIzXh8JtPAlZ8sOInhNilhjsTQ
	bw8o9zUNLyAvm5IAYBCfrBr9UFtwbwJWLEpzOz1AJh/SWsmcruXaAoTmxzzeDVgdl017ttsXGgs
	PNUqz+JbBDOKeoVqaag3KaiKlcC4w24GncUkEJ7O4w6VTz76J0seXNAWRPITsTiUiolQo4KqKIA
	QOuNgk16C5RgS1hVy3z+4/Hs7w9tcvCDp3gFlyUgbK9LQ6PymH8xGpMMIgwIVXioFfPJjNa0r1B
	ih8Luu38QQTzFS9WUiiTQJJl+IPzBy/0tRLw56ASsddemPWouSqYmXHeKdnapmLmqkPvsPL9Wic
	+aMwAmm+aWHEz9kxJfmg8ZO/ghnsVvom0NhNOLXM+0IYb4mPOwtHSSHAKB443gal0wyYbuJlGHF
	meVzgmt39+lDuta
X-Received: by 2002:a05:620a:1a24:b0:8f9:effc:4dd0 with SMTP id af79cd13be357-910af549f66mr254989885a.15.1778715440701;
        Wed, 13 May 2026 16:37:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e68csm93903085a.10.2026.05.13.16.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:37:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNJ8h-000000047wo-2D4K;
	Wed, 13 May 2026 20:37:19 -0300
Date: Wed, 13 May 2026 20:37:19 -0300
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
Subject: Re: [PATCH rdma-next v4 11/16] RDMA/mlx4: Use ib_umem_get_cq_buf()
 for user CQ buffer
Message-ID: <20260513233719.GV7702@ziepe.ca>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-12-jiri@resnulli.us>
 <20260512182927.GJ7702@ziepe.ca>
 <agRinwoVkaPujATb@FV6GYCPJ69>
 <20260513175124.GT7702@ziepe.ca>
 <agS-Txfk0jid-ut-@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agS-Txfk0jid-ut-@FV6GYCPJ69>
X-Rspamd-Queue-Id: 9917F53C11D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20621-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 08:10:31PM +0200, Jiri Pirko wrote:
> >That plan seems right to me, lets just get it sorted before anything
> >starts using the new uverbs flow.
> 
> Well, this is existing code with CQ legacy umem attrs. But sure, will
> address this right after this patchset is merged.

What concerns me is the new attributes won't work at all because they
will trigger the EOPNOTSUPP, but that isn't what we want, we want the
userspace to be able to convert to the new attrs..

> >Also please look on the Sashiko report, I saw some interesting things
> 
> I don't see any url anywhere. Where to find it?

https://sashiko.dev/#/patchset/20260507125231.2950751-1-jiri%40resnulli.us

Jason

