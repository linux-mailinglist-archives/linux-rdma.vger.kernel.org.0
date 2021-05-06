Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5DC375316
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 13:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbhEFLf3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 07:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234603AbhEFLf2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 May 2021 07:35:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A241E61157;
        Thu,  6 May 2021 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620300870;
        bh=8/cRQsRVgB8StZWU9Xp8Xr8DXDhLO/Z29n+TRUw5MM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8F9gJR4X/sfeZY6WomvCBM0VWYm8O4yGQw3tvVP74DVD98XCOTx36h+nprSmXrQT
         5Kl5evgRcsp1qP3hpvD4WPEvBIaey4PkCQy9V7vU728w7v5OEvDsIXUQojOC7LECzl
         67Uu05lft0nRp4ycSd4H05pQQfYtKKq/jNVX9wQrTScltBoGJ3aD96jWjizoN6MVhE
         ruawG2onLNW9xnvJ+1az9K5tRLXB7t4aeRw97fYn77mbu5CV0W3epRjt/iez83rIQo
         BDHVbOA9FFTZYrQg+evX4poLXZiseOTsGCmvnRkF0hXvlDfx52cWXzY8oygGAGc1LH
         YgSWyHy7uFniA==
Date:   Thu, 6 May 2021 14:34:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ib_srpt: Remove redundant assignment to ret
Message-ID: <YJPUQkQCS86mS9gw@unreal>
References: <1620296105-121964-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620296105-121964-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 06, 2021 at 06:15:05PM +0800, Yang Li wrote:
> Variable 'ret' is set to -ENOMEM but this value is never read as it is
> overwritten with a new value later on, hence it is a redundant
> assignment and can be removed
> 
> In 'commit b79fafac70fc ("target: make queue_tm_rsp() return void")'
> srpt_queue_response() has been changed to return void, so after "goto
> out", there is no need to return ret.
> 
> Clean up the following clang-analyzer warning:
> 
> drivers/infiniband/ulp/srpt/ib_srpt.c:2860:3: warning: Value stored to
> 'ret' is never read [clang-analyzer-deadcode.DeadStores]
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Fixes: b99f8e4d7bcd ("IB/srpt: convert to the generic RDMA READ/WRITE API") 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
