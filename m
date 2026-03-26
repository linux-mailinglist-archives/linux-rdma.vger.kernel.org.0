Return-Path: <linux-rdma+bounces-18702-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ17H9ICxWlZ5gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18702-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 10:56:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18233332C19
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 10:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C1153043BED
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5C539B951;
	Thu, 26 Mar 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Lx5lLr5z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33A399009;
	Thu, 26 Mar 2026 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518579; cv=none; b=FRnPI5lCTjq71YD95DLLDbIENPt9MtQtWx88p2uYxnZ9dO/jfPikdtlPoe64Lif4r/8+/FlDiCv489bYHEG7IuebXBpGwDUY1xMYRS7qEJ528/qnQZM96GYdEuw1FTQCzkF6LuhRw//dnwoysrIK2Lz5bUNCJHIq06BpWsBITqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518579; c=relaxed/simple;
	bh=Hcv3BUfw7txA6r1Uh0brIkEpZiRcbZGhRP2mGVojuDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSOr15c7bXLPBFy60o/PxUF5Os8+qx2q8nC4goAWe7e7QvEsVoIhGuVVn31xvhwwRgiLqURIIWEjQyLjYQL1Gw3p6jD0i+pNyiv+HHmIgvDX+Vqnqq8Sl/BQ1Ci/WCpKOdxE97GxQY0pfeOVnAa+Zh+ED8UNM0nNxMlkBn5MBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Lx5lLr5z; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=HcQDeEXUnBzf8mzWuF6SYQrZaKhw3Qa8vqAtbSFc0L4=; b=Lx5lLr5z64BFlzlHMTBnFoVN/t
	WgrBdnb8ho5fX46P8yJoRr3fKAFe1N5ektWSviptYWri9+DCdCN3qW6JE6ch4VWin0wMfWJZI+d2B
	dfDjVMOtTihKKeJC5iVVH4AlftYrMnZK3OubHEO4QIj0RDaNwEIjWHaPN1g1NKu/DawENBeBzJJoo
	Y1LxmXSkT14X6wS/lukC3ejt7dbYaPb5Rd5iVzHOVKIXeQ16fpsUVP+5UfW2U1poq4PzYvWAmI1/Y
	GhY0bPYwzMGArS31EVTh5sjcC5k10m3JUXVnlBd1rVh7sXLf1SqfkllsA1m/fyvz+t8HIF9YXRoEs
	nrROrD8A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w5hLB-009lLm-UG; Thu, 26 Mar 2026 09:49:26 +0000
Date: Thu, 26 Mar 2026 02:49:18 -0700
From: Breno Leitao <leitao@debian.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Naveen Mamindlapalli <naveenm@marvell.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Danielle Ratson <danieller@nvidia.com>, Hariprasad Kelam <hkelam@marvell.com>, 
	Ido Schimmel <idosch@nvidia.com>, Kory Maincent <kory.maincent@bootlin.com>, 
	Leon Romanovsky <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/12] ethtool: Add MAC loopback support via
 ethtool_ops
Message-ID: <acT_i_93YkRB_GwA@gmail.com>
References: <20260325145022.2607545-1-bjorn@kernel.org>
 <20260325145022.2607545-8-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325145022.2607545-8-bjorn@kernel.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18702-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,marvell.com,redhat.com,nvidia.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18233332C19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 03:50:14PM +0100, Björn Töpel wrote:

> @@ -284,20 +305,31 @@ static int loopback_dump_one_dev(struct sk_buff *skb,
>  {
>  	struct loopback_req_info *req_info =
>  		container_of(ctx->req_info, struct loopback_req_info, base);
> +	/* pos_sub encodes: upper 16 bits = component phase, lower 16 = index
> +	 * within that component. dump_one_dev is called repeatedly with
> +	 * increasing pos_sub until all components are exhausted.
> +	 */
> +	enum ethtool_loopback_component phase = *pos_sub >> 16;
> +	u32 idx = *pos_sub & 0xffff;

Consider introducing macros for these bit operations to improve code
readability. Named macros would make the shift and mask operations more
self-documenting and facilitate future changes, if we eventually get
there.

