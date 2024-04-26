Return-Path: <linux-rdma+bounces-2112-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB91C8B3D6D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 19:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C217D1C226CC
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB2168B08;
	Fri, 26 Apr 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx+dcwZ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9C1649DA;
	Fri, 26 Apr 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150698; cv=none; b=minENdBnOoGTJKz/Any4tjqNv7YNGh27PIC8MHVpDqu+9QtxiL2dreoS7dI5ie6JhZ/HDlbQ07xUHjy+UtJjbEZzAjKVAJg4uvTUMUBqx7eIoi01KAIi06oD2IEtEQ1u5GaH/Ojprc1D2LBN30Wc8Ovc9CNzeqZFeegOWaHvfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150698; c=relaxed/simple;
	bh=EzYFiYt6zEp6WoEpQGiC0Ch86lvn1yMBxmE8d4XGy7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLQoTYvplLiHpdRs12NNnr2xa1eLCOuGaO3ZRLpgdocn1AALAbV9JstyiR8cKILEt/zK8F7NeV2PpSdnYZtTH1zq7miioxdfvOTThE5OZS0cgmsJDQl/sduxR13f23n6tbQGHCqbHSflQ7LAn06KUj3H+IdSLmxo/zPoDNgCrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx+dcwZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DECDC113CD;
	Fri, 26 Apr 2024 16:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714150698;
	bh=EzYFiYt6zEp6WoEpQGiC0Ch86lvn1yMBxmE8d4XGy7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zx+dcwZ/cP/6zGMidM3R4Sul92n/dJXEknLlOqnHyTiROmD1gZTk52mR14xMSVeb6
	 3i1G5XIKGDp9KW+Yh0XjfVRBkDhGfClqdMRgCQOWQAjtej2ikhguouRx+dOZWfY7QA
	 fnyXPUm0KKDQcVtvz1bNds+1hc/spSMqvqGswb7Ee/tA7KygGvbHQMqu76wapHGetR
	 7umtJKcGP9LtYuzqrLvgV92ldNfLdPeF/qyWV+Y/Xkh7ycTk4Y5ijVwS6jBy5tL6oE
	 VtmSZYO+vZXbtI6NgqaQ8FTSJFjxIImQENPANPr1fMDKvMPha10gwK4uyZJwV9BMlO
	 wYW6Ly4oAg/jQ==
Date: Fri, 26 Apr 2024 09:58:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	kotaranov@microsoft.com, sharmaajay@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: fix missing ret value
Message-ID: <20240426165815.GA2876951@dev-arch.thelio-3990X>
References: <1713881751-21621-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240423150315.GA891022@nvidia.com>
 <Zivb7qs4gSywzVsL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zivb7qs4gSywzVsL@smile.fi.intel.com>

On Fri, Apr 26, 2024 at 07:53:02PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 12:03:15PM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 23, 2024 at 07:15:51AM -0700, Konstantin Taranov wrote:
> > > From: Konstantin Taranov <kotaranov@microsoft.com>
> > > 
> > > Set ret to -ENODEV when netdev_master_upper_dev_get_rcu
> > > returns NULL.
> > > 
> > > Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> > > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > > ---
> > >  drivers/infiniband/hw/mana/device.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Applied to for-next, thanks
> 
> So, what's wrong with my patch that had been sent _before_ this one?

Was it?

This patch:

  $ date -d 'Tue, 23 Apr 2024 07:15:51 -0700' -u
  Tue Apr 23 02:15:51 PM UTC 2024

Your patch: https://lore.kernel.org/20240423204258.3669706-1-andriy.shevchenko@linux.intel.com/

  $ date -d 'Tue, 23 Apr 2024 23:42:58 +0300' -u
  Tue Apr 23 08:42:58 PM UTC 2024

Seems like this one beat yours by six hours?

Cheers,
Nathan

