Return-Path: <linux-rdma+bounces-19265-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP1vCOhv3GnAQwkAu9opvQ
	(envelope-from <linux-rdma+bounces-19265-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 06:24:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A2C3E743C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 06:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1209302BA32
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 04:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34FE3815DB;
	Mon, 13 Apr 2026 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1VycH9D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D442236F2;
	Mon, 13 Apr 2026 04:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053902; cv=none; b=SGD1au3UDmMj9QHdakhJzIzduIDMv/fC8/6Andx8J+gCghfpXEwnRka0bfTS07yiZRmK5GaCwQL9B43BHvtdaTkz51ikX/uTy4pnNFdxBvFD4rEAOYlvWKCo56fQk2d5LDqs3b1RQ2mP0JRpzzcZXtcj+QPXKjWHNRfWapngQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053902; c=relaxed/simple;
	bh=Pp1iBhC7TFgfIc7ilshuD6S4dh8klyJjX1DuyMqb1lg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sDKMHqTP++RhWSRzgnq4Tepa2a8qFC3HEa/I9q3HkI4a6qt/uA1uhQvZhh45Ihuo3u+IrVy6H+j2EhyVlKkxUNUJsROhaZ6UPG+CHVEOKnC5CRxlvK3nodiBbJ4zQlqk9uje0oeoc7Dmk6d2G0A46A8e1KklQBDRtf5eJ+Tz3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1VycH9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CABC116C6;
	Mon, 13 Apr 2026 04:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053902;
	bh=Pp1iBhC7TFgfIc7ilshuD6S4dh8klyJjX1DuyMqb1lg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=L1VycH9D//HAVXnEEn7S2Lq3SSPuEArn4JAZbpm0rdeB2q769hVODNxrErCnyNEyB
	 mpcYauCqkrSpvPc0RYUhoxbrai/C7QEzL+zR7gbMZ8WX0UEpT1NhLfrwC2NryvND83
	 XpOxr8B2DLiQQdncP3XpzFIN29XTsp4ANKglb7RdcgLdE39Lp9DNU4bW3BG/FGlVt6
	 jy8pqAmVexXJNohStojyCrqNforek7Zr0Sshb19JG7qqLZliyE/NOMtvU6Zh7nXwq4
	 zOigGbpwSscA8z70FGzRIPZD6D1Ru8esxfwsFc6bEUE+PRREE0qIAmhXCctBshsdE9
	 YkfloyO/UgsYQ==
Message-ID: <d29bce267f7ea7c18727304475cc08cd526f2e56.camel@kernel.org>
Subject: Re: [PATCH] RDS: Fix memory leak in rds_rdma_extra_size()
From: Allison Henderson <achender@kernel.org>
To: Xiaobo Liu <cppcoffee@gmail.com>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org
Date: Sun, 12 Apr 2026 21:18:20 -0700
In-Reply-To: <20260412124455.2008-1-cppcoffee@gmail.com>
References: <20260412124455.2008-1-cppcoffee@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19265-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1A2C3E743C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-04-12 at 20:44 +0800, Xiaobo Liu wrote:
> Free iov->iov when copy_from_user() or page count validation fails in rds=
_rdma_extra_size().
>=20
> This preserves the existing success path and avoids leaking the allocated=
 iovec array on error.

Hi Xiaobo,

Thanks for catching this.  The fix itself looks correct, but it will need y=
our
Signed-off-by line.  Also be sure to note the target tree and subsystem in =
the subject
line like this "[PATCH net v2] net/rds: Fix memory leak in rds_rdma_extra_s=
ize()", and
make sure the commit message wraps at about 72 characters.  Other than that=
 I think
the patch looks good.

Thank you!
Allison

> ---
>  net/rds/rdma.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/rds/rdma.c b/net/rds/rdma.c
> index aa6465dc7..91a20c1e2 100644
> --- a/net/rds/rdma.c
> +++ b/net/rds/rdma.c
> @@ -560,6 +560,7 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
>  	struct rds_iovec *vec;
>  	struct rds_iovec __user *local_vec;
>  	int tot_pages =3D 0;
> +	int ret =3D 0;
>  	unsigned int nr_pages;
>  	unsigned int i;
> =20
> @@ -578,16 +579,20 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
>  	vec =3D &iov->iov[0];
> =20
>  	if (copy_from_user(vec, local_vec, args->nr_local *
> -			   sizeof(struct rds_iovec)))
> -		return -EFAULT;
> +			   sizeof(struct rds_iovec))) {
> +		ret =3D -EFAULT;
> +		goto out;
> +	}
>  	iov->len =3D args->nr_local;
> =20
>  	/* figure out the number of pages in the vector */
>  	for (i =3D 0; i < args->nr_local; i++, vec++) {
> =20
>  		nr_pages =3D rds_pages_in_vec(vec);
> -		if (nr_pages =3D=3D 0)
> -			return -EINVAL;
> +		if (nr_pages =3D=3D 0) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> =20
>  		tot_pages +=3D nr_pages;
> =20
> @@ -595,11 +600,20 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
>  		 * nr_pages for one entry is limited to (UINT_MAX>>PAGE_SHIFT)+1,
>  		 * so tot_pages cannot overflow without first going negative.
>  		 */
> -		if (tot_pages < 0)
> -			return -EINVAL;
> +		if (tot_pages < 0) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
>  	}
> =20
> -	return tot_pages * sizeof(struct scatterlist);
> +	ret =3D tot_pages * sizeof(struct scatterlist);
> +
> +out:
> +	if (ret < 0) {
> +		kfree(iov->iov);
> +		iov->iov =3D NULL;
> +	}
> +	return ret;
>  }
> =20
>  /*


