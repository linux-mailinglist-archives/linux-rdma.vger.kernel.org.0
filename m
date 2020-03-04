Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A05E1791E8
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 15:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCDOG6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 09:06:58 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46024 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDOG6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 09:06:58 -0500
Received: by mail-il1-f196.google.com with SMTP id s201so1153627ilc.12
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 06:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfjzUCbDLhFNsZdN5aVe4fJwcxXS61usa1QBsBujdDI=;
        b=a/9Rq5yXpdKxM/tCSyf2BJEDDwIMzmMLCc3obIaXd0Sv5Y8TQFIuTtZJD5/FWAwIxP
         u15AjsLBwzrkJ2Pt8x9LIdzVf+FTuJ3N1He6+HsdwFs38HCOnpgsUrHnj8wxLEkPa6RM
         Lg6+NOXxjIjp429g0NH7/NJ0XyKQd4lWHlno5kaMbcoRna/SbEiS/LvxywI6xo9AfZX2
         YKHn1X7MIbaefp78REH93Zwl7IDRm4FWXOfrRxoNkcsdFbafJkZuKfwHyN8AMKn9aAty
         e6rtI0ZS6OtsY3u51ioydW1UlKHtMG89D0BZrItocftS2r9Aa/YZzPHBZNWsSOUrRetV
         ByiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfjzUCbDLhFNsZdN5aVe4fJwcxXS61usa1QBsBujdDI=;
        b=HDC31PHr4gQ706KeDShP/NENp9c5ZkQfvA4Uq+9MFBjRm3lVtvn9xigCeLzCZj/iZI
         QhZilJEntAiMfEf8da2jPtEjq8Rm4zey7PGAf8ycrETX7yGB0TO/kvNMg1tooEs+VZYQ
         KP5g+VsGilGNskIZdN1uAxgIJAt6UlvgbIotggLl+lw7UZZqSwFX9WyhnS697PGtkeXY
         KSYzs0ZrGaqR9Y4qdJclnBFNRgLuhYEidRSzlXrOMTdhPQFSktMTLcN68mbnweDFN4iD
         MQkJvnlAIkyUAXQ9KsqGGgSPIqq5Due/CpyLqCIdZoNFx54qV+Lz6Lpma40qZ5Su5k2C
         zZ+Q==
X-Gm-Message-State: ANhLgQ0ympdNTCXMv8t9zylYSsfBg0wZLCj1wOKRfe7t7lJmE/IAIPUF
        baG+7T50eY3Gmb1BYQngHyHGeYQ6qpDkMOudN8+uDA==
X-Google-Smtp-Source: ADFU+vvVrJhJj3lvIcgyYn3hijbAhsxZrIvpyfcjqI5E4MdkVHsL1OaRA6Zsb1dkhiHJJfDUbgi01nJfTqLOx2iLlwo=
X-Received: by 2002:a92:8893:: with SMTP id m19mr2796823ilh.54.1583330817069;
 Wed, 04 Mar 2020 06:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200303092849.GH121803@unreal>
In-Reply-To: <20200303092849.GH121803@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 4 Mar 2020 15:06:46 +0100
Message-ID: <CAMGffEkoyScOn1e9DuPL_S3pvGB5A-4QQ_8awS4A0Syar1RdcA@mail.gmail.com>
Subject: Re: [PATCH v9 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 3, 2020 at 10:28 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Feb 21, 2020 at 11:46:56AM +0100, Jack Wang wrote:
> > Hi all,
> >
> > Here is v9 of  the RTRS (former IBTRS) RDMA Transport Library and the
> > corresponding RNBD (former IBNBD) RDMA Network Block Device, which includes
> > changes to address comments from the community.
> >
> > Introduction
> > -------------
> >
> > RTRS (RDMA Transport) is a reliable high speed transport library
> > which allows for establishing connection between client and server
> > machines via RDMA. It is based on RDMA-CM, so expect also to support RoCE
> > and iWARP, but we mainly tested in IB environment. It is optimized to
> > transfer (read/write) IO blocks in the sense that it follows the BIO
> > semantics of providing the possibility to either write data from a
> > scatter-gather list to the remote side or to request ("read") data
> > transfer from the remote side into a given set of buffers.
> >
> > RTRS is multipath capable and provides I/O fail-over and load-balancing
> > functionality, i.e. in RTRS terminology, an RTRS path is a set of RDMA
> > connections and particular path is selected according to the load-balancing
> > policy. It can be used for other components beside RNBD.
> >
> > Module parameter always_invalidate is introduced for the security problem
> > discussed in LPC RDMA MC 2019. When always_invalidate=Y, on the server side we
> > invalidate each rdma buffer before we hand it over to RNBD server and
> > then pass it to the block layer. A new rkey is generated and registered for the
> > buffer after it returns back from the block layer and RNBD server.
> > The new rkey is sent back to the client along with the IO result.
> > The procedure is the default behaviour of the driver. This invalidation and
> > registration on each IO causes performance drop of up to 20%. A user of the
> > driver may choose to load the modules with this mechanism switched off
> > (always_invalidate=N), if he understands and can take the risk of a malicious
> > client being able to corrupt memory of a server it is connected to. This might
> > be a reasonable option in a scenario where all the clients and all the servers
> > are located within a secure datacenter.
> >
> > RNBD (RDMA Network Block Device) is a pair of kernel modules
> > (client and server) that allow for remote access of a block device on
> > the server over RTRS protocol. After being mapped, the remote block
> > devices can be accessed on the client side as local block devices.
> > Internally RNBD uses RTRS as an RDMA transport library.
> >
> > Commits for kernel can be found here:
> >    https://github.com/ionos-enterprise/ibnbd/commits/linux-5.6-rc2-ibnbd-v9
> >
> > Testing
> > -------
> >
> > All the changes have been tested with our regression testsuite in our staging environment
> > in IONOS data center. it's around 200 testcases, for both always_invalidate=N and
> > always_invalidate=Y configurations.
> >
> > Changelog
> > ---------
> > v9:
> >  o Rebased to linux-5.6-rc2
> >  o Update Date/Kernel version in Documentation
> >  o Update description in Kconfig for RNBD
> >  o rtrs-clt: inline rtrs_clt_decrease_inflight
> >  o rtrs-clt: only track inflight for Min_inflight policy
> > v8:
> >  o Rebased to linux-5.5-rc7
> >  o Reviewed likey/unlikely usage, only keep the one in IO path suggested by Leon Romanovsky
> >  o Reviewed inline usage, remove inline for functions longer than 5 lines of code suggested by Leon
> >  o Removed 2 WARN_ON suggested by Leon
> >  o Removed 2 empty lines between copyright suggested by Leon
> >  o Makefile: remove compat include for upstream suggested by Leon
> >  o rtrs-clt: remove module parameters suggested by Leon
> >  o drop rnbd_clt_dev_is_mapped
> >  o rnbd-clt: clean up rnbd_rerun_if_needed
> >  o rtrs-srv: remove reset_all sysfs
> >  o rtrs stats: remove wc_completion stats
> >  o rtrs-clt: enhance doc for rtrs_clt_change_state
> >  o rtrs-clt: remove unused rtrs_permit_from_pdu
> >  * https://lore.kernel.org/linux-block/20200124204753.13154-1-jinpuwang@gmail.com/
> > v7:
> >  o Rebased to linux-5.5-rc6
> >  o Implement code-style/readability/API/Documentation etc suggestions by Bart van Assche
> >  o Make W=1 clean
> >  o New benchmark results for Mellanox ConnectX-5
> >  o second try adding MAINTAINERS entries in alphabetical order as Gal Pressman suggested
> >  * https://lore.kernel.org/linux-block/20200116125915.14815-1-jinpuwang@gmail.com/
> > v6:
> >   o Rebased to linux-5.5-rc4
> >   o Fix typo in my email address in first patch
> >   o Cleanup copyright as suggested by Leon Romanovsky
> >   o Remove 2 redudant kobject_del in error path as suggested by Leon Romanovsky
> >   o Add MAINTAINERS entries in alphabetical order as Gal Pressman suggested
> >   * https://lore.kernel.org/linux-block/20191230102942.18395-1-jinpuwang@gmail.com/
> > v5:
> >   o Fix the security problem pointed out by Jason
> >   o Implement code-style/readability/API/etc suggestions by Bart van Assche
> >   o Rename IBTRS and IBNBD to RTRS and RNBD accordingly
> >   o Fileio mode support in rnbd-srv has been removed.
> >   * https://lore.kernel.org/linux-block/20191220155109.8959-1-jinpuwang@gmail.com/
> > v4:
> >   o Protocol extended to transport IO priorities
> >   o Support for Mellanox ConnectX-4/X-5
> >   o Minor sysfs extentions (display access mode on server side)
> >   o Bug fixes: cleaning up sysfs folders, race on deallocation of resources
> >   o Style fixes
> >   * https://lore.kernel.org/linux-block/20190620150337.7847-1-jinpuwang@gmail.com/
> > v3:
> >   o Sparse fixes:
> >      - le32 -> le16 conversion
> >      - pcpu and RCU wrong declaration
> >      - sysfs: dynamically alloc array of sockaddr structures to reduce
> >          size of a stack frame
> >   o Rename sysfs folder on client and server sides to show source and
> >     destination addresses of the connection, i.e.:
> >          .../<session-name>/paths/<src@dst>/
> >   o Remove external inclusions from Makefiles.
> >   * https://lore.kernel.org/linux-block/20180606152515.25807-1-roman.penyaev@profitbricks.com/
> > v2:
> >   o IBNBD:
> >      - No legacy request IO mode, only MQ is left.
> >   o IBTRS:
> >      - No FMR registration, only FR is left.
> >   * https://lore.kernel.org/linux-block/20180518130413.16997-1-roman.penyaev@profitbricks.com/
> > v1:
> >   o IBTRS: load-balancing and IO fail-over using multipath features were added.
> >   o Major parts of the code were rewritten, simplified and overall code
> >     size was reduced by a quarter.
> >   * https://lore.kernel.org/linux-block/20180202140904.2017-1-roman.penyaev@profitbricks.com/
> > v0:
> >   o Initial submission
> >   * https://lore.kernel.org/linux-block/1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com/
> >
> > As always, please review and share your comments, and consider to merge to
> > upstream.
> >
> > Thanks.
> >
>
> I still see module parameters and prints after allocation failures.

I will remove all prints after allocation failure, will also review
and remove unneeded module parameters.

Thanks!
