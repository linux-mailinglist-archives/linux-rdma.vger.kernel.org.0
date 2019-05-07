Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809A316797
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 18:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEGQPF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 12:15:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33133 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfEGQPF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 12:15:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so16610183qtf.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EI4YKysAAw9PT6TgsRsWE0KeovUlmnLKyjf6TL2eRRM=;
        b=l0OscmOkjsu9ymG5Z70+QRsa1Mzb2R0elb5tcvEj80itvp7VZZ7uLIbMJK2g8ILmDM
         witFwCDYYh+Cm+mWyaxXe5i/J87VjtUsLgv0Tk4XmZghRuOTq4gcg0VhLKKqAkYcO0zh
         nAWe20E7j6mF4o0dscdRKhM3uWE7fK1KyNhp0i0jki+mvZJr5LEZalDhTnNpz+rZgbsV
         8oZwzsoqGL5op8Ryp15RiqtI2fvazTwCYeQ7ypu+nVlCPtc0pDtzbJs3KSCHVzEUcg1R
         1wXKVMFuDRQxPhB134uN3z5N4RqNnrktDw8nLKvU8YGSCFyUKDaz0zr8THX3hCaJKu+d
         Kx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EI4YKysAAw9PT6TgsRsWE0KeovUlmnLKyjf6TL2eRRM=;
        b=r3KxDRbhZpjybFzanfJs3Ili3fiuG7tgyG170sdXnNYKYAByDwzLJq8ejwMxt7XooM
         4BuznIDLxCsh4L7fY1c5VT2jWRCpCIZTSC655hJoQ3/9Eqx8w6RdzWnk7Ids7fDJaMi3
         axSHE+sheE103hmq9jt31NQdy/y63b5qiTO47ixIcyKV5ygLgqDyYpNNy2O/kVqGgxi7
         3TW6b1Y9ROnZXPm4ekqn1dHqCXS9wlqs7tU6u61J7u4PcnNLbUlh+42oN0e/SjjLknEt
         1Txgwc543wpJaE5Z2zlt31bejgZkcKwxyYfBDQRo0+qXouk2IP610tJLhSBX7AjpLrrP
         SsmA==
X-Gm-Message-State: APjAAAWB0dwsE3OBnBVk3IAMqpaS8CsSfg3LsYz4QUWJGhKNxSC9II7E
        p/OD+rev2GSpFPEJ02vPLj76I97G+rw=
X-Google-Smtp-Source: APXvYqwr89gAD3pWDEE95UDoKGQaS3Xc423vZc7KqVvfvG2EgugOWFWxIs7mMoXUk8xaIUDuqNbCCg==
X-Received: by 2002:a0c:d2f2:: with SMTP id x47mr26736437qvh.90.1557245704034;
        Tue, 07 May 2019 09:15:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id d127sm7316351qkf.8.2019.05.07.09.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 09:15:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hO2kA-0006mV-Py; Tue, 07 May 2019 13:15:02 -0300
Date:   Tue, 7 May 2019 13:15:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1] RDMA/device: Don't fire uevent before
 device is fully initialized
Message-ID: <20190507161502.GA26010@ziepe.ca>
References: <20190505163320.9014-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505163320.9014-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 05, 2019 at 07:33:20PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> When the refcount is 0 the device is invisible to netlink. However
> in the patch below the refcount = 1 was moved to after the device_add().
> This creates a race where userspace can issue a netlink query after the
> device_add() event and not see the device as visible.
> 
> Ensure that no uevent is fired before device is fully registered.
> 
> Fixes: d79af7242bb2 ("RDMA/device: Expose ib_device_try_get(()")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Changelog
>  v0 -> v1
>  * Fix comment as suggested by Parav.
> ---
>  drivers/infiniband/core/device.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

While I don't particularly like this approach, it seems like all we
will be able to manage for this merge window, so applied to for-next

Thanks,
Jason
