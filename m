Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8234A602743
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 10:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJRIlb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 04:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJRIla (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 04:41:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F422D1F9;
        Tue, 18 Oct 2022 01:41:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B938B81D87;
        Tue, 18 Oct 2022 08:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB41C433C1;
        Tue, 18 Oct 2022 08:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666082487;
        bh=i+32hOOFbdeWka8X0/B248gtA7ffcNpeaUupMbTCTP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lr6pnMrbHpjmCWvtEg002JTuRybA5i5LrsVXvGwsLghUJ6XKOxJoxR1JDS/1X5SeF
         2yJdFX/U3nwQ/CdffEqKQgDvPoaBpKCgl8qJjBUkpv750QJetoGL1DjCk+ZW7Oxh3s
         B87JziudmfkRP6++rIaDMXv2HPw6bTP6qXNBKz8tyxP0V0S960lsaiDk0xdl4FGi0b
         nETBkouq+6I+Iah/54+HRIjlh47bY8JFN0G4D69C5BBRfXsN1BahRRDB15X5hpQ0J2
         LCWJTf5xJdFTbdIe2mmO1njF4wr+q1dVtVhENtvSat9gGmcwk1FD24ghEFF8GcHoUn
         FNisl++GKIUIw==
Date:   Tue, 18 Oct 2022 11:41:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Natalia Petrova <n.petrova@fintech.ru>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] rdmavt: avoid NULL pointer dereference in rvt_qp_exit()
Message-ID: <Y05msUNgnQTWmXyh@unreal>
References: <20221017142652.13906-1-n.petrova@fintech.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017142652.13906-1-n.petrova@fintech.ru>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 17, 2022 at 05:26:52PM +0300, Natalia Petrova wrote:
> rvt_qp_exit() checks 'rdi->qp_dev' for NULL, but the pointer is
> dereferenced before that in rvt_free_all_qps().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: f92e48718889 ("IB/rdmavt: Reset all QPs when the device is shut
> down")

Please never break fixes line.

> Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> index 3acab569fbb9..06e755975f61 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.c
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -459,13 +459,16 @@ static unsigned rvt_free_all_qps(struct rvt_dev_info *rdi)
>   */
>  void rvt_qp_exit(struct rvt_dev_info *rdi)
>  {
> -	u32 qps_inuse = rvt_free_all_qps(rdi);
> +	u32 qps_inuse = 0;
> +
> +	if (!rdi->qp_dev)
> +		return;
> +
> +	qps_inuse = rvt_free_all_qps(rdi);

These lines are not needed.

>  
>  	if (qps_inuse)
>  		rvt_pr_err(rdi, "QP memory leak! %u still in use\n",
>  			   qps_inuse);
> -	if (!rdi->qp_dev)
> -		return;

It is enough to delete these two lines. At this stage, rdi->qp_dev always
exists as it was created in rvt_register_device().

Thanks
