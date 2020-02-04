Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB015172C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 09:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgBDIu5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 03:50:57 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33827 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgBDIu5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Feb 2020 03:50:57 -0500
Received: by mail-il1-f193.google.com with SMTP id l4so15199945ilj.1
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2020 00:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBZHNAh7IF58rvr2WJpc+V1Fcx/ZMbd4NCdg8+WmIck=;
        b=MdUw+sbVJDfVrf0SHVsgdprtQmzkDadu7OfIUjbUwpZryapfuR6UAmPDqxgACwzA5v
         +CEW0DGvAOUwtm027B7nczChJHF3lT9Vz+aE/Y4s7xQ/xau82Pa6PdN9L2vhUmCiuhiG
         hLxZn4qhJsQEHUozRi1ZfhzhzyLw8d5XGMkJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBZHNAh7IF58rvr2WJpc+V1Fcx/ZMbd4NCdg8+WmIck=;
        b=iKXuxJthKqQ1JJgHIdB36RfynOre+i6ZLOhbibpbzZ9/bQ99d3kUGo5Hg5qwcNnO84
         HyAtuAr6PZ1i2JfsMvVvj3Xqy89rlnCMJjkQ6SfXXVh8dbadstgKPsAMGzaXCLM+oAp9
         DvMq46Ux/MvOotg9zQTO4i1PLDAu9NNVAAzKT1cP0GzRu3qBArVoWARciDM2mBoNPCBo
         VxM5aHgqdPZ3z6ntpBJyZybgU/kKbhJfG3cu3DbcRMy3Sfmiy2stAcOBaExTpY6eS0jq
         1dUbfLFaP7W9y7JICYuJuVrbJWs+JOLY++fjXPc7lWS2qnrgqlWH3DBkPzejhrAFJwNb
         np7A==
X-Gm-Message-State: APjAAAWviEfydQiF9GRmlfyPE3kcPRPwaLAKiEZKNRlgesnzx3XTjZjs
        G/jYhQAVDedzIP3ccstcDx11N+HhyFgjEPeyJOtJqQ==
X-Google-Smtp-Source: APXvYqxwTLMHI9MxdjqfBHi6pJGv4yvpWKcjjXqOkTOVrSPSH9OnUrb0EWMBtDbC/lAtV7Ty1Mzrjb7Ko7uxybz8MJs=
X-Received: by 2002:a92:d7cd:: with SMTP id g13mr20235988ilq.300.1580806256641;
 Tue, 04 Feb 2020 00:50:56 -0800 (PST)
MIME-Version: 1.0
References: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com>
 <20200203175317.GQ23346@mellanox.com> <CANjDDBh_Xv0BNhTYZ1xaaOCQ8-ijHUMqDE68_J4aqRF-EnT2Zg@mail.gmail.com>
 <20200203180405.GR23346@mellanox.com> <AM0PR05MB486694589EA1CBC66F598066D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20200204071739.GV414821@unreal> <AM0PR05MB4866502B08D18DAF65D9A61FD1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CANjDDBg_=eJH_ADJzvm7mVhJtMgjDh38kPB-PcDGh56WsAKfLg@mail.gmail.com>
In-Reply-To: <CANjDDBg_=eJH_ADJzvm7mVhJtMgjDh38kPB-PcDGh56WsAKfLg@mail.gmail.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Tue, 4 Feb 2020 14:20:20 +0530
Message-ID: <CANjDDBjNGJ_1S2rwKNUsDU9XLnBVMzsWADbYb0CHg-wELBkidw@mail.gmail.com>
Subject: Re: [PATCH v5] libibverbs: display gid type in ibv_devinfo
To:     Parav Pandit <parav@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 4, 2020 at 2:14 PM Devesh Sharma <devesh.sharma@broadcom.com> wrote:
>
> On Tue, Feb 4, 2020 at 12:55 PM Parav Pandit <parav@mellanox.com> wrote:
> >
> > Hi Leon,
> >
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Tuesday, February 4, 2020 12:48 PM
> > >
> > > On Tue, Feb 04, 2020 at 04:27:45AM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > > > Sent: Monday, February 3, 2020 11:34 PM
> > > > >
> > > > > On Mon, Feb 03, 2020 at 11:31:06PM +0530, Devesh Sharma wrote:
> > > > > > On Mon, Feb 3, 2020 at 11:23 PM Jason Gunthorpe <jgg@mellanox.com>
> > > > > wrote:
> > > > > > >
> > > > > > > On Mon, Feb 03, 2020 at 12:52:04PM -0500, Devesh Sharma wrote:
> > > > > > > > It becomes difficult to make out from the output of
> > > > > > > > ibv_devinfo if a particular gid index is RoCE v2 or not.
> > > > > > > >
> > > > > > > > Adding a string to the output of ibv_devinfo -v to display the
> > > > > > > > gid type at the end of gid.
> > > > > > > >
> > > > > > > > The output would look something like below:
> > > > > > > > $ ibv_devinfo -v -d bnxt_re2
> > > > > > > > hca_id: bnxt_re2
> > > > > > > >  transport:             InfiniBand (0)
> > > > > > > >  fw_ver:                216.0.220.0
> > > > > > > >  node_guid:             b226:28ff:fed3:b0f0
> > > > > > > >  sys_image_guid:        b226:28ff:fed3:b0f0
> > > > > > > >   .
> > > > > > > >   .
> > > > > > > >   .
> > > > > > > >   .
> > > > > > > >        phys_state:      LINK_UP (5)
> > > > > > > >        GID[  0]:               fe80::b226:28ff:fed3:b0f0, IB/RoCE v1
> > > > > > > >        GID[  1]:               fe80::b226:28ff:fed3:b0f0, RoCE v2
> > > > > > > >        GID[  2]:               ::ffff:192.170.1.101, IB/RoCE v1
> > > > > > > >        GID[  3]:               ::ffff:192.170.1.101, RoCE v2
> > > > > > >
> > > > > > > v1 GIDs are GIDs and should never be formed as IPv6 addreses..
> > > > > > So, V1 gids would fall back to old style of display and there will
> > > > > > be one more check for gid-type inside the loop...
> > > > >
> > > > > Yes
> > > > >
> > > > > Parav should we show both the v6 and classic format for a v2 GID? ie
> > > > >
> > > > >         GID[  3]:               0000:0000:0000:ffff:xxxx:xxxx:xxxx, RoCE v2
> > > > >                                 ::ffff:192.170.1.101
> > > > >
> > > > Due to lack of support of GID's netdev, v1/v2 type info in ibv_devinfo output,
> > > most users that I know of are using non upstream show_gids script.
> > > > So changing format here shouldn't break the existing users scripts.
> > > > There may be some scripts that may find this format different.
> > > > So I think printing both is likely a more safer option.
> > >
> > > I don't understand this argument. Output from example tool (ibv_devinfo)
> > > inside libibverbs can't be considered API and we can't live in constant fear that
> > > some user script will break. Of course, we will try to keep it stable, but there is
> > > no such promise.
> > >
> > I agree with your point that ibv_devinfo output is not an API.
> > I haven't come across a user who uses ibv_devinfo output as an API given lack of info in it.
> > I really do not have any strong opinion to keep both format or single format.
>
> To it looks dirty, if the tool would print both things would look
> something like:
> phys_state:             LINK_UP (5)
>                         GID[  0]:
> fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
>                         GID[  1]:
> fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
>                         GID[  1]:               fe80::b226:28ff:fed3:b0f0
>                         GID[  2]:
> 0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
>                         GID[  3]:
> 0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v2
>                         GID[  3]:               ::ffff:192.170.1.101

Re-post with re-formating:
phys_state:             LINK_UP (5)
                        GID[  0]:
fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
                        GID[  1]:
fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
                        GID[  1]: fe80::b226:28ff:fed3:b0f0
                        GID[  2]:
0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
                        GID[  3]:
0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v2
                        GID[  3]: ::ffff:192.170.1.101
