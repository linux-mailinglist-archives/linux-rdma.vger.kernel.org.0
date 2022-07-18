Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D945780A1
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 13:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiGRLVr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGRLVr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 07:21:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52688E01A
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 04:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E365BB8111D
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 11:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224C1C341C0;
        Mon, 18 Jul 2022 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658143303;
        bh=xHGJ+X6rkXzMwTL4uTrudTYzmvu931YVczbm9VFcBT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyLMAzX3rrVANfVrM5Zv5LpnChYhw1+xCkQkFmhrf8ktHgH0ihNgib31X2ch104tG
         XevzusxaoA26zwe2wT+3IVsUY5b+EEpXX8z/uX0qlS1pU4fxsuDHMh9UVphdP09HVZ
         1k2jCoC7IWeOK4yWZ8SB+N4jO9jXG4wdPhIeJnnH20cfMrhdCb3C3C1yZGIbWttCde
         /Uto2WRW20Fa+HiOev+vssd9fMZarFpi4E+GdF9i9dTGgKwtuHUbOHMZ1PtQV/oRKm
         2ozd2Upts2W+V5D7mPsqh0Mne4qZrag1FIQQoYCgfIma6th0UMheODS5EQBNQhv1TQ
         j0bzWnxXWYwag==
Date:   Mon, 18 Jul 2022 14:21:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, BMT@zurich.ibm.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/siw: Fix duplicated reported
 IW_CM_EVENT_CONNECT_REPLY event
Message-ID: <YtVCQo+3RS9gSLqF@unreal>
References: <dae34b5fd5c2ea2bd9744812c1d2653a34a94c67.1657706960.git.chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dae34b5fd5c2ea2bd9744812c1d2653a34a94c67.1657706960.git.chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 14, 2022 at 09:30:47AM +0800, Cheng Xu wrote:
> If siw_recv_mpa_rr returns -EAGAIN, it means that the MPA reply hasn't
> been received completely, and should not report IW_CM_EVENT_CONNECT_REPLY
> in this case. This may trigger a call trace in iw_cm. A simple way to
> trigger this:
>  server: ib_send_lat
>  client: ib_send_lat -R <server_ip>
> 
> The call trace looks like this:
> 
>  kernel BUG at drivers/infiniband/core/iwcm.c:894!
>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>  <...>
>  Workqueue: iw_cm_wq cm_work_handler [iw_cm]
>  Call Trace:
>   <TASK>
>   cm_work_handler+0x1dd/0x370 [iw_cm]
>   process_one_work+0x1e2/0x3b0
>   worker_thread+0x49/0x2e0
>   ? rescuer_thread+0x370/0x370
>   kthread+0xe5/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x1f/0x30
>   </TASK>
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")

Thanks, applied.
