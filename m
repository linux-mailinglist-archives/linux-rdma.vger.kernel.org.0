Return-Path: <linux-rdma+bounces-14656-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7DCC74B8D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 16:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5B743598D2
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7134104A;
	Thu, 20 Nov 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fqj9j1Pn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B133A027
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650553; cv=none; b=ssfyqk7Gb+p+bCYlK9iOsAL0stfjlQ7QQnZb02YiVpyHOuqdKAVH18dyUUQY8nsKzvd+HXN1pwjysvNGqPuU8LkyzgGduUgJkWuFTvMOC2nbZn694VG6LR80mSgIE8xCv/y+kgde+VAR9FseuAyd6bzAjHi7hk0GdWvjuiOMF2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650553; c=relaxed/simple;
	bh=/vmdzwx7YN43hL9gWUoErNciVUby5yb1OVF6bW03qbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5i/PcitQSkExdlPgtRqSN13PlnBlV8GE/qL1mGZY7LxVkanNejnbw6E5FTPVr4ROyAD8lvBiQ2ZKblA/7GNYnFyf7Bj0qICcdMCJ0RYp+78/fLDjpZVY5dztkPB8js1vH3mVj1v6hp08RSEStwgJXxQX4vTyA8CJl24h1S7450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fqj9j1Pn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735e278fa1so200556566b.0
        for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 06:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763650549; x=1764255349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tB3yAJnsR+u7PKfvNjCtD0cHNrMrenN9Rj7f1nqALY4=;
        b=fqj9j1PnjwlnVl8sVigH81WqTfw5pwX+zCldx/6jekvsGCpJihckhoDrJTZBJ7gZor
         sZtVtmdEKLlyXl8dBNZ5LAZXmjq6KQAHJQBZjWrMsfxNqFehbbnxmOmzU7mV9zNFyIBy
         VbPQYw+AmeKJGCanD7qlrWQuUKht7PuzFNfy9s/vEbPP6oMw4hisOHczkDO9yNiNQgRK
         bLNorx0c3qFFGqDmkJY0MxAXvIboSPGhWFsGL6XFee2fh5dgqmbkYDdSQYmA+a/0zUF5
         He6IpAbAcNWsRsX697nIxgvE8UkEwTW+58DeZ00zvlKPdsfBsXGE+DRhKIW3Fz5xc90y
         Y6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650549; x=1764255349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tB3yAJnsR+u7PKfvNjCtD0cHNrMrenN9Rj7f1nqALY4=;
        b=XD1+kAARaGr61aJ5bzFxaN2mSu4Uyxez9j3jr+g/nUqgf+0wipjiWlS5VvlllWeU5/
         kqo7aHwGUiQvmUGWBIEbnECWH8JFAG9O0HoTkPH1tbALXrOJ2WsmoNEXJc7cJt0v5jG2
         DKve04D5woB/V2b+trJs/OAJ+iSqmOBvVy0clpaSb0X2164YER9wf7jY/wPyVObwNrES
         u51lizH/GTLCvpn82K49NBDJ2cV3laoi6ojgOYU/u2H8wpbf6dRVAAO1QHocOiMVcnm2
         4istYICZCIe2t4sI5MMox1Tm10e86WQf9kuXe7AHgdxc6RZ3Oak092bEpdRU5ERhDfzq
         NFkg==
X-Forwarded-Encrypted: i=1; AJvYcCUhQZyVblJdYDz6ItZy+gnkZFOfiLXbS4qTrKiQxWJkB7KBf4GEo/aMFlcw819aQrDsph/5jjQeWuB+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyveby9inCVX5+TmyRRa4o1jc01X0g93R/9qf2ILvEvLYi+tF3A
	+4mznvLfdWqlZbJn78fEDWOoY8ITg8edfTvuyUEbXnqizNIcPraYiRfMptAifAcqyZ0O24KzCb0
	I7O5B
X-Gm-Gg: ASbGncuD9hlQsagUpRRMr5n3EiIk60Ot8BSnO//5C2tC9IgtOZYZP42RrPOHROtRLpj
	7Oid2+4fwRucffU3PAHYEOLwMtgN/Gxsb2mpsOmrGIyeCs0xutt7x/fa024wYD7H6BwPpwEDAaE
	OD2TLcSlScCehQYAX3NNjjiCtIYye///DByv9W2VLtKEb+vZi4oLoabONUtfaHM9dYXyizhVAAf
	ffssJDF8QjY5fyVjZg1DpvglobVzZnCuDjW+eEm7wbXyT0iKUnijgCYAIfJlpFdKjawfg+AJvGN
	mhohCW1s5RSQj625q0BoNegzvJE2Y6P2J2DWFNiD0AJdw0RWnyOR5MQNZKYvMQZE4rykfwKP8pf
	FfGsWlooPat1hsf/boxj1j5ArfsC1Yxo3JWkUT+flRQSagiFj5X88bg9GDZT6YG5Tiww3OeUZYI
	spT0uotiu11TJiRAKFPqY=
X-Google-Smtp-Source: AGHT+IEkw3ELDAFGw5UHVPLRHfnwkakgGWj/7LG9KJyXkQ6oXNY/brkJ9zjTpg5jWHAWPcFd74rMYA==
X-Received: by 2002:a17:907:3f0f:b0:b3f:cc6d:e0a8 with SMTP id a640c23a62f3a-b7654de0690mr359237366b.17.1763650549210;
        Thu, 20 Nov 2025 06:55:49 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4e6bsm221729466b.34.2025.11.20.06.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:55:48 -0800 (PST)
Date: Thu, 20 Nov 2025 15:55:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 08/14] devlink: Allow rate node parents from
 other devlinks
Message-ID: <cg4wyb7lvawxouogcnk3dgoeielcfpsbqycadp5ohaaifgjbtn@fyvhyk2zj32e>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
 <1763644166-1250608-9-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763644166-1250608-9-git-send-email-tariqt@nvidia.com>

Thu, Nov 20, 2025 at 02:09:20PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>This commit makes use of the building blocks previously added to
>implement cross-device rate nodes.
>
>A new 'supported_cross_device_rate_nodes' bool is added to devlink_ops
>which lets drivers advertise support for cross-device rate objects.
>If enabled and if there is a common shared devlink instance, then:
>- all rate objects will be stored in the top-most common nested instance
>  and
>- rate objects can have parents from other devices sharing the same
>  common instance.
>
>The parent devlink from info->user_ptr[1] is not locked, so none of its
>mutable fields can be used. But parent setting only requires comparing
>devlink pointer comparisons. Additionally, since the shared devlink is
>locked, other rate operations cannot concurrently happen.
>
>The rate lock/unlock functions are now exported, so that drivers
>implementing this can protect against concurrent modifications on any
>shared device structures.
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

