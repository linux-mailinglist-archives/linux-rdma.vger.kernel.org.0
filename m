Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B35657F4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 15:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfGKNjS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 09:39:18 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46989 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfGKNjS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 09:39:18 -0400
Received: by mail-ua1-f66.google.com with SMTP id o19so2449256uap.13
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KazpKbhHu00FeDDiPuVEMFaRWnbqcqwHcNdLtMoOcsY=;
        b=hSpyP6xxjo+eds0vrJb/JDa7NP4AH5hQ5XuifWkBcJeQ7QMVBqpHtOBM+0SNoecQAT
         pZT3btPHtTfKXQPkK/OXxLy6gRcJGFjS5Z2RHHVat3M/YCDQrA523q7tXlIp0lCiXGul
         gaBSTMYQbNyZ1yVHI/m2ZeEucJqTcl3pqzEIlLRHIlwgqIMBIEppENpnpEqEwHpKCREG
         MQHdsD9Cd241lCqj0guf5qqEEFCmEVcVWA6YxxBpFe9sovxZgSWkAX0Rh3GBfcGN2mAf
         JNmgWPxLUVhOlTE6KR119OqXGM0GjC6IgKU82Ldw162Zz78+g5B4OrxU0yHOfeTy50TL
         BwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KazpKbhHu00FeDDiPuVEMFaRWnbqcqwHcNdLtMoOcsY=;
        b=QJ8bFRQtMzuyyTyFmYIksL1uc5xEe7Sn1u+nZeJGobf1tF4rlVboR6ywWvgp5fe6Qv
         L93aKyoVbTCxXSgV7PnylZ+nVZ/dnfHnzmLnC3zKuscXn20/XzUb8u8lpLXr59tCXBmn
         yD6wY3UdhLeNuw8yRq8v+9VNddjo3t2UJga0lJKZe6xYWurw4vNVu1ZNZJBk+iSj7G9r
         Ok+TdZNdDed4OP4e/RsCNFqTRVnAGuxaDesxzojIYGn4z4Mzef8JFsr5eeBt6xUK3CBw
         5eaf6QPKO/+6VjgFXqscPUehW96OHFGXuuRhMbv6zd7jvDfiqoVbMe0eZ9ICFvsRyb/k
         WMcw==
X-Gm-Message-State: APjAAAUoIanpDwaoIRgh4Sc5Z49zWdcZzEuX8/sPutS9r8Bi6xrJQR7I
        k3XWBCfT7ovwFw1ISsVSfA9Vxw==
X-Google-Smtp-Source: APXvYqxZqbGbb8rEAZtuGWj3Z/ByRS0P9lJZBtlaYx5SRTsxdaUIbZMmBZGoyMBP+H11pK7IY+SnlA==
X-Received: by 2002:ab0:2756:: with SMTP id c22mr4174211uap.22.1562852357161;
        Thu, 11 Jul 2019 06:39:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s67sm2549736vkb.30.2019.07.11.06.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 06:39:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlZI3-0007pP-MZ; Thu, 11 Jul 2019 10:39:15 -0300
Date:   Thu, 11 Jul 2019 10:39:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190711133915.GA25807@ziepe.ca>
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
 <20190711081434.GA86557@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711081434.GA86557@archlinux-threadripper>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 01:14:34AM -0700, Nathan Chancellor wrote:
> Hi Bernard,
> 
> On Thu, Jul 11, 2019 at 07:44:22AM +0000, Bernard Metzler wrote:
> > Nathan, thanks very much. That's correct.
> 
> Thanks for the confirmation that the fix was correct.
> 
> > I don't know how this could pass w/o warning.
> 
> Unfortunately, it appears that GCC only warns when two different
> enumerated types are directly compared, not when they are implicitly
> converted between.
> 
> https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wenum-compare
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78736
> 
> If it did, I wouldn't have fixed as many warnings as I have.
> 
> https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aissue+is%3Aclosed+label%3A-Wenum-conversion
> 
> Maybe time to start plumbing Clang into your test flow until it can get
> intergrated with more CI setups? :) It can catch some pretty dodgy
> behavior that GCC doesn't:

I keep asking how to use clang to build the kernel and last I was told
it still wasn't ready..

Is it ready now? Is there some flow that will compile with clang
warning free, on any arch? (at least the portion of the kernel I check)

> Kernel CI has added support for it (although they don't email the
> authors of patches individually) 

Well.. we didn't see any emails till yours, so if others are looking
they aren't communicating?

Jason
