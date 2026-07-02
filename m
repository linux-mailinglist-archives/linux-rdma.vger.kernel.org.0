Return-Path: <linux-rdma+bounces-22677-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CZcvBZIcRmqyKAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22677-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 10:08:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3F36F4997
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 10:08:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=LGzO9brO;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22677-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22677-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748EC3156863
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 07:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E173D1CB4;
	Thu,  2 Jul 2026 07:52:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55F30CDBC
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 07:52:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978760; cv=none; b=HGVeOMQwENYTwwbU2sF2XKms63DGQ3t0V/IJ0IiWsY5zXiMRibAAylFaDWzET6bBNYPIFVIhkfDLaH5uPy88kGozkE0KfVwaleak3y54tyzKVZbchTwfMIJjGSguP8Z3N/xqTYE3uWJKO5hlf6O4Z1Kn6igelIReO81qEyWb5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978760; c=relaxed/simple;
	bh=tkTbs5WEomVgmghemsBWZ8vvMtlIsS90pwefFFYS67o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHRvzdw6eIbSzsdnMWdX6X3Q9Um27EXlpE5AJK4O0EojSn4rSf+13rfESOZLh/1wU+rBzKTXJpkNU86CBbwbJjCYFKyDPpoyxx0XsMQN+m3+C7NfjdDMKz8i+YlQpXJsuHTkyRESso7LUQM/1F3P5hzRGTcFfbj00jaV4h0RIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=LGzO9brO; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-472326ca506so1089099f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782978748; x=1783583548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kESoQxWQJP4S+fDdlEQZkP18r4Y5za67xWurR8NPaGI=;
        b=LGzO9brOLsAmggJcjv2mpsSISA3wkiKChF1hBC3mjlzBxpToiPRqxUzAJg3u9PxWn+
         MjJufWTFv3xlPnBH6C9Wf5RtZEeovjxJLea8QpAILr/Y9JZq+9/VzEsYUa3JWf6eY/qT
         eS6IU2T/yluuO1KvWcDr+N5zNvXe3cO4C8XuS/DKDtbI9a3lUoEx3gFjjAYR5rNJIRGj
         LEqpaaMf9EV/eCU4pP94N2bc3oPHvkFuv/hsw5tyGqI5Vs//XxC+xHfePBZ3oxyn06T+
         e1aQhaKzoF7MlUjDEvskQG+XS5e7Kduz4VbzEEVUh7ou3sUSNSNclz4WZNw4OWBLTngP
         SSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782978748; x=1783583548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kESoQxWQJP4S+fDdlEQZkP18r4Y5za67xWurR8NPaGI=;
        b=WfyY9EY0dROhpZM9engPL12MjGpND240YXelQXo9tw+H0GS4hPGyIs/1VUlHioSEmn
         2xpOr7zFck6xTFfMbJyo4DW/R6rYz/hexpth8pKpqYfJ8nWhNwvI3xuIcNDaCc53AgAx
         2t39/46hd1Al4yxWCtg+9Fq2kIXjDa0I3++1Q49Qp0E64ID3n8/dCbNEJGe+hMXw+fd+
         1Jw07253pNyqF8yNmJIUbPZfDX65JFIr3IEvg5Mg+4L0BSk9SIpwGYZxmqqe9F9D2VOM
         6jka4Xlrau/7ftDI4zCSKeUqwJ/HZzwIgksQTf35ZILje0aYFS7F6uvZ2g0VEKP91FaQ
         l0WA==
X-Forwarded-Encrypted: i=1; AHgh+RrclYzwWW7lyNHihwCxLkMLhEmqbr0gNbKC1E47cLGVYUXI6HXfni6xP54bpKepSze4PFc+51n6ppab@vger.kernel.org
X-Gm-Message-State: AOJu0YzOm+Tu5lV5lms6+qLI/D/zEaPpgcFsByxbuiCfIyLQWocYcdTg
	3tpO4qKKAntfA9nEoxEiVEK/6Iv9xzIPC8W4z2pvaPaL/k83fDiWHooy6u/yaBN4nJw=
X-Gm-Gg: AfdE7cnHPrQfjuemGPtX6H7nIqJb8TI3HK32oCbh3VoBPs/eKsXSUi1hNU49dOEbWhZ
	28M/wqz5HyDwbt8yPPoGalfEUemO7R9u9eDTeQ1ZPSB9mtf5F/bAPAASijcqVSX04LscLuStRWJ
	5iNpokaWwFVxMtk6qTbVR+aotNlHIQ2ECE9fGltYGsedeEil8/wZUOJ+MDoJgAyllV2Ta/Yvp1D
	w2bYmxC/I1mg1ObSLO1jCmlv8Se9e9os++/0g4plzWUXcsCjwACWUXvfHf9qXopXUonSsJPf8I2
	wpByEuqc6HwBa9cFIPZsFd44XquwXUPMUSSsICTcvBngg5nvVm2M7K2PrphGUMNURG6GsA4Kfkw
	Cd1LJz1S6p1g4fjv8siU2dyelVb1Z0l/cQmUBZJZuhp0Kc1kH1dR65wS8evln9A1wCEmHbNmyn1
	5+CAXrhZHmh84PGCBTSH2KosBUjZhV7T54
X-Received: by 2002:a05:6000:4687:b0:475:e015:c2a with SMTP id ffacd0b85a97d-47757e57e6cmr5234114f8f.8.1782978747939;
        Thu, 02 Jul 2026 00:52:27 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94cb64sm6592524f8f.23.2026.07.02.00.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:52:27 -0700 (PDT)
Date: Thu, 2 Jul 2026 09:52:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V4 4/6] devlink: Apply eswitch mode boot defaults
Message-ID: <akYX4pMrDTnxa6yK@FV6GYCPJ69>
References: <20260629182102.245150-1-mbloch@nvidia.com>
 <20260629182102.245150-5-mbloch@nvidia.com>
 <akThPmvUHvCMT2cp@FV6GYCPJ69>
 <1d4ca929-82b8-4891-9058-1451bf71a660@nvidia.com>
 <akUfXyKioGNAO_iB@FV6GYCPJ69>
 <ecaeeef0-c463-4f10-885a-02ad2d648be0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecaeeef0-c463-4f10-885a-02ad2d648be0@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-22677-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C3F36F4997

Wed, Jul 01, 2026 at 07:42:57PM +0200, mbloch@nvidia.com wrote:
>
>
>On 01/07/2026 17:09, Jiri Pirko wrote:
>> Wed, Jul 01, 2026 at 02:57:21PM +0200, mbloch@nvidia.com wrote:
>>>
>>>
>>> On 01/07/2026 12:48, Jiri Pirko wrote:
>>>> Mon, Jun 29, 2026 at 08:20:59PM +0200, mbloch@nvidia.com wrote:
>>>>> Apply parsed devlink_eswitch_mode= defaults after devlink registration
>>>>> and after successful reload.
>>>>>
>>>>> devl_register() may still be called before the device is ready for an
>>>>
>>>> How so? I would assume that driver calls devl_register only after
>>>> everything is up and running and ready. If not, isn't it a bug?
>>>>
>>>
>>> You would think so :)
>>>
>>> Some drivers, mlx5 included, call devl_register() while holding the
>>> devlink instance lock and then finish setting up state before releasing
>>> the lock.
>>>
>>> In v3 I tried to enforce exactly that model, move devl_register() to
>>> be the last thing the driver does. Jakub pushed back on making that a
>>> general rule. So in v4 I changed the approach. devl_register() only
>>> schedules the work, and the actual eswitch mode change can run only
>>> after the driver releases the devlink lock.
>> 
>> Wouldn't it make sense to use a completion instead of loop-reschedule of
>> delayed work?
>
>Just to make sure I understand the suggestion, this would mean that the
>work waits until the devlink lock holder drops the lock, and devl_unlock()
>would signal it, something like:
>
>void devl_unlock(struct devlink *devlink)
>{
>	ool complete_apply = devlink->default_esw_mode_apply_pending;
>
>	mutex_unlock(&devlink->lock);
>
>	if (complete_apply)
>		complete(&devlink->default_esw_mode_apply_ready);
>}
>
>That would avoid the retry loop, but it also means the queued work 
>sleeps until the driver drops devl_lock. It does keep one worker
>blocked per pending instance and adds this default-esw-mode signalling to
>the generic devl_unlock() path.
>
>The delayed retry was meant to avoid a sleeping worker and keep the
>instances independent. If one devlink instance is still locked, we just
>try it again later while other instances can progress.
>
>If you prefer the completion approach I can switch to it, but I don't see
>it as simpler overall.

Yeah, I don't have preference. I was just wondering. Feel free to leave
it as is.

Maybe, instead of "complete", you can schedule with "0" delay in
devl_unlock? Well, it does not really need to be delayed work, right?
The only single schedule may be done from devl_unlock. That would help
to eliminate the rescheduling. Am I missing something?


>
>Mark
>
>> 
>>>
>>> Mark
>>>
>>>>
>>>>> eswitch mode change, so keep a per-devlink delayed work item and pending
>>>>> flag for the registration path. Registration queues the work, and the
>>>>> worker tries to take the devlink instance lock.
>>>>>
>>>>> If the lock is busy, the worker requeues itself with a delay.
>>>>>
>>>>> For successful reloads that performed DRIVER_REINIT, devlink_reload()
>>>>> already holds the devlink instance lock and the driver has completed
>>>>> reload_up(). Clear pending work and apply the default directly from the
>>>>> reload path instead of queueing work.
>>>>>
>>>>> If a user sets eswitch mode through netlink before the pending
>>>>> registration work runs, clear the pending flag so the queued default does
>>>>> not override that user request. Cancel pending default apply work when
>>>>> freeing the devlink instance.
>>>>
>>>> These AI generated code descriptive messages are generally not very
>>>> useful :(
>>>>
>>>
>

