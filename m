Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A63E75783A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 11:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGRJkh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 05:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjGRJkg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 05:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D34FE55
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 02:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32D976148E
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 09:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05904C433C7;
        Tue, 18 Jul 2023 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689673231;
        bh=UUG0pWqPOPAXabGgVF1Ytb5r7tDsGH9qe0aQKsrWsFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4PJ6udNCcIVYHeykc15p6fZS8RD8Y1Z1ecz6Jd4wOkC/QKPuyF9jqOsEjZwK66CY
         iTtGRO7na4ZwmfJqcGykLoymZEOVT/hCd8MdgZ2MyzqdXFH/P/4ZurKF3G/tQf688p
         WJUrJRdYF0TF2csaxLn1ZiYir5shUBklUyj5OkHxE8A1oSmOEh1UfDzcQwFqY5Gqd/
         hQB441iqPv8+jHiv9/aZuWxzHl0KrXQxXtJmBLGusSwaUC14S7TMZK7/v9yz96KRTi
         zomabcDsEJfNEz01t+YRE9hlunI72OkefP0pZwxhR8zcQQNxoCg3zaE/dzTbvmwmz7
         hdd7Ne/3YHavw==
Date:   Tue, 18 Jul 2023 12:40:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        michael.chan@broadcom.com
Subject: Re: [PATCH for-next v2 0/7]RDMA/bnxt_re: Doorbell Drop Prevention
Message-ID: <20230718094027.GB8808@unreal>
References: <1689573194-27687-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689573194-27687-1-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 16, 2023 at 10:53:07PM -0700, Selvin Xavier wrote:
> The idea behind this series is to prevent Doorbell drops
> on some of the Broadcom adapters that require Doorbell
> moderation. This is achieved by pacing the doorbell writes
> into the hardware FIFO. The rate at which individual doorbells
> are written needs to be dynamically adjusted, because
> it depends on the ability of the hardware to drain the
> FIFO and on the number and behavior of individual
> doorbell writers. When congestion is detected by the user
> library, it notifies the driver and driver adjust the
> pacing parameters dynamically in a shared page, which will
> be used for pacing the Doorbells.
> 
> Currently this feature is targeted only for user applications.
> The corresponding user lib patch is in the pull request.
> https://github.com/linux-rdma/rdma-core/pull/1360
> 
> Thanks,
> Selivn
> 
> v1 -> v2:
>      Rebased the patches on top of the latest for-next branch
> 
> Chandramohan Akula (7):
>   bnxt_en: Update HW interface headers
>   bnxt_en: Share the bar0 address with the RoCE driver
>   RDMA/bnxt_re: Initialize Doorbell pacing feature
>   RDMA/bnxt_re: Enable pacing support for the user apps
>   RDMA/bnxt_re: Update alloc_page uapi for pacing
>   RDMA/bnxt_re: Implement doorbell pacing algorithm
>   RDMA/bnxt_re: Add a new uapi for driver notification

Jason, any comments?

Thanks

> 
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h       |  27 ++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  51 +++++-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h      |   2 +
>  drivers/infiniband/hw/bnxt_re/main.c          | 220 ++++++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_res.h     |  19 +++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h |  54 +++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |   2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   1 +
>  include/uapi/rdma/bnxt_re-abi.h               |   7 +
>  9 files changed, 379 insertions(+), 4 deletions(-)
> 
> -- 
> 2.5.5
> 


