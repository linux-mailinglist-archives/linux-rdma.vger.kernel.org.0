Return-Path: <linux-rdma+bounces-17590-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LydLMDFqmnVWwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17590-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 13:17:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7041220614
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 13:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C030303086C
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227B038E5E1;
	Fri,  6 Mar 2026 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ebePal5t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85F38E5C9
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799212; cv=none; b=Vgott3kZJEwW+1AGwa7QGHKI8yUtIkC5WLE08UIjt+3sf9yc8p5CkCZOYHmMU6MieCQiJxhFy7HnIzA6IIb3Wl3oKpdp3fxFQgSrzQv50u2bkCTRiAT0BBT2pMuxWmKRnvhjLjShxgvL4pefiNtgCQQ9ztvK2pOGZpXw2Ahq6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799212; c=relaxed/simple;
	bh=iL3nHsj2qbN/ptZ32yL5eiwUDcUBsCkMTT+rcB3PMxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGnZLtGWeyG3kXgPSnZjASKWsxrHbS4DC7dwfIseVuJCVQ9vmtyu04dr9WAMvHpjKyDMJNhg2VWZiS8zYfdHvn7zlDwSm6xujIRSM6ZNCDXVvDQ8Ujgxw9K2Vh5ixq2W5nEDtcsc6QRhbeTknMUYv+RaKGIuSp3V7iLLa9+s12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ebePal5t; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483770e0b25so78410245e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 04:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772799210; x=1773404010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTpTiYCmYefmS8voVHhTmV6UthynmjNZaFJx1xqdpVE=;
        b=ebePal5t6HxHoJBNoARUWaa23plUvf87O/bmUdgs1xJyNY8MgzRCJ4pZYxQwDqbNqI
         CzdVMwW/wuYjxdrwhOEHph9kMh8D4v0osXRgDx11NoFqv6QSQpzM4fhWtLja24HmA7xX
         0DfZdgtURfiBXxa8luOdr4FZpOxGgaVTLFrD5VS3R9IL8rp/dRpPJSHe5730iobk+v3e
         XdzW/mYri2yNMKXJtn/A3EmBtBIt8vS/hWWYK/eqXmjtfgqJjy7bqiOeI0FQS/obIDs0
         ArZaLYnwwKZWVKTUdwudnZDxTxRmgZKJ6gWudyK+aq7SJq3u/2DyZkjttkw/n5bZLXKX
         03EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772799210; x=1773404010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTpTiYCmYefmS8voVHhTmV6UthynmjNZaFJx1xqdpVE=;
        b=VhgdgXxH/XcgIvlqa2xZSOxARBUaSnQG61Gc9OpWj30JaMCKPsSi3HhDzcncfF3cM/
         WCidiI6QFjJAmWusA9LDzyvfTxLjpFZCoO4AobjvpO18MC/fZIYJBW6g63RRR6N/Nadr
         lERrDctX7pSRi+7Wdy+EZ8YIRnVvV2cVW1oqCb2T+YKqV7Q9fcTCyzQf7hAVW9aNL4yY
         IynhG3JqLcEu2H9eCLjIoAlaXgsJUhPDHBesaOc0H9BCgNMM4ldFMJQs39FnXVq9bIlC
         e8BQbD5rYZZqLxQcCVX9g547dHPVUH9l1j0MezAuNi6aYyYbSe0cZik91A0w12VvkakY
         83hg==
X-Forwarded-Encrypted: i=1; AJvYcCXYVhEnkEUKqG+9CqZ6acC5AXiWJpW68x/LClwpPdWbq54ojhuMoqzd5wdddaJ3Kyy1HtthAvmCvonY@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdj+pmtEcMuOLX1hjXg8F/GegzUCbGdhx0ANw/ZHWcL/GYjIv
	4PwkcsqAMKn5gw1FWfbTm7tHHh0cU4n86lFBf+/Ot6eXxTkLq3XzVyzSYNV87ZwRSm8=
X-Gm-Gg: ATEYQzxMhRz3s2nV0eggO5lJJyRAswT3WMfXEbmrnfXevAl9LC6MvHUp12D3dCglLKV
	I5p4y9mHq5/ZFZQjkLety8RwR2S7u9wdmMXp4gnrWAl2OQKwVbS5zbA0ChhJlRM5jkSD8+EjPuh
	Hq8J8ls3TiD0jrk4qz6N7EK2r9uYcs9fvK0YRpzBdSaQo/RtIQul2MzutrJ954qdrgjAff5JhGx
	SrexYcjGlO5iwmtQXPDIgHja3xv1CbASkPgudywTxR0G6auYtByCwuuZ8J9w01jxRF+gP+3irNc
	O9ONzHoDmyzow3QLj1PrOW6y9D+tp4Rb63jKyW8DzT+sWsfEpQyWlbmRl8enXcbCk7NFQygULnz
	fBKb7Kez3SG1Dtf32Wjs2bVhXNttJY36acGbv9n86Wnf5g3pPx4QUrkCjM1T1Kgt4NTAS+IfliH
	mfJP4Z/m0NnZo4KMOJQ4hhVE9xb/JIj/jgF/GyhiV6Rw==
X-Received: by 2002:a05:600c:4fc2:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-4852692bfa5mr30418785e9.13.1772799209987;
        Fri, 06 Mar 2026 04:13:29 -0800 (PST)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485256b1eacsm30285005e9.0.2026.03.06.04.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:13:29 -0800 (PST)
Date: Fri, 6 Mar 2026 13:13:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource support
Message-ID: <ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
 <20260302192640.49af074f@kernel.org>
 <pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
 <jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
 <20260304101522.09da1f58@kernel.org>
 <np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
 <20260305063729.7e40775d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305063729.7e40775d@kernel.org>
X-Rspamd-Queue-Id: C7041220614
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17590-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Thu, Mar 05, 2026 at 03:37:29PM +0100, kuba@kernel.org wrote:
>On Thu, 5 Mar 2026 08:56:42 +0100 Jiri Pirko wrote:
>> Wed, Mar 04, 2026 at 07:15:22PM +0100, kuba@kernel.org wrote:
>> >On Wed, 4 Mar 2026 11:34:13 +0100 Jiri Pirko wrote:  
>> >> On a second thought, if we merge multiple objects into one dump, how
>> >> does this extend? I mean, the userspace has to check there are no extra
>> >> attributes, as they may be used as a handle to another new object
>> >> introduced in the future... Idk, it's a bit odd.  
>> >
>> >That's true, the user space must be able to interpret the object
>> >identifier. So if we extend the command to add more identifiers
>> >we will have to add the bitmask to the dump request, and have
>> >the user space tell the kernel which objects it can recognize.
>> >I was just saying that we don't have to add such attribute now,
>> >maybe leave a comment in a strategic place for our future selves?  
>> 
>> Or, alternatively, we can have per-object dumps as we have for all
>> objects and command right now and leave things simple and
>> straightforward? I mean, I don't really see a benefit of a single dump
>> for more objects :/
>
>What do you mean by straightforward, exactly?
>
>User will most likely want to see all resources of a device in a single
>dump / command.

Hmm. We actually already have this for region and health reporter dumps.
Only for params we have that separate.
So let's do it for resource too.

Thanks!

>
>The objects themselves are identical, they only differ by the handle,
>and yet we'd have two separate commands to access them.
>
>It's as if we had separate GETLINK commands in rtnetlink for devices on
>the PCIe bus vs connected via USB.

