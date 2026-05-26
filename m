Return-Path: <linux-rdma+bounces-21297-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJMVF++pFWqJXAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21297-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:10:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EC25D7272
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C585301303D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3962C0F84;
	Tue, 26 May 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Z5SavboQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11E3FDBF3
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804441; cv=none; b=D40y+KJ0lV4IToJATy3NUhPjbNXaXmWJnhaTYUMQI6mZjTxX4nL2bYdGs+ovZzaFonWDUMMN0cPbgXkW23Vknw3jDOM3LSqdcvxx1MMH7v1LfTWhCZTfG1ZB4rZ+m7+NvecYXDCxyh6LzJVqFVOU95b8RQQd0+bVy7rl1YX/MxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804441; c=relaxed/simple;
	bh=T1UqiNTVmB4/tDb0kiqnEMrv4GrgBQEv5c3B2KoOQ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZn2gAnPyeENrDUtK2yUA2fr+JwNSpwq9xgOejp0SfZTuiwqnrvlkEcdWICJSgicTfuOCu/fg52dyLHcbUG81OiSF0iFZOeKVxkT5cDUQXtdz1vbjvQn0+nYF1WgQBQo62ak4SdU7Tr3LgL/g8/AB80AYUr9a6nO3KuCuVOvtwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Z5SavboQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44e1860558fso6809169f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779804435; x=1780409235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdJEpA7bMT8GO5yFBjPJn50s6+iOwqU78oJOnULy2Sc=;
        b=Z5SavboQ8OfmgiOMXeMNLttL+ek46pq6N4vtuNm9QxlcqyoOI4xJyW3JUZG+p51Iq9
         QMpNll0CyQ7obzOu1z02CyKJlMRH4ez2ray5djb2y+6XJviSdoBqUwHeiw7XQ9g4ZW2c
         5vYCAp51dZy7ulO6W3/L4QsNanzQppg890v77m2d3IyoPIeEaSxs/EvNNnDtCDSbR48a
         RbVc6uVLoii+CHswDM2ALLCNDuY4hk1VBDapcOMEG+06DWvPdGGxrWGn7eJxjAaFIqAG
         GU/5DNQcXVGWtcD4hcGz7QQaMjMnHes+hbrcu2vbn0EGPfjWT8sbKtZaGmv8fC/FzMdr
         Cn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804435; x=1780409235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdJEpA7bMT8GO5yFBjPJn50s6+iOwqU78oJOnULy2Sc=;
        b=p0yyYYhbLm15YyDm3btLHGj+zMBABKlBpmzrlDlz/dN8gHqdncZkavZChFdVwO8k0A
         rGF9E3xj6ktxvZAmgvT/B8LnQdoBXnd1mFrm3/OQWu5jBD7Pde2pUwrLvcuCV3owmqgk
         XlIvDio74/p9/BrE23eS2PHlqDurSf4u+YSlWEppYh3pJC3ip8x7/gXOOfG7J+UOPLP8
         zeDyPjPGpvA6MZ0cCs3qcoCzXCF9escSKH3mby1H+qH9WQHyt6owlseD/6GrXnRN1yQ+
         NW8FrgCERE6PGoHiBrZ6/4jotamvfLTpWQOCkJxhmQYVSMjQJ3OgK1df0HAyZcWqEqEX
         uO5A==
X-Forwarded-Encrypted: i=1; AFNElJ+yUt5EIh8pXeLL6oeagWpPCchk6IbGbjpYMITItb2iVl1rZCmtxxw6a1aVt3/AN+oWrhRr274LdxMr@vger.kernel.org
X-Gm-Message-State: AOJu0YzDLYZQdEOjvSG3IYUwvKZzbCQq3CxawN/GUyGQyeC+RBYggXvV
	TtwNPM0zC48ud2cSaSg6np/01qsWFTsfvEDtLcE5pQ0GBWMmPQbrU4K0BaDDclgwXoI=
X-Gm-Gg: Acq92OFuiV6tme4HBPuWpRhkaWLFymOAD2hLcOxU1nMmGdG56rKdgjwoh5O2THrXfFR
	OHd7425gufrPZHZA7nzZ1yngbU4H86RASQXuS9Fr8Ia5Edi8Ywv88lZkYnfvdRZIETdL8cvNpL1
	cXb5BeKmvbBAugwV/0334zENSY/qI8SvtwjkCsVbhI1E8kyEyJf0ERo06Z0ee4A0b1YcNngo0/u
	yVYTajfLtPOJpxjTH7ABQwW8F7GuvXxUlaqUy4Q/dNOhruSBcH+NBgPvtm/f9cDefGK8NCrJ4Pe
	8tVFwQcERV1T6PNj6mO+VJIQ5JNvIUe4bzGoctC/GmRdVLMh4CUqlCyNRRHQJrpGvxSkH36U7n1
	87mTzzaoiJxf3ExkcRhIs6ZVrQi76udt5JpgTKvwygua07e4mVjcBEG6qW6cDANCf2Hw9wWan9T
	Xpeo5392wGA6XO1bFbhTz/MColGIQ4NZVy
X-Received: by 2002:a05:6000:2003:b0:43b:4136:1e6f with SMTP id ffacd0b85a97d-45eb38e4b46mr32483028f8f.38.1779804435027;
        Tue, 26 May 2026 07:07:15 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4ca0dsm35432258f8f.18.2026.05.26.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:07:14 -0700 (PDT)
Date: Tue, 26 May 2026 16:07:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Li RongQing <lirongqing@baidu.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch
 mode during init
Message-ID: <ahWm4NXph9gdazV_@FV6GYCPJ69>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com>
 <ahVPASuh4BZGOfx0@FV6GYCPJ69>
 <8c8df8da-62a9-49e8-84eb-572d54cfeb1f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8df8da-62a9-49e8-84eb-572d54cfeb1f@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-21297-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C9EC25D7272
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, May 26, 2026 at 11:44:46AM +0200, mbloch@nvidia.com wrote:
>
>
>On 26/05/2026 10:44, Jiri Pirko wrote:
>> Thu, May 21, 2026 at 09:24:34AM +0200, tariqt@nvidia.com wrote:
>>> From: Mark Bloch <mbloch@nvidia.com>
>>>
>>> Apply devlink default eswitch mode for mlx5 devices after successful
>>> device initialization while holding the devlink instance lock.
>>>
>>> At this point the devlink instance is registered and the mlx5 devlink
>>> operations are available, so the default eswitch mode can be applied to
>>> the matching PCI devlink handle.
>>>
>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>> Reviewed-by: Shay Drori <shayd@nvidia.com>
>>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>> ---
>>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
>>> 1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>> index 0c6e4efe38c8..4528097f3d84 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>> @@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>>> }
>>>
>>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>>> +{
>>> +	struct devlink *devlink = priv_to_devlink(dev);
>>> +	int err;
>>> +
>>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>>> +		return;
>>> +
>>> +	devl_assert_locked(devlink);
>>> +	err = devl_apply_default_esw_mode(devlink);
>>> +	if (err)
>>> +		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
>>> +			       err);
>>> +}
>>> +
>>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>> {
>>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>>> @@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>> 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>>>
>>> 	mutex_unlock(&dev->intf_state_mutex);
>>> +	mlx5_devl_apply_default_esw_mode(dev);
>> 
>> I wonder how we can make this work for all. I mean, other driver would
>> silently ignore this command like arg, right? Any idea how to make all
>> drivers follow the arg from very beginning?
>> 
>
>I have a follow-up series that adds the call to all drivers which support
>setting eswitch mode. When going over the other drivers, what I found is
>that the right point to apply the default is driver specific, drivers
>I have patch for:
>
>46e16c6d9836 net: Apply devlink esw mode defaults
>ab4f54102ba9 bnxt_en: Apply devlink default eswitch mode during init
>b48cce1607bb liquidio: Apply devlink default eswitch mode during init
>4ea54b0fe04a ice: Apply devlink default eswitch mode during init
>b7faddaa1c90 octeontx2-af: Apply devlink default eswitch mode during init
>74b0c22c47b9 octeontx2-pf: Apply devlink default eswitch mode during init
>5000e4c3d768 nfp: Apply devlink default eswitch mode during init
>97a218e95e41 netdevsim: Apply devlink default eswitch mode during init
>
>I don't think doing this generically from devlink is realistic. devlink
>doesn't really know when a given driver is ready to change eswitch mode.
>Some drivers need SR-IOV state, representor setup, or other init pieces to
>be ready first, and the locking is not identical across drivers either.


Low hanging fruit would be just to call ops->eswitch_mode_set at the end
of register. Multiple reasons:

1) end of devl_register is exactly the point userspace is free to issue
   the eswitch mode set. Driver should be ready to handle it.
2) all drivers would transparently get this functionality, without
   actually knowing this kernel command line arg ever existed, without
   odd wiring call of related exported function. I prefer that stongly.
3) you should add a there warning for the case this arg is passed yet
   the driver does not implement eswitch_mode_set. User should
   get a feedback like this, not silent ignore.

The only loose end is see it the void return of devl_register().
Multiple ways to handle the possibly failed eswitch_mode_set(). I would
probably just go for pr_warn, seems to be the most correct.

Make sense?


>
>Also, since this knob is only about eswitch mode, I don't think we need to
>touch every devlink driver. Drivers that don't implement eswitch_mode_set()
>would just ignore it anyway. The follow-up only wires the default into
>drivers that actually support changing eswitch mode.
>
>Mark
>
>> 
>>> 	return 0;
>>>
>>> err_register:
>>> @@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>>> 		goto err_attach;
>>>
>>> 	mutex_unlock(&dev->intf_state_mutex);
>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>> 	return 0;
>>>
>>> err_attach:
>>> -- 
>>> 2.44.0
>>>
>

