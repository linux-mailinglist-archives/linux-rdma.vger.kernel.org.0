Return-Path: <linux-rdma+bounces-20543-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF7gCG8RBGoMDAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20543-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:51:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5AC52DC96
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA46930B236B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE803ACF1E;
	Wed, 13 May 2026 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2g8pjKM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E23AEB27;
	Wed, 13 May 2026 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651365; cv=none; b=hlAwIPTSZPUsvYGcK8QldAp6cF7gkl95n6jykn0j7meJSH9AXzkl1tHum3VlBt723qtQqceBIxp5ck06CY88qkbjlA6nkO4T4+YdvGyKrRDsJlAwrwWT292hRb5q5Ckfu1anqZAuqM7fgs352BlAj60plJB4xxfMdaJxCB70dzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651365; c=relaxed/simple;
	bh=bC78n1G/0rJONz1IOc5tjzw6NhXjs+EpD/tRgeP9lw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/a9+MIOh57qe2qAegUdqPRHN2lAnQPXFv2Oi+GFO3QRD76JuD+C1FXfUOopBckPD4xbrKg+HXB9BhFY8zrnIRNuGuvCMphH0FErhnz6pCk5k8Z1cDsifUW0S45FdJ7JJou+SagBvujUA+6Pfsfpo9seLB0HjKA/gMR4V0yVWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2g8pjKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F8EC2BCB7;
	Wed, 13 May 2026 05:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778651364;
	bh=bC78n1G/0rJONz1IOc5tjzw6NhXjs+EpD/tRgeP9lw8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=d2g8pjKMGN8t/JjZAP9D+DvqjEUr9cSNLBYnERRuDiAw3Tf129S+ptaHNrgfNDClJ
	 O6RT97CS8BN6kxiSmY3yRJ/XXWPizMW0K1MqfsM+qLVN852cM44+m0peSTCUhKiN8D
	 eQBh0+Bvzd3gZYZEcJJAgiyNCFR5cLypVMfbsQ1GqDhaINB2Riu4dvyhJkN5AN/LSi
	 GqpGElfyhrr1+J/eqomSV+V6FBVa1LcAJGmlXai9NyXorshwyUtu8NgALN5Gjn0WIg
	 /zvt/iMQdJpdyfatP+TrlUPaSUx8/GlDlwCWNpj13UF7IgcUdQYyhZiq0ZAOtzLuD9
	 wcYObM3rS6N2w==
Message-ID: <35dbecc33417ff79ec6c27c041f05d362ff7ab90.camel@kernel.org>
Subject: Re: [PATCH net-next] rds: tcp_listen: fix typos in comments
From: Allison Henderson <achender@kernel.org>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com,  horms@kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com,  linux-kernel@vger.kernel.org
Date: Tue, 12 May 2026 22:49:23 -0700
In-Reply-To: <20260512215531.1988662-1-avinash.duduskar@gmail.com>
References: <20260512215531.1988662-1-avinash.duduskar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7A5AC52DC96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20543-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 2026-05-13 at 03:25 +0530, Avinash Duduskar wrote:
> Two typos in comments:
>=20
> - "reconneect" -> "reconnect" (block comment above
>   rds_tcp_accept_one_path()).
> - "acccepted" -> "accepted" (block comment inside
>   rds_tcp_conn_slots_available()).
>=20
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>

Looks fine to me.  Thanks for the cleanups!

Reviewed-by: Allison Henderson <achender@kernel.org>

> ---
>  net/rds/tcp_listen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> index 08a506aa7ce7..a3db9b057084 100644
> --- a/net/rds/tcp_listen.c
> +++ b/net/rds/tcp_listen.c
> @@ -69,7 +69,7 @@ rds_tcp_get_peer_sport(struct socket *sock)
> =20
>  /* rds_tcp_accept_one_path(): if accepting on cp_index > 0, make sure th=
e
>   * client's ipaddr < server's ipaddr. Otherwise, close the accepted
> - * socket and force a reconneect from smaller -> larger ip addr. The rea=
son
> + * socket and force a reconnect from smaller -> larger ip addr. The reas=
on
>   * we special case cp_index 0 is to allow the rds probe ping itself to i=
tself
>   * get through efficiently.
>   */
> @@ -143,7 +143,7 @@ void rds_tcp_conn_slots_available(struct rds_connecti=
on *conn, bool fan_out)
>  	 *
>  	 * Doing so is necessary to address the case where an
>  	 * incoming connection on "rds_tcp_listen_sock" is ready
> -	 * to be acccepted prior to a free slot being available:
> +	 * to be accepted prior to a free slot being available:
>  	 * the -ENOBUFS case in "rds_tcp_accept_one".
>  	 */
>  	rds_tcp_accept_work(rtn);
>=20
> base-commit: 73d587ae684d176fac9db94173f77d78a794ea4f


