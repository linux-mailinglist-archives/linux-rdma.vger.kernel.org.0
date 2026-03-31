Return-Path: <linux-rdma+bounces-18822-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPElEMosy2n8EQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18822-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 04:09:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC9A3634C6
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 04:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F531305E9BE
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 02:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC186366DCF;
	Tue, 31 Mar 2026 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTMD/ypE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84231352D;
	Tue, 31 Mar 2026 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922894; cv=none; b=QrFLaBWI6ekMnPxtHKAPFrgv5xfeq8WUWSgFqZPMZB8cqOu8ujC02IusDqIC7May/TUTEOY0S6lq9Hxssgp605BGPsiTJl2hVXbiuuOCt8HN2BEh0Q4g7pXSaNVBaV+Jht2fMEPlWhUzUtaW0N3FI/GL9FQjEHjFqZkn22S9qIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922894; c=relaxed/simple;
	bh=2OGwww/ZGCDPrRMGsKihmdhNNNsk/4hydMXJSXnUs8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u09SRMXFS5jCt+FhKLdfqQ9W3aG/WzdBcwvI18wvf4nFNkXvE1HYJ0Nb6N4BDBK588KKr9FtaDOuhrQyd+Qj1y8lrCJd0I0quo81yiDpbStACIuMWeR6GopGWqVyGFFwvVLi3rn6P4w4ppTXa6OG+Kao84m/7zxzOVptEKfFAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTMD/ypE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C4AC4AF0B;
	Tue, 31 Mar 2026 02:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922894;
	bh=2OGwww/ZGCDPrRMGsKihmdhNNNsk/4hydMXJSXnUs8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTMD/ypEavuPD5GRUzpjK+FbkK7AKCa7/FlXVYK+JwRPQTIV0i4kHRgKNsb7IWJhL
	 RftZsmBgUm6haqQ/gQix3xQ408PNbQkUgCsZm9MXEiU0rjeC6pR3Krp31DhjbJjSjs
	 lvlHwBodHJDY3QBRJBvRphWDQHM25MzKDhkPRr0y5b+n8zTN+D+zuP23qXB/W4KoRu
	 S5AUUBnikIuUcJ0CG7haI12x2Kw78rrRJKFUJgL6RRvD7gl74Ow+PEsfya0C1EJ10h
	 KnQQ4g5MS7QG/MaksCg6NWcPpVC6Dtl4RYcGXAcIt+Lo5xK2vucsdIsd4JNT+LCI6m
	 QAf2PewF0rzpw==
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
Subject: Re: [PATCH net-next V9 04/14] devlink: Decouple rate storage from associated devlink object
Date: Mon, 30 Mar 2026 19:08:10 -0700
Message-ID: <20260331020810.3524941-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326065949.44058-5-tariqt@nvidia.com>
References: <20260326065949.44058-5-tariqt@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-18822-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: DCC9A3634C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
devlink: Decouple rate storage from associated devlink object

Devlink rate leafs and nodes were stored in their respective devlink
objects pointed to by devlink_rate->devlink.

> diff --git a/net/devlink/rate.c b/net/devlink/rate.c
> index 4781429109195..9ebbc72130c6a 100644
> --- a/net/devlink/rate.c
> +++ b/net/devlink/rate.c
[ ... ]
> @@ -648,8 +702,9 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto err_rate_set;
>  
>  	refcount_set(&rate_node->refcnt, 1);
> -	list_add(&rate_node->list, &devlink->rate_list);
> +	list_add(&rate_node->list, &rate_devlink->rate_list);
>  	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
> +	devl_rate_unlock(devlink);
>  	return 0;
>  
>  err_rate_set:
>  	ops->rate_node_del(rate_node, rate_node->priv, info->extack);
> @@ -658,6 +713,8 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
>  	kfree(rate_node->name);
>  err_strdup:
>  	kfree(rate_node);
> +unlock:
> +	devl_rate_unlock(devlink);
>  	return err;
>  }

If devlink_nl_rate_set() fails after it successfully sets the parent node
and increments the parent's refcount, does this error path permanently
leak that reference since it frees the node without decrementing it?

[ ... ]
> @@ -716,14 +785,20 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
>  		      struct devlink_rate *parent)
>  {
>  	struct devlink_rate *rate_node;
> +	struct devlink *rate_devlink;
>  
> +	rate_devlink = devl_rate_lock(devlink);
>  	rate_node = devlink_rate_node_get_by_name(devlink, node_name);
> -	if (!IS_ERR(rate_node))
> -		return ERR_PTR(-EEXIST);
> +	if (!IS_ERR(rate_node)) {
> +		rate_node = ERR_PTR(-EEXIST);
> +		goto unlock;
> +	}
>  
>  	rate_node = kzalloc_obj(*rate_node);
> -	if (!rate_node)
> -		return ERR_PTR(-ENOMEM);
> +	if (!rate_node) {
> +		rate_node = ERR_PTR(-ENOMEM);
> +		goto unlock;
> +	}
>  
>  	if (parent) {
>  		rate_node->parent = parent;
> @@ -737,12 +812,15 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
>  	rate_node->name = kstrdup(node_name, GFP_KERNEL);
>  	if (!rate_node->name) {
>  		kfree(rate_node);
> -		return ERR_PTR(-ENOMEM);
> +		rate_node = ERR_PTR(-ENOMEM);
> +		goto unlock;
>  	}

Similarly, if kstrdup() fails here, does this leak the parent's refcount
since it was already incremented earlier in the function?

