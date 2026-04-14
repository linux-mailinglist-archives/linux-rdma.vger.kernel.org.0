Return-Path: <linux-rdma+bounces-19313-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNtiFDyH3WkgfQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19313-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 02:15:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5023F460A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 02:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FFF830413BF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 00:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2295198E91;
	Tue, 14 Apr 2026 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smpGiiph"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822CB13DDAA;
	Tue, 14 Apr 2026 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776125750; cv=none; b=diyfR0srKumP/UtzU1BsbRE7mSh89Yyngrr7l0/t1PgIB0AASW9r2UbjyWokBpCjM3MkvFApjHtUlWSbPzV9sQsxGZaf/gVgg/EhAZMlk+KbI883+Gpy1I4bef2m/8sgLD2DapKwgmjp+Prwlx6SQyyJA8jbIZK2axv6EjRtlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776125750; c=relaxed/simple;
	bh=/KsjYsvdykoCUcRhppsdRI5ZRMsJIIzrqtQA2lvXVW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VG3Iu4CAw817imEcChhME/8OAa0QCDdZnUepG0F+Olzm0jBM946K7M6k2SFZMk4iPHmqEarzFGwEwdy9MtiQrd9m0pEoK1J70USo3jX1hzzdfMpA69HVuo0NhnpKY3Nh6G7VJg2AuBNb3KwQScmlBgBqxYmpWJbu7YB4oNrHAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smpGiiph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F70C2BCAF;
	Tue, 14 Apr 2026 00:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776125750;
	bh=/KsjYsvdykoCUcRhppsdRI5ZRMsJIIzrqtQA2lvXVW4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=smpGiiphv9CG4RZAun++HCq1EKwc++OmIX7vrMRUMd2K7F6SE7GV2HyP5vLcOa7Z9
	 0Gob217U6w7aMdaBShFo3kk/1Byn/vhq4/I8yx7avDWemyRl0UC9pDCN20Bal1eum1
	 Gvcrj/JuTRzDb8l2rH7gKTOyVUfiCv2gIsCP7w04DHkenQyBGp/BE4T4+Gq4uc6the
	 66lK7eaYbVyHjCO4hnIq9Nn3QHzJFjsiOMXTnt9tLA6IGE6IgwP57YdwDPwq5AjaXO
	 Da+vvsOTIWHbghxyIjvLwN5OYKi1Aug+KQ7BObvN5AZJvQbktaMc20SW6yPbg2bYD1
	 Vw8+vdi1vV0WQ==
Message-ID: <70b9eca6eac73a9ac71662b45ffc330314aee9d7.camel@kernel.org>
Subject: Re: [PATCH net v2] RDS: Fix memory leak in rds_rdma_extra_size()
From: Allison Henderson <achender@kernel.org>
To: Xiaobo Liu <cppcoffee@gmail.com>, "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,  linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com,  linux-kernel@vger.kernel.org
Date: Mon, 13 Apr 2026 17:15:48 -0700
In-Reply-To: <20260413070005.15272-1-cppcoffee@gmail.com>
References: <20260413070005.15272-1-cppcoffee@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19313-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB5023F460A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-04-13 at 15:00 +0800, Xiaobo Liu wrote:
> Free iov->iov when copy_from_user() or page count validation fails
> in rds_rdma_extra_size().
>=20
> This preserves the existing success path and avoids leaking the
> allocated iovec array on error.
>=20
> Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>

I think this looks good now.  Thanks Xiaobo.
Reviewed-by: Allison Henderson <achender@kernel.org>

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


