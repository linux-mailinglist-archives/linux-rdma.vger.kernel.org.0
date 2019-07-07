Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01CF614ED
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2019 14:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGGMVT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Jul 2019 08:21:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42235 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGGMVT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Jul 2019 08:21:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id h18so8035274qtm.9
        for <linux-rdma@vger.kernel.org>; Sun, 07 Jul 2019 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vno4F54ammbJbJtZ9Cmd7T+mTtPwrmoJfKKsT8mE16Q=;
        b=c09INCVbEPTz0vcUJ0m1HAGa7iTlfOSty9DkYBirSBtBzFKnoeDC/uD7W/o9d/Myzh
         3AsbR7bW78kBHqOQ6mRQfbTGeAZ/EzEFMWf4fvo5if3MfKEz3lMPxSxobZTZKljqFrv4
         aWFonfCnIYGVA1CqT7Rag9Ab6eO4qGFGjxYDYhjhhhOIcmbmBiNh+cSqcO2UMpvy8Kb+
         UwI5w8rLh7WjdmpUjsPH1P5/6o0XnSzS4iRA+IRKblPeHVIwKmUIot8lSvHJKw8LZZvT
         yYdju6KFbv1mAFHcmTVaRsjcGvGKydwI1QYfC5T7QlNvCmO/YRs4Fx5XU3JhkcIPTlT2
         bV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vno4F54ammbJbJtZ9Cmd7T+mTtPwrmoJfKKsT8mE16Q=;
        b=iZSyyaBUJiVhn1OEgWUv76I+HeRhr9Ad5jOg9CF2AiN9V5Y2BAvLutwpHMCT74pEum
         Oqpx2SPiv78wjEJGkyFJtLYIoJ6hZEo01U6t4xAcN5ys93h5MCJl2EVmGOvT3VnyIhmu
         hm6xfc0kVxXaFs2wYX3tY7IrD3nvXvCUFkFsuvs2wud2LhlbtOVT+Bzf5ct4Fs2QfgE/
         XAqbf0pUXwuJE7ogvufpkAZDnOiNLQbh5drW6aquzr/WvxTzLwxKK9L1yxL0Ao1Osx1m
         gU03kLmpkFOBSejhtbVGYBteWRytWYwNTQS3aHjmDVyzk9sXyKt+SAZ4Pg6jIYDvTRS4
         NLyw==
X-Gm-Message-State: APjAAAWnOs48UojtGJf9tvgGg3i9WhrQCUszYF5pxDSs/M18b3qvV5UP
        m2dm0fYG5EiU73YoEyVl4SQquw==
X-Google-Smtp-Source: APXvYqy1lfwH/CZjy/gDJWS2ezditBCBo9tNDzty1VFNAoKPJTCtXFk5q/zGhK2C9oqJXF5Aa3lzZQ==
X-Received: by 2002:ac8:17c1:: with SMTP id r1mr10011237qtk.41.1562502078554;
        Sun, 07 Jul 2019 05:21:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j78sm3503330qke.102.2019.07.07.05.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jul 2019 05:21:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hk6AP-0005Km-Hb; Sun, 07 Jul 2019 09:21:17 -0300
Date:   Sun, 7 Jul 2019 09:21:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     oulijun <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 5/8] RDMA/hns: Bugfix for calculating qp buffer
 size
Message-ID: <20190707122117.GB19566@ziepe.ca>
References: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
 <1561376872-111496-6-git-send-email-oulijun@huawei.com>
 <997bdd68-8be1-9684-5d4d-d0b5bf202b80@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <997bdd68-8be1-9684-5d4d-d0b5bf202b80@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 06, 2019 at 09:47:09AM +0800, oulijun wrote:
> 在 2019/6/24 19:47, Lijun Ou 写道:
> > From: o00290482 <o00290482@huawei.com>
> Hi, Jason
>    May be my local configuration error causing the wroong author.  How should I make changes?
> 
> The correct as follows:
> From: Lijun Ou <oulijun@huawei.com>

I fixed it this once, but please check and fix it on your end in
future.

You should be able to set the patch author in git's config file:

[user]
        email = jgg@mellanox.com
        name = Jason Gunthorpe

Jason
