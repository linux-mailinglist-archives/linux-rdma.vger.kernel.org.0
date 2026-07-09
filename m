Return-Path: <linux-rdma+bounces-22942-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IFIIL/hvT2rJggIAu9opvQ
	(envelope-from <linux-rdma+bounces-22942-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:55:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD02472F2C2
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 11:55:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=cUZ2jZs3;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22942-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22942-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51699300252C
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AFA3F7865;
	Thu,  9 Jul 2026 09:46:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70BD3F12E7
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 09:46:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590413; cv=none; b=QAaGoe32QTF1muX4p3gvE30wxD9CjBLn73iUw3AWYN8LtvAspqh7pnMiIZ2NCxWviMaOIaUxI6JYCFvHBL1K1c3t6YVN0QSpmvDfBfeGZbkMVzUZwu1r34Y3afQM+7PR9X5M790QE34GY6jJnoAmzVwzHYmHKP56A9asbv+M4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590413; c=relaxed/simple;
	bh=QjxnfdFkEb0Z6vufY3cN0U0+kv71/r1+joErkMeCX14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGM6grBzRUV6ZlmcBmJoqePpqPpadOACkZQ9SXiLkArz2As5AJQF1euHdBdTcvGoyiyZhxxS/NQxYYauofAb/lf9cyOtnoK0r6Thjd05ZWbkT7DI1xvS42CUif6sJlxqaDxYwzzFho1aCVfhCUT8VU8YY24bWg9RnZk1EqkK3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=cUZ2jZs3; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4758bd3731bso458523f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2026 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590405; x=1784195205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jCDpigf6NAvGtv4KCK1nKWmd+1oUaDS0btU+snL4BhY=;
        b=cUZ2jZs3CBzcw9ITDguBXjdMkWvvAC214XaHjyoq90rBob86KOU/+yQyj1ktffnD9p
         OpTMwuKs2jJPJn77eRvEO+KuEo3Zqwhfvu5lmVDP2sqxf6ygE0vj3p2h3vK0uNp9/bEO
         pxLQSFmGbY1KUVaAZtGrd+2gH3TYx5ERTXUJ3qkgJb/44iKHwcmmuP3bk+vAr7CKJ5Dr
         n1ZJKQ9ryNHX4+Z18cTN6QH62QAnBBNYbRSIH6K0fg0EuDNAUkV58/73PwT3wfgT5J8p
         flHgTIZEQvAPwBAqpxZYnIgF2ySdUGbBr932kRyWkvf9IVnFT99FOLELz9uDhaw5Es8a
         Fwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590405; x=1784195205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jCDpigf6NAvGtv4KCK1nKWmd+1oUaDS0btU+snL4BhY=;
        b=Y+zU6DnvghZ8or87auhpP2EoaskLc2s9UMmc2kqGXmxSV94EwCYXXObDIOraLlkd7z
         cGvfdUV8MrWpmzpgACA/XWESe9XciYajYG/z4h31FACrUA8IU10x66tMVRMOZLRlvaoi
         8BZKqvrY0qmK6iZNzdK7kKpD3oVGftzl+7uVcGQHlt4KUhuh/eL5XOOkS2Z8oTqHGYfN
         /FsbVKwLYLzXgh26/zRlmTBNnmwcT660erh6Hxe+HMfkUidmb83EV+IbidOXab28Cp0M
         TXLP6lWT50Dztcgr7m+JwCoVCvYTBNRW7BDh/xFa8uqb41X0gfw5Wjkqo2GCzt7a9nP0
         60ow==
X-Forwarded-Encrypted: i=1; AHgh+RpbarvEAtS5qtLM2p9sh4eJ3vzrdc2hgcsJogjd9dybYU0K4VHCk9+M7qG0gOuq28c6PWj1BFheMXg4@vger.kernel.org
X-Gm-Message-State: AOJu0YyTx/DIEmdcTUdgfyzeToICod4t0iWB+BmRtUkG2aP0O9k1fMrI
	qve/Rhzqp1uarCsmI6LjLKcaNQZhb9n/tmkbMAUquFr5uBuQQ9c7/DfCGCayQoXpA0U=
X-Gm-Gg: AfdE7ck37lW6icCCZN1I8KQVefm1NeVkPMIJKKlv7lGCk1UsZsmi+VTUMRQKmkl+FQw
	uRBc8t2N5df8fpTqHkXhF7UM7ObZJJWj19yarKZHEAvVX6hu9gcH2fU7YTIZ/P+fXGQ0L4KKHNu
	RcL7pejJu7iK9mI/Xevpx2JD8HxM6rWa23sAqxlyQI3wiqyRANsrX3YeRikjb6rQese/P0EUHf3
	kNRiznxQsvrf+Z5jGFeNKvbvy6/6/fkZl3znl+fhTUyZa+fbu9Ja5la50C8prYsDkiHjRPamM86
	0Ll+qalJUj9/ZrI+aVtyVLm5vt6qTcdCUj/PIhIiA0qbBxn9wQ/WHbjlh14nbJGk01GnRdliIGD
	vKetryj8v6tDwoWe76/YisVRppAvOtNP1/Vc1vZ5S66zLtrMiKqWwSV5F7WcibBZT8rcjW+j9kF
	WobFyKLZIuzDSJpG4x/W/XDA==
X-Received: by 2002:a05:6000:4602:b0:475:f0c2:75ae with SMTP id ffacd0b85a97d-47df7561a22mr2165637f8f.25.1783590404637;
        Thu, 09 Jul 2026 02:46:44 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm53671269f8f.7.2026.07.09.02.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:46:44 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:46:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V5 4/6] devlink: Apply eswitch mode boot defaults
Message-ID: <ak9thhKgtDBepkcD@FV6GYCPJ69>
References: <20260707174527.425134-1-mbloch@nvidia.com>
 <20260707174527.425134-5-mbloch@nvidia.com>
 <ak4Muihtk40r3lfV@FV6GYCPJ69>
 <e9445ff1-87b5-4111-8264-74016634d3bb@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9445ff1-87b5-4111-8264-74016634d3bb@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22942-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[FV6GYCPJ69:mid,vger.kernel.org:from_smtp,resnulli.us:from_mime,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD02472F2C2

Thu, Jul 09, 2026 at 07:45:20AM +0200, mbloch@nvidia.com wrote:
>
>
>On 08/07/2026 11:59, Jiri Pirko wrote:
>> Tue, Jul 07, 2026 at 07:45:25PM +0200, mbloch@nvidia.com wrote:
>>> Apply parsed devlink_eswitch_mode= defaults after devlink registration
>>> and after successful reload.
>>>
>>> devl_register() may still be called before the device is ready for an
>>> eswitch mode change. Keep the registration path passive and let the
>>> regular devl_unlock() path queue the async apply work once the instance
>>> is registered and the default is still pending.
>>>
>>> The queueing path runs while the devlink instance lock is held, so the
>>> queued work gets its devlink reference before the caller drops the lock.
>>> The worker then takes the devlink instance lock normally and applies the
>>> default only if the instance is still registered and the default is still
>>> pending.
>> 
>> This is very code-descriptive. What's the benefit of that?
>
>The point is that there is still a window before the queued work
>runs where the user can explicitly set the eswitch mode. If they 
>do, the default will no longer be pending, so the worker will skip
>applying it.
>
>I'll reword.
>
>> 
>> 
>>>
>>> For successful reloads that performed DRIVER_REINIT, devlink_reload()
>>> already holds the devlink instance lock and the driver has completed
>>> reload_up(). Clear pending work and apply the default directly from the
>>> reload path instead of queueing work.
>>>
>>> Preserve the user configured mode when it is set before devlink applies
>>> the default.
>>>
>> 
>> [..]
>> 
>> 
>>> +void devlink_default_esw_mode_apply_locked(struct devlink *devlink)
>>> +{
>>> +	const struct devlink_ops *ops = devlink->ops;
>>> +	int err;
>>> +
>>> +	devl_assert_locked(devlink);
>>> +
>>> +	if (!devlink_default_esw_mode_match(devlink))
>>> +		return;
>>> +
>>> +	if (!ops->eswitch_mode_set) {
>>> +		if (!devlink_default_esw_mode_match_all)
>>> +			devl_warn(devlink,
>>> +				  "devlink_eswitch_mode= selected this device but eswitch mode setting is not supported\n");
>>> +		return;
>>> +	}
>>> +
>>> +	err = devlink_eswitch_mode_set(devlink, devlink_default_esw_mode, NULL);
>>> +	if (err)
>>> +		devl_warn(devlink,
>>> +			  "Couldn't apply default eswitch mode, err %d\n",
>>> +			  err);
>>> +}
>>> +
>>> +void devlink_default_esw_mode_queue_apply_work(struct devlink *devlink)
>> 
>> eswitch/esw - we call it "eswitch" consistently everywhere. Why "esw"
>> here?
>
>Ack
>
>> 
>> 
>> 
>>> +{
>>> +	devl_assert_locked(devlink);
>>> +
>>> +	if (!devlink_default_esw_mode_enabled || !devlink_default_esw_mode_wq)
>>> +		return;
>>> +	if (!devlink->default_esw_mode_apply_pending ||
>>> +	    !__devl_is_registered(devlink))
>>> +		return;
>>> +	if (!devlink_try_get(devlink))
>>> +		return;
>>> +	if (!queue_work(devlink_default_esw_mode_wq,
>>> +			&devlink->default_esw_mode_apply_work))
>>> +		devlink_put(devlink);
>>> +}
>>> +
>>> +static void devlink_default_esw_mode_apply_work(struct work_struct *work)
>>> +{
>>> +	struct devlink *devlink;
>>> +
>>> +	devlink = container_of(work, struct devlink,
>>> +			       default_esw_mode_apply_work);
>>> +
>> 
>> What happens if userspace eswitch mode set happens now? Any userspace
>> attempt should cancel the default apply. I don't see such mechanism in
>> your patches, did I miss it?
>
>devlink_nl_eswitch_set_doit() calls
>devlink_default_esw_mode_apply_pending_clear(), which clears the
>pending bit.
>
>So if a user sets the eswitch mode before the queued default
>work applies it, the worker will see that the default is no longer
>pending and will do nothing

Okay.


>
>> 
>> 
>> 
>>> +	devl_lock(devlink);
>>> +
>>> +	if (devl_is_registered(devlink) &&
>>> +	    devlink->default_esw_mode_apply_pending) {
>>> +		devlink_default_esw_mode_apply_locked(devlink);
>>> +		devlink->default_esw_mode_apply_pending = false;
>>> +	}
>>> +
>>> +	devl_unlock(devlink);
>>> +	devlink_put(devlink);
>>> +}
>>> +
>>> +void devlink_default_esw_mode_instance_init(struct devlink *devlink)
>> 
>> Why "_instance_"? Care to drop?
>
>Ack
>
>> 
>> 
>>> +{
>>> +	INIT_WORK(&devlink->default_esw_mode_apply_work,
>>> +		  devlink_default_esw_mode_apply_work);
>>> +	devlink->default_esw_mode_apply_pending = true;
>>> +}
>>> +
>>> +void devlink_default_esw_mode_apply_pending_clear(struct devlink *devlink)
>>> +{
>>> +	devl_assert_locked(devlink);
>>> +
>>> +	devlink->default_esw_mode_apply_pending = false;
>>> +}
>>> +
>>> +void devlink_default_esw_mode_instance_cleanup(struct devlink *devlink)
>> 
>> Why "_instance_"? Care to drop?
>
>Ack
>
>> 
>> 
>>> +{
>>> +	if (cancel_work_sync(&devlink->default_esw_mode_apply_work))
>>> +		devlink_put(devlink);
>>> +}
>>> +
>>> static int __init devlink_default_esw_mode_setup(char *str)
>>> {
>>> 	devlink_default_esw_mode_param = str;
>>> @@ -228,10 +325,21 @@ int __init devlink_default_esw_mode_init(void)
>>> 		return err;
>>> 	}
>>>
>>> +	devlink_default_esw_mode_wq = alloc_workqueue("devlink_default_esw_mode",
>>> +						      WQ_UNBOUND | WQ_MEM_RECLAIM,
>>> +						      0);
>>> +	if (!devlink_default_esw_mode_wq) {
>>> +		devlink_default_esw_mode_param = NULL;
>>> +		devlink_default_esw_mode_nodes_clear();
>>> +		pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate workqueue\n");
>> 
>> Why you don't "return"  here? I think that we don't need to allow the
>> case wq is not allocated.
>
>The function returns right after this block. It is not treated

What I ment was "return error".


>as a valid “workqueue unavailable” mode, the parsed defaults are
>cleared, the parameter is ignored, and no default eswitch mode will
>be applied.
>
>I kept it as a non critical failure so we do not abort the whole
>devlink init just because the default-mode workqueue could not be
>allocated.

Why to treat it like this? Is there any other example of such flow in
devlink? I don't see the benefit, only potential confusion in very
unlikely case the alloc_workqueue fails. Am I wrong? If not, just bail
out here.



>
>That said, I can make this more explicit by returning 0 directly
>from this error path.
>
>Mark
>
>> 
>> 
>>> +	}
>>> +
>>> 	return 0;
>>> }
>>>
>>> void __init devlink_default_esw_mode_cleanup(void)
>>> {
>>> +	if (devlink_default_esw_mode_wq)
>>> +		destroy_workqueue(devlink_default_esw_mode_wq);
>>> 	devlink_default_esw_mode_nodes_clear();
>>> }
>> 
>> [..]
>

