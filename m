Return-Path: <linux-rdma+bounces-19869-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECXIOTuo9mmgXQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19869-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 03:43:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1BC4B4062
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 03:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A6A6301ABAA
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B88D23FC41;
	Sun,  3 May 2026 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOvf11Dl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4321771B;
	Sun,  3 May 2026 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777772554; cv=none; b=a1adWVoOAGZMzaABGQ8GSKGCdY8UkrAES7LDH77PIXi2FGZn4YAIT+L5NSqQ/OMXhk8I7J9vmpiVE2e22hUH7o2eE1DOZ0AZx0WaFwY+LfLkb3B8Jd7IakPwM0IqwzmNYBDP2/Wg63cunAWDyHdYw3QH7cb527vewHQtQgD7Ce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777772554; c=relaxed/simple;
	bh=kzDVj3W6CzUg7tKzJAaInLf1t+Wq+AGUGvJKXvwc758=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZVyZoRgs2Cr3zn3iAquwA3CtOmCHn3m9N67zIxjHOU42hr5nq6r9AIdKHw2R0Mm52w+o4hekKnEjn4GlpmLaVCr1JQuB9TKnoQzuWwoxd5SRZ4fKWk8RbP1i7BiDr24JLTwl/Rsz5O8+pGcE3e5DSzlyIibgM1BTwWmVAvn8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOvf11Dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C77BC19425;
	Sun,  3 May 2026 01:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777772553;
	bh=kzDVj3W6CzUg7tKzJAaInLf1t+Wq+AGUGvJKXvwc758=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOvf11DlCIGI3xDEIydlk8rM9PH0qvHshnhNYWCBQlLqQeOm1y17W1rBn4tuE14gv
	 0lSlRsCbhdxUmP4qUIfVDMl6QJON3nI3qGm5RAM/issrDvVmH4jlZefztA3QTSk+9S
	 PeOxGe7wTZwbMXw/22iU0wpQ1vYWr3x/wBCWxsiBQA3PVqkuDMj7W2pArxbInCxxTm
	 0uNWwStrqGXreaXBzG/k7hRaTbYGip5Vuj0VGxjQ03BRtIFi9GY86GP1N1mM8EgbI/
	 hZTc1uaH0/E6MhHvqnVmQ21KwcbNvuQ8YAfzcSNDzpiI3ohZWUX79GLYAGcxGDC74D
	 TFw27KjpDdScQ==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	leon@kernel.org,
	jgg@ziepe.ca,
	saeedm@nvidia.com,
	mbloch@nvidia.com,
	shayd@nvidia.com,
	ohartoov@nvidia.com,
	edwards@nvidia.com,
	msanalla@nvidia.com,
	horms@kernel.org,
	gbayer@linux.ibm.com,
	moshe@nvidia.com,
	kees@kernel.org,
	phaddad@nvidia.com,
	parav@nvidia.com,
	cjubran@nvidia.com,
	cratiu@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	gal@nvidia.com,
	dtatulea@nvidia.com
Subject: Re: [PATCH net-next V2 6/7] net/mlx5: E-switch, load reps via work queue after registration
Date: Sat,  2 May 2026 18:42:27 -0700
Message-ID: <20260503014231.4096128-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501041633.231662-7-tariqt@nvidia.com>
References: <20260501041633.231662-7-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B1BC4B4062
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19869-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5: E-switch, load reps via work queue after registration

This change defers loading of newly registered representors to the
E-Switch work queue so the handler can acquire the devlink lock that is
not held by the auxiliary driver registration context. The unregister
path continues to unload representors synchronously.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 8f656253981b..f26d1652dd05 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -4563,6 +4563,38 @@ mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,

[ ... ]

> +static void mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
> +{
> +	mlx5_esw_reps_block(esw);
> +	mlx5_eswitch_reload_reps_blocked(esw);
> +	mlx5_esw_reps_unblock(esw);
> +}
> +
>  static void
>  mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
>  					const struct mlx5_eswitch_rep_ops *ops,
> @@ -4574,6 +4606,8 @@ mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
>  		mlx5_esw_reps_block(esw);
>  	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
>  	mlx5_esw_reps_unblock(esw);
> +
> +	mlx5_esw_add_work(esw, mlx5_eswitch_reload_reps);

The return value of mlx5_esw_add_work() is discarded here.

Looking at mlx5_esw_add_work():

    static int mlx5_esw_add_work(struct mlx5_eswitch *esw,
                                 void (*func)(struct mlx5_eswitch *esw))
    {
            struct mlx5_host_work *host_work;

            host_work = kzalloc_obj(*host_work, GFP_ATOMIC);
            if (!host_work)
                    return -ENOMEM;
            ...
    }

the allocation is GFP_ATOMIC and can fail, in which case no work is
queued.

If mlx5_esw_add_work() returns -ENOMEM while the E-Switch is already in
MLX5_ESWITCH_OFFLOADS mode, the reload that mlx5_eswitch_reload_reps()
was meant to perform never runs, so the newly registered rep type will
not be loaded for the already-enabled vports — which is the exact case
this commit is introducing infrastructure to handle.

Registration still returns success to the auxiliary driver
(mlx5e_rep_probe / mlx5r_rep_probe), with no log message, no retry, and
no way for the caller to notice the dropped reload.

The other existing caller, mlx5_esw_funcs_changed_handler(), does check
the return value of mlx5_esw_add_work(), suggesting allocation failure
is expected to be handled.

Should this call check the return value and at least emit a warning or
retry, so that a GFP_ATOMIC allocation failure during switchdev-mode
registration does not silently leave the representors unloaded?

>  }
>  
>  void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,

