Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83D36E1149
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 17:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDMPiq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 11:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDMPip (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 11:38:45 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA9C10F3
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 08:38:44 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id mu15so383621qvb.10
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681400323; x=1683992323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPofEC3M3pJ25sYfIHrqsj1mLGA7EWsC1qDpjqd0pZw=;
        b=e3JslS3/eKDS1Vle9OHA8lpL+IAXtsygR/GHZsGtYIn9P6l3QccTVkfSfBSknbnutA
         RT2/Uz1gZ7iO6giOVG7+SqpzckFr0TYebaEz2QLCyOLh8FBRBohJ/wBXCnwn7MKwbOMt
         tYXS3OLiafyEn3wwLLXiDr6r6LvOO3UeVPYpOexqJpa0I6uCTOZC1OQX2Fu3uUA90YGW
         MUnmdzw8WdvKVQkWw2t/O3odcTA/+EVO352XZAnlX+S3XtRBUhbHlN+ohgRBNB4fe7Ud
         5K7EXahgfp7qE3Y4BUvFRQ0mejZ6as+5sVRGUtS/+QYUseBgh7/jux3yD8U1+AaQrbeF
         fPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681400323; x=1683992323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPofEC3M3pJ25sYfIHrqsj1mLGA7EWsC1qDpjqd0pZw=;
        b=lztAWRuPCV8UMGiUZRltsnfKMdPDQ7v2hQXe/LxCn04dOTf4rFjIEOjm/kdYRMW5wF
         Aiknq0spnuXeEuivdTuFxzIkqkvGQbCdUj2Y2hvpvDWf3KGaj1xiEqTnPhj9P9BMqYkY
         tZxpoGuHpaKAKVSw0HdrwzH0Q+qbWFSUQD1MdnWYVybpJHSwdnBt24HEmPM9/DGOecxI
         FoaV/3ZSDRm6OD8YEYbC47Hrt49RMpvYl7XnaFPfs69Xr0aWMBY5vysC+zS3agBbwiKE
         dpwt9Bz5Wmg9uLjZhiRXe5x3netYpx1qUxIDHmds7gYlglUgZrYkirTTjJIYpSO9XY/g
         s0Uw==
X-Gm-Message-State: AAQBX9cSKq7TzsQyB2wNQBq1jAYLeYzvEhYxAicgHYwtRQhg32lmHXdS
        F15AyohqKEAfzVwSZ3/YIUin99PuzcLoXa96ZMk=
X-Google-Smtp-Source: AKy350bsQMCETBwyNLswzbafDObOI8tjQWroK50vFyVfelhDZTdSzuo+MxJEOsfyqVR2Jk7Y6HOXxZ/HoR9qqc8Xfwg=
X-Received: by 2002:ad4:48d3:0:b0:5ef:528d:8899 with SMTP id
 v19-20020ad448d3000000b005ef528d8899mr278635qvx.4.1681400323565; Thu, 13 Apr
 2023 08:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230214060634.427162-1-yanjun.zhu@intel.com> <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
 <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
 <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev> <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
 <PH0PR12MB548169DB2D2364DF3ED9E2F3DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548169DB2D2364DF3ED9E2F3DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
From:   Mark Lehrer <lehrer@gmail.com>
Date:   Thu, 13 Apr 2023 09:38:32 -0600
Message-ID: <CADvaNzXm-KZZQuo2w1ovQ+-w78-DW5ewRPPY_cjvprHCNzCe_A@mail.gmail.com>
Subject: Re: [PATCHv3 0/8] Fix the problem that rxe can not work in net namespace
To:     Parav Pandit <parav@nvidia.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Didn=E2=80=99t get a chance to review the thread discussion.
> The way to use VF is:

Virtual functions were just a debugging aid.  We really just want to
use a single physical function and put it into the netns.  However, we
will do additional VF tests as it still may be a viable workaround.

When using the physical function, we are still having no joy using
exclusive mode with mlx5:


# nvme discover -t rdma -a 192.168.42.11 -s 4420
Discovery Log Number of Records 2, Generation counter 2
=3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D
... (works as expected)

# rdma system set netns exclusive
# ip netns add netnstest
# ip link set eth1 netns netnstest
# rdma dev set mlx5_0 netns netnstest
# nsenter --net=3D/var/run/netns/netnstest /bin/bash
# ip link set eth1 up
# ip addr add 192.168.42.12/24 dev eth1
(tested ib_send_bw here, works perfectly)

# nvme discover -t rdma -a 192.168.42.11 -s 4420
Failed to write to /dev/nvme-fabrics: Connection reset by peer
failed to add controller, error Unknown error -1

# dmesg | tail -3
[  240.361647] mlx5_core 0000:05:00.0 eth1: Link up
[  240.371772] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[  259.964542] nvme nvme0: rdma connection establishment failed (-104)

Am I missing something here?

Thanks,
Mark


On Thu, Apr 13, 2023 at 7:05=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
>
> > From: Mark Lehrer <lehrer@gmail.com>
> > Sent: Thursday, April 13, 2023 9:01 AM
> >
> > > Do you make tests nvme + mlx5 + net ns in your host? Can it work?
> >
> > Sort of, but not really.  In our last test, we configured a virtual fun=
ction and put
> > it in the netns context, but also configured a physical function outsid=
e the netns
> > context.  TCP NVMe connections always used the correct interface.
> >
> Didn=E2=80=99t get a chance to review the thread discussion.
> The way to use VF is:
>
> 1. rdma system in exclusive mode
> $ rdma system set netns exclusive
>
> 2. Move netdevice of the VF to the net ns
> $ ip link set [ DEV ] netns NSNAME
>
> 3. Move RDMA device of the VF to the net ns
> $ rdma dev set [ DEV ] netns NSNAME
>
> You are probably missing #1 and #3 configuration.
> #1 should be done before creating any namespaces.
>
> Man pages for #1 and #3:
> [a] https://man7.org/linux/man-pages/man8/rdma-system.8.html
> [b] https://man7.org/linux/man-pages/man8/rdma-dev.8.html
>
> > However, the RoCEv2 NVMe connection always used the physical function,
> > regardless of the user space netns context of the nvme-cli process.
> > When we ran "ip link set <physical function> down" the RoCEv2 NVMe
> > connections stopped working, but TCP NVMe connections were fine.
> > We'll be doing more tests today to make sure we're not doing something
> > wrong.
> >
> > Thanks,
> > Mark
> >
> >
> >
> >
> > On Thu, Apr 13, 2023 at 7:22=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.de=
v> wrote:
> > >
> > >
> > > =E5=9C=A8 2023/4/13 5:01, Mark Lehrer =E5=86=99=E9=81=93:
> > > >> the fabrics device and writing the host NQN etc.  Is there an easy
> > > >> way to prove that rdma_resolve_addr is working from userland?
> > > > Actually I meant "is there a way to prove that the kernel
> > > > rdma_resolve_addr() works with netns?"
> > >
> > > I think rdma_resolve_addr can work with netns because rdma on mlx5 ca=
n
> > > work well with netns.
> > >
> > > I do not delve into the source code. But IMO, this function should be
> > > used in rdma on mlx5.
> > >
> > > >
> > > > It seems like this is the real problem.  If we run commands like
> > > > nvme discover & nvme connect within the netns context, the system
> > > > will use the non-netns IP & RDMA stacks to connect.  As an aside -
> > > > this seems like it would be a major security issue for container
> > > > systems, doesn't it?
> > >
> > > Do you make tests nvme + mlx5 + net ns in your host? Can it work?
> > >
> > > Thanks
> > >
> > > Zhu Yanjun
> > >
> > > >
> > > > I'll investigate to see if the fabrics module & nvme-cli have a way
> > > > to set and use the proper netns context.
> > > >
> > > > Thanks,
> > > > Mark
