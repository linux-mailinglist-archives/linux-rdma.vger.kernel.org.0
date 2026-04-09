Return-Path: <linux-rdma+bounces-19160-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L+iDnuZ12lNQAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19160-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:20:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 114163CA502
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BA433007F4B
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACC381B11;
	Thu,  9 Apr 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="QdEHGD9N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C21A262A
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737170; cv=none; b=u+J4ZjYpqrUhN8MrNDKxTPq1mGXOsaVQZTAwnsPX/wMcGnRHPZP5S5kB9kjGkR5xCpj/e7zL3t8mwineu0IgoVTcmqOo6qm27O84w3m8BWJh6E0o1UX/E7khK+mSvBDbHrtLDMJshv0LsvbcIqWGXEob/ukuQfSiJnL87qwskAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737170; c=relaxed/simple;
	bh=aoryTLhZZaAhcoydzNlXGsaHYHenjlGGRt3TbanhX2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0wGFxewDqSTrk+0rc9VQ6BUNIUO+Zdp0u0DfwudDagZUxV0u5ZaLoqLeblCNDGIjZyVE984bE3ljN4qGJ9CiFfYsYC11cI7sgqlfInSnyYclZx5JZazIuL1JbXbPVtr1YZ1QIPHPLdNnRlhS4Z4enmPkSfV+pfu3VtKQX5m8OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=QdEHGD9N; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b8efed61so7057215e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 Apr 2026 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775737165; x=1776341965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTwJERCihkOfuqJB5utbCuHcFs2g0GNjn1E8yryPsDo=;
        b=QdEHGD9N+4OXZa2ohUI/kq4ANp/iIlYbB1vevgLipa+IMD9xw1XNHbGvxABsVjgC0e
         sLoBlCSVUK+EtxWKt7yq5zXmRooPvM32wuCmj7uW6MOEsY4mzKTpoHyieSrThUpshTmC
         c5aJlCfv7s/Ax4HZL5hh9MzAw0ebxB6NbQxFWryi7aCQtmwoM6rXMlk+7n6FeFDeoOpA
         RoeIAxOlBxdshixlikoc3ED698SWKnBQjodUBFX09Dw2GdkIb02k/y4HIuoa5SV5wbAY
         hfB5ODBN4CulH6/KdroPBUccb/KuJcn2ZjZxKnohUWyzlYxMcmUdRl+W0JLRPFQDvUsl
         gtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775737165; x=1776341965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTwJERCihkOfuqJB5utbCuHcFs2g0GNjn1E8yryPsDo=;
        b=VZZD8QWa9szZMEgY2Ipv49jujWZC8XtL22851OrxVoAzplRYxSJLmGfiqE5xg2fNiv
         GSJ0ijD9UxVpiV55vscwusPshxzGPWuT6g6Qb2ignulGo0lGUb95XZnVaR5SOpVfoZDN
         RlX7z++6JDqhzUfchTmC8vxas6E8fEcVVo6CxfIrHtwnDuSMrhdfv93DBecC9vj3RtAS
         TMW+m3K+aVcQdspqNCHwAgGilMeMDfn7mpZiQotpi+esv4fFjnFrIMGGRDyMVEkv3DnO
         SvQM5zwbailS+H7fZq9zSyXQwp2JowEBf+06Nrmr/gWmMqnUnXzbtTg1jebkLfG0iT+H
         emVA==
X-Gm-Message-State: AOJu0YzxyCpO5S1QDiTF6gnk3prWUR3PtVcN8emj0qIX8Qe9vpm0vOm6
	cbSnjRlf8roIgd5IVOfF1nkzyzhwpWgLTDbgja88NluoNu/gEyDFL0+HnJksCXEY+Hys4zedAVZ
	a5EnS
X-Gm-Gg: AeBDieujyUwiSFAaQMenRWV7g+WOLSqL9mLUL7SG+mg77A21oQb+DbIiFWaJCjzWl26
	uq9zS/Cg2w8Qsy2cOk30V1jDjWW8H/0OgZ5G5l8GbCFRdbWA/y/Bj0gOsrwfvn8Dpq70dFdXo1m
	bYvKu9MTmLsHx9TMhyqRuY4IL+hVnPXiESYtav+wnEzEYG/V+M0kifVTFK+iLWIX9qH17kK3u08
	5x8aTYBpcf+n95UgHypU0qNUFwQt+HAvg0Vwzp9tMGA4zvn9wP0SLr4B+atZVz6bBO/R61b9X/S
	GGUvVNLX3S/oAZnTqAnfNhEFyh6KNYZozc0NwpEQn6jJSusw0jfpGVUPb2l5DXLFUYuv0SfBmpA
	sJnJMG+pfxEuYbvVaM81HyQ44m6W1077fBBT896BiR3qOMWFTRno8ctuaZRN77If0wXrQVRORSz
	ci/5srTAWY3guu1T8jVcwVt5N1GrRZLZNOtX8=
X-Received: by 2002:a05:600c:4e01:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-488cd556b22mr48155305e9.9.1775737164377;
        Thu, 09 Apr 2026 05:19:24 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd18e466sm22295095e9.24.2026.04.09.05.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 05:19:23 -0700 (PDT)
Date: Thu, 9 Apr 2026 14:19:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, wangliang74@huawei.com, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 07/15] RDMA/mlx4: Use umem_list for user CQ
 buffer
Message-ID: <sgq7tehn7pgw5gm6dqrqhqj2c6tfcqf2flzhtxfpge6okiowue@upf4ejwvma5t>
References: <20260325150048.168341-1-jiri@resnulli.us>
 <20260325150048.168341-8-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325150048.168341-8-jiri@resnulli.us>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19160-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 114163CA502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Mar 25, 2026 at 04:00:40PM +0100, jiri@resnulli.us wrote:
>From: Jiri Pirko <jiri@nvidia.com>
>
>Use ib_umem_list_load_or_get() and ib_umem_list_replace() to work
>with umem instead of ibcq->umem.
>
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>

This patch needs to be rebased on top of Leon's fix:

commit 911e5ca3e16975866739f49b6e24c858110110bc
Author: Leon Romanovsky <leon@kernel.org>
Date:   Wed Mar 25 20:16:03 2026 +0200

    RDMA/mlx4: Restrict external umem for CQ when copy_to_user() is used

I will be reposting this patchset.

