Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF6244E894
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Nov 2021 15:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhKLO0u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Nov 2021 09:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhKLO0u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Nov 2021 09:26:50 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED3C061766
        for <linux-rdma@vger.kernel.org>; Fri, 12 Nov 2021 06:23:59 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id jo22so6317892qvb.13
        for <linux-rdma@vger.kernel.org>; Fri, 12 Nov 2021 06:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sWENJVBED6vEpvhTV25Kprid8J2O9Z3XamygIR51gYw=;
        b=QzooSEHs8s4vI/w7cg/CuRglhNoL1YUL+mqZ7i/IBi8aPOpcOd5C6hVK5EK2W0fSIZ
         RrLqWdlLZ95a0l+/y70GWlmHZ3DTHpfqsmCCyqahjiMdpdSabz6BQpkoIgRczdu3aC3E
         tsnh70pWlAcY85OswRetPPuKd3en6FXOUn6gR365xVo0q5YfrERd7MREaNTiT7gP6x9e
         M8+N5VbDD0Ua0vsdtw6S1v7tTzeskgiMnmOIWJidGcOkQxN/kXuZt33i7uP8T8kk0Ndt
         rwjV0j7pjuL3NUbbNBNQUDFczjHAdVPPHuXDNE3rUHI0/6helbEUiv1BfqDmj8Y9SUHS
         baJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sWENJVBED6vEpvhTV25Kprid8J2O9Z3XamygIR51gYw=;
        b=2bEhSuD2vKDwPLYjzqbqeJoGUXXWkl+uWY15F4SJD4QWrmxCPNKQ2yOOihxUwvkD2f
         gNXSb2O7DxZ9HrEs75GB/oytOxAp9WTOPvzC1F2ugEMb9IuyuPeZ/CU76QGxq37ehj1b
         tmw9ewqlcm4uZzOuYQ7UOQJdqRNM+0C/VbSJ8APqly//5fj2NfvbqBj+WAwgbiGwpcdx
         W63RxA6It4C+za7d65cpfkWtHEG1nURW0LcYvHkWGp9Jm872YprFznnffvpqxF5krB28
         xMnini3hx1TOImrLsRs6mMPeanr9MViJzjgsr61isz/ZCEL6MDoxDw+/cY++3dBuiWoG
         /gCA==
X-Gm-Message-State: AOAM532tB/QFEpvSu5W/HzP8XWSkBusLlHEs+FNM1OoJmG9AC0kqNNFj
        UuMMM1132OiAoNCt5cEp71WY5w==
X-Google-Smtp-Source: ABdhPJzOJGXIoAmIqd4KEO0v2yL2iZEnao9sFNrS3qf20S24bLW471+KHCi2wdpUZ9Xw6bp46yZXKQ==
X-Received: by 2002:a0c:ed52:: with SMTP id v18mr14646178qvq.61.1636727038739;
        Fri, 12 Nov 2021 06:23:58 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n13sm3350983qtx.68.2021.11.12.06.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 06:23:58 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mlXTA-0095vi-Um; Fri, 12 Nov 2021 10:23:56 -0400
Date:   Fri, 12 Nov 2021 10:23:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Haris Iqbal <haris.iqbal@ionos.com>
Subject: Re: Missing infiniband network interfaces after update to 5.14/5.15
Message-ID: <20211112142356.GC876299@ziepe.ca>
References: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
 <YYz+lmJ9C4P/2hbv@unreal>
 <CAMGffE=EVpgYrPnUy-jGM7i4yvwsBUz1-Mre--aP70b9hP8zug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=EVpgYrPnUy-jGM7i4yvwsBUz1-Mre--aP70b9hP8zug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 12, 2021 at 09:23:04AM +0100, Jinpu Wang wrote:
> On Thu, Nov 11, 2021 at 12:29 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Nov 11, 2021 at 08:48:08AM +0100, Jinpu Wang wrote:
> > > Hi Jason, hi Leon,
> > >
> > > We are seeing exactly the same error reported here:
> > > https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> > >
> > > I suspect it's related to
> > > https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> > >
> > > Do you have any idea, what goes wrong?
> >
> > I can't reproduce it with latest Fedora 34 RPM, which I downloaded from here
> > https://koji.fedoraproject.org/koji/buildinfo?buildID=1851842
> >
> > and also with kernel-5.14.7-200.fc34.x86_64 version mentioned in the bug
> > report.
> >
> > [leonro@c-235-8-1-005 ~]$ uname -a
> > Linux c-235-8-1-005 5.14.7-200.fc34.x86_64 #1 SMP Wed Sep 22 14:54:28 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > [leonro@c-235-8-1-005 ~]$ rdma dev
> > 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> > 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
> >
> > [leonro@c-235-8-1-005 ~]$ uname -a
> > Linux c-235-8-1-005 5.14.16-201.fc34.x86_64 #1 SMP Wed Nov 3 13:57:29 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > [leonro@c-235-8-1-005 ~]$ rdma dev
> > 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> > 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
> > [leonro@c-235-8-1-005 ~]$ lspci |grep nox
> > 08:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> > 09:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> >
> > Thanks
> >
> Hi,
> 
> I tried different host with CX-3/CX-5, they all work fine. and I can
> only reproduce on hosts with a bit old HCA:
> 03:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe
> 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
> 
> The bug report link
> https://bugzilla.redhat.com/show_bug.cgi?id=2014094, mentioned HCA
> ConnectX too.
> 
> 01:00.0 InfiniBand [0c06]: Mellanox Technologies MT25408A0-FCC-GI
> ConnectX, Dual Port 20Gb/s InfiniBand / 10GigE Adapter IC with PCIe
> 2.0 x8 5.0GT/s In... (rev b0)
> with the instrument, I only narrow it down to
> 1438                 port = setup_port(coredev, port_num, &attr);
> 1439                 if (IS_ERR(port)) {
> 1440                         ret = PTR_ERR(port);
> 1441                         pr_info("setup ports failed %d\n", ret);
> 1442                         goto err_put;
> 1443                 }

Keep going with the tracing, there are lots of allocations in there.

> My guess is the ConnectX HCA may be missing some features, which leads
> to ENOMEM, I will continue the instrument if no other hint.

Since there is no memory allocation failure splat I'm guessing some
memory allocation hit an overflow and silently failed - ie mlx4 is
possibily setting some value to something bogus

Jason
