Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C556E42109E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 15:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbhJDNt1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 09:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbhJDNtX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Oct 2021 09:49:23 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E47C048D8F
        for <linux-rdma@vger.kernel.org>; Mon,  4 Oct 2021 06:15:18 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id e16so5324594qts.4
        for <linux-rdma@vger.kernel.org>; Mon, 04 Oct 2021 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fY9n46rDsSqLMN7tBVm5DkKE+DclMqI1aoIh5QrW0JU=;
        b=iZJhKEVypu+NCt4ahJaoSu1aX1jv1yJtEXpg+MWzlVkavx5jZ7WyxDtcjBcc3R1AeM
         NgjRZYeTqiGWfl4nc+P2i3+xCcTGISosY1pUvxPygefIjpgDZ3KML+XqZ+HCSv1xr4Bt
         7MnpOL5tpS17YpMKqpPEWZ2VVIeNdJutSACJ4h6/yfG6iK+x8UuQKYO1kPqxVmXka4da
         9P2ciRDbs/aKUMPguhg210MJLvQI2EXIwvgCKPqfMQyPWvjArAi95Itf1zn8371nGXyI
         NqSqhrR2PXx3U5PwaOyGyvWb7+jXo5ApTEbnfdp23pWIxLlvXizhOK6WzeFJ+ABJIwIu
         cxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fY9n46rDsSqLMN7tBVm5DkKE+DclMqI1aoIh5QrW0JU=;
        b=zS7Q7Aqrds6OBZFaKjX2qrMAxzvv+OpvLXEKAaqzQ9xDDOsHk0lsS3dM5pBlYan1a8
         1mxcTShvkMA+Mgex2wsgAWWJpPARLYkImu0tLgyNHXH0lJPe7xCDexACX5NC+Xy4W+h6
         azrVqqbYoxxHytEexYbLQ4Fma6hCUIZbmfnu/TYlQKZ2UoPnCzrQnmdhfjWnbS2LfjWM
         Vo8LNMFSfjX+2wHtTbA+anmZUaiSWE1u4Tn74jWceAHTR8ypOaLVlXXvEEh3N9AKDUEG
         JEFjfPqTA4xpxr85Kiw80vozPlesE0Dht46Cd4csDvsysTplpZV7M2wSODRRIY8xbgaA
         xO1A==
X-Gm-Message-State: AOAM532KNZR0OQw3sUrkPkqPTThWdjJ5j1HCrOI+m+pg4cyMcbtLX1HB
        /MoINPSx7tnGa2VFXGlbcisXyQ==
X-Google-Smtp-Source: ABdhPJw7crTLfE4bAH1OXES9Zrqk0qb0l4QL4UGjCzEqwVNdATMRymZwHwJT8JRpJ/UKqhci7W7yLg==
X-Received: by 2002:a05:622a:178b:: with SMTP id s11mr13852404qtk.13.1633353317883;
        Mon, 04 Oct 2021 06:15:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id y6sm7505053qkj.26.2021.10.04.06.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:15:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXNoK-00ATbM-PB; Mon, 04 Oct 2021 10:15:16 -0300
Date:   Mon, 4 Oct 2021 10:15:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        syzbot <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: RESTRACK detected leak of resources
Message-ID: <20211004131516.GV3544071@ziepe.ca>
References: <0000000000005a800a05cd849c36@google.com>
 <CACT4Y+ZRrxmLoor53nkD54sA5PJcRjWqheo262tudjrLO2rXzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZRrxmLoor53nkD54sA5PJcRjWqheo262tudjrLO2rXzQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 04, 2021 at 02:42:11PM +0200, Dmitry Vyukov wrote:
> On Mon, 4 Oct 2021 at 12:45, syzbot
> <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    c7b4d0e56a1d Add linux-next specific files for 20210930
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=104be6cb300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c9a1f6685aeb48bd
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3a992c9e4fd9f0e6fd0e
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com
> 
> +RESTRACK maintainers
> 
> (it would also be good if RESTRACK would print a more standard oops
> with stack/filenames, so that testing systems can attribute issues to
> files/maintainers).

restrack certainly should trigger a WARN_ON to stop the kernel.. But I
don't know what stack track would be useful here. The culprit is
always the underlying driver, not the core code..

Anyhow, this report is either rxe or rds by the look of it.

Jason
