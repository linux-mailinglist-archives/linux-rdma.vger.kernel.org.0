Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A04693940
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Feb 2023 19:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBLSHn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Feb 2023 13:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLSHm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Feb 2023 13:07:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C89DBFD
        for <linux-rdma@vger.kernel.org>; Sun, 12 Feb 2023 10:07:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EA5760DB6
        for <linux-rdma@vger.kernel.org>; Sun, 12 Feb 2023 18:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331FDC433D2;
        Sun, 12 Feb 2023 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676225256;
        bh=vFSLReHzXdhWBWz/f/SF3bFURe13nFZaKECflZfH3qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7W/NrkQVT3VRwiYiPcQ+l5rZZRFzY5E8nWVY+sjTT6NkItq76WgYNrFQ3pDTvCmU
         /U39DQEPaXS7R+7zouBf7ecbgcGoaYEG7DoK/PGEiCYygP0Z8/RnqT88xH5qN27VVF
         Cw9i3vti03PCdWw4y9YZOzfozqCTMdw2I4Dz3LbPXRhpsd7l8xCszKAzcXV4qFIYnk
         YFGBU3OVlMjDdptUiO/edfi05kqN/eIL2VooBsOViVSyWpQMtVnDC/VAZ0JsCeMg6b
         YiUNv0KuiuTzT3HDliURJ4ubl+z5ynXsHpNzICO7+uayPAGDu2gD8Fm+Csye9roe5x
         znHySNj66gfZw==
Date:   Sun, 12 Feb 2023 20:07:32 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Sindhu Devale <sindhu.devale@intel.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        shiraz.saleem@intel.com, mustafa.ismail@intel.com
Subject: Re: [PATCH for-rc] RDMA/irdma: Fix for RoCEv2 traffic after IP
 deleted
Message-ID: <Y+kq5JZ6/BjZgy4e@unreal>
References: <20230208162507.1381-1-sindhu.devale@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208162507.1381-1-sindhu.devale@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 08, 2023 at 10:25:07AM -0600, Sindhu Devale wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Currently, traffic on a RoCEv2 RC QP can continue after the IP address is deleted from the interface.

Please break lines while you write commit messages.

> Fix this by finding QP's that use the deleted IP and modify to the error state.
> 
> Fixes: cc0315564d6e("RDMA/irdma: Fix sleep from invalid context BUG")
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
> ---
>  drivers/infiniband/hw/irdma/cm.c    | 113 +++++++++++++++++++++++++---
>  drivers/infiniband/hw/irdma/cm.h    |   6 +-
>  drivers/infiniband/hw/irdma/utils.c |  27 ++++++-
>  drivers/infiniband/hw/irdma/verbs.h |   9 +++
>  4 files changed, 135 insertions(+), 20 deletions(-)

Why is irdma special here?

I don't see anything even remotely close in other drivers.

Thanks
