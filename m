Return-Path: <linux-rdma+bounces-11513-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3376CAE29B4
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 17:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C034116CC52
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FD11586C8;
	Sat, 21 Jun 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChvvTk+E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497D7262D;
	Sat, 21 Jun 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750518187; cv=none; b=FEXA9Cn6ynpkx4mMEcHpVDMzyP79WKj6jL97pAIbz1eYjaDf6Q7AzrfCWoufj3KAfxIP3+4KftjU8/yZX+CslrSAlIyOG/lPOtr+uEE9DihmXeSQr/H34txUhw8/v8ZzaD8pnPl2fYwfpYIfk5/Uj5pg66ww4YOlgnYkzpgOcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750518187; c=relaxed/simple;
	bh=g66sLXmUcEXF/ehSdvRAG1Aw/xp6rPKby5bIA+HLI28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsYMY06lci0TAgJu4RGxRfpigjoQc/b2yRO8QuqG5SkZjjUcKNI7aq8oO/9Ladmfe3FrQ1LNC3zRtMG0C+unKRRudibG/nBP546CuKoU+ulKyJ2U3rLFsnfSGe+cmfJzVjnk/hZNzCLim0+68YJi2YUIsRf+cGc6hpgo4fc9q9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChvvTk+E; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234b440afa7so29483755ad.0;
        Sat, 21 Jun 2025 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750518185; x=1751122985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ2meP6AQOt18RTp1pYruaymRIfMLYo2hgcL5xk8YIk=;
        b=ChvvTk+ExhntdAFQNPmxjCBrKzx8nfk7UOpy1cRa6HdiPjBhL29bxLNOG41IKjfl28
         deXvrgCviXYhdmzH8QRhaPSpQaC3+vj2UcHmuOAa6PFNmNruqOeFAo0UXYiiSTUezSay
         vRvsa9T6obMSmqiP32h2sSDVoYNuGM9kI2jYlNTIKk6rnmDWc5TyDRrSJbNxi9U6/xYC
         t/cxfuWL4wdEVQd2y7mjdgGIkgC5wz3hJq3mWbWzmrorZE2zEqOH5s+6KuMeBwSA4Y59
         ZEKmxwuOM7L/zbQQRcMlqXTKVOL4xE1MhuLavnGQcYs7d6UiWbk3ppqTZ+XCnSTsG5f0
         SOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750518185; x=1751122985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ2meP6AQOt18RTp1pYruaymRIfMLYo2hgcL5xk8YIk=;
        b=oD3/F+nVFkxgMh+M1AXJU8pu9biuzaFFRHk9SDel9FQ1asIPJg9XEuxVKdLr16/v4f
         uAKXd32KguDN26OUYPd2cs4riGNaKrf5+xs1eyC/yRM4uXFJWmd4cgpbtRppax9NRqvr
         ilmBC/4mYQrATT0uqpBknOCzEf1Kl4XhN997YdNgoGIJwUteiixWu6JbFiiVGx4Rbr6j
         Dt4VKBfNalUtFB1cedMpLSEYUUF9qBIz6Nhk35zZboOE+cCynDqzQg2hU4TrEiOO3ei1
         luKvWiwVaK5kFsrve7RAoP49x/heU7BFbgRfudnZpUWldi2LH1ZsLfrM52VllvpRZnR0
         NQIg==
X-Forwarded-Encrypted: i=1; AJvYcCW6h5L7OfY6BSEDHH7dnoX243nHu/MFpDOWk18ad15+Mw0vZZFM9O6iT3vE8Fz3sZEbLjd246r/35pnQw==@vger.kernel.org, AJvYcCWuUXVCv1DPl6YfgxUY4YQFfeM4Mz0yLugnv261bL+eNHQ1BYsjfktSjhFV84lwxrrikd7g7VIKIrodqxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJkeiukOD58KVy75bedSgFtJcn7MavL8MN1e9b/RC669Ed633E
	D6oEeoOpWkojTF7Xpxs9iB6iQtc1zXrvQqzmY0anzYMXlNVPMYtYZ4CuMgx86A==
X-Gm-Gg: ASbGnctu2ZTLupXGUJZDvHG25i5PXhE3/IVKhScObQ2URxx5t2qQvehZSdUxj8VKnzC
	nwfgZ9S3WUPUQCt/gNFs6QISJzPGIvwKAz86bjTu9R8POvvDCsgG5QAr8LY2XxMWLOrzOtwTNBU
	dpMwr0A0wHhKXqRq/F1csik51ogu7H38M9bKTCirjiDIX8+yJvIulnbXLiefwmpUa5u184OarmC
	m1TrN63MBggrrEJcBPH9xG7gbgVXc+2xvMPtrH63v/2pgmNSYTsskdnJA8vTY8r0GLvVK3TTd/U
	m5bwQmwTIgB7KeqtmJvzxzZA6cOIEJHtJQf7Q/zLvNWCiG1heDrdA7KO67aRFQ==
X-Google-Smtp-Source: AGHT+IEA6XqOqvZVfygiiLvTsTGD9tG4qpIqBoGaxNVST5TuhNXyOINNzuNNRpL9nPwbc/NOtrHvjA==
X-Received: by 2002:a17:903:32cc:b0:234:8f5d:e3b6 with SMTP id d9443c01a7336-237d96b63b2mr91537635ad.3.1750518185333;
        Sat, 21 Jun 2025 08:03:05 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83f14a2sm42814815ad.80.2025.06.21.08.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 08:03:04 -0700 (PDT)
Date: Sat, 21 Jun 2025 11:03:02 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] RDMA: hfi1: cpumasks usage fixes
Message-ID: <aFbJpqbP-tU4q84P@yury>
References: <20250604193947.11834-1-yury.norov@gmail.com>
 <20250612081229.GQ10669@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612081229.GQ10669@unreal>

On Thu, Jun 12, 2025 at 11:12:29AM +0300, Leon Romanovsky wrote:
> On Wed, Jun 04, 2025 at 03:39:36PM -0400, Yury Norov wrote:
> > The driver uses cpumasks API in a non-optimal way; partially because of
> > absence of proper functions. Fix this and nearby logic.
> > 
> > Yury Norov [NVIDIA] (7):
> >   cpumask: add cpumask_clear_cpus()
> >   RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()
> >   RDMA: hfi1: simplify find_hw_thread_mask()
> >   RDMA: hfi1: simplify init_real_cpu_mask()
> >   RDMA: hfi1: use rounddown in find_hw_thread_mask()
> >   RDMA: hfi1: simplify hfi1_get_proc_affinity()
> >   RDMI: hfi1: drop cpumask_empty() call in hfi1/affinity.c
> > 
> >  drivers/infiniband/hw/hfi1/affinity.c | 96 +++++++++++----------------
> >  include/linux/cpumask.h               | 12 ++++
> >  2 files changed, 49 insertions(+), 59 deletions(-)
> 
> Dennis?

So?.. Any feedback?

