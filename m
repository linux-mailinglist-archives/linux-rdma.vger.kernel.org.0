Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E845625F54
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 17:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiKKQWO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 11:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiKKQWN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 11:22:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8C7343D;
        Fri, 11 Nov 2022 08:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E70A5B8261D;
        Fri, 11 Nov 2022 16:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044D8C433C1;
        Fri, 11 Nov 2022 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668183729;
        bh=Jo2VLhgTPhaP0FaHWJqMlTHXlRzhpTRXowe0wUl1tYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLo0AIoboSZU0MWNkngQG3YmGzq+vFwred21EgELiAr0s910LEc6a3FNVJa7lZiBw
         JShUC5fxmg0Tdc9BbUDPDA2/8OCe6Pk+pavs74ZKt/d6zrUZ7NzSYxOq2CQ5T7ps9V
         akgPJYHdwVtLSFtrYJPnUaHPOtcAJGJt/eAesSwOimXEZxyuHRxuAiCtlxSr7cHqOK
         /9ImoaeWp87TxV31zju+WXPWlPWvxCrVSpGe6rA8xdAwiIfmCqtYtJk3IjQ5JGzSjq
         uadTXHvO3jKPZIg6+/N/MsNhe9kJG21pLxUX8kjtrXkc0JSzVfZ44fkAXOqsV4NgsA
         SLXYkX2iu/09w==
Date:   Fri, 11 Nov 2022 18:22:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 for-rc 0/2] Fix sge_num bug
Message-ID: <Y252rdeqOY2zGosj@unreal>
References: <20221108133847.2304539-1-xuhaoyue1@hisilicon.com>
 <Y2vsZ+qPWJI/R94M@unreal>
 <48d3efa2-60f8-c0dd-8206-8ca0466f3b77@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d3efa2-60f8-c0dd-8206-8ca0466f3b77@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 11, 2022 at 07:41:43PM +0800, xuhaoyue (A) wrote:
> Hi Jason and Leon,
> 
> Actually, I have another bugfix patch set needed to send, and I am waiting for this patch to apply. That one is not related to this patch set.
> Could I send it out, since it is a little late for Linux 6.1?

Up to you and the change you want to send. At this stage, your commit 
message must be very descriptive and patch should fix kernel panic and/or
UAPI issue introduced in previous cycle.

> Also, I wonder is that ok to send more than one patch set in the review list.

Yes, you can send, but with two small caveats:
1. You need to try and avoid merge conflicts if series are applied not in
the order of submission.
2. Series should be small.

Bottom line, take a look on RXE patches and DON'T do like them.

Thanks
