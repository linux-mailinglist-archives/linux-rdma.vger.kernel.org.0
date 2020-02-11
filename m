Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1002E1598A0
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 19:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgBKSaa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 13:30:30 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46909 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBKSaa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 13:30:30 -0500
Received: by mail-qk1-f196.google.com with SMTP id g195so11042426qke.13
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 10:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R7nUNk2MFi8vmxGzrMqVJAxCIbcZzIcXMIboihws0vo=;
        b=INxWddlTqtXKWjpEGExndonkDvzMkeGJZtBysWtd2uCVPDXO+gkDbMYBdk3l85QuVp
         YFCedQH+SPIGltdLEdaOC7Sna5546nW/KG8WKQBi5PY4WW0XTrAJy/lEIFvf8xowq0IG
         zwriEXYqksV2r2KBeNfbSqBL7d4E5NJobET12gGDPJk832Yj77BnI1d7hzXV6ROHvehu
         8xFhQbz192DrQf2n9XsKgmo6msicQD75WpSB0U/etk0CZDNUrlDRAnVFuLNxr5WeFu7I
         4zDGm5hsMjEI9Ue7cLyDvFJHLOjKb3p+jnb2pkun+/yGkSPNcwDlK8lUJ0223NYKz1pG
         8h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R7nUNk2MFi8vmxGzrMqVJAxCIbcZzIcXMIboihws0vo=;
        b=aZh/Zm7iy0NDUCrk5ueZetW2CTigYNoPctNNCpzZn5CNpamrAnLj97+tTQsILppl4z
         CmWveF8K0PDliM1ewYftVJaNTgoevmLN8t4Pm+wN9nwrTSwH86+UWf1+emD+C3ImrF20
         Io4xUdMmlohJsxsb3eHzrvFgzgRV7R7k+5JFcvs3oJoRIcNpfXnYyjWzK7hhVJFEx+Pd
         ss6rgpfiEKhQ/Y6RPwau/Y2EzHys0Oh05ygoBWkS/hYEypW8I6ApLNyWUJPYsdd8lMLC
         9RVo3utGeuNtJqkgfJcef0lN/whWkjKeec0L3FBW/BDyM1u4NNWw2oaitw4ycvxHfJL0
         55/A==
X-Gm-Message-State: APjAAAXTJ3jq9AEFZ4HrOBDVkwmxHzVwSrtkoGDuDmL6OWOwGE11CEI2
        Dqd12D1pi/8gkYoMdtx03AtHKlFwhx0aOQ==
X-Google-Smtp-Source: APXvYqzeDN1G8C+pNxNNZEAzeMXaObQepJYu44RoBkFvJBuyoWqzKSDGLTfjdq/6LArUo2WTCT4zRw==
X-Received: by 2002:a37:5d1:: with SMTP id 200mr3911109qkf.492.1581445828923;
        Tue, 11 Feb 2020 10:30:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c8sm2384099qkk.37.2020.02.11.10.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 10:30:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1aIm-0003d9-4F; Tue, 11 Feb 2020 14:30:28 -0400
Date:   Tue, 11 Feb 2020 14:30:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        bharat@chelsio.com, nirranjan@chelsio.com
Subject: Re: [PATCH for-rc] RDMA/iw_cxgb4: initiate CLOSE when entering TERM
Message-ID: <20200211183028.GA13933@ziepe.ca>
References: <20200204091230.7210-1-krishna2@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204091230.7210-1-krishna2@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 02:42:30PM +0530, Krishnamraju Eraparaju wrote:
> - As per draft-hilland-iwarp-verbs-v1.0, sec 6.2.3,
>   always initiate a CLOSE when entering into TERM state.
> 
> - In c4iw_modify_qp(), disconnect operation should only be performed
>   when the modify_qp call is invoked from ib_core. And all other
>   internal modify_qp calls(invoked within iw_cxgb4) that needs
>   'disconnect' should call c4iw_ep_disconnect() explicitly
>   after modify_qp. Otherwise, deadlocks like below can occur:
> 
>  Call Trace:
>   schedule+0x2f/0xa0
>   schedule_preempt_disabled+0xa/0x10
>   __mutex_lock.isra.5+0x2d0/0x4a0
>   c4iw_ep_disconnect+0x39/0x430    => tries to reacquire ep lock again
>   c4iw_modify_qp+0x468/0x10d0
>   rx_data+0x218/0x570              => acquires ep lock
>   process_work+0x5f/0x70
>   process_one_work+0x1a7/0x3b0
>   worker_thread+0x30/0x390
>   kthread+0x112/0x130
>   ret_from_fork+0x35/0x40
> 
> Fixes: d2c33370ae73 ("RDMA/iw_cxgb4: Always disconnect when QP is
> transitioning to TERMINATE state")
> Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 4 ++++
>  drivers/infiniband/hw/cxgb4/qp.c | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
