Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B508A1C43D3
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 20:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbgEDSBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 14:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731243AbgEDSBy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 14:01:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E370C061A0E
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 11:01:54 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s30so292446qth.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=THe0j7F0REvvkPmZJeKR5f3IuXNmJPCSkf2MbBDkDaw=;
        b=fai1/FC29rHqid/46bPFYyJsP9M9I8Q98zUYmq4xfQOXbTAmEth5nNGKOwcEK7cNOj
         QFv6nOBlFFXjCbJoxPvqdTR8wefCjzaEcO3uDGGWOVngEI4aiue32GYZVGQhYB4F8dnk
         KHZbnv/VwTb2LtotpK+bUuhR6T6RgldG51nEgrbjIf+LtuyJCASujbTocMV4vi4jraqT
         Mc1aRvJ5xo0xr1tYuweRoBIYTiMsEOdjPerDnIGyBXVUdvDhkoDJKPisF1E4XRBLTuMI
         kCqkPVYUIROks5WtV5K7Q6qwDNvZVKMYlStO1scT2YHxHKl7jDLax1BWanN0Ngyf6aO/
         KCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=THe0j7F0REvvkPmZJeKR5f3IuXNmJPCSkf2MbBDkDaw=;
        b=QmJb8hcuDl7v1fB0ka+GE9N/EkViv387bgILLz2yIyXCfmbZGhgHBZbbovtvT/QhXg
         ZaDpu6yvLdl1EAVlW7WlbmcfldV/QCCk7LLcjtZSOwj5FaLeNduvl8kpnD8smmZ/0ezh
         TRPheVgmdjmXVEkopEowZsjKJtmbcmahFVrKmtGdLCOiid4U6q+IbxlfsyBQaqY6CYDl
         QM0QJO1TOyoKh79+5NHVslbB2YM6wFP+lq1Mj1C1uHJqqWnbA3jiIXRFIEDneHul9MlW
         MRhOTHI6ahKeqUOVTskRhqvT9+09XBVB/BGxDfPLWWyNbVIBAFE0myV+jjVOuR6aHyzw
         D5Eg==
X-Gm-Message-State: AGi0PuZfGrqLVeKWxjaDU1cYvB9eYNj+UqI3ExcZKVrSJdnOPltJajW1
        PTgWslyjf/ELDo5ofQoI+KP2ww==
X-Google-Smtp-Source: APiQypKLVT70Y6mtxjWMdmWWNxm26HnJnRKDUbGc5U0BG7uoyyDGUk7L5JoEb0EhArqs5WJxndS1uA==
X-Received: by 2002:ac8:36ab:: with SMTP id a40mr269729qtc.309.1588615313564;
        Mon, 04 May 2020 11:01:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h25sm11922681qte.37.2020.05.04.11.01.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 11:01:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jVfPc-0006tn-Kp; Mon, 04 May 2020 15:01:52 -0300
Date:   Mon, 4 May 2020 15:01:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc] IB/mlx4: Test return value of calls to
 ib_get_cached_pkey
Message-ID: <20200504180152.GA26485@ziepe.ca>
References: <20200426075921.130074-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426075921.130074-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 26, 2020 at 10:59:21AM +0300, Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> 
> In the mlx4_ib_post_send() flow, some functions call ib_get_cached_pkey()
> without checking its return value. If ib_get_cached_pkey() returns
> an error code, these functions should return failure.
> 
> Fixes: 1ffeb2eb8be9 ("IB/mlx4: SR-IOV IB context objects and proxy/tunnel SQP support")
> Fixes: 225c7b1feef1 ("IB/mlx4: Add a driver Mellanox ConnectX InfiniBand adapters")
> Fixes: e622f2f4ad21 ("IB: split struct ib_send_wr")
> Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Applied to for-rc

Thanks,
Jason
