Return-Path: <linux-rdma+bounces-22943-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eWyNLXRvT2qfggIAu9opvQ
	(envelope-from <linux-rdma+bounces-22943-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:52:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF4272F267
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:52:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=bMxSyS0j;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22943-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22943-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57F37301F582
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40313F9F21;
	Thu,  9 Jul 2026 09:52:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80E3E4C70
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 09:52:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590755; cv=none; b=UzaAfaCxXNz2JIShtl8GAwY0yIvIlz0K8OUFneFHBpZU8ss8m6cx0pHMEPaNQc1WT0yXzarKNvXP8adu22ji3IxkHHOlBiJ46rLK4vZi8X4d0/GIT6BIz0RSJENQbKUKB3mbzsIFOx9UvYBm9WDl3JLX0I/LgLezYDIh5nsJ9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590755; c=relaxed/simple;
	bh=iQNrGVvv3ujLtkwmKctK+PWCeJB+Z38/i3Nxrwmlsrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKDFfhPN8mz+NTIv0adJ2xVJIB0O/PwioaX9mcrJ07fo8KI5Gd6itjksCs1XST1CCIxDx4q3swuYDlpXp+KLUrwpyqGHVV0yZP7b/4ROp78oKC4BhmMGSPMDtOorv5c7nLLbmwZwzOdKClkaQVGNkku7DjZq7qbiGa1CG0JPc88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=bMxSyS0j; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b77b150aso13103325e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2026 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590752; x=1784195552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cmUvpg/LGglbFmX5TbG8S8cuP4tLEOPmrTkk7nQFQLo=;
        b=bMxSyS0jwGsmJ9MuQogJyBz3F63LUvsACq+qyW5SuL5TGiMrFn6oWnP1raMt0zSqOs
         KPCHAvEOkvHnkgapRFG3coOIo2t7LdYiwODMKtMHP6dhftejtSoBSnC6yt57SoDVYGyS
         SkhTVmOi6VM6+P3CGSP2ryQE6Iv+vEm5x5RL8J8gMojBQuvog5v3dyC+em/tw/nGQ1rx
         ewWmylZPOhEYFoL16n5oSCbtFWL0GWF8MDYlBlw3QRnx75eWGNeE4EdAJcgZMd+U8wGb
         f1z2SUs+qsLUakRRl5k/M/CdjDwr5+6vDIdpXVIdWMeXsbGrfpJmIkoxrfLaCzmfpliB
         iErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590752; x=1784195552;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cmUvpg/LGglbFmX5TbG8S8cuP4tLEOPmrTkk7nQFQLo=;
        b=gicgW7zqD9WWV4+HPevJjeiiKuQ2h9T4089Aeby+iS2EbZxqJvKH4wxITZm0hG0fqi
         ntotsXphbdno8lRAjobNFP+Y4Y75udK8QWK9srzRRaEvd+BgLBSbdPqJF5AZ8U4fv7h8
         qXFTn58P7BPUqYx8thy8poyuqugjgPwF9U1olRYpNA+E2CLB8sWjSZtVtqM0yeXtEs95
         C0NAXEZXijerr5Qh95s41LSqeg0upKe+bSWW78a6QmphZeRGheP8JkK8BaWrTRW+bcos
         2ciOUa6PwAvArnS0OOPzAfBaSFeeipT1ZZNUAoMUV82yJNUOmsgQ3b28wgHTt/tHMOqW
         CfmA==
X-Forwarded-Encrypted: i=1; AHgh+RrFu9GtbzF1b5QOWh5f5tyCH31vdhoeltju7GKat2FpbE8Wj3X2k8xWwonW1Pzh5H5hJ3/A8l0VmY7b@vger.kernel.org
X-Gm-Message-State: AOJu0YxnyR8f8WF7O38d2ARr/bY4E3qGoH6pBfxKXCA2hDWq1CGgU+Fg
	JUI7QJOEloZ56P2yD7r5fFd5O+lrg6xAYNJGeIv+FEZGzxwV8Vwq/nvyum31ki2ox+U=
X-Gm-Gg: AfdE7ckWcdTMEcjXtiDzybeqkcIZoecSpqlWgMvIRi0SysLpqsdZDqfamLKIy7RYTD3
	B0ysz101YiizgKVMaUumtTqmviDn6cvIM8JHychvzxELr3qVYDoAHCGaJqyzcrC9rQDEzjxdafR
	8z15ESxV1JYz3+uZ0zBM0IPvMfEvbQa3RUOArQ/CHJ+FGE4VCR29AWF0f/zrYkDVmJDmRIwNAFE
	+coEkhGx8oS0Zal5N02tvE6o7SgjYs8HES1hDdPRlJmTysg0zewRcY1mg42GTDgcbMJhMAffT/B
	W1dAlufQWxpfE0uEKWgVLtdpJPhCIILA5btiTvW0oBtzLNmttrlOuQxyKLmn7h6tqhTDtWVeDep
	fbn/xj++T+ZelbXkcuR9qSan3BEJhpzq0q13Utw72HP8BwLqO4NgVMOZ0xY6EXAHOB6MJDEfdMV
	px4dJ+twTUC9muXWdWSFAk62w0vSeivs3e
X-Received: by 2002:a05:600c:3111:b0:493:aab3:c09c with SMTP id 5b1f17b1804b1-493e6a4a8b1mr61043955e9.28.1783590752378;
        Thu, 09 Jul 2026 02:52:32 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm53652344f8f.1.2026.07.09.02.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:52:31 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:52:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V5 6/6] net/mlx5: Apply devlink eswitch mode
 boot default on probe
Message-ID: <ak9un-lCDmhGI9tL@FV6GYCPJ69>
References: <20260707174527.425134-1-mbloch@nvidia.com>
 <20260707174527.425134-7-mbloch@nvidia.com>
 <ak4LVcyKofmtrWcU@FV6GYCPJ69>
 <7309e57a-89bc-4e4a-97e9-d843b02efa42@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7309e57a-89bc-4e4a-97e9-d843b02efa42@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-22943-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,FV6GYCPJ69:mid,resnulli-us.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email,resnulli.us:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CF4272F267

Thu, Jul 09, 2026 at 08:00:19AM +0200, mbloch@nvidia.com wrote:
>
>
>On 08/07/2026 11:34, Jiri Pirko wrote:
>> Tue, Jul 07, 2026 at 07:45:27PM +0200, mbloch@nvidia.com wrote:
>>> Apply devlink_eswitch_mode= boot defaults for mlx5 after the initial
>>> probe finishes device initialization while holding the devlink instance
>>> lock.
>>>
>>> At this point the devlink instance is registered and mlx5 can perform an
>>> eswitch mode change. Calling devl_apply_default_esw_mode() also clears
>>> any pending default apply work queued by devl_register(), so the queued
>>> work will not apply the same default again.
>>>
>>> Keep this call in mlx5_init_one() rather than the lower-level
>>> devl-locked init helper. That helper is also used by devlink reload, and
>>> devlink core already applies the boot default after a successful
>>> DRIVER_REINIT reload.
>>>
>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>> ---
>>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 13 +++++++++++++
>>> 1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>> index 643b4aac2033..0712efea74cc 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>> @@ -1392,6 +1392,17 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>>> }
>>>
>>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>>> +{
>>> +	struct devlink *devlink = priv_to_devlink(dev);
>>> +
>>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>>> +		return;
>>> +
>>> +	devl_assert_locked(devlink);
>>> +	devl_apply_default_esw_mode(devlink);
>>> +}
>>> +
>>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>> {
>>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>>> @@ -1471,6 +1482,8 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
>>> 	err = mlx5_init_one_devl_locked(dev);
>>> 	if (err)
>>> 		devl_unregister(devlink);
>>> +	else
>>> +		mlx5_devl_apply_default_esw_mode(dev);
>> 
>> I don't understand why this patch is needed at all. Just leave the job
>> to the devlink core, no? That was the point to not pollute drivers with
>> code like this. Is it some kind of leftover?
>
>It was discussed with Jakub here:
>https://lore.kernel.org/all/20260611085440.4fe36bf2@kernel.org/
>
>The main reason is timing. If the default is applied only by devlink
>core, it has to wait until the driver drops the devlink lock.

I don't follow.

<quote>
	devl_lock(devlink);
	if (dev->shd) {
		err = devl_nested_devlink_set(dev->shd, devlink);
		if (err)
			goto unlock;
	}
	devl_register(devlink);
	err = mlx5_init_one_devl_locked(dev);
	if (err)
		devl_unregister(devlink);
unlock:
	devl_unlock(devlink);
</quote>

devlink lock is droped right after.



>For mlx5, that usually happens very late in the init sequence. I
>wanted drivers to be able to apply the default as soon as the driver
>is ready for it, because on NICs with a DPU the host PF can remain
>stuck until the ECPF moves to switchdev.
>
>This API is also useful beyond the initial devlink registration path.
>Follow-up patches will use it for driver controlled paths that are
>not covered by the devlink core, such as recovery and FW reset.
>
>There is also a race window where userspace may take the devlink lock
>before the core gets a chance to apply the default. Letting the driver
>explicitly apply the default at the right point avoids that scenario.
>
>Thinking about this again, maybe the simpler approach is to apply the
>default from devl_unlock(). That would avoid the whole workqueue
>infra.
>
>I avoided doing that earlier because applying a default mode as a
>side effect of devl_unlock() feels a bit odd. But compared to adding
>dedicated workqueue handling maybe it is the lesser evil here.
>
>What do you think?

I was under impression that you need the work to resolve nested locking.
If not, drop it, sure.


>
>About the extra API, I still think it's useful and would like to keep
>it if possible.
>
>Mark
>
>
>> 
>> 
>> 
>>> unlock:
>>> 	devl_unlock(devlink);
>>> 	return err;
>>> -- 
>>> 2.43.0
>>>
>

