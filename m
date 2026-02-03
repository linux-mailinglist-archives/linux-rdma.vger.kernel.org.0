Return-Path: <linux-rdma+bounces-16387-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5Z5gGwB0gWnPGQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16387-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 05:05:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF4AD4486
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 05:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CECA4302C34D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 04:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1332D2E7F22;
	Tue,  3 Feb 2026 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUQEEwoL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92491547EE;
	Tue,  3 Feb 2026 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770091491; cv=none; b=ElN6ZigVYQxRh51GMOev0j1WlXA4a9vctnsL5XzObHjhFb/3JxvkA/dAWVCOgGc2Yle2Z3HDGaXB1JkxfItS4rHiP2FIXEaST4vrxve28GjS42BIqEmXpyYdaCaaGBQpOMBUWK+QBuqTBw9fBfoNH8RFdvXLvKVkE93DMx6Zg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770091491; c=relaxed/simple;
	bh=vUIb9XltpfKWCkFD7i+hZie5duQHouVl0PZYkTgvvKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5NLVNIr4XmxeULNXPZsGhtOBVFMbmbFRizNbkWG5MKrvEF6EwmDBLmCOlciNOc2k/7Eg4VERIXEbVEkAZgJLw905NrsfeLN5y21mzXv+86f2snwJ6qp1IhXKt7m1kz6KQXQlmsECElZQ0u3NJMMERJ3zdE3T4jvUYKxSpLu0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUQEEwoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F72C19425;
	Tue,  3 Feb 2026 04:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770091491;
	bh=vUIb9XltpfKWCkFD7i+hZie5duQHouVl0PZYkTgvvKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jUQEEwoLc7ewgVTQbtfouaegtLjAyOnje3a0/yW9Sz3Q0QiinVRadQakBaJp43oq5
	 5BdIblsPd0kPhyTsZKxBh6oCJXue2YPrOtFZCsyWIDglPmS2+1Y7YQTJ9R6L7qd89L
	 ENjmN3t/qabTr4K26YOFaXv03NI3ybP1farAsD9ZoASkza2Rh/Kse03ZMESIfLpxqE
	 ys0tccI2WlY5k/rr7WDl3K655ZX72ieWwHmcNMqP6eG6BJEj3pGQnwVdzmJSqbWvd4
	 U7UvGZFuZJTn9pxtcbn3KMvcEO6gWDGrK6yw4jYjsqUQy3qWiDwDtMU0KufU/Eosiq
	 1awEIRNU19QxA==
Date: Mon, 2 Feb 2026 20:04:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
 <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 09/14] devlink: Allow rate node parents from
 other devlinks
Message-ID: <20260202200449.775fabe9@kernel.org>
In-Reply-To: <20260128112544.1661250-10-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
	<20260128112544.1661250-10-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16387-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEF4AD4486
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 13:25:39 +0200 Tariq Toukan wrote:
> +EXPORT_SYMBOL_GPL(devl_rate_lock);

Why is this exported? There is no caller outside of core..

