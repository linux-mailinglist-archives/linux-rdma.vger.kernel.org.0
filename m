Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2125CCC23E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbfJDR7f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 13:59:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38315 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387928AbfJDR7e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 13:59:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id j31so9733427qta.5
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=maY9Agn3ncyORodc1Jb5cz+/WonNXy+axN8jUh7REZs=;
        b=dQgwZQ4CqS/dg0MBpSpxViSI7fq2GohKTBIPApR8uoYW0kug5u629hyX2/s2bF/57w
         4pzfrDLYe0HR4pa4HRVZA+N6IhrGeYmD36lq6u614dyKKsy7EolM+0JKENRUFb8R5T0n
         1Z6MWGvFKMqyRocggU43EeVUz0rqxQ0M4jsg7njY22Uwn7U2vHxzeoUXUeqWkaVDI+63
         66cUsPNp6JeB6vOoSS9oMfx1SDTjW07cYjySkmjfew88IHRSM8A8OEuxvriTFguoNJdI
         IIVad9Fef+GOET5OoZ1d1/jxcpPJ85pecmIJbZ2vCzwcNCGOn4wVyJieCBWSyZlPgw8w
         VWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=maY9Agn3ncyORodc1Jb5cz+/WonNXy+axN8jUh7REZs=;
        b=kSEyKQ0mdLLZSKUQQiASxCCP5r0d7/BXsUqh7amLAzUUqopXUuOSBqcQqUCKQiX8/l
         ofTNhc63x8Y3LP68ZxxT4QWOMnor4uCcfoM22frCRU87W6R1eJw7qx7xRjFbG/kHnEnL
         ECS5FeXrtx6TSrY9vmb7OVWMuYEfiTng3lwe2PBArAuHU9lglnQikKfNWtgQRdLvZDFw
         7LHf1qV3b/YXExbT125ix40hyeRAmbxZ3sYKCtew0euM1pwuB1VigdA6PbvEvCxvAXFc
         3bkQH9pl7XWFrZQCOqyRs5bkiXdZkSA8RGc+HPylFoZBAi1h/hK05dhtK4VuIQOOYYvT
         Svyg==
X-Gm-Message-State: APjAAAX5w+EyMRVppi1ahRqACtrwSfH1Tekaj0KykkFt1LreOuRBlaw5
        40SABEyPpBmSebUvbU9FTXPr4Q==
X-Google-Smtp-Source: APXvYqwHMEZCM3DrrGv2lyHc1+piOUypI/2x/vPd17HKzRg20e0DXKOrt0n99fkRViwp7GC2KSyDtQ==
X-Received: by 2002:ac8:73c7:: with SMTP id v7mr17514163qtp.106.1570211973942;
        Fri, 04 Oct 2019 10:59:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id n65sm3359647qkb.19.2019.10.04.10.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 10:59:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGRrY-0006M6-To; Fri, 04 Oct 2019 14:59:32 -0300
Date:   Fri, 4 Oct 2019 14:59:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH 1/4] RDMA/cm: Fix memory leak in cm_add/remove_one
Message-ID: <20191004175932.GA24402@ziepe.ca>
References: <20190916071154.20383-1-leon@kernel.org>
 <20190916071154.20383-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916071154.20383-2-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 10:11:51AM +0300, Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> 
> In the process of moving the debug counters sysfs entries, the commit
> mentioned below eliminated the cm_infiniband sysfs directory.
> 
> This sysfs directory was tied to the cm_port object allocated in procedure
> cm_add_one().
> 
> Before the commit below, this cm_port object was freed via a call to
> kobject_put(port->kobj) in procedure cm_remove_port_fs().
> 
> Since port no longer uses its kobj, kobject_put(port->kobj) was eliminated.
> This, however, meant that kfree was never called for the cm_port buffers.
> 
> Fix this by adding explicit kfree(port) calls to functions cm_add_one()
> and cm_remove_one().
> 
> Note: the kfree call in the first chunk below (in the cm_add_one error
> flow) fixes an old, undetected memory leak.
> 
> Fixes: c87e65cfb97c ("RDMA/cm: Move debug counters to be under relevant IB device")
> Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/cm.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-rc, thanks

Jason
