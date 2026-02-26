Return-Path: <linux-rdma+bounces-17195-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB2jE2+4n2mKdQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17195-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 04:05:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E37E91A04FA
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 04:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C4033022045
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 03:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888D3296BDA;
	Thu, 26 Feb 2026 03:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOvRvhvM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15212D21B;
	Thu, 26 Feb 2026 03:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075116; cv=none; b=FyqBh1X18SiV+NHZm2CdwrXHkFdcZPrLKEs0hslTUzh751OTLHdKIM1F95KpVvaHhQYl9kmiGSFTo47d/zLzbFCgLFagnKC6EjrJfRC1AEveYGFf1kFeqC95cxLs7LjZPZvhoG0ST9UqZlcdSo+8LCIii4dLfnjLhYiMQCud7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075116; c=relaxed/simple;
	bh=Jbe6zqtLhmZkH+KY7ioNCubyyvB+h7ibTPgsqJ5W360=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIKfBNfpT2Y3ezWPuAUQnrtpZzC1onmH2ist7bkLOvFljUYbMdqgZ2SDfQyj3gA+6RMZsu1qAXqrLSnq9oJg4BoV2eW31yhF9d5gmYeEg8pwXSLz4JbmKtDbI/g5hsn+cO6brJobigBLtxsCWi5qPXDkrcLY9hONFP5uJRr9+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOvRvhvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECABC116D0;
	Thu, 26 Feb 2026 03:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772075116;
	bh=Jbe6zqtLhmZkH+KY7ioNCubyyvB+h7ibTPgsqJ5W360=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XOvRvhvMyHKPwbDcCh8CTKU+ggWjGTNADQTWr6yno8gCz2Gw1dti3pafYLjB2L2Dp
	 Ug0GgdeJd/mivZZWR8YcWKfS3CuUnIZTzUyVZG27txnrsM9jDtBHkEn34xc+YJ0rmk
	 AzuqhkD0Pekr4lDj4WBk5sPCoqSxXPIrPMvAKttcgAdhojN5z7ZUEt1nSlZYXVF60+
	 hHjMz21YbXFFnxfhR+p31ENrp0PeWxNx7YRp5Eye7uTD5GXNA2vomc/hlgXq/beCjk
	 9mvC1SHBypCHtopAoKKR4N705525ZvOUzCx4UJGWwrQyBP5MlHMuJvz7uaMSevBheZ
	 cFiwjoygjnXrQ==
Date: Wed, 25 Feb 2026 19:05:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "kexinsun@smail.nju.edu.cn" <kexinsun@smail.nju.edu.cn>
Cc: Allison Henderson <allison.henderson@oracle.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "yunbolyu@smu.edu.sg" <yunbolyu@smu.edu.sg>, "davem@davemloft.net"
 <davem@davemloft.net>, "ratnadiraw@smu.edu.sg" <ratnadiraw@smu.edu.sg>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "julia.lawall@inria.fr" <julia.lawall@inria.fr>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>, "xutong.ma@inria.fr"
 <xutong.ma@inria.fr>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] rds: update outdated comment
Message-ID: <20260225190514.01a905d7@kernel.org>
In-Reply-To: <2e555525ab0bcec255c9c73a8457ba4a9466ee6e.camel@oracle.com>
References: <20260224020720.1174-1-kexinsun@smail.nju.edu.cn>
	<2e555525ab0bcec255c9c73a8457ba4a9466ee6e.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17195-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E37E91A04FA
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 03:03:10 +0000 Allison Henderson wrote:
> Thanks for the catch.  Just one small nit:  Your patch should specify the=
=C2=A0target
> branch, version and component like this:
>=20
> [PATCH net-next v2] net/rds: update outdated comment in rds_send_xmit

That's right, please try to remember the tree name in the future.
Since net-next is our default tree anyway, there's no need to repost

