Return-Path: <linux-rdma+bounces-17833-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EuyCmM9r2mDSgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17833-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 22:36:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77614241C91
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 22:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63DB2301B720
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 21:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0F368960;
	Mon,  9 Mar 2026 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfXAGRoa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ADD34D392;
	Mon,  9 Mar 2026 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773092002; cv=none; b=jeC/R41SuB0aiW89YhdP/SKQUiNSiM2OS4zh/8sTs4z9pccU/FNACuGhWzPAEHGyHqHRMWK56tMdR4p6cAEXU3X50tcZlTksCyIbwIb0WjCEtK+W57BzDFCjuCNW8Ci9Z+1xjeix2+8pXxwYnJRnWpHunpSnakPqrdo8kcgNllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773092002; c=relaxed/simple;
	bh=Vh1+RU+c7dqwjx1AepujXslb7COs6f1ooMHYXz5ni5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JckefipZO4BTVx74zKr0dHNgwY4IBA+nC2ZcuOuV9UevlJStTLlcXsqZeRX981vH0yxZ/mq+Ij0LciLPb02hIEGTPez6guuEgNiGVifiKt5cjzeSoeWMxjIVpO5Nb5vQljFBC3KGTyB1kgrO+AhTx7CzXeFhJ9BCk9DwkNTTa3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfXAGRoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953D0C4CEF7;
	Mon,  9 Mar 2026 21:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773092002;
	bh=Vh1+RU+c7dqwjx1AepujXslb7COs6f1ooMHYXz5ni5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mfXAGRoa2FiUJIHD4r4HV2krCDP9BFXfMSpTF/zvUtV4uAYkSjMN65YDbU2tzC63H
	 Eoa5OHr1DQ0El9jeOtW+FqfUBQ9bjL565j336880h27y20YMp3o1cDzQgxJ1icoWVx
	 ROkTh6+Mzu4JE8tAu2ZZcjB01zKTn5SnY3EOkpVDAxmCInVQzCAxVewKiszhC/YTJA
	 6LJPYvNjk8w8UMXnfGLfrVYLLhYX+5xiGxu30/KfDy2ThLsHcOOQBAgrfOJrrTaj9+
	 EMSTJZw1zjXiH0JJQpfSlYIIQhe3sUGM7p+gptZH0WCwdtXiNGulsPobSL+Io6EUlr
	 4sin3LSJsbilA==
Date: Mon, 9 Mar 2026 14:33:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
 <shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: Re: [PATCH mlx5-next 8/8] {net/RDMA}/mlx5: Add LAG demux table API
 and vport demux rules
Message-ID: <20260309143320.1cee163d@kernel.org>
In-Reply-To: <a10faf04-36c2-4070-ac8b-86b110e6976c@nvidia.com>
References: <20260308065559.1837449-1-tariqt@nvidia.com>
	<20260308065559.1837449-9-tariqt@nvidia.com>
	<20260308085248.2427feed@kernel.org>
	<a10faf04-36c2-4070-ac8b-86b110e6976c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 77614241C91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17833-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, 8 Mar 2026 20:34:26 +0200 Mark Bloch wrote:
> Thanks for catching this. We=E2=80=99ll address it.
>=20
> Also, I saw IA flagged issues con
> =E2=80=9Cnet/mlx5: LAG, replace pf array with xarray=E2=80=9D.
> Just for context, lag_lock is already a known problematic
> area for us, and we do have plans to remove it. I ran the
> review prompts locally in ORC mode, so I assume I saw the
> same comments as NIPA.
>=20
> So the issue raised there is not really a new one. lag_lock
> already has some known issues today, but we do not expect to
> hit this particular case in practice, since by the time
> execution reaches mdev removal, the LAG should already have
> been destroyed and the netdevs already removed for the driver
> internal structures.

Ack, I haven't looked at the AI reivew TBH.
As usual with known AI flags - should the explanation be part=20
of the commit message?

