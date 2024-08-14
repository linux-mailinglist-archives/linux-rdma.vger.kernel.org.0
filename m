Return-Path: <linux-rdma+bounces-4367-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0CE951DE7
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5B5B253AA
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D1B1B374D;
	Wed, 14 Aug 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEvyZV95"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E94D14373B;
	Wed, 14 Aug 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646741; cv=none; b=GYMCAJTwZfVF3y03xOrq6G4617sIEn1tt4j2cTKJ8cLOiqmhZSsdbdr94sLeInCmrx6e0TOhqbujGwgX9lPDSNR3XTW0mU3Bub296+EC7hyJEyGbi4udZfiWwp64e5k9K2KD6bmuTKnYHiuCyUxRcOKHCO6CIaXFaoCu7ZTHZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646741; c=relaxed/simple;
	bh=sIDrVyW5p+dieFxCp1p1Wd8qmZCDRZYV7VnUzL1BCfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6zJqWbX37emsnRPDZK4S9FZHyhg+Hp4f7WL4WCcL5WWhSPMUqx556hmtkYq4eddmD55FhROcwCtWOlY9OHWNojXau4S+oURXVc7HWLOavZ902Bmq2KJBxU0pVFLeW+6xfv9+MF2XemEV5uWruI27Zt5qdD8KEgxNcjEzdETulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEvyZV95; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso5063242b3a.2;
        Wed, 14 Aug 2024 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723646739; x=1724251539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=em773V98Z8qtfRMHU9D+Z+DGVZZPQSH+f1TO/5ttRR4=;
        b=XEvyZV95KKgzsMVCJwLAg9ZUqWLaCU1ajhqLubqPiLNET/MoXxicEADP4KfsYB7KbH
         QumNceENGJfwj+Jhj1w7bhKvHtJm1zEjWoipPNKl7MlGBdi/8xMhx3Mg9Oo3KQMBiBXI
         XlwAi/WCFVmcXbbxNGffZWuEKOWKHCIT/ZfXyxNKIx5fymX8prXPljXKWUXPO5ZigKo5
         BKJi4+fgDxYUiAw1MPurvjhl0SshmuBih4HXuSn3sSHrQb04x3mnUr6c0NDzIQ/yS2Kd
         G7mrV6OIFUhMXqKBEUK86pAHtdAJoarnWgBc+JS8dYMeQYT9fyELQU0P142oMgVCJZ4E
         oYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723646740; x=1724251540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em773V98Z8qtfRMHU9D+Z+DGVZZPQSH+f1TO/5ttRR4=;
        b=qgzWwAtTsTQLT1Yo3sa3MBLI5yovPfbl20Rk6Ha7H8TMXBWcvHzxO02e4wUuz/zvh5
         aaiKxCQEiVTkS/bmDsMXm9YKHhyqoKmtkt5CXLBqfxwNgl3ZRDbmksl62/2RJywRybxY
         4qln46c8c9dAEHX8rHAKe5kgQpgZQ6XoOqCuWmb5Npnqac0VOL1h/EDrx3JMdFRQVHz0
         2DTz+IDr4t4fqHhXLno/vThTTs+Ky9p6Y4iup9nZLdtUOiPtY1dAxG5qN5x4HPKh/Lqh
         fp4jxxO2AFeHI3Bsshkcd8u42674XXvsP5z8nvUDd4Y8XA1huLEWQRqQbaLecU5v+q7z
         B3aA==
X-Forwarded-Encrypted: i=1; AJvYcCXi2PkkvS3vOSxRYB5GOxV+24BtUohJ0P5XVgyXQTTboU9J3JOSPatTQf8mzb7kbMO6NQ4PYtgJak7EWjTZ7UMX859yKJ0XeHdGfMV5GR7cXu//mb7Sb3PG5gZ1TmkDhfd3MBsxwf839hMcec/qa79ZGILhONynCScop+s7QUkm6g==
X-Gm-Message-State: AOJu0YyYPU0Hf49wPzRCn91wKMJWJW9BFH4Bvw6/J/3udE1Zi3shB04+
	5EDrdc+KubElrwrxBC0CGpgglA7xe7CGGKGUYkOI0FnxIdDmRC7g
X-Google-Smtp-Source: AGHT+IFwjfanFhv+rPDQ+tu6xGaY+40z4gDjwdcW7JLaZYtDy5L/jAJeExKiqdNOFqRNtt99YRKX0w==
X-Received: by 2002:a05:6a00:1404:b0:706:65f6:3ab9 with SMTP id d2e1a72fcca58-712673ab9acmr3218112b3a.20.1723646739422;
        Wed, 14 Aug 2024 07:45:39 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a728d9sm2869868a12.88.2024.08.14.07.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:45:39 -0700 (PDT)
Date: Wed, 14 Aug 2024 07:45:36 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Erwan Velu <erwanaliasr1@gmail.com>, Erwan Velu <e.velu@criteo.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Yury Norov <ynorov@nvidia.com>, Rahul Anand <raanand@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Use cpumask_local_spread() instead of custom
 code
Message-ID: <ZrzDAlMiEK4fnLmn@yury-ThinkPad>
References: <20240812082244.22810-1-e.velu@criteo.com>
 <3dcbfb0d-6e54-4450-a266-bf4701e77e08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dcbfb0d-6e54-4450-a266-bf4701e77e08@gmail.com>

On Wed, Aug 14, 2024 at 10:48:40AM +0300, Tariq Toukan wrote:
> 
> 
> On 12/08/2024 11:22, Erwan Velu wrote:
> > Commit 2acda57736de ("net/mlx5e: Improve remote NUMA preferences used for the IRQ affinity hints")
> > removed the usage of cpumask_local_spread().
> > 
> > The issue explained in this commit was fixed by
> > commit 406d394abfcd ("cpumask: improve on cpumask_local_spread() locality").
> > 
> > Since this commit, mlx5_cpumask_default_spread() is having the same
> > behavior as cpumask_local_spread().
> > 
> 
> Adding Yuri.
> 
> One patch led to the other, finally they were all submitted within the same
> patchset.
> 
> cpumask_local_spread() indeed improved, and AFAIU is functionally equivalent
> to existing logic.
> According to [1] the current code is faster.
> However, this alone is not a relevant enough argument, as we're talking
> about slowpath here.
> 
> Yuri, is that accurate? Is this the only difference?
> 
> If so, I am fine with this change, preferring simplicity.
> 
> [1] https://elixir.bootlin.com/linux/v6.11-rc3/source/lib/cpumask.c#L122

If you end up calling mlx5_cpumask_default_spread() for each CPU, it
would be O(N^2). If you call cpumask_local_spread() for each CPU, your
complexity would be O(N*logN), because under the hood it uses binary
search.

The comment you've mentioned says that you can traverse your CPUs in
O(N) if you can manage to put all the logic inside the
for_each_numa_hop_mask() iterator. It doesn't seem to be your case.

I agree with you. mlx5_cpumask_default_spread() should be switched to
using library code.

Acked-by: Yury Norov <yury.norov@gmail.com>

You may be interested in siblings-aware CPU distribution I've made
for mana ethernet driver in 91bfe210e196. This is also an example
where using for_each_numa_hop_mask() over simple cpumask_local_spread()
is justified.

Thanks,
Yury

