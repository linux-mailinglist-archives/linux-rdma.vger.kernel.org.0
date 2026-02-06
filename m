Return-Path: <linux-rdma+bounces-16631-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Il1ABmzhWmbFQQAu9opvQ
	(envelope-from <linux-rdma+bounces-16631-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 10:23:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C231FBFAE
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 10:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3304B303FF3D
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680F035CB73;
	Fri,  6 Feb 2026 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1SD7lkyc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE756350A10
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369674; cv=none; b=laA9eYEceJ4GSgBwqtisPJ1jy+GVEok8Vr2o6JS/MRQKsFb9oVwtKm6r/FlUsPEOXCX8QN5Vvq+ftlfa4eFo+V76v3RJ0lWNif0A+yCC0VZUman/f1K9f06ZydAH6vx1jQpnTjiHfmgvEGNMR6a+w9qXnE1f4XkMb/kUYI3TxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369674; c=relaxed/simple;
	bh=uYHqopYroroGJu4jPezMwlTHDcRYczudf62+B8v8YAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE8NqqkdmXA629mOEEcjZI5ePa33RLS5fsnHkL1ClfBrf0kALCiN+hg/kUxcEu1kRzACK+wOHD6kdwql5S8VAY43FO8vdQ+0u14Tf3DDIkizZ6HQZwJ4Y8v1XoiP+hW9/R6J7UOVqhyPnwX4FXIsUilMJ3+Hes486u3qND7n9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1SD7lkyc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so14092315e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 01:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770369672; x=1770974472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYHqopYroroGJu4jPezMwlTHDcRYczudf62+B8v8YAg=;
        b=1SD7lkychrBCkUtZgs7PjPm5kuQs14E0On+1DH2AAOVRkYXUmDkdt62pIjvCyEtsTB
         BDOkASCgvFWvIWLPjSmmRq+37Dcl7/RAl3s8OVFyO8BhVQSeIGsKyfIQKkUPPrO8G6EL
         gcBeQDKJadLj9buu7DIeEcHmiRCSS5NaQ9dV7+BCbYyzAcrMFQCmsTrPxdftsYdikH6e
         EgLSTygeRc1ju1n97ukBjdnWsThiAiM0yQi1IOjJnypPP6Xo6rVqNrSoKneyC0JHG7X/
         kNK7I3JQqD1e9wUinelrzX3v50EZTsU/RHiEr3oczDNWqJMeCYsHkOCXAS6U5QeFgMlU
         KfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770369672; x=1770974472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYHqopYroroGJu4jPezMwlTHDcRYczudf62+B8v8YAg=;
        b=Q3Q51C2L2Lnw5+dNhXEECN+BKaW954EOlQt4kCwM1AiHzKrq7t1yiIwEtrOIVYH5S+
         g2ANCkOYFSYVf3155uenBOkIxX7Hbk6M8fosZQZiID5bC76X9c4mxMfxibqd2pAQkd78
         UhzgqF24xaPeeSYfiJhGpkATZLwJH3Cm7pf98yzZu/hDIomAjNzN42cnPk/ROi1Fwhgp
         ueL/ymtekuu5VwWK5Iaie7M3P1ZF3pP3d3vx11JgO5hEtgCXNndMfbaJzKHabS8758sl
         +dxITs8OWYU1poFNy5ioeozeTmOT/XV115xC39vSL2uWvd+1Fnp2PW6HBtY2xrfoSjaG
         Gwhg==
X-Forwarded-Encrypted: i=1; AJvYcCVTq44ivOCahU0iYAi5fu+a4z8oAFsCra+byF5hUY8AoBOCefHe9XXEaEIrkv7RPMTS8xkxbXENGLJv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0RGO/VUZSj+zdzDT2TTkYjeS/vayZ8C4XSNRgCZl58F+NYaJ
	m3vmxg1zb3sOVD/EA1GWUUcydBy1WLarQAKZTSh534mOJ/QRv2CQjIkLbCkju+/OXxg=
X-Gm-Gg: AZuq6aI9tgq3pZdhd9PGXWYcp0B5IjcigvzEWVGTrUzzia+pIH/+IsJ9krOMwqjbV+O
	G6PibP5AP97L0ixWLc0N+K0U6TYRFC6uVeZJhB5x1a4dWHbQDe1eclgPSrdnAlVp77oG0zjl6op
	L2EpIMEprMCnQXh6es1pOStr1h+yehtMVdhC7xE5Sk3cJ4ep8Xz4w2o1d/4FxPglAt0apzRjdTU
	kHRc+9S8cJ4sc+5jztUKIJjFjojkKOFtJN/RaX6ahwTD9IdTR+qgMW2dR7h+D/eTVf73lOHAbjn
	kj+jLl3BaIhE7H/ghCfkEBZWXBi+d8U2TTBd6TUfWBLxKNfYY8KSa6I/SNyrOpmrqx/DPEAcm0V
	atWWxl7VYlZX2pHXYKZTosNMB1aNg076APHxrtdoo7X78umHlJ5kfMWW6fqWVHqe8s8fqsq9I0U
	aZG0BaNng2oexxLtKTuOa9Wxa2IHtxIQ==
X-Received: by 2002:a05:600c:8b57:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-4832021d9b3mr30466725e9.30.1770369671987;
        Fri, 06 Feb 2026 01:21:11 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d8341csm109643915e9.13.2026.02.06.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:21:11 -0800 (PST)
Date: Fri, 6 Feb 2026 10:21:09 +0100
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
Subject: Re: [PATCH net-next V2 2/7] devlink: Add port-level resource
 registration infrastructure
Message-ID: <oh6xvllidmtqx7wmsbmvghc7zeokvvgwkj2kbt7erwhn6jt7r5@gl4knllsp35u>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
 <20260205142833.1727929-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205142833.1727929-3-tariqt@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-16631-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 4C231FBFAE
X-Rspamd-Action: no action

Thu, Feb 05, 2026 at 03:28:28PM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>The current devlink resource infrastructure supports only device-level
>resources. Some hardware resources are associated with specific ports
>rather than the entire device, and today we have no way to show resource
>per-port.
>
>Add support for registering resources at the port level.
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

