Return-Path: <linux-rdma+bounces-21491-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FTVODhqGWrGwQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21491-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 12:28:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A5D600CEF
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 12:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 458483024950
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8D73C4141;
	Fri, 29 May 2026 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="yKetUNKZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E83BE65C
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050339; cv=none; b=hsqjQsC6FDzetUXYWqEEs+2HPIGo1sIGzYZJCvx/OX36A1pS44IZ4WcF+adxXAnvrdKE4eYunz6EASm896mK15/YJjqKSMu8X+fa+YMYkIEHjZNeOXCosI0SuAvvL1+kE6ULdU/etPyOIt4n4M60zSmNpSgeaFNITFd2hx4mRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050339; c=relaxed/simple;
	bh=hZdiciRf7GduXcXbVm4Vk1hA9JOZko9BRjeDEqiVcIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiclC4qlgEdWyHSLX4dZIWuv7YgVWzOgwJ/WaX38Wde9vBlUKK/Vv3SfqUwTJf55cr3Q9IMEHsotERUTpeMRV4w2saF3OYfBid8vaaRuMaECa5gy/SQgAnGgA6SQOoeykS68r2ODXmNcRS6nt2u2QmGsg8F+e7Tm/JYomMhp4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=yKetUNKZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4905e190c71so64088015e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780050333; x=1780655133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JgtlNA99ibd00JHFfLFvSWZDOdItSPRT9Y5BN+K0sUE=;
        b=yKetUNKZi6rsvq+sHOmWrCOxpx+Ieb6fNzmlo7y784P07W2nC4Hnhzihe+J6LAh5w2
         +b4s1eD/8mcCi8blrP1pfagTSMVYKjQ9GBPGyUFmPHrQTp84oyYUgUtUG1L6PmPm3S9u
         onE3HEOCHbQwlU9e5jVRBXqBegMPHFQYUJqyG+N4qWAimpYMZ192jddkvLCHN3LrKirr
         lWMAaC8T5NWvVNEq+rG3GOZCzacAKAyDsdxe7Sj3T5JNxUv3eAGAfT/FVjPeaRQ5/ssc
         V2sxWa730QSTYsvW2D9JIRsKLucHIY++4V71/jVbudL7nPEX1d9Y5qPLF6ayqA2RFBUu
         WK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780050333; x=1780655133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgtlNA99ibd00JHFfLFvSWZDOdItSPRT9Y5BN+K0sUE=;
        b=FQaY8ERFI/1efLbm151PytKFu6c/bGu98j9bpwsTrUsoEytBr/+GkcZEq2J8tpLsPQ
         i3c6YvNEvFepUKZINujLtCUuWWXmGWpz0QFZSIt46ISZAtWUG2xcgRBfRvyHHu2yTQzq
         40JGbfjbdUNMLov8y8CDLh+1eGkXGmJNBgNqEvBu90iaCFsZu9XMDLZEC0WwsLNy4+P1
         b1TqUL68cy/wzRgoUi1M8oZEPSXwgDgZ2Yd3ZZ/H7X8iR4V8OYS9PPE71P+aeqW6F+i9
         tcqjWtUFLChvFvpwQxwPKFHca9jE+N2B/VzEleSvPyoN4LxlWNMNmjIIp79jVmhqmKTV
         4QKw==
X-Forwarded-Encrypted: i=1; AFNElJ9qO2wBOTbkuz72+WQUXSANX3iEQXky3mgTnEwuK5uvPNRvATUk6ch7tCFzyNwWwdw2Lxmq6HHai3ou@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsyq2wZrzXo8bze9FTFxDAG6b69ucc0Wl4+rm9ovG9g61W8QSd
	dYmeY/v2oAnkWyPuxnKot15s5afxrFcZdNRKEz8YANuXvdao7S4yrKjLi2eXJotP+7M=
X-Gm-Gg: Acq92OFJUCXA770JGETJUO9nuxcPOnvJPAFiTCJArwqnzxYAtdItZ6XIqkU9wSGCyAd
	551wtNMOPfDURZgS2uqKeEuI9iSc/Tdbr10uwI4MMfcnBK0xXTOstXr41XTYL1LAkpozb2KRCaW
	0eju0Yagm3/tMC5LsJm5NLanq3lGySUUqokAv6crk7Ks4gdG61GAWaFNOjMdoDSkWNpytV1R36Q
	FmnUAW3BL9iwPQ7xnDhfxV5BuuR9PzKPx4ax9HTAnU18qEo+3xb1aEkemfnBiMo9q+imoDWs01l
	XS7x+WH8CQcFRpFah0ZyREzXMTusqb/EaHB9rmeuUlN0whuEfq7i/rqu/9yhJLzfJUYyPVxAtAo
	Z7zlk9Layw4K2nYVQd103BlTDIOhoD6/GUIw1KeZ0CgeggBo51Yn7mcY80I+yzpCE3kDeUwRN5T
	kN7B2EeP1t7kpBWe0mFezWNs9kamzqKBPVPKxPjGVwEw==
X-Received: by 2002:a05:600c:3f19:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-4909d1bf171mr42154205e9.14.1780050332793;
        Fri, 29 May 2026 03:25:32 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm2492262f8f.34.2026.05.29.03.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:25:32 -0700 (PDT)
Date: Fri, 29 May 2026 12:25:28 +0200
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
Message-ID: <ahlpjJ4CCZAwqFVi@FV6GYCPJ69>
References: <ahVPASuh4BZGOfx0@FV6GYCPJ69>
 <8c8df8da-62a9-49e8-84eb-572d54cfeb1f@nvidia.com>
 <ahWm4NXph9gdazV_@FV6GYCPJ69>
 <9aa7c295-35cb-428b-9031-13a2f507ae4b@nvidia.com>
 <ahXF2aQZNOwHdCG_@FV6GYCPJ69>
 <b9105eb7-de56-496e-998f-7c49c660b880@nvidia.com>
 <ahZ9CgIWdjny4N4D@FV6GYCPJ69>
 <b26b9866-440b-45bf-9d2f-7c4d3193c793@nvidia.com>
 <ahafaNDr0x-lzA7F@FV6GYCPJ69>
 <e4f4a6a5-9be0-462b-b4d7-8bbf57001cb4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4f4a6a5-9be0-462b-b4d7-8bbf57001cb4@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-21491-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 47A5D600CEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, May 28, 2026 at 10:15:44AM +0200, mbloch@nvidia.com wrote:
>
>
>On 27/05/2026 14:18, Jiri Pirko wrote:
>> Wed, May 27, 2026 at 09:03:26AM +0200, mbloch@nvidia.com wrote:
>>>
>>>
>>> On 27/05/2026 8:14, Jiri Pirko wrote:
>>>> Tue, May 26, 2026 at 07:13:46PM +0200, mbloch@nvidia.com wrote:
>>>>>
>>>>>
>>>>> On 26/05/2026 19:23, Jiri Pirko wrote:
>>>>>> Tue, May 26, 2026 at 05:03:57PM +0200, mbloch@nvidia.com wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 26/05/2026 17:07, Jiri Pirko wrote:
>>>>>>>> Tue, May 26, 2026 at 11:44:46AM +0200, mbloch@nvidia.com wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 26/05/2026 10:44, Jiri Pirko wrote:
>>>>>>>>>> Thu, May 21, 2026 at 09:24:34AM +0200, tariqt@nvidia.com wrote:
>>>>>>>>>>> From: Mark Bloch <mbloch@nvidia.com>
>>>>>>>>>>>
>>>>>>>>>>> Apply devlink default eswitch mode for mlx5 devices after successful
>>>>>>>>>>> device initialization while holding the devlink instance lock.
>>>>>>>>>>>
>>>>>>>>>>> At this point the devlink instance is registered and the mlx5 devlink
>>>>>>>>>>> operations are available, so the default eswitch mode can be applied to
>>>>>>>>>>> the matching PCI devlink handle.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>>>>>>>>>> Reviewed-by: Shay Drori <shayd@nvidia.com>
>>>>>>>>>>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>>>>>>>>>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>>>>>>>>>> ---
>>>>>>>>>>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
>>>>>>>>>>> 1 file changed, 17 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>>>>>> index 0c6e4efe38c8..4528097f3d84 100644
>>>>>>>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>>>>>>> @@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>>>>>>>>>>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>>>>>>>>>>> +{
>>>>>>>>>>> +	struct devlink *devlink = priv_to_devlink(dev);
>>>>>>>>>>> +	int err;
>>>>>>>>>>> +
>>>>>>>>>>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>>>>>>>>>>> +		return;
>>>>>>>>>>> +
>>>>>>>>>>> +	devl_assert_locked(devlink);
>>>>>>>>>>> +	err = devl_apply_default_esw_mode(devlink);
>>>>>>>>>>> +	if (err)
>>>>>>>>>>> +		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
>>>>>>>>>>> +			       err);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>>>>>>>> {
>>>>>>>>>>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>>>>>>>>>>> @@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>>>>>>>> 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>>>>>>>>>>>
>>>>>>>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>>>>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>>>>>>>
>>>>>>>>>> I wonder how we can make this work for all. I mean, other driver would
>>>>>>>>>> silently ignore this command like arg, right? Any idea how to make all
>>>>>>>>>> drivers follow the arg from very beginning?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I have a follow-up series that adds the call to all drivers which support
>>>>>>>>> setting eswitch mode. When going over the other drivers, what I found is
>>>>>>>>> that the right point to apply the default is driver specific, drivers
>>>>>>>>> I have patch for:
>>>>>>>>>
>>>>>>>>> 46e16c6d9836 net: Apply devlink esw mode defaults
>>>>>>>>> ab4f54102ba9 bnxt_en: Apply devlink default eswitch mode during init
>>>>>>>>> b48cce1607bb liquidio: Apply devlink default eswitch mode during init
>>>>>>>>> 4ea54b0fe04a ice: Apply devlink default eswitch mode during init
>>>>>>>>> b7faddaa1c90 octeontx2-af: Apply devlink default eswitch mode during init
>>>>>>>>> 74b0c22c47b9 octeontx2-pf: Apply devlink default eswitch mode during init
>>>>>>>>> 5000e4c3d768 nfp: Apply devlink default eswitch mode during init
>>>>>>>>> 97a218e95e41 netdevsim: Apply devlink default eswitch mode during init
>>>>>>>>>
>>>>>>>>> I don't think doing this generically from devlink is realistic. devlink
>>>>>>>>> doesn't really know when a given driver is ready to change eswitch mode.
>>>>>>>>> Some drivers need SR-IOV state, representor setup, or other init pieces to
>>>>>>>>> be ready first, and the locking is not identical across drivers either.
>>>>>>>>
>>>>>>>>
>>>>>>>> Low hanging fruit would be just to call ops->eswitch_mode_set at the end
>>>>>>>> of register. Multiple reasons:
>>>>>>>>
>>>>>>>> 1) end of devl_register is exactly the point userspace is free to issue
>>>>>>>>    the eswitch mode set. Driver should be ready to handle it.
>>>>>>>> 2) all drivers would transparently get this functionality, without
>>>>>>>>    actually knowing this kernel command line arg ever existed, without
>>>>>>>>    odd wiring call of related exported function. I prefer that stongly.
>>>>>>>> 3) you should add a there warning for the case this arg is passed yet
>>>>>>>>    the driver does not implement eswitch_mode_set. User should
>>>>>>>>    get a feedback like this, not silent ignore.
>>>>>>>>
>>>>>>>> The only loose end is see it the void return of devl_register().
>>>>>>>> Multiple ways to handle the possibly failed eswitch_mode_set(). I would
>>>>>>>> probably just go for pr_warn, seems to be the most correct.
>>>>>>>>
>>>>>>>> Make sense?
>>>>>>>
>>>>>>> I see the point, but I don't think devl_register() (at least not the only place)
>>>>>>> is the right place.
>>>>>>>
>>>>>>> There is a small but important difference between userspace doing
>>>>>>> "devlink eswitch set" after register is done, and devlink core calling
>>>>>>> eswitch_mode_set() from inside the register flow.
>>>>>>>
>>>>>>> Some drivers call devlink_register() while holding the device lock.
>>>>>>> liquidio is one example. If devlink core calls ops->eswitch_mode_set() from
>>>>>>> there, we may start the full eswitch mode change while holding that lock.
>>>>>>> That mode change can create representors, register netdevs, take rtnl,
>>>>>>> allocate resources, etc. I don't think we want this to become an implicit
>>>>>>> side effect of devlink registration.
>>>>>>
>>>>>> I believe your AI may untagle liquidio locking :)
>>>>>
>>>>> I didn't try to solve that one with ai. Most drivers were fairly simple 
>>>>> so I didn't use ai at all. bnxt was the one where I needed a bit of help :)
>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> For mlx5, the placement after intf_state_mutex is also intentional:
>>>>>>>
>>>>>>> mutex_unlock(&dev->intf_state_mutex);
>>>>>>> mlx5_devl_apply_default_esw_mode(dev);
>>>>>>>
>>>>>>> We can't call it while holding intf_state_mutex because the mode set path
>>>>>>> takes it internally, and switchdev mode may also create IB representors.
>>>>>>>
>>>>>>> Also, devl_register() only covers the first registration. The mlx5 call in
>>>>>>> mlx5_load_one_devl_locked() is for reload/fw reset recovery kind of flows.
>>>>>>> In those flows devlink is already registered, so devl_register() is not
>>>>>>> called again, but the driver state was rebuilt and we may need to apply the
>>>>>>> default again.
>>>>>>
>>>>>> Call it from reload too, right?
>>>>>
>>>>> Yes, that was my first thought: apply it from devl_register() for the first
>>>>> registration and from devlink_reload() after a successful DRIVER_REINIT.
>>>>>
>>>>> That covers the clean devlink reload path but....(see bellow)
>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Same for reload, fw reset and pci recovery in general. If the driver tears
>>>>>>> down and rebuilds eswitch related state, the place to apply the default is
>>>>>>> in that driver's reinit flow, not in devl_register().
>>>>>>>
>>>>>>> When I went over the other drivers, the right place was not always the same
>>>>>>> as devlink registration. I'm not an expert in any of them, so I hope I got
>>>>>>> the details right, but for example octeontx2 AF needs sr-iov and the
>>>>>>> representor switch state to be initialized first. nfp can do it after
>>>>>>> app/vNIC init while the devlink lock is already held. liquidio should do it
>>>>>>> only after dropping the PCI device lock.
>>>>>>
>>>>>> Idk, perhaps do it from devlink_post_register_work of some kind? That
>>>>>> would allow you to have the same locking ordering as a userspace cal
>>>>> l.
>>>>>
>>>>> I thought about a workqueue too, it was actually my first idea.
>>>>>
>>>>> The problem is that then we race with userspace. In the mlx5 version here the
>>>>> default is applied while the devlink lock is still held, before userspace can
>>>>> come in and issue its own eswitch set. If we defer it to post-register work,
>>>>> the devlink instance is already visible and userspace can get there first
>>>>> and then we might change the user configuration.
>>>>
>>>> Figure that out and expose to user by setting xa_mark only after the
>>>> work is done? This is doable.
>>>
>>> I agree that if devlink can keep the instance hidden/unavailable until the
>>> post register work is done, that solves the initial userspace race.
>>>
>>> The other part is the reinit/recovery case. For that I think devlink core
>>> needs some explicit indication from the driver that the device is now in
>>> reinit. Something like (at least that's the code I had initially, but something
>>> along those lines):
>>>
>>> void devl_dev_reinit_begin(struct devlink *devlink);
>>> void devl_dev_reinit_end(struct devlink *devlink);
>>> void devl_dev_reinit_abort(struct devlink *devlink);
>>>
>>> The core can then mark the instance as temporarily unavailable/in reinit
>>> between begin/end, and the relevant lookup/dump paths, for example
>>> devlink_get_from_attrs_lock() and devlink_nl_inst_iter_dumpit(), can reject
>>> or skip it while reinit is in progress. devlink_reload() can probably mark
>>> this state by itself around DRIVER_REINIT.
>> 
>> I believe this is orthogonal to the problem you are trying to solve in
>> this patchset. Not sure why you bring it in to the conversation...
>> 
>
>I brought it up because I was also thinking about reinit/recovery flows, but
>I guess I can tackle that later.
>
>For now I can focus on the generic devlink path, move drivers to register
>devlink only after the device is ready. Then devlink core can apply the default
>before exposing the instance to userspace.
>
>I think it is better to fix the ordering for all devlink drivers, not only the
>ones that support eswitch mode set. That gives us a consistent model and makes
>future defaults easier.
>
>Reload can be handled from devlink after successful DRIVER_REINIT.
>
>Does this sound ok?

Yes. Thanks!


>
>Mark
>
>> 
>>>
>>> Then mlx5 would look more or less like:
>>> 	devl_lock(devlink);
>>> 	devl_dev_reinit_begin(devlink);
>>> 	ret = mlx5_load_one_devl_locked(dev, recovery);
>>> 	if (!ret)
>>> 		devl_dev_reinit_end(devlink);
>>> 	else
>>> 		devl_dev_reinit_abort(devlink);
>>> 	devl_unlock(devlink);
>>>
>>> This gives devlink core a way to know that the devlink instance is registered,
>>> but should not be used by userspace at the moment. It also allows keeping the
>>> default/config apply logic in devlink instead of adding driver specific calls
>>> to apply it in each init path.
>>>
>>> But this still means the generic solution needs some driver help. Drivers need
>>> to register devlink at a point where the post-register default apply is safe,
>>> and full reinit paths need to be marked with this begin/end API.
>>>
>>>>
>>>>
>>>>>
>>>>> Also, the bigger issue for mlx5 is not only initial registration or devlink
>>>>> reload. Some recovery paths, pci resume, and fw reset flows rebuild the driver
>>>>> state without going through devlink at all. I did not find a clean way for
>>>>> devlink core to infer all those points by itself.
>>>>
>>>> If you don't obey current configuration for example in pci resume, it is
>>>> bug and you should fix it. All these flows should obey current eswitch
>>>> mode configuration.
>>>>
>>>
>>> I agree that the device should come back according
>>> to the intended high level policy. But I don't think full reinit can be treated
>>> as restoring the whole previous runtime state. There may be user created
>>> steering rules and other objects which the driver cannot keep or replay. Today
>>> full reinit brings the device back to a clean initialized state, and that is
>>> intentional.
>>>
>>> So the split I have in mind is:
>>>
>>> - full runtime state is not preserved across full reinit;
>>> - high level devlink policy/configuration should be applied when the device is
>>>  initialized again;
>>> - the command line default should not blindly override a later explicit
>>>  userspace eswitch mode selection.
>>>
>>> I am not against moving this into devlink core, and I am willing to work on it.
>>>
>>> But before I rework the series, I want to make sure we agree on the direction.
>>> As I see it, doing this cleanly needs a devlink state like "registered but
>>> unavailable/in reinit", plus driver annotations for the reinit paths.
>>>
>>> If this is not the direction you want, I prefer to know now rather than spend
>>> time on a version that will be rejected anyway.
>>>
>>> Mark
>>>
>>>>
>>>>>
>>>>> To handle that from devlink I would still need to add some api for the driver
>>>>> to tell devlink "I just reinitialized, apply the default now". but nce I had
>>>>> that driver call , it felt simpler and clearer to let the driver call
>>>>> the helper directly at the points where it knows eswitch mode is safe.
>>>>>
>>>>> I agree that handling all of this inside devlink would be the better option.
>>>>> I just couldn't make it work in a clean way.
>>>>>
>>>>> Mark
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Mark
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Also, since this knob is only about eswitch mode, I don't think we need to
>>>>>>>>> touch every devlink driver. Drivers that don't implement eswitch_mode_set()
>>>>>>>>> would just ignore it anyway. The follow-up only wires the default into
>>>>>>>>> drivers that actually support changing eswitch mode.
>>>>>>>>>
>>>>>>>>> Mark
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> 	return 0;
>>>>>>>>>>>
>>>>>>>>>>> err_register:
>>>>>>>>>>> @@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>>>>>>>>>>> 		goto err_attach;
>>>>>>>>>>>
>>>>>>>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>>>>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>>>>>>>> 	return 0;
>>>>>>>>>>>
>>>>>>>>>>> err_attach:
>>>>>>>>>>> -- 
>>>>>>>>>>> 2.44.0
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>
>>>
>

