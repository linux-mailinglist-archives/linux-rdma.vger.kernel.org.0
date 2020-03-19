Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6726618B863
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 14:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCSNwV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 09:52:21 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:44057 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgCSNwV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 09:52:21 -0400
Received: by mail-qt1-f170.google.com with SMTP id y24so1773775qtv.11
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LeIJ8QX8g7k39gXV9ez+TLKO2ATd125VcXiQnyDPFUc=;
        b=kticJZ+OgJaA2vbsAFtBRyHLwVZxPD7C3gB7Ej6wZhCthO67McwdXZ+JnHgIlEzstP
         hPc3TVcBhRycy77et+AdAyZGvHROVhgrELuL3BCMNI9ETD31BQ1OK37UGVNTy1nh3UXE
         kLMwb2WYWewU/Qlg86IkeXWtURX2CLdnL5hreoqJMpzgISYVlFsVOaLGIl/bGwHaICda
         WAWgkqTvH7cF+UloT0qnmfcshIfdz2iMcjR8Jq2C2FBGiEGblPwtni/Les3uEoYYVsPU
         lCCVemzJXMayVunMlybt9qpViSvW8pEcnzQmyGzQlV1fXvdq+z4r/iyoUHrhKxtT5d/b
         JBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LeIJ8QX8g7k39gXV9ez+TLKO2ATd125VcXiQnyDPFUc=;
        b=Kb2RFGmnFxYzQWME24HbG3dHm2/JBWT1mbi1+iQVFzcCyHCTPZdY+fxjmuERY+nHe1
         nAnOSTF3YJls6vw0hrbuiaoHWEWjnLNSZYcLCSuc8dCG5muWU9E5DWrRTFDdfRP2AvbK
         nN4tOaqqGfhWX/v4jvpIrF1vXVnDBVid7RwYPjGYBWINntYDyWakCOEiyKFsrhAxtZSS
         +pWcwJORZbf58mtTk3L/lHjOFyezlJRos/YlM+njFe8/jDItGxBG1m7FgRwHSTif2cxC
         Z2LLfCUuJ8Nhr5KCBQZTAksLGFlPCtLAByb0ZDw8baenGHH69DN7ET7XMQ41E5SPpXjt
         KHOg==
X-Gm-Message-State: ANhLgQ0sUm9cEe1uqvSpmykC2uo0aYBPzf53FaCixyoXyjbk2VCmYu3+
        hcs7Rjx/F+14nDV/JeeKDmijUGiSett7sg==
X-Google-Smtp-Source: ADFU+vtmlSDDvMG0mrG+kG6uxQN0LTPV4Ude3wYMey7a0YchGNtHk06HyFW1jozME4bWQjGfgj5iPg==
X-Received: by 2002:aed:21c5:: with SMTP id m5mr2959598qtc.42.1584625939981;
        Thu, 19 Mar 2020 06:52:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d25sm179855qtj.86.2020.03.19.06.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 06:52:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEvas-0006Vc-QU; Thu, 19 Mar 2020 10:52:18 -0300
Date:   Thu, 19 Mar 2020 10:52:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: UDP with IB verbs lib
Message-ID: <20200319135218.GJ20941@ziepe.ca>
References: <CAOc41xGSL3bYs5s9AO-3hfEwLjOy4PEdpbN8xBYMpk5j4cLQSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOc41xGSL3bYs5s9AO-3hfEwLjOy4PEdpbN8xBYMpk5j4cLQSQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 04:07:37PM -0700, Dimitris Dimitropoulos wrote:
> Hi,
> 
> I'm looking at UDP using the IB verbs library. If I send UDP packets
> that are intercepted by the IB verbs layer, what happens with the
> completion notifications ?

Each recv that requests a completion gets a completion.

> For example, say I create a list of 10 ibv_recv_wr objects and each
> has num_sge = 30, with each SGE having a 4K size. And I setup for
> reception with ibv_post_recv(). If I transmit 30 UDP packets each 4K
> in size will I receive one CQ event ? Or 30 ?

One per ibv_recv_wr requesting completion

> Will the UDP packets be written in consecutive SGEs of the first
> ibv_recv_wr object ? Or will they be written in consecutive
> ibv_recv_wr objects (in their first SGE) ?

Only the first. Each recv handles a single incoming packet.

DPDK has a hyper-optimized version of processing IP/UDP packets via
mlx5dv

Jason
