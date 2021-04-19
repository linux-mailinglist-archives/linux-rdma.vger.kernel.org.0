Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7117C364935
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 19:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbhDSRv2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbhDSRv2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Apr 2021 13:51:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0A5C06174A
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 10:50:58 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j3so17299509qvs.1
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PFYo4F/pu6WmySW2AUaoCkbhbMq7uB4j/t0AhM0YAng=;
        b=aJzqnJbvObGzZGGLp/AECbTq2/zz+8Mfz0H+50ov2n9hjUr04siVw/rtcX9OGvD9BO
         dhOly7mYcEOvgHjOTAE+524e+wdnzmBIyVoJ4ihBX13QqsRaFqjM/sDSze8GugnIdx08
         9dn40PemC8z6p83jLDVqtlrMQrvzYwl4qQ/ste4Y7CDs1uJkQXmNie8zEuYuMhFVjYMv
         1OadNwuFqv0BlLSA/YlBrZvLErUW0NpE1nhi2PiUcIIr8l6qc4ZoIpF4EXB9FkRO/GNm
         oLjAFBrztiuvRHAv9DQGmWUl+KZJzldeGB3DVcvcxEzk5MjGnVQs8FtDxr/ZiObTgFYy
         Huxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PFYo4F/pu6WmySW2AUaoCkbhbMq7uB4j/t0AhM0YAng=;
        b=LJM8qhzqvpPYExw+VFA+kXUn74tfC/hDf+ZvnHRFOEmb6CKvRa1FDX/Gh/h0zilP69
         ba8tADTp/JDlCjtRwC+L+AKsacwsUUlildfk6YnUN8ThaV2HutBPvVUrS26FMMjUhz+0
         X/Qbl1aO92OVG/0FkuoHWutpv46X6CEQE2nzgNE3+3FBpgeEGsN9tqnRTE7TNuEpM1a+
         Diyg1B9Krbfur95PPDn2P9UW6w5XrRKtxAwU0CiT5SX4rjtGfDxi0LgXtj7kjN9GCokS
         DAoN3siaSvd152t0kBFONcFLa3ZU9u89UgEe1Q1v27MGHltgurjNs1N+KcZ9fwk5k4iJ
         N1xw==
X-Gm-Message-State: AOAM533xIRGyNsWokit9/yt5rJRKfTBFwG4fCOhWaxq96CNLRwjBOmD3
        4K/qlcjSfGTkCFMJih6slKKjfA==
X-Google-Smtp-Source: ABdhPJxLxFguELT+c4bl5CsBN4f+Mz3yBJVK3+wGPPGPM3G53AX1YAsk5k3DPOln+4rOh5PHEO2PHQ==
X-Received: by 2002:a0c:f2c8:: with SMTP id c8mr22489012qvm.35.1618854657322;
        Mon, 19 Apr 2021 10:50:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id p186sm10304929qka.66.2021.04.19.10.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:50:56 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lYY2x-008dEP-MI; Mon, 19 Apr 2021 14:50:55 -0300
Date:   Mon, 19 Apr 2021 14:50:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in cma_cancel_operation, rdma_listen
Message-ID: <20210419175055.GA2047089@ziepe.ca>
References: <CACkBjsY5-rKKzh-9GedNs53Luk6m_m3F67HguysW-=H1pdnH5Q@mail.gmail.com>
 <20210413133359.GG227011@ziepe.ca>
 <CACkBjsb2QU3+J3mhOT2nb0YRB0XodzKoNTwF3RCufFbSoXNm6A@mail.gmail.com>
 <20210413134458.GI227011@ziepe.ca>
 <CACkBjsY-CNzO74XGo0uJrcaZTubC+Yw9Sg1bNNi+evUOGaZTCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsY-CNzO74XGo0uJrcaZTubC+Yw9Sg1bNNi+evUOGaZTCg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 13, 2021 at 10:19:25PM +0800, Hao Sun wrote:
> Jason Gunthorpe <jgg@ziepe.ca> 于2021年4月13日周二 下午9:45写道：
> >
> > On Tue, Apr 13, 2021 at 09:42:43PM +0800, Hao Sun wrote:
> > > Jason Gunthorpe <jgg@ziepe.ca> 于2021年4月13日周二 下午9:34写道：
> > > >
> > > > On Tue, Apr 13, 2021 at 11:36:41AM +0800, Hao Sun wrote:
> > > > > Hi
> > > > >
> > > > > When using Healer(https://github.com/SunHao-0/healer/tree/dev) to fuzz
> > > > > the Linux kernel, I found two use-after-free bugs which have been
> > > > > reported a long time ago by Syzbot.
> > > > > Although the corresponding patches have been merged into upstream,
> > > > > these two bugs can still be triggered easily.
> > > > > The original information about Syzbot report can be found here:
> > > > > https://syzkaller.appspot.com/bug?id=8dc0bcd9dd6ec915ba10b3354740eb420884acaa
> > > > > https://syzkaller.appspot.com/bug?id=95f89b8fb9fdc42e28ad586e657fea074e4e719b
> > > >
> > > > Then why hasn't syzbot seen this in a year's time? Seems strange
> > > >
> > >
> > > Seems strange to me too, but the fact is that the reproduction program
> > > in attachment can trigger these two bugs quickly.
> >
> > Do you have this in the C format?
> >
> 
> Just tried to use syz-prog2c to convert the repro-prog to C format.
> The repro program of  rdma_listen was successfully reproduced
> (uploaded in attachment), the other one failed. it looks like
> syz-prog2c may not be able to do the equivalent conversion.
> You can use syz-execprog to execute the reprogram directly, this
> method can reproduce both crashes, I have tried it.

I tried this program and it reliably deadlocks my kernel :|

So there is certainly something here

Jason
