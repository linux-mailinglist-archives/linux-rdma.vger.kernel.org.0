Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D9446C179
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 18:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhLGRTJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 12:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhLGRTJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Dec 2021 12:19:09 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9690AC061574
        for <linux-rdma@vger.kernel.org>; Tue,  7 Dec 2021 09:15:38 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id p3so13700277qvj.9
        for <linux-rdma@vger.kernel.org>; Tue, 07 Dec 2021 09:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XBFyhsQNquZ3pQHlUtJ+6p1EED9gXcXiwvxejmOE88o=;
        b=PgGKb+Njo2T1X/tum6Ttion0RVdSWLjvQNuQQUQh/9ciXyvFmQts2vIfjGDS4lbW4l
         lJ3EfP11Wu9S1Y6tSz2xhls/0T0ilKTm+JwuBUlz2KQwdRSDlTTqPLPiGcSAHkTU22cp
         2fprTvHiMLIlRFFm/R/cDEoY23MJ5wKne/mh1wtBWmdoNu9F7bFYn5tSwcAlzCpyMJVH
         AxTALAhF4016N/A8Ye82uUl6/bJnQmAQZVopQrqZyWRFeckKCR6TsKICVobXreJd2yDo
         FDliWYkLgmsAth2w/v/F1Xw3LTOfGYFk26upKuayLj8XyVaburOFCXILvGyYjkYf0UB2
         Ex0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XBFyhsQNquZ3pQHlUtJ+6p1EED9gXcXiwvxejmOE88o=;
        b=qzhc58uW4HtYFdh2824gQB8FcIU4OamP4GtRXfflRBeq2Sbp8HpQlCurdxynJ3+bQS
         YPIZ8BvnkoPs9fW7rpjBiVFLpx5hCjNkRNsmZGU/iO7R97GHD/DLfaTJXpbQX/bB9Y26
         qqH0F1fx6a864q44lr98pBCz6mSrZfYaREZjWkzjfZbyEdhWfzm3nFdqjK6Nnio3LWde
         MZCT7Eq5HrxtFI+J+vexUQg33efxXIjnJlkKpeSaDIBN6gm2+3J1HgBMS8Nbi8IaBYCG
         4PD0EsWiNeOmecebt5ipF8umAIY4hqgovR4OdWAImHJe5KtidWhjfInmdTsBdRrZPR/G
         xQzA==
X-Gm-Message-State: AOAM5328R95Ga3Ss8mmBeXjxW8c6Ai0VQeXzg6mKDTJk+or39YPaCopE
        ZeBQsuevBTjarHzuV8w+NiLleQ==
X-Google-Smtp-Source: ABdhPJx2dAwjSu6007TyEGRFXM67eMCde+v+xT39zzAQ9NoQBCOcllZxeigztUqz6Ze6rQ9T4R5awg==
X-Received: by 2002:a05:6214:29c3:: with SMTP id gh3mr620183qvb.30.1638897337717;
        Tue, 07 Dec 2021 09:15:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b11sm182363qtx.85.2021.12.07.09.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:15:37 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mue40-0005eD-O7; Tue, 07 Dec 2021 13:15:36 -0400
Date:   Tue, 7 Dec 2021 13:15:36 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com>,
        avihaih@nvidia.com, dledford@redhat.com, haakon.bugge@oracle.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: corrupted list in rdma_listen (2)
Message-ID: <20211207171536.GB6467@ziepe.ca>
References: <000000000000c3eace05d24f0189@google.com>
 <20211206154159.GP5112@ziepe.ca>
 <CACT4Y+bnJ5M84RjUONFYMXSOpzC5UOq2DxVNoQkq6c6nYwG9Og@mail.gmail.com>
 <20211206173550.GQ5112@ziepe.ca>
 <CACT4Y+atv60UELnQJqejS_Z+uBYYERha4-o1dViwVuSLpb-Tfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+atv60UELnQJqejS_Z+uBYYERha4-o1dViwVuSLpb-Tfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 07, 2021 at 09:37:30AM +0100, Dmitry Vyukov wrote:

> > > https://syzkaller.appspot.com/bug?extid=c94a3675a626f6333d74
>
> In the Crashes table there are 2 crashes, one is the one that was
> reported in this email and the second happened on upstream commit
> 5833291ab6de (you can search by this hash on the page).
> 5833291ab6de is newer than a year:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=5833291ab6de

Oh I see, I did not read it properly then

Sigh, OK

I thought we fixed this :(

Jason
