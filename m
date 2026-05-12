Return-Path: <linux-rdma+bounces-20465-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFe0LxToAmpEyQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20465-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 10:43:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF1B51CDFC
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 10:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52689301F7CE
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2522496908;
	Tue, 12 May 2026 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="sY20+c4Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFCF4968E8
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575368; cv=none; b=qIb+eRLvGKHWSmuOg7g4XHzzKHcKA77S7ZMrpZHQUbiMZdAfcAPQo22CrWlSS1W67oXt2cm1Mqinbn3H71sKtKjndOCQPguhSCa7FwoVI+GYY8WMAT4zgakvu0B6W44P9f0fnFirPrlr6CXqp+GxfY+QS3jtde3+/wN3wevsFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575368; c=relaxed/simple;
	bh=YsbKMtLsF8n757WsDejnc9PnHwNnAlr9Ml5HzNjnAY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj8rvfaIGpDDqEftEjC+lauIu3xt3/gUMPT38LizqL2Mmh5k/hfTsXTOBWTI8SeE6L9OYEgnFA+UTrmLUa9oRLeLgsAgodWvNebiadPNxkrVGP79BojdDKtVBUv1/8EDGZPc1dhybKdNSsaIce2a0dhOiJT9tjRtWFKhakddjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=sY20+c4Q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso48007495e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778575345; x=1779180145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22yyk03jobS7/yf02FbmawWzo9rxTI9n393P7VL0W2c=;
        b=sY20+c4Q7FYmUxNrxfwNltQGQG/Q2Ncwgj7CINFni1jYq3boPZrA154ZIy9YKMR6BD
         9tur3ntpLTCkxlDpPHiu4PRO5F9BedG/cGipgnQdOl1L7uN5QCTyuvcmdOojeWLZvnX9
         8o+TDscy3ReFabiawRcyBWqnlI8ecwA/E7I5P3cw90Mu/ro6sYEK8V9sXadSH4TMTHfR
         h7KhyTNgWTUvSPWsXygY+zeFGoimXrTMHq1GTynXwheC34ru7XjVUnf3B0lnnsRgKr1D
         S48ktP3gapZNRMFSm23KLt40kHH78/7NdKWkFIQBuP/XTWMPYwqOfpaTJaeWuhevgaEa
         RIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778575345; x=1779180145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22yyk03jobS7/yf02FbmawWzo9rxTI9n393P7VL0W2c=;
        b=a07UHZmMRIWnxLu4LaVk8dT0vduwiXV7uT2x7OqYBQ2sLfDMKjYeGKVoMs22boPAx7
         dVVodEb5RgM/BgS/N+ud1Kg3ao8QIqy9B+4TU+frwrsACP71afmFjjNp7iyln8413vZX
         Qz/HQ+Ei8W14mUF68FvwgbAsF0SsKXq0BAbux7HzeRqZWlCZeWWnny4X85j6Fgtb2Kti
         rxgnagrwTjtArBRY8lkgpfj3WRzUpLgt1dslQzu/Kmu9cEWfFXoIRfG1PNFaUFmEzJIQ
         Rs0ZFzI73HI7Gppw0tN4hTQDi2iuGVD3NgPaYcSxKXIwUhkAh99tzyCRleUmF5i/WFfF
         +07A==
X-Forwarded-Encrypted: i=1; AFNElJ+cH25XpMNAWPXqi6SWolurOf4bW/D5G6+7rj5gUH05qhxJqYEeNCLea2VdN2QqkWjsNoqqVm8Fgv3+@vger.kernel.org
X-Gm-Message-State: AOJu0YwlySAfQ+6EQZUaIR/5fyJ2rW/cZQcn2LTAN9suIbHfBIOBBnLY
	2r9Qtk12VGEIT/Wvyg6z3MOrFaqZvVKAYJHQUnuHhwa4UbxVbTghbHvnBT+1juhEMx8=
X-Gm-Gg: Acq92OGp+R94bpJ4r+qCDcGraJl2hfU3L1nfxX45Rfu7HEBruFTzLs486BOp2rUAvXB
	d35ozoZfeQNuNhu90J/+vOjH872wPT409tRbXLVG3eBvQRsXp94VudbqbLy5+Tihsi7ABIIWbce
	hPTlNs0h0ZU6IgGgJaiKZZcwD7RQ8d8gZvU/H3IH9YkJlX0Q9tocTRU+1XADaQOwBvmoW0R/9IP
	TtRMfLi3Tt4urQXDIp/QcUBK2jvXHT7WQXIV4gs7nTHgjKX3SCzZxJ+v3DD9U1XRj2oY6gvo2xN
	GNss3+/pxcx9OtUvMydPIk1mavKcbxey2epd2flH1cBqSmHS9HQ3s5Ir8V/zIru6JseJTMIsVho
	DT6B1lCjVI1irNVZSY66HnVD4MTg7y5JY2lePIgdV1A17JkLURUsmYDprzjgk5i3rMOG5MAfI51
	8N17YOGArPhoj6+yLhj5kcY1nEP7zjymvf9bzAfjDPLrK8EQ==
X-Received: by 2002:a05:600c:6299:b0:489:1f97:6b1d with SMTP id 5b1f17b1804b1-48e706edd0dmr212584825e9.28.1778575344445;
        Tue, 12 May 2026 01:42:24 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491cab9c2sm32800055f8f.31.2026.05.12.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:42:23 -0700 (PDT)
Date: Tue, 12 May 2026 10:42:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mark Bloch <mbloch@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Randy Dunlap <rdunlap@infradead.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Christian Brauner <brauner@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Li RongQing <lirongqing@baidu.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
Message-ID: <agLlIAX7EuYNuSNk@FV6GYCPJ69>
References: <aftaW-irGmkfA7FS@FV6GYCPJ69>
 <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
 <afxvzOjqw-vxUAED@FV6GYCPJ69>
 <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69>
 <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <20260510093732.6ba47e54@kernel.org>
 <agGOeqeNwJGJ_-2A@FV6GYCPJ69>
 <20260511164132.2df9c5a1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511164132.2df9c5a1@kernel.org>
X-Rspamd-Queue-Id: 6AF1B51CDFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20465-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 01:41:32AM +0200, kuba@kernel.org wrote:
>On Mon, 11 May 2026 10:42:56 +0200 Jiri Pirko wrote:
>> Sun, May 10, 2026 at 06:37:32PM +0200, kuba@kernel.org wrote:
>> >On Sat, 9 May 2026 09:01:23 +0200 Jiri Pirko wrote:  
>> >> Sat, May 09, 2026 at 02:52:13AM +0200, kuba@kernel.org wrote:  
>> >> As "a non-SR-IOV user", what extra representors you talk about? When you
>> >> have pfs only, you don't have anything extra. Just 1 netdev per-pf, one
>> >> devlink port per-pf. What's extra about it? When you don't have VFs/SFs.
>> >> Everyhing is the same:  
>> >
>> >Some devices have separate uplink ports and PF representors.
>> >As I said, what you're proposing isn't going to work for all drivers.  
>> 
>> Well, the point is, mlx5 appears to the the one needing this, not other
>> drivers. What I'm trying to point at, mlx5 should not need this.
>> It makes things compicated, adding a ugly knob for no good reason.
>> Legacy/switchdev mode, in both, the non-sriov/eswitch user should not
>> see different behaviour. The mode is an eswitch attribute.
>> 
>>    devlink dev eswitch set - sets devlink device eswitch attributes
>>        mode { legacy | switchdev }
>>               Set eswitch mode
>> 
>>               legacy - Legacy SRIOV
>> 
>>               switchdev - SRIOV switchdev offloads
>> 
>> 
>> Briefly looking over other drivers, looks like ice, bnxt, octeon, sfc,
>> there is no new entity created in case of switching to switchdev mode.
>> The only driver that creates separate pf entities seems to be nfp,
>> but the mode seems to be determined by the app being run (loaded
>> firmware).
>> 
>> Am I missing something?
>
>Hm. Okay, I wasn't aware that mlx5 was the only driver that did
>heavy-duty reinit for switching modes.
>
>> >> I look at it from the perspective that from some CX generation,
>> >> switchdev mode should be default. So that is a device-based decision.
>> >> I believe as such it can optionally be permanenty configured (nv config)
>> >> on older device. Why not?  
>> >
>> >Feels a bit arbitrary and won't cover all cases. The question should be  
>> 
>> What cases it does not cover? I don't follow.
>
>Other FW and HW versions. People are still using EOL devices (CX4/CX5),
>IIUC the nvmem config path would require FW upgrade.

If user wants to have a new feature (a bit odd to call this feature,
but ok), he is obliged to upgrade FW. What's wrong about it?

But, even without nvconfig knob, what's stopping us from fixing the
behaviour (/bugs) and just make "switchdev" mode default in net-next for
all in mlx5 driver? Again, perhaps I'm missing something.



>
>> >why you are nacking a more reasonable solution. Keeping Linux config in
>> >Linux params.  
>> 
>> What's reasonable about adding basically a module option (kernel cmdline
>> is pretty much the same) for no reason?
>
>The initial patch as posted added this to a mlx5-specific module param.
>If we need a module param IMO generic one is much better.
>Doesn't matter if other drivers take no time to reinit into switchdev
>mode, having to switch mlx5 with a module param and all the rest in
>runtime is not the best user experience?

I still believe we don't need either, not module param, not cmdline
devlink option. We just need to fix bugs and have proper defaults. The
rest is shortcut.



