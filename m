Return-Path: <linux-rdma+bounces-18823-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDONAaQsy2n8EQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18823-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 04:08:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B968D36349B
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 04:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1B063046DA1
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 02:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3FE366DB9;
	Tue, 31 Mar 2026 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVlsqoOQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AD36681B;
	Tue, 31 Mar 2026 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922899; cv=none; b=RL8zB2GHT8AFjZx/NeZTLA7dE6vfCacnzKiscL/lZI1JOFTsKaFWCBHFxQOKvfmit48SWb1T3IijABp3C7YTcccRtPCIG0ThmETycWqn6L7Wk8reaq4BwovvmKkC52AX1eZ+9h3I9wMoUnEZ40GGJAM9kQNCvQxeyVIyTBHCsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922899; c=relaxed/simple;
	bh=0/HlB/XC232tGSsyIIb4yW7Si9P7zTLBaKbCcQgaRIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0XtXC06N+N66gzNn9MUsekW2MD0lqP4adSwtrwobCB0y5KEVZOFiouK79eIB2cnH4yZF8cMoykaHY+EXY58tSQBVuhAaFAeqluVmsxbqv4/xYIkbxKfYkX6s0qfIdOJRL1mL6qvRpMO2B88jsTuj6DV09oxqf3Xbu4owgbOZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVlsqoOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E68C2BCB2;
	Tue, 31 Mar 2026 02:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922897;
	bh=0/HlB/XC232tGSsyIIb4yW7Si9P7zTLBaKbCcQgaRIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jVlsqoOQVCwSTDgL9d9ni0UG+RN3N5GOJ3zEarKMLNy2Zv48mtr6K+4pwkn0yRWjs
	 9zfKSmSR8S/hbabNH6e2mFszx6+vo+g1HUsk349dur3X7FEzz6jVFXumFrNyGxss+s
	 drcN66MhEipwAexC2tt2Huzx8E9r4ky9hAfqicni6cBkK7VyV47kZJYjRlVlF90qLI
	 3Bhuo4BLIgDhHEpFoIdqQRXo9xe1VA5vTS2s2otE0Bcx4XMMw0+jCWOQQ7PWML3TJg
	 uE1DHypi1L3iSP100GBJ7H5RA8M6MZo/F/yGXcmFcPeOQE2useL5fclvMeMBS94A2M
	 BMFMRRX6iD9UQ==
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
Subject: Re: [PATCH net-next V9 07/14] devlink: Allow rate node parents from other devlinks
Date: Mon, 30 Mar 2026 19:08:14 -0700
Message-ID: <20260331020814.3525053-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326065949.44058-8-tariqt@nvidia.com>
References: <20260326065949.44058-8-tariqt@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,openvpn.net,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-18823-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B968D36349B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
devlink: Allow rate node parents from other devlinks

This commit makes use of the building blocks previously added to
implement cross-device rate nodes.

> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index 3038af6ec017e..8d5ad5d4f1d05 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -1585,6 +1585,11 @@ struct devlink_ops {
>  				    struct devlink_rate *parent,
>  				    void *priv_child, void *priv_parent,
>  				    struct netlink_ext_ack *extack);
> +	/* Indicates if cross-device rate nodes are supported.
> +	 * This also requires a shared common ancestor object all devices that
> +	 * could share rate nodes are nested in.
> +	 */
> +	bool supported_cross_device_rate_nodes;

When a device acting as a cross-device rate parent is destroyed,
devl_rate_nodes_destroy() iterates the shared rate_list to detach its
children. If it encounters a child rate node belonging to a different device,
it invokes the child driver's ops->rate_node_parent_set or
ops->rate_leaf_parent_set callbacks.

Since the cleanup path only holds the parent's devlink lock and the shared
root devlink lock, does this allow the child driver's rate operations to
execute concurrently with other operations on the child device without holding
the child's devlink instance lock?

[ ... ]
> diff --git a/net/devlink/rate.c b/net/devlink/rate.c
> index 1949746fab291..f243cccc95bee 100644
> --- a/net/devlink/rate.c
> +++ b/net/devlink/rate.c
> @@ -30,19 +30,53 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
>  	return devlink_rate ?: ERR_PTR(-ENODEV);
>  }
>  
> +/* Repeatedly locks the nested-in devlink instances while cross device rate
> + * nodes are supported. Returns the devlink instance where rates should be
> + * stored.
> + */
>  static struct devlink *devl_rate_lock(struct devlink *devlink)
>  {
> -	return devlink;
> +	struct devlink *rate_devlink = devlink;
> +
> +	while (rate_devlink->ops &&
> +	       rate_devlink->ops->supported_cross_device_rate_nodes) {
> +		devlink = devlink_nested_in_get_lock(rate_devlink->rel);
> +		if (!devlink)
> +			break;
> +		rate_devlink = devlink;
> +	}
> +	return rate_devlink;
>  }

[ ... ]

> +/* Repeatedly unlocks the nested-in devlink instances of 'devlink' while cross
> + * device nodes are supported.
> + */
>  static void devl_rate_unlock(struct devlink *devlink)
>  {
> +	if (!devlink || !devlink->ops ||
> +	    !devlink->ops->supported_cross_device_rate_nodes)
> +		return;
> +
> +	devl_rate_unlock(devlink_nested_in_get_locked(devlink->rel));
> +	devlink_nested_in_put_unlock(devlink->rel);
>  }

If a parent devlink is not yet registered, devlink_nested_in_get_lock() can
return NULL in devl_rate_lock() and break the loop without taking a lock.

If another thread completes registering the parent devlink concurrently,
devlink_nested_in_get_locked() in devl_rate_unlock() will find it. 

Could this lead to unlocking a mutex that was never acquired and dropping a
reference that was never taken, resulting in a use-after-free or lock
corruption?

[ ... ]
> @@ -320,13 +371,14 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
>  				struct genl_info *info,
>  				struct nlattr *nla_parent)
>  {
> -	struct devlink *devlink = devlink_rate->devlink;
> +	struct devlink *devlink = devlink_rate->devlink, *parent_devlink;
>  	const char *parent_name = nla_data(nla_parent);
>  	const struct devlink_ops *ops = devlink->ops;
>  	size_t len = strlen(parent_name);
>  	struct devlink_rate *parent;
>  	int err = -EOPNOTSUPP;
>  
> +	parent_devlink = devlink_nl_ctx(info)->parent_devlink ? : devlink;
>  	parent = devlink_rate->parent;
>  
>  	if (parent && !len) {
> @@ -344,7 +396,13 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
>  		refcount_dec(&parent->refcnt);
>  		devlink_rate->parent = NULL;
>  	} else if (len) {
> -		parent = devlink_rate_node_get_by_name(devlink, parent_name);
> +		/* parent_devlink (when different than devlink) isn't locked,
> +		 * but the rate node devlink instance is, so nobody from the
> +		 * same group of devices sharing rates could change the used
> +		 * fields or unregister the parent.
> +		 */
> +		parent = devlink_rate_node_get_by_name(parent_devlink,
> +						       parent_name);

Is parent_devlink validated to ensure it shares the same common rate root
ancestor as devlink?

If an arbitrary unrelated parent_devlink is specified,
devlink_rate_node_get_by_name() could traverse an unrelated parent's
rate_list that was never locked by devl_rate_lock(), leading to a data race.

Additionally, if a rate node is found, its priv pointer is passed to the
target driver's ops->rate_node_parent_set. Could this cause the target driver
to cast a foreign priv pointer to its own private struct type, resulting in
type confusion and memory corruption?

