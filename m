Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837D851A07B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 15:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiEDNN0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiEDNNZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 09:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C7ED2E9EA
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 06:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651669788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFg6Pcf9hLC/bvNHZtgNSUoCpWVM5fZPOHRggK9KPBY=;
        b=JAfUtknEfYix2Ejnb+z5N26AN7Nzrq+nYdV27a7XeaC6eYdCOusyDbrx7qjQnA2puHp3ME
        MiM0hQW22BEk+wM2GyscXyJ7z+NdGP7J7rYodBtWS+p5vyzK8BjoUVLhVzNJ0WfcRziSH1
        SB1WB46NTYVV3QC0TPu2Ifn82gnemrk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-w6Ie5d5bMJOWNqLQBV4xDQ-1; Wed, 04 May 2022 09:09:47 -0400
X-MC-Unique: w6Ie5d5bMJOWNqLQBV4xDQ-1
Received: by mail-wm1-f69.google.com with SMTP id n186-20020a1c27c3000000b00392ae974ca1so1614371wmn.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 May 2022 06:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rFg6Pcf9hLC/bvNHZtgNSUoCpWVM5fZPOHRggK9KPBY=;
        b=sYfoRx/8kY4CAlQJmfU0HdF/wRjkiw8xsiYkbmQeO/cTQo9j11t4wPwMg+T09ABer1
         Ut5J8cVZTZFJ18uNJvGm1nCkCuWYckG6OpNAKZ8+OHXqlDFuZhaDb0aH25wc3ZC6HM1y
         IyNmEl/Pw62dsknB9nuiAWQD3Az0rDzNkACM8JibCVf1NKW5p07vVeApkogqSJRALagu
         2Xn9vUEfreIl4gHj7wKtNnRscpsXBmz16+G4lskb0v9CgRBFdpXR2IjyfxNfORtYBpih
         ofgAlqopxHGQBieXqqPW5+ONfBeCKd9FLm2xwJlxqVZysv4HXPaz1+oLqhg30tu/Xx7S
         RB4A==
X-Gm-Message-State: AOAM5338ikjEQ+oAAzBI6d/5GfyFAQsEGY52EeLZ5Ti4ylyAQvmeKAox
        1iux0GnMxKeIQ2Sq6oqmUOs3q2EQeGvd9kCU+0sz78A+KWZncZQ0OnF1jIBBlYVxpKSyTdKLhuB
        CcQcjbt1EB+TDTwt5Bi1JDg==
X-Received: by 2002:adf:eacf:0:b0:20a:c8c4:ac51 with SMTP id o15-20020adfeacf000000b0020ac8c4ac51mr16624117wrn.510.1651669785764;
        Wed, 04 May 2022 06:09:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfSUbwPLB6puSaYMJt/utbnn7soTRITSSpskar0giAb7st7IVHKLxkG9G6bKW9v7swgHwQwg==
X-Received: by 2002:adf:eacf:0:b0:20a:c8c4:ac51 with SMTP id o15-20020adfeacf000000b0020ac8c4ac51mr16624102wrn.510.1651669785550;
        Wed, 04 May 2022 06:09:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id c17-20020a7bc011000000b003942a244f40sm3974352wmb.25.2022.05.04.06.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:09:44 -0700 (PDT)
Message-ID: <d3d068eda5ef2d1ab818f01d7d07fab901363446.camel@redhat.com>
Subject: Re: [PATCH v2] net: rds: acquire refcount on TCP sockets
From:   Paolo Abeni <pabeni@redhat.com>
To:     Eric Dumazet <edumazet@google.com>,
        patchwork-bot+netdevbpf@kernel.org
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+694120e1002c117747ed@syzkaller.appspotmail.com>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Date:   Wed, 04 May 2022 15:09:43 +0200
In-Reply-To: <CANn89iLHihonbBUQWkd0mjJPUuYBLMVoLCsRswtXmGjU3NKL5w@mail.gmail.com>
References: <a5fb1fc4-2284-3359-f6a0-e4e390239d7b@I-love.SAKURA.ne.jp>
         <165157801106.17866.6764782659491020080.git-patchwork-notify@kernel.org>
         <CANn89iLHihonbBUQWkd0mjJPUuYBLMVoLCsRswtXmGjU3NKL5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 2022-05-03 at 14:17 -0700, Eric Dumazet wrote:
> On Tue, May 3, 2022 at 4:40 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
> > 
> > Hello:
> > 
> > This patch was applied to netdev/net.git (master)
> > by Paolo Abeni <pabeni@redhat.com>:
> > 
> > On Mon, 2 May 2022 10:40:18 +0900 you wrote:
> > > syzbot is reporting use-after-free read in tcp_retransmit_timer() [1],
> > > for TCP socket used by RDS is accessing sock_net() without acquiring a
> > > refcount on net namespace. Since TCP's retransmission can happen after
> > > a process which created net namespace terminated, we need to explicitly
> > > acquire a refcount.
> > > 
> > > Link: https://syzkaller.appspot.com/bug?extid=694120e1002c117747ed [1]
> > > Reported-by: syzbot <syzbot+694120e1002c117747ed@syzkaller.appspotmail.com>
> > > Fixes: 26abe14379f8e2fa ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
> > > Fixes: 8a68173691f03661 ("net: sk_clone_lock() should only do get_net() if the parent is not a kernel socket")
> > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > Tested-by: syzbot <syzbot+694120e1002c117747ed@syzkaller.appspotmail.com>
> > > 
> > > [...]
> > 
> > Here is the summary with links:
> >   - [v2] net: rds: acquire refcount on TCP sockets
> >     https://git.kernel.org/netdev/net/c/3a58f13a881e
> > 
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> > 
> > 
> 
> I think we merged this patch too soon.

My fault.


> My question is : What prevents rds_tcp_conn_path_connect(), and thus
> rds_tcp_tune() to be called
> after the netns refcount already reached 0 ?
> 
> I guess we can wait for next syzbot report, but I think that get_net()
> should be replaced
> by maybe_get_net()
> 
Should we revert this patch before the next pull request, if a suitable
incremental fix is not available by then?

It looks like the window of opportunity for the race is roughly the
same?

Thanks!

Paolo

