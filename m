Return-Path: <linux-rdma+bounces-16960-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Kb5MrKclGmrFwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16960-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 17:52:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB2014E6A0
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 17:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67B7E3034557
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78436EAB8;
	Tue, 17 Feb 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="e9KywhR5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdzV/iiD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B23B21D5B0;
	Tue, 17 Feb 2026 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347105; cv=none; b=dFnxdw0XlURdFthn4rxFqayax0c06LzcNF18kc8KYOb4mWEVGC8gHtYrFjum+ch87WpVeWix8smF4Vsvo6BulT6qRkg1AwR0xrlmZakNzT6OejzH0+0B/NJaYYekE6pC2lsSXNhnysUnD7JZRfAdTvSBEZASpHEvJRLADB3tNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347105; c=relaxed/simple;
	bh=BSi3S2dZEPzNzAFDEVV13PQ53p7wkd2tpUn0QpbhpSw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RdvNRG/eiGNkmugd0eNF9jftUZvldjRi8m7WCDSO7g7hlbdPPmXA+Y/yBvtS4HRqMrcKoBLp4mLf4QfToHylTzm7LJr4H5buG1PlB5G1gxgru5kaE/rGCZ35PTOK73cVtdnXY4XnZXjQceZKprddbzP73wCZHUkL26FTuylONg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=e9KywhR5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdzV/iiD; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 229831D00067;
	Tue, 17 Feb 2026 11:51:41 -0500 (EST)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-10.internal (MEProxy); Tue, 17 Feb 2026 11:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771347100;
	 x=1771433500; bh=gTmXdQ6x0zAJ455xiBa36oRFZfaGcb1DbTWyp/DHGRg=; b=
	e9KywhR5y2hxP/dm/IgwOhcv417kvQQrmOKx/MQxuaLdheeME9ALh0xKeLHUJQrx
	jO+jB46bjoobaTPA+Q0DizuWsgESjwfJ32UntKGojc+NsenzB06JRDrA5rWEeQIM
	jnVrLcBhIH7/EzMcJGo1N2sbFjKRzNjI/w8OUpf5vXo0ieXgPwmS4UhtL+pQijJy
	QEUIbYZXwx590dvrvFPEEoyGVdEFZMcdZ2bKjM1iGFLybOxxS6WMlFFvzBJRRKPc
	icCcphvmDcMoT1WWtqWrx0gtMuIhAD/POPcDMUdLbUOh8E+QmpstnXf/sSdkoQsH
	SLzvomH9h/TStIxGnkGUuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771347100; x=
	1771433500; bh=gTmXdQ6x0zAJ455xiBa36oRFZfaGcb1DbTWyp/DHGRg=; b=V
	dzV/iiDWvatJURxZtyxnn+yfu+SRtp5d1R71dVukwhWvkRA/UOA6yWffz6C5ADA5
	5tcoIcUusuE2QjdkouMUJMWj3Uoq3dyFOPiaBpaXMr9xfwlG1CDKLTamEM8+1Xg/
	ovYbbGal6KLclCeVve444sRiaN11LS8ZCsibRHfF/4rtCKu1GZyGcqGO9gyM3Fbl
	b01biSpgibxTdS/tEqMoW1DHuNwdhVCIQ0vd2/y0lL8eOrnpLle1WNWWn9FbfYdR
	9QdUZCRMpftLvOH0cnxD3cFdx428jnI1AoMZ5+o2GHlaPhauNlJyUd1KLcgduPlZ
	ZnzyEO+5bvN5EuMEKgjcg==
X-ME-Sender: <xms:nJyUaa-fmgw6d0RsUFRcDnp4OqgMrVxamKC2k8uJnOUJkVxd3a6G8w>
    <xme:nJyUaVgLMByj6_0uWENMEi_hubN4BSrt79oyXejyAhKHztOyApgEBEiLfdf12Oy-X
    P6glCMwlZ5lTsRlzzlrSXGoqTVGTb1YVbs9kd2xCOJ78DmfachpDjzF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlihgt
    vgcuofhikhhithihrghnshhkrgdfuceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrg
    hilhdrihhmqeenucggtffrrghtthgvrhhnpefhgfevgeeljeegleeiffduheegieehtdff
    tdetvdffieelkedthfejleejgfeftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgt
    vgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhnsggprhgtphhtthhopedvfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdr
    nhgvthdprhgtphhtthhopegufiesuggrvhhiugifvghirdhukhdprhgtphhtthhopehjoh
    hhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrh
    gsohigrdhnvghtpdhrtghpthhtoheprghlihgtvgesihhsohhvrghlvghnthdrtghomhdp
    rhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgifkheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nJyUaT-B8aqYlapHkcRqNFMuvR6rIYbffH0sG4OTLYQQ_8XWBvPjNw>
    <xmx:nJyUaUmVV40_RWITVWiyQ8kHZego9PaMGCiAHON-Rj-V4OAxmqx08A>
    <xmx:nJyUaek24iPNytAhqpQNY26E--BOxVEAbq127U6TpOc9xvbpJb5ETA>
    <xmx:nJyUaRiHFT5d9u5zqinZB-_jISVazcKyrhUmlPK8KTLlq9_N0dHs_w>
    <xmx:nJyUaZ4HSzRzH76kH1UENPYBaqRZbEwgWq22ws5JRLn8Z70DJfJ6Pf57>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1810533E0099; Tue, 17 Feb 2026 11:51:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6vJis2OPFsV
Date: Tue, 17 Feb 2026 18:48:32 +0200
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Tariq Toukan" <tariqt@nvidia.com>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: "Saeed Mahameed" <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Mark Bloch" <mbloch@nvidia.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, "Gal Pressman" <gal@nvidia.com>,
 "Moshe Shemesh" <moshe@nvidia.com>, "William Tu" <witu@nvidia.com>,
 "David Wei" <dw@davidwei.uk>, "Dragos Tatulea" <dtatulea@nvidia.com>,
 alice@isovalent.com
Message-Id: <aa5dc734-f122-42ec-b382-f464d02ddc35@app.fastmail.com>
In-Reply-To: <20260217074525.1761454-1-tariqt@nvidia.com>
References: <20260217074525.1761454-1-tariqt@nvidia.com>
Subject: Re: [PATCH net] net/mlx5e: XSK, Fix unintended ICOSQ change
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16960-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk,isovalent.com];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid,fastmail.im:email,fastmail.im:dkim,messagingengine.com:dkim,nvidia.com:email,iogearbox.net:email]
X-Rspamd-Queue-Id: 1EB2014E6A0
X-Rspamd-Action: no action

On Tue, Feb 17, 2026, at 09:45, Tariq Toukan wrote:
> XSK wakeup must use the async ICOSQ (with proper locking), as it is not
> guaranteed to run on the same CPU as the channel.
>
> The commit that converted the NAPI trigger path to use the sync ICOSQ
> incorrectly applied the same change to XSK, causing XSK wakeups to use
> the sync ICOSQ as well. Revert XSK flows to use the async ICOSQ.
>
> XDP program attach/detach triggers channel reopen, while XSK pool
> enable/disable can happen on-the-fly via NDOs without reopening
> channels. As a result, xsk_pool state cannot be reliably used at
> mlx5e_open_channel() time to decide whether an async ICOSQ is needed.
>
> Update the async_icosq_needed logic to depend on the presence of an XDP
> program rather than the xsk_pool, ensuring the async ICOSQ is available
> when XSK wakeups are enabled.
>
> This fixes multiple issues:
>
> 1. Illegal synchronize_rcu() in an RCU read- side critical section via
>    mlx5e_xsk_wakeup() -> mlx5e_trigger_napi_icosq() ->
>    synchronize_net(). The stack holds RCU read-lock in xsk_poll().
>
> 2. Hitting a NULL pointer dereference in mlx5e_xsk_wakeup():
>
> [] BUG: kernel NULL pointer dereference, address: 0000000000000240
> [] #PF: supervisor read access in kernel mode
> [] #PF: error_code(0x0000) - not-present page
> [] PGD 0 P4D 0
> [] Oops: Oops: 0000 [#1] SMP
> [] CPU: 0 UID: 0 PID: 2255 Comm: qemu-system-x86 Not tainted 
> 6.19.0-rc5+ #229 PREEMPT(none)
> [] Hardware name: [...]
> [] RIP: 0010:mlx5e_xsk_wakeup+0x53/0x90 [mlx5_core]
>
> Reported-by: Daniel Borkmann <daniel@iogearbox.net>
> Closes: 
> https://lore.kernel.org/all/20260123223916.361295-1-daniel@iogearbox.net/
> Fixes: 56aca3e0f730 ("net/mlx5e: Use regular ICOSQ for triggering NAPI")
> Tested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
>  .../ethernet/mellanox/mlx5/core/en/xsk/pool.c |  4 ++--
>  .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++++++++++------
>  4 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h 
> b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index a7de3a3efc49..19fce51117c9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -1103,6 +1103,7 @@ int mlx5e_open_locked(struct net_device *netdev);
>  int mlx5e_close_locked(struct net_device *netdev);
> 
>  void mlx5e_trigger_napi_icosq(struct mlx5e_channel *c);
> +void mlx5e_trigger_napi_async_icosq(struct mlx5e_channel *c);
>  void mlx5e_trigger_napi_sched(struct napi_struct *napi);
> 
>  int mlx5e_open_channels(struct mlx5e_priv *priv,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c 
> b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
> index db776e515b6a..5c5360a25c64 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
> @@ -127,7 +127,7 @@ static int mlx5e_xsk_enable_locked(struct 
> mlx5e_priv *priv,
>  		goto err_remove_pool;
> 
>  	mlx5e_activate_xsk(c);
> -	mlx5e_trigger_napi_icosq(c);
> +	mlx5e_trigger_napi_async_icosq(c);
> 
>  	/* Don't wait for WQEs, because the newer xdpsock sample doesn't 
> provide
>  	 * any Fill Ring entries at the setup stage.
> @@ -179,7 +179,7 @@ static int mlx5e_xsk_disable_locked(struct 
> mlx5e_priv *priv, u16 ix)
>  	c = priv->channels.c[ix];
> 
>  	mlx5e_activate_rq(&c->rq);
> -	mlx5e_trigger_napi_icosq(c);
> +	mlx5e_trigger_napi_async_icosq(c);
>  	mlx5e_wait_for_min_rx_wqes(&c->rq, MLX5E_RQ_WQES_TIMEOUT);
> 
>  	mlx5e_rx_res_xsk_update(priv->rx_res, &priv->channels, ix, false);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c 
> b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> index 9e33156fac8a..8aeab4b21035 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> @@ -34,7 +34,7 @@ int mlx5e_xsk_wakeup(struct net_device *dev, u32 qid, 
> u32 flags)
>  				     &c->async_icosq->state))
>  			return 0;
> 
> -		mlx5e_trigger_napi_icosq(c);
> +		mlx5e_trigger_napi_async_icosq(c);
>  	}
> 
>  	return 0;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c 
> b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 4b8084420816..6a7ca4571c19 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -2744,16 +2744,26 @@ static int mlx5e_channel_stats_alloc(struct 
> mlx5e_priv *priv, int ix, int cpu)
> 
>  void mlx5e_trigger_napi_icosq(struct mlx5e_channel *c)
>  {
> +	struct mlx5e_icosq *sq = &c->icosq;
>  	bool locked;
> 
> -	if (!test_and_set_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state))
> -		synchronize_net();
> +	set_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &sq->state);
> +	synchronize_net();
> 
> -	locked = mlx5e_icosq_sync_lock(&c->icosq);
> -	mlx5e_trigger_irq(&c->icosq);
> -	mlx5e_icosq_sync_unlock(&c->icosq, locked);
> +	locked = mlx5e_icosq_sync_lock(sq);
> +	mlx5e_trigger_irq(sq);
> +	mlx5e_icosq_sync_unlock(sq, locked);
> 
> -	clear_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state);
> +	clear_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &sq->state);
> +}
> +
> +void mlx5e_trigger_napi_async_icosq(struct mlx5e_channel *c)
> +{
> +	struct mlx5e_icosq *sq = c->async_icosq;
> +
> +	spin_lock_bh(&sq->lock);
> +	mlx5e_trigger_irq(sq);
> +	spin_unlock_bh(&sq->lock);
>  }
> 
>  void mlx5e_trigger_napi_sched(struct napi_struct *napi)
> @@ -2836,7 +2846,7 @@ static int mlx5e_open_channel(struct mlx5e_priv 
> *priv, int ix,
>  	netif_napi_add_config_locked(netdev, &c->napi, mlx5e_napi_poll, ix);
>  	netif_napi_set_irq_locked(&c->napi, irq);
> 
> -	async_icosq_needed = !!xsk_pool || priv->ktls_rx_was_enabled;
> +	async_icosq_needed = !!params->xdp_prog || priv->ktls_rx_was_enabled;

Acked-by: Alice Mikityanska <alice.kernel@fastmail.im>

With a follow-up suggestion that we discussed at:

https://lore.kernel.org/netdev/8a3a3ff4-16c7-4d99-8854-38d741cc6b82@gmail.com/

>  	err = mlx5e_open_queues(c, params, cparam, async_icosq_needed);
>  	if (unlikely(err))
>  		goto err_napi_del;
>
> base-commit: ee5492fd88cfc079c19fbeac78e9e53b7f6c04f3
> -- 
> 2.44.0

