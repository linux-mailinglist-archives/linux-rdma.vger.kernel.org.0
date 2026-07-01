Return-Path: <linux-rdma+bounces-22652-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QequBtkgRWr+7QoAu9opvQ
	(envelope-from <linux-rdma+bounces-22652-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 16:14:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 802906EE958
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 16:14:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=n41nM9bK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22652-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22652-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4050E30DDAFD
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F662459E1;
	Wed,  1 Jul 2026 14:09:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9442ED15F
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2026 14:09:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914962; cv=none; b=Lsk9fcHODHLJ9YLjt5jq4LwfFVybFd4QQO6zc4DO5VsMXMdLz91gzefqAQpQyKE00hWM4oD+7hddxg5dszLQ6zXAP1Q2ulvQ1RHsVVYCgf0USQkmb9FxlnOrGmBJkppLNnTn6Gyll4k8OWEMnFWEgA9N62KEby8uWzV2hRMnQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914962; c=relaxed/simple;
	bh=9573nrWrSx/Y9UOpr/TlheCNkMPqUyYtfuIixr6r3Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxEqGHCE9gcgLa5vZy3zQUT1BAkJhnS/tDqi/zxE3w4mC/CVjmv86mKNeeRgkjBY2mXJpgft2QBVEPwIhiPy61d532/Ef9vH+va/UG3377pJueI1CdarTWShTIVCjY7NE+xszfAsXkJhruVryO4SC1VjwbUL0tXxdZi9wkDm4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=n41nM9bK; arc=none smtp.client-ip=209.85.218.51
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c126e47a82cso92181466b.2
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2026 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782914957; x=1783519757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5yGg7xTrcKVGSs2/RAkolvsvNsO9JL3VCUQsl5nfCM=;
        b=n41nM9bKknfDSII57sUQPENrA4Ng5DsEfRL3eWWCo/bbwhodzoikFkhqKLOweRDaci
         7pyaqeO+O32WrlUmGJSf46JU91myU51QRi5yMo89WymHVuGtOSiF6gpkg3WTbIcsewnC
         zzz83E61Q/ukK9yzOE2did4Klq4Bp6TB7RjRXE4LvhS+xDTegZe4CcJmggUaAAS+AfJo
         8tZPOGn/pVVJkHAKeC3xqzHKuVO0v6pQcrb8gXCI488U1e/bczogCOWyKdyH72/KDAZV
         7UxEHJC0ctXfPVk0vGJIAfkHsOtIlOlVtnXp445XuNJK3oZCCYMegSj5Ez/nxm7CYYCG
         tazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782914957; x=1783519757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5yGg7xTrcKVGSs2/RAkolvsvNsO9JL3VCUQsl5nfCM=;
        b=JgQR/y1s/Rp9GaHMLd1fSMaHmfBC3CUA3EnoyBzr9JmQjKWYUKvpOxsBWBFfnjhnzI
         OFpv9vCYWMmEBZ0tgfqeXb9Ft8veUBZdqIJZTWoW73omcaApWEQtY23KFWFs1MqfDQro
         uE5z0eTi3/lJhjegAMR37HFO8vXAq8VAhU5az30URY4fLOHh/Op2Tx5a+B09q0NiA6tH
         kogbIaOSybhwpKorUuo6dsqDO1P9qYAc9IYeBnOdZu94R3VZsw1o8D2pw28B4NbOjGKR
         zpoUi4gLcp9fw7Gm0fkfFGRLiH5A3mXJ4Jm/N+KOyuMBRogmm9Wa/AXF37qp55H+L7E0
         aXOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpeHgqw+6l+fhkaaBNOWCHNseLCyurr4I0aHO9fPwvZ6OIUKPazPftqjEudEmpczpdMDbCz4FKDmlOE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9u5D2m04vjslN9+wz1t8hdLX8rMHinMLDdFfSXtgtq32+Clh
	GbODKQ/WsbIQukQnk9Tr1YI9iUs0N7cXfIW6B+iRwbw4dL3k5M2ybeF/FeEI/5/QLfY=
X-Gm-Gg: AfdE7cllWz+5ZK7bkx/5LGk1u0KwUtXIQk2e8CnV8aUEWMuZH31zeazt3QrvYZZX5Dr
	N3TItwfTnW+MoFBETLInAAIr6wwR8KDaycSqFpi/l/GpYNodZP0vaJmanxlr+WbTZ0oa5QsUOJf
	cxtZ9wy5+I+vH9UDaqGDXUaDkhhdOGQyyCGX4uT+y2XaFh+/XAzoXSQZGdTtQFxObLknd/dPidR
	paBLH+t9un66exrmeaxo02ZnM/iVFg7apIYFQGkVLKaEi2YlXBRpCivJNh3t8IPqUNx3KOkEQVi
	3uQsJ0XgVMLQxf64dH3gHGecJW7eWdjg5rxKkDTbD+ZTPrVJLwnF4SfzATd9oIpP8aKnHyaFtpW
	CYJ0ljYSyfwma00ybxhw+ys24+YD4SebR7xd1lj+krmL63fiKrNlUIPwGCutFCpwSSytZCM1Wvk
	UII7twBrOzjnAIPLtBhi2YCQ==
X-Received: by 2002:a17:906:e907:b0:c12:8ec5:eb8 with SMTP id a640c23a62f3a-c12aa1411eemr71054966b.41.1782914957090;
        Wed, 01 Jul 2026 07:09:17 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d6a3e8sm281311366b.19.2026.07.01.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:09:16 -0700 (PDT)
Date: Wed, 1 Jul 2026 16:09:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V4 4/6] devlink: Apply eswitch mode boot defaults
Message-ID: <akUfXyKioGNAO_iB@FV6GYCPJ69>
References: <20260629182102.245150-1-mbloch@nvidia.com>
 <20260629182102.245150-5-mbloch@nvidia.com>
 <akThPmvUHvCMT2cp@FV6GYCPJ69>
 <1d4ca929-82b8-4891-9058-1451bf71a660@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d4ca929-82b8-4891-9058-1451bf71a660@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-22652-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,FV6GYCPJ69:mid,vger.kernel.org:from_smtp,resnulli.us:from_mime,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 802906EE958

Wed, Jul 01, 2026 at 02:57:21PM +0200, mbloch@nvidia.com wrote:
>
>
>On 01/07/2026 12:48, Jiri Pirko wrote:
>> Mon, Jun 29, 2026 at 08:20:59PM +0200, mbloch@nvidia.com wrote:
>>> Apply parsed devlink_eswitch_mode= defaults after devlink registration
>>> and after successful reload.
>>>
>>> devl_register() may still be called before the device is ready for an
>> 
>> How so? I would assume that driver calls devl_register only after
>> everything is up and running and ready. If not, isn't it a bug?
>> 
>
>You would think so :)
>
>Some drivers, mlx5 included, call devl_register() while holding the
>devlink instance lock and then finish setting up state before releasing
>the lock.
>
>In v3 I tried to enforce exactly that model, move devl_register() to
>be the last thing the driver does. Jakub pushed back on making that a
>general rule. So in v4 I changed the approach. devl_register() only
>schedules the work, and the actual eswitch mode change can run only
>after the driver releases the devlink lock.

Wouldn't it make sense to use a completion instead of loop-reschedule of
delayed work?

>
>Mark
>
>> 
>>> eswitch mode change, so keep a per-devlink delayed work item and pending
>>> flag for the registration path. Registration queues the work, and the
>>> worker tries to take the devlink instance lock.
>>>
>>> If the lock is busy, the worker requeues itself with a delay.
>>>
>>> For successful reloads that performed DRIVER_REINIT, devlink_reload()
>>> already holds the devlink instance lock and the driver has completed
>>> reload_up(). Clear pending work and apply the default directly from the
>>> reload path instead of queueing work.
>>>
>>> If a user sets eswitch mode through netlink before the pending
>>> registration work runs, clear the pending flag so the queued default does
>>> not override that user request. Cancel pending default apply work when
>>> freeing the devlink instance.
>> 
>> These AI generated code descriptive messages are generally not very
>> useful :(
>> 
>

