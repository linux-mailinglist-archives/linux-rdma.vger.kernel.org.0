Return-Path: <linux-rdma+bounces-946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC7D84C64B
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 09:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788041F2456D
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6827B20324;
	Wed,  7 Feb 2024 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3TBNoXp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B932031C;
	Wed,  7 Feb 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707294824; cv=none; b=m9L0m8c8cvV1JBo0brQr3ORTmOn/tty9rp4dUKu2hz0YJSe8hvAwR5KxyWT8qZiEg7EmlWXbqdmgjDTV493YIUrQDIkJ4VpHmiUNj7dpEduI5QOO+KssLAC08qnFe+KEjbL2XjkdQ7kuPwKy3AVosteqfFX3j9WXUBwPRkZqFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707294824; c=relaxed/simple;
	bh=nOhXvYmd62bYlpNUjEHdYRDD49aGBERbbiFOVhXGsDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqh57gHZxFxhI8Y5GMOQirDnmjezoPuagWTeG0ZYYbDcWLaxH/wRruD0VSpTZjU8bEqQvOdb4ms+uPGP82iXGpRAdEmbrlPFFpRNIFLJBmjGaj6cvvO0dh2uuX0lV6Ladi5yIiY1INGFNN751JQOvKMgs0Tz85E3Eo4sS+X5WYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3TBNoXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17160C433C7;
	Wed,  7 Feb 2024 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707294823;
	bh=nOhXvYmd62bYlpNUjEHdYRDD49aGBERbbiFOVhXGsDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J3TBNoXp51qlKOvXZvCQHMIwRALuDdMThrVpIJ5owQtLlak3vqWhHJDBg8goHcF5E
	 qooTSk+NoQ2epPGjnrOlxFbDODkQnBPCzc51GQ5+1NpcTm5pXV8FIW6caEeuL8mFvr
	 JshHgpSMskwo4aIUTrCwk6dS5wguUeJCQ3/hrxTb6UzHdhEPj5QIwZAShToUy93cCY
	 x4w7c6ggD0hVdv/t7iikjJWqSHkzj+3yzxTung5rPCG6tsgcfaMO8U+1pocQiuU3KW
	 P8Ou6YLQW3f4e9YFxUcklg8eHrtx1+mJ801SrxX9VlgR1CP/ZiJs1N326kUAcBrEEp
	 Kveuw/BoRDmmw==
Date: Wed, 7 Feb 2024 10:33:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 0/2] RDMA/hns: Support configuring congestion
 control algorithm with QP granularity
Message-ID: <20240207083338.GB56027@unreal>
References: <20240207032910.3959426-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207032910.3959426-1-huangjunxian6@hisilicon.com>

On Wed, Feb 07, 2024 at 11:29:08AM +0800, Junxian Huang wrote:
> Patch #1 reverts a previous bugfix that was intended to add restriction
> to congestion control algorithm for UD but mistakenly introduced other
> problem.

First patch shouldn't be revert but a fix to "add a restriction that only DCQCN
is supported for UD." and second patch should be a new feature.

Thanks

> 
> Patch #2 adds support for configuring congestion control algorithm with
> QP granularity. The algorithm restriction for UD is added in this patch.
> 
> Junxian Huang (1):
>   RDMA/hns: Support configuring congestion control algorithm with QP
>     granularity
> 
> Luoyouming (1):
>   Revert "RDMA/hns: The UD mode can only be configured with DCQCN"
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h | 26 +++++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 18 ++----
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  3 +
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 71 +++++++++++++++++++++
>  include/uapi/rdma/hns-abi.h                 | 17 +++++
>  6 files changed, 118 insertions(+), 20 deletions(-)
> 
> --
> 2.30.0
> 

