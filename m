Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F080D23C056
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Aug 2020 21:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHDT7s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Aug 2020 15:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgHDT7r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Aug 2020 15:59:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C922C06174A;
        Tue,  4 Aug 2020 12:59:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so13246408pls.2;
        Tue, 04 Aug 2020 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n8qr9Xpstwwca8AXJiSUgtIod/3O027NBlrU0CWCi3I=;
        b=AIjpsI36psS/bZbywZzRkMmni/1aWo9RsguNrcZix6QjC3ELmBTizcdLnrYman3zS5
         rjayxz/JRvRyButW7/lH/kyS467vFoi0pfi0AItQ03cn6L7uXFxTXQFLY93Jq6O64w6B
         dOpE9HQDSF+mnWHGZwDnH0BbfuIHoD1BAGLOjClSQL0JpbXsLzrJJxiF9GfVw7FYI6x2
         DJykQw0mgk0hUkezmqqhDuqxAF+WO9bSCwlMRXpeF2DgxC00OBk3kC0n/7W5BF1HSzcA
         Etm7BG8avj4rHA5L12QOV5s3MCmUlUPauKo/PnaaFTr7Qb+SB+XiBnMtO5Ryius7m8Eq
         qWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n8qr9Xpstwwca8AXJiSUgtIod/3O027NBlrU0CWCi3I=;
        b=PtNjQeUZtWbkjI7tjcGNjUohyGUzrGckP/5NRltvujLeWPrq2Fe3f/EsDU7w+zhdaX
         1GW387i8DoDMy3SWHwjeSXauMzulnyRDroTa7UKpSAw3gxARnKZRJXbwjA2PHJC6+5yD
         aOXRvaLE1jDJBOMIQJD8F2QowtoG4tEejyTQdjUQzlT7DdXilzCCon6VR0ZXc31CfX3a
         JlIoH7/l3gT77szvpnZ4jYvEzpiCDMR2vjzPFLBty81+qLFpZoxjkfWJtxVyftYqR+OJ
         yB2HQNLSTtJpP2g9e4Ot87vqu0Mfw8ajhdA60v2/2ZmK/zorCm7d9hHp5vmD94dVIolt
         RNlg==
X-Gm-Message-State: AOAM532RPKir8Q5XnmFVJMNNRu/yahBKFFXE6gN9iVdWiJeSALoBVON+
        YaQlEYaDcad4CisLr942DwRTmjzkyt0=
X-Google-Smtp-Source: ABdhPJyFIZzJB6lcTN7Al6/93KEVK9f7bNiV3lcwLil5u3nnX1p7ox6z/hf6Wwyn/I/ykCmFKUIbPg==
X-Received: by 2002:a17:902:b089:: with SMTP id p9mr20011218plr.52.1596571186607;
        Tue, 04 Aug 2020 12:59:46 -0700 (PDT)
Received: from thinkpad (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id v128sm23069064pfc.14.2020.08.04.12.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 12:59:46 -0700 (PDT)
Date:   Tue, 4 Aug 2020 13:00:13 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in netdevice_event_work_handler
Message-ID: <20200804200013.GB263814@thinkpad>
References: <0000000000005b9fca05aa0af1b9@google.com>
 <20200731211122.GA1728751@thinkpad>
 <20200802222226.GO24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802222226.GO24045@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 02, 2020 at 07:22:26PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 31, 2020 at 02:11:22PM -0700, Rustam Kovhaev wrote:
> 
> > IB roce driver receives NETDEV_UNREGISTER event, calls dev_hold() and
> > schedules work item to execute, and before wq gets a chance to complete
> > it, we return to ip_tunnel.c:274 and call free_netdev(), and then later
> > we get UAF when scheduled function references already freed net_device
> > 
> > i added verbose logging to ip_tunnel.c to see pcpu_refcnt:
> > +       pr_info("about to free_netdev(dev) dev->pcpu_refcnt %d", netdev_refcnt_read(dev));
> > 
> > and got the following:
> > [  410.220127][ T2944] ip_tunnel: about to free_netdev(dev) dev->pcpu_refcnt 8
> 
> I think there is a missing call to netdev_wait_allrefs() in the
> rollback_registered_many().
calling it there leads to rtnl deadlock, i think we should call
net_set_todo(), so that later when we call rtnl_unlock() it will
execute netdev_run_todo() and there it will proceed to calling
netdev_wait_allrefs(), but in ip tunnel i will need get
free_netdev() to be called after we unlock rtnl mutex
i'll try to send a new patch for review

> The normal success flow has this wait after delivering
> NETDEV_UNREGISTER, the error unwind for register_netdevice should as
> well.
> 
> If the netdevice can progress to free while a dev_hold is active I
> think it means dev_hold is functionally useless.
good point

