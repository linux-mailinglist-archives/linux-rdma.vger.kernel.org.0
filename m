Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842FD68BAEB
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 12:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBFLD6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 06:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBFLD6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 06:03:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2484232
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 03:03:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A56C660E83
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 11:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C245C433D2;
        Mon,  6 Feb 2023 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675681436;
        bh=WWtxc+2z+aMgAbEf7SFv9+w6zx+MsRbc3ke8P9vieeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0bt8LBSc2oLTq2cAZlZjzeRyuZPEGABv/hkV52QoJcWAGVUpYz0tM5+ExnftD7vH
         4b11NwJDry/nsvjvEGFKYASosIOy4rYLB+cUDDF3QYZm/oWBlQ1u7d84SeGIuSY7OB
         qfRLLh4xyqEMU+e1vlOaac9zqCJth1SNdOQmI5BINpeKxzbIgGLpx5VP8RetmG3o7Y
         LuG0w/tgay0/2CCQ+xX3EcSM/Gv3bwR/u7vkXd4q1ewA6yf6tEMvOyRYP+lmZb0bE7
         cXVeAmYPgKvxA+hEn+7uaYDh6iJFq8CFEX3nFs4xOBLx9MAvL59IUfpGyH127xKM6z
         F57+jOspghEVg==
Date:   Mon, 6 Feb 2023 13:03:52 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jgg@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 0/3] Rework system pinning
Message-ID: <Y+DemENJaLcGW9ki@unreal>
References: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 25, 2023 at 03:01:33PM -0500, Dennis Dalessandro wrote:
> This series from Pat & Brendan reworks the system memory pinning in our driver
> to better handle different types of memory buffers that are passed into. 
> 
> Changes Since v1:
> ----------------
> Added missing commit messages to patches 1 and 2.
> 
> ---
> 
> Patrick Kelsey (3):
>       IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
>       IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors
>       IB/hfi1: Do all memory-pinning through hfi1's pinning interface
> 

<...>

>  include/uapi/rdma/hfi/hfi1_ioctl.h      |  18 +
>  include/uapi/rdma/hfi/hfi1_user.h       |  31 +-
>  include/uapi/rdma/rdma_user_ioctl.h     |   3 +

Where can we see user-space part of these changes?

Thanks
