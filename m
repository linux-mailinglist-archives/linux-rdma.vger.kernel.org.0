Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E586E0AFA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 12:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDMKCC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 06:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDMKCC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 06:02:02 -0400
Received: from out-3.mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8F39775
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 03:01:55 -0700 (PDT)
Message-ID: <c9094ba1-cca7-8044-76d3-f9013ee82086@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681380113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJtpwbnmtG3NbONejB5UCivPKB8u1jnxl/8POpR71k4=;
        b=B6BNsnDs0b14f/73hiUUBf6yGifdkYWFAeiUhudHbnKfGAKrMLKSGe/l4RGCHk+NX0yZBy
        pfXvsRsr/5cP/0fYlx8lEBhuvxG1kVpWGMYa68rf19AEH37MP9vCs5H7mzwE8QlHqhMvg2
        F69RX0bZv0PZJGqHSO8nwUpxKjAlgNM=
Date:   Thu, 13 Apr 2023 18:01:48 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix the error "trying to register
 non-static key in rxe_cleanup_task"
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
References: <20230404063848.3844292-1-yanjun.zhu@intel.com>
 <29d0ab8c-1ea4-bbce-120b-82c390b56a6f@linux.dev>
 <20230413082316.GC17993@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230413082316.GC17993@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/4/13 16:23, Leon Romanovsky 写道:
> On Mon, Apr 10, 2023 at 11:08:15PM +0800, Zhu Yanjun wrote:
>> 在 2023/4/4 14:38, Zhu Yanjun 写道:
>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>
>>> In the function rxe_create_qp(), rxe_qp_from_init() is called to
>>> initialize qp, internally things like rxe_init_task are not setup until
>>> rxe_qp_init_req().
>>>
>>> If an error occures before this point then the unwind will call
>>> rxe_cleanup() and eventually to rxe_qp_do_cleanup()/rxe_cleanup_task()
>>> which will oops when trying to access the uninitialized spinlock.
>>>
>>> If rxe_init_task is not executed, rxe_cleanup_task will not be called.
>>>
>>> Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
>>> Link: https://syzkaller.appspot.com/bug?id=fd85757b74b3eb59f904138486f755f71e090df8
>>>
>>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>>> Fixes: 2d4b21e0a291 ("IB/rxe: Prevent from completer to operate on non valid QP")
>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>> ---
>>> V1 -> V2: Remove memset functions;
>> Gently ping
> It doesn't apply to rdma-next.

The latest commit is based on rdma-next: 
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git

Branch: remotes/origin/wip/leon-for-next

Thanks,

Zhu Yanjun

>
> Thanks
