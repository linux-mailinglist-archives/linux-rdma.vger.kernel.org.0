Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E281484B3E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfHGMKj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 08:10:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38323 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbfHGMKj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 08:10:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so87981293qtl.5
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TyUqRDmRKloW/sMIvGnAqMuGW5YCqBPaj3KDrOKJEqs=;
        b=ceI/F6gB0pxxridkgCFoiRA3F2G+kFZJApg7pEkSENU7ARCk7TexijHl2DK49nkYpP
         RjzEO0d7RqIjCSDZJYs+YFh76CV4jxQp0IOyEG81LxHwCg6Be/yrkxqjVdGNMITJpIGz
         ZOgb2OWFAspX3mvhnNJBG+G6IH4+jtQLZo5M+MaRrPW4OoKFdcGwTe5vMicDCSViruCo
         J0c/noMtEbxiK06G9/WA+Piez2tvMHS7swkjoxfxU9u1FGTBG6ah1XHd89BlvDAJE9qx
         cfSopX76jwUOHLNCwL3xWmmfwrjSgBlyFIpmYgJpaK2yLdIfLsqcOd9NetaO5dYkXXqW
         a2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TyUqRDmRKloW/sMIvGnAqMuGW5YCqBPaj3KDrOKJEqs=;
        b=gQMQHB7XOAiiqkJU6TT0F5h+XgANKl1X9eO6L9SLkJo3dxTYYGYya3TAKmYuSvXYSc
         9msnpASbvz1tRJ8YXLIkk6a/cf8gwjiqbZKO/5ERGhtWLqOnvUf4T7Q1TNWn1vXK1hFJ
         UMY7k5b+GKZAKY5AShizgfTn2bYfzdhg/t9UoGDpCdtg7C1nuYxHs31kN+KWS1MUU9NQ
         sZyImEwrqJn2DHg8Sedd+goRARFa0KDDLrjmm7fa+3AYqJFP9b3+Jnwd7uhkI33XPq1q
         ohmA1XIFzBLUb9mS2/cRbCDVpJRONkdZtSqtaSG5WfK0MV4EHSzkjKZc751dhDB3MZ+T
         FqVQ==
X-Gm-Message-State: APjAAAXDYI+woo7N+9hkE0ra8jvdwOEmmeu0VM2ieSjwnQV0oy1cG5oI
        Lakzol/KbIRCd3PggY6MJovFwQ==
X-Google-Smtp-Source: APXvYqyO8Is2rHqVcjoXVwRl+RRSxDujV+x1nKfBnEd3h/w6218ooFi47opkUhvYiPV6BdOH6CTKTg==
X-Received: by 2002:a05:6214:11af:: with SMTP id u15mr7693849qvv.115.1565179838709;
        Wed, 07 Aug 2019 05:10:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l80sm19618120qke.24.2019.08.07.05.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 05:10:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hvKm5-00010p-S2; Wed, 07 Aug 2019 09:10:37 -0300
Date:   Wed, 7 Aug 2019 09:10:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jiangyiwen <jiangyiwen@huawei.com>
Cc:     bvanassche@acm.org, dledford@redhat.com,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        yebiaoxiang@huawei.com, Xiexiangyou <xiexiangyou@huawei.com>
Subject: Re: [bug report] rdma: rtnl_lock deadlock?
Message-ID: <20190807121037.GC1557@ziepe.ca>
References: <5D4A3597.5020406@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D4A3597.5020406@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 10:21:11AM +0800, Jiangyiwen wrote:
> Hello,
> 
> I find a scenario may cause deadlock of rtnl_lock as follows:
> 
> 1. CPU1 add rtnl_lock and wait kworker finished.
> CPU1 add rtnl_lock before call unregister_netdevice_queue() and
> then wait sport->work(function srpt_refresh_port_work) finished
> in srpt_remove_one().

This is an old kernel, this issue has been fixed

Jason
