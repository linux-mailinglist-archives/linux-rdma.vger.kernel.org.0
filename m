Return-Path: <linux-rdma+bounces-16438-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OT/LSvEgWnZJgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16438-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:47:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF4CD7101
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4907730802DF
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DF42C08A1;
	Tue,  3 Feb 2026 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XLNtWRHP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AD28BA83
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111863; cv=none; b=B3VwsNztqlGpigfGfpIaoWx92rzUizzkDShK2Du53Dcvztcwll5wF0vqvejHBpDkwKGJX0rLWoi0K0bczvDorn6USR/fnIk04Ist++28QvuIVaDdABoTPOw0PnP4L3sN+jDtBIzGlCnTJbbEmnzIon4hLdroI5Jj2UXcTVUGfas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111863; c=relaxed/simple;
	bh=+LoK5vMPKAT4d7HNt+4rYvxY6d0PqQkC7S4nBXL7pQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbHwkvjaQnKEEIkU779yUoDb37jiJz6G2G36ozfd6jnMV65Nt8/K3oCkqdHBMjyX4wvEfbbSX9zE3PixAPdf2GI7Pud0S3v6czfoRJrn64vFEzgsvxPumBan3uf8bfm7Uuyn153fi78Hf27MSckhMxAqX8+2H41P/r6FKsTveNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XLNtWRHP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432d28870ddso3314058f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 01:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770111860; x=1770716660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+mmJhBHP/2MQgA56LecZqFvpbK/EEvY+icUfVMGut74=;
        b=XLNtWRHPQYSZVfrHI+VqXUFHrGZhLu1vFVp/9VLdOdSJpYpgkqv3eXNAdbrJTAv3hs
         8bQo2vGOpf20bI2zqLEAkiHe48erDDBrZhsh+tasKB/U5wiiToiPfeLGjYWp6Uq8tKGo
         +9zmHb81094Ss2S/tnfjBJ0u1gw/9jNv7TItFVFhHUCU33mP6H2CzT7+wV1d8eW23Nk4
         1DtOBY4x1r81rIu078oQJoD0YTMkYbqgUlpdgM9LL77V2V62Jr1J9NvVM4Bhr4N4Rx2m
         NuW1uGDHnbRizg+YdshHKIkbJY8Rwo1NDL9VQ/emxuxksC0KBU+/PFVuVJtx64M3Zkjv
         zjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770111860; x=1770716660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mmJhBHP/2MQgA56LecZqFvpbK/EEvY+icUfVMGut74=;
        b=Laqodo/scvuycHqewvc8Tz7xqy84mQPGCoXw7xTyI3fJBup0fmaWlzb6Tn4cd/hUCL
         k8k9eYc2VwLXa2ksU1G/MjGuLbe6zvA1i5KiuDWFWvmn1aYqnoO6ODhnoC8UwquJ5goq
         WmmuDyeBRxyMR/OJ9BDpUyxn1Pk7qRWgY2GCFtcloScUdGr3G94c7yBAhGuA3iXG+5TI
         UNBdOBOW5VvSWiBc1EXeVYXb/vv5QPp7I6THIOfegCqr29LX9OXasNeMdFLP9E1O6lu0
         qujmrc7KENMZXnuBO/73e30vLFVZquw75r+FaD0Jh45Szf8oFPGskq967t4nSxo35q1e
         T+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXKRShTsWdug0va6tWmNY4pLsITNx7cmrVQI9hH1U6Tgfo/7SrJdKKH7C8b0Nh1HMlxgY91+itqOF/w@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZiJw5RsI45icdjGIYbCCcRJ/dVmHc9t1UzUYqyfWpwFQu7Vp
	KLExjsnhDDX8L/TnxL6LJrVb0d4N6hbamLYyKjsg5glVcxtBJtOFHIxKTddOHII7+CE=
X-Gm-Gg: AZuq6aJGhfQmXlR68Mhz9ZL1ZszBiFz5X80uueHN8/cDSAUkDSucO32Rw+pGscAxUd9
	HJk2Dpe24Gz45DXlosqFhqWM8KukAlWF7yFRPb+kzNX7hFPKm6k7nKdx3V/anZ5Uluow2/2tQFn
	YOhpJH/1YrHAIYqoiN8+ZGdmwkx1gJ2OmHMHBBSCIJMWjD6RQ2zIai7EqqffYgwaC3Y8VOf7RIp
	q/AZOiJ9ZgshANCNUqJb+80P5/4f+R/Cuo61cHcovOWGkoMwlGIDaCydoWL6B2Kin+egDA3u1OB
	+eu1OnGcwLiEvqSP9BHEwPI6eFU0SPc/E/KGpUunST3444pDrfYHZMbfA83brIl6kU/IidALEjV
	MfV6XC+wl/LSifN7hYGl/o1XsAQQSqyfbxwV2WdtakYYAD9rUNs9psB+9dwXOUc5QAkmkk5DuXt
	R/ODksPbVE4pMQ2nN5yASm8DaHGhWpLA==
X-Received: by 2002:adf:f7cc:0:b0:436:143c:c000 with SMTP id ffacd0b85a97d-436143cc130mr1101812f8f.45.1770111859982;
        Tue, 03 Feb 2026 01:44:19 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436142de842sm2407305f8f.30.2026.02.03.01.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:44:19 -0800 (PST)
Date: Tue, 3 Feb 2026 10:44:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 02/14] devlink: introduce shared devlink
 instance for PFs on same chip
Message-ID: <wdkd7yelgosii7bklmahxf5t6xnn2vydnwiiruiwqpyue722dj@yjnkcdctzeav>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
 <20260128112544.1661250-3-tariqt@nvidia.com>
 <20260202194946.64555356@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202194946.64555356@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16438-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org,infradead.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DF4CD7101
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 04:49:46AM +0100, kuba@kernel.org wrote:
>On Wed, 28 Jan 2026 13:25:32 +0200 Tariq Toukan wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Multiple PFs may reside on the same physical chip, running a single
>> firmware. Some of the resources and configurations may be shared among
>> these PFs. Currently, there is no good object to pin the configuration
>> knobs on.
>> 
>> Introduce a shared devlink instance, instantiated upon probe of the
>> first PF and removed during remove of the last PF. The shared devlink
>> instance is backed by a faux device, as there is no PCI device related
>> to it. The implementation uses reference counting to manage the
>> lifecycle: each PF that probes calls devlink_shd_get() to get or create
>> the shared instance, and calls devlink_shd_put() when it removes. The
>> shared instance is automatically destroyed when the last PF removes.
>
>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>> index cb839e0435a1..c453faec8ebf 100644
>> --- a/include/net/devlink.h
>> +++ b/include/net/devlink.h
>> @@ -1644,6 +1644,12 @@ void devlink_register(struct devlink *devlink);
>>  void devlink_unregister(struct devlink *devlink);
>>  void devlink_free(struct devlink *devlink);
>>  
>> +struct devlink *devlink_shd_get(const char *id,
>> +				const struct devlink_ops *ops,
>> +				size_t priv_size);
>> +void devlink_shd_put(struct devlink *devlink);
>> +void *devlink_shd_get_priv(struct devlink *devlink);
>
>Would Cosmin or someone else be willing to take on co-maintainership 
>of this API (including reviews of other drivers using it)?
>We could add a maintainers entry with:
>
>K:	devlink_shd_
>
>So y'all get CCed.
>
>> +#include <linux/device/faux.h>
>> +#include <net/devlink.h>
>
>> +/* This structure represents a shared devlink instance,
>> + * there is one created per identifier (e.g., serial number).
>> + */
>> +struct devlink_shd {
>> +	struct list_head list; /* Node in shd list */
>> +	const char *id; /* Identifier string (e.g., serial number) */
>
>Why does this have to be a string? The identifier should be irrelevant,
>and if something like serial number exists it can be reported in dev
>info for the shared instance?

String gives drivers flexibility to use anything. Perhaps I'm missing
your point. Are you againts free-form or just string and buf+buf_len
would be fine?


>
>> +	struct faux_device *faux_dev; /* Related faux device */
>> +	refcount_t refcount; /* Reference count */
>> +	char priv[] __aligned(NETDEV_ALIGN); /* Driver private data */
>
>size member annotated with __counted_by() is missing here

Will add.


>
>> +};
>
>> +static struct devlink_shd *devlink_shd_create(const char *id,
>> +					      const struct devlink_ops *ops,
>> +					      size_t priv_size)
>> +{
>> +	struct faux_device *faux_dev;
>> +	struct devlink_shd *shd;
>> +	struct devlink *devlink;
>> +
>> +	/* Create faux device - probe will be called synchronously */
>> +	faux_dev = faux_device_create(id, NULL, NULL);
>> +	if (!faux_dev)
>> +		return NULL;
>> +
>> +	devlink = devlink_alloc(ops, sizeof(struct devlink_shd) + priv_size,
>> +				&faux_dev->dev);
>> +	if (!devlink)
>> +		goto err_devlink_alloc;
>
>error labels should be named after the target not the source in new code

Okay. Tried to be consistent with the rest of the code. But as you wish.


>
>> +	shd = devlink_priv(devlink);
>> +
>> +	shd->id = kstrdup(id, GFP_KERNEL);
>> +	if (!shd->id)
>> +		goto err_kstrdup_id;
>> +	shd->faux_dev = faux_dev;
>> +	refcount_set(&shd->refcount, 1);
>> +
>> +	devl_lock(devlink);
>> +	devl_register(devlink);
>> +	devl_unlock(devlink);
>> +
>> +	list_add_tail(&shd->list, &shd_list);
>> +
>> +	return shd;
>> +
>> +err_kstrdup_id:
>> +	devlink_free(devlink);
>> +
>> +err_devlink_alloc:
>> +	faux_device_destroy(faux_dev);
>> +	return NULL;
>> +}
>
>> +struct devlink *devlink_shd_get(const char *id,
>> +				const struct devlink_ops *ops,
>> +				size_t priv_size)
>> +{
>> +	struct devlink_shd *shd;
>> +
>> +	if (WARN_ON(!id || !ops))
>> +		return NULL;
>
>Seems a little too defensive to check input attrs against NULL.
>Let the kernel crash if someone is foolish enough..

Okay.


>
>> +	mutex_lock(&shd_mutex);
>> +
>> +	shd = devlink_shd_lookup(id);
>> +	if (!shd)
>> +		shd = devlink_shd_create(id, ops, priv_size);
>> +	else
>> +		refcount_inc(&shd->refcount);
>> +
>> +	mutex_unlock(&shd_mutex);
>> +	return shd ? priv_to_devlink(shd) : NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(devlink_shd_get);
>> +
>> +/**
>> + * devlink_shd_put - Release a reference on a shared devlink instance
>> + * @devlink: Shared devlink instance
>> + *
>> + * Release a reference on a shared devlink instance obtained via
>> + * devlink_shd_get().
>> + */
>> +void devlink_shd_put(struct devlink *devlink)
>> +{
>> +	struct devlink_shd *shd;
>> +
>> +	if (WARN_ON(!devlink))
>> +		return;
>
>ditto

Okay.


>
>> +	mutex_lock(&shd_mutex);
>> +	shd = devlink_priv(devlink);
>> +	if (refcount_dec_and_test(&shd->refcount))
>> +		devlink_shd_destroy(shd);
>> +	mutex_unlock(&shd_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(devlink_shd_put);

