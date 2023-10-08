Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C620B7BCF3A
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Oct 2023 18:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjJHQBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Oct 2023 12:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjJHQBy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Oct 2023 12:01:54 -0400
Received: from out-198.mta1.migadu.com (out-198.mta1.migadu.com [IPv6:2001:41d0:203:375::c6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F163B6
        for <linux-rdma@vger.kernel.org>; Sun,  8 Oct 2023 09:01:52 -0700 (PDT)
Message-ID: <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696780910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKcOyrJkVaJ/xvKnkD831klpEkDx4Y+SEx+7tM+0dR4=;
        b=gWBsvWXU2F/Io3LrTAq9PjFmfQsfLB3K0FCTQkdDxSEqQoj3CSC98d3arD+X8E4mb8z0km
        +/Z9uaY4m1v8KVucje5HJIDus0FaZmdSQUWlRug9nF1xEkQE8ATNC/yDC0Y5dtyY9iPhXk
        i9RkpxVnDpHWCx6o53948u9FMZ8o8hs=
Date:   Mon, 9 Oct 2023 00:01:37 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, matsuda-daisuke@fujitsu.com,
        shinichiro.kawasaki@wdc.com, linux-scsi@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@intel.com>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/10/5 22:50, Bart Van Assche 写道:
> On 10/5/23 07:21, Jason Gunthorpe wrote:
>> Which is why it shows there are locking problems in this code.
> 
> Hi Jason,
> 
> Since the locking problems have not yet been root-caused, do you
> agree that it is safer to revert patch "RDMA/rxe: Add workqueue
> support for rxe tasks" rather than trying to fix it?

Hi, Jason && Leon

I spent a lot of time on this problem. It seems that it is a very 
difficult problem.

So I agree with Bart. Can we revert patch "RDMA/rxe: Add workqueue
support for rxe tasks" rather than trying to fix it? Then Bob can apply 
his new patch to a stable RXE?

Any reply is appreciated.
Warm Regards,

Zhu Yanjun

> 
> Thanks,
> 
> Bart.

