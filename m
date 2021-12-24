Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E01A47EBE0
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 07:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351421AbhLXGBB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 01:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351410AbhLXGBB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Dec 2021 01:01:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3B3C061401;
        Thu, 23 Dec 2021 22:01:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4E4261847;
        Fri, 24 Dec 2021 06:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1C1C36AE8;
        Fri, 24 Dec 2021 06:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640325660;
        bh=DmRKthJ2kVM6MCITVMqiUPHjYnufAo/yIEno99XHZco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VI0k4+stqa8m2hv4CHELbLTnDPl7ncyZYuXKp9p3Vgh8lGzPf6zzQpAHheuk56Dcn
         1wg0v2H9/UVENl2Um4BDpYxig+MtLrBn0RW9GtVXcD4GqKedHGhDIcTo9wlCV+2W4p
         MQWfvu1S0eWhf0W46uWAW+Ft+oIBOvWt+oCaHwKe8gYbriFPtN2hOcNg/FvG5c2Pjz
         ikt2yb41Xpt9avpWx9kvOs0zFxuXsU3xxiQW3Eoal4XDqq5WeK5i0IzdWzrSnrS3b0
         CloC2emYJtpQ9At2hPH5Qw2YQ8Tvx7ojM215ue6m/Z2aQEOkiMoT/rKUCEq5DyAmBC
         yc+AqEovJfXQA==
Date:   Fri, 24 Dec 2021 08:00:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, alaa@nvidia.com,
        chuck.lever@oracle.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-rc] Revert "RDMA/mlx5: Fix releasing unallocated
 memory in dereg MR flow"
Message-ID: <YcViF8yyTfuedh38@unreal>
References: <20211222101312.1358616-1-maorg@nvidia.com>
 <20211224025145.GE1779224@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224025145.GE1779224@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 23, 2021 at 10:51:45PM -0400, Jason Gunthorpe wrote:
> On Wed, Dec 22, 2021 at 12:13:12PM +0200, Maor Gottlieb wrote:
> > This patch is not the full fix and still causes to call traces
> > during mlx5_ib_dereg_mr().
> > 
> > This reverts commit f0ae4afe3d35e67db042c58a52909e06262b740f.
> > 
> > Fixes: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
> > Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 +++---
> >  drivers/infiniband/hw/mlx5/mr.c      | 26 ++++++++++++++------------
> >  2 files changed, 17 insertions(+), 15 deletions(-)
> 
> Huh? Why is this such a problem to fix the missing udatas?

Because of internal structure of Nvidia/Mellanox, we are having very
hard time to properly test any fix in ULP area.

In addition, the vacation season doesn't help either.

Feel free to approach me or Maor offline and we will explain you the
non-technical details behind this revert.

Thanks

> 
> Jason
