Return-Path: <linux-rdma+bounces-22328-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X3bqEbLmMmoP7AUAu9opvQ
	(envelope-from <linux-rdma+bounces-22328-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 20:25:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7F69BEF9
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 20:25:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C8XuDcHh;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22328-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22328-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA196307282B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A52637756C;
	Wed, 17 Jun 2026 18:25:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993D134CF;
	Wed, 17 Jun 2026 18:25:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781720746; cv=none; b=JmpNidqGdgbXbe2qAK6FXTtr1hHKNUVGbEuUeNFDKyYU5PHsBS7Iajrn+dHKHyvzniCq3s5jU9iuwHeoXKfyCJ20hOxDTBPt+tgHzLdFfqAclG5SE2DuKg+ccB90KpxEJ2AIXgH8wsptEC2reTc+iGVBtZpyQTUwDBxvvtyerT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781720746; c=relaxed/simple;
	bh=Insbb4m5VY8Bj9kG0mK0lWc0V7QajkhFlxTizRJpbFo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rzZxJB6aLYtHHda1Xm8X8ERAXEqKMJwywFgmJOWrXTXVZIEqCspNAFMXwcsAjHGeOq1KRTOwLmXgo6hDypOQN2X5TWcthTkxPloxeNYv5XoWyiGxaBkdggK9t4shV6Kjm06dEYRuGca1rhfIPifZL5uQNzF4R3hxk4/o4eZf43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8XuDcHh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519561F000E9;
	Wed, 17 Jun 2026 18:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781720744;
	bh=gUzfZHIg0OEVhvJFDOxsMxKZengHRyuStreBfVTFXyA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C8XuDcHhosoJzRD2ckESYUaPf0+vt3r9mhO8ocToscSWELWHFm0BC/IFhVlvGrKPB
	 kji8yuSt4/QY4XtymobNK0zts/JPKxnx5DMlgfgl30PRLRsrYcs7M/Rh4R1tXvJDml
	 3+YzLxqAaMQWRhot11v0Q0VoGQYtF1di/70ctWNzIWd4mXgpl3LGS67zKL8d2Fm2FM
	 CGGq/57b67x44zacmWROP1a+dpshW07bMFmaKMjf5p1KYVSdmz0CcOGaECbbnbOqAs
	 CwF5H8ROTY9Ii8T5Niy+z0fS2txK4ZQ6tCbi7GVXyGeUN4knsr3rlrbui69qEIxA+Q
	 puVntB5BRj57w==
Message-ID: <2a86a6f10a402ce9e43bd6fd3915694112597170.camel@kernel.org>
Subject: Re: [PATCH net-next v2] net: rds: check cmsg_len before reading
 rds_rdma_args in size pass
From: Allison Henderson <achender@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>, "David S . Miller"
	 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org
Date: Wed, 17 Jun 2026 11:25:43 -0700
In-Reply-To: <20260617023146.2780077-1-michael.bommarito@gmail.com>
References: <20260617023146.2780077-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22328-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,google.com];
	FORGED_SENDER(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDE7F69BEF9

On Tue, 2026-06-16 at 22:31 -0400, Michael Bommarito wrote:
> rds_rm_size() handles RDS_CMSG_RDMA_ARGS after only CMSG_OK() and then
> calls rds_rdma_extra_size(), which reads args->local_vec_addr and
> args->nr_local without first checking that cmsg_len covers struct
> rds_rdma_args. The other two RDS_CMSG_RDMA_ARGS consumers already guard
> this: rds_rdma_bytes() in rds_sendmsg() and rds_cmsg_rdma_args() in
> rds_cmsg_send() both reject cmsg_len < CMSG_LEN(sizeof(struct
> rds_rdma_args)). Add the same check to rds_rm_size() so all three RDMA
> args passes are consistent.
>=20
> This is a consistency and hardening change with no behavioral effect for
> well-formed senders and no reachable bug today: rds_rdma_bytes() runs
> before rds_rm_size() in rds_sendmsg() and already rejects a short
> RDS_CMSG_RDMA_ARGS, so the size pass is not reached with an undersized
> cmsg. But rds_rm_size() reads the args independently of that earlier
> pass, and nothing in rds_rm_size() itself records or enforces the
> precondition, so a reader or a future refactor of the size pass cannot
> tell the cmsg has already been length-checked. Applying the same
> cmsg_len guard in all three RDS_CMSG_RDMA_ARGS consumers keeps that
> invariant local to each and robust to reordering.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
This looks good to me.  Thanks for working on this.

Reviewed-by: Allison Henderson <achender@kernel.org>
Allison

> ---
> v2:
>  - Re-target net-next and drop the Fixes: tag and the stable Cc. This
>    is a consistency/hardening change, not a reachable bug: as Allison
>    Henderson noted, rds_rdma_bytes() runs before rds_rm_size() in
>    rds_sendmsg() and already rejects a short RDS_CMSG_RDMA_ARGS, so a
>    user cannot reach the rds_rm_size() read through sendmsg.
>  - Corrected the changelog: the two sibling guards are rds_rdma_bytes()
>    in rds_sendmsg() and rds_cmsg_rdma_args() in rds_cmsg_send(); the
>    former runs before, not after, rds_rm_size().
>  - Dropped the KASAN/AF_RDS reachability framing. No code change from v1.
>  - v1: https://lore.kernel.org/all/20260614130725.2520842-1-michael.bomma=
rito@gmail.com/
>=20
>  net/rds/send.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/rds/send.c b/net/rds/send.c
> index d8b14ff9d366b..6ca3192b1d8af 100644
> --- a/net/rds/send.c
> +++ b/net/rds/send.c
> @@ -967,6 +967,8 @@ static int rds_rm_size(struct msghdr *msg, int num_sg=
s,
> =20
>  		switch (cmsg->cmsg_type) {
>  		case RDS_CMSG_RDMA_ARGS:
> +			if (cmsg->cmsg_len < CMSG_LEN(sizeof(struct rds_rdma_args)))
> +				return -EINVAL;
>  			if (vct->indx >=3D vct->len) {
>  				vct->len +=3D vct->incr;
>  				tmp_iov =3D
>=20
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8


