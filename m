Return-Path: <linux-rdma+bounces-19310-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PeYHMZs3WlNeAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19310-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 00:23:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB163F3CA0
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 00:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 771FD30398A6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 22:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2339A806;
	Mon, 13 Apr 2026 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDjqQxJC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B604395260;
	Mon, 13 Apr 2026 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118951; cv=none; b=hl8M8D6Oc7Jgf0AiCDO429n1CQItq8bGxP5ik0hR9PkItjeNmOXJ/j6kauA+X4QpfnPA0kKFV/S8FbS0VC2ZpToWcGp36oeBNRuVhlq2V+HRPqUMtVaLToOdhLZiS6ve3saqXgUmFe6T9VcHEZzz9PCIcMz8tB8hGPmm+RQGumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118951; c=relaxed/simple;
	bh=7MNnhu6awipoZFEwSWOsG73lPCDwodGXTLlyv++eaCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okNIEEEBjR7VzEuCceavsgBME7gZteM0cW7B5Z+CYAZlL0XyM0lMNg/xLuMZ8h924hgKxMmeHxfcvaYFqeg9PXujyZ+eNELUFJUu5AAwUCbLCRhndjS2QOldlWTYwj2iMdaDDkTR1pn8v7S9FI7WgH4TwAuzHciviW3d5695/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDjqQxJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33541C2BCAF;
	Mon, 13 Apr 2026 22:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776118951;
	bh=7MNnhu6awipoZFEwSWOsG73lPCDwodGXTLlyv++eaCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hDjqQxJCI31jOecteax8DHHEclhnOZqFYD4y2S5K5Kmvyo/jebSy4LfOfZBHBy7Yz
	 Fs9RGIlTU78DtknmufaOGuh6jC+TqoQOSqTTdol2/mY0CM7gNFLBAOtJnvjsKUbov+
	 uau9y4ghEHze4SNw/TuYnwadaZ2g9nu7v19M12pYrSHU5YR23nmSjK5fMKH/NQXB5f
	 vMQIVSXc9uxg7fZV/gOd1kVV3VBIiOUmqxcWz8nqfItk2+764WbU2iFvTqU4FXkmAG
	 m6QmypcabzXKk9h7CARFq1m91ttym4fRCeR032JRl0IxAA8+B96b+wtX+fq1O2Zm0L
	 E79ZeAVf9FxdA==
Date: Mon, 13 Apr 2026 15:22:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
 <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
 <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
 <horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
 <kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Gerd Bayer
 <gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 5/7] net/mlx5: E-Switch, block representors
 during reconfiguration
Message-ID: <20260413152229.7700b89b@kernel.org>
In-Reply-To: <20260409115550.156419-6-tariqt@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
	<20260409115550.156419-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19310-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DB163F3CA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 14:55:48 +0300 Tariq Toukan wrote:
> A spinlock is out because the protected work can sleep (RDMA ops,
> devcom, netdev callbacks). A mutex won't work either: esw_mode_change()
> has to drop the guard mid-flight so mlx5_rescan_drivers_locked() can
> reload mlx5_ib, which calls back into mlx5_eswitch_register_vport_reps()
> on the same thread. Beyond that, any real lock would create an ABBA
> cycle: the LAG side holds the LAG lock when it calls reps_block(), and
> the mlx5_ib side holds RDMA locks when it calls register_vport_reps(),
> and those two subsystems talk to each other. The atomic CAS loop avoids
> all of this - no lock ordering, no sleep restrictions, and the owner
> can drop the guard and let a nested caller win the next transition
> before reclaiming it.

You gotta explain to me how a busy loop waiting for a bit to go 
to "UNBLOCKED" state is anything else than a homegrown lock :S

Also what purpose does the atomic_cond_read_relaxed() serve?
I haven't seen it being used before.

