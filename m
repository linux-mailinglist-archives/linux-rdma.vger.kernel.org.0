Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D470E4A9
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjEWS2W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 May 2023 14:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbjEWS2V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 May 2023 14:28:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8208A8F
        for <linux-rdma@vger.kernel.org>; Tue, 23 May 2023 11:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F177632B4
        for <linux-rdma@vger.kernel.org>; Tue, 23 May 2023 18:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D9BC4339B;
        Tue, 23 May 2023 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684866499;
        bh=whVz3CRsD3wwwzUZWpPeMCHSk27FLUf7aoxGz/4IABE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOll17MhgP6cz5AQPKcFmni9DHNr8S6ngjHpITn2CVequbxcJ5y2B8pIX6t4vbmca
         W7u4KdhZOUCgbzcJ7l3gJ6Q5WkwgID5dpFw239z+pAdwMY/RbSMmDLJ1ZDKZHXBhN3
         udHtDmuAVjYX8QAG4MzMgbP8BjwsktA8Y4HNGtpxl7jl5FljBahS76JtrVPEz3Z+uc
         GCEmTDNvTYnwBahDGAkegTwizSaczNJVqtRUZMDeIWILKghdzy9cY7SmUqwTaSH5FZ
         nlVsY5mdmwjlSPVeAA+ptA0KPlm48ERCL0vIrFK9qkOnGQrk9C4qVmQk2E+bDCTPQC
         tLvBepmwDz0ow==
Date:   Tue, 23 May 2023 21:28:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, parav@mellanox.com
Subject: Re: [PATCH] Revert "IB/core: Fix use workqueue without
 WQ_MEM_RECLAIM"
Message-ID: <20230523182815.GA2384059@unreal>
References: <20230523155408.48594-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523155408.48594-1-mlombard@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 23, 2023 at 05:54:08PM +0200, Maurizio Lombardi wrote:
> when nvme_rdma_reconnect_ctrl_work() fails, it flushes
> the ib_addr:process_one_req() work but the latter is enqueued
> on addr_wq which has been marked as "!WQ_MEM_RECLAIM".
> 
> workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
> [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]

And why does nvme-wq need WQ_MEM_RECLAIM flag? I wonder if it is really
needed.

Thanks
