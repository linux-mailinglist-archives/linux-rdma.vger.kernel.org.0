Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87FE51FD29
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 14:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiEIMqe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 08:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiEIMqe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 08:46:34 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77671F15B1
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 05:42:39 -0700 (PDT)
Message-ID: <5f6d0da2-6f24-9e5c-0240-e4e486c73348@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652100158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ck7LunAuYmgYphLfBrXVcCYo0OYHDiUz3XuOzRaVk9c=;
        b=LvHfUFfskHgaci6MyRGujuADCgdJ0+sktqoFL3woIx6op4d8z3mquEwIEHsfndaHjsIIbx
        YMyx1alIbK++DkJ5zb4jILVt5XLxZe4YYeOFNzGmPKN+a13X1KjRhiq47tRMFVAJyErTbj
        IRu0+jTGpReqta1HIjJsHXtOUSSzdLc=
Date:   Mon, 9 May 2022 20:42:31 +0800
MIME-Version: 1.0
Subject: Re: Apparent regression in blktests since 5.18-rc1+
To:     Jason Gunthorpe <jgg@nvidia.com>, Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
 <CAD=hENd1kTsy42qDmMjcAhB_rO7aa7eP-G377R2DDE7qkqRB3Q@mail.gmail.com>
 <20220509115233.GI49344@nvidia.com>
 <ff097539-3359-cf8a-14fd-7b0d460e8451@linux.dev>
 <20220509123313.GJ49344@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220509123313.GJ49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/5/9 20:33, Jason Gunthorpe 写道:
> On Mon, May 09, 2022 at 08:31:22PM +0800, Yanjun Zhu wrote:
> 
>> [   36.700285]  <TASK>
>> [   36.700291]  dump_stack_lvl+0x70/0xa0
>> [   36.700323]  dump_stack+0x10/0x12
>> [   36.700329]  __might_resched.cold+0x102/0x13a
>> [   36.700350]  __might_sleep+0x43/0x70
>> [   36.700368]  wait_for_completion_timeout+0x40/0x160
>> [   36.700373]  ? _raw_spin_unlock_irqrestore+0x4f/0x80
>> [   36.700381]  ? complete+0x4c/0x60
>> [   36.700403]  __rxe_cleanup+0xaf/0xc0 [rdma_rxe]
>> [   36.700431]  rxe_destroy_ah+0x12/0x20 [rdma_rxe]
>> [   36.700440]  rdma_destroy_ah_user+0x3a/0x80 [ib_core]
>> [   36.700464]  cm_free_priv_msg+0x44/0xf0 [ib_cm]
>> [   36.700477]  cm_send_handler+0x10b/0x2f0 [ib_cm]
>> [   36.700510]  timeout_sends+0x1aa/0x230 [ib_core]
>> [   36.700544]  process_one_work+0x2a9/0x5e0
>> [   36.700567]  worker_thread+0x4d/0x3c0
>> [   36.700582]  ? process_one_work+0x5e0/0x5e0
>> [   36.700588]  kthread+0x10a/0x130
>> [   36.700594]  ? kthread_complete_and_exit+0x20/0x20
>> [   36.700604]  ret_from_fork+0x22/0x30
>>
>> [   36.700650]  </TASK>
> 
> That is the AH bug again, nothing to do with RCU.
OK. Hope all these AH bugs can be fixed.

Zhu Yanjun
> 
> Jason

