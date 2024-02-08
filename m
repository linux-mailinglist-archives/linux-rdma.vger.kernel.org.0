Return-Path: <linux-rdma+bounces-970-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA884DB16
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 09:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301902838C2
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0866469E1C;
	Thu,  8 Feb 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naUXxxdU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66D72AD1D;
	Thu,  8 Feb 2024 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379830; cv=none; b=ZtAdBpS2u79GjkXxtgBxDC7AsiT0A7H6MZ2FpFOeBO5kvtiuZGB71YDaTPE1fnIyL/zcHZm/XOtqkB6Yy1Zwb55vOvkasXSdAw57IDfL4hCwpXR7H9CoJtkh8kuEb2PI44cAG5++iXktpWOJxzujZpZBDgHR5CjumeAwIRvsj7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379830; c=relaxed/simple;
	bh=f8fS3VylYeWzBDRy5ZzCL3I+hbLfKl3o5TJVKRsArhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh7oZ2yUhhQjnEg1QIxEoL1+GTjXyknjTYYSM959rwdU1vPTpWTOYuVXKO18UMKs6caknoaqrzcAQ9a1vQ93j/hU5jA3oJuZfvD3nNNitp+nCOVZnDb1aPBFT3P+dS0JRHtAxvjKqCUuCFGs2RYR42eyu/bNZEHyScPAu774vNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naUXxxdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09B3C433F1;
	Thu,  8 Feb 2024 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707379830;
	bh=f8fS3VylYeWzBDRy5ZzCL3I+hbLfKl3o5TJVKRsArhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=naUXxxdUDiKNE5yIbVxtWMlESWnQoRSV+OvRC7fWAIsP135g07i/LVzMWtC4KR5jp
	 YRb9nTROyfNlmWOYAUhZUPOVEmLxG38TOPsCjEZL4+hNKsEkVd6Ytsn4VC07WDd1Z1
	 zJ3HCCVi83YuZtoSXVXMHwYUQ2R9fmRKPeo9mieYvWCgtcfMp9XjTKWv+aZPUYh7EB
	 nTM6dyUop41puLLqrcAhhYqTQmC2RkuCQJhoi8uKjN19xfZFnh9xZOJUxaXq8F5pBF
	 ZbNIzA4FjuCal1tEYgPr471F7+qcMBmr66CwwjgYPTdE7A+dgHN5R0kxBWizezVpyd
	 OHqsh6uxeTBWQ==
Date: Thu, 8 Feb 2024 10:10:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 0/2] RDMA/hns: Support configuring congestion
 control algorithm with QP granularity
Message-ID: <20240208081025.GD56027@unreal>
References: <20240207032910.3959426-1-huangjunxian6@hisilicon.com>
 <20240207083338.GB56027@unreal>
 <322ab57d-05d8-72b9-9580-0579b5d8b468@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322ab57d-05d8-72b9-9580-0579b5d8b468@hisilicon.com>

On Wed, Feb 07, 2024 at 04:59:56PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/2/7 16:33, Leon Romanovsky wrote:
> > On Wed, Feb 07, 2024 at 11:29:08AM +0800, Junxian Huang wrote:
> >> Patch #1 reverts a previous bugfix that was intended to add restriction
> >> to congestion control algorithm for UD but mistakenly introduced other
> >> problem.
> > 
> > First patch shouldn't be revert but a fix to "add a restriction that only DCQCN
> > is supported for UD." and second patch should be a new feature.
> > 
> > Thanks
> > 
> 
> OK, but I have two questions here:
> 
> 1. Of course we can not only revert but also completely fix the bug in patch #1.
>    But since we are adding a new feature that can also fix this bug in patch #2,
>    the fix in patch #1 will be immediately removed in patch #2. Is this acceptable?

I would expect that second patch will extend the first one and not remove.

> 
> 2. Should I still put these two patches into one patchset in the next version, or
>    seperate them into two individual patchset?

Better to separate, as we will take fix faster than new feature.

Thanks

> 
> Thanks,
> Junxian
> 
> >>
> >> Patch #2 adds support for configuring congestion control algorithm with
> >> QP granularity. The algorithm restriction for UD is added in this patch.
> >>
> >> Junxian Huang (1):
> >>   RDMA/hns: Support configuring congestion control algorithm with QP
> >>     granularity
> >>
> >> Luoyouming (1):
> >>   Revert "RDMA/hns: The UD mode can only be configured with DCQCN"
> >>
> >>  drivers/infiniband/hw/hns/hns_roce_device.h | 26 +++++---
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 18 ++----
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 +-
> >>  drivers/infiniband/hw/hns/hns_roce_main.c   |  3 +
> >>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 71 +++++++++++++++++++++
> >>  include/uapi/rdma/hns-abi.h                 | 17 +++++
> >>  6 files changed, 118 insertions(+), 20 deletions(-)
> >>
> >> --
> >> 2.30.0
> >>
> > 

