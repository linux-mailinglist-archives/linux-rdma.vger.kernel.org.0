Return-Path: <linux-rdma+bounces-21272-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KaOLw1PFWpMUQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21272-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 09:43:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0E5D1D62
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 09:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9400330298B3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 07:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4A83CC30F;
	Tue, 26 May 2026 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="NKvgWCRK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0193CBE79
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781326; cv=none; b=EvIbldCRBsEk67vKU5aOY6ncMhewprYSVMGRUmU/4vfdii1vArLex/XPYs3XvicGlkuIYvJsVB7/OItGTJJ5arC0WZBn/mT9ktcMuAVL5r4b7NFcLQIpT2FJCue0k41W1KEXJ2W089YtZKT9WQntppAftLLLaxOunkGDhiLlUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781326; c=relaxed/simple;
	bh=E/qFLtmVUNW34+Ixf++D++sSrm9KXhLgjM3d4kgyiZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feHjUeiJtGJFwrcnW11Goi5CL1Ru6QZy/v9/c8Cnolyz4OUsjR2vEHAh0Bf36PqLnJoYP7y6TmDCfUtYnZA4fFbtDDoQC+Aadca/JW/iLqfzHapAvieC0C/L6hcb3eNB0m9r1CuAGf41Wg6IXOQnDjUrOesIHIQKH66azlw+gyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=NKvgWCRK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49068493267so11769655e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779781320; x=1780386120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/qFLtmVUNW34+Ixf++D++sSrm9KXhLgjM3d4kgyiZI=;
        b=NKvgWCRKQAxei3XOKqtyPqJk4M3SHlJ4ifdvYXIiwEnQ5aXiynfRwcz/nSWDaopK3l
         ZEMPiaD3qWuu0edhQkZ3vVixgGfySaFwv9jmPkLfcOqcNePhiVj1n6IavLhPh8Ro6OSL
         Fbc73d+w0KDbvdkxjN2eAiePbpEpeCLH+NYf6OuBHKlOwBrjQ9z1RwRcS9Qr/FlO3oGu
         bfVYvC/V5QgLXZTgmVOrMhg5H73tsSqvJQlHkfZBlkcX068aCzp7hXoBe0IMoE76dRHE
         T9NMKheRAOvBFZmmWKRyw/P7H2HJ+IJpQoJU2ZTOhVL4DFZpiuCov+OzZ/xo2pGAiTJ1
         8CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779781320; x=1780386120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/qFLtmVUNW34+Ixf++D++sSrm9KXhLgjM3d4kgyiZI=;
        b=ellXfhW+TmeQS9ujj71wTbOeB6Enym/egwepTgZlI4R21SNDrR8x3rhppKvi/eyene
         4lWUYvKRdrvMHFtSMk/RVESGfzssGN4F8CmaN7EH1YQG3HU1u7LK3ZfwUDoB5aKRSjKt
         eADqysE5MRnKSM3zB+kvwqKzvvArFJWUmSDhYXFlD5iefYStWXXHlXtNSBN5ISX4NG/F
         6QeVTCMIw2C5AJazRxxbEBEumMRpW8Nr/0TPl8YMos1g7M5Rd8c3+yDPZY0YT5t3Rybs
         KXZEir2oK4a4e1saqnc66gbj8x10o+ilipwqqmYTw3jWn+VIGaZ157KS7bZ8S7IkaKAI
         EuTw==
X-Forwarded-Encrypted: i=1; AFNElJ8acUDPDqlaLklyVhJuHf+8tH6liLRNSgznwMbMYYqlGNo4dFZmynuKia5y1a/Moex+sT3iaszZQIZg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzecww3xsZ1tXG8Y84qKhqny4OCApDWtE62WOc3C20WFlLpSGNR
	C7C+Lu3F8DIZ+Wp0pZgHxUCkfRgdrtRUoofcDIy/sYdgfVqMIzgRlWtsXy3CAmPHOj0=
X-Gm-Gg: Acq92OHLu7tNRlS2bBmKttA4MVMiqr4yhUNSD6rb1tKPLCUiB8ecCQs0WvyuLnNbBb0
	6wWu99R6HYrYI5AvM5HGqmxxus9A3FMn6dx/TIvXJ4Ji/xCUl1JjcIfGL9J+54xscgmObOI9D2m
	6E4rMZqKkKPv8gjPmQcH8pNY5ZjP7Zty+6S21zEK5nphyTWFblfz4R+nFP86QMhsXX5Ch8S9XS5
	ckB+Ly26pxWISPtBhWcSG6r4CS6QhE68/yzlHEOFBeuihBoliX94OUeq089KAqD5/xHFdmlvxET
	0S/VNFZPhrRPTmAmn4lUmnU0FQlW+YRrxpmWNCcVIN6n9QI2tslZlFDW8Z6sshEDmez8p40d6QK
	vN5g2XDsMNkc7LzR+gMvk4ZFag8PmxefQ62H84GkQ8IuXnojvPUKvcAAXmuImRQXxDaLMGEdPC5
	xgKgtDi8KECvzzu8LY3rCOTHw+LJ4rwTjevND/XQ+qdNA=
X-Received: by 2002:a05:600c:c83:b0:48e:60a3:220a with SMTP id 5b1f17b1804b1-49042250219mr286320275e9.0.1779781320072;
        Tue, 26 May 2026 00:42:00 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5caeesm34281078f8f.29.2026.05.26.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:41:59 -0700 (PDT)
Date: Tue, 26 May 2026 09:41:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Li RongQing <lirongqing@baidu.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 0/3] devlink: Add boot-time eswitch mode defaults
Message-ID: <ahVOlJdfgkRa5z0Y@FV6GYCPJ69>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260525124256.650fbd9d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525124256.650fbd9d@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-21272-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
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
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 38A0E5D1D62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, May 25, 2026 at 09:42:56PM +0200, kuba@kernel.org wrote:
>On Thu, 21 May 2026 10:24:31 +0300 Tariq Toukan wrote:
>> This series adds a devlink_eswitch_mode= kernel command line parameter
>> for applying a default devlink eswitch mode during device
>> initialization.
>
>Jiri? Are you okay with this?

In general, yes. Couple of details perhaps. Let me check it more deep.

