Return-Path: <linux-rdma+bounces-4494-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA595BCE8
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 19:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51024B2DAB2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 17:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D991CE71D;
	Thu, 22 Aug 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QEgObGye"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633481CDFCE
	for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346496; cv=none; b=YxJddR8GZoZRUKPMrT4+AOq1a8s9OTAhX4adgDSdUOWaQEjT+XiA6KfcdbR0QoxhOuqAEPnTqNX6Znid9aC39hfssU14o1sfYnp+x6gew6+7E09h+QU2Tkca0vNCchkv9I79xTw/h54CTbzIVEyUcd72R1VcgBskwkxp0iq9ip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346496; c=relaxed/simple;
	bh=BMc+FJl8erOZwXJDoGjXhPQwr6aeokc1pIgEX4Vo6vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJyHEV8xeY+Asgw3Iroqag4ReacLWYeF1UlTiveuEQG/CuUYXU2t6tM7vdLLxVyU1PvDZh0JAD1n8rbNCsG1mXOetUAxv7CIffFIeaNs1R8YCr48rJIyw82F2FYuZDCOZIadSsNhJhW/kN7hlaVBSsirWhjtiXN+Qpx5lRBO/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QEgObGye; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2023dd9b86aso8786445ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2024 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1724346494; x=1724951294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vPskSxp3DwFGJ51OvKab2oMYd9Bt/ArGDf3ppqCaMdg=;
        b=QEgObGye/a1hz+W/5NuFpRUx+Nm6bBOYNmah2pi0eLSG0nGIMd9dwYPm4iLeZFqgzx
         6PE2DwpDVB6EgVxwCbH5aJ87IVUdTiJ5BtFg2un5B31mBCjz766SfQU9svXqEVTMJfXo
         DtrjJd98NL65JJvvgPM3+8DKCTSFFbaqN3CvkpBElpbddiSiDFCNgSG2OnmtiEj23Xja
         RlLMMdDtztGGVS9VMRTB4GTtb031AZCmImtrSUzaORTMdU0jQvYpBsPPz4SBEIUO3eEZ
         am09xG1eNd3ekZYhotrRfZ8jhaXuOmF9icfJ73dOjULwd+dukTke7CSi+bBYj01x3AXw
         EeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346494; x=1724951294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPskSxp3DwFGJ51OvKab2oMYd9Bt/ArGDf3ppqCaMdg=;
        b=djKraQOiDyhZ0c4MtACLMvX0P+MC9B150qioL5J5tKreUD6voZBhUZMon9VG01eFD8
         RRURr5NjB4TziWjsW6paSJzQyrOv2C3ok+RP4KAloLBxvYQqgusnN6QOPxF979msbFd8
         q5mZlw83oe4qavHHUOqkg4QBssLfM8F6EcHbrgS5cDQi2/CuY2lNS7Z69pEKUDQsXQU4
         Hnj93qkd/FOLGiQ5tLHIFmUwDKoGVIHSjB/seUbr4kMxT+Xr1hfGuth5LgouB8KxZ073
         bQwfHJVaO/SYFAWrP9FP6JkBRU8LdclwF9O0dExlYQ4rHI6QtjFck9oReLbPRpeSEeYC
         EMwg==
X-Forwarded-Encrypted: i=1; AJvYcCVjYuwwCRN6oBFGFcxckNYgUpM8IG04xzoKeI8RtbzHqds6WwGMFlUDdP+xvo/dEZT6QlvumbDoCDFh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78G6vtG6LE25/gpdaJHbONT3BK7ppFnH1qvymE1VwuVUIOkCg
	O80KsUgUCGfN0CyqrRdqc0r2F0w/0G4qZQO+V1KoxuZ0OrZOWThpaa4x8fEIkdM=
X-Google-Smtp-Source: AGHT+IFZeMlN3uhYsXoA4fG5+9UylUMv56IDXgYgY+U3CGQbvR4WiqN638xyKpy2em4NymF6ZQp1HQ==
X-Received: by 2002:a17:902:ce85:b0:202:4a24:ee with SMTP id d9443c01a7336-20388bddbe0mr30180865ad.55.1724346493569;
        Thu, 22 Aug 2024 10:08:13 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2038560df7dsm14839665ad.225.2024.08.22.10.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 10:08:13 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:08:11 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shay Drori <shayd@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Added cond_resched() to crdump collection
Message-ID: <Zsdwe0lAl9xldLHK@apollo.purestorage.com>
References: <20240819214259.38259-1-mkhalfella@purestorage.com>
 <ea1c88ea-7583-4cfe-b0ef-a224806c96b1@intel.com>
 <ZsUYRRaKLmM5S5K9@apollo.purestorage.com>
 <ea86913b-8fbd-4134-9ee1-c8754aac0218@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea86913b-8fbd-4134-9ee1-c8754aac0218@nvidia.com>

On 2024-08-22 09:40:21 +0300, Moshe Shemesh wrote:
> 
> 
> On 8/21/2024 1:27 AM, Mohamed Khalfella wrote:
> > 
> > On 2024-08-20 12:09:37 +0200, Przemek Kitszel wrote:
> >> On 8/19/24 23:42, Mohamed Khalfella wrote:
> >>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> >>> index d0b595ba6110..377cc39643b4 100644
> >>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> >>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> >>> @@ -191,6 +191,7 @@ static int mlx5_vsc_wait_on_flag(struct mlx5_core_dev *dev, u8 expected_val)
> >>>              if ((retries & 0xf) == 0)
> >>>                      usleep_range(1000, 2000);
> >>>
> >>> +           cond_resched();
> >>
> >> the sleeping logic above (including what is out of git diff context) is
> >> a bit weird (tight loop with a sleep after each 16 attempts, with an
> >> upper bound of 2k attempts!)
> >>
> >> My understanding of usleep_range() is that it puts process to sleep
> >> (and even leads to sched() call).
> >> So cond_resched() looks redundant here.
> > 
> > This matches my understanding too. usleep_range() should put the thread
> > to sleep, effectively releasing the cpu to do other work. The reason I
> > put cond_resched() here is that pci_read_config_dword() might take long
> > time when that card sees fatal errors. I was not able to reproduce this
> > so I am okay with removing this cond_resched().
> > 
> >>
> >>>      } while (flag != expected_val);
> >>>
> >>>      return 0;
> >>> @@ -280,6 +281,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
> >>>                      return read_addr;
> >>>
> >>>              read_addr = next_read_addr;
> >>> +           cond_resched();
> >>
> >> Would be great to see how many registers there are/how long it takes to
> >> dump them in commit message.
> >> My guess is that a single mlx5_vsc_gw_read_fast() call is very short and
> >> there are many. With that cond_resched() should be rather under some
> > 
> > I did some testing on ConnectX-5 Ex MCX516A-CDAT and here is what I saw:
> > 
> > - mlx5_vsc_gw_read_block_fast() was called with length = 1310716
> > - mlx5_vsc_gw_read_fast() does 4 bytes at a time but the did not read
> >    full 1310716 bytes. Instead it was called 53813 times only. There are
> >    jumps in read_addr.
> > - On average mlx5_vsc_gw_read_fast() took 35284.4ns
> > - In total mlx5_vsc_wait_on_flag() called vsc_read() 54707 times with
> >    average runtime of 17548.3ns for each call. In some instances vsc_read()
> >    was called more than once until mlx5_vsc_wait_on_flag() returned. Mostly
> >    one time, but I saw 5, 8, and in one instance 16 times. As expected,
> >    the thread released the cpu after 16 iterations.
> > - Total time to read the dump was 35284.4ns * 53813 ~= 1.898s
> > 
> >> if (iterator % XXX == 0) condition.
> > 
> > Putting a cond_resched() every 16 register reads, similar to
> > mlx5_vsc_wait_on_flag(), should be okay. With the numbers above, this
> > will result in cond_resched() every ~0.56ms, which is okay IMO.
> 
> Sorry for the late response, I just got back from vacation.
> All your measures looks right.
> crdump is the devlink health dump of mlx5 FW fatal health reporter.
> In the common case since auto-dump and auto-recover are default for this 
> health reporter, the crdump will be collected on fatal error of the mlx5 
> device and the recovery flow waits for it and run right after crdump 
> finished.
> I agree with adding cond_resched(), but I would reduce the frequency, 
> like once in 1024 iterations of register read.
> mlx5_vsc_wait_on_flag() is a bit different case as the usleep there is 
> after 16 retries waiting for the value to change.
> Thanks.

Thanks for taking a look. Once in every 1024 iterations approximately
translates to 35284.4ns * 1024 ~= 36.1ms, which is relatively long time
IMO. How about any power-of-two <= 128 (~4.51ms)?

