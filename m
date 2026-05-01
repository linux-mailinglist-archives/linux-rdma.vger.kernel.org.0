Return-Path: <linux-rdma+bounces-19837-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IfUMWwD9WlGHQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19837-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 21:47:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3001B4AF563
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 21:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADB92306496A
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E54426EC9;
	Fri,  1 May 2026 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFrNpdHz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F04421A14;
	Fri,  1 May 2026 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664430; cv=none; b=P8GmWMv/Ussw2xWW0VTNy2HObZWQwel6MLpnpS2eRfeORudamhdEu5HzASREa7J22oDjUyj3nHCiDWjWorkY8UjLFluIOji/DSagigkAAzXBaYoXWnmAJWz4aMOFnhPnEtzp4JpVKc4Ne0+L+bZ3HximHbWocAnNai2oO1egKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664430; c=relaxed/simple;
	bh=DVernVjlwHkGRUemq83InMZZTHnAT+4erTkc0LGEwrU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmNmmjk0FliSV5lnKLg2WbGryglKB2ZhpfyjFvWkeeAezd1zlfpwrK5oE7iq8wbUm6REFdAlBFmvsI6qJH1g8ShqCl7QTXp1lrh8JWypQ7l1zag98tb0GF7IR6KXhfLbz8CpSu/NKrSjHPObgHRUjzThXixdBXLI/lvvbAJ7EIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFrNpdHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF150C2BCB8;
	Fri,  1 May 2026 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777664428;
	bh=DVernVjlwHkGRUemq83InMZZTHnAT+4erTkc0LGEwrU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GFrNpdHz44rlcoSQzge3VQPoSOfqLpLse6we5jgwG4isV0aywD+0ZrACAZyaQfVpV
	 JvUeEG+d0McDQ8CduL4vAgtUwLyHZyqlIRRsiAK720i5/G9IMrgtYoIgUrDZVlNzM/
	 HUlzIVc6j1BUjgRS9zcz7oB1RTHSoblLzKi/7kDHdyDoO5R3AiN0RUDPOBXUUg6mRz
	 +SduDz6v8dLz7O/tKbSJQd6UEtFWVXPqvDft/EdqQ3waAn6hXeaF/lxfFLQyMEfiGz
	 wpjk19uBU0smVbVqLdhq6N3V4B1xSTJiXe6vftAZySNL5LSlNa2287gBlSF2awBJhH
	 z5pBMT0vSJhLQ==
Message-ID: <87f79bc7483aa1a7b3a44718b62a5cd5bd016f8c.camel@kernel.org>
Subject: Re: [PATCH net 1/1] net/rds: handle zerocopy send cleanup before
 the message is queued
From: Allison Henderson <achender@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  horms@kernel.org, santosh.shilimkar@oracle.com,
 sowmini.varadhan@oracle.com,  willemb@google.com, yuantan098@gmail.com,
 yifanwucs@gmail.com,  tomapufckgml@gmail.com, bird@lzu.edu.cn,
 lx24@stu.ynu.edu.cn, tonanli66@gmail.com
Date: Fri, 01 May 2026 12:40:26 -0700
In-Reply-To: <d2ea98a6313d5467bac00f7c9fef8c7acddb9258.1777550074.git.tonanli66@gmail.com>
References: <cover.1777550074.git.tonanli66@gmail.com>
	 <d2ea98a6313d5467bac00f7c9fef8c7acddb9258.1777550074.git.tonanli66@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3001B4AF563
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[ynu.edu.cn:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19837-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,oracle.com,gmail.com,lzu.edu.cn,stu.ynu.edu.cn];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ynu.edu.cn:email]

On Fri, 2026-05-01 at 09:08 +0800, Ren Wei wrote:
> From: Nan Li <tonanli66@gmail.com>
>=20
> A zerocopy send can fail after user pages have been pinned but before
> the message is attached to the sending socket.
>=20
> The purge path currently infers zerocopy state from rm->m_rs, so an
> unqueued message can be cleaned up as if it owned normal payload pages.
> However, zerocopy ownership is really determined by the presence of
> op_mmp_znotifier, regardless of whether the message has reached the
> socket queue.
>=20
> Capture op_mmp_znotifier up front in rds_message_purge() and use it as
> the cleanup discriminator. If the message is already associated with a
> socket, keep the existing completion path. Otherwise, drop the pinned
> page accounting directly and release the notifier before putting the
> payload pages.
>=20
> This keeps early send failure cleanup consistent with the zerocopy
> lifetime rules without changing the normal queued completion path.
>=20
> Fixes: 0cebaccef3ac ("rds: zerocopy Tx support.")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Xiao Liu <lx24@stu.ynu.edu.cn>
> Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

This fix looks fine to me.  Thanks Ren Wei!
Reviewed-by: Allison Henderson <achender@kernel.org>

Allison

> ---
>  net/rds/message.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/rds/message.c b/net/rds/message.c
> index eaa6f22601a4..25fedcb3cd00 100644
> --- a/net/rds/message.c
> +++ b/net/rds/message.c
> @@ -131,24 +131,34 @@ static void rds_rm_zerocopy_callback(struct rds_soc=
k *rs,
>   */
>  static void rds_message_purge(struct rds_message *rm)
>  {
> +	struct rds_znotifier *znotifier;
>  	unsigned long i, flags;
> -	bool zcopy =3D false;
> +	bool zcopy;
> =20
>  	if (unlikely(test_bit(RDS_MSG_PAGEVEC, &rm->m_flags)))
>  		return;
> =20
>  	spin_lock_irqsave(&rm->m_rs_lock, flags);
> +	znotifier =3D rm->data.op_mmp_znotifier;
> +	rm->data.op_mmp_znotifier =3D NULL;
> +	zcopy =3D !!znotifier;
> +
>  	if (rm->m_rs) {
>  		struct rds_sock *rs =3D rm->m_rs;
> =20
> -		if (rm->data.op_mmp_znotifier) {
> -			zcopy =3D true;
> -			rds_rm_zerocopy_callback(rs, rm->data.op_mmp_znotifier);
> +		if (znotifier) {
> +			rds_rm_zerocopy_callback(rs, znotifier);
>  			rds_wake_sk_sleep(rs);
> -			rm->data.op_mmp_znotifier =3D NULL;
>  		}
>  		sock_put(rds_rs_to_sk(rs));
>  		rm->m_rs =3D NULL;
> +	} else if (znotifier) {
> +		/*
> +		 * Zerocopy can fail before the message is queued on the
> +		 * socket, so there is no rs to carry the notification.
> +		 */
> +		mm_unaccount_pinned_pages(&znotifier->z_mmp);
> +		kfree(rds_info_from_znotifier(znotifier));
>  	}
>  	spin_unlock_irqrestore(&rm->m_rs_lock, flags);
> =20


