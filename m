Return-Path: <linux-rdma+bounces-2732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98538D649A
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 16:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB71E1C22E40
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869F33EA86;
	Fri, 31 May 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6f3KftU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6417758;
	Fri, 31 May 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166128; cv=none; b=Jnh/pnEFyjmlzSJq9a2wvlVyCahe29l78PTt/ArSSpKqXPCJjeD2WJwDLZgqrN0YZNHBH8+mUmeTIQGpkkE3Et4QUqey9Yn+yNNEY9cPfhsoggWRqyeP1JNSz14fjRd4eXcOh5Tc8wRFOxEtHJyW2O45grVHNYozNXbGmrvBqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166128; c=relaxed/simple;
	bh=ef/DJjtPmTqPj1loDMbxCMS7osswe0vD0N//nDnbMYg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=o4qlS7PojvYTHitilYSrm0EYMzNfDtjV3dEWkexVumsKIycisXLyRXEvj5ILJPlA6mCYJbgzlJg0KP/Pw/4yZMEW9wpMguZriXW61bSvHYmgJlgzus8trxPT0PSGj4OKuJUbCgCWq04mn8EDdjdkTi7cVZTr4u4O8G540KBcCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6f3KftU; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e96f298fbdso22217501fa.1;
        Fri, 31 May 2024 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717166125; x=1717770925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n05EtFe3sdj15ew6SLWTU1Vrct7rRtquCuzOf+gCyVM=;
        b=j6f3KftUlY79ijIB3P66WdOjvJ2QzIN6sxIP28zJ1BA2rA6fbSNgjhmBAWsQp8qt+K
         CfTJSC7jktr5m0xjqWSO7fwXedWnUGF6yScbnHRDnNocmwq5Be2tU9ukBd4hzVUS9fYM
         tqaIbeZIM70luHQwqAOg36nteokihe6PQzmcexN8PUjM5pMWSZPPszDSHUJSihNIgaq4
         O9b8ASeZhtFHsBNfifgm9lftqMjYOGOvNq7bcE3PBKORh5Qt0aWFwLPekC7SdlL0VU7t
         Tlw08W0vKW00oeL4oQgIMafv6P+95Ayd4P/bGJ41IdC9tVakzp/Zh52pyc1vO2ZOBzQu
         C4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717166125; x=1717770925;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n05EtFe3sdj15ew6SLWTU1Vrct7rRtquCuzOf+gCyVM=;
        b=CGr6CwJ4+ZVv4GCk1iGWmY3b5yTUexWAdnnIZinlDTyARAZzgLnu0S5uhh5g6kNHrH
         5FTYbZ2wi7LGUsAbe6/J1P5nIjnuZw0k0zdXJpwl9l+VOL9Fbm6h2rtA3jQ51IuuVfNz
         wV0tCJ2Rya7Ci04HTG6HuRnsBYuRFHFqVDQSv0fvM+Sh/v8kHpoC0W2DneyI9b5YhJjR
         7KQ3eb+AZuflr6vt5CR5jfAbKXKtG/NYbhznfuZSggKqB/dhOE6pCztgKwUtpW12RzUR
         FiCteFxljCLwwyOYXgb12Vj7ZOD4WMaU7uKyWgnPQvFwPWLZtkgVyW+dhH0nNIJucfz8
         eNbg==
X-Forwarded-Encrypted: i=1; AJvYcCW9458J2T7b7/loiGib9KJ22kgKHDCC6AMKZBYBsYMvzWgixAuzLnj/DB77pmXnibVHq2y0Y8Ox2FKbQhyYg9vdsJWkfhhh6aIGhQxmnuJdqZdNbWAjiDHkTzQxFD/KTM3Ls35EhM1/VBV/YsGboIXcjFRnSLs9Wh20OndKtI9DYo0o1Q==
X-Gm-Message-State: AOJu0YxybgFVyiS3whflyAo4fvs3fWqY2BHJghc9vs8Uhz31Dryo650G
	z2dcQ7Y+tCgrIaUsZEuuDOGMUp5M4O38w2I9j/EA+xfDv/jzkbYA
X-Google-Smtp-Source: AGHT+IGVcCUHaZnpv1MwLaF6IIx1BsHReM37tDQicYsLW0v+utsuiS5MmlTY3NO6OJjjjtHmAt8QVg==
X-Received: by 2002:a05:651c:1402:b0:2ea:7def:46d0 with SMTP id 38308e7fff4ca-2ea950c896emr12043811fa.9.1717166124628;
        Fri, 31 May 2024 07:35:24 -0700 (PDT)
Received: from [10.16.155.254] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04da603sm1988134f8f.57.2024.05.31.07.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:35:24 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev>
Date: Fri, 31 May 2024 16:35:23 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.10-rc1 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
Content-Language: en-US
In-Reply-To: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.05.24 03:54, Shinichiro Kawasaki wrote:
> Hi all,
> 
> (I added linux-rdma list to the To list since blktests nvme and srp groups
>   depend on rdma drivers.)
> 
> I ran the latest blktests (git hash: 698f1a024cb4) with the v6.10-rc1 kernel,
> and observed a couple of failures as listed below.
> 
> There are two notable differences from the result with kernel v6.9-rc1 [1].
> The first one is srp/002,011 hangs with the rdma rxe driver, which was discussed

IIRC, the problem with srp/002, 011 also occurs with siw driver, do you 
make tests with siw driver to verify whether the problem with srp/002, 
011 is also fixed or not?

Thanks,
Zhu Yanjun

> at LSF 2024. I no longer observe these hangs with v6.10-rc1 kernel. Great :) I
> found Bob Pearson made a number of improvements in the driver. I guess these
> changes avoided the hangs. Thank you very much!
> 
> The other difference is nbd/002 failure. CKI project still reports it for
> v6.10-rc1 kernel [2]. Recently Josef provided blktests side fix [3] (Thanks!),
> and it has not yet applied to the CKI test run set up. The fix was made for
> nbd/001, but I expect that it will avoid the nbd/002 failure also.
> 
> [1] https://lore.kernel.org/linux-block/m6a437jvfwzq2jfytvvk62zpgu7e4bjvegr7x73pihhkp5me5c@sh6vs3s7w754/
> [2] https://datawarehouse.cki-project.org/kcidb/tests/12631448
> [3] https://lore.kernel.org/linux-block/9377610cbdc3568c172cd7c5d2e9d36da8dd2cf4.1716312272.git.josef@toxicpanda.com/
> 
> 
> List of failures
> ================
> #1: nvme/041 (fc transport)
> #2: nvme/050
> 
> Failure description
> ===================
> 
> #1: nvme/041 (fc transport)
> 
>     With the trtype=fc configuration, nvme/041 fails:
> 
>    nvme/041 (Create authenticated connections)                  [failed]
>        runtime  2.677s  ...  4.823s
>        --- tests/nvme/041.out      2023-11-29 12:57:17.206898664 +0900
>        +++ /home/shin/Blktests/blktests/results/nodev/nvme/041.out.bad     2024-03-19 14:50:56.399101323 +0900
>        @@ -2,5 +2,5 @@
>         Test unauthenticated connection (should fail)
>         disconnected 0 controller(s)
>         Test authenticated connection
>        -disconnected 1 controller(s)
>        +disconnected 0 controller(s)
>         Test complete
> 
>     nvme/044 had same failure symptom until the kernel v6.9. A solution was
>     suggested and discussed in Feb/2024 [4].
> 
>     [4] https://lore.kernel.org/linux-nvme/20240221132404.6311-1-dwagner@suse.de/
> 
> #2: nvme/050
> 
>     The test case fails occasionally with a QEMU NVME device. The failure cause
>     is the lockdep WARN among ctrl->namespaces_rwsem, dev->shutdown_lock and
>     workqueue work completion. After LSF 2024 discussion, Sagi and Keith worked
>     on the solution and Keith provided the fix [5]. Thank you!
> 
>     [5] https://lore.kernel.org/linux-nvme/20240524155345.243814-1-kbusch@meta.com/


