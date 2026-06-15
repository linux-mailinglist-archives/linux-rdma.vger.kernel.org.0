Return-Path: <linux-rdma+bounces-22222-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V1PUJp2FL2owBwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22222-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 06:54:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C780683585
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 06:54:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=e1VpKlxG;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22222-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22222-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4C0C3001FA8
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 04:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726652DFA3A;
	Mon, 15 Jun 2026 04:54:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395213A1DB;
	Mon, 15 Jun 2026 04:54:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499288; cv=none; b=ia1jdpwdx3ABDKLZbjXFIRfHfj7Yb0Wu1EE//eOrjinyCEv5pxef0wkACzb5HMitHInaePs5CTVYDCOjHPPTiadg3aQyoAE5g1l/xG+ad2e5ZE2RODnt9aK+fD51Uoc8vprOmmaSDazoMxNeQ2v1q3NU5VAcR3eeElTU9b3qUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499288; c=relaxed/simple;
	bh=DwI1QGjBl+eFmOOKHqt8cmGm1eswWHvQ465qNrrlpXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=izyYAqEmIrEXF0XrJ3DxiXNam+8V3rN7iCcG73w7m/PdU1rOJ3COtonxknqTrJjBEOwk1mkb++mibidzq4VQzxhMhSx0kxRQPXsBZiztGTrzalNsEEjZyfR4qqRq0CebNDRaaRtLajh5i4I94Bn7Dr+o8wvr0jMibygCAwXFFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1VpKlxG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471021F000E9;
	Mon, 15 Jun 2026 04:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781499286;
	bh=x5U/riXi12CQinv00Fshdw+mxzCpH2LghnOXNQ4N4yE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e1VpKlxGslHv1esBgPVHEP2n7IS7dOTCdCSXIbd4LIT/O/bO5axZwrAbp1NVfY7ZN
	 Fc3IKN1OZTgz1ldrXKxKFeAHjlJDWkqMq63N9qVa+Uaog+W3Dc7ttck95pw6j8ar2Z
	 WKzyKg9oeVOC004RHkOI3EA/ikWSUjT614bYcddx1utWBge8XYnEw0s39xIYrR4gti
	 TFR7gAH7hkJm2dInZ1o2fuPthISv/QYiLIOKT5Zy1qZBndb6qhYbyxbC0jGONhj4ns
	 dfx53IzptDkClrLrLCrFYI11I9HD0CFuxkTd9pGKF95HwbnlKxo2qybxuujFQB+WG1
	 tP9PPx+bRwS1g==
Message-ID: <81a65e76f5524dfae8a644bed887d9461bcbfd26.camel@kernel.org>
Subject: Re: [PATCH net] net: rds: check cmsg_len before reading
 rds_rdma_args in size pass
From: Allison Henderson <achender@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>, "David S . Miller"
	 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org
Date: Sun, 14 Jun 2026 21:54:45 -0700
In-Reply-To: <20260614130725.2520842-1-michael.bommarito@gmail.com>
References: <20260614130725.2520842-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22222-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,google.com];
	FORGED_SENDER(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C780683585

On Sun, 2026-06-14 at 09:07 -0400, Michael Bommarito wrote:

Hi Michael,

Thanks for looking at this.  A few comments below:

> For RDS_CMSG_RDMA_ARGS, rds_rm_size() calls rds_rdma_extra_size() after
> only CMSG_OK(), without checking that cmsg_len covers struct
> rds_rdma_args. rds_rdma_extra_size() reads args->local_vec_addr and
> args->nr_local, so a short control message reads past the copied control
> buffer. The value bounds an allocation count, so this is an
> out-of-bounds read in the kernel, not a leak to user space, and an
> unprivileged AF_RDS socket can trigger it with one short cmsg.
>=20
> The two later RDS_RDMA passes (rds_cmsg_rdma_args() and the rdma-bytes
> loop in rds_sendmsg())=C2=A0
>=20

I puzzled over this line for a bit since rds_sendmsg doesnt call
rds_cmsg_rdma_args directly.  I think you meant:

"(rds_rdma_bytes() in rds_sendmsg(), and rds_cmsg_rdma_args() in rds_cmsg_s=
end())"

?

Also, note that rds_rdma_bytes() runs before rds_rm_size(), not later.
That ordering matters as noted below:

> already reject cmsg_len < CMSG_LEN(sizeof(struct
> rds_rdma_args)); only this size pass does not. Reject it the same way.
>=20
> Reproduced under KASAN on QEMU via a KUnit driving the real
> rds_rm_size(); the out-of-bounds read is gone after this change.
>=20
> Fixes: ff87e97a9d70 ("RDS: make m_rdma_op a member of rds_message")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> A short RDS_CMSG_RDMA_ARGS placed at a page boundary makes
> rds_rdma_extra_size() read the args fields past the allocation:
>=20
>   BUG: KASAN: slab-out-of-bounds in rds_rdma_extra_size
>=20
> an 8-byte read. On stock it faults; patched it returns -EINVAL with no
> report. Controls (well-formed args; a short cmsg with args still in
> bounds) drive the same pass cleanly on both trees.
>=20
> No in-tree selftest exercises rds_rm_size(); I can send the KUnit suite
> as a separate net-next patch if wanted, kept out so the fix is not held.
>=20
>  net/rds/send.c | 2 ++
>  1 file changed, 2 insertions(+)


The code change itself looks ok, but it's not really a bug fix.=C2=A0
rds_rm_size() is only called from once place: line 1290 in  rds_sendmsg().
Here, cmsg_len is already verified by rds_rdma_bytes(), which performs the
same cmsg_len <  CMSG_LEN(sizeof(struct rds_rdma_args)) check for
RDS_CMSG_RDMA_ARGS before rds_rm_size() ever runs.


        ret =3D rds_rdma_bytes(msg, &rdma_payload_len);    <------------ cm=
sg sanity checking done here
        if (ret)
                goto out;

        if (max_t(size_t, payload_len, rdma_payload_len) > RDS_MAX_MSG_SIZE=
) {
                ret =3D -EMSGSIZE;
                goto out;
        }       =20
               =20
        if (payload_len > rds_sk_sndbuf(rs)) {
                ret =3D -EMSGSIZE;
                goto out;
        }      =20
                       =20
        if (zcopy) {
                if (rs->rs_transport->t_type !=3D RDS_TRANS_TCP) {
                        ret =3D -EOPNOTSUPP;
                        goto out;
                }
                num_sgs =3D iov_iter_npages(&msg->msg_iter, INT_MAX);
        }
        /* size of rm including all sgs */
        ret =3D rds_rm_size(msg, num_sgs, &vct);    <-------------- rds_rm_=
size only called here
        if (ret < 0)
                goto out;

A KUnit test directly calling rds_rm_size() might run across an OOB if it
shortcuts this pre-check, but this isnt something a user could reach throug=
h
sendmesg since the rds_rdma_bytes() check would reject it first.

The patch is still a reasonable hardening fix, it just shouldn't be carryin=
g
a fixes tag or targeting net.  Please re-target this patch for net-next ins=
tead
of net, and drop the fixes tag.  No need to cc stable.  We should also clar=
ify
the commit message as noted above, as well as remove the line about the AF_=
RDS
socket.  Other than that, I think it's a good change.

Thanks for working on this!
Allison


>=20
> diff --git a/net/rds/send.c b/net/rds/send.c
> index d8b14ff9d366b..6ca3192b1d8af 100644
> --- a/net/rds/send.c
> +++ b/net/rds/send.c
> @@ -967,6 +967,8 @@ static int rds_rm_size(struct msghdr *msg, int num_sg=
s,
>=20
>  		switch (cmsg->cmsg_type) {
>  		case RDS_CMSG_RDMA_ARGS:
> +			if (cmsg->cmsg_len < CMSG_LEN(sizeof(struct rds_rdma_args)))
> +				return -EINVAL;
>  			if (vct->indx >=3D vct->len) {
>  				vct->len +=3D vct->incr;
>  				tmp_iov =3D
>=20
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8

