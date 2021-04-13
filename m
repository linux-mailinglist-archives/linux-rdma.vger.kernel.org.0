Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9935E073
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 15:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbhDMNpW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 09:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbhDMNpV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 09:45:21 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE402C061574
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 06:45:00 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id x27so8053605qvd.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1Jhigyf9UU6G6IXvufmrKhvm5rl8XcUyp6UG+kGmgLA=;
        b=P8TZ3q/K2FYMwgX8ih6dAOpznLZqzG37b1Il+KiMHbiWEjdcrBMIXlzDa57UplaUu8
         1cAAmqJDwP+fMGvD6pfollJBQ39I4eEqGf7lGvVy2tw198zw6adWvWR1L3rvb6WgYOFV
         uQGjCtawvPEMW58igm5A0CBka0uwolxOU4LEpFWKSs1lhPa77NKyBLPUg4WWHQTJy3LB
         156DznYIBE8+OodCuxpBC0EFExw/tzwn0R97kcNdKbOkaiQkydvJ+gJ0LLFY0JZWEeRv
         camQQdnfN4b3Ipkdf/GOljO8I/WtnNMwVi71Eh0N1IqdmIxk8/zkFM1RV0Whu15RMwut
         uVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1Jhigyf9UU6G6IXvufmrKhvm5rl8XcUyp6UG+kGmgLA=;
        b=NKBbSjTbrlhjnR44cFGc5IO2/S1LQSHAVNK3xAWFlJvD420v+W1fwYKOSUo7Vi2/2L
         1hTq3XHMGI87WPlwan+lkS76u/0DWaTrz2m6o2eV6lUc90RfBg4wpEpp+uDHQ+tMewAd
         vtnXgrs7DS4pgaElzbcejFoG1i+MaWZICluALzbYeZFz14ecOaHpFDnSUW56bzRitZ3Q
         h9cnnKWx13FjB6pkWXEk5E+vSCU+HtE0OLZCZ1/XCjrYRte7BrY52DKOKl17ex6/s0pn
         iR771I9/2wBLBxcdOo392axdYkHj0rPI3phY4CB81nzW+2ZoS4zO0ouC7UEh+r+OcriC
         NP5Q==
X-Gm-Message-State: AOAM530ozmlDFwf/DFPB153w2KBlsujEyKl3XvPvdYqk33oaAGxJe32B
        Gv2UtZnAma+2LKWAFDS6kIAF+Q==
X-Google-Smtp-Source: ABdhPJxTLJu6I3qqH/XCtkZYAon1RFtHUEySj+DXtp3rSpBUrRvTcwgxXLIb7BBpqqA3GaZlyYTKOA==
X-Received: by 2002:ad4:458b:: with SMTP id x11mr163890qvu.36.1618321500031;
        Tue, 13 Apr 2021 06:45:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id i21sm1369148qtr.94.2021.04.13.06.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:44:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lWJLe-005HU5-T4; Tue, 13 Apr 2021 10:44:58 -0300
Date:   Tue, 13 Apr 2021 10:44:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in cma_cancel_operation, rdma_listen
Message-ID: <20210413134458.GI227011@ziepe.ca>
References: <CACkBjsY5-rKKzh-9GedNs53Luk6m_m3F67HguysW-=H1pdnH5Q@mail.gmail.com>
 <20210413133359.GG227011@ziepe.ca>
 <CACkBjsb2QU3+J3mhOT2nb0YRB0XodzKoNTwF3RCufFbSoXNm6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsb2QU3+J3mhOT2nb0YRB0XodzKoNTwF3RCufFbSoXNm6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 13, 2021 at 09:42:43PM +0800, Hao Sun wrote:
> Jason Gunthorpe <jgg@ziepe.ca> 于2021年4月13日周二 下午9:34写道：
> >
> > On Tue, Apr 13, 2021 at 11:36:41AM +0800, Hao Sun wrote:
> > > Hi
> > >
> > > When using Healer(https://github.com/SunHao-0/healer/tree/dev) to fuzz
> > > the Linux kernel, I found two use-after-free bugs which have been
> > > reported a long time ago by Syzbot.
> > > Although the corresponding patches have been merged into upstream,
> > > these two bugs can still be triggered easily.
> > > The original information about Syzbot report can be found here:
> > > https://syzkaller.appspot.com/bug?id=8dc0bcd9dd6ec915ba10b3354740eb420884acaa
> > > https://syzkaller.appspot.com/bug?id=95f89b8fb9fdc42e28ad586e657fea074e4e719b
> >
> > Then why hasn't syzbot seen this in a year's time? Seems strange
> >
> 
> Seems strange to me too, but the fact is that the reproduction program
> in attachment can trigger these two bugs quickly.

Do you have this in the C format?

Jason
