Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75D25BE531
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 14:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiITMEv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 08:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiITMEt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 08:04:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001E63A4
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 05:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77D5EB80E63
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 12:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C007BC433D6;
        Tue, 20 Sep 2022 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663675485;
        bh=aL5OK1WtviB966Iv1pwtG7mA2NkR4hznGuQQ4Fo5F6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUKTVXv4CSLMVQikixAM0Y5QekzfgRyaXtrWAAHnklmA6mGCzgefes5ot8is7M5GH
         Yi33DpkAQukmFqr7VRmLKQ4tjqYKLgIU97IXMfC+mPH52dPuavyrHtBrs398apdGkF
         ZpTDiTWQhLBs/Rw9rnX9zJjSrq6UJkPj4GKNoHVgu7rdfQkriA8LqhrrOQid9HD8JV
         UM9QiShhhW9dncpBpL20O3bDuOu9G2N8ggPkhzkqsL3cgnpB16nQpzMTyMCZ5NVEVO
         o+Zm8z9HGcTmVHt9TrE4ZNOri1lgYnXHu2cNwVucQLyUndPPbvEtVWjDfCogOFEIyS
         fgghHo3hxc0ZA==
Date:   Tue, 20 Sep 2022 15:04:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2 0/3] misc changes for rtrs
Message-ID: <YymsWfTQVKN5Grhj@unreal>
References: <20220908094548.4115-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908094548.4115-1-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 08, 2022 at 05:45:45PM +0800, Guoqing Jiang wrote:
> Hi,
> 
> Pls review the three patches.
> 
> Thanks,
> Guoqing
> 
> V2 changes:
> 1. fix compile warnings in the third patch
> 2. collect tag from Haris, thanks!
> 
> Guoqing Jiang (3):
>   RDMA/rtrs: Update comments for MAX_SESS_QUEUE_DEPTH

This patch doesn't apply.

>   RDMA/rtrs-clt: Break the loop once one path is connected
>   RDMA/rtrs-clt: Kill xchg_paths
> 
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 19 ++++++-------------
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  7 +++----
>  2 files changed, 9 insertions(+), 17 deletions(-)
> 
> -- 
> 2.31.1
> 
