Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE867B9EDB
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 16:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjJEOOm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 10:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjJEOMw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 10:12:52 -0400
Received: from out-207.mta1.migadu.com (out-207.mta1.migadu.com [IPv6:2001:41d0:203:375::cf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB79AA26F
        for <linux-rdma@vger.kernel.org>; Thu,  5 Oct 2023 02:25:55 -0700 (PDT)
Message-ID: <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696497937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/XbE8gP0R5n5VOgy0224cCsYOet41U373eOZr5Idw8=;
        b=PRoEAk6RYEcN6+72/6ZuSklLwRz/qUwiSpgtJxplv8LhZFN//iHB1hi6qRoGlxpNdfsT3+
        X/2YlXgOJrk9oX3a6nqMpLBJLkO/NQ0kf00CSKxr1FfIZ6xBEK/vm575ZKlRfGRiFp1jhp
        U6wyvUBCjXNDSY+mDNhp7v+2OIXWUUc=
Date:   Thu, 5 Oct 2023 17:25:29 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231004183824.GQ13795@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/10/5 2:38, Jason Gunthorpe 写道:
> On Wed, Oct 04, 2023 at 10:43:20AM -0700, Bart Van Assche wrote:
> 
>> Thank you for having reported this. I'm OK with integrating the
>> above change in my patch. However, code changes must be
>> motivated. Do you perhaps have an explanation of why WQ_HIGHPRI
>> makes the issue disappear that you observed?
> 
> I think it is clear there are locking bugs in all this, so it is not
> surprising that changing the scheduling behavior can make locking bugs
> hide
> 
> Jason

With the flag WQ_HIGHPRI, an ordered workqueue with high priority is 
allocated. With this workqueue, to now, the test has run for several 
days. And the problem did not appear. So to my test environment, this 
problem seems fixed with the above commit.

I doubt, without the flag WQ_HIGHPRI, the workqueue is allocated with 
normal priority. The work item in this workqueue is more likely 
preempted than high priority work queue.

Best Regards,
Zhu Yanjun
