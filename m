Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAAEE169257
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2020 00:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgBVXk2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Feb 2020 18:40:28 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:43075 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgBVXk2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Feb 2020 18:40:28 -0500
Received: by mail-qt1-f179.google.com with SMTP id g21so4104313qtq.10
        for <linux-rdma@vger.kernel.org>; Sat, 22 Feb 2020 15:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7MOW+3gtxwX5gaVjlGRp2hRa+xWcXgpRXNEHahRNc3c=;
        b=mavI8ufQxhSr3olyX+QmA3INhscq7rS7u01n3HFY2Itj1tls1w+P0hlpM4XDOanM/k
         yFHM6PU89fVq34O0FSmY8ky4mA00QZDV9SWZoFP4f9V7k8Y/HkR1Nznk9T33jgh4U8DP
         mGdaxSageki5xBR7VmWXSZKngbVyyZ0aNvaGjU7TS+XBUAunRFaZ1PxGI/0vszJ6C7ir
         bIvUawb96Tlslc2pWxIkJUjjeNNEGpY5pG9+dkZtHHLGuxxY540vTMXiQN1uW9n0Z7vV
         lu9OSGjyGSTMw2B1fISH6tAIOPyP44fS3p6tELUkVKc/NkJETNlRMa/ZhbcIJDsaFBQE
         TPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7MOW+3gtxwX5gaVjlGRp2hRa+xWcXgpRXNEHahRNc3c=;
        b=aNWwV9RVapX1xC+W36wHHTIu1Q5TW3GjdraIXACzaVYJ2jDR+dvv9y1wjjqawfphRY
         X3JESrLwW2UXkw623z3BIFeZ6Ljn78CPuCVeNwm3mjYthgqyX67hKLTxhAXC8ggYYxH0
         Z8JVJwlaRK3xuzt6GerH7MoiJ1K2RVJUFO6dbhU5hKNVYWs8R/bhoieZZqkrLavBWGa5
         fwzGd5PH5KGD/6N+5qRhvpFsN0GkCDtgIYORbt6ZxOGbBh7eD4iSkGoh98sVQCAJ+QwY
         yesnyIibed6S6v7CQ46BNy+YrO8qdbWT3ru+eYZAR62KO73DAuz6RPGcD9p6XMP+7bnN
         +oLQ==
X-Gm-Message-State: APjAAAUVK/GWeaW+9JI/r0uxx2rpQp2vSreXPrPw9dD3wQcMvp/p96tj
        Htm0wZQBFRTN9pMSFCNZAcSyRg==
X-Google-Smtp-Source: APXvYqxhASBotohymtnvTnNInQ0+OWT438AGuTRedoy71m93ucrqAVGr2HQKLPlljoyqGk3upplLfw==
X-Received: by 2002:ac8:6f09:: with SMTP id g9mr40493641qtv.275.1582414827569;
        Sat, 22 Feb 2020 15:40:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s42sm3795636qtk.87.2020.02.22.15.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Feb 2020 15:40:26 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j5eNm-0001AG-Ey; Sat, 22 Feb 2020 19:40:26 -0400
Date:   Sat, 22 Feb 2020 19:40:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        linuxarm@huawei.com, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Message-ID: <20200222234026.GO31668@ziepe.ca>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 22, 2020 at 11:48:04AM +0800, Weihang Li wrote:
> Hi all,
> 
> We plan to implement LAG in hns drivers recently, and as we know, there is
> already a mature and stable solution in the mlx5 driver. Considering that
> the net subsystem in kernel adopt the strategy that the framework implement
> bonding, we think it's reasonable to add LAG feature to the ib core based
> on mlx5's implementation. So that all drivers including hns and mlx5 can
> benefit from it.
> 
> In previous discussions with Leon about achieving reporting of ib port link
> event in ib core, Leon mentioned that there might be someone trying to do
> this.
> 
> So may I ask if there is anyone working on LAG in ib core or planning to
> implement it in near future? I will appreciate it if you can share your
> progress with me and maybe we can finish it together.
> 
> If nobody is working on this, our team may take a try to implement LAG in
> the core. Any comments and suggestion are welcome.

This is something that needs to be done, I understand several of the
other drivers are going to want to use LAG and we certainly can't have
everything copied into each driver.

Jason
