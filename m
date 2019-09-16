Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58107B3BF4
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 15:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbfIPN6E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 09:58:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46183 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfIPN6E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Sep 2019 09:58:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so5656808qtq.13
        for <linux-rdma@vger.kernel.org>; Mon, 16 Sep 2019 06:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tHXe5aIe2U2Z276Fnt3tKiJ+L7qqwjA2PXek5+5pAQE=;
        b=g4/X4dk/ZP90ttspVnPWmMq60CSyB9KJqjUc3y3w7oaDGK4zgKuJw16D21iwvnk6z6
         Lj0zXQyhfVfv4SOmUI1HYZl+f44N6fw7fykV0jEny3jxHeOsZQoOhe5aOfQlmPt1TdV9
         r4DTtS83KOXlm5dqecHboap2MLQ8mq+4EdIHpCv26SMj7k5r1jqsi1PSIwv2l4noXeaq
         0qKAax4vuTXHxIejbSbDAjeGjA1TBh7RSEUn8puQoeOjL8IOIq044qN8OFehmLvYjn7r
         laB9HI9Obz49nlhN8s91es+Qr/8L0Ax1J2ulr4ZfDWey+Nsg1RSa3UswW1wddND7/onO
         P/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tHXe5aIe2U2Z276Fnt3tKiJ+L7qqwjA2PXek5+5pAQE=;
        b=fFMV8vqNeCssm4vF0qsgLwsETLQdW1iaA58+aKMpO05zS/fTN3Sjkl59eM/rs5W3UL
         3fcdkFVHc5HuejiCZCWW8YjOoQXZZygYlrYOxoyhRpo5QyeWH0yfFf01r1QFKxASTkDq
         tLev1mwpZLB18Od/u4uocbp0yweL3/UD+GhdiCdxSi4UZvzeO9sMGN97NUcTCr2qya9n
         quxE2RYLJ1buJnfLCdWNdnbBu7jKBUruF1xWRTT2QR3xK0C3GjmyAQ96RMCA5lgLNljl
         unGgVtWSCKXDsIzw7q9sK79DhuxywmDTw2TjH6G5iqWuXpG56gQTeH7jQZEXDl4EI6r6
         NTQA==
X-Gm-Message-State: APjAAAVAZBJeL4dJgz1SBo3bGmyQEMvhn1iMANEK3vKguyw62XGXFNiG
        MkfvTWAoF65VPzmmh3/9Xyb1XIlmrB8=
X-Google-Smtp-Source: APXvYqynTxL8Z46sbmNRztvUGC7s1IFVdDjSljTbrYwfZDEj2dlGTluU2Bq9s37Qgm+4lkJsxYCUHA==
X-Received: by 2002:ac8:670a:: with SMTP id e10mr16935563qtp.356.1568642283341;
        Mon, 16 Sep 2019 06:58:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id u23sm17519055qkm.49.2019.09.16.06.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 06:58:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i9rVy-0001WU-Dm; Mon, 16 Sep 2019 10:58:02 -0300
Date:   Mon, 16 Sep 2019 10:58:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] hfi1 and rdmavt fixes for next cycle
Message-ID: <20190916135802.GA5806@ziepe.ca>
References: <20190911112912.126040.72184.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911112912.126040.72184.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 11, 2019 at 07:30:34AM -0400, Dennis Dalessandro wrote:
> Here are some small patches for the next merge window. The traces patch requires
> one that is already in 5.3-rc4 and not yet in for-next. There will be a conflict
> otherwise. Easy to resolve but will also conflict when merge with Linus. The 
> pre-req patch is: IB/hfi1: Unsafe PSN checking for TID RDMA READ Resp packet [1]
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=35d5c8b82e2c32e8e29ca195bb4dac60ba7d97fc
> 
> 
> Ira Weiny (1):
>       IB/hfi1: Define variables as unsigned long to fix KASAN warning
> 
> Kaike Wan (2):
>       IB/hfi1: Add traces for TID RDMA READ
>       IB/{rdmavt, hfi1, qib}: Add a counter for credit waits

Applied to for-next

Thanks,
Jason
