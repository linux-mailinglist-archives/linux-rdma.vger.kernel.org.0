Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827FE7B459D
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Oct 2023 08:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjJAGa5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Oct 2023 02:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjJAGa4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Oct 2023 02:30:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE460C2;
        Sat, 30 Sep 2023 23:30:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AA7C433C7;
        Sun,  1 Oct 2023 06:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696141853;
        bh=6e/Z9EDdbfohM0CT2JpFgF67+SDZWAsv5OmZaM9zIBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSbQVtq/LPy0O856bBsywsFdNuqek5sZFpI5LHujcv/+eY5cW9FYPNFZMQ57AUaQw
         YS096OU+PkkHojhqZH/9qMs71VsEJ44SoMKl0EtG3pD0LQ7t5cfcyIcl9gzeKhnZR0
         eC9EYAKQIskdEPCZf+Rs953CP0AF5g5FEw8der9kxtVe6gHifyPEGITPRMAHZIHzcX
         B7qqPQIe+A/Xj3zzdfvByAbM4gjEp8cYBG362aVmSB6JMYfwmjdVJCfaWLH/sL4gIe
         xAWnHyfHEp4qg3AnMjY36ZjvzMzuIHBD45ZUujyMZGUq5al80Y+5v5DewmnvvrfgSY
         Ql4I9yzNb0Rmw==
Date:   Sun, 1 Oct 2023 09:30:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        ". Bart Van Assche" <bvanassche@acm.org>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        matsuda-daisuke@fujitsu.com, shinichiro.kawasaki@wdc.com,
        linux-scsi@vger.kernel.org, Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Message-ID: <20231001063048.GA6351@unreal>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <6d9aaf05-c4cb-2b8e-c3dd-899e0360b6a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d9aaf05-c4cb-2b8e-c3dd-899e0360b6a1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 27, 2023 at 11:51:12AM -0500, Bob Pearson wrote:
> On 9/26/23 15:24, Bart Van Assche wrote:
> > On 9/26/23 11:34, Bob Pearson wrote:
> >> I am working to try to reproduce the KASAN warning. Unfortunately,
> >> so far I am not able to see it in Ubuntu + Linus' kernel (as you described) on metal. The config file is different but copies the CONFIG_KASAN_xxx exactly as yours. With KASAN enabled it hangs on every iteration of srp/002 but without a KASAN warning. I am now building an openSuSE VM for qemu and will see if that causes the warning.
> > 
> > Hi Bob,
> > 
> > Did you try to understand the report that I shared? My conclusion from
> > the report is that when using tasklets rxe_completer() only runs after
> > rxe_requester() has finished and also that when using work queues that
> > rxe_completer() may run concurrently with rxe_requester(). This patch
> > seems to fix all issues that I ran into with the rdma_rxe workqueue
> > patch (I have not tried to verify the performance implications of this
> > patch):
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> > index 1501120d4f52..6cd5d5a7a316 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_task.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> > @@ -10,7 +10,7 @@ static struct workqueue_struct *rxe_wq;
> > 
> >  int rxe_alloc_wq(void)
> >  {
> > -       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> > +       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, 1);
> >         if (!rxe_wq)
> >                 return -ENOMEM;
> > 
> > Thanks,
> > 
> > Bart.

<...>

> Nevertheless this is a good hint since it seems to imply that there is a race between the requester and
> completer which is certainly possible.

Bob, Bart

Can you please send this change as a formal patch?
As we prefer workqueue with bad performance implementation over tasklets.

Thanks

> 
> Bob
> 
> 
