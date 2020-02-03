Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD7150F1E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 19:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgBCSJm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 13:09:42 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44006 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgBCSJm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 13:09:42 -0500
Received: by mail-il1-f195.google.com with SMTP id o13so13438366ilg.10
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 10:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEuT6cD25vtjWhrCsXyoMA7kdZT9wGb+fIyDm7sga8M=;
        b=J5AqllaFq/jH/1j3NntrqvgCnVmwuVsboFA5MYquPoBC+Rla7pjcxmLqQcTh9/Bz5n
         xlge/Y/qK4AEP/EgEbnbwNJdhDud2QO19hbslAYAtw93T1n7ZlHDXrQYetYOSCb4LuK5
         dEG82uu94KmK5jt6FJ8vM0AfBFXkxAoLqK3LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEuT6cD25vtjWhrCsXyoMA7kdZT9wGb+fIyDm7sga8M=;
        b=YT+ByZbk4kYi+2EyoOut4KRBjw4Q7ZjFvQ53oUNs3sakUGBov9/D6SOQjk0BLKKwW6
         ck7OSe5CbRZ+oyX0NUjQtfGqv8bKkaEUHtayYqIMWWpHllqNgnytYnARHCbO9S5Y5e0x
         cFdybgRLu2aiYCdfUEfkFJ84+wYlL9Arle4IrGUftScChypGVSvN9KZi2li9drhFdc++
         G0PkZF4/JR33lB3AJYCR8WRFl7nH2VHUnMm5qeQFXrJM3HMVqsqPiFWBFiRVpZitRb+n
         RvIjaew9snTDiznLSeGjxHXNf1SO193z/ND0ZT26AX3erq46+M5LXKiXFYgC7SskPtog
         JCIg==
X-Gm-Message-State: APjAAAXRuLKHlwaibA1CRY0hhpp25um6KRJEGlzW07BM6N/coc4lctGc
        9OeFVCoQ5mNA9l2TwUpMIQWApD2jR/Xi0/NQaAMt/A==
X-Google-Smtp-Source: APXvYqyWMqLMTCD2zfToVVvyRF6ncuF4w6WlLoRr8JhHNaBRwQ+U9EFoWMGoqKE5q0nLOYx2qgBamI6aigWSHiusHVw=
X-Received: by 2002:a92:bf10:: with SMTP id z16mr16458686ilh.87.1580753381257;
 Mon, 03 Feb 2020 10:09:41 -0800 (PST)
MIME-Version: 1.0
References: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com>
 <20200203175317.GQ23346@mellanox.com> <CANjDDBh_Xv0BNhTYZ1xaaOCQ8-ijHUMqDE68_J4aqRF-EnT2Zg@mail.gmail.com>
 <20200203180405.GR23346@mellanox.com>
In-Reply-To: <20200203180405.GR23346@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 3 Feb 2020 23:39:04 +0530
Message-ID: <CANjDDBj5HyvWb1rG8j9NedA=yAA5Venxk-8kd8c6fhq56iXiwA@mail.gmail.com>
Subject: Re: [PATCH v5] libibverbs: display gid type in ibv_devinfo
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 3, 2020 at 11:34 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Feb 03, 2020 at 11:31:06PM +0530, Devesh Sharma wrote:
> > On Mon, Feb 3, 2020 at 11:23 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Mon, Feb 03, 2020 at 12:52:04PM -0500, Devesh Sharma wrote:
> > > > It becomes difficult to make out from the output of ibv_devinfo
> > > > if a particular gid index is RoCE v2 or not.
> > > >
> > > > Adding a string to the output of ibv_devinfo -v to display the
> > > > gid type at the end of gid.
> > > >
> > > > The output would look something like below:
> > > > $ ibv_devinfo -v -d bnxt_re2
> > > > hca_id: bnxt_re2
> > > >  transport:             InfiniBand (0)
> > > >  fw_ver:                216.0.220.0
> > > >  node_guid:             b226:28ff:fed3:b0f0
> > > >  sys_image_guid:        b226:28ff:fed3:b0f0
> > > >   .
> > > >   .
> > > >   .
> > > >   .
> > > >        phys_state:      LINK_UP (5)
> > > >        GID[  0]:               fe80::b226:28ff:fed3:b0f0, IB/RoCE v1
> > > >        GID[  1]:               fe80::b226:28ff:fed3:b0f0, RoCE v2
> > > >        GID[  2]:               ::ffff:192.170.1.101, IB/RoCE v1
> > > >        GID[  3]:               ::ffff:192.170.1.101, RoCE v2
> > >
> > > v1 GIDs are GIDs and should never be formed as IPv6 addreses..
> > So, V1 gids would fall back to old style of display and there will be
> > one more check for gid-type inside the loop...
>
> Yes
Sure.
>
> Parav should we show both the v6 and classic format for a v2 GID? ie
>
>         GID[  3]:               0000:0000:0000:ffff:xxxx:xxxx:xxxx, RoCE v2
>                                 ::ffff:192.170.1.101
>
> Lets also supress the 'IB/RoCE v1' string on !roce device. IB only has
> one GID type, there is no reason to print anything
W.r.t. IB devices, this makes sense, While sending v1 I had a thought
in mind on IB devices.
>
> Jason
