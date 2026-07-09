Return-Path: <linux-rdma+bounces-22967-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E9pZBmXET2pWoAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22967-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 17:55:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618297332AC
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 17:55:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=Yjl0q1+X;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22967-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22967-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FDCC3028B0A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E842983C;
	Thu,  9 Jul 2026 15:48:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99988425CC1
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 15:48:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612095; cv=none; b=bt+Fk+NlAbi3y9k4DOyS76439hgP7WfPL1o1vQhtFr0etYx/9GVd6k6bsCMm6nL+QCb8yIXZeyw6oWjAU2bi8qoeC9/SjZeYu3X2eiJDnvTh7SZS6e2aSa2GdYCbFmNbV0Bf/E1shh/TD9Ow56Tjx8olftVx64vUeRcNPVkJVMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612095; c=relaxed/simple;
	bh=1MkQe1sQSCJFr++J1/4jB+AJVcNDiQ/KelgtPEM6mkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmBnfVxUXvibsb8bcL6oPge1kuxERflgOQolvqdYwY7YRQkvAPeZOrUmUp+shqjzKfsQFrr4Wxycr+Tkx7EqMbCZwfPQMOF8sXIJzzsfWqVQ3gmsKhlXN9tsIa9o8+bRXnbYlSQBwT/LYfz0+3xhEIEnyc2CGKQDwXVXWsnqJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Yjl0q1+X; arc=none smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f0e5e36912so406366d6.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2026 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783612092; x=1784216892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MkQe1sQSCJFr++J1/4jB+AJVcNDiQ/KelgtPEM6mkE=;
        b=Yjl0q1+Xpik6cUYeFMgWv2Nizx2mTPWP89+r2kpZ9wemygWACy3McJeoAyVB7G31uA
         VZsiuelysCy2aNJ/OtqPuTsfVFJ4gwx2eS1mg+aq+cj/CgxOTsbm34wQsqNW4p01RRsy
         jgh2I+OWNKaya29Sk+3FN98NrzdSodfxUboDfnbmJDI/mWfYG43unftqRqKK6R9izyG/
         gHnXtowClp+6TsODZ3n6g0vTGOV7NBCm6XLIHLKf5NPIAlSUUOZ23A2An9wWUpTJ2rCe
         rMh4s2XfBzEks0nKmJEktde2YhMsf7wJZHMK414JunYtIcxewrjn4LG/EtipkgzxHSdL
         xtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612092; x=1784216892;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MkQe1sQSCJFr++J1/4jB+AJVcNDiQ/KelgtPEM6mkE=;
        b=hg89OYZD/PRdcXO/SkftT35KcTIGl5bFVHW9Q0/0hhQyws08tsJf/3OC4zLatKpQwH
         62cAXCoBQHyzfjDVkZScCq1M06LhQNqsWjSjFt8bisIVVZjLStClPcll2cVgcykHMSTm
         R+HY8O9Myl+AD8iJEQjefRw+TajP8f4MNZm5NWfHd2qQFQfgYzsiWs+EltawSs0TZvca
         61if9qdBPj+StQJKplWG9DP/BZ4hjbVFvGqya6xqZ/aGGb853ldsDlpbm8xSeYGQRO03
         nSlJVx2D2q+J9UtYOxrN6auvQS/wyEIV1jAmDE1dqphwXsYS32631Va89ztKZPPsTLJp
         LsoA==
X-Forwarded-Encrypted: i=1; AHgh+RpLsmLEKk7yRZQKyygHqzRj0AW/tsnnfhV6548jG/hAUbGCiDUwADO2A0o7YVUV/wruyv0WhfPF5cDV@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBVeuGlbRjXxiG1MXoQOguv+orzzXorRsQYrntSs7X7enSnr6
	NC5+TfohNyOycunKzlQskdb1sfX7ieTjd47xe0Jk6YkHKu/KdnsuyzWWCht2qRD8oPM=
X-Gm-Gg: AfdE7cmODwXkxST7iGglKMd5x1240FgZmCVvOzfubCpvnREFPyWv60ou17MsaAqa6Ty
	aGpGmSTHHSQ3mc35EeEsF09WRpWeOSw79MfI0AFdqlG5te0nYeVNoPMErEJCkaBSknxlh3F+85C
	EC+gGFBkFtI2TMOoJ9wTYghV5C9nv5NwmR3NTcKLBxOuS+Z51zmfDn8/QGCqtboNcFgMubZBZ9M
	OkPrTL09eNQQTTl9W0dChJ+JIGprA1RMjw6WKLoVAMBvi6CEFcO3KtKyST/qLP/Pu36XKT1kSSz
	F1wLIFV3nE/utX4lOVBCQFPao0fJ6tBZ7RODm2AW8AVyNVJ6aveSs3CXexhhEjgtnalgs6McUll
	Skl4GE7qKSRxVENe25deyO0Q+4EoNYbceJQlYLPGZ0YmNfNyLqCywDtVO1QmThPtbCMjWXM0=
X-Received: by 2002:a05:6214:2583:b0:8fd:6e12:9711 with SMTP id 6a1803df08f44-8fec49c8c2cmr84469526d6.63.1783612092026;
        Thu, 09 Jul 2026 08:48:12 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0347sm20381976d6.2.2026.07.09.08.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:48:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1whqyw-000000057JY-2UoE;
	Thu, 09 Jul 2026 12:48:10 -0300
Date: Thu, 9 Jul 2026 12:48:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Serhat Kumral <serhatkumral1@gmail.com>
Cc: yanjun.zhu@linux.dev, dsahern@kernel.org, leon@kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com,
	zyjzyj2000@gmail.com
Subject: Re: [PATCH] RDMA/rxe: rework per-net tunnel socket lifetime to fix
 refcount underflow
Message-ID: <20260709154810.GK118978@ziepe.ca>
References: <1a4f521b-796e-46a4-8992-dc5955e463b4@linux.dev>
 <20260706181404.6687-1-serhatkumral1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706181404.6687-1-serhatkumral1@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22967-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:serhatkumral1@gmail.com,m:yanjun.zhu@linux.dev,m:dsahern@kernel.org,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com,m:zyjzyj2000@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,8c9eede336e3a843750e];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 618297332AC

On Mon, Jul 06, 2026 at 09:14:04PM +0300, Serhat Kumral wrote:

> For that remaining window, instead of rtnl_lock() or a global mutex,
> v2 makes rxe_net_del() idempotent per device with a test_and_set_bit()
> in struct rxe_dev, so only the first invocation drops the pernet
> socket references. This keeps the serialization at device granularity
> without adding any global locking. If you would rather serialize
> dellink itself, I am happy to respin that way.

I'm not taking any bodges for this namespace stuff until it is
rewritten not to use net ns notifiers.

sockets need to be linked to GID entries and take their namespaces and
addressing from the gid entries.

This will fix all the lifetime issues.

Jason

