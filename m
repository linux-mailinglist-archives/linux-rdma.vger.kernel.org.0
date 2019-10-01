Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EE8C38C6
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfJAPU3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 11:20:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39685 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfJAPU3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 11:20:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so11581234qki.6
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5q/jxO3lIJa8Acj2bnHQA+2U4vkcPe8FZr7+RGilU7A=;
        b=PWDBQwb3QofWvs/91t/xZ4I42e9F7silFVKJaDq6WqIw4Cylz5g1uKGxQ1L9ibN5IL
         3qX+xb0qn+3f8Tg0QnLUwU9qRVEtwHV3/QI1odhK4KNRp+fYf6cQ2D5bnyrMeAIjK052
         rCOtoSm+NdA2EKBzAvuB7+bBv9CABHB/Shc4ZDAARcx+5cS/JAWUrsiMJRFcnbSabe2y
         4K/uVaJZbZKpI8xa73XTP6UMILR8zT+dt/EugBTcdU4RQXwwstSsWreqGZzBzevBCVGL
         nWgmI6vV1CLB6aHpo5y84myHE2CWK2j46YvhBj4jdeC7nrrYvEdmRroet0j25WEkG1Hj
         RKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5q/jxO3lIJa8Acj2bnHQA+2U4vkcPe8FZr7+RGilU7A=;
        b=aX7QLLCfXB3iaRj9iUHiocEbXh0nU9TAEQws4COJls/jH8RIdewh8pN/LsSl0c0zQL
         mGpMhLSF+nbEDoVZHztXHUF1ezdLf5rEr9aF6i7qz3JYu1NHIM1B/yzrbLfedUWG387M
         HbPehk4K0kHAE56YlXOuDSRV2a/nIh+Mc68uME0vu3lGQMxy5aowT+lF92ALaVXVsfcB
         k9DSXXCZ27LiDhKM4CLTF/kip1t5xGzhyaFPGZ5n0uKzd9m8deqd2a0VfZLlHCALkqXv
         559g/EKJM6QTylGW5I1qGsSFGQBnW5SnN0/TerGxTx3dDkygBE9q9Pt2TomRt6x+6BsK
         e63g==
X-Gm-Message-State: APjAAAWMRswoX4NRq1w/PBEiWO7m5of2UT4q0ZToP+4XF2agjDM4EBW7
        fZdGa1ZZQhvlDMr0gGMlsLKQRg==
X-Google-Smtp-Source: APXvYqyyiXStSg2EpadM8gV6gv7hU6qboZLt1oGiX4X30KdbvQsD9tb83Ipr273Gp2phe6023uyrHQ==
X-Received: by 2002:a05:620a:13d1:: with SMTP id g17mr1272927qkl.9.1569943228869;
        Tue, 01 Oct 2019 08:20:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id p56sm10251561qtp.81.2019.10.01.08.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 08:20:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFJwx-0000Za-SQ; Tue, 01 Oct 2019 12:20:27 -0300
Date:   Tue, 1 Oct 2019 12:20:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH 04/15] RDMA/siw: Fix port number endianness in a debug
 message
Message-ID: <20191001152027.GB2159@ziepe.ca>
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930231707.48259-5-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 30, 2019 at 04:16:56PM -0700, Bart Van Assche wrote:
> sin_port and sin6_port are big endian member variables. Convert these port
> numbers into CPU endianness before printing.
> 
> Cc: Bernard Metzler <bmt@zurich.ibm.com>
> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Applied to for-next, thanks

Jason
