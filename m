Return-Path: <linux-rdma+bounces-17508-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDvVOqY3qWlk3AAAu9opvQ
	(envelope-from <linux-rdma+bounces-17508-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 08:58:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B120D09B
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 08:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D66DC3031AE8
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE1133A005;
	Thu,  5 Mar 2026 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e7ohBO2E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027A339853
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697410; cv=none; b=beriKGBv2uv+Olp8M0FG3pnqhwsHxp1HAaM4+xTieh/8dNwWKlX7pn64MFtIMGufdx+pO2tFKamKBAJx/odfPJfzEfL0sCWhF9g1WuxgscpDY8rQz2InhlgP10yGdovYHoED4EXnZwP0S4yQyN6arcAvKIyjfuqYNdZ3DBdztok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697410; c=relaxed/simple;
	bh=mz/EuY8jC9ieYjTjT8XfZfn15rgLMQGbwpMFMcAlAtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck69916THGmnGRsIdLulDWyMe2+W6m88EPJkRn64EXYFb5z+2W+63GcXTm9np/kc7/dwjgnDzt9/cPsQVoV5x8cETE2voDUud3zxc8vkH0FCjKti6E7vjQ4drGa65rDC/qvTscyzO6oe5ZJQdpl/1P7ORhJ2lXJ/WzeSr5moO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e7ohBO2E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48336a6e932so47821925e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 23:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772697405; x=1773302205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5kaz3yDs+eQ3DSayWibzk/nqIRQjOvr8dHk2wAo4yE=;
        b=e7ohBO2EoHi9AUF1ByScMnNHk8aK8R7h37+EEg+EYAw2pTDLpwa5qXzI+XjgNZo5vW
         oCN1/FzT1+P5/bEe7/Rqk8NG6GKlhnGhaT+nT2Ximp2Rw5ehAVs6hNczVJzJhbK2UtKe
         VI/HJ3lzX4G/eM+cddPwkrNT9rtIdF+zZ9pXL0bMGp8173Sv3Zj4q+Yv6eEmu83ZSdJo
         EV/RooVcqE3OT0Ukd8LBHzI3glJnZ6J8qJ2R3tkyHipozJmpCqUTeHxq0jMbXJApxUii
         PNduuJAC9gOQ39xvHQTBgvigVuRqa0FrqTf3Qqjp8Hqm86PxWxpIpNC7B2tac5WcXUGM
         QRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772697405; x=1773302205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5kaz3yDs+eQ3DSayWibzk/nqIRQjOvr8dHk2wAo4yE=;
        b=kGus87xuoYsQWFsWuoLbDb/9w5aWaFVUITAU3r6bm36zlI6iiUnwpfMODXvD2tqzWa
         Jaf4Ylc1yo/FaFZVwBP+p+L99zEL3mStWRN58FRNTUbx8KenwSz0YRWxqDv7/WBGURwf
         LRpC+woKST9bY2yM1n2C7Y/KEUxXVSEnob+yFQ+RqnQeOUjxvME9T9Lqvp8Ifnl/ObJU
         ofDa+URS/paABNC8+cHIyA0RCqz4MEUZOSJiZ1TrmxTez1oSdq27zOAC6VKOI+sq9v/R
         q+TrFQfeDSJ2vDluDLKu5VZLul6p8tfX/9uk/Qc/ao8J9ZfBF8pMnZXPp8wooHOA2+vZ
         b3LA==
X-Forwarded-Encrypted: i=1; AJvYcCX7BfCDm87KJmYQVlY6BNqW5n5IOoXQ55pqJ/n9yupYrlK4bO1RVfD/q40hRk/p3YfE4OuuMCf+vtN8@vger.kernel.org
X-Gm-Message-State: AOJu0YzKg+XDuWKZ3q0Czu8xITH1dC7abUVB0onCAnApQbROMREQPDLK
	V0Qe/uroKWm5kD1uZknDbpSdnnVmkjMuJ9da69b9JFQqRA5LCwUc4Rj20dAw8XnwMlM=
X-Gm-Gg: ATEYQzwSBhRIdBfljwH0c/LPP3ZlFKImaBy9PW9dvWfreyjtRpn2lj3TU1lW/1M5J3X
	e1ZB+2T5/ID2uyIHzl74cXhsrUI4TiR60EFu8i85PTQ5+DmLeJTUbhIetuti7ToVXqWOn1LHGDW
	O0JIFrisvUdy5Nw58g7JBapfcECFWcfb9sKoESEtKB4pDv3qGD6JoMbSaKdO/b6OCSm9zBuRX0U
	c8OQ0PS1y93bRj+Y7OrfjQiimNqagXWd9711vvdXsGunTx7YjnnPgKgyTVct5c3QLkdCDjM8Ul1
	2zGU8CLMIuyuPO+t9b157IWan6C5gyQvoVkQZXF0tZBVWSHhjHJRLIpByuo/ws68yqVM3bNLCO3
	Bo5EP9BW2hc2R1s4spIQt/g8rDf4Hy543wzLFV6MVRW69uRPLueLVDeLX1k3Bf+z2m7yF8QXRWs
	Y7Zm7aozj6jEcgD+VXhVGvB5ma4W8alD4PEhE=
X-Received: by 2002:a05:600c:a51:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-48519886ca3mr85966475e9.21.1772697404947;
        Wed, 04 Mar 2026 23:56:44 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851acfbd1bsm42090985e9.6.2026.03.04.23.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 23:56:44 -0800 (PST)
Date: Thu, 5 Mar 2026 08:56:42 +0100
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
Message-ID: <np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
 <20260302192640.49af074f@kernel.org>
 <pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
 <jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
 <20260304101522.09da1f58@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304101522.09da1f58@kernel.org>
X-Rspamd-Queue-Id: 8F8B120D09B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17508-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Wed, Mar 04, 2026 at 07:15:22PM +0100, kuba@kernel.org wrote:
>On Wed, 4 Mar 2026 11:34:13 +0100 Jiri Pirko wrote:
>> >>I have a strong suspicion that the user will want to access all
>> >>resources of a device. `devlink resource show [$dev]` should dump 
>> >>all resources devlink knows about, including port ones.
>> >>
>> >>What's the reason for the new command?  
>> >
>> >You are right, one cmd would do. Good thing someone forgot to implement
>> >dump for it :)  
>> 
>> On a second thought, if we merge multiple objects into one dump, how
>> does this extend? I mean, the userspace has to check there are no extra
>> attributes, as they may be used as a handle to another new object
>> introduced in the future... Idk, it's a bit odd.
>
>That's true, the user space must be able to interpret the object
>identifier. So if we extend the command to add more identifiers
>we will have to add the bitmask to the dump request, and have
>the user space tell the kernel which objects it can recognize.
>I was just saying that we don't have to add such attribute now,
>maybe leave a comment in a strategic place for our future selves?

Or, alternatively, we can have per-object dumps as we have for all
objects and command right now and leave things simple and
straightforward? I mean, I don't really see a benefit of a single dump
for more objects :/

