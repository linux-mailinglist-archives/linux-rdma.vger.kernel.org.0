Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6E83E2126
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 03:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbhHFBqS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 21:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhHFBqR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 21:46:17 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C3BC061799
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 18:46:01 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d9so5349319qty.12
        for <linux-rdma@vger.kernel.org>; Thu, 05 Aug 2021 18:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XmeinfU14TTLpVoOpv29tbpv0csH0eVU1S0MYI1ZFP0=;
        b=CLrx7K+gYvLiXLc2nAiXpsrstD5GnhoDiZax+zk/PUXHKmhC/VTx70GGGPM5+XGe1L
         4HYeBV2FllfZ1ltXPD8Fdy0iMa6F5+RYAy3CAsRbOo2M/rth2bJyptnRoRQgu4bstS8B
         i68Ga55ZW6s/XerTL7cUx+SA6B3pqVRQXXXs/xsm50oYoiE2mffRtWduqdByXOZMry5v
         +XHzNgOzPkjNgX1KmBfCuMsrHtZaBdf5A3qaKclLzXC6Rq3P6uQa3rIfjPaAtYVvcpVs
         Ggkf0UFs+fuuh6jkW5XjO89AjLe/ZKpBOiGIDBci7TD7dpV+SjlRIZERh9fiJrCS4RZ3
         tdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XmeinfU14TTLpVoOpv29tbpv0csH0eVU1S0MYI1ZFP0=;
        b=a+5AG2x9ATvEuXMkupsgkn8f+PxRwMD2cOe0ABXMM3J2iY+RXvtvQbVNVPIIY7yHMh
         pu/bdwd5DKZbiw+k6nbWMuKS7jMlenI3WgSUGQydXJ77t24tNKmiGgNo0NexiWknqYUN
         e75h9x2Vy5lyHmT1Kijtk4Soa9zCoWEVJ9ZZ3FB40iVfzte26ZPktzPVWpKoORbwKYhF
         jCIXBSSp4gV4EP82p3R7vpEeO7no14iU6QYtylHXsELcsi3tDWui7vm2Y7MAHLZzLwkp
         d/FRorZlTrpscJO08pkbeaHdBO2G3EJLB+wXJOQYl+LVgIX9WrIsBkx0Jln2ufDFa4no
         +GyQ==
X-Gm-Message-State: AOAM531ENwJOrrWySmdyubGOePVr5UU8bBAO8TSj30uXaCsmXM7DLoBL
        4nkxrAAjbskyW8wyS/iFX36z/Q==
X-Google-Smtp-Source: ABdhPJxtabhGCmSV9Jj+2l+0F2IJ09MTVk8et8gFyq45hhqrIc1CxB4ulAOqoa6VcWyFUwvHqeYZ8A==
X-Received: by 2002:a05:622a:d2:: with SMTP id p18mr4556531qtw.262.1628214361031;
        Thu, 05 Aug 2021 18:46:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 2sm3868562qka.68.2021.08.05.18.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 18:46:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mBovv-00Dvgn-UB; Thu, 05 Aug 2021 22:45:59 -0300
Date:   Thu, 5 Aug 2021 22:45:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?TGksIFpoaWppYW4v5p2OIOaZuuWdmg==?= 
        <lizhijian@cn.fujitsu.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
Subject: Re: RDMA/rpma + fsdax(ext4) was broken since 36f30e486d
Message-ID: <20210806014559.GM543798@ziepe.ca>
References: <8b2514bb-1d4b-48bb-a666-85e6804fbac0@cn.fujitsu.com>
 <68169bc5-075f-8260-eedc-80fdf4b0accd@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68169bc5-075f-8260-eedc-80fdf4b0accd@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 04, 2021 at 04:06:53PM +0800, Li, Zhijian/李 智坚 wrote:
> convert to text and send again
> 
> 2021/8/4 15:55, Li, Zhijian wrote:
> > 
> > Hey all:
> > 
> > Recently, i reported a issue to rpmahttps://github.com/pmem/rpma/issues/1142
> > where we found that the native rpma + fsdax example failed in recent kernel.
> > 
> > Below is the bisect log
> > 
> > [lizhijian@yl linux]$ git bisect log
> > git bisect start
> > # good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
> > git bisect good bbf5c979011a099af5dc76498918ed7df445635b
> > # bad: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
> > git bisect bad 2c85ebc57b3e1817b6ce1a6b703928e113a90442
> > # good: [4d0e9df5e43dba52d38b251e3b909df8fa1110be] lib, uaccess: add failure injection to usercopy functions
> > git bisect good 4d0e9df5e43dba52d38b251e3b909df8fa1110be
> > # bad: [6694875ef8045cdb1e6712ee9b68fe08763507d8] ext4: indicate that fast_commit is available via /sys/fs/ext4/feature/...
> > git bisect bad 6694875ef8045cdb1e6712ee9b68fe08763507d8
> > # good: [14c914fcb515c424177bb6848cc2858ebfe717a8] Merge tag 'wireless-drivers-next-2020-10-02' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next
> > git bisect good 14c914fcb515c424177bb6848cc2858ebfe717a8
> > # good: [6f78b9acf04fbf9ede7f4265e7282f9fb39d2c8c] Merge tag 'mtd/for-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> > git bisect good 6f78b9acf04fbf9ede7f4265e7282f9fb39d2c8c
> > # bad: [bbe85027ce8019c73ab99ad1c2603e2dcd1afa49] Merge tag 'xfs-5.10-merge-5' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
> > git bisect bad bbe85027ce8019c73ab99ad1c2603e2dcd1afa49
> > # bad: [9d9af1007bc08971953ae915d88dc9bb21344b53] Merge tag 'perf-tools-for-v5.10-2020-10-15' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
> > git bisect bad 9d9af1007bc08971953ae915d88dc9bb21344b53
> > # good: [21c2fe94abb2abe894e6aabe6b4e84a255c8d339] RDMA/mthca: Combine special QP struct with mthca QP
> > git bisect good 21c2fe94abb2abe894e6aabe6b4e84a255c8d339
> > # good: [dbaa1b3d9afba3c050d365245a36616ae3f425a7] Merge branch 'perf/urgent' into perf/core
> > git bisect good dbaa1b3d9afba3c050d365245a36616ae3f425a7
> > # bad: [c7a198c700763ac89abbb166378f546aeb9afb33] RDMA/ucma: Fix use after free in destroy id flow
> > git bisect bad c7a198c700763ac89abbb166378f546aeb9afb33
> > # bad: [5ce2dced8e95e76ff7439863a118a053a7fc6f91] RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces
> > git bisect bad 5ce2dced8e95e76ff7439863a118a053a7fc6f91
> > # bad: [a03bfc37d59de316436c46f5691c5a972ed57c82] RDMA/mlx5: Sync device with CPU pages upon ODP MR registration
> > git bisect bad a03bfc37d59de316436c46f5691c5a972ed57c82
> > # good: [a6f0b08dbaf289c3c57284e16ac8043140f2139b] RDMA/core: Remove ucontext->closing
> > git bisect good a6f0b08dbaf289c3c57284e16ac8043140f2139b
> > # bad: [36f30e486dce22345c2dd3a3ba439c12cd67f6ba] IB/core: Improve ODP to use hmm_range_fault()
> > git bisect bad 36f30e486dce22345c2dd3a3ba439c12cd67f6ba
> > # good: [2ee9bf346fbfd1dad0933b9eb3a4c2c0979b633e] RDMA/addr: Fix race with netevent_callback()/rdma_addr_cancel()
> > git bisect good 2ee9bf346fbfd1dad0933b9eb3a4c2c0979b633e
> > # first bad commit: [36f30e486dce22345c2dd3a3ba439c12cd67f6ba] IB/core: Improve ODP to use hmm_range_fault()

This is perhaps not so surprising, but I think you should report it to
the dax people that hmm_range_fault and dax don't work together..

Though I think it is supposed to, and I'm surprised it doesn't.

Jason
