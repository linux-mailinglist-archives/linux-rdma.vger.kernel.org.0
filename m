Return-Path: <linux-rdma+bounces-1864-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C613389D303
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 09:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034541C20BEC
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 07:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9937BB11;
	Tue,  9 Apr 2024 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BomYJ/M8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F8F7605D;
	Tue,  9 Apr 2024 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647743; cv=none; b=oWOCgrip8BHOYXTXqm6DqZ/FtSOg1yZWR1d0tOXyCOO50PVV0HCJmI3c51OvX9FWy/jMxuX8y0kSeYZMMvFU36kRc58Liz7hX+i/LR/9wKpLMMcHHse47iwH0/My0Yw/dHorrlwvR5Mb0GaOwp7Wl+3UIsS/RqbmvZbzPH4avdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647743; c=relaxed/simple;
	bh=JvKfcKEAsoiskBON5TaDR8k78HLBl5gF+EQsdjcI+8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieLKZiohHCkHa6/4P1U1YVZcUHmqKP/ud0Yuj+wVYwdmHSOj/YcOs+sr1xCF0hgcejDWXwFNEENnnAievUGnueRYIl6sUsQZVJQ3YiOFvN3JShbH1O6EwEw1ECK/HTwW5rdQODRk9z0pUdThgGrKvxAfEIp+IDy/1SI/cgNb9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BomYJ/M8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AC5C433F1;
	Tue,  9 Apr 2024 07:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712647743;
	bh=JvKfcKEAsoiskBON5TaDR8k78HLBl5gF+EQsdjcI+8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BomYJ/M8QtCzV6uHRx8jf/lBcP7hvw5jcjWLugYPNLXlboEjpQksxcJ6IpaCF6Dwi
	 KX1PJdVwhNo2cpLnP6VhGZKk710yRei55HdfW0iRVNvwiRs+LQU5NJsTO1Sxithqu3
	 FVQ/x/Zf9i1C7LdTYcShE7oZqTFg/B3pDRi4jjCrZljoWrRhdrufJ9jRXRjdEVrJCn
	 LeFTTKwFnN+kMjf5ZGHHJSNXDHy4Ow49BETYTGVHL2Oj7uTVmNPTVAVxkwmGrKgQ50
	 kGu7YJELtgMhgmIp8gVuKVM0U1xIFrfNNF0FRE0PZqhiFPAep8+PyGHRUVJSXeKOQi
	 0b/w+8+iDX+Aw==
Date: Tue, 9 Apr 2024 10:28:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>,
	oe-kbuild-all@lists.linux.dev, Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [rdma:wip/leon-for-next 12/12]
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c:4864:13: warning: unused variable
 'sl_num'
Message-ID: <20240409072858.GB4195@unreal>
References: <202404090005.YRqvDvXD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404090005.YRqvDvXD-lkp@intel.com>

On Tue, Apr 09, 2024 at 12:14:20AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
> head:   c3236d538646c8e333370d71cb1d1e37e8996eaf
> commit: c3236d538646c8e333370d71cb1d1e37e8996eaf [12/12] RDMA/hns: Support DSCP
> config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240409/202404090005.YRqvDvXD-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240409/202404090005.YRqvDvXD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404090005.YRqvDvXD-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function 'hns_roce_set_sl':
> >> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:4864:13: warning: unused variable 'sl_num' [-Wunused-variable]
>     4864 |         u32 sl_num;
>          |             ^~~~~~
> --
>    drivers/infiniband/hw/hns/hns_roce_ah.c: In function 'hns_roce_create_ah':
> >> drivers/infiniband/hw/hns/hns_roce_ah.c:65:13: warning: unused variable 'max_sl' [-Wunused-variable]
>       65 |         u32 max_sl;
>          |             ^~~~~~
> 

Thanks for the report, fixed.

