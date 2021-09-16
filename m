Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9144040DEE3
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 18:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbhIPQDr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 12:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbhIPQDr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 12:03:47 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C5C061764
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 09:02:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id m9so5996081qtk.4
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CmOTDYp80F4kUyraA9ML+LX4bjdl3k2IyBR2TsA9nis=;
        b=YntFQPmuQYLQD9/0eLL1n2bggwYEgCI5uBCHuXiSN/yH+l8cBGuHRq5ZynaqF9dMzc
         63fO3H7y5YN7JF/KRc1Oa5t4DFGzEGk9p9RlbKmdFmB78+H90sAuUBSh2bXUR645+vqP
         XMh+fdOc+92Pfs8PAJf/jP0+FxUnVW+y1P4LXPCGHhO5+Yn51uzKoFKFtxIlRHQkLUmY
         ilcTMYEI7KfP5oX+L83qizwQwyqSNxq03VNcKWKJ+b9DN7Iqq282t+9/IUUrvSPvJV4d
         iMa6nZE/5yf8akhoxIIFRwJNoJ5ghBPiO15FbqEoL5/2qew9C0yoZfXsnkb1CXE+Vv8g
         3omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmOTDYp80F4kUyraA9ML+LX4bjdl3k2IyBR2TsA9nis=;
        b=JGXRderFZofzIjc8jx/5kVU3eZLGyAlkXzq8ujFfNZYpETja2u830yuLejaSx5/xwD
         4P/XeLSjMydslOpZXedrxN23qIa4fcc/3Nabrm6hpd7FwaIoTHJv9GJDubwzO2Po9BHm
         h+Z8j/lzabjXuZUCxzZR9l1pzST5DaDCI0sG2F6/MfC/yOViKP96+ZYNFMiQuGvpc0zO
         LvqxvO4COAuwnJCUg48/W2iuxpTOapegCDk7hhMfaYkcWHPC8aKLnTN+Iu5g8HGXSG3U
         1VFkoWYzOi+QAFlyVCvnEcFwwtrnv7RjisVN9y1w1XMazAb+kXHpt22irHjZSGDB1+du
         uOHA==
X-Gm-Message-State: AOAM530Iura4TWq21lbNq+R80wNjjTqY53dMzalHg9E584K9jdg5RD9W
        XZi/MVXVAE1x0ePuNAFWLj2EuOrNG92LlA==
X-Google-Smtp-Source: ABdhPJwY8gWfa0MI0w0r5Y5Vr92o09KHHYetjPmTfkNKWw7/GxQb37zPUsm44nzsMjACNWnWgly8SQ==
X-Received: by 2002:ac8:58d0:: with SMTP id u16mr5768320qta.189.1631808145628;
        Thu, 16 Sep 2021 09:02:25 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id y185sm2759926qkb.36.2021.09.16.09.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:02:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQtqC-001nJt-6h; Thu, 16 Sep 2021 13:02:24 -0300
Date:   Thu, 16 Sep 2021 13:02:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
Message-ID: <20210916160224.GP3544071@ziepe.ca>
References: <000000000000ffdae005cc08037e@google.com>
 <20210915193601.GI3544071@ziepe.ca>
 <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
 <20210916130459.GJ3544071@ziepe.ca>
 <CACT4Y+aUFbj3_+iBpeP2qrQ=RbGrssr0-6EZv1nx73at7fdbfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aUFbj3_+iBpeP2qrQ=RbGrssr0-6EZv1nx73at7fdbfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 04:45:27PM +0200, Dmitry Vyukov wrote:

> It looks like a very hard to trigger race (few crashes, no reproducer,
> but KASAN reports look sensible). That's probably the reason syzkaller
> can't create a reproducer.
> From the log it looks like it was triggered by one of these programs
> below. But I tried to reproduce manually and had no success.
> We are currently doing some improvements to race triggering code in
> syzkaller, and may try to use this as a litmus test to see if
> syzkaller will do any better:
> https://github.com/google/syzkaller/issues/612#issuecomment-920961538

I would suggest to look at this:

https://patchwork.kernel.org/project/linux-rdma/patch/0-v1-9fbb33f5e201+2a-cma_listen_jgg@nvidia.com/

Which I think should be completely deterministic, just do the RDMA_CM
ops in the right order, but syzbot didn't find a reproducer.

The "healer" fork did however:

https://lore.kernel.org/all/CACkBjsY-CNzO74XGo0uJrcaZTubC+Yw9Sg1bNNi+evUOGaZTCg@mail.gmail.com/#r

> Answering your question re what was running concurrently with what.
> Each of the syscalls in these programs can run up to 2 times and
> ultimately any of these calls can race with any. Potentially syzkaller
> can predict values kernel will return (e.g. id's) before kernel
> actually returned them. I guess this does not restrict search area for
> the bug a lot...

Well, it does help if it is only those system calls

And I think I can discount the workqueue as a problem as I'd expect a
kasn hit on the 'req' allocation if the workqueue was malfunctioning -
thus I must conclude we are not calling work cancelation for some
reason.

Jason
