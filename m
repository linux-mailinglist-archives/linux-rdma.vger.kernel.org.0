Return-Path: <linux-rdma+bounces-14901-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA4ECA6F57
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Dec 2025 10:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C047D31B0ECC
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Dec 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614B7330B1D;
	Fri,  5 Dec 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JQRyBaGT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520B3242DF
	for <linux-rdma@vger.kernel.org>; Fri,  5 Dec 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927561; cv=none; b=J8GD7/1olU1YTCunNkxuNaSEzXBZsCjKUXtZ5sF95uq3llY7V1ezwdSMbn+hN1BLfcdKLW9RbombgXtyTALNlY8U1+QpaJgIzKOdM3foH7HMAW9+lfbv0NWpC2bkepvlPukwhCYaH8Ogc45cOgJo8GLb4bbSzqDrbR55R4pzWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927561; c=relaxed/simple;
	bh=95ObkSeuIKSEm4S22DN1kvGLeGFx6W3fWOpM/yf2jHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NecrCFANLlYOijuJiUr8LQ/kfAtrrP7QAfsN4xd4+Xj2Lcc88I/ZvSepSQ4bw61tqjkNjqwoujN/FVion6TiiutKWAzQPYDiWIn8KH6bHyC/2xzQZaM20lFfuimBCh2QxdUhq+JlyeHIx9QkdG8Vz2AEd1nrnhP5hEy/3UCDNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JQRyBaGT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso15321885e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 05 Dec 2025 01:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1764927545; x=1765532345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaAGBjbPbYIBQtblcFbwD7Gc0J3AOtm/MkA1xHU4Vcw=;
        b=JQRyBaGTfZ5TRdyu3nYephxBQXadn9EGrQA5tj0P0TzMFH3ZOV166rnvN1w5tuV2rk
         EpRvigAE0oAOOGkKebc9upFa3GxnCixUwNLA1uIY+SxdVetiIkV7TyI56tGaeaw5e7KC
         o3mTPlq7JBClyB9d1Q4PGjgT00tXFU06t1ik3eHEr3i/cUqRndDpIL/U+t92mRssnWrR
         zH88h8BW0ok0LV9fJYzoKfFIIVxJPVeFkZ6g1gqRygF40A4ud4KcyL4VjNAQHrN2KSAW
         JZwkqWG9Dl115eEfiGgNkdHj7KbDBX8xegRH88CC56jQFJk2dvjNLlySZQbqFYIVRQ3E
         wzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764927545; x=1765532345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaAGBjbPbYIBQtblcFbwD7Gc0J3AOtm/MkA1xHU4Vcw=;
        b=pAAhN5u4gYElYnUrumMkpnmH0Q1T6C1HyArVkDlhnZd7o+3GtQjyS6ovuWFDcQVGPi
         urWiR5nv2EfIkKijla5MMwbmZYDro4oH+WLAsrOfqekcdyP3eCmOktOZF/WP8EzGDYJ8
         8Hv6MIRWd/8l04MOfwQYm4HlvQNJrchd/lWMskYm1SABsYMLID2fGWrODoqXcXlpopE4
         Dz15Tp509eNPi8WxHxs7eZSeMXrzeaOjrHS9pqM4YIOtbOy6DIdjthAOWoIaYTUHDWfJ
         etfGhwRsqeDC3Ba5Hs+MzgQ9dYNoUlzPqkwA5EQsxCpje+CywqLb8BPSA2iYlk5MJJW6
         EqLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnKKO2Q8VGHR5BcWOQ7iCr+bTqxgX2wSoDJq+RYtMoARLvxPkVXmYezCFcxpDv83i0b1KsfaldQFYk@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5UolV1QihZ6bZ0oxOgDXe1lixxUNbRmVC/gy1zu7tOtKNDqT
	shFsc4NPjBKj+8yrA2ZAvP0QXhnVsvx9fXemvAV/yAGxlCzbd6LzoyRVxrz8jfgzqwc=
X-Gm-Gg: ASbGnctm+66NrzbYPfzPaHyApxnCD++B2MIEqaxaQ+qnC+Tf+52Q3a8cAcVIz7n1fe4
	TlZ23/a5SIY5DfJIQzGRZX2dhT0OsXZZ95X/ch3a5VMhXsM4tAu21ozEU8A8O4dL7UBTEKL35mH
	mMSjD9UbfxnMN1m3mFmA0WZo6lz8qx4Ju3wini0/3Sp0jPwyPFnz/S8JEMRHQVxpCwfNsZrWoeK
	F4r9lLhcT4JvbBVJhCBtUYJFOJyT4GDgi056nCvzuTaLXSsDe4bnbTztdXqXcb4a/cYkiVGvfJL
	PNrqaK68f9IAfpiz/x/oVdU5Z1pcIkr9oTGQ3CbeMfXwdKtyYU2ZijupSmK31JkJfv/U9p4ULo9
	zgwt+HsUOLxg0mWDzu2QCRqMpKNH+ZXDygvHLEfHq7aKTExRjzNK0IT+zl3FhjdJcC6b6jw9rK0
	LiYtGFg5zma5Lig7KCOMsWS3TrG1zBq/e4HQ==
X-Google-Smtp-Source: AGHT+IGDQMvqBdqJEOzpp4D1Mp55Rha91vFFizQlMrUQ2ckvl6oDH6vQIiAKgZEXK5RQ7xwYag20mw==
X-Received: by 2002:a05:6000:40cf:b0:42b:4223:e63c with SMTP id ffacd0b85a97d-42f7319045emr8571810f8f.11.1764927545234;
        Fri, 05 Dec 2025 01:39:05 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222491sm8200896f8f.22.2025.12.05.01.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 01:39:04 -0800 (PST)
Date: Fri, 5 Dec 2025 10:39:02 +0100
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
Message-ID: <f4aq27k6ohsuiiqlsjhfjx4g7nexltot4tfd4m2kxdtzwciqpr@72u2malmrkif>
References: <1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
 <20251127201645.3d7a10f6@kernel.org>
 <hidhx467pn6pcisuoxdw3pykyvnlq7rdicmjksbozw4dtqysti@yd5lin3qft4q>
 <20251128191924.7c54c926@kernel.org>
 <n6mey5dbfpw7ykp3wozgtxo5grvac642tskcn4mqknrurhpwy7@ugolzkzzujba>
 <20251201134954.6b8a8d48@kernel.org>
 <2lnqrb3fu7dukdkgfculj53q2vwb36nrz5copjfg3khlqnbmix@jbfmhnks7svq>
 <20251202101444.7f6d14a8@kernel.org>
 <vwdbowwy3eivqwwypwo2klexhu47qpvb6nevjg3st7a43ucmxl@tllljudder3l>
 <20251204105737.551d1cc1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204105737.551d1cc1@kernel.org>

Thu, Dec 04, 2025 at 07:57:37PM +0100, kuba@kernel.org wrote:
>On Wed, 3 Dec 2025 11:36:13 +0100 Jiri Pirko wrote:
>> >To be clear -- I understand how you're laying things out. My point is
>> >not about that. My question is how can user make intuitive sense of this
>> >mess of random object floating around. Every SW engineering problem can
>> >be solved by another layer of abstraction, that's not the challenge. 
>> >The challenge is to design those layers so that they make intuitive
>> >sense (to people who don't spend their life programming against mlx FW
>> >interfaces).  
>> 
>> Well, this really has no relation to mlx FW interfaces. It is a generic
>> issue of having multiple PFs backed by 1 physical device sharing
>> resources. How to make things more intuitive, I don't know :/ Any
>> suggestion?
>
>We're talking in circles. Having a single devlink instance for the
>"1 physical device" is far more intuitive than stringing together
>ports from two devlink instances by using a third instance.

PF is sort of physical device, isn't it? The boundary is just too
fuzzy. In some things the PFs are separate, in other they share
resources.

I guess we don't live in ideal world? Per pf devlink instance
is what we currently have and removing that would be just too
distruptive. I don't know how to do this
differently other than adding shared instance for these N PFs.
Honestly I can't clearly tell what exactly you want :(

