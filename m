Return-Path: <linux-rdma+bounces-16635-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAHsGHm3hWmOFgQAu9opvQ
	(envelope-from <linux-rdma+bounces-16635-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 10:42:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2B6FC2C2
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 10:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FFCE305C2AC
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5935F8AC;
	Fri,  6 Feb 2026 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O9tVlAas"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B435EDB8
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370622; cv=none; b=f3T02w8Th2yV8gyVOZ2fl8HupmqC8pyUtRDusH0O8bGqjbVtNvonvNV9GGWdCn72qeUmmMbMd/ka/jVE3wOsPgp91kdX8F8p2aC7IMf045pXwPAaNpquiKY4AbMbbmOeHL3Yl1PA4fx0QS45SPJXx+5tXVPwN/C8sm1AswwLxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370622; c=relaxed/simple;
	bh=PW/cUZwzFiiiVYrbjLi+IZRoi6zXuNxLhvfj3skBHOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLndMjLXlxRkIN3hA7bjR3eBZOUq3ayoDH6i1AEIQquLbaA4w7qsrdcTlu/fG8VsKSSgPErNshhtfgmU/1/pCRQmepEeM5c23wF+7esUsZdZ2v6xYGciJcU+SMZ9qcdNIU9xg2nFAfyrwqdIrwhUkSCRMqjUIAUD1vaew4Dz+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O9tVlAas; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4362cdf1d82so222210f8f.1
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 01:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770370621; x=1770975421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PW/cUZwzFiiiVYrbjLi+IZRoi6zXuNxLhvfj3skBHOk=;
        b=O9tVlAasfC87pV8+srE8Fnp7LzWL9qTDXNIdbHPsDemn04UoLuwt75lx1yjKaejc/D
         3IVAxkmeTjbWhCkwjvVprBNN7oHGz3yGjKohL6nCGX/LRP5XxdF/jsP9b4UIrvQAswEB
         v+r5JULntlZ4PPfiI95wnJXH17mkmS0J6Nm9NkeMeBpyBxiJQsjdQTLhO103M0JcpquT
         YRlMWhJ8yLc9p5DLqqAy6GLkd+4/LisZLRfdkO/GBx9rGZ5OZXIKK2/xejfjFNZix2lC
         xLlCuTEkuN8NX13FdtB7mjhCklPmZoHSgHs98HIQQjN9mE8KDkUDyWdEqex1uQDS+NRa
         mpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370621; x=1770975421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PW/cUZwzFiiiVYrbjLi+IZRoi6zXuNxLhvfj3skBHOk=;
        b=M78m2DH2bbqJbskDYaOouyIuAAySzZi5fM7X4ENvW72Zlv63ao1pnIDkxcTnhe+Lg7
         sOhsmtSUga/gIlgFZ4+twuvP4dYm6w2pzi1G73O+tX/mrz/Y6K/DdyOgDMX8FrSKTFzp
         kzbvWjOohFQdIAhclcLpThxK2wkqwUL7Wc7WUYko7CndaUl2/K3qNBzmUxr2y2y37tQ9
         8f6y70EzoALoKe0APbp9DLQRf7N/AEwzLPjwej3PZ3ZFfClH8tYHBOOpW+MC9+K2tARC
         xCSaoXi7rx8cuPRBop+0WRgOqQbaERlgq2s51WJOsgqBjAahv0i3RLSkHJu09qnKobBi
         +1UA==
X-Forwarded-Encrypted: i=1; AJvYcCUsY5t/EFJ8jagR5DWguKggJRZ4J4kPTEedcPdpTM4pgSlp2TMS8x3YR9aEZdCTiveuovtsa3XQVDPf@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+vfCZXEm+8QtzvKgsRrayEMA/F17G28b5IAcYs2TF8mpvxRP
	c+QzOeZB1nT7v+q6wo2gCUNsNkVpQw80pv+13/xXjQc+qEoR5ecoxou4+RW03G8+l1c=
X-Gm-Gg: AZuq6aLnhroPCpkUzhX5Y30kqv5vSzhr1XywrNeoIJvuYMqZY8fKOYmxq9I1lHg1c73
	IPhQY5Lx6b/VUTltq+eIAbVQP+/urGC9Ey9eQiqZnyMPQagIJiW8DWOH5oN1F/8DOHojukMeqsa
	92omDPbJnAarW139zcl8B87i2YPsjyc4KXo1nLSKxk2/EUbw0A3vfLUJjGzAT5jbSNLG8da8XEW
	ouHswQaw2hsCODwRo1COI5XLOKo2zBU0F3upu4fKZEWcxB/8oKjPVUxRlJDkjSqHPr7jdE34e0k
	ebd9TJUXE8pV3jaVAOpolXNuEm3LzS+WhlAyvSMFfKmLH8dgSA1CwA0AAlnmQEb7AkWAcjjdeBU
	XZ3M34cZXDMYSRCo5M1qmVz/znZD2g909RhAyV9wq1FFsB6FOzBGe7GAiaX2bUzl5xZ5R4ti5Ss
	Ez0FEam35sre1vQbGYkrUK7+wrU9bPSA==
X-Received: by 2002:a05:6000:2c08:b0:435:a48a:123f with SMTP id ffacd0b85a97d-4362937b167mr3578107f8f.42.1770370620697;
        Fri, 06 Feb 2026 01:37:00 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629756b0dsm4020062f8f.40.2026.02.06.01.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:37:00 -0800 (PST)
Date: Fri, 6 Feb 2026 10:36:58 +0100
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
Subject: Re: [PATCH net-next V2 5/7] netdevsim: Add devlink port resource
 registration
Message-ID: <vtlfg47c7tme2stoefit6nws5fhxhcyx6uia7pcbqvi4xenzoj@b44ivjpnwzgx>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
 <20260205142833.1727929-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205142833.1727929-6-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16635-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA2B6FC2C2
X-Rspamd-Action: no action

Thu, Feb 05, 2026 at 03:28:31PM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>Register port-level resources for netdevsim ports to enable testing
>of the port resource infrastructure.
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

