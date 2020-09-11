Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430C726682E
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgIKSTr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 14:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgIKSTl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 14:19:41 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B81C061573
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 11:19:41 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r8so8558909qtp.13
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NUMNzPsZluP4A9WQF3+FT2V5kMfREvpaBzqUi2M9exA=;
        b=f0d5uzHehvTubKW5AXkQ2iZH08u25QqbA/58BP45d70peWpRrVpLscvQY1zhzKAmUw
         45ZKs3r42JDdoIQn0cvdIlCOMhaayxsFCQveuu3nLZstLXVH2b4lAaKGNSIQQeQpwJA4
         pYi1Axr/BkTlSVQ4CoS1y8RMKLS2H0ZPxppK2IRRDvWzp9TbacaI938kTyO6qRHuEeNW
         OFYXPFlHZkY9iTCZPN+tDq1W09Cr2s7mc3MpxCcJn/TV0kwGOJYjymH2w4FQWWxKkUIb
         kpXpZgjmRVS7yStq3JIQo9BjcDbSgSGNJTo2J7c5eaQYshJkfiWeifqR19eWxdItlQPe
         xUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NUMNzPsZluP4A9WQF3+FT2V5kMfREvpaBzqUi2M9exA=;
        b=WckuYKGn39hugxpJujw2yGO6+cDS6SXU0ntUYW33zerfxg5CMSmKaNqHOpY3Fud4lF
         97ttz5pdSxtbb24Ls6yubH2w5KX0DPnVeqyyj9mF+59oC+bM8RxV3pCOigm0Y8HgVr5x
         IrJczt6TGBc8o3m9Uz6WD4D88bZirNrYok9b/fWHwbLuQOa14nuPaRbC+Cc7DMWQQGCi
         MPZYMeb668XR+eJ0kN95/mncfHG6oc72YHboDnJarykrQrcxmMDB9RoFM1IrmyXCAto+
         G+CrLtBFl/ZWwB6xD50uJ0t7vhuI/Gok2+M619atfHFHwKFaY/3Qm05ORCMxvL6eVT8p
         8wnw==
X-Gm-Message-State: AOAM532dzMXSW/603NFs/u+lROzfmbgaJQws3sWGkKevGS7W+wQFww+m
        zxLyIe91T1dfAvUnSwIm8gCdWA==
X-Google-Smtp-Source: ABdhPJxS51I8TpA7FH4QtwdoDh+RDwMsZ9DP69EVU43/gBXCUgmLXBu9VYXTwQB46rX9P7hTHh9pig==
X-Received: by 2002:aed:2d62:: with SMTP id h89mr3154762qtd.193.1599848380859;
        Fri, 11 Sep 2020 11:19:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y73sm3716420qkb.23.2020.09.11.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 11:19:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGne7-0057v5-GC; Fri, 11 Sep 2020 15:19:39 -0300
Date:   Fri, 11 Sep 2020 15:19:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in ucma_close (2)
Message-ID: <20200911181939.GA1221970@ziepe.ca>
References: <0000000000008e7c8f05aef61d8d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008e7c8f05aef61d8d@google.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 10, 2020 at 07:09:24AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    34d4ddd3 Merge tag 'linux-kselftest-5.9-rc5' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1002ea2d900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=cc6fc752b3819e082d0c
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1600e053900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com

#syz test: https://github.com/jgunthorpe/linux ucma_migrate_fix

Jason
