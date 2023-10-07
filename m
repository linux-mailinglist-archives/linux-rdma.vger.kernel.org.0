Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420CE7BC355
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Oct 2023 02:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjJGAfV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Oct 2023 20:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjJGAfV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Oct 2023 20:35:21 -0400
Received: from out-209.mta1.migadu.com (out-209.mta1.migadu.com [95.215.58.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE9BE
        for <linux-rdma@vger.kernel.org>; Fri,  6 Oct 2023 17:35:20 -0700 (PDT)
Message-ID: <ee0b7977-d063-fe58-f185-4f94a1d7a3be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696638918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7EoxSVEJ+4nAFhC40ohlMd/5tFA0h9o6GJHu0CkfzY=;
        b=ZRAziit/O59bcfCl4hoiABGiBGS047E5XyjLt65PxNYCs5vWbp1Z4+YtBOh/60ShyeqVWR
        D7s0fOD05WKDlB+wwOT5mXLhFO814Wpy5PxGvbYSFDrV82qjV7SGVt+hY7N1xhZYv56Zh3
        diEGJrIa3NIkyShtHZInqyAgcR5SKD8=
Date:   Sat, 7 Oct 2023 08:35:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, matsuda-daisuke@fujitsu.com,
        shinichiro.kawasaki@wdc.com, linux-scsi@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@intel.com>
References: <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <20231005155616.GR13795@ziepe.ca>
 <93c8ad67-f008-4352-8887-099723c2f4ec@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <93c8ad67-f008-4352-8887-099723c2f4ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/10/6 23:58, Bob Pearson 写道:
> On 10/5/23 10:56, Jason Gunthorpe wrote:
>> On Thu, Oct 05, 2023 at 07:50:28AM -0700, Bart Van Assche wrote:
>>> On 10/5/23 07:21, Jason Gunthorpe wrote:
>>>> Which is why it shows there are locking problems in this code.
>>> Hi Jason,
>>>
>>> Since the locking problems have not yet been root-caused, do you
>>> agree that it is safer to revert patch "RDMA/rxe: Add workqueue
>>> support for rxe tasks" rather than trying to fix it?
>> I don't think that makes the locking problems go away any more that
>> using a single threaded work queue?
>>
>> Jason
> This is slightly off topic but may still be relevant.
> If there are locking bugs they are between the two send side tasks
> rxe_completer and rxe_requester which share the send queue and other
> state. Bart attempts to fix this by setting max_active to 1 which
> limits the ability of these two work queue tasks from interfering.
> For completely different reasons we have looked at merging these
> two tasks into a single task which it turns out improves performance,
> especially in high scale situations where it reduces the number of
> cpu cores needed to complete work. But even at low scale (1-2 QPs)
> it helps because of improved caching. It turns out that if the work
> is mostly sends and writes that there isn't much for the completer
> to do while if it is mostly reads there isn't much for the requester
> to do. So combining them doesn't hurt performance by having fewer cores
> to do the work. But this also prevents the two tasks for a given QP
> to run at the same time which should eliminate locking issues.
> If no one hates the idea I can send in our patch that does this.

Hi, Bob

The blktest hang problem is not fixed now. I do not think that it is a 
good time

to introduce this new feature.

IMHO, we should fix this blktest hang problem. And we also need some time to

wait for the test results from the users. If this problem proves fixed. 
Then we have a

stable RXE version for the new feature from you.

In short, we need a stable RXE version for use. Then based on the stable 
RXE version,

new features are welcomed.

Please let me know your advice.

Please Bart comment on this.

Please Jason && Leon comment on this.

Warm Regards,

Zhu Yanjun

>
> Bob
