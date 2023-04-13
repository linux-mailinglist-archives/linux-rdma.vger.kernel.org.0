Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D16E08DB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 10:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDMIXZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 04:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDMIXX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 04:23:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8551E2108
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 01:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12C7660FE9
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 08:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC87BC433EF;
        Thu, 13 Apr 2023 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681374200;
        bh=8ec1Al50JnTZKeDp/xxUF8SUV1sK6hDXf7qby6d3BHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYV8H853M0W1kBieY+hNG0KySf5bFfvVsDrJCjOL+973lLPugjKaLug7yeJ6n0tKO
         sTybN7OWStnb0Ss+hC13N02EjwxarqIIn5gGBwKFttGRf8XTbeJL1HvyERZGZ1l/43
         tSIpBlo9NbK4cBy9yYH3SsDx/DFXusVivZTMqXt/rj1TEzc54ZSybZiBWqDXCJ3ucu
         2/22VXKylrSxsud9fYq2xflxTP2Y2YVkvdqftAIdBuXww1O3quAPxKUhdsTiKFgOCF
         7Hif7Z5sJj29oZn1iUxE0ppGw99Wl6rQ7BJoapQ+qm8wu+CZFYKFvzCVCdgqR8xPxU
         PxlOMnEMFTlsQ==
Date:   Thu, 13 Apr 2023 11:23:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix the error "trying to register
 non-static key in rxe_cleanup_task"
Message-ID: <20230413082316.GC17993@unreal>
References: <20230404063848.3844292-1-yanjun.zhu@intel.com>
 <29d0ab8c-1ea4-bbce-120b-82c390b56a6f@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29d0ab8c-1ea4-bbce-120b-82c390b56a6f@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 11:08:15PM +0800, Zhu Yanjun wrote:
> 在 2023/4/4 14:38, Zhu Yanjun 写道:
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > 
> > In the function rxe_create_qp(), rxe_qp_from_init() is called to
> > initialize qp, internally things like rxe_init_task are not setup until
> > rxe_qp_init_req().
> > 
> > If an error occures before this point then the unwind will call
> > rxe_cleanup() and eventually to rxe_qp_do_cleanup()/rxe_cleanup_task()
> > which will oops when trying to access the uninitialized spinlock.
> > 
> > If rxe_init_task is not executed, rxe_cleanup_task will not be called.
> > 
> > Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?id=fd85757b74b3eb59f904138486f755f71e090df8
> > 
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Fixes: 2d4b21e0a291 ("IB/rxe: Prevent from completer to operate on non valid QP")
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > ---
> > V1 -> V2: Remove memset functions;
> 
> Gently ping

It doesn't apply to rdma-next.

Thanks
