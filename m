Return-Path: <linux-rdma+bounces-21327-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGP7DnXJFWqMbAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21327-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 18:25:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE1D5D9A25
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 18:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53DC03013840
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2783B6BEE;
	Tue, 26 May 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="McGYWAVT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D93B3C08
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812621; cv=none; b=uJsqEpOIRNinPZHQ9nBc64Wk+Xotd1EfYxZI2+scWwez8bVC+UN3jitDP4/0k5Rhlc2fD6N2ZpMBC0Z9Ptm6ZZ5WDLXNK1GCEnY5aQvcjyxjUOGD4nL6vh4TqDCB5RXH4rkDvSikLukaUKk4xB12XwS9s+t5KuRT+H74tnd++Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812621; c=relaxed/simple;
	bh=/guMXgQW93OWipJLT8Mg8akWH/y+aqGs8oksgRHFwb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtkyxeDrjvUoAQCPKWzE5Tdbb2TCkUL3dcTjxp4can9pfss3513HBjPJqAc/BBJ5er97GzPhsN1z7vKMI8hJ/rTa2RR+E16xAz7Y0Fl5wiYAiDNoIsYT13vnFCTVjZSugboRkXqwcAk5HvGWE5tfk717QLIYnZz+1d5O60B+yiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=McGYWAVT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ed9336049so603138f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779812615; x=1780417415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLZvkzp6ATjH3l5+aCHSeZgpKYTRGGuT+8/f+7jWDUA=;
        b=McGYWAVTbwMXqgEdQk8ZvRP61Eno8f2trDAHxIk2ytoHfJFVzRN6EChxoOK5tjZC57
         tBPfDcIvpqpBw5/hG5mj7MwahTHn1hZaA32H8wFbeOofQtULyPsMN9k14mFP9fGjPFln
         ETuBgg4tX25Zyt7bD9X7V3RopNICPY83QUyjqDgj7CNJcMR4OIsvoc4Ei8YlNoKbi27L
         7KisFlfoxbtSNkTPfSx466bWc5EmtMS2BZaj1s8Xi4Fb0GLJTtHghxMPcrsdQTmTHUAK
         X+e+602Z2Q41aAmFpnPDNP1yP8lc5FDRH6r+nt9dLfK+S9oSq4hzS8rplBUWdjrWS/1w
         XW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779812615; x=1780417415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLZvkzp6ATjH3l5+aCHSeZgpKYTRGGuT+8/f+7jWDUA=;
        b=Nz8T6IutlYi3BKjA8mi32Axnukvc9KjKbjZO973pfA4Kz3omkzBuIjhwVHGTXX+zr5
         92RrC8CHugjGRiB/6WEWtUsfzZ/0w/v2mLilE43xvBEF+9olBFG5HkDgZtifPr6+E+I3
         aluaXa9Go2mjI9VVGJa1ZL4BqamIHt3TdBWswPmCjCFwQeHdqgIVAyQ8ovjxvyEc+Lb/
         Zumy2mkc8jh6aPAEkkwKhx5+OvuyvhFMUP2zTwOoXxMWPJm7tuPxM3MwTmH002Oy+QRj
         jIFSmp6Brq0pfGQ+Giyiy5pXSAnlcOWLKOwuI91xpgTQE1kjqeQwAl2LucKG20zPIUIU
         2gQA==
X-Forwarded-Encrypted: i=1; AFNElJ9txvmIjO1Fv4Grlu+uofQVXfhCPO03G7D5xtMc9wZDbg1YE/IeKMATj1s+NG3poD06jLqgEC1RcufZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwwidBxVUb0MxmVIEkC5FRIUR6t1ta+RP3GyGlaxYSdHHtlLX9x
	UloPTemOIS6+rqBQWYY5TW5PH6cj9hP052Ud4771cll7/txlx71n/sJ/CFfFZU0GpaE=
X-Gm-Gg: Acq92OEE4hOuAuRkvY9K7aI8eGy3imPrG6acuxzn7K7Le304Ugf4S92+6Nrrvuxp7kX
	X4fog41EPXFawXCbisARJ+1tctjlZrfXYAlOEGuytgfz+re+SI3aooljI2SDw0yz33Wzbz0uem3
	Jb7P/ulbiHd0e+/qTJAnq3eQDOASl7cJLBCrplz6GDhZVA5vnNXtiW5OnLSsufgeBPGaziqi5Q6
	2J8fOzcKMcFCIxsL0pLtkFzf7RQ+/QeyE14x8glycvc0TpSy1/VRmVPoC5FMOXsEWbkL0tA+cmB
	vTn3iqBEk66mx2s391hTYkxjANhK6ObM2NP7+6FMn4oIKg5jMUF9uug3QTr0SWj8ZPay9+VSZ2U
	ylhnQMhr7mRZPZ0vS6LaeP3WM5QZi4FnXP+TuO05fQ8B0ryn/dEEpSSDewQBLMgxhPsO/ziH6ai
	kjlFPK3j6nlYqOV0dEdgXlHwUJSDnxU0BOHhnpiTuAqcc=
X-Received: by 2002:a05:6000:401e:b0:45d:4b37:7fcf with SMTP id ffacd0b85a97d-45eb367fac4mr33534428f8f.15.1779812614061;
        Tue, 26 May 2026 09:23:34 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6cd1780sm39478805f8f.16.2026.05.26.09.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:23:33 -0700 (PDT)
Date: Tue, 26 May 2026 18:23:29 +0200
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
Message-ID: <ahXF2aQZNOwHdCG_@FV6GYCPJ69>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com>
 <ahVPASuh4BZGOfx0@FV6GYCPJ69>
 <8c8df8da-62a9-49e8-84eb-572d54cfeb1f@nvidia.com>
 <ahWm4NXph9gdazV_@FV6GYCPJ69>
 <9aa7c295-35cb-428b-9031-13a2f507ae4b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aa7c295-35cb-428b-9031-13a2f507ae4b@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-21327-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: EDE1D5D9A25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, May 26, 2026 at 05:03:57PM +0200, mbloch@nvidia.com wrote:
>
>
>On 26/05/2026 17:07, Jiri Pirko wrote:
>> Tue, May 26, 2026 at 11:44:46AM +0200, mbloch@nvidia.com wrote:
>>>
>>>
>>> On 26/05/2026 10:44, Jiri Pirko wrote:
>>>> Thu, May 21, 2026 at 09:24:34AM +0200, tariqt@nvidia.com wrote:
>>>>> From: Mark Bloch <mbloch@nvidia.com>
>>>>>
>>>>> Apply devlink default eswitch mode for mlx5 devices after successful
>>>>> device initialization while holding the devlink instance lock.
>>>>>
>>>>> At this point the devlink instance is registered and the mlx5 devlink
>>>>> operations are available, so the default eswitch mode can be applied to
>>>>> the matching PCI devlink handle.
>>>>>
>>>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>>>> Reviewed-by: Shay Drori <shayd@nvidia.com>
>>>>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>>>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>>>> ---
>>>>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
>>>>> 1 file changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>> index 0c6e4efe38c8..4528097f3d84 100644
>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>> @@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>>>>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>>>>> }
>>>>>
>>>>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>>>>> +{
>>>>> +	struct devlink *devlink = priv_to_devlink(dev);
>>>>> +	int err;
>>>>> +
>>>>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>>>>> +		return;
>>>>> +
>>>>> +	devl_assert_locked(devlink);
>>>>> +	err = devl_apply_default_esw_mode(devlink);
>>>>> +	if (err)
>>>>> +		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
>>>>> +			       err);
>>>>> +}
>>>>> +
>>>>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>> {
>>>>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>>>>> @@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>> 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>>>>>
>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>
>>>> I wonder how we can make this work for all. I mean, other driver would
>>>> silently ignore this command like arg, right? Any idea how to make all
>>>> drivers follow the arg from very beginning?
>>>>
>>>
>>> I have a follow-up series that adds the call to all drivers which support
>>> setting eswitch mode. When going over the other drivers, what I found is
>>> that the right point to apply the default is driver specific, drivers
>>> I have patch for:
>>>
>>> 46e16c6d9836 net: Apply devlink esw mode defaults
>>> ab4f54102ba9 bnxt_en: Apply devlink default eswitch mode during init
>>> b48cce1607bb liquidio: Apply devlink default eswitch mode during init
>>> 4ea54b0fe04a ice: Apply devlink default eswitch mode during init
>>> b7faddaa1c90 octeontx2-af: Apply devlink default eswitch mode during init
>>> 74b0c22c47b9 octeontx2-pf: Apply devlink default eswitch mode during init
>>> 5000e4c3d768 nfp: Apply devlink default eswitch mode during init
>>> 97a218e95e41 netdevsim: Apply devlink default eswitch mode during init
>>>
>>> I don't think doing this generically from devlink is realistic. devlink
>>> doesn't really know when a given driver is ready to change eswitch mode.
>>> Some drivers need SR-IOV state, representor setup, or other init pieces to
>>> be ready first, and the locking is not identical across drivers either.
>> 
>> 
>> Low hanging fruit would be just to call ops->eswitch_mode_set at the end
>> of register. Multiple reasons:
>> 
>> 1) end of devl_register is exactly the point userspace is free to issue
>>    the eswitch mode set. Driver should be ready to handle it.
>> 2) all drivers would transparently get this functionality, without
>>    actually knowing this kernel command line arg ever existed, without
>>    odd wiring call of related exported function. I prefer that stongly.
>> 3) you should add a there warning for the case this arg is passed yet
>>    the driver does not implement eswitch_mode_set. User should
>>    get a feedback like this, not silent ignore.
>> 
>> The only loose end is see it the void return of devl_register().
>> Multiple ways to handle the possibly failed eswitch_mode_set(). I would
>> probably just go for pr_warn, seems to be the most correct.
>> 
>> Make sense?
>
>I see the point, but I don't think devl_register() (at least not the only place)
>is the right place.
>
>There is a small but important difference between userspace doing
>"devlink eswitch set" after register is done, and devlink core calling
>eswitch_mode_set() from inside the register flow.
>
>Some drivers call devlink_register() while holding the device lock.
>liquidio is one example. If devlink core calls ops->eswitch_mode_set() from
>there, we may start the full eswitch mode change while holding that lock.
>That mode change can create representors, register netdevs, take rtnl,
>allocate resources, etc. I don't think we want this to become an implicit
>side effect of devlink registration.

I believe your AI may untagle liquidio locking :)


>
>For mlx5, the placement after intf_state_mutex is also intentional:
>
>mutex_unlock(&dev->intf_state_mutex);
>mlx5_devl_apply_default_esw_mode(dev);
>
>We can't call it while holding intf_state_mutex because the mode set path
>takes it internally, and switchdev mode may also create IB representors.
>
>Also, devl_register() only covers the first registration. The mlx5 call in
>mlx5_load_one_devl_locked() is for reload/fw reset recovery kind of flows.
>In those flows devlink is already registered, so devl_register() is not
>called again, but the driver state was rebuilt and we may need to apply the
>default again.

Call it from reload too, right?


>
>Same for reload, fw reset and pci recovery in general. If the driver tears
>down and rebuilds eswitch related state, the place to apply the default is
>in that driver's reinit flow, not in devl_register().
>
>When I went over the other drivers, the right place was not always the same
>as devlink registration. I'm not an expert in any of them, so I hope I got
>the details right, but for example octeontx2 AF needs sr-iov and the
>representor switch state to be initialized first. nfp can do it after
>app/vNIC init while the devlink lock is already held. liquidio should do it
>only after dropping the PCI device lock.

Idk, perhaps do it from devlink_post_register_work of some kind? That
would allow you to have the same locking ordering as a userspace call.

>
>Mark
>
>> 
>> 
>>>
>>> Also, since this knob is only about eswitch mode, I don't think we need to
>>> touch every devlink driver. Drivers that don't implement eswitch_mode_set()
>>> would just ignore it anyway. The follow-up only wires the default into
>>> drivers that actually support changing eswitch mode.
>>>
>>> Mark
>>>
>>>>
>>>>> 	return 0;
>>>>>
>>>>> err_register:
>>>>> @@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>>>>> 		goto err_attach;
>>>>>
>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>> 	return 0;
>>>>>
>>>>> err_attach:
>>>>> -- 
>>>>> 2.44.0
>>>>>
>>>
>

