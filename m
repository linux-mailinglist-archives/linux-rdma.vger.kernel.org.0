Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306DF663E9B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 11:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjAJKxq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Jan 2023 05:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjAJKxo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Jan 2023 05:53:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9591F4
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 02:53:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1F1AB810FB
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 10:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD9EC433EF;
        Tue, 10 Jan 2023 10:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673348021;
        bh=JwyNWGYuRuYRjY9QT2xtvaBtz6NSNDn7SRay2D5+ICI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W+Wl+k1YsQYIyTb83zM7UR2ea7qKQm+jTOBRDtdT3WBTTVfbFHhkE0D0OWQkhBw0H
         ewIBnB7PmwQ5Bi3WElZm4FbtsFA1pZbTK2CxvEHaf74pEv3jvCJz1KPKe6HPE8wPJZ
         +w5iBPmDxRcCFN/WVhazAApxd7CHvsaHQUwGsA8++27XfnGbY6xiTgui9GLF73SMT2
         8gBJS1N2Z2g52MOOxWMYttw1c7Rsl7cIzI1c0cxdyq94sLJhDXyvTMhd0daYnRdsow
         KickAyhkmOoapdWP56S7laCg2YMhWcCkN5yV/h2KWS0bUqijDm1CsMeU91cUAy1Uux
         egb3bbznh6ciQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
In-Reply-To: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Message-Id: <167334801632.1195631.9755973420734035366.b4-ty@kernel.org>
Date:   Tue, 10 Jan 2023 12:53:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 09 Jan 2023 14:03:58 -0500, Dennis Dalessandro wrote:
> Dean fixes the FIXME that was left by Jason in the code to use the interval
> notifier. There are also fixes for other things like splitting our counter
> allocation to better align with the way the core is moving.
> 

Applied, thanks!

[1/7] IB/hfi1: Remove redundant pageidx variable
      https://git.kernel.org/rdma/rdma/c/3c49eef3897822
[2/7] IB/hfi1: Assign npages earlier
      https://git.kernel.org/rdma/rdma/c/a479433a6b7a2b
[3/7] IB/hfi1: Consolidate the creation of user TIDs
      https://git.kernel.org/rdma/rdma/c/d8f4ab01c6d0d5
[4/7] IB/hfi1: Improve TID validity checking
      https://git.kernel.org/rdma/rdma/c/845127ed8717e0
[5/7] IB/hfi1: Split IB counter allocation
      https://git.kernel.org/rdma/rdma/c/ef90f0a1913e8b
[6/7] IBh/hfi1: Update RMT size calculation
      https://git.kernel.org/rdma/rdma/c/131268e2558f1f
[7/7] IB/hfi1: Use dma_mmap_coherent for matching buffers
      https://git.kernel.org/rdma/rdma/c/5d3fcb45a374a7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
