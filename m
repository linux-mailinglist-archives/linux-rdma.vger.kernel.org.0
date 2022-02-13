Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA2B4B3C11
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Feb 2022 16:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiBMPd5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Feb 2022 10:33:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiBMPd5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Feb 2022 10:33:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15545EDE8;
        Sun, 13 Feb 2022 07:33:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A520611C4;
        Sun, 13 Feb 2022 15:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA45C004E1;
        Sun, 13 Feb 2022 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644766430;
        bh=wP6wRP9xng+IpOBqQkrxjzoFZkcgVwGVuttr2jzeZDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fn9IenRDzTMMkkCufjI/zpC4U9VkuFtU42n8g533bcaSc38aszenqt0SE/zu53+NY
         MV/3efCazMZbk5RhpA9ujA78me6op53IcT3NTJ4mMmGmLi5bIQqHZoedyc8PZzwJ6m
         luqziaK9BIBxnViG/U789y8vaQPuWQx7WDhTvH0G41ywlpordOauwXIYxq5J9Dzjhl
         jZCqZXbpZAQFObLubFCKIi1SPNF3hho25UVNcmrCNLPThmDdjQgLgfAUzlblEByn3z
         EfEPEU9l7CZvE63TBZlmyEtY6azxFCsLksut+DqXWtUkCsTXHLDAGBufHun3Jgz40F
         Lzl6Wux/9dsGw==
Date:   Sun, 13 Feb 2022 17:33:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [syzbot] possible deadlock in worker_thread
Message-ID: <Ygkk2lRe7Ndg1528@unreal>
References: <0000000000005975a605d7aef05e@google.com>
 <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
 <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
 <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
 <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 13, 2022 at 02:14:09AM +0900, Tetsuo Handa wrote:
> On 2022/02/13 1:37, Bart Van Assche wrote:
> > On 2/11/22 21:31, Tetsuo Handa wrote:
> >> But this report might be suggesting us that we should consider
> >> deprecating (and eventually getting rid of) system-wide workqueues
> >> (declared in include/linux/workqueue.h), for since flush_workqueue()
> >> synchronously waits for completion, sharing system-wide workqueues
> >> among multiple modules can generate unexpected locking dependency
> >> chain (like this report).
> > 
> > I do not agree with deprecating system-wide workqueues. I think that
> > all flush_workqueue(system_long_wq) calls should be reviewed since
> > these are deadlock-prone.
> > 
> > Thanks,
> > 
> > Bart.
> 

I second to Bart's request to do not deprecate system-wide workqueues.

Thanks

> 
