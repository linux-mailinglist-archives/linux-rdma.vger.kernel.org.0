Return-Path: <linux-rdma+bounces-16384-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCa1OGRwgWlLGQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16384-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 04:49:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC6D437D
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 04:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C935E3007215
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 03:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779530FC3C;
	Tue,  3 Feb 2026 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFspSqr9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988A201278;
	Tue,  3 Feb 2026 03:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770090589; cv=none; b=mcmNQCkEt0KwkWrohEeAU9kA6SGNZaW+wgny+tHvhbP3xGIKkwRQe5MXFr7/nmCntp0wNZHx8uJM9Iaij4hvrckOkpluomv/aWt97u51LVylr863USPsCjmGP7QsUNSYvONDTnscfwDTepyEdnufQ1Bs2paFkfWCxDmVeGzb2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770090589; c=relaxed/simple;
	bh=3sqcoPOsBwxpf2e/fd6p4srqKfoSP6kirvHZkLepaGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDpnlo6VEJTxhVRVOTKD+ZZLQlQOIfkd3u0V+yoJjsg8v0Uw+ZkNl/Lv2LgILkOZKr3uc4Cyk4fLqoyELt9aJBLe8I/A1Q7P5/zpmto5M6cD+3eYXqEaruRF/ProSuJ6s6n2+MZnHkxEifuqtKBtN53w0j9/GsY2vsJ9815bCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFspSqr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE5EC116D0;
	Tue,  3 Feb 2026 03:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770090588;
	bh=3sqcoPOsBwxpf2e/fd6p4srqKfoSP6kirvHZkLepaGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hFspSqr9ZbD53xkOyl/RRHdvyVMNiemeQbO35VADs/UyJoYeIAvYi3HlXBFoOjsrh
	 J4TZCePT33cKkR2POcSuo9cEj61AMoDZpiYSvrjIuEA180mhd5XTq3kOMpCxykHe8b
	 D4MMi434NBPup1S+zOLZcz6OKib+v5y95TpaNOzEEm75QMKULpMZ2tQPDqGpTtfWxw
	 jJAYjSkSyf+zw1iGQUwoMdktZ1l5sPD8A9PaKcUvbHoCbeg2GnX8q1qPymW488wlxL
	 q1UV8bylfqhSm8iA+OWSFWNH4Gr+7fb5trL+ymdizonPMbAGxL1v5amL9OSi7KjIbG
	 +f+4TBoJKPk2Q==
Date: Mon, 2 Feb 2026 19:49:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
 <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 02/14] devlink: introduce shared devlink
 instance for PFs on same chip
Message-ID: <20260202194946.64555356@kernel.org>
In-Reply-To: <20260128112544.1661250-3-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
	<20260128112544.1661250-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16384-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 5EBC6D437D
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 13:25:32 +0200 Tariq Toukan wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Multiple PFs may reside on the same physical chip, running a single
> firmware. Some of the resources and configurations may be shared among
> these PFs. Currently, there is no good object to pin the configuration
> knobs on.
> 
> Introduce a shared devlink instance, instantiated upon probe of the
> first PF and removed during remove of the last PF. The shared devlink
> instance is backed by a faux device, as there is no PCI device related
> to it. The implementation uses reference counting to manage the
> lifecycle: each PF that probes calls devlink_shd_get() to get or create
> the shared instance, and calls devlink_shd_put() when it removes. The
> shared instance is automatically destroyed when the last PF removes.

> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index cb839e0435a1..c453faec8ebf 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -1644,6 +1644,12 @@ void devlink_register(struct devlink *devlink);
>  void devlink_unregister(struct devlink *devlink);
>  void devlink_free(struct devlink *devlink);
>  
> +struct devlink *devlink_shd_get(const char *id,
> +				const struct devlink_ops *ops,
> +				size_t priv_size);
> +void devlink_shd_put(struct devlink *devlink);
> +void *devlink_shd_get_priv(struct devlink *devlink);

Would Cosmin or someone else be willing to take on co-maintainership 
of this API (including reviews of other drivers using it)?
We could add a maintainers entry with:

K:	devlink_shd_

So y'all get CCed.

> +#include <linux/device/faux.h>
> +#include <net/devlink.h>

> +/* This structure represents a shared devlink instance,
> + * there is one created per identifier (e.g., serial number).
> + */
> +struct devlink_shd {
> +	struct list_head list; /* Node in shd list */
> +	const char *id; /* Identifier string (e.g., serial number) */

Why does this have to be a string? The identifier should be irrelevant,
and if something like serial number exists it can be reported in dev
info for the shared instance?

> +	struct faux_device *faux_dev; /* Related faux device */
> +	refcount_t refcount; /* Reference count */
> +	char priv[] __aligned(NETDEV_ALIGN); /* Driver private data */

size member annotated with __counted_by() is missing here

> +};

> +static struct devlink_shd *devlink_shd_create(const char *id,
> +					      const struct devlink_ops *ops,
> +					      size_t priv_size)
> +{
> +	struct faux_device *faux_dev;
> +	struct devlink_shd *shd;
> +	struct devlink *devlink;
> +
> +	/* Create faux device - probe will be called synchronously */
> +	faux_dev = faux_device_create(id, NULL, NULL);
> +	if (!faux_dev)
> +		return NULL;
> +
> +	devlink = devlink_alloc(ops, sizeof(struct devlink_shd) + priv_size,
> +				&faux_dev->dev);
> +	if (!devlink)
> +		goto err_devlink_alloc;

error labels should be named after the target not the source in new code

> +	shd = devlink_priv(devlink);
> +
> +	shd->id = kstrdup(id, GFP_KERNEL);
> +	if (!shd->id)
> +		goto err_kstrdup_id;
> +	shd->faux_dev = faux_dev;
> +	refcount_set(&shd->refcount, 1);
> +
> +	devl_lock(devlink);
> +	devl_register(devlink);
> +	devl_unlock(devlink);
> +
> +	list_add_tail(&shd->list, &shd_list);
> +
> +	return shd;
> +
> +err_kstrdup_id:
> +	devlink_free(devlink);
> +
> +err_devlink_alloc:
> +	faux_device_destroy(faux_dev);
> +	return NULL;
> +}

> +struct devlink *devlink_shd_get(const char *id,
> +				const struct devlink_ops *ops,
> +				size_t priv_size)
> +{
> +	struct devlink_shd *shd;
> +
> +	if (WARN_ON(!id || !ops))
> +		return NULL;

Seems a little too defensive to check input attrs against NULL.
Let the kernel crash if someone is foolish enough..

> +	mutex_lock(&shd_mutex);
> +
> +	shd = devlink_shd_lookup(id);
> +	if (!shd)
> +		shd = devlink_shd_create(id, ops, priv_size);
> +	else
> +		refcount_inc(&shd->refcount);
> +
> +	mutex_unlock(&shd_mutex);
> +	return shd ? priv_to_devlink(shd) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(devlink_shd_get);
> +
> +/**
> + * devlink_shd_put - Release a reference on a shared devlink instance
> + * @devlink: Shared devlink instance
> + *
> + * Release a reference on a shared devlink instance obtained via
> + * devlink_shd_get().
> + */
> +void devlink_shd_put(struct devlink *devlink)
> +{
> +	struct devlink_shd *shd;
> +
> +	if (WARN_ON(!devlink))
> +		return;

ditto

> +	mutex_lock(&shd_mutex);
> +	shd = devlink_priv(devlink);
> +	if (refcount_dec_and_test(&shd->refcount))
> +		devlink_shd_destroy(shd);
> +	mutex_unlock(&shd_mutex);
> +}
> +EXPORT_SYMBOL_GPL(devlink_shd_put);

