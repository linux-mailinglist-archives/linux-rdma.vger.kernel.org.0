Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36071450118
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Nov 2021 10:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbhKOJYC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Nov 2021 04:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbhKOJX6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Nov 2021 04:23:58 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7593C061746
        for <linux-rdma@vger.kernel.org>; Mon, 15 Nov 2021 01:21:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w1so2720272edc.6
        for <linux-rdma@vger.kernel.org>; Mon, 15 Nov 2021 01:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIk1h/SwhJWgOMOg/yoeLqhFeAr2GA7BlWfqcbi2WE4=;
        b=do75lOgHZWzw8LrkJxacPuOIJf2im1ec0nYdkLMv0DMaAkZmjkLvDKE7qMPzah5ezd
         PfZyqSzKA71MZzMyhLSJeyq9jWlRCI5SVX5sSAUf/yL/7OrTx+olhoJumU6HVUGY2yGu
         BNdKqlzxHiz7Nmpep5Vj5htWLwuO6H+Kohhlgp4JYufGjsyHAOzKvmPw3mJVyp6kaBeS
         wzpnUlkINzJ22IdMH/FdTkGuVByr6DeUuQOmw5Ln9MIkPlIX2q58rbtEZSlodhxdbVSD
         ExsBtp5ofFKL9YQlBtrF+IGCwH2ZVlhZpFP23nqK48MqIwPvxQpHN9ZK3kOMEjwGI7Lr
         QCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIk1h/SwhJWgOMOg/yoeLqhFeAr2GA7BlWfqcbi2WE4=;
        b=YD+8Vd/n3wpoGALxCSoWTdjMPAmalOiq9H+azHPJmgGtWg1ZwA+WIQOcV47Y8Rb5s6
         hNDX2RGm7W7grzcVGCIiUnH82WVAUF28ciEZJ4fRnVQVbW4cG/tFTYv7+D+Zr2mn5rON
         WBhUJfRz8+IADVoa0rj4485OMI/zRaiZ6Dba5YcKo7A8aDxfGTiZRy58ECFyZdN3ua04
         kI/91A6D/tqGzmW4770SdqIkL1neqJpsNjvhaShs+fd1DVY/k8EyW+l1NKWgDFsUtqC6
         uy31EIzrWLqQh+oOgspSZA1aiFIV6wXfc7s4Q8eJ2RifV5wOaJgWBd1K68b6quMCP2Nx
         wE6Q==
X-Gm-Message-State: AOAM530Ir6DiKQhq1P//xTaKwgpT68kVI/SyP8DvvaYxAaI0zI6vC1Gz
        u4QHWPmpN2x+vjI9bFjsPDbdEXMT2gdxSWHhXVWpRQ==
X-Google-Smtp-Source: ABdhPJzEDNh0b9Pt4CD2GVs4Pxj/JwXo4eZIz41rx72pAAZEObFk8BuzdrfNtKwSu+KzGsFjNIgphmjVfyO1x0YXPL4=
X-Received: by 2002:a50:9514:: with SMTP id u20mr25419022eda.117.1636968061223;
 Mon, 15 Nov 2021 01:21:01 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
 <YYz+lmJ9C4P/2hbv@unreal> <CAMGffE=EVpgYrPnUy-jGM7i4yvwsBUz1-Mre--aP70b9hP8zug@mail.gmail.com>
 <20211112142356.GC876299@ziepe.ca> <YZC1S+T+SosaHihh@unreal> <CAMGffEmfYBSUOw73n=o+iCJheAzdv93WZJJ2MK6M52JzaYWEWQ@mail.gmail.com>
In-Reply-To: <CAMGffEmfYBSUOw73n=o+iCJheAzdv93WZJJ2MK6M52JzaYWEWQ@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 15 Nov 2021 10:20:50 +0100
Message-ID: <CAMGffEkmm3rqyHooraMq4ELkCP=tXORqNENR9Ur0mOhDmRJZWw@mail.gmail.com>
Subject: Re: Missing infiniband network interfaces after update to 5.14/5.15
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Haris Iqbal <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 15, 2021 at 9:18 AM Jinpu Wang <jinpu.wang@ionos.com> wrote:
>
> On Sun, Nov 14, 2021 at 8:05 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Nov 12, 2021 at 10:23:56AM -0400, Jason Gunthorpe wrote:
> > > On Fri, Nov 12, 2021 at 09:23:04AM +0100, Jinpu Wang wrote:
> > > > On Thu, Nov 11, 2021 at 12:29 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Thu, Nov 11, 2021 at 08:48:08AM +0100, Jinpu Wang wrote:
> > > > > > Hi Jason, hi Leon,
> > > > > >
> > > > > > We are seeing exactly the same error reported here:
> > > > > > https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> > > > > >
> > > > > > I suspect it's related to
> > > > > > https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> > > > > >
> > > > > > Do you have any idea, what goes wrong?
> > > > >
> > > > > I can't reproduce it with latest Fedora 34 RPM, which I downloaded from here
> > > > > https://koji.fedoraproject.org/koji/buildinfo?buildID=1851842
> > > > >
> > > > > and also with kernel-5.14.7-200.fc34.x86_64 version mentioned in the bug
> > > > > report.
> > > > >
> > > > > [leonro@c-235-8-1-005 ~]$ uname -a
> > > > > Linux c-235-8-1-005 5.14.7-200.fc34.x86_64 #1 SMP Wed Sep 22 14:54:28 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > > > > [leonro@c-235-8-1-005 ~]$ rdma dev
> > > > > 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> > > > > 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
> > > > >
> > > > > [leonro@c-235-8-1-005 ~]$ uname -a
> > > > > Linux c-235-8-1-005 5.14.16-201.fc34.x86_64 #1 SMP Wed Nov 3 13:57:29 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > > > > [leonro@c-235-8-1-005 ~]$ rdma dev
> > > > > 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> > > > > 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
> > > > > [leonro@c-235-8-1-005 ~]$ lspci |grep nox
> > > > > 08:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> > > > > 09:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> > > > >
> > > > > Thanks
> > > > >
> > > > Hi,
> > > >
> > > > I tried different host with CX-3/CX-5, they all work fine. and I can
> > > > only reproduce on hosts with a bit old HCA:
> > > > 03:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe
> > > > 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
> > > >
> > > > The bug report link
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=2014094, mentioned HCA
> > > > ConnectX too.
> > > >
> > > > 01:00.0 InfiniBand [0c06]: Mellanox Technologies MT25408A0-FCC-GI
> > > > ConnectX, Dual Port 20Gb/s InfiniBand / 10GigE Adapter IC with PCIe
> > > > 2.0 x8 5.0GT/s In... (rev b0)
> > > > with the instrument, I only narrow it down to
> > > > 1438                 port = setup_port(coredev, port_num, &attr);
> > > > 1439                 if (IS_ERR(port)) {
> > > > 1440                         ret = PTR_ERR(port);
> > > > 1441                         pr_info("setup ports failed %d\n", ret);
> > > > 1442                         goto err_put;
> > > > 1443                 }
> > >
> > > Keep going with the tracing, there are lots of allocations in there.
> > >
> > > > My guess is the ConnectX HCA may be missing some features, which leads
> > > > to ENOMEM, I will continue the instrument if no other hint.
> > >
> > > Since there is no memory allocation failure splat I'm guessing some
> > > memory allocation hit an overflow and silently failed - ie mlx4 is
> > > possibily setting some value to something bogus
> >
> > Yes, look for the values returned from FW.
> Hi Leon, hi Jason
>
> I've found the problem, the device doesn't support per port diag
> counters, and the driver then fails the register which is
> too harsh.
>
> I'm not sure how to fix it properly, your thought?
>
> Thanks
>
with this change,  the device can be detected properly. if you think
it's the right direction, I can submit a patch.

Thanks!
+
+static const struct ib_device_ops mlx4_ib_hw_stats_ops1 = {
+       .alloc_hw_device_stats = mlx4_ib_alloc_hw_device_stats,
+       .get_hw_stats = mlx4_ib_get_hw_stats,
+};
+
 static int mlx4_ib_alloc_diag_counters(struct mlx4_ib_dev *ibdev)
 {
        struct mlx4_ib_diag_counters *diag = ibdev->diag_counters;
@@ -2230,8 +2238,11 @@ static int mlx4_ib_alloc_diag_counters(struct
mlx4_ib_dev *ibdev)

        for (i = 0; i < MLX4_DIAG_COUNTERS_TYPES; i++) {
                /* i == 1 means we are building port counters */
-               if (i && !per_port)
-                       continue;
+               if (i && !per_port) {
+                       ib_set_device_ops(&ibdev->ib_dev,
&mlx4_ib_hw_stats_ops1);
+                       return 0;
+               }
