Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048CA578061
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiGRLD7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 07:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiGRLD5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 07:03:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476D06570;
        Mon, 18 Jul 2022 04:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05141B8111D;
        Mon, 18 Jul 2022 11:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3117EC341C0;
        Mon, 18 Jul 2022 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658142234;
        bh=EFa5qbZPRcqpYw9J5oxsXohxWl/hvq/z2A343vHh2Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jr8InTyk6FrYLBSagUXNLM5mimKkojJqZ/0IWY9ZiN/gv8fWvEy+f54RhWQ0k5OXz
         SVv8qFRN0BHFJH0eBgZUn7aH3XRLgCxui/mtlQEPJgQw8tQBsfP3bbgUHRFvLNcj6V
         vXw2iCcxFqmY6Yj/qNix8QNVny9EdpkI8gRyNlDzVZyBI/4aQo3FOlR8ELCb+QEejm
         PqdV6kj2Nf/dJokOMtKCpi0SGPla70olZIiMcOa7n/XZdwY7xUqxhu0S3OTPFFiK3D
         /aKkz3kW5HPAf3ydUvj247I0JhIcJgAMc712BGz6umZG/wnUmL8mQ0XAGdJARZXsvN
         8ezIWAbPlWLkg==
Date:   Mon, 18 Jul 2022 14:03:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     mkalderon@marvell.com, aelior@marvell.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/qedr: Fix potential memory leak in __qedr_alloc_mr()
Message-ID: <YtU+ETuEBVewKJQK@unreal>
References: <20220714061505.2342759-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714061505.2342759-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 14, 2022 at 02:15:05PM +0800, Jianglei Nie wrote:
> __qedr_alloc_mr() allocates a memory chunk for "mr->info.pbl_table" with
> init_mr_info(). When rdma_alloc_tid() and rdma_register_tid() fail, "mr"
> is released while "mr->info.pbl_table" is not released, which will lead
> to a memory leak.
> 
> We should release the "mr->info.pbl_table" with qedr_free_pbl() when error
> occurs to fix the memory leak.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Added fixes line.
Fixes: e0290cce6ac0 ("qedr: Add support for memory registeration verbs")

Thanks, applied.
