Return-Path: <linux-rdma+bounces-8317-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664DEA4E250
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 16:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C563BFC94
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523DE25DB16;
	Tue,  4 Mar 2025 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFIZLBaL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E620AF68
	for <linux-rdma@vger.kernel.org>; Tue,  4 Mar 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099481; cv=none; b=Kzy7GdX1oLURUGXZehEkerDuiufqWjPt/F3qxpjY6NIPImXpE48a0F3NtCCdFGAaS+hWdTkYDy8779l2QM0X4mohj/IKNRzU9mQePdeE1l5uPLo27BSuMOy60HAtBOGtSv4YAW6cYFQ/qv7FGf6wu3NBFvoNvt706m1eFhGSbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099481; c=relaxed/simple;
	bh=51kKBuvYYpflpeoeO3Xg1ua9IU6MBr8g/1OI19k6VCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhSMMAxTgCD+W5KKF8XxBn/gsR/F3wqoGPQQZ337yUyYmuC8+74Td/VVABssWcoQyWswV7Vy3+LXrBAK1ZaQfjzmBT75HjgqyRxKOrf/Yh3Dxtr3fJyGhBde4ts0N52aN6eylFHIKUHO7Zjelf1BywuiB4ECEkpfmd1h7RTUIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFIZLBaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242CAC4CEE5;
	Tue,  4 Mar 2025 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099480;
	bh=51kKBuvYYpflpeoeO3Xg1ua9IU6MBr8g/1OI19k6VCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFIZLBaLHxhhLtpLBUIzoQfdCYH8nMlhxZ9J4SQOA5u4lSZgzf/Ur3reiv/kU4O4o
	 43+oaHlvfesfu8iwtZS41yTH6EtB/mryJ6vjhvWq1/joi4nwbm8yHU+iNQ3+PD+w0g
	 eq0EyqXHcCtbJ4LqhnuYje/IukLI20MnXjiyixF2JYV6rGpko7nEbxiX2ZyCHVnfYo
	 UZPbCAGHIyoxkETuRjiipGhp4vIV2PNE1Ne2Yjr9h/ZqPwiaCTwMVMgewQNc49FamH
	 B6KRzCR91eUxYM+NeSDUD90Ouym3a4FeEYSQFAwtUeq/42vAUd9gAtVzfImMuaeSn6
	 07UqI6YGsLJrg==
Date: Tue, 4 Mar 2025 16:44:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 1/6] RDMA/uverbs: Introduce UCAP (User
 CAPabilities) API
Message-ID: <20250304144436.GG1955273@unreal>
References: <cover.1740574943.git.leon@kernel.org>
 <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>
 <20250304131852.GH133783@nvidia.com>
 <20250304134418.GF1955273@unreal>
 <20250304143026.GL133783@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304143026.GL133783@nvidia.com>

On Tue, Mar 04, 2025 at 10:30:26AM -0400, Jason Gunthorpe wrote:
> On Tue, Mar 04, 2025 at 03:44:18PM +0200, Leon Romanovsky wrote:
> 
> > > > +	device_initialize(&ucap->dev);
> > > > +	ucap->dev.class = &ucaps_class;
> > > > +	ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
> > > > +	ucap->dev.release = ucap_dev_release;
> > > > +	dev_set_name(&ucap->dev, ucap_names[type]);
> > > 
> > > Missing error handling on dev_set_name()
> > 
> > Most of the kernel users don't check dev_set_name(). It can't fail in
> > reality.
> 
> I'd still add the missing check

I can add this hunk while applying the patch.

diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
index 82b1184891ed..e958bd6e34d7 100644
--- a/drivers/infiniband/core/ucaps.c
+++ b/drivers/infiniband/core/ucaps.c
@@ -169,7 +169,9 @@ int ib_create_ucap(enum rdma_user_cap type)
        ucap->dev.class = &ucaps_class;
        ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
        ucap->dev.release = ucap_dev_release;
-       dev_set_name(&ucap->dev, ucap_names[type]);
+       ret = dev_set_name(&ucap->dev, ucap_names[type]);
+       if (ret)
+               goto err_device;

        cdev_init(&ucap->cdev, &ucaps_cdev_fops);
        ucap->cdev.owner = THIS_MODULE;



> 
> Jason

