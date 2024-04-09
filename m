Return-Path: <linux-rdma+bounces-1866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCEF89D536
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 11:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC26B282EC8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C337EF14;
	Tue,  9 Apr 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1m6hQCv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811E3BBD8
	for <linux-rdma@vger.kernel.org>; Tue,  9 Apr 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654098; cv=none; b=N8ZlOQxN/IHfYHoNheeZ+jRmRPlnHxhN/tbmcIBdkgQlW1tFTETj/+U4wMfLwa38gcwqE6dnaVi5h9Q1pRE7jZxq/JOyo6nv0wfJIVLGBpNjX9cdybJBuOuN8RxVA6hQvSiU9kB4ok1xZWWipXXtL/RckYZ3phuTFHLl0/3UlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654098; c=relaxed/simple;
	bh=TKM89WN0S1IWDWAX+UlNafog5wgzPJ+nDtcIuulSyZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V18eLF8U3/oNxi7ku/Dg/HR6m3SXLgsTA6CgGw/YpEdJQCnPziGcebnEAbaPdYMrz1eRzU85HVtQA8seuuUFZl4bEwwJTbiMILmoa+kiKsJdBK2Hy86uNiJkEeTWMMvRfqfSknBu9Bq1xUWdhAepUOh0tiZntj5Fs/8JesAD4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1m6hQCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEF8C433C7;
	Tue,  9 Apr 2024 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654097;
	bh=TKM89WN0S1IWDWAX+UlNafog5wgzPJ+nDtcIuulSyZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1m6hQCvPJmWciLObkbuNISVPAY2t2S88O5uUSlOCw5R66H0de6TBdYyKGNOWMCgN
	 bQQW3ib2MG2EkctnF6sW31f0PiJnZXwLXnfncLgNyN9Qd8dCM90tM0sz9xGG8hfgAR
	 L6NKQCC8FZv7GyUYG/az8tKYpuIcMtW3UmHFZPCZBDpxMT/LHFthysSTWtb91Hz30N
	 eWoucvoKZDRIHSByGxnlPB4TEKCQz7HG4HXTqcSRSoJLLPXWhHi3YbsrI+a0PrcPnG
	 +up3KwUI4JMzhqF2KyfD90Yt33Zgodku+V5JJPN7qKMEXJfWCKTFhwsV0jlhRGBzf0
	 Vxb9D/rzYEK0Q==
Date: Tue, 9 Apr 2024 12:14:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: kernel test robot <lkp@intel.com>, Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [rdma:wip/leon-for-next] BUILD SUCCESS WITH WARNING
 c3236d538646c8e333370d71cb1d1e37e8996eaf
Message-ID: <20240409091453.GE4195@unreal>
References: <202404090846.K3NBrnkh-lkp@intel.com>
 <863c38c7-349d-42b0-4b0f-5512cf7d3cab@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <863c38c7-349d-42b0-4b0f-5512cf7d3cab@hisilicon.com>

On Tue, Apr 09, 2024 at 09:17:42AM +0800, Junxian Huang wrote:
> 
> 
> On 2024/4/9 8:08, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
> > branch HEAD: c3236d538646c8e333370d71cb1d1e37e8996eaf  RDMA/hns: Support DSCP
> > 
> > Warning reports:
> > 
> > https://lore.kernel.org/oe-kbuild-all/202404090005.YRqvDvXD-lkp@intel.com
> > 
> > Warning: (recently discovered and may have been fixed)
> > 
> > drivers/infiniband/hw/hns/hns_roce_ah.c:65:13: warning: unused variable 'max_sl' [-Wunused-variable]
> > drivers/infiniband/hw/hns/hns_roce_hw_v2.c:4864:13: warning: unused variable 'sl_num' [-Wunused-variable]
> > 
> 
> Sorry, will send a cleanup soon.

There is no need, I already fixed it.

Thanks

