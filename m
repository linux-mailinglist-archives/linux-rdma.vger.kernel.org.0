Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E865484EDE
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 08:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbiAEHtw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 02:49:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38090 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbiAEHtw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 02:49:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8590DB81929
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 07:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C82FC36AE3;
        Wed,  5 Jan 2022 07:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641368990;
        bh=dXE2zm4W3aso4ZKBDA7XoNZmrLvKlNjYZRc1373aoCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUMrcy3mM6fV9yLCim3rJIpKUu0Yl0TXrhvclrAjPrNFpJsq1RObQ0lOQFUfuRO+N
         w1rNQqpuEw0NMEv2oywdiGe4ekbEerEqxrNMoWJJhF7ceJ+N9MgU7VUis4Gvwkdqvp
         ArDCRtBXtMbDvLsROXwmze24QpBOWjBZh/c8HbPfbquKhI9kZiNHMdsoxMJxQOlUSD
         bzMxNRBXw+nAHbRRzabTgg/dwfCwBqkwnXzR6I7Tnp73zrychQmUZJac9hOQZgVy9s
         ugLQWB/Cn9TkTKW7+cvwzCSjAHLtFmWgoW8eFc9XLvO6PxwsGWxITOW/ji6orDVNGO
         B34TjTh2qpKLA==
Date:   Wed, 5 Jan 2022 09:49:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/5] RDMA/core: Calculate UDP source port based on flow
 label or lqpn/rqpn
Message-ID: <YdVNmrmi2pPCRl/7@unreal>
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-2-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105221237.2659462-2-yanjun.zhu@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 05:12:33PM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Calculate and set UDP source port based on the flow label. If flow label
> is not defined in GRH then calculate it based on lqpn/rqpn.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  include/rdma/ib_verbs.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
