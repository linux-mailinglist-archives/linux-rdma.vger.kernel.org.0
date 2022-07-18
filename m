Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6996577CB7
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 09:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiGRHlu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 03:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGRHlu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 03:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D34518392
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 00:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB48361372
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 07:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A48C341C0;
        Mon, 18 Jul 2022 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658130108;
        bh=xmkHsMX1UwmPIe4yB49ixWjVx8JgaSHukymL8zyxFYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfkCOiBBytUr007Q+Mn/jF9GGOrcl4rrE6/dp6AhnVuSO5g8tYR/6RQRbc+7U8gzp
         vWaAQUtJy4u5QsKgnAHN42HFJ7Uyd4mnS9G/xybkZaf7+kPQQFbGFkPyyb8VbUNQWD
         yjBmHK79dGmCCd+1c8OWKxSoFCsKl0hzywh/UrLVXhG0lsVrq976KgjDZzWwqKXofU
         RhlFxZDM13uPqTasihIHzf3Nlaa+47/OKVjyZGoGMQeedkwkoBsJccKei9QMaTZi6p
         XhriurlxGvipNyAVgJeH6ag5WaiSbImrLHCjo3n42jbCg+xJ44tn/mC78l6aOJhPIO
         A4Tlgt0QE7Yuw==
Date:   Mon, 18 Jul 2022 10:41:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/7] irdma for-next updates 7-5-2022
Message-ID: <YtUOt48MpdNcGZrQ@unreal>
References: <20220705230815.265-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705230815.265-1-shiraz.saleem@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 05, 2022 at 06:08:08PM -0500, Shiraz Saleem wrote:
> This series adds level2 PBLE support, debug tracing and a few minor
> fixes for irdma.
> 
> Mustafa Ismail (6):
>   RDMA/irdma: Add 2 level PBLE support for FMR
>   RDMA/irdma: Add AE source to error log
>   RDMA/irdma: Make CQP invalid state error non-critical
>   RDMA/irdma: Fix a window for use-after-free
>   RDMA/irdma: Fix VLAN connection with wildcard address
>   RDMA/irdma: Fix setting of QP context err_rq_idx_valid field
> 
> Nayan Kumar (1):
>   RDMA/irdma: Make resource distribution algorithm more QP oriented
> 
>  drivers/infiniband/hw/irdma/cm.c    | 11 ++++++-----
>  drivers/infiniband/hw/irdma/ctrl.c  |  8 +++++---
>  drivers/infiniband/hw/irdma/hw.c    | 24 +++++++-----------------
>  drivers/infiniband/hw/irdma/main.h  |  2 +-
>  drivers/infiniband/hw/irdma/utils.c |  1 +
>  drivers/infiniband/hw/irdma/verbs.c | 16 ++++++++++++----
>  6 files changed, 32 insertions(+), 30 deletions(-)

Thanks, applied.

> 
> -- 
> 1.8.3.1
> 
