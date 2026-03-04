Return-Path: <linux-rdma+bounces-17452-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DopFz2Gp2m5iAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17452-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 02:09:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CB31F9153
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 02:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80F6F3064E9F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 01:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2E305046;
	Wed,  4 Mar 2026 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoUMKuth"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A139FD9;
	Wed,  4 Mar 2026 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586550; cv=none; b=gQ/qT0S09NDYFz/0g1k4ZQKF1jSmr1rDnri7wNl+QWub5xo66/KN3u0v4ukoGwmUgG3j+xpPBiHMqgwOu1lZu6FIfz2sKZeHr2bq5Tal2D/0hJNnOyODBvIIFNRke5CamT7yDZNO8lxNoRL+naCt2Cwi4Pv5mwJiQiAfrWikZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586550; c=relaxed/simple;
	bh=oJ7H/Fg75E5Kzd69Xj5N2aHTw22/7ssgPNPD9zCo4Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLSM+WGpulfWveLI0o4o1Gfk88GMddhA23ViFJ5SYwOZKbxiDak+RXseh9g208dLkH7OWQI/+0K/CDHMEpryRnB8IPsKFSKom0aWe7rYltkjzZSoVLu6nqBSEJXC/KVhZORTvTWA5iHBN70gU4bbDo9KUEx1qtr2PSSWXgcLXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoUMKuth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A519C116C6;
	Wed,  4 Mar 2026 01:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772586549;
	bh=oJ7H/Fg75E5Kzd69Xj5N2aHTw22/7ssgPNPD9zCo4Bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BoUMKuthe9Bgwfmljqqs2QiIrb5l3nGXqd3MVBuH9pk9MjQxXYCSyvMVml8RudKp2
	 VRy1yEf76NEZ70+lp7e/JhnIJFYaEZaTnlewRvqTJi97OOFakCzXO/ahdLxihU1NIF
	 ZZT5sVFWOYvATpJVh1FmdwORfDtzpAXLVKmcaVfwJ+4QpdJblD96djijIssiYHTXe6
	 /gHzMOpIUDEN0Ffk0Tk6Kwwc2OZ/A2qBX4WLowm57MCWTq8iBOEbmWcK/aRllB1fsj
	 S4xJjq2Q52MtoNz/DrEnMlL6vvvSFQ1DXH9gpZto7xlgfa01eAOXakAX2bYI41bWaL
	 3qiP+n/9w4dSw==
Date: Tue, 3 Mar 2026 17:09:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>, Dust Li
 <dust.li@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia
 Zhang <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
 <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, oliver.yang@linux.alibaba.com, pasic@linux.ibm.com
Subject: Re: [PATCH net-next v2] net/smc: transition to RDMA core CQ pooling
Message-ID: <20260303170908.64a5070f@kernel.org>
In-Reply-To: <20260302063737.4393-1-alibuda@linux.alibaba.com>
References: <20260302063737.4393-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B6CB31F9153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17452-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon,  2 Mar 2026 14:37:37 +0800 D. Wythe wrote:
> The current SMC-R implementation relies on global per-device CQs
> and manual polling within tasklets, which introduces severe
> scalability bottlenecks due to global lock contention and tasklet
> scheduling overhead, resulting in poor performance as concurrency
> increases.

does not apply, please rebase & repost
-- 
pw-bot: cr

