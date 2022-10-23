Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DAF609337
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Oct 2022 15:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJWNEM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 09:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJWNEL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 09:04:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFA46FA24
        for <linux-rdma@vger.kernel.org>; Sun, 23 Oct 2022 06:04:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CF47B80B2C
        for <linux-rdma@vger.kernel.org>; Sun, 23 Oct 2022 13:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D07EC433D6;
        Sun, 23 Oct 2022 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666530247;
        bh=F91TU7xDLwVBsZ12yVUspcO7ppC4dYAVPJPQNnBT+oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSzMwra1NAXS/YnPwQ7Rq8yl2bW+Wsg5j2TAPineWW6PRCCV5z5Sv+3RHxtxy3Qyr
         fUyLnawI2LTKpUU5oLweZgf2R4b0gWzxBj20HgdHgK17uKf2qC42RrWKQyxsT3l5lH
         JThGa5zGu0nwwQSFOeiZqS4bmo1K727/+uPxPy7sFsNRiaUhn1KUooq48fzXn/O3TE
         IP7haZKioTWO1aFUV0zR0DX1NvT1sn0ZZ30/RV5fcbwoQThIJZt5G4oY4KCPCSViMg
         mnQBCl/GlsKRSbYSx2xfVDhBMEYPcd1UXn+515HNPeeQvLP00QE6bbgQfpWqGhGi06
         xxfdh7y4Dfcog==
Date:   Sun, 23 Oct 2022 16:04:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: Re: [PATCH 0/3] RDMA net namespace
Message-ID: <Y1U7w+6emBqrQnkI@unreal>
References: <20221023220450.2287909-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023220450.2287909-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 23, 2022 at 06:04:47PM -0400, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> There are shared and exclusive modes in RDMA net namespace. After
> discussion with Leon, the above modes are compatible with legacy IB
> device. 
> 
> To the RoCE and iWARP devices, the ib devices should be in the same net
> namespace with the related net devices regardless of in shared or
> exclusive mode.
> 
> In the first commit, when the net devices are moved to a new net
> namespace, the related ib devices are also moved to the same net
> namespace.

I think that rdma_dev_net_ops are supposed to handle this.

Thanks
