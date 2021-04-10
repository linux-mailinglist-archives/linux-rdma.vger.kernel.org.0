Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A489C359BB3
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Apr 2021 12:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhDIKPm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Apr 2021 06:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhDIKNx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Apr 2021 06:13:53 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092CBC0613F0
        for <linux-rdma@vger.kernel.org>; Fri,  9 Apr 2021 03:12:13 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id m13so5202172oiw.13
        for <linux-rdma@vger.kernel.org>; Fri, 09 Apr 2021 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uu3qVfx+7w9jxHiUwAe7eFdK6umncczG0xdPmz1lIjQ=;
        b=ttKUSNCz4tE8mNbjpd64JV0uh7lVymP7ooThi/BJuEJV5dtKiGlT25JdSMpw2KacZq
         Fq8JShgXP39lHTw5g/mSRrJiIEDA/nupOFF0x6XibOIiMAFiTwWhvJV1bjUhMg9GW0m7
         j71rfkeKb3N8PmfGGFFl1K/9zOy/pTiltWel6FzfoDjtsQGxsuvh8rk7BksuOt0zj4Hd
         lFr8oZt7MEB843U8+dd1+tXPHFHksFhx24hFjn8vqg2yaVFFevgCe9J4CEKwa4VA9mt1
         MUog4nXPUKZvqjMIvSHCgdFagl9s867zHysCYFYn88x31slwAkc5Mrw2ekuripM6B9fq
         fYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uu3qVfx+7w9jxHiUwAe7eFdK6umncczG0xdPmz1lIjQ=;
        b=PCevMd/Z/oG5ynr1ENMwrkAbVvfY0ZqnQu0eWeX9N6xPhLUaUhmoxw1zRd3gAHKzSc
         V/GHo7Ojy9Mm4PlzuBVIXtsfnFlJyc3HyJHeWPsqwI42mn/D/5yOiiBet8Gt0GTjSP0Q
         EM29mcWL9uDdd42pDsl7MjSU0KyYv8B+TrwI9r3z9DxOE76PNcksW2LLvRMbKO3AyI/d
         fx14Rt0wSg07gT9sI2aBfGGfKMLMd+FkDPF3dNLNiX40rQHX8mlH9nDLVECGz3vGvNoI
         Ti9xxxedeAw7IJmD+nyMrd1hCRf0W2tEr1uvQX55+ucei6WSHovvgAtlHxrj8GFNNJ/n
         KYcw==
X-Gm-Message-State: AOAM532Pxox50I1ckA0qnlwF0StGFaKwn977cE8amhUPlAe+3/3dRp6s
        SnEC+lJl4RSnPHwxZbZeHtUUgmAGmtDgr3F//RM=
X-Google-Smtp-Source: ABdhPJxAZICXVI1dlvJlU5lDvI29TRSRJcAmkckMYX3PJL1xoNQdQaEbNKauco16OmrGRSDwP16ibm8IU7SAaIKR3iM=
X-Received: by 2002:aca:490e:: with SMTP id w14mr214510oia.169.1617963131556;
 Fri, 09 Apr 2021 03:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210326012723.41769-1-yanjun.zhu@intel.com> <20210408183359.GA676678@nvidia.com>
In-Reply-To: <20210408183359.GA676678@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 9 Apr 2021 22:36:42 -0400
Message-ID: <CAD=hENehGzGn=nxNO0B8u=nevFx1CGsiovxtir3OCZ2ffVB1gQ@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable set in cmdline
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 8, 2021 at 2:34 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Mar 25, 2021 at 09:27:23PM -0400, Zhu Yanjun wrote:
> > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> >
> > When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> > in the stack. As such, the operations of ipv6 in RXE will fail.
> > So ipv6 features in RXE should also be disabled in RXE.
> >
> > Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > Tested-by: Yi Zhang <yi.zhang@redhat.com>
> > V2->V3: Remove print message
> > V1->V2: Modify the pr_info messages
> >  drivers/infiniband/sw/rxe/rxe_net.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> > index 01662727dca0..3b8ed007e8af 100644
> > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > @@ -72,6 +72,9 @@ static struct dst_entry *rxe_find_route6(struct net_device *ndev,
> >       struct dst_entry *ndst;
> >       struct flowi6 fl6 = { { 0 } };
> >
> > +     if (!ipv6_mod_enabled())
> > +             return NULL;
> > +
> >       memset(&fl6, 0, sizeof(fl6));
> >       fl6.flowi6_oif = ndev->ifindex;
> >       memcpy(&fl6.saddr, saddr, sizeof(*saddr));
>
> What is this actually fixing?
>
> ndst = ipv6_stub->ipv6_dst_lookup_flow() will return an error if the
> ipv6 support is not loaded so why do we need more tests?

As what I said in commit log, when "When ipv6.disable=1 is set in
cmdline, ipv6 is actually disabled"
That is, when cat /proc/cmdline, the command line is
"
cat /proc/cmdline
BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.12.0-rc3+ root=/dev/mapper/cl-root
ro resume=/dev/mapper/cl-swap rd.lvm.lv=cl/root rd.lvm.lv=cl/swap
crashkernel=512M ipv6.disable=1
"
And if you make the above configurations, then modprobe rdma_rxe should work.
then ''rdma link add rxe0 type rxe netdev eth0" should work well.
ndst = ipv6_stub->ipv6_dst_lookup_flow should not be called.
Can you tell me how to disable IPV6 in your test host?

> in the stack. As such, the operations of ipv6 in RXE will fail.
> So ipv6 features in RXE should also be disabled in RXE."

>
> > @@ -616,6 +619,8 @@ static int rxe_net_ipv4_init(void)
> >  static int rxe_net_ipv6_init(void)
> >  {
> >  #if IS_ENABLED(CONFIG_IPV6)
> > +     if (!ipv6_mod_enabled())
> > +             return 0;
> >
> >       recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> >                                               htons(ROCE_V2_UDP_DPORT), true);
>
> rxe_setup_udp_tunnel() should already fail naturally because the V6
> socket won't be created
>
> What is the actual symptom this patch is trying to address?

This patch is try to fix the problem in the link
https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t

Zhu Yanjun

>
> Jason
