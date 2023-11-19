Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82677F063C
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Nov 2023 14:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjKSNA3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Nov 2023 08:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSNA3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Nov 2023 08:00:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA51B9
        for <linux-rdma@vger.kernel.org>; Sun, 19 Nov 2023 05:00:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EFAC433C7;
        Sun, 19 Nov 2023 13:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700398825;
        bh=tT38lcuudWoIVI0o1aNdlw5o8c25w7Ntwtl3Ugiulyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2Y0cNyb1HsDcoz4/u014SyrV+2NZ4HeBc0ifmWByM6DF7GG74d06iT+CXjP3gu8M
         sO+7mtFhUdquk83DtU6uHo8lndrbeblYmYjODmKcTLFw0x49yLIG/fyw3ZqirXZPSh
         Dwc+4znZjJXfYPijk7wn/AYYqiZ2XgZL0lmnv5ESihwuLj8l0MZTLSiv52Cj9hd3fX
         RO2jGGhMTUTqg/62WN3EmXiVtgD+LBPuzCG78OMwoeYnn/0EoloOKYcQMSaAoCY7Hx
         L40qbnXgX6C4JnnGVaQ3I6UKVvEx39geBZsn6rUbmCGh7m5NBRatCSHDlHL9DBcRF3
         U6z+Zaqn+VNVw==
Date:   Sun, 19 Nov 2023 15:00:21 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
        jinpu.wang@ionos.com
Subject: Re: [PATCH for-next 0/9] Misc patches for RTRS
Message-ID: <20231119130021.GA15293@unreal>
References: <20231115152749.424301-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115152749.424301-1-haris.iqbal@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 15, 2023 at 04:27:40PM +0100, Md Haris Iqbal wrote:
> Hi Jason, hi Leon,
> 
> Please consider to include following changes to the next merge window.
> 
> Jack Wang (4):
>   RDMA/rtrs-srv: Do not unconditionally enable irq
>   RDMA/rtrs-clt: Start hb after path_up
>   RDMA/rtrs-clt: Fix the max_send_wr setting
>   RDMA/rtrs-clt: Remove the warnings for req in_use check
> 
> Md Haris Iqbal (4):
>   RDMA/rtrs-clt: Add warning logs for RDMA events

All these patches, except this one, fix errors and should have Fixes line.
Please add and resubmit.

I took this warning patch to -next.

Thanks

>   RDMA/rtrs-srv: Check return values while processing info request
>   RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
>   RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight
> 
> Supriti Singh (1):
>   RDMA/rtrs: use %pe to print errors
> 
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 15 ++++++-----
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 37 +++++++++++++++++++-------
>  drivers/infiniband/ulp/rtrs/rtrs.c     |  4 +--
>  3 files changed, 37 insertions(+), 19 deletions(-)
> 
> -- 
> 2.25.1
> 
