Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD2A1D6E1C
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 01:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgEQXnx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 19:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgEQXnw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 19:43:52 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8857C061A0C
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:43:52 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id l1so6724324qtp.6
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/F/sZtcZ2xyJTS1GvtPFnMstSoyEgQHsPwLbcrUCpQE=;
        b=mZUIyb/wcnwUK6o777ILLg1plJ2yTLq4vCsN1hbWU5f0wDkhNe+4TkJ0r1iG3Nm8/m
         g2Hhw1tVUcdXLWW+kLIUEVOoa6VwPeVyflq3LODi0rUCGVNb8IWKPIImHN40s8nlRDOm
         uKGnsDHqwAUNABHqB8KyC0LZGJobuF/JmGRK4vVfO5k4mL692P26wk0+khewMuSa2ARI
         k5zveuBgQ3MLzph9onaKquXwAt9EhNgekTPCjo1+5JhSA+pqeMGATwEC0X4IZdllzNci
         Tp8Nxa576/ogVbk29QXFi/iXqLzjPWaoH88Y/UqQFFR9fdI157feEv826iyi+l1wBTvV
         CmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/F/sZtcZ2xyJTS1GvtPFnMstSoyEgQHsPwLbcrUCpQE=;
        b=Pb27fCV701POiUUDlF5AKj6Gm771CGY8WxCAhTKTn4ozxaACvepPQO3kKnRdQAfUbe
         MkEISKzLO3I3aF36JDZAtXCqrmhp5H1cmmJWW0qELfr+VSnkGAU6GDQ3LnROb4WTAxc5
         JiYZEx4rYpZW3bbCHR+NheRBO2Ki6f14kd9cXM/2DX4FLk/4n00Lh7rn86f3AtEE4OHm
         cZKSVCMKtpnRtHVyhChf/os45V9jomKTOYRnnlsAJVlNY5G8yR8VrD3Q1JXO/L2jeAbi
         F6bq58WRUCD+Nd/vjvrXoaxwKrgtUd3v9sVzZmS6jizo1czxycdqvtjHYJqpACM/gvzL
         +eRg==
X-Gm-Message-State: AOAM533/SWx6v0mP/c0CKyXKhTqwua6WaYIl2yClXvL0sBZRIq5V+sH3
        YJU1fEs8IIJ9x/Aq+OXpTqc1tAH7vDk=
X-Google-Smtp-Source: ABdhPJy+ycm4D4nse7dg8SJNFssnio+gAX8IHRN9qYpH+PqlA2kL3h1WlNMlSPHoUNp9Y9yqw/DXvQ==
X-Received: by 2002:ac8:7941:: with SMTP id r1mr5401339qtt.290.1589759031927;
        Sun, 17 May 2020 16:43:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g66sm7165284qkb.122.2020.05.17.16.43.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 16:43:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaSwh-0008LZ-3u; Sun, 17 May 2020 20:43:51 -0300
Date:   Sun, 17 May 2020 20:43:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-rc v2] RDMA/srpt: Fix disabling device management
Message-ID: <20200517234351.GA32048@ziepe.ca>
References: <20200514114720.141139-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514114720.141139-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 14, 2020 at 02:47:20PM +0300, Kamal Heib wrote:
> Avoid disabling device management for devices that don't support
> Management datagrams (MADs) by checking if the "mad_agent" pointer is
> initialized before calling ib_modify_port, also fix the error flow in
> srpt_refresh_port() to disable device management if
> ib_register_mad_agent() fail.
> 
> Fixes: 09f8a1486dca ("RDMA/srpt: Fix handling of SR-IOV and iWARP ports")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
