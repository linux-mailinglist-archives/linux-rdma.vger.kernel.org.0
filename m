Return-Path: <linux-rdma+bounces-19063-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNGcH/EF1Gk9pwcAu9opvQ
	(envelope-from <linux-rdma+bounces-19063-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 21:13:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CE43A6883
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 21:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0889300DEE2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A443396D0D;
	Mon,  6 Apr 2026 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Jn7UFP/I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416E39659F;
	Mon,  6 Apr 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775502830; cv=none; b=WLfNM96t0qx7UKN6mlgjyiAvIkLI3x95HayG4VRBH0rWG8A+W3f724tth+0MeAUo/cc7SvYgBmTf3fELRwQ4KDaSQXIVE70HyuNrcVjKGhuyCY9y59YXPqW+GaCqRbT4kvdqbOiCjjd/BiP5PL9NxV0MLICOSRO3+aLFGFFJKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775502830; c=relaxed/simple;
	bh=QaqzdCmNeCrAhm1LRm0CqpLr2/dvKjSnKZXyn/9GohU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=utJKwTOGXj6L1ijJtPAMu6qGfxv5ovYRTtPzpx/zxK4isVVDvmfVelbouARj/0U9M7PuUcI1xpPBljBJtawA7/MAhzK4NZi5EXljTJFGCJQrsL9rM2zLiaqIh98DY9F6kuz6OxJqUhDt1F3EzL+B0M2iCQiwmYpil+BobvSvGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Jn7UFP/I; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CAB0A588B;
	Mon,  6 Apr 2026 21:13:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775502826; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uVV2KW2xgBvLgMVhejwFXDN1mbWxSYXamGXWza39rVA=;
	b=Jn7UFP/IPZrV2HA7qyedqJFoZsZwKQP47IoCc+HAOgyfbSc9fEKK9lO1Gj9sQyr/lEBe1c
	rgZQgaCFL94ZUwW15o96PPPRZ9twjLyXZh03UAr6QWoHLamN/Cbcq0mH61qtmkqk/JjmbF
	jh1uJf1UTzEVrfrs6gAutOVSRbCf6StjRNu7F0W5HfyTWsBoXGEJn/KN0wMlKYdisBzuEh
	b7w8T0Qh081GbXeBYeF7YBSw+pm9kBpz9NTatkPHkKkyDiNIUjnKSqMpXUnxT5U3htDZcH
	QfTPc0GfdRRz1Kw3ym+SBUjwEvyXggUCwuqTslLOkG/5fxJ5LBTJTH3KyIRIIg==
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Apr 2026 21:13:43 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Cosmin Ratiu <cratiu@nvidia.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Lama Kayal
 <lkayal@nvidia.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Carolina Jubran <cjubran@nvidia.com>,
 Nathan Chancellor <nathan@kernel.org>, Daniel Zahka
 <daniel.zahka@gmail.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Raed
 Salem <raeds@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next V2 4/5] net/mlx5e: XDP, Use a single linear page
 per rq
In-Reply-To: <e0ac9755-fd49-4620-92ce-0f5e4203a95e@nvidia.com>
References: <20260403090927.139042-1-tariqt@nvidia.com>
 <20260403090927.139042-5-tariqt@nvidia.com> <adH5yAsPJ8rNgT0k@x13>
 <20260406084344.5d315f01@kernel.org>
 <e0ac9755-fd49-4620-92ce-0f5e4203a95e@nvidia.com>
Message-ID: <d7c247276e39d88e1cd9d86e21c74779@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19063-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 13CE43A6883
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6.4.2026 18:31, Mark Bloch wrote:
> On 06/04/2026 18:43, Jakub Kicinski wrote:
>> On Sun, 5 Apr 2026 08:08:06 +0200 Dragos Tatulea wrote:
>>> sashiko says:
>> 
>> Thanks a lot for reviewing the review! It takes a lot of maintainer 
>> time

> [...]

> 
> For example:
> 
> “Before posting, authors could run a recommended baseline of review 
> tools,
> where available, to catch obvious issues early. During review, tools 
> such
> as review-prompts and Sashiko may be used to assist the reviewer.”
> 

There is already https://netdev-ai.bots.linux.dev/ai-local.html which I 
found really helpful.
If this is still the preferred approach, I could draft a patch to add it 
to Documentation/process/maintainer-netdev.rst

> Mark

Thanks
Nicolai

