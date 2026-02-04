Return-Path: <linux-rdma+bounces-16513-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NlrEo0Yg2mKhgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16513-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:59:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5106E4329
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 816233022F73
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AD5387357;
	Wed,  4 Feb 2026 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Km5MWAOq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B43AEF5F
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199111; cv=none; b=ALXz0c8OFhyrbP5zpYYlmzKq5oQICUlEUZ8awSB3O4uCNujP82AZduWlkFYZyp4WTWbNK6/hVm40jWFtOrlVGQbJjmuKLVTpC9dZuYB5QNO8/Sfj6GO3T1WW6qZhThnFKyi1fSYch8eiLBRVd4v4ZBa3138quL/w0u8OwkHLEsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199111; c=relaxed/simple;
	bh=RqUvHqsbdJMXbroQSbdoa+j17A8Lq78NDNCD6CEhGH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwJbmjffc8yJ7xxybZcB324hp/j8PMHW6WyLRSV35h+rSpnt3NFLUti7YedKAXHCbVHiJVh+trXmmTnHIiT1vy7PiPyJ54K4nZkD+tYUacILZ7tDMf9Jyn5e2RhIGKopMnRky5CTTuSIL4VfkyeM6GshSgpNLKySnz3H7ebicu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Km5MWAOq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359228b7c6so4645456f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 01:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770199110; x=1770803910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsS2W/JwCUgw6NN0Wz3AYONgmZuWQ5joMlv0dByi4ao=;
        b=Km5MWAOqgKvfPhv0SPoi64vQ23QnUBw9q2/Ua2FnDxfvG4yejUVVUVKTURAtFCcUsQ
         xUCskVjp7dw/KAlS1RyxfllziMWMOytV3ZKR2X1uBYv/qoRmNB4kKOafr+v5COwoOt4j
         475IIpIpCnORYHO+5VkI5u0Qa3VnQ6GCLBIH+Jm2jebh1aNrW9070zKmM/xzFrwzZ9ZN
         XfVbC+hI94PN9SPGkoTQ4xsLMSMrsnjd0Q6TnATV7JVJzaY47y9QhypUe9962Y3F0k2e
         IEPuZP6WjrCJh/Oh+mQsSdTDqVILIJWiTyyh/F7ZZaPV4qGikhpvv8UShGn32T6PXqPA
         zAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770199110; x=1770803910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsS2W/JwCUgw6NN0Wz3AYONgmZuWQ5joMlv0dByi4ao=;
        b=CUlOG0IT5PzAPSe02dElMimA8YANtE3MhaJhrYXX2ynFQ1YyTuMGzYScKqQCd/MVg6
         YghjZ9jpKLMtUZX6d/hl8CYodQkaiGIs45NSy7Dn3N8CjJfDj1SvPtiyJo1aijJYmXPU
         lYHeMhDi4e67UfQ8e8ywEili7uSucjoXNm8wLv0RUDjxfZ0YnWGiZ/kibw/cEp3S8D8h
         q9TyBvSZAmtV8FZZUn6JKHEv1VRi+Rc/SeB1dE1+0G+AOe40/rt+XdOAtzgXuTx6F/gw
         6XJ7eP2G2kyhGS58b8cTayMCkXU/f5ItyrFuEV1ZxlBUMwSDn0utQKAUnmDdVekYfZPA
         zD5A==
X-Forwarded-Encrypted: i=1; AJvYcCW/zJMXPh/za4lwmTPVSnokSQfUPTyVKEfw5NG3NeMzMUPeERlMpf/r/OYuu1A6aOqPf3XR6dmIhVdy@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFQwMUZSUYGAac0uDJxRro53VCWHZblfZlcrIk7pNCMXCZQjH
	ObiFjPC3oVGEF3FJahGsJmwEVFO2L5MDOO5rWTxYISIb1H0XOHuY7MJnKSAS4gCZdL8=
X-Gm-Gg: AZuq6aIIvQ+0XBL6IQ4EMU/MLqvrnHyc3tSzBn4lgi4LHWxfQc1x2++cdqkCd/Ur6hv
	sKFgXdCwjfI4Wj6CGvbqc6Konkml7oRWMTjm3s0PiYZbdy1wSHS4dQBlyNyvwMKUD0i50Dyejrw
	85RaWispC27lFxbVTYggwXGtkJonGjqKcSlij/x4rcy9K73lex90/jPGeK3sUGo9QSVK8j8zdp0
	CLVdblNiVYFrC+tNik1ClBJiL3nayfr0dr9p+2vEQFGcFPBUCKNZkBUdjg099l4dK5qoIsf9FI1
	V0SPwKsguzgKuj96qAhzPL4ZR+dAK74c+VX+sdNWrQ7wKuSle/CMVh1bv7QLQNYAf/cU0b5UJvJ
	TvqdDUA5Ae27F5gfHCxVfnMn7zxkXqY9M3S6/dJSdbu6sIYDbpNc9Zolq3DrbMMkvkiezzZ2g1h
	FqJ1A2S0APa3uhoJT+/O0=
X-Received: by 2002:a05:6000:290b:b0:431:b6e:8be3 with SMTP id ffacd0b85a97d-43618053a95mr3496064f8f.38.1770199109610;
        Wed, 04 Feb 2026 01:58:29 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25d02sm5028086f8f.3.2026.02.04.01.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:58:29 -0800 (PST)
Date: Wed, 4 Feb 2026 10:58:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH net-next 1/5] devlink: Add port-level resource
 infrastructure
Message-ID: <tvw3nu7emtvoozmgsskpqqxej74ku4pprztx7kmy3vyv7gygx5@tpfdfghwmrru>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
 <20260203071033.1709445-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203071033.1709445-2-tariqt@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-16513-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,nvidia.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B5106E4329
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 08:10:29AM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>

[...]

> 
> 	DEVLINK_CMD_NOTIFY_FILTER_SET,
> 
>+	DEVLINK_CMD_PORT_RESOURCE_GET,	/* can dump */

Hmm, I assume that "set" is somehow on the horizon. Wouldn't it make
sense to add the enum as a placeholder to have the cmds
together?


>+
> 	/* add new commands above here */
> 	__DEVLINK_CMD_MAX,
> 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1

[...]

