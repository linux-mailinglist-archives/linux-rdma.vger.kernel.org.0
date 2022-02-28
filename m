Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C44C6B93
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 13:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiB1MEP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 07:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiB1MEN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 07:04:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999D217E28
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 04:03:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51F1CB810DD
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 12:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596DAC340E7;
        Mon, 28 Feb 2022 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646049811;
        bh=9k/FnKTQLs1S4cL2qQUWXcb8Ln4mL5VTA6pMZ4qFmU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jovdFk6ipzUckRuU8P3YR1x1XUfLY0mS4lNUyx+easlTbUfybnz46tluGF6hdrkO2
         KGYSyqO7BqY5bdwoMPV8/mVeU7OWUrTeggJq1tNWdiGITLTL+8057xbRaYblf94x7I
         1l0LdTWGGoIwfwmVgec50euC4OFvI8cThc7gRKFvqllwqUQOcE2UCAEHb7UIT89CFm
         FMu3gTWmyJ6dt57IAy0MglbxTvOPNlPdCKRGTJLIGwsvSu2vZoOVpYZDMfmeDBfoWd
         4JCWt/wjJrBAUT7T3c2Sl00f5Oi6J8Tk1+PCyKWVZ/G6eDmxR5gRJe68t2gVuEz2PK
         BcExGCa3Drvmg==
Date:   Mon, 28 Feb 2022 14:03:28 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 5/9] RDMA/hns: Refactor mailbox functions
Message-ID: <Yhy6ENF7epAa/FGs@unreal>
References: <20220225112559.43300-1-liangwenpeng@huawei.com>
 <20220225112559.43300-6-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225112559.43300-6-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 25, 2022 at 07:25:55PM +0800, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> The current mailbox functions have too many parameters, making the code
> difficult to maintain. So construct a new structure mbox_msg to pass the
> information needed by mailbox.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cmd.c      |  73 ++++++------
>  drivers/infiniband/hw/hns/hns_roce_cmd.h      |   2 +-
>  drivers/infiniband/hw/hns/hns_roce_cq.c       |   9 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h   |  14 ++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 111 +++++++++---------
>  .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |   4 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c       |  13 +-
>  drivers/infiniband/hw/hns/hns_roce_srq.c      |   6 +-
>  8 files changed, 120 insertions(+), 112 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
