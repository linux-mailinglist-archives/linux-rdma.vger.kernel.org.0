Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB1E7282
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 14:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfJ1NR1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 09:17:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37381 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJ1NR1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 09:17:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id g50so14488271qtb.4
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CfHVjXypw/UbxgUDck+kyLGY5ODQZIUw9eVaIE6mR6E=;
        b=nvATko49tAKtNyrMxVpnKJbXZiaBhGe/VyTHIPM4sc1Z0BKhqLDSNYlvtf4aoVWTaY
         4LMWzNLBxaU+fx/y9FVwsPPvT2oBzxJ2f+OImJSFvIuo15VaYnQwBTey21mXm1Uh0umy
         Qr3cS/nqCziO5tGLw/Gv/gIZmhrKn12/Oek8IovzDWdlJX/Zmf7w8JAkEBV/nxg7r0DG
         GXAwUh1qmd4mD9xkMFVIxOOwXNMl1eixdkrceFVAJwPV3t4aoa5UBiwNC1uaV3JzuVVk
         Gx+01pnwUSt//u2q4Q9Uv/Pg/uVY6K8NCAqOrZVBrUod6rRvuoGn2LWGxs9JI3nLmivj
         fcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CfHVjXypw/UbxgUDck+kyLGY5ODQZIUw9eVaIE6mR6E=;
        b=ptUOb+Q0Rafk/a9Z62Q52eYNE8RIumoFX9iFv5rjRtRIcCcQQDUNBr2HnQtMTzGlri
         Xs53y3qKcTHGdWsVFiW8HHvwypKd7+5gt7Ki9cgbWEfdooYmO79OxZKPP32qgeRhpfcf
         8qijXi7PS9uR0UXMkvRtKZ6cLPLNoBBgmhzY7hu05+WRLXDk+T4h4B2c+KD2pOTLjkJW
         z4MKsbWQuhl61PO1kDsmGECNwD8YBttTI5ndQ/OfXNgHpEDTIt2TiFVV4ucxzDH8vS0B
         ZigGXmxn4/01f/A9yc9BTmppUsM+6ee7Wfnn9akZbDIwmB3jIiaYSXNnOmcSCxMFgPQ4
         VKtw==
X-Gm-Message-State: APjAAAVT++AQUedkSD4zeJkLPj9db4ilwmqqQv6xskCHkw4jUai5cA3t
        i8S3W5gIX8Z7Q47NlYVaPpWhxA==
X-Google-Smtp-Source: APXvYqzsRiksNmEAxa/BnMAhXfsWtAlHK/T8tb2jtwt8mXdaHjkBjOiDnSD+zcYzG65XQPDZD0zHEQ==
X-Received: by 2002:ac8:6f27:: with SMTP id i7mr17487009qtv.359.1572268646390;
        Mon, 28 Oct 2019 06:17:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id x64sm5660723qkd.88.2019.10.28.06.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 06:17:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP4th-0007uX-He; Mon, 28 Oct 2019 10:17:25 -0300
Date:   Mon, 28 Oct 2019 10:17:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH rdma-next 0/6] CM cleanup
Message-ID: <20191028131725.GA30331@ziepe.ca>
References: <20191020071559.9743-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020071559.9743-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 10:15:53AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This is first part of CM cleanup series needed to effectively
> add IBTA Enhanced Connection Establishment (ECE) spec changes.
> 
> In this series, we don't do anything major, just small code cleanup
> with small change in srpt. This change will allow us to provide
> general getter and setter for all CM structures.
> 
> Thanks
> 
> Leon Romanovsky (6):
>   RDMA/cm: Delete unused cm_is_active_peer function
>   RDMA/cm: Use specific keyword to check define
>   RDMA/cm: Update copyright together with SPDX tag

Applied to for-next

>   RDMA/cm: Delete useless QPN masking
>   RDMA/cm: Provide private data size to CM users
>   RDMA/srpt: Use private_data_len instead of hardcoded value

These ones probably need a bit more work

Thanks,
Jason
