Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417855A4FBA
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 16:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiH2O7z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiH2O7y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 10:59:54 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3201103
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 07:59:48 -0700 (PDT)
Message-ID: <2b9ad96e-0e33-b322-4dcf-74c6bedfab5a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661785186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=srTXSMXqUosucb1Btda2Umea7eFN3qgXjhCpGlWamKw=;
        b=YVGEV0uTLlsZm820K1xGL3v26uZ74vK6umD/TAFLS6blgJhOyaqIRn/XeebhcN7FZv6CPD
        Vox0DrxSW5e1YB4Z7gjfYUXOGzk+bbCxgu27J8oViGLkhS8O4Yr3KGBRE6lxVuQmL8U+08
        w5zgigkcQaHVus9NUHrRV/lu4/VsEuE=
Date:   Mon, 29 Aug 2022 22:59:36 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Fixes for syzbot problem
To:     yanjun.zhu@linux.dev, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
References: <20220822011615.805603-1-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220822011615.805603-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/8/22 9:16, yanjun.zhu@linux.dev 写道:
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

Gently ping

Zhu Yanjun

>    RDMA/rxe: Fix "kernel NULL pointer dereference" error
>    RDMA/rxe: Fix the error caused by qp->sk
>    RDMA/rxe: Remove the unused variable obj
> 
>   drivers/infiniband/sw/rxe/rxe_qp.c   | 16 ++++++++++------
>   drivers/infiniband/sw/rxe/rxe_task.c |  3 +--
>   drivers/infiniband/sw/rxe/rxe_task.h |  3 +--
>   3 files changed, 12 insertions(+), 10 deletions(-)
> 

