Return-Path: <linux-rdma+bounces-14844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA6FC96B89
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Dec 2025 11:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E49594E123A
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9673043DB;
	Mon,  1 Dec 2025 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="x0H5Sflv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECD3043C7
	for <linux-rdma@vger.kernel.org>; Mon,  1 Dec 2025 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586215; cv=none; b=U0UNnuQAFvdIg6UwRrWWbpaJ9AJGA7mPkVJTE2XkDStEIu1ZTKaNqdpt5LMmzUlYsH6gP4y6nIKWqGCi5xTBkfkfW2neBPfYxo5ZdQ55LOR/aOgVI3wU6REEEJ4XrVF/Z/MuUzl7dKtbUw90UWWvp2EDOhZLU/a2DLO8jzILe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586215; c=relaxed/simple;
	bh=Vl5Pt6fbbWhiVMNLXXFQfg4zF9/xEjpl7rTTd1qmuhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6O6/PVYRprQj96/Jadp0V/WKRXyHIVRxrQl7ntPQMUeltUPNjQZN7s6zN/i6HgVwUou6REK45yhYjQPRrSjIE6bA4ws31/GPSb0VhCFICbVLyE5ZIrYMuF2TUCfpZcFrB+5Ss5LhhsiWggEcZC35+CGS2j9FmkZFtDAr7SH4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=x0H5Sflv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42e2e6aa22fso558557f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 01 Dec 2025 02:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1764586212; x=1765191012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vsBhiX0PVPZ+1c2Xkz/7qg2YuqZk4pwJLdnYaEMKyy4=;
        b=x0H5SflvsYhHeVejbOzjFjA6IxemuZ+5XE0kEgoxSRNMgoLmme6pS0YKTpXhsCKumV
         SWWrYbtAZqZQwqCkDtK3HePLav9G9ld614dc+jmCpOWPfv51eTLRgKlutWSVmSJqkzdx
         VVTG5IGZAQ+cxj2sR0af8arQOyytwYBKAO8hZ/RFIh3v8+Kp0i/udQXKCB3yhfnkkUMf
         RirGGb5O0S95DPE569OB4HsFg7WRlxbBd8buPYcGNdaYwAipotN7MDWRF+gHm8Z/4gaL
         UkiyVG46MY+yzzJxHOYZjInitRclZ3H6J0j6C8eLIFScQhn5cNsfD3oHGQgoZZioC+gW
         rUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764586212; x=1765191012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsBhiX0PVPZ+1c2Xkz/7qg2YuqZk4pwJLdnYaEMKyy4=;
        b=d+AeCgYEEZVasDPyf3wltwG81KiW2Jho5obhGzjq3ToG7lkajgfRxaJJ1+1LUKEA63
         SDibG63WM1+WAHrGSc3PkrqVoIN3XKjdH/XRbIl+ujn83T4o4g7as4xDtbQc5GN/nX5b
         r73PhKdpZrxj74ht3o+Ekjm7ZR5vmUQe1Z1X6G+0ZNkxDh1cLyW7aZg6GWJM4mbwZClh
         xz+iBHKRDfv+3YJKjVqYM6pWU7ggUAK9PDcclEHC3HtbCwqulap5173D/+y2I71EmkwF
         p6IBxNjnPKVscDXnsrGZ1oIVzUz4V2q87ryn52ZUXWOaOVshhnbik+Nly60nCdz+ddCp
         Zjgw==
X-Forwarded-Encrypted: i=1; AJvYcCVYCjwa8vtpv5PyQLFA80x4aOrjDe622+t/TvVY69oxDvqkG2Z1fbPVR3Gm3HN9E7NOCSPIKaGmDMoc@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGDMSLsohz4X0PNSAiBJCavJrH9RrWRglpSrRKanRALTV8DFJ
	CAGwskepiU5aAUiy2RA57W1nTmKjzgfhNx4816YNVwm5vfF2wt7yD+S+TrKit4kCD5k=
X-Gm-Gg: ASbGnctjRsVnm8Ra7vYALTp4s9Nt/W+Mu3zXhCSINQHmem34ccsWzY/o66hKsUEHab6
	VG/FgLfut0QOulsHGYHZUKZnxbMzkk+YeV+vpOnzSvl/aRaSKtv8F0Hki0fqTSO50ulpiz2HWB6
	IujVEuHkf9Brxabh7M/dcmS+1r6mhfM5RFhIe+hs/ayjp9Bq8xVNFnaLdKhAeeP04N9dGK8660m
	eF07+OOlJnN8w/r6jTh5OdSdS/Oq8BawsgcKpvyNHgnSk2vxWFze3NyJDeCjF2LvUfOz0D14ZNj
	e/CvmaJIIgudKY8LsvaNWxLMZGWurAbiMB+QKdX/D1eNkRNmlO66Xm0b74rLWt9yoxqhuYGcH8/
	MThfxKyzEI/0WY50C4JdTWx7LQKHnrgPigIToo7Ztr2jnF9Bl9jSD4N7FToH+yYj9j5Ic67qDyp
	6hqM9h97rMYrcYhj5fsGP4Vg==
X-Google-Smtp-Source: AGHT+IF8Tu4veq+TqWb6qimoMPLbdTzxlzvlIjg1tAKG25deNHRi+KLPl07N+U3YsCQceTPRWYr3CA==
X-Received: by 2002:a05:6000:2288:b0:429:c4bb:fbbb with SMTP id ffacd0b85a97d-42e0f2129cemr26950630f8f.13.1764586211765;
        Mon, 01 Dec 2025 02:50:11 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caa5d02sm25827129f8f.36.2025.12.01.02.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:50:11 -0800 (PST)
Date: Mon, 1 Dec 2025 11:50:08 +0100
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
Message-ID: <n6mey5dbfpw7ykp3wozgtxo5grvac642tskcn4mqknrurhpwy7@ugolzkzzujba>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
 <1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
 <20251127201645.3d7a10f6@kernel.org>
 <hidhx467pn6pcisuoxdw3pykyvnlq7rdicmjksbozw4dtqysti@yd5lin3qft4q>
 <20251128191924.7c54c926@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128191924.7c54c926@kernel.org>

Sat, Nov 29, 2025 at 04:19:24AM +0100, kuba@kernel.org wrote:
>On Fri, 28 Nov 2025 12:00:13 +0100 Jiri Pirko wrote:
>> >> +Shared devlink instances allow multiple physical functions (PFs) on the same
>> >> +chip to share an additional devlink instance for chip-wide operations. This
>> >> +should be implemented within individual drivers alongside the individual PF
>> >> +devlink instances, not replacing them.
>> >> +
>> >> +The shared devlink instance should be backed by a faux device and should
>> >> +provide a common interface for operations that affect the entire chip
>> >> +rather than individual PFs.  
>> >
>> >If we go with this we must state very clearly that this is a crutch and
>> >_not_ the recommended configuration...  
>> 
>> Why "not recommented". If there is a usecase for this in a dirrerent
>> driver, it is probably good to utilize the shared instance, isn't it?
>> Perhaps I'm missing something.
>
>Having a single instance seems preferable from user's point of view.

Sure, if there is no need for sharing, correct.


>
>> >... because presumably we could use this infra to manage a single
>> >devlink instance? Which is what I asked for initially.  
>> 
>> I'm not sure I follow. If there is only one PF bound, there is 1:1
>> relationship. Depends on how many PFs of the same ASIC you have.
>
>I'm talking about multi-PF devices. mlx5 supports multi-PF setup for
>NUMA locality IIUC. In such configurations per-PF parameters can be
>configured on PCI PF ports.

Correct. IFAIK there is one PF devlink instance per NUMA node. The
shared instance on top would make sense to me. That was one of
motivations to introduce it. Then this shared instance would hold
netdev, vf representors etc.


>
>> >Why can't this mutex live in the core?  
>> 
>> Well, the mutex protect the list of instances which are managed in the
>> driver. If you want to move the mutex, I don't see how to do it without
>> moving all the code related to shared devlink instances, including faux
>> probe etc. Is that what you suggest?
>
>Multiple ways you can solve it, but drivers should have to duplicate
>all the instance management and locking. BTW please don't use guard().

I'm having troubles to undestand what you say, sorry :/ Do you prefer to
move the code from driver to devlink core or not?
Regarding guard(), sure. I wonder how much more time it's gonna take
since this resistentance fades out :)

