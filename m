Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E3D5A76F2
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 08:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiHaGyX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 02:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHaGyW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 02:54:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD1ABB01B
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 23:54:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D816B81F61
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 06:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39DEC433D6;
        Wed, 31 Aug 2022 06:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661928859;
        bh=qEnxYQyfeHARz5MOn49pXKWsf4/1gEGDy+HQhQc9dBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxA4kjP0KrKHhXOeoTds9rvmwJDWH6ujx9zmzxyD6Nqh9wFOGznZdHdMb5LIIwqVT
         Dt+vEm0g+av7fXK4uXP0LtrHPBI46TA42/w723cCvYOJiS18xvjet3Ey1E3pWObaR3
         rGFmxU+7J0TD918vW1UPwnLgfo6gnAuqNh/iRnQBA754rzgFaTllLs23ojiE1lv0A2
         6jkqJQKMFwxqWu6l9A5kNVJ5kWZu9iUuqwGGK17rgKszOM98ItFytoP+u/ghXb4U8q
         bFpIl+AISCZvtLCei8cHlSGOF46cC+UGYsZHuz3+0+d1tPbTM+Jo9ntMEYYl/yaqsi
         t0sdrDzMVPFOQ==
Date:   Wed, 31 Aug 2022 09:54:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Subject: Re: [PATCH 0/3] Fixes for syzbot problem
Message-ID: <Yw8FlnMX/7dC2emP@unreal>
References: <20220822011615.805603-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822011615.805603-1-yanjun.zhu@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 21, 2022 at 09:16:12PM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> In the link:
> 
> https://syzkaller.appspot.com/bug?id=3efca8275142fbfdde6cf77e1b18b1d5c6794d76
> 
> a rxe problem occurred. I tried to reproduce this problem in local hosts.
> Finally I could reproduce this problem in local hosts.
> The commit ("RDMA/rxe: Fix "kernel NULL pointer dereference" error") tries to
> fix this problem.
> 
> After this syzbot problem disappeared, another problem appeared
> when qp->sk failed to initialized.
> The commit ("RDMA/rxe: Fix the error caused by qp->sk") tries to solve
> this problem.
> 
> When I delved into the source code to solve the above problems, I found
> that the member variable obj in struct rxe_task is not needed. So the
> commit ("RDMA/rxe: Remove the unused variable obj") removes this
> variable obj.
> 
> After the 3 commits, in locat hosts, the whole system can work well.
> 
> Zhu Yanjun (3):
>   RDMA/rxe: Fix "kernel NULL pointer dereference" error
>   RDMA/rxe: Fix the error caused by qp->sk
>   RDMA/rxe: Remove the unused variable obj

Thanks, applied to -next with applied suggestion from Bob.
