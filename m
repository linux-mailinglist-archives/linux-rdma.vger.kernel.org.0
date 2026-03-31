Return-Path: <linux-rdma+bounces-18825-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEzqJVcty2n8EQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18825-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 04:11:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 372E0363519
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 04:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D5E3094D2F
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 02:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B12368964;
	Tue, 31 Mar 2026 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7eLPna2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961036826D;
	Tue, 31 Mar 2026 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922904; cv=none; b=cBogbtRWyqTMpYGIcbUNhhv4AnS4ZVYHgRG6Utr2t9+rZJaltBc93k1k8HIPomzzjLNeDIuGHlP/3VU89FDYwoQVUPh5eRtgce23XOC2AkXiXuY76fbugRfqGYYjMjAG5DwM2hNnVmh1UKUkRRyC26f+0YxhX7fnhAnVj2S7JYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922904; c=relaxed/simple;
	bh=Ti2rwlshDR79ZI/BGbAVD6CjcN6oVYO5Ai7SaqZamXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNLaDul7WptmxNAVeY5NPcA3A6KdDiSlMQRoCJh6P4f/5Yy+rDrHEktMdL+Hr4f1/J5Ce0cYyq5R8RsOkgvyyhFMRsB5Is0QLDaoJLcz0DGNmGV6RRxbwsR+tnIONvUSU+HQ7UOz6dEZPHapYpe66kNGp6c8A6Sg6Yi7j4Sbr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7eLPna2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B8FC19423;
	Tue, 31 Mar 2026 02:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922903;
	bh=Ti2rwlshDR79ZI/BGbAVD6CjcN6oVYO5Ai7SaqZamXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7eLPna2zLPQvleiKAUeNeTyNuhbmXZy6joPxF+meNPF0vuJq0MP7KczjS5CMpASR
	 XjUxBemZlQu8OMqjojw8eVLh2Z+fWu++qcCB2q2fsM2PmUhbsznMl9/bUOgsv4AuLZ
	 9yS0IjOuMWJyrRNr+I5rDK1RWlwH24ISao6FdTlK2ol+I5FW20vb5kLL3Zv3+dDtZ+
	 IyKPUzKevuDXOj+cGRrv8+PsmMVb0P86T08oXiP5/dtOiwor8ewxi17EQRCG5bF91l
	 VA4Wd1CekwLXgI868pwSzAGrXVNu3/cf+EW6gv5EZ73fQxT4aV/wONbDKHT1rVBIb9
	 PEUVRy4ipgjkA==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	horms@kernel.org,
	jiri@resnulli.us,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	shuah@kernel.org,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	cratiu@nvidia.com,
	dtatulea@nvidia.com,
	jacob.e.keller@intel.com,
	shshitrit@nvidia.com,
	daniel.zahka@gmail.com,
	parav@nvidia.com,
	ajayachandra@nvidia.com,
	kees@kernel.org,
	shayd@nvidia.com,
	danielj@nvidia.com,
	moshe@nvidia.com,
	willemb@google.com,
	dw@davidwei.uk,
	petrm@nvidia.com,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	joe@dama.to,
	razor@blackwall.org,
	vadim.fedorenko@linux.dev,
	mst@redhat.com,
	antonio@openvpn.net,
	allison.henderson@oracle.com,
	minhquangbui99@gmail.com,
	noren@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	gal@nvidia.com,
	jiri@nvidia.com
Subject: Re: [PATCH net-next V9 12/14] net/mlx5: qos: Support cross-device tx scheduling
Date: Mon, 30 Mar 2026 19:08:20 -0700
Message-ID: <20260331020820.3525138-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326065949.44058-13-tariqt@nvidia.com>
References: <20260326065949.44058-13-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,openvpn.net,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-18825-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 372E0363519
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5: qos: Support cross-device tx scheduling

This commit relaxes the restriction that rate groups can only contain vports
from the same E-Switch. It enables cross-device TX scheduling if the hardware
supports it, LAG is enabled, and the E-Switches share a devlink device.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c

[ ... ]

> @@ -1738,18 +1761,44 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
>  	return 0;
>  }
>  
> +static int
> +mlx5_esw_validate_cross_esw_scheduling(struct mlx5_eswitch *esw,
> +				       struct mlx5_esw_sched_node *parent,
> +				       struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	if (!mlx5_lag_is_active(esw->dev)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cross E-Switch scheduling requires LAG to be activated");
> +		return -EOPNOTSUPP;
> +	}

What happens to the cross-device rate scheduling if LAG is deactivated
after the configuration is applied?

When LAG is deactivated, the LAG state is torn down in hardware, but there
does not appear to be a corresponding cleanup or update triggered for the
cross-eswitch QoS scheduling elements.

Could this result in a regression where the hardware TSAR tree and devlink
rate configuration remain pointing to a now-invalid VHCA association,
bypassing the state validation and causing traffic drops or firmware errors?

> +
> +	return 0;
> +}

