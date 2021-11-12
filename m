Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2F44E2F1
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Nov 2021 09:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhKLI0H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Nov 2021 03:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhKLI0G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Nov 2021 03:26:06 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51494C061766
        for <linux-rdma@vger.kernel.org>; Fri, 12 Nov 2021 00:23:16 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so34643352edz.2
        for <linux-rdma@vger.kernel.org>; Fri, 12 Nov 2021 00:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VU5UtrOGzeQLBcdaLyA/Ud6V84LftjDwa1vaPXcHk7M=;
        b=Gv9YrWDkJ1J4t7J/1PR4AEkaTe5w72UKGQxqixpubLZ5MOOtQdv1n4ZJP7jiy2GvkI
         Uv18w0uvNVGgL+7izFyrTiZSA23Pjoint6IMHnX/z3AkUMDlwlzEd2DzJ9pudcCR3Ikt
         e5I5qXy2WWuQ+VKOXX4H3vGz52OwzLyFRTtqojxmo8KikG3ngFdcbqV3oqVs3IiM1QU7
         /2Z+jSNHuTz94AYAITxy2SzXX0LiWcJxB5pH4vkOuI+GB49ybt/OdWCifge8eyHSNDAC
         HuErjscPU9jC+SFBYrX4bAn3mqNVqF5KoUix5Rz6/R89hLYpYH79YXWDS2C+6ULH6n0A
         Vp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VU5UtrOGzeQLBcdaLyA/Ud6V84LftjDwa1vaPXcHk7M=;
        b=UmM2INegiShd9P5a4yhnCQ/Pu0L3F5rQ/5+B31faoE3fgrynCKl5U7zenpU6WO3N36
         4tRjIw6AYkSrgoUkm/MzFsXzjrUxAr/FORtivRllv9D6sitEWkHIt8lWzff2pCMXlbAq
         yueH7792vLUfhFNPNU2VQPkXCk7JQyyuoRWD4hU2wfKwCeWGlyvrFiRpjvCZNEg303oD
         /7zyZvR6+qIgm5PhTnJjCMCYohTAp0qJcGenM0JaIbDRc21efmFbBbF/eh/cCF8+NUZP
         lmPdPoQOxJ5XjJJCYG+DoR7YR80/wK005P5/QOWg8N2snaYpLhWDD7F8SI/uui36Blzx
         FmHA==
X-Gm-Message-State: AOAM531GtQbF8ZKNL9ERjhe0tX88qRZ/vcIzXB2sjDAA3bCFvf1q3zy1
        pQvbOGklvp/d0Psl+J8hA/RVoJs5AijBl0EukWSV2Q==
X-Google-Smtp-Source: ABdhPJxUIHAzoWlvwCqQ+ScBy6AIHuAP+dusjQCo8/sqe/MsGVJ8UCwATJoZ2gaebK04KoK34mfbmyOkbojD29zbCes=
X-Received: by 2002:a50:ef02:: with SMTP id m2mr1455495eds.172.1636705394814;
 Fri, 12 Nov 2021 00:23:14 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
 <YYz+lmJ9C4P/2hbv@unreal>
In-Reply-To: <YYz+lmJ9C4P/2hbv@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 12 Nov 2021 09:23:04 +0100
Message-ID: <CAMGffE=EVpgYrPnUy-jGM7i4yvwsBUz1-Mre--aP70b9hP8zug@mail.gmail.com>
Subject: Re: Missing infiniband network interfaces after update to 5.14/5.15
To:     Leon Romanovsky <leon@kernel.org>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 11, 2021 at 12:29 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Nov 11, 2021 at 08:48:08AM +0100, Jinpu Wang wrote:
> > Hi Jason, hi Leon,
> >
> > We are seeing exactly the same error reported here:
> > https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> >
> > I suspect it's related to
> > https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> >
> > Do you have any idea, what goes wrong?
>
> I can't reproduce it with latest Fedora 34 RPM, which I downloaded from here
> https://koji.fedoraproject.org/koji/buildinfo?buildID=1851842
>
> and also with kernel-5.14.7-200.fc34.x86_64 version mentioned in the bug
> report.
>
> [leonro@c-235-8-1-005 ~]$ uname -a
> Linux c-235-8-1-005 5.14.7-200.fc34.x86_64 #1 SMP Wed Sep 22 14:54:28 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> [leonro@c-235-8-1-005 ~]$ rdma dev
> 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
>
> [leonro@c-235-8-1-005 ~]$ uname -a
> Linux c-235-8-1-005 5.14.16-201.fc34.x86_64 #1 SMP Wed Nov 3 13:57:29 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> [leonro@c-235-8-1-005 ~]$ rdma dev
> 0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
> 1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
> [leonro@c-235-8-1-005 ~]$ lspci |grep nox
> 08:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
> 09:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
>
> Thanks
>
Hi,

I tried different host with CX-3/CX-5, they all work fine. and I can
only reproduce on hosts with a bit old HCA:
03:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe
2.0 5GT/s - IB QDR / 10GigE] (rev b0)

The bug report link
https://bugzilla.redhat.com/show_bug.cgi?id=2014094, mentioned HCA
ConnectX too.

01:00.0 InfiniBand [0c06]: Mellanox Technologies MT25408A0-FCC-GI
ConnectX, Dual Port 20Gb/s InfiniBand / 10GigE Adapter IC with PCIe
2.0 x8 5.0GT/s In... (rev b0)
with the instrument, I only narrow it down to
1438                 port = setup_port(coredev, port_num, &attr);
1439                 if (IS_ERR(port)) {
1440                         ret = PTR_ERR(port);
1441                         pr_info("setup ports failed %d\n", ret);
1442                         goto err_put;
1443                 }

[   43.795268] <mlx4_ib> mlx4_ib_add: counter index 1 for port 2 allocated 0
[   43.830809] setup ports failed -12
[   43.830814] infiniband mlx4_0: Couldn't register device with driver model

My guess is the ConnectX HCA may be missing some features, which leads
to ENOMEM, I will continue the instrument if no other hint.

Thanks
