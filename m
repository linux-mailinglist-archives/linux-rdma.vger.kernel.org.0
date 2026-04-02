Return-Path: <linux-rdma+bounces-18930-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPqGE8q6zWnqgAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18930-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 02:39:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A79A33820B5
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 02:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60443028B18
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 00:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EACA221F1C;
	Thu,  2 Apr 2026 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBOt7xs7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B21146A66;
	Thu,  2 Apr 2026 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090216; cv=none; b=HG6KOzNU+9z/s0eKZSqvqAvgOSVBFa+2uSrNPHHmT/8f9IhMgmsW51fe9Pjm2sqG7JLVBhpTR05vY6036dUwiPqvmvvagYoDwbn5Pk+jYPk24x8QHKedyZnrq/qJJkFtQbx8gGNbXaruKYaTyNv2GxUsRPSIJE/uIiJZKTUQ+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090216; c=relaxed/simple;
	bh=I9XmIlaaGS8O9PlHryu2TNe0bSVMKDY9S66r55Vddco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1uEad5lC7yANpmfIRbk8fMcAmgm8Eyuj6qIugVRBF0JDO3i6mDEWg1t5XqbbT+mE7bdiK8ULjs8GkgaOWZ16I0KXNfjFDtmw7EQYBe/iq98iZy/h2rO0mWDEqrjB1jjNb2YlM2u4z1mQ/ivQvnf9xtVHL9LnV8j9/V8fiHG4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBOt7xs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2C8C4CEF7;
	Thu,  2 Apr 2026 00:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775090215;
	bh=I9XmIlaaGS8O9PlHryu2TNe0bSVMKDY9S66r55Vddco=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SBOt7xs7Poe03PP+mL0ZWGG2xRoupRJ3YPgwe/jnpdM+SwGzqyNYtiFG/Gi8FTWuV
	 X0QulQvo1pjvaJcbdJGKdVnQdFcXzr4BwZWQ1W1wXOZR0/oDLVWdmTL1rcCfcea3E5
	 EP6BhXg0PnH7Jt9vl+rLurMLEydndp2+YoOj096pgu53+MzLB6GUueBju/dKb3Nm9C
	 JP3zrsrN2sCyRNDN+LAM+m8m1zp+UjB/EKqYinSaLeOioIVcSKxkym5gqWVuNa8+z6
	 qJUxszQRAPZcu3s3lsTAZOiCL+c8wJ4C/Ap2poJVIM1uxNldeZXpDBIiOJGyPdCdlb
	 aZr5G87hXJ6DA==
Message-ID: <b34739e6a4ac19fe4d8f361177056e3bdb30fa71.camel@kernel.org>
Subject: Re: [PATCH net] rds: ib: reject FRMR registration before IB
 connection is established
From: Allison Henderson <achender@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>, "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Date: Wed, 01 Apr 2026 17:36:53 -0700
In-Reply-To: <20260330163237.2752440-2-bestswngs@gmail.com>
References: <20260330163237.2752440-2-bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18930-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A79A33820B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-31 at 00:32 +0800, Weiming Shi wrote:
> rds_ib_get_mr() extracts the rds_ib_connection from conn->c_transport_dat=
a
> and passes it to rds_ib_reg_frmr() for FRWR memory registration. On a
> fresh outgoing connection, ic is allocated in rds_ib_conn_alloc() with
> i_cm_id =3D NULL because the connection worker has not yet called
> rds_ib_conn_path_connect() to create the rdma_cm_id. When sendmsg() with
> RDS_CMSG_RDMA_MAP is called on such a connection, the sendmsg path parses
> the control message before any connection establishment, allowing
> rds_ib_post_reg_frmr() to dereference ic->i_cm_id->qp and crash the
> kernel.
>=20
> The existing guard in rds_ib_reg_frmr() only checks for !ic (added in
> commit 9e630bcb7701), which does not catch this case since ic is allocate=
d
> early and is always non-NULL once the connection object exists.
>=20
>  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>  RIP: 0010:rds_ib_post_reg_frmr+0x50e/0x920
>  Call Trace:
>   rds_ib_post_reg_frmr (net/rds/ib_frmr.c:167)
>   rds_ib_map_frmr (net/rds/ib_frmr.c:252)
>   rds_ib_reg_frmr (net/rds/ib_frmr.c:430)
>   rds_ib_get_mr (net/rds/ib_rdma.c:615)
>   __rds_rdma_map (net/rds/rdma.c:295)
>   rds_cmsg_rdma_map (net/rds/rdma.c:860)
>   rds_sendmsg (net/rds/send.c:1363)
>   ____sys_sendmsg
>   do_syscall_64
>=20
> Add a check in rds_ib_get_mr() that verifies ic, i_cm_id, and qp are all
> non-NULL before proceeding with FRMR registration, mirroring the guard
> already present in rds_ib_post_inv(). Return -ENODEV when the connection
> is not ready, which the existing error handling in rds_cmsg_send() conver=
ts
> to -EAGAIN for userspace retry and triggers rds_conn_connect_if_down() to
> start the connection worker.
>=20
> Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registrat=
ion mode")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/rds/ib_rdma.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
> index 077f7041df155..2cfec252eeac2 100644
> --- a/net/rds/ib_rdma.c
> +++ b/net/rds/ib_rdma.c
> @@ -604,8 +604,13 @@ void *rds_ib_get_mr(struct scatterlist *sg, unsigned=
 long nents,
>  		return ibmr;
>  	}
> =20
> -	if (conn)
> +	if (conn) {
>  		ic =3D conn->c_transport_data;
> +		if (!ic || !ic->i_cm_id || !ic->i_cm_id->qp) {
> +			ret =3D -ENODEV;
> +			goto out;
> +		}
> +	}
> =20
>  	if (!rds_ibdev->mr_8k_pool || !rds_ibdev->mr_1m_pool) {
>  		ret =3D -ENODEV;

Hi Weiming,

Apologies for the delay, this looks looks fine to me.  Thanks for catching =
this.

Reviewed-by: Allison Henderson <achender@kernel.org>


