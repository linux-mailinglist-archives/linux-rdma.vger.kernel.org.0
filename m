Return-Path: <linux-rdma+bounces-14868-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF890C9EBC3
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Dec 2025 11:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A1C3A6D37
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Dec 2025 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543E32EE5FE;
	Wed,  3 Dec 2025 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0gT/UOWB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DED2E9EBF
	for <linux-rdma@vger.kernel.org>; Wed,  3 Dec 2025 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758180; cv=none; b=DTXp+HLYlcIAuOcISLQzHmuCGsUA92h3jPTE/qdRYJckY4Uilh1F+lFGzcmc3kg+VWE9SiwvDGphfxm2OBM3QWOvCUAcDj31+Cecv1AgdJWsqIOyc0Fx0r4CzcxpUXf5lfeQdl8aOfVsSFeJZehNtjD91TKAH7ptTrp1FT4pgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758180; c=relaxed/simple;
	bh=GiLdBM8LvjD5dwdrVWkmdwmePN8KQT/Hw6JieAVZlLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jetFiex9udTJ9c91XU0VHktjx7EplWpB6uwbETcwHqG0FfUiZ3e5PJ7x7BgMWDNI6XoKbRtkE6JYDDAXL/FLwE0FejYGgl+CleaGmnvd9l3JhcSyh4FLzr31OSVHOyWlutiff0c1MTb2c3jjT6yfp3a/KX6AJ2tqMLxBGyeV8Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0gT/UOWB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso5276425e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 03 Dec 2025 02:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1764758176; x=1765362976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyIaF1ZZoiI5thM+pEUZh3TPbJ3eEVBLKOsqp828xqk=;
        b=0gT/UOWBqGmTcjAf2oc73S0ITvzz5n/9CiOkyjOiT1UAYrfS1YlT9r3OR7STXTARUU
         nVd6C3n+5dAiRGNivxPJz4dlRqwUF1aYu+mOZD86GIhezw1SpV2iGYyNZGIW6kODKve9
         3GpkXtPKON3SU9dpWwfETnSahqeLpuHW2jMVTYkL3QknLvEKxcnYWlUJa5aFAsr/BGMI
         9zYEMcZ082+C/9fs1k8BWIzcLSmjoJalf2j2i1ud/p2dDhONBwwmuN0RGXJJAfMdJQ6P
         E6px6M4ib7IY86gVjzZDNa7nmyRQ2blA4DDYyXnepuEdyhIdkVggoc0m+KhgIkVzs0KU
         Ij0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764758176; x=1765362976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyIaF1ZZoiI5thM+pEUZh3TPbJ3eEVBLKOsqp828xqk=;
        b=fmVQTy7bUevyGHmdE9475wE31D8FdGgBnNDx7rGbMEg3n1msHlXAheW6oX9HAMLJgs
         yV8DyXNBqmcZIbK+70J3ghEscLiqQ7YTXI+j1q+ZUmtPKDq4NkF5m4zlfW8GnGzQ9N9S
         SooOwCcmNKr0h5zN4XMol+B9kBiCMlrmu1zef351YJ7OdijYt8vH2DTG7gbLK8N0rNSs
         rYo8f2oxovgKKpYucdrlb+N4fbOqH3/Kc3hJKl01Vur67NS92mrzcJGd6iZfMknUstI2
         YH5WASYtj5XyRo7MxMLaKm9olZrlF3SiotY1qwV8KgV3ODG/LpWYmFkkPyvflaA1aFot
         6Dpw==
X-Forwarded-Encrypted: i=1; AJvYcCVWxZZQpM8be2PbUWFcKRKEkv1WZrCz6hZpBDcnNQOhDepoJPt0bg5cdkU49lSs9yzoHR3zc5FnQJNl@vger.kernel.org
X-Gm-Message-State: AOJu0YwcqRDVn6joFBD6m5t/ceutKEmoeaKx9MEZ0Z4oQsHt5Zf/bQuk
	ASI+cqzfE/AuTP6GMEDKXCEbuMgxSehopplRn0QYHp1YZC50gPFYQ0LkC7zZdARSy9Y=
X-Gm-Gg: ASbGncsJL/TxHKeNpBl/Pl4N2PhvatpRncr5xS/KWE8QRxvqvRyU/Y1BCBNPYjC89cn
	ekh6vh1jhs0WMRwt8sQPRjHvkD1kc0AlAKgSWAaCUIsF8KTLIui8ZQY2GxgK5dfHelCBoQnv2fe
	C3eABsTo/Yg+AmwYWQXElZgbFom/BlOO5uj7aHj2VLzRBaDKsbRS8MkA55/5k0zM3r1lBStQa0+
	OFBkTOYfd1SW9ywEzoZbE5Z8pHG5xzVl5TLEQ2YbUgGn4yDiaEu+30aoPeXrEZscEyuzPRptG+P
	AQXKATApbyIGyQ1ncUvCLZXn6/UrlCAjcnCGaR2VmjCBWjqhmANM5iYLa2xJst5j2yaFUNvInh2
	uSsK50/w4EDuLT1QTBO/9IpoqZC7FWP6IP0BfUutYLNXSdOjgYhxLQauk8woXmYT4cW7IYsM+5/
	L7fQ3rz3ksgZSGuAqFJt0=
X-Google-Smtp-Source: AGHT+IH1dq7fxDRNIhcm0BrW7rgm1HV8GPjTBEz9+0SlOEhGSmCdlKYZ60LdcNFAgyTCThBCp5KxCw==
X-Received: by 2002:a05:6000:2084:b0:429:d59e:d097 with SMTP id ffacd0b85a97d-42f72d722famr2252853f8f.9.1764758175805;
        Wed, 03 Dec 2025 02:36:15 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c3022sm39020547f8f.4.2025.12.03.02.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 02:36:15 -0800 (PST)
Date: Wed, 3 Dec 2025 11:36:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH net-next V4 02/14] documentation: networking: add shared
 devlink documentation
Message-ID: <vwdbowwy3eivqwwypwo2klexhu47qpvb6nevjg3st7a43ucmxl@tllljudder3l>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
 <1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
 <20251127201645.3d7a10f6@kernel.org>
 <hidhx467pn6pcisuoxdw3pykyvnlq7rdicmjksbozw4dtqysti@yd5lin3qft4q>
 <20251128191924.7c54c926@kernel.org>
 <n6mey5dbfpw7ykp3wozgtxo5grvac642tskcn4mqknrurhpwy7@ugolzkzzujba>
 <20251201134954.6b8a8d48@kernel.org>
 <2lnqrb3fu7dukdkgfculj53q2vwb36nrz5copjfg3khlqnbmix@jbfmhnks7svq>
 <20251202101444.7f6d14a8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202101444.7f6d14a8@kernel.org>

Tue, Dec 02, 2025 at 07:14:44PM +0100, kuba@kernel.org wrote:
>On Tue, 2 Dec 2025 08:43:49 +0100 Jiri Pirko wrote:
>> Mon, Dec 01, 2025 at 10:49:54PM +0100, kuba@kernel.org wrote:
>> >On Mon, 1 Dec 2025 11:50:08 +0100 Jiri Pirko wrote:  
>> >> Correct. IFAIK there is one PF devlink instance per NUMA node.  
>> >
>> >You say "correct" and then disagree with what I'm saying. I said
>> >ports because a port is a devlink object. Not a devlink instance.  
>> 
>> Okay, you mean devlink_port. You would like to see NUMA node leg as
>> devlink_port? Having troubles to undestand exactly what you mean, lot of
>> guessing on my side. Probably I'm slow, sorry.
>> 
>> But there is a PCI device per NUMA node leg. Not sure how to model it.
>> Devink instances have 1:1 relationship with bus devices.
>> 
>> Care to draw a picture perhaps?
>> 
>> >> The shared instance on top would make sense to me. That was one of
>> >> motivations to introduce it. Then this shared instance would hold
>> >> netdev, vf representors etc.  
>> >
>> >I don't understand what the shared instance is representing and how
>> >user is expect to find their way thru the maze of devlink instanced,
>> >for real bus, aux bus, and now shared instanced.  
>> 
>> Well, I tried to desrtibe it in the documentation path, Not sure what is
>> not clear :/
>> 
>> Nested devlinks expose the connections between devlink instances.
>
>To be clear -- I understand how you're laying things out. My point is
>not about that. My question is how can user make intuitive sense of this
>mess of random object floating around. Every SW engineering problem can
>be solved by another layer of abstraction, that's not the challenge. 
>The challenge is to design those layers so that they make intuitive
>sense (to people who don't spend their life programming against mlx FW
>interfaces).

Well, this really has no relation to mlx FW interfaces. It is a generic
issue of having multiple PFs backed by 1 physical device sharing
resources. How to make things more intuitive, I don't know :/ Any
suggestion?

