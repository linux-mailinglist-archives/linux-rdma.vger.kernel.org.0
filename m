Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAB2423B41
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhJFKL4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 06:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237822AbhJFKL4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 06:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C04FF6113A;
        Wed,  6 Oct 2021 10:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633515004;
        bh=RUk8IzsaAAxDUuEscLmsd00ae5Ben9+hFoTUkQiilTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1zSSdcqNK7BYa6wAtlP1AkPD4b7Whjq7c9k8iwimJgiWjXmv0OeiMDf4WpZvfAby
         ZFg7Hb5Qo4G6GuYhQRNGORuVGxgWEjvrOlbZ0zYPfO2fZCtSzjOqul2N56c4tsAobe
         QxQex5/kNW1NQF9DIlkpYZ6+iYHWDwumwLIZSTdkl4d3mM0h+zqIhrqJAPk/PHN8QJ
         kPVePnYgBPvg8MAS0lvmLdy/9OMXho5OWCp/M2l9Eqx1Sbs6mHLxXZBVi4vMo/oDIz
         uCsWXDy0XdaZsEsGb1RL3ORovjA31CYhs+ED8aH2egjra+agY20pzmYSk9p567xA/b
         DbfFanWmUbg0g==
Date:   Wed, 6 Oct 2021 13:10:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Doug Ledford <dledford@redhat.com>,
        syzbot <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: RESTRACK detected leak of resources
Message-ID: <YV11+OljDThGAalY@unreal>
References: <0000000000005a800a05cd849c36@google.com>
 <CACT4Y+ZRrxmLoor53nkD54sA5PJcRjWqheo262tudjrLO2rXzQ@mail.gmail.com>
 <20211004131516.GV3544071@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004131516.GV3544071@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 04, 2021 at 10:15:16AM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 04, 2021 at 02:42:11PM +0200, Dmitry Vyukov wrote:
> > On Mon, 4 Oct 2021 at 12:45, syzbot
> > <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    c7b4d0e56a1d Add linux-next specific files for 20210930
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=104be6cb300000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c9a1f6685aeb48bd
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3a992c9e4fd9f0e6fd0e
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com
> > 
> > +RESTRACK maintainers
> > 
> > (it would also be good if RESTRACK would print a more standard oops
> > with stack/filenames, so that testing systems can attribute issues to
> > files/maintainers).
> 
> restrack certainly should trigger a WARN_ON to stop the kernel.. But I
> don't know what stack track would be useful here. The culprit is
> always the underlying driver, not the core code..

We had WARN_ON() in early versions, but it didn't give us anything
except spammed dmesg, so I changed it to more lighter version.

> 
> Anyhow, this report is either rxe or rds by the look of it.
> 
> Jason
