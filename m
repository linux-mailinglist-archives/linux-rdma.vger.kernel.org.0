Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109476B8F1F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Mar 2023 11:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCNKAa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Mar 2023 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCNKA2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Mar 2023 06:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846A3302AF
        for <linux-rdma@vger.kernel.org>; Tue, 14 Mar 2023 03:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B65B2616DF
        for <linux-rdma@vger.kernel.org>; Tue, 14 Mar 2023 10:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E93C433EF;
        Tue, 14 Mar 2023 10:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678788014;
        bh=F7gVEGUKdlKF4tP0jO26lptZTVhyL35LgyB4eK7UTWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIEqAx5ECrlFBWpY01Eq/Rb+jtRz6H7m6L5rlplf2l+WH+qfkjt9Viu2ipcJPLnGL
         wVfl0WAYlK3oaUTwbPy235WiDXES7FltRQiAjM6zOiRmAHKwSWFu23AcCxyHxGF2Wy
         Gx43GqwfmNZQDy/37KPDF2aW6c7YADVP4gR0mOmZFe4DtHzOJAttuIWr4i+Wz7d83q
         Gpywq4AaJgI7UrrY2fyBOo9kwChx5v0TSYtIA8PKJNs5cb3s/bt+jeuNUYF/aKrYfi
         KDB8M6Zt4Uj7uNIdSsGTf02/d3nUBtsc8h6U45ro6QG8WUWRx2xi2liZyBSoECz25K
         muuClqiJ+XAFw==
Date:   Tue, 14 Mar 2023 12:00:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/2] Support query vf caps
Message-ID: <20230314100005.GA36557@unreal>
References: <20230304091555.2241298-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304091555.2241298-1-xuhaoyue1@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 04, 2023 at 05:15:53PM +0800, Haoyue Xu wrote:
> VF originally used default caps in the driver.
> The patchset add a command to query the VF's caps,
> which makes it more extensible.
> 
> Yixing Liu (2):
>   RDMA/hns: Add new cmq command to support query vf caps
>   RDMA/hns: remove set_default function

I squashed these two commits into one and applied.

Thanks

> 
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 191 ++++++---------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  37 +---
>  2 files changed, 61 insertions(+), 167 deletions(-)
> 
> -- 
> 2.30.0
> 
