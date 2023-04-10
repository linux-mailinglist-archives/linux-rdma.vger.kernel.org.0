Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FE76DC6CD
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 14:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDJMcT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 08:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDJMcR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 08:32:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB8A4C02
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 05:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E76F6187C
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 12:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C336C433EF;
        Mon, 10 Apr 2023 12:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681129935;
        bh=uzS0qSF6dqRy16e1KT545Kw1rLRPqW+pyytU/tpjWVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tE0d64e6rr+n8ftb01F6TvoFxlIkREpC/b87r9rx2bGs1ssX4221jGKhRs3y7h2Du
         ryYhSLqYEBO/2PC1Z3Hw897/Tk/CVq8MpmYMg0LjUXVjQ1xPaes/J9OxvNKSORMNoR
         k0HCIoo5f2tEgi0HzRsy5/+FoMOWLUw4PjMJl0Y+q4iSs19Z/vxzktblJooomDx0xt
         wAfsAcOla8sEAPzjguACTXoqx15hxc9w5E04i0r8+Ozamcp/2wr6ZW1VzdaQg6bX54
         c+gO9gjMOAzwYLSj3252O2b59iqkaWCay4yGe0NtHNBwmTRzOTqeQ4gi6n5u977e+8
         7aTssw6yYAa3g==
Date:   Mon, 10 Apr 2023 15:32:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next 0/6] RDMA/bnxt_re: driver update for supporting
 low latency push
Message-ID: <20230410123211.GS182481@unreal>
References: <1681125115-7127-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681125115-7127-1-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 04:11:49AM -0700, Selvin Xavier wrote:
> The series aims to add support for Low latency push path in
> some of the bnxt devices. The low latency implementation is
> supported only for the user applications. Also, the code
> is modified to use  common mmap helper functions exported
> by IB core. 

What does it mean "low latency push"?

Thanks

> 
> User library changes are added in the pull request
> https://github.com/linux-rdma/rdma-core/pull/1321
> 
> Please review.
> 
> Thanks,
> Selvin Xavier
> 
> Selvin Xavier (6):
>   RDMA/bnxt_re: Use the common mmap helper functions
>   RDMA/bnxt_re: Add disassociate ucontext support
>   RDMA/bnxt_re: Query function capabilities from firmware
>   RDMA/bnxt_re: Move the interface version to chip context structure
>   RDMA/bnxt_re: Reorg the bar mapping
>   RDMA/bnxt_re: Enable low latency push
> 
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 160 +++++++++++++++++++++---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h   |  17 +++
>  drivers/infiniband/hw/bnxt_re/main.c       | 123 +++++++++++++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  14 +--
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |   2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   1 +
>  drivers/infiniband/hw/bnxt_re/qplib_res.c  | 192 +++++++++++++++++++----------
>  drivers/infiniband/hw/bnxt_re/qplib_res.h  |  33 +++--
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c   |   3 +
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h   |   1 +
>  include/uapi/rdma/bnxt_re-abi.h            |   9 ++
>  11 files changed, 449 insertions(+), 106 deletions(-)
> 
> -- 
> 2.5.5
> 


