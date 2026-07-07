Return-Path: <linux-rdma+bounces-22818-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z1ofAbvzTGr2sQEAu9opvQ
	(envelope-from <linux-rdma+bounces-22818-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 14:40:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4E171B714
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 14:40:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=wPHaqrho;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22818-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22818-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC4AB3055F7D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D2C414DC8;
	Tue,  7 Jul 2026 12:39:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DB414A05
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2026 12:39:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427988; cv=none; b=VGgkeW9dWuTp/eRkHVlt3NuE9z6RkPWSA5gGdASml22hZgZzc1jmO3t3Plp7C49uf6C1R69h0QISZUeqYelYgjobCmhv3vchrKh/F8niY6iIrqfCnvgdIrtyr0LzACweJoXOS5/tOki5ftbQVmIEv0NNNOiSBDAkrBUAdM57hyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427988; c=relaxed/simple;
	bh=vkEuyudynAbdDdHXbCABH5roVxW1tlfjkxheK4tjgSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4tEqKD5+e8guPhJp1PSEgjwgE4P2Ec77aK42N55TK0ivRvqkIGcGrMQDG/Dfo8fME47tNz7dkwBGeAf4DqeH2JzIFg/QfX8GVP6pkhz+ipuz+IqcF8z0x9KLl3IO+CohgiEFXbhv2Eso/7i4hb3yy4zTDmjKv6UmKMJ16UC9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=wPHaqrho; arc=none smtp.client-ip=209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-697de23bd7dso5053516a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2026 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783427983; x=1784032783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EnwDL12vlYEazYcGR9rb54AP+Tj9amAPmQc3cAai/2c=;
        b=wPHaqrhom2bOThCI718MGxUviGgB+/wipuir650vZ75B54HGGe8ljZDV6r1hxTrc0A
         A8uNe4YwXxyWXKy3CxBq7L6Ycm3dTEy8eT1njE52Dcu8gpmsThe6xnKSTaMN9RppnQx8
         vMtV25V6/Q1Pu3+ZqXMln3fZsq6P9u9jXdMNAbcblrtd6qVdF2T7pjczRsY4K51NqJkQ
         vWF0jGnD+ec5rhioEVdu7ApZ9VFVvv4cGLm/DjPtuWlzrh8qUybUD/r8+TJunyUf1UMM
         O42dPNknDb+jRXYhvq9HUqvCnrpyGCTiEdoADgTcQprny1ry+ubqyAAwxUHT13QqGugY
         IaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783427983; x=1784032783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EnwDL12vlYEazYcGR9rb54AP+Tj9amAPmQc3cAai/2c=;
        b=hJIus0pX/SFY9uY0sGVXWlnnErpYWqOxQN2tc0QJVNL6tudWXYX0GdFl/IVw++tcPn
         wCu8hRL+AAXBAFwfmKtzhQSq5kqv5ruLs4M7ZmS6lpY6OalQTVUq8Os+Cl4UcBWpolxU
         tfB3gCgw/YBp8+sjRbE/bk2oN5KAlPdzj/RyIbudIkwym0+v/xDV3NlI8w4cGHA9SLkk
         ytAIjeffr7QHiopccra8jyHwG/XiL/9hzR9LmMsAOwVOSsp0u0CuSptLqu4kqXrdTyW+
         vyhumAhLT2qOhjeJkgisw4VsoBXw02M8e050oBghoVM1WaRh9lwAQ+/USw4DDlpLsXJE
         tYwg==
X-Forwarded-Encrypted: i=1; AHgh+RpT9disRivRxrKleyzKB1JOmq8uC6ISwjUEZg0BztXiEAMk07bbKR6vclIPfBOmAezGs3NJ8v5Rls88@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMEGcNO5CxezObyvhdxibAmoLKN0Hsgtza7jLE76pKCiqoHwH
	kAK2IVCDnHhoab8OfdGCjKj214Pd4kJETvD1lsqyjcFXjghenDnd3Orkz5N77QB4A9Q=
X-Gm-Gg: AfdE7ck2HtcHZUL444PUGYq5PThbTBjd/UqSSvoKfqm8cfbhXVpFr1NXDQ/hNvoqYfB
	Sh82PFJM/Fxyu/Vvhy6c2tszNx4V7Tg9WLZWh5dwLIyx3lDc6RPTSvuMKXtFq+/W4eEa6Sa0BsQ
	dvveFp99jlSHEQ2JN9DMEqdYvgjMjIfZtiZ4Nbv4d4PVKoaQz+9qh5+OmZCby4yqnb1tqsePqFA
	/5MI7HpptBpSy9Ht4i8iSi2nsruDGUAb/AVZ1DMyvcEspqkVUwheRcuFrKFP3wWNWiodLVsSwml
	BpWhrJYlHvfIBOwpJJARwb+qi+vTH2ai00PcmguBZY8aYSBeGtyVB7Wb9kj3sVsJeWPETOVQfYn
	45cakCPRODqPX9PPDzDBmoyL/gxF4S1aQ/BMcmt8coCxaSNcQNwzI2ouNWDU9gPqnTZ2oRUOSmM
	GGXrllObfngFAgXYy4wOSE
X-Received: by 2002:a17:907:6d20:b0:c12:e4c6:c4d4 with SMTP id a640c23a62f3a-c15ab074a88mr199441966b.63.1783427982190;
        Tue, 07 Jul 2026 05:39:42 -0700 (PDT)
Received: from localhost ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad9be55csm126574866b.31.2026.07.07.05.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:39:41 -0700 (PDT)
Date: Tue, 7 Jul 2026 14:39:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V4 4/6] devlink: Apply eswitch mode boot defaults
Message-ID: <akzzW3aDgej-r26T@FV6GYCPJ69>
References: <20260629182102.245150-1-mbloch@nvidia.com>
 <20260629182102.245150-5-mbloch@nvidia.com>
 <akThPmvUHvCMT2cp@FV6GYCPJ69>
 <1d4ca929-82b8-4891-9058-1451bf71a660@nvidia.com>
 <akUfXyKioGNAO_iB@FV6GYCPJ69>
 <ecaeeef0-c463-4f10-885a-02ad2d648be0@nvidia.com>
 <akYX4pMrDTnxa6yK@FV6GYCPJ69>
 <4fa57470-0d4f-43dc-af4d-e66ddb450923@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fa57470-0d4f-43dc-af4d-e66ddb450923@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-22818-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,resnulli.us:from_mime,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC4E171B714

Fri, Jul 03, 2026 at 08:27:28PM +0200, mbloch@nvidia.com wrote:
>
>
>On 02/07/2026 10:52, Jiri Pirko wrote:
>> Wed, Jul 01, 2026 at 07:42:57PM +0200, mbloch@nvidia.com wrote:
>>>
>>>
>>> On 01/07/2026 17:09, Jiri Pirko wrote:
>>>> Wed, Jul 01, 2026 at 02:57:21PM +0200, mbloch@nvidia.com wrote:
>>>>>
>>>>>
>>>>> On 01/07/2026 12:48, Jiri Pirko wrote:
>>>>>> Mon, Jun 29, 2026 at 08:20:59PM +0200, mbloch@nvidia.com wrote:
>>>>>>> Apply parsed devlink_eswitch_mode= defaults after devlink registration
>>>>>>> and after successful reload.
>>>>>>>
>>>>>>> devl_register() may still be called before the device is ready for an
>>>>>>
>>>>>> How so? I would assume that driver calls devl_register only after
>>>>>> everything is up and running and ready. If not, isn't it a bug?
>>>>>>
>>>>>
>>>>> You would think so :)
>>>>>
>>>>> Some drivers, mlx5 included, call devl_register() while holding the
>>>>> devlink instance lock and then finish setting up state before releasing
>>>>> the lock.
>>>>>
>>>>> In v3 I tried to enforce exactly that model, move devl_register() to
>>>>> be the last thing the driver does. Jakub pushed back on making that a
>>>>> general rule. So in v4 I changed the approach. devl_register() only
>>>>> schedules the work, and the actual eswitch mode change can run only
>>>>> after the driver releases the devlink lock.
>>>>
>>>> Wouldn't it make sense to use a completion instead of loop-reschedule of
>>>> delayed work?
>>>
>>> Just to make sure I understand the suggestion, this would mean that the
>>> work waits until the devlink lock holder drops the lock, and devl_unlock()
>>> would signal it, something like:
>>>
>>> void devl_unlock(struct devlink *devlink)
>>> {
>>> 	ool complete_apply = devlink->default_esw_mode_apply_pending;
>>>
>>> 	mutex_unlock(&devlink->lock);
>>>
>>> 	if (complete_apply)
>>> 		complete(&devlink->default_esw_mode_apply_ready);
>>> }
>>>
>>> That would avoid the retry loop, but it also means the queued work 
>>> sleeps until the driver drops devl_lock. It does keep one worker
>>> blocked per pending instance and adds this default-esw-mode signalling to
>>> the generic devl_unlock() path.
>>>
>>> The delayed retry was meant to avoid a sleeping worker and keep the
>>> instances independent. If one devlink instance is still locked, we just
>>> try it again later while other instances can progress.
>>>
>>> If you prefer the completion approach I can switch to it, but I don't see
>>> it as simpler overall.
>> 
>> Yeah, I don't have preference. I was just wondering. Feel free to leave
>> it as is.
>> 
>> Maybe, instead of "complete", you can schedule with "0" delay in
>> devl_unlock? Well, it does not really need to be delayed work, right?
>> The only single schedule may be done from devl_unlock. That would help
>> to eliminate the rescheduling. Am I missing something?
>
>Yeah, that can work.
>
>The only part I don't really like is adding default-esw-mode specific
>logic to devl_unlock(). But if you are fine with that, I can switch to

Could be a devl_unlock_x variant? Idk.


>this approach.
>
>There is still a small race between mutex_unlock() and queue_work(), where
>someone else can take devl_lock() first. So the worker may still wait on
>the lock, but the window should be small and we get rid of the delayed
>retry loop.

No problem.

>
>Mark
>
>> 
>> 
>>>
>>> Mark
>>>
>>>>
>>>>>
>>>>> Mark
>>>>>
>>>>>>
>>>>>>> eswitch mode change, so keep a per-devlink delayed work item and pending
>>>>>>> flag for the registration path. Registration queues the work, and the
>>>>>>> worker tries to take the devlink instance lock.
>>>>>>>
>>>>>>> If the lock is busy, the worker requeues itself with a delay.
>>>>>>>
>>>>>>> For successful reloads that performed DRIVER_REINIT, devlink_reload()
>>>>>>> already holds the devlink instance lock and the driver has completed
>>>>>>> reload_up(). Clear pending work and apply the default directly from the
>>>>>>> reload path instead of queueing work.
>>>>>>>
>>>>>>> If a user sets eswitch mode through netlink before the pending
>>>>>>> registration work runs, clear the pending flag so the queued default does
>>>>>>> not override that user request. Cancel pending default apply work when
>>>>>>> freeing the devlink instance.
>>>>>>
>>>>>> These AI generated code descriptive messages are generally not very
>>>>>> useful :(
>>>>>>
>>>>>
>>>
>
>

