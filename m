Return-Path: <linux-rdma+bounces-20455-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DS/OFeZAmpyuwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20455-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 05:07:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B24E519291
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 05:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BCDB302412B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DCD2C15BB;
	Tue, 12 May 2026 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0x7E03g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8D211A28;
	Tue, 12 May 2026 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778555135; cv=none; b=thTvmg19/ZAZKac9rtVmNNvWjXmtGmrlOFQgnP9ubkwW3TuZpNjFpSHgunXAZcOdRsS9YjaX6CVnPVAfnxM5bvZYHA7GARlCFhSuh1iLO3RjpNm9aGNOThzkMfv9w/aIeULo4deN4hOFODB6PeusABrnFkBn1jF2EcTwlb0ibHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778555135; c=relaxed/simple;
	bh=1w2UOoO1tnxzUBHVNiml1kjKXTz7nAaO6k3r5W8GT1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IEl4TODV1Ko9yBLT62sAzrQmt9rdKIT/wxU6OdPWa+SKPF1wyrRjm5HK8fDT96dIP8UD18DxsfLETrgAWyZzyI7bv/RBQcIOhsS9MtL2CGdyT4UNRBd6GCIXmCkBscxGAAwTxoA3qi9DG2cbo+ePJeqXWF3KDD5otGFsx03kGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0x7E03g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D240C2BCB0;
	Tue, 12 May 2026 03:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778555134;
	bh=1w2UOoO1tnxzUBHVNiml1kjKXTz7nAaO6k3r5W8GT1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=d0x7E03g0fkkNy0im+bNUEyZx542jOsy6iuW98pWaS4iN007wIfVwiOFKJaj4e0c7
	 4dMZRWTFKS0txGG64KScJ/b4VqemIlRIgtwEcTeNlA6PARW6snGZ9a4eTvH4lBzL+3
	 zGGp1oFKEgxUVGZN2qaKzFafuV2Zl377rmHLWbp+G/76rCs90Pvra6wfY0mfNfdiTY
	 aJCR097h/v97kBuYXR5yzOcwIecEu538pJidzuO5/gGyJcnT60Cze9m0zdpxJSmEIL
	 ghG8vP8bRfOYCRnGcV2LNqiLpY1BvcNrXH9SI6VLQdQBCL9u7RZ+hnn1YlW+0BqRCR
	 QgZNccop0nwaw==
Message-ID: <8f5bd75c7328d3b314a4c503ea16fb3c1bfffc08.camel@kernel.org>
Subject: Re: [PATCH net] net/rds: fix zerocopy page ownership on partial
 copy failure
From: Allison Henderson <achender@kernel.org>
To: Spencer ?? <spencer.phillips@live.com>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 11 May 2026 20:05:32 -0700
In-Reply-To: <CY8PR11MB70846C6CD3C93572660CCC40EA3B2@CY8PR11MB7084.namprd11.prod.outlook.com>
References: 
	<CY8PR11MB70846C6CD3C93572660CCC40EA3B2@CY8PR11MB7084.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4B24E519291
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20455-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[live.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[live.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, 2026-05-10 at 21:20 +0000, Spencer ?? wrote:
> RDS zerocopy sends pin user pages into the message data SG list and uses =
a
> zerocopy notifier to carry pin accounting and completion state.
>=20
> If iov_iter_get_pages2() fails after some SG entries have already been
> populated, the copy helper currently tears down the notifier and returns =
an
> error while leaving the partial SG count live.
>=20
> The common message purge path no longer has a notifier to distinguish
> zerocopy user pages from copied-send pages in that state, so it can relea=
se
> a still-mapped user page with __free_page().
>=20
> Make data page ownership explicit with an op_zcopy bit. Once zerocopy pin
> accounting succeeds, leave the notifier, ownership bit, and populated SG
> count attached to the message and let rds_message_purge() perform the
> single cleanup path.
>=20
> The notifier still controls zerocopy completion and pin accounting. The n=
ew
> op_zcopy bit controls whether counted data SG entries are released with
> put_page() or __free_page().
>=20
> This preserves normal copied-send cleanup and queued zerocopy completion
> behavior. It fixes the partial-build failure path without adding a second
> manual unwind path.
>=20
> Tested with an AF_RDS/RDS_TCP MSG_ZEROCOPY partial-fault reproducer on a
> KASAN kernel. Before the fix the run triggered bad page/accounting report=
s;
> after the fix sendmsg returns -EFAULT and no bad page or KASAN report occ=
urs.
>=20
> Fixes: 0cebaccef3ac ("rds: zerocopy Tx support.")
> Cc: stable@vger.kernel.org
> Assisted-By: Codex:GPT-5.5-xhigh
> Signed-off-by: Spencer Phillips <spencer.phillips@live.com>

Hi Spencer,

Thanks for finding this.  The fix itself looks ok to me.  When you resend t=
he patch with the corrected author name, you
can add my rvb.

Reviewed-by: Allison Henderson <achender@kernel.org>

Thanks!
Allison

> ---
>  net/rds/message.c | 33 ++++++++++-----------------------
>  net/rds/rds.h     |  1 +
>  2 files changed, 11 insertions(+), 23 deletions(-)
>=20
> diff --git a/net/rds/message.c b/net/rds/message.c
> index 25fedcb3cd00..a381a895339c 100644
> --- a/net/rds/message.c
> +++ b/net/rds/message.c
> @@ -141,7 +141,7 @@ static void rds_message_purge(struct rds_message *rm)
>  	spin_lock_irqsave(&rm->m_rs_lock, flags);
>  	znotifier =3D rm->data.op_mmp_znotifier;
>  	rm->data.op_mmp_znotifier =3D NULL;
> -	zcopy =3D !!znotifier;
> +	zcopy =3D rm->data.op_zcopy || !!znotifier;
>=20
>  	if (rm->m_rs) {
>  		struct rds_sock *rs =3D rm->m_rs;
> @@ -170,6 +170,7 @@ static void rds_message_purge(struct rds_message *rm)
>  			put_page(sg_page(&rm->data.op_sg[i]));
>  	}
>  	rm->data.op_nents =3D 0;
> +	rm->data.op_zcopy =3D 0;
>=20
>  	if (rm->rdma.op_active)
>  		rds_rdma_free_op(&rm->rdma);
> @@ -414,7 +415,6 @@ struct rds_message *rds_message_map_pages(unsigned lo=
ng *page_addrs, unsigned in
>  static int rds_message_zcopy_from_user(struct rds_message *rm, struct io=
v_iter *from)
>  {
>  	struct scatterlist *sg;
> -	int ret =3D 0;
>  	int length =3D iov_iter_count(from);
>  	struct rds_msg_zcopy_info *info;
>=20
> @@ -429,12 +429,12 @@ static int rds_message_zcopy_from_user(struct rds_m=
essage *rm, struct iov_iter *
>  	if (!info)
>  		return -ENOMEM;
>  	INIT_LIST_HEAD(&info->rs_zcookie_next);
> -	rm->data.op_mmp_znotifier =3D &info->znotif;
> -	if (mm_account_pinned_pages(&rm->data.op_mmp_znotifier->z_mmp,
> -				    length)) {
> -		ret =3D -ENOMEM;
> -		goto err;
> +	if (mm_account_pinned_pages(&info->znotif.z_mmp, length)) {
> +		kfree(info);
> +		return -ENOMEM;
>  	}
> +	rm->data.op_mmp_znotifier =3D &info->znotif;
> +	rm->data.op_zcopy =3D 1;
>  	while (iov_iter_count(from)) {
>  		struct page *pages;
>  		size_t start;
> @@ -442,28 +442,15 @@ static int rds_message_zcopy_from_user(struct rds_m=
essage *rm, struct iov_iter *
>=20
>  		copied =3D iov_iter_get_pages2(from, &pages, PAGE_SIZE,
>  					    1, &start);
> -		if (copied < 0) {
> -			struct mmpin *mmp;
> -			int i;
> -
> -			for (i =3D 0; i < rm->data.op_nents; i++)
> -				put_page(sg_page(&rm->data.op_sg[i]));
> -			mmp =3D &rm->data.op_mmp_znotifier->z_mmp;
> -			mm_unaccount_pinned_pages(mmp);
> -			ret =3D -EFAULT;
> -			goto err;
> -		}
> +		if (copied < 0)
> +			return -EFAULT;
>  		length -=3D copied;
>  		sg_set_page(sg, pages, copied, start);
>  		rm->data.op_nents++;
>  		sg++;
>  	}
>  	WARN_ON_ONCE(length !=3D 0);
> -	return ret;
> -err:
> -	kfree(info);
> -	rm->data.op_mmp_znotifier =3D NULL;
> -	return ret;
> +	return 0;
>  }
>=20
>  int rds_message_copy_from_user(struct rds_message *rm, struct iov_iter *=
from,
> diff --git a/net/rds/rds.h b/net/rds/rds.h
> index 6e0790e4b570..b27848ec5c5a 100644
> --- a/net/rds/rds.h
> +++ b/net/rds/rds.h
> @@ -496,6 +496,7 @@ struct rds_message {
>  		} rdma;
>  		struct rm_data_op {
>  			unsigned int		op_active:1;
> +			unsigned int		op_zcopy:1;
>  			unsigned int		op_nents;
>  			unsigned int		op_count;
>  			unsigned int		op_dmasg;
> --
> 2.54.0


