Return-Path: <linux-rdma+bounces-17462-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JaEGuIDqGkRnQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17462-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 11:05:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 689751FE128
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 11:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 774D63008CBD
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA739D6CA;
	Wed,  4 Mar 2026 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XsN3t+Kv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371039479F
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618714; cv=none; b=uXLR5zwSICAvsgBpM1gIDMZPz93aTZlXH3j3lShjqprSAwKlukQZ51fXUV1nRkhCEXt4EPKFZxwXR+E49gGP6SL8pnJh/MJSBjB17aMJTiC3X7SVi/DqowN1KjtvR+GtQ759SGbc546pgpGLBRQNL7oYvdKmoTqwYCrjlKsdTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618714; c=relaxed/simple;
	bh=dgVJAhqnOIPqC5PZq8vBwCOU9OzRV/WoR8Mk8PnVt3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7916RBaXY4TVhNM9e/nfBa4OdZeoTmWn9MsbGMv1vJINCf+AFBXTH2gDQECtyEZmfHOgsvOswQP0JV9AS5ZaboBZihm9TH7StXUBAUBMu/jzK8WpYY2/pI4QocFxa3andg+YQuqxc3eex4WOa2YOhMPY+RW96rRipG39x4dY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XsN3t+Kv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-480706554beso72184465e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 02:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772618710; x=1773223510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9gDnR/GlX5r3MxOQp0wc5+efc8WjR6tGLkWS8cjDDi4=;
        b=XsN3t+KvRjLmQXyGUq5jGUsYLtOoKckGDvdjFPqdf+t/WgrKa6MuFAOCdwrn/g8WIe
         nDCe6oN/KroI47pNwQbREv9OVhK/qaQtApRuGJrJPNsVOd/l6yRRCX25RS1NyYTdwb3p
         jOG3z+IQbhDsiwrq5LBFyGR9t0hpChPYPjUB7HZE31HaMGx9jYjv/som+VbRtbWiDsY1
         WnXhEoQrS3MNUnX5RjG4CuflIR9eyXQ5OGt7Z5i7gICKuHo1uKY6gLIYSD8Vr5dgq/aP
         oqes1OLZxrrSZCaWBGcGsDHBlKbuu7j+k5pSqOARsJTikBcEQBvsCtEnGKZ9qpCSbuwS
         NNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772618710; x=1773223510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gDnR/GlX5r3MxOQp0wc5+efc8WjR6tGLkWS8cjDDi4=;
        b=uQTEYAKG5FY3ObB6JT5iV+2iPOu1mjim5O6b7HXwdkjrft75+QagyVf2Is/En8PjCK
         DE8/FbtfSPKxP9DVVmu9X+ApW3ovbIEXtO03Maxjht52wO7swS4eAo1uB/TZKaPrtQKm
         q5v0um+cg6jrNN864U76KzTRKTygBBJUoL4s8za0iJq0H0oSYH5S/5O9QeSYuzAVS8+0
         Vpw52JJuDTiHimb05w2kYDaZYnsM8vwa81AL8A5p4jHAQ3rSOKQLDpTTaONCuP5Ted5a
         ZtxYUDR499q+6vXz8QZQY8rTrgSisLAmB4avaMZCuzTIuivGk0ZtIg3rtVNvI4Bq7291
         mmJg==
X-Forwarded-Encrypted: i=1; AJvYcCUslK/o6lOdwIu7ds0UVxzPdz+sWq9DeWeWr/envxWEuDvtX+Qlyu76FDSV/CoZlAVu/9oRbSxy7t4O@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6QkGA2ZBXQVRyFsRmLGYDqo+25tnv4vc+yHmW6sMe7AeRoKD
	Mnjvxj2gx/yrKGFZcrIeXQV8+uUQ/6CUZttIkIXemnrjqfiWS303mmfglEYEMO1siMk=
X-Gm-Gg: ATEYQzwM33uoI7GLECTm2xQ/sy7zXHG4hzMrEPVFIXSheOJBZAEFHZER2D0AaN/tqBi
	G+yATuJOMFloAX9a3DJc/cIQiCqklFlAG7jsaIZPA63Nf+Tvv/PE0yfjautsthkugVb8Qa2I4Cs
	tPlymER2hYA9EGlQKlx764knl+gE+Wxb187dPEmP9YVoVgxOzF9Gs2lHFH3ZhIKDz/c5s86K5hB
	G44DejqiPvS5t1e7dEDVkfqsHCRVfI32EniwmfrHGECyjRNoLCZ4O67tHMZ/+D4SdwFnhtN5TGZ
	HD6Jo3JqgJ0lt9MWHBnFtt7N0mRvo5aGJuYDt4Wef/fJ68gXr2Q6MApNZRFFnqhHh47l8hdDiW/
	hsKl2bfNUUHcsvMzWeFnx8G5D+PPxEyaHwdD+SLTlhgVbVoOFQooc2ouBk4jGT9/ldbLuEf0ZRp
	qAjljZKq7F91IDeZklQRxhC6Rf/BTAKOSOnrE=
X-Received: by 2002:a05:600c:1c06:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-48519851b59mr26465905e9.12.1772618710225;
        Wed, 04 Mar 2026 02:05:10 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187b7851sm70235585e9.3.2026.03.04.02.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 02:05:09 -0800 (PST)
Date: Wed, 4 Mar 2026 11:05:06 +0100
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
Message-ID: <pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
 <20260302192640.49af074f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302192640.49af074f@kernel.org>
X-Rspamd-Queue-Id: 689751FE128
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
	TAGGED_FROM(0.00)[bounces-17462-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Tue, Mar 03, 2026 at 04:26:40AM +0100, kuba@kernel.org wrote:
>On Fri, 27 Feb 2026 00:19:06 +0200 Tariq Toukan wrote:
>> With this series, users can query per-port resources:
>> 
>> $ devlink port resource show pci/0000:03:00.0/196608
>> pci/0000:03:00.0/196608:
>>   name max_SFs size 20 unit entry
>> 
>> $ devlink port resource show
>> pci/0000:03:00.0/196608:
>>   name max_SFs size 20 unit entry
>> pci/0000:03:00.1/262144:
>>   name max_SFs size 20 unit entry
>
>Code LGTM, I have a question about having a new cmd, tho.
>
>Does it matter to the user how the resource is scoped? 
>Whether the resource is at the instance level or at the port level?
>
>I worry we are mechanically following the design of other commands.
>Since the dump handler is new we could just dump resources with port-id
>there. No existing user space may be using it. Alternatively we could
>add a new attribute to select a bitmask of which scope user wants to
>dump.

You can specify what you want to dump with dump selectors. For example,
if you are interensted only in port of specific devlink. That should be
enough for most of the cases, no?

>
>I have a strong suspicion that the user will want to access all
>resources of a device. `devlink resource show [$dev]` should dump 
>all resources devlink knows about, including port ones.
>
>What's the reason for the new command?

You are right, one cmd would do. Good thing someone forgot to implement
dump for it :)

