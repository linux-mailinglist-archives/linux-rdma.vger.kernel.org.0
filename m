Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34F7AE940
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 11:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjIZJbD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 05:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjIZJbC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 05:31:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA4712A;
        Tue, 26 Sep 2023 02:30:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD69C433C7;
        Tue, 26 Sep 2023 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695720649;
        bh=hj4oxhOkY4q3xTfX5ieHdoLzD+mLcLaLDO8XnC6wpXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kW10MjOWGXCIICnfagr6XcT9Im7CQZjdm9bT1IhfwzLWOa/brK9fo0al2Nmc3o1Wy
         ric8CucrtnCGkTXN/4oTdNdb5LlIwhyGyk1vbuy3RrP7vx9sUF37yKOmL7Nj3Ab8/0
         IenBaFbogr9fJvlk84kVZFmZ+INx8iIYrXC2yf0AHqK/7TORqZNvE33vqibQQib6Kt
         S1FgXH6p30FKqzbHsQduKb1hP7Xah1EwPhQrAsEZWBb3uPcDhpPhhXiTLyIlFoD/Du
         hjYM8vaaYJr+6/a9/+1QcixYCwGmRglkygFkWh7qtseYDHGqLlU8hUBuhXI6vMLUkd
         rxiNZhAs9wfoA==
Date:   Tue, 26 Sep 2023 12:30:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hns: Support SRQ record doorbell
Message-ID: <20230926093046.GG1642130@unreal>
References: <20230920033005.1557-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920033005.1557-1-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 11:30:05AM +0800, Junxian Huang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> Compared with normal doorbell, using record doorbell can shorten the
> process of ringing the doorbell and reduce the latency.
> 
> Add a flag HNS_ROCE_CAP_FLAG_SRQ_RECORD_DB to allow FW to
> enable/disable SRQ record doorbell.
> 
> If the flag above is set, allocate the dma buffer for SRQ record
> doorbell and write the buffer address into SRQC during SRQ creation.
> 
> For userspace SRQ, add a flag HNS_ROCE_RSP_SRQ_CAP_RECORD_DB to notify
> userspace whether the SRQ record doorbell is enabled.
> 
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  3 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 30 ++++++--
>  drivers/infiniband/hw/hns/hns_roce_srq.c    | 85 ++++++++++++++++++++-
>  include/uapi/rdma/hns-abi.h                 | 13 +++-
>  4 files changed, 120 insertions(+), 11 deletions(-)

Junxian, do you plan to resubmit it this patch to fix kbuild error?

Thanks
