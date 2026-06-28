Return-Path: <linux-rdma+bounces-22543-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CB3iE04nQWq5lgkAu9opvQ
	(envelope-from <linux-rdma+bounces-22543-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 15:53:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD216D3F10
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 15:53:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jYPVQVfH;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22543-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22543-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B247E300D44A
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C063A451B;
	Sun, 28 Jun 2026 13:53:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA87137923;
	Sun, 28 Jun 2026 13:53:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782654787; cv=none; b=bKmGFurNE53PFJ5wzSiu9kVLQaD2kM96h3LTNGuKbDrbPjf88YSvWR1BSXLrxBkMuAgblGcVjvW6BKfclzLqTQFTBi7RZc8GWzMvjfHtkXNheLK/n88iCCe44Gp6quyeYE+/uNs54jKaXSDWw8usSCRpebj3kq0qG56Drc5treo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782654787; c=relaxed/simple;
	bh=7lPTU1d1Uw8n3KzTLi0FHJo9ZRUta/MprUwgvLmOt3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFdKdCR3IlX2PaGsbXokV0JUi4RIOlSooDJe0J1aeXqMEkVuRKeAHqFF4VynFXbhlmwFHV5j+7MKl51nVRuFkUa+kK8gnalL+IbsqE4GmJZwLKVYXqRx55x55r88qaDaAwxJvEwTsM9RmeTwfACV7zty9JwNL9Scd0DIe6g2yZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYPVQVfH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8531F000E9;
	Sun, 28 Jun 2026 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782654786;
	bh=7Tx2dsE55A7xgtcP1ElvQW1i6JCa56my3ePfCMjsOb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jYPVQVfH8eydUNI4R5Mu/O82q81bxX3A32DVSzAzeb+zWd8sHEGwQeyoFAqyNA5YC
	 +o4mH5Rl4W4v0ZdrF0XZEcXMhu5ZnkKpjoHmHfQEay/yBhh7RQcqkzGhbwYPRB7HPS
	 PZkbJ5dyCQZeE/l643t4lI22vICGKGhGIUrIazNnKV8WzGeUKQTiQc4AloOvNPLTZb
	 Pcx0/A2DpkJGFtvHTdr1HVYfcOTBYj5CfVl5zOqp82QurA9ZUokdKBVIohwp6md3vH
	 ck1eD54sdEHZ82e8O7ppPxxOLTaJxbkyLlSZxBUe6K+J5/UpAoA+zBE9LEHfm3T9zk
	 lmTnKTTVhVDUw==
Date: Sun, 28 Jun 2026 16:52:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Florian Westphal <fw@strlen.de>,
	Kees Cook <kees@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] IB/iwpm: fix memory leaks in error paths
Message-ID: <20260628135259.GA33710@unreal>
References: <20260622134553.43186-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622134553.43186-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:jgg@ziepe.ca,m:fw@strlen.de,m:kees@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22543-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,unreal:mid,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDD216D3F10

On Mon, Jun 22, 2026 at 09:45:53PM +0800, Wentao Liang wrote:
> In iwpm_register_pid(),iwpm_add_mapping() and
> iwpm_add_and_query_mapping(), when the send operations fail,
> the allocated message buffers are not freed before returning,
> causing memory leaks.
> 
> Fix this by adding proper error handling with goto labels to
> ensure kfree() is called on all error paths in both functions.
> Fixes: 30dc5e63d6a5 ("RDMA/core: Add support for iWARP Port Mapper user space service")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/infiniband/core/iwpm_msg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/iwpm_msg.c b/drivers/infiniband/core/iwpm_msg.c
> index 4625abd29ac0..bac3d1f321ab 100644
> --- a/drivers/infiniband/core/iwpm_msg.c
> +++ b/drivers/infiniband/core/iwpm_msg.c
> @@ -122,7 +122,7 @@ int iwpm_register_pid(struct iwpm_dev_data *pm_msg, u8 nl_client)
>  	pr_info("%s: %s (client = %u)\n", __func__, err_str, nl_client);
>  	dev_kfree_skb(skb);
>  	if (nlmsg_request)
> -		iwpm_free_nlmsg_request(&nlmsg_request->kref);
> +		kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
>  	return ret;
>  }
>  
> @@ -207,7 +207,7 @@ int iwpm_add_mapping(struct iwpm_sa_data *pm_msg, u8 nl_client)
>  add_mapping_error_nowarn:
>  	dev_kfree_skb(skb);
>  	if (nlmsg_request)
> -		iwpm_free_nlmsg_request(&nlmsg_request->kref);
> +		kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);

We already discussed this change.
https://lore.kernel.org/linux-rdma/20260608183438.GA95325@nvidia.com/

Thanks

>  	return ret;
>  }
>  
> @@ -296,7 +296,7 @@ int iwpm_add_and_query_mapping(struct iwpm_sa_data *pm_msg, u8 nl_client)
>  query_mapping_error_nowarn:
>  	dev_kfree_skb(skb);
>  	if (nlmsg_request)
> -		iwpm_free_nlmsg_request(&nlmsg_request->kref);
> +		kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
>  	return ret;
>  }
>  
> -- 
> 2.39.5 (Apple Git-154)
> 

