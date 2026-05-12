Return-Path: <linux-rdma+bounces-20433-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK1jA4dxAmowtAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20433-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 02:17:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA286517CCE
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 02:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47AB330233F2
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 00:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DB1E5207;
	Tue, 12 May 2026 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzZMWpwX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC02347C7;
	Tue, 12 May 2026 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545028; cv=none; b=AwNa1A06TNZTR2Y1l9wivtQdLn+OH2sXmpCs9iAKx1cT+jrQtxSHLGJCq95yM7iZGFLnwiIUTW633VvoeSC/ycG3+R138AjXtxflj419Qc/yYSi2JmpPCy63iGJjAbc0b56kZRTeShTbzGMNLHzditgG9mBAOJCz6GjbREW11U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545028; c=relaxed/simple;
	bh=AVJXFKj7NdF68q4kK2jnhiaQ4jje6q+LVkK3WlurYK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/bdA/6TR0nSps2T4qvlDUDsbOg2l6DWEHOPoV8XDdnHgVH5H360D+3d65SrBoR8ri102gDXe4gLYhkyHnxeEBdpKjdB9qzJk9xeGUhdLG5/TNp3wx9X4fwydfgXQxEDq3ypI8K4jkkLji4aSsR0eXEdyYUhRF5vKcuHIKU2Xpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzZMWpwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99219C2BCB0;
	Tue, 12 May 2026 00:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545027;
	bh=AVJXFKj7NdF68q4kK2jnhiaQ4jje6q+LVkK3WlurYK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IzZMWpwX7rHsTDQiuoIhU6sSerlBb2nymO9j1bNwiCVybt6s/UbYEpTIY/EATERC4
	 wzGVL8p1B7Erdpk0RGKHoSIyqDuQgLPOa9pp1ba8pX3DB30G7ooSsdfzDNuR5k48xP
	 4BL8bWNo0HYzvhW/N6QAQJXVxJOUKlkajHAWLBfMli+Ao64OqG8AqUEd8HCa7w+fvi
	 mSW6bqvxi4kwrTBGX3vpIx8Oximw4qvim5JCkvSgFFPxPZvQh2nnOeaFzt2ow+I6Uv
	 vSuTzjmQNSurDmRCFKZ0pY7oJW4GK5isL0RsS+BErDXXnL5EZpIUTcGOzMxqR5U0bO
	 x/aqwZaCzSEfQ==
Date: Mon, 11 May 2026 17:17:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Spencer ?? <spencer.phillips@live.com>
Cc: Allison Henderson <achender@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "rds-devel@oss.oracle.com"
 <rds-devel@oss.oracle.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net/rds: fix zerocopy page ownership on partial
 copy failure
Message-ID: <20260511171704.380f7537@kernel.org>
In-Reply-To: <CY8PR11MB70846C6CD3C93572660CCC40EA3B2@CY8PR11MB7084.namprd11.prod.outlook.com>
References: <CY8PR11MB70846C6CD3C93572660CCC40EA3B2@CY8PR11MB7084.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AA286517CCE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20433-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[live.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,live.com:email]
X-Rspamd-Action: no action

On Sun, 10 May 2026 21:20:58 +0000 Spencer ?? wrote:
> From: Spencer ?? <spencer.phillips@live.com>

Your name is mangled in the From line, which git uses for the Author.
Please fix and repost.
-- 
pw-bot: cr

