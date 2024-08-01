Return-Path: <linux-rdma+bounces-4149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206B3944A6A
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 13:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB20A1F219C1
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6F1170A20;
	Thu,  1 Aug 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7XsEE3B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431D7406D;
	Thu,  1 Aug 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511860; cv=none; b=Y7JqwwsilzetpsuaicJ97Lz1eAWjJREA4nRK6cqudsDt+AaO6qSWUQKs4VXCfpjNc+EB3wRuCLVJCEctijUNqyENQXR5Ob/+9eJjdlSi56ULeLeiO4lKl2sIn19nn7HPhoI0ZMMVHjFOGE+BR7AsFQ/2Y13Cswmb3It1aqHO6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511860; c=relaxed/simple;
	bh=fbqVFlOK511foaak+99Fgz0L0P/nMuTSt21J2SoqSEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mX4+aenhXh7n4RMOaEPJMpdThk0CCQStvN0cKSjDpshaWnat8Lk/+SxZs3WRuP/AGcp+rHsaB2CqV14v28NKXmXhC1zrZ4LCbIBat5MVf47mwGwp65hhc+fXu6uvOg4v6kkEZomxQ24hnrAwDjSdEBKBxDVhJLGuUvm6TkhvuDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7XsEE3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0E4C32786;
	Thu,  1 Aug 2024 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722511859;
	bh=fbqVFlOK511foaak+99Fgz0L0P/nMuTSt21J2SoqSEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7XsEE3BmtNonBaRCiTNN4/SNIkOez4Gq4khVdq+2ISkPhr91Tfv6T6zo6bWyGVMe
	 8yw4rU0q6By7k2sM5d667ots28I3rlUKkULBtGZH2njAjpj8Xz4Xu0FBp/laszmewL
	 6oYhmXCB6lS4VIvmNHwo/336tFp0hCTABy9Ubsb8CNc+JzzYdZWEzhxt8/24FEoXZz
	 eJW6DlFTGOUJkxS9oNjKZWRRZyiHi91O+MoYc3Sq0bHwGOpj66z0SnWPeNBnRd3ISu
	 hgD4mXdPbWPMbndTzX0O1wYp0jHsv/T2RsC1C0HdRFznU0ZaDw0tWBenRXYKRklBEk
	 MHsU2VlKuV6oQ==
Date: Thu, 1 Aug 2024 14:30:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, bvanassche@acm.org, nab@risingtidesystems.com,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix UAF when srpt_add_one() failed
Message-ID: <20240801113055.GH4209@unreal>
References: <20240801074415.1033323-1-huangjunxian6@hisilicon.com>
 <20240801103712.GG4209@unreal>
 <bcbc57ba-3e54-cfe5-60b8-8f3990f40000@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcbc57ba-3e54-cfe5-60b8-8f3990f40000@hisilicon.com>

On Thu, Aug 01, 2024 at 07:02:41PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/8/1 18:37, Leon Romanovsky wrote:
> > On Thu, Aug 01, 2024 at 03:44:15PM +0800, Junxian Huang wrote:
> >> Currently cancel_work_sync() is not called when srpt_refresh_port()
> >> failed in srpt_add_one(). There is a probability that sdev has been
> >> freed while the previously initiated sport->work is still running,
> >> leading to a UAF as the log below:
> >>
> >> [  T880] ib_srpt MAD registration failed for hns_1-1.
> >> [  T880] ib_srpt srpt_add_one(hns_1) failed.
> >> [  T376] Unable to handle kernel paging request at virtual address 0000000000010008
> >> ...
> >> [  T376] Workqueue: events srpt_refresh_port_work [ib_srpt]
> >> ...
> >> [  T376] Call trace:
> >> [  T376]  srpt_refresh_port+0x94/0x264 [ib_srpt]
> >> [  T376]  srpt_refresh_port_work+0x1c/0x2c [ib_srpt]
> >> [  T376]  process_one_work+0x1d8/0x4cc
> >> [  T376]  worker_thread+0x158/0x410
> >> [  T376]  kthread+0x108/0x13c
> >> [  T376]  ret_from_fork+0x10/0x18
> >>
> >> Add cancel_work_sync() to the exception branch to fix this UAF.
> >>
> >> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>  drivers/infiniband/ulp/srpt/ib_srpt.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> >> index 9632afbd727b..244e5c115bf7 100644
> >> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> >> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> >> @@ -3148,8 +3148,8 @@ static int srpt_add_one(struct ib_device *device)
> >>  {
> >>  	struct srpt_device *sdev;
> >>  	struct srpt_port *sport;
> >> +	u32 i, j;
> >>  	int ret;
> >> -	u32 i;
> >>  
> >>  	pr_debug("device = %p\n", device);
> >>  
> >> @@ -3226,7 +3226,6 @@ static int srpt_add_one(struct ib_device *device)
> >>  		if (ret) {
> >>  			pr_err("MAD registration failed for %s-%d.\n",
> >>  			       dev_name(&sdev->device->dev), i);
> >> -			i--;
> >>  			goto err_port;
> >>  		}
> >>  	}
> >> @@ -3241,6 +3240,8 @@ static int srpt_add_one(struct ib_device *device)
> >>  	return 0;
> >>  
> >>  err_port:
> >> +	for (j = i, i--; j > 0; j--)a
> >> +		cancel_work_sync(&sdev->port[j - 1].work);
> > 
> > There is no need in extra variable, the following code will do the same:
> > 
> > 	while (i--)
> > 		cancel_work_sync(&sdev->port[i].work);
> > 
> >>  	srpt_unregister_mad_agent(sdev, i);
> 
> i is also used here.

So put cancel_work_sync() there.

Thanks

> 
> Junxian
> 
> >>  err_cm:
> >>  	if (sdev->cm_id)
> >> -- 
> >> 2.33.0
> >>
> > 
> 

