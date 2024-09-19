Return-Path: <linux-rdma+bounces-5011-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1FE97CD58
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 19:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5ED31F229A5
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262AA1A2652;
	Thu, 19 Sep 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DIcLuD2A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80E18C31
	for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768485; cv=none; b=VO7+J472Q6P9lwX1FmmD4R4Azvj6vnEhmITPNOzKjx0h869XAIdk8lfw7BIXwiR/cuNZ80ZSra4/mQJ7WaPyZQKbZRfQWcD24Cco4kGCS3g3wRGkCGEeLl4mTie7SGdOmwn0slbZQKUe2S4N1LSA8IQ9eAkW+/AgawmcGOnKyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768485; c=relaxed/simple;
	bh=L2EgTXNrTRq/ZjjH1kSInpyVrSWJD/vH4Z+1Xj/9HIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCOY2V2Cgx0CL3HNk3KhrUUhSReo5tb7LAI7v4nRRDnQHaI19NzaMCWagABLAhn5BVgnwOMNATYT3mz99TQOpstvwyhEyKD33OzI/PW3yP62yORtDFMOWd7wBa/pYmoK3uLNSN/QEhwkrmfiJ3REdqVJ94t3rSO8lDPqQDWWVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DIcLuD2A; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so858844a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1726768483; x=1727373283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5Z/MiCwV25IPgl2HkDVjcuqIYV04L7ZzrLDbbmmiKY=;
        b=DIcLuD2AzHj8GBQdESnaiC2ebjVUFxkd/W/J42HjviX7J2FGDci//Halw8ZxAv4WAE
         zi87JnXBjMd6HO1ZJzr5o1u/HbJFGSABY3MtBlkwPuuuz9Tj6OFFYWeXH0nouoWVkcJy
         BfBYMPz/DycDlfdVIU8d3U0fgDTdJMYumEzXvs7+RHAKLF7dC8jQ3F980lIApMJUx4bP
         cqV4feCFzIbTc62t+M82dJmwbfM3GNSkjwZLx+oCTP7uT2KzzTtSXU0ReIzJDX5In1s4
         XHOrSA2YcRISgt1FLHMSM/HR+oJRPObpVlrU+G+lHr6hyH88YNRX2FIwZZA9UUsH17r+
         fxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726768483; x=1727373283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5Z/MiCwV25IPgl2HkDVjcuqIYV04L7ZzrLDbbmmiKY=;
        b=xEJdkhKWhSURr6+Ld26rWi3M8bBh5AXqivl5kGc9WeM9uO0gi8g9dadqxrzV5FBeMl
         GY4tlsCbaTxxxUVy2hIkBzXdeJY0Wo0wtjyIfZhYWi40mCNJUnN0SYPD5W/FWKOViMAE
         DZm/IK83BG0dmxm0OlIXplV++oC+Gsu2tTaVVQAmjL+/I4Cg7xni1iJdd1BBqZNqRcP/
         VFYK5sn5QK7XmfcSM2CwmYIk9TlLfXSuKG2LglX34grYWgTs4Lx2/H1N2aRf2CRZjT9o
         2A67WcnvAWuePGfsZGuETCol1PZWfd3Sz7NdF4I3O6tJmDZuzzUBJFLu/ZFw2VFz1z0r
         YsIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnQl7nnYj1Gw/Rzc6xSy1esikPUbCJf2ss6AffTGT89j63wflAFPo8adye0+gaoiTQ5DUyeZJwERw2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7mfd6Yc2tCy5mnQwHnGAJkrGH6Jkk/rUrCH7wMts/WxPXNVi
	vzEa+F4RElj6fvmerMuwVKX6gumcPGohNSof27TpkFsQ1ZtP2tPiIDeOdVu+Igs=
X-Google-Smtp-Source: AGHT+IHxbXl5qPD2Oz6Nk3e5ksHxOGqb+RhkZlOpyrQZFj/u1RlaBeB0FXDYtRQehBRwsqQi32jufg==
X-Received: by 2002:a17:90b:b09:b0:2da:50e6:5ab with SMTP id 98e67ed59e1d1-2dd6cecb68fmr6147970a91.18.1726768483450;
        Thu, 19 Sep 2024 10:54:43 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dd6ee9f43dsm2248810a91.24.2024.09.19.10.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 10:54:43 -0700 (PDT)
Date: Thu, 19 Sep 2024 10:54:41 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, yzhong@purestorage.com,
	Shay Drori <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH v2 0/1] net/mlx5: Added cond_resched() to crdump
 collection
Message-ID: <ZuxlYXXEBg2A3Y-a@apollo.purestorage.com>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
 <ZtELQ3MjZeFqguxE@apollo.purestorage.com>
 <43e7d936-f3c6-425a-b2ff-487c88905a0f@intel.com>
 <36b5d976-1fcb-45b9-97dd-19f048997588@nvidia.com>
 <ZtknozCovDvK7-bL@ceto>
 <ZuxePhq3V4ag8WTz@apollo.purestorage.com>
 <3d1be80f-4195-4b44-807e-92aa674307b7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1be80f-4195-4b44-807e-92aa674307b7@nvidia.com>

On 2024-09-19 20:40:48 +0300, Moshe Shemesh wrote:
> 
> 
> On 9/19/2024 8:24 PM, Mohamed Khalfella wrote:
> > 
> > On 2024-09-04 20:38:13 -0700, Mohamed Khalfella wrote:
> >> On 2024-08-30 12:51:43 +0300, Moshe Shemesh wrote:
> >>>
> >>>
> >>> On 8/30/2024 10:08 AM, Przemek Kitszel wrote:
> >>>
> >>>>
> >>>> On 8/30/24 01:58, Mohamed Khalfella wrote:
> >>>>> On 2024-08-29 15:38:55 -0600, Mohamed Khalfella wrote:
> >>>>>> Changes in v2:
> >>>>>> - Removed cond_resched() in mlx5_vsc_wait_on_flag(). The idea is that
> >>>>>>     usleep_range() should be enough.
> >>>>>> - Updated cond_resched() in mlx5_vsc_gw_read_block_fast every 128
> >>>>>>     iterations.
> >>>>>>
> >>>>>> v1:
> >>>>>> https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/
> >>>>>>
> >>>>>> Mohamed Khalfella (1):
> >>>>>>     net/mlx5: Added cond_resched() to crdump collection
> >>>>>>
> >>>>>>    drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
> >>>>>>    1 file changed, 4 insertions(+)
> >>>>>>
> >>>>>> --
> >>>>>> 2.45.2
> >>>>>>
> >>>>>
> >>>>> Some how I missed to add reviewers were on v1 of this patch.
> >>>>>
> >>>>
> >>>> You did it right, there is need to provide explicit tag, just engaging
> >>>> in the discussion is not enough. v2 is fine, so:
> >>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> >>>
> >>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> >>> And fixes tag should be:
> >>> Fixes: 8b9d8baae1de ("net/mlx5: Add Crdump support")
> >>
> >> Will add the tag in v3.
> > 
> > A quick follow up on this patch. I posted v3 [1] of this patch with
> > minor changes. There are no functional differences between v2 and v3 of
> > this patch. The commit messsage on v3 has information why call
> > cond_resched() every 128 iterations, so that could be useful to add.
> > 
> > Is there anything I need to do to get v2 or v3 of this patch merged?
> 
> I already added my reviewed-by tag on this patch you can see up here, 
> same goes to v3.
> Thanks.
Thank you.

