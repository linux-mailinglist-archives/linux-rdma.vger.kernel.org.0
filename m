Return-Path: <linux-rdma+bounces-19484-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKW7IoKw6WlchgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19484-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 07:39:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64044D4D8
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 07:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 433B5302CB02
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6A23C5526;
	Thu, 23 Apr 2026 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nshC468M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2039280D;
	Thu, 23 Apr 2026 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776922751; cv=none; b=UaDy5u6NJ+X6fl1vAbhpmUtbKAIZS0ttYzXmSbwy1Fx6bO2i5NpXUhihtKGO5K2BWm01SVHFF8cDjewqeYpE5sbAN+PEKlPH7uV6QzD4h5tkegFBz0mbcWPDJnSPV6lCsvoyTns0bpNqtjtyzYn73dbuf9z4qRooWJUvurRVCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776922751; c=relaxed/simple;
	bh=rowK5DSec9h1SfrIxFRjEH/ZsljFmavsKkMyOS1b4G0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SM2Gxuh6zRQuuCScBgCTRdkbeYzRDYD2nlj2iJk2g8P5a2Fci82CyA6D6z6TD9RmM7z0OEP359SmpKgccac8wUfK4/WQ3iKWQEi2EicUbVCB4gPA63b8+7LsMfWGO9a//ke953Pnd1tATUpFcuGGaq7lvxORxCCzYHLfm2Fm9xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nshC468M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E69C2BCAF;
	Thu, 23 Apr 2026 05:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776922751;
	bh=rowK5DSec9h1SfrIxFRjEH/ZsljFmavsKkMyOS1b4G0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nshC468MLUdeq6ua1iH0soJMxRatSDUHngY0w+hhnBfJ9ToHsNeB/7hzEujDbtPaq
	 EwjODy3ryDQ4GAYwlURDkUVe+mvJNGqG971uygnyV8hqv/p2XRGXB0vZsUXXaK9KRe
	 Be/WX/qzv16aG3Ic4Ko89rPJnswXnsPF5KBHbqgb8heHHhvzk4G0MmsZ6kZ250lv2R
	 IStH4wJJbyLaxanIGYi94YDj+Thgrn7LXY48JOcQqr9Kvw/jMaFslkCbITsaz8FLOk
	 NzY8nQBc8TePCfhNvl8qGITunclFy8I5EQXZJWzprpOtDRYK5g7z+GBuWeuHeWoa87
	 hLrkyKePLwWUA==
Message-ID: <15512dc3c3250ae025f9e588e2335e2a2acf5107.camel@kernel.org>
Subject: Re: [PATCH net 1/1] net: rds: fix MR cleanup on copy error
From: Allison Henderson <achender@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  horms@kernel.org, leon@kernel.org,
 santosh.shilimkar@oracle.com,  jhubbard@nvidia.com, yuantan098@gmail.com,
 yifanwucs@gmail.com,  tomapufckgml@gmail.com, bird@lzu.edu.cn,
 draw51280@163.com
Date: Wed, 22 Apr 2026 22:39:08 -0700
In-Reply-To: <79c8ef73ec8e5844d71038983940cc2943099baf.1776764247.git.draw51280@163.com>
References: <cover.1776764247.git.draw51280@163.com>
	 <79c8ef73ec8e5844d71038983940cc2943099baf.1776764247.git.draw51280@163.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19484-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,oracle.com,nvidia.com,gmail.com,lzu.edu.cn,163.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC64044D4D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-22 at 22:52 +0800, Ren Wei wrote:
> From: Ao Zhou <draw51280@163.com>
>=20
> __rds_rdma_map() hands sg/pages ownership to the transport after
> get_mr() succeeds. If copying the generated cookie back to user space
> fails after that point, the error path must not free those resources
> again before dropping the MR reference.
>=20
> Remove the duplicate unpin/free from the put_user() failure branch so
> that MR teardown is handled only through the existing final cleanup
> path.
>=20
> Fixes: 0d4597c8c5ab ("net/rds: Track user mapped pages through special AP=
I")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Ao Zhou <draw51280@163.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Hi Aso,

This fix looks good to me.  Since this is a bug fix, this patch should be c=
c'd to stable@vger.kernel.org.  Also be sure
to note the target tree and component in the subject line like this: =20

[PATCH net v2 1/1] net/net: rds: fix MR cleanup on copy error

Other than that, the patch looks good to me.  Thanks Aso.

Reviewed-by: Allison Henderson <achender@kernel.org>

Allison

> ---
>  net/rds/rdma.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/net/rds/rdma.c b/net/rds/rdma.c
> index aa6465dc742c..61fb6e45281b 100644
> --- a/net/rds/rdma.c
> +++ b/net/rds/rdma.c
> @@ -326,10 +326,6 @@ static int __rds_rdma_map(struct rds_sock *rs, struc=
t rds_get_mr_args *args,
> =20
>  	if (args->cookie_addr &&
>  	    put_user(cookie, (u64 __user *)(unsigned long)args->cookie_addr)) {
> -		if (!need_odp) {
> -			unpin_user_pages(pages, nr_pages);
> -			kfree(sg);
> -		}
>  		ret =3D -EFAULT;
>  		goto out;
>  	}


