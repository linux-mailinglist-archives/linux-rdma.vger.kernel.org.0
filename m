Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3453564C0C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 20:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfGJS01 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 14:26:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42627 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfGJS01 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 14:26:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so2664466qkm.9
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2019 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g2+6yeYN+3vI29rODOmLOhqDB3fSrrUGXJ7yMKJfWBA=;
        b=nHTREbiykhoxsXUKbKVDSyCrN9c1C+4e+EPeTqBJfniHHpLXBTAQ5/6FJhrlG0OmNy
         LDI2ZrHB/YWFEeYno4nlYcqMMaDxG4p4vYKjpcHX4m0wvU+VutA5sAu+1FKcIboPjp41
         LejgcDFeqRGHyOLQu/6AQE5ocMW13bW9Apj1L5NtqlCf8ihRJuu3a3cuo6+EbaX/DnmJ
         s3LWaYjPB56WRS2bDdv1euUVESWEecbR6ZQ5ML+GERIcgeHFPSCmtJrvsVHaB7w2/Zdc
         cduq0R8tdGcJAstHZW75gbZNvWoWVS5SwWgfu5xj0kvrk0lUcMqvbZ71FudVk1n/0vRZ
         cGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g2+6yeYN+3vI29rODOmLOhqDB3fSrrUGXJ7yMKJfWBA=;
        b=PJDocB4hoQzXQ2z4twxCq4D1Z4oZyvE0n16MNHlNN6WhOhpesA/Wakj3CMgyyHQfhf
         iOE8uAgcImREP1YmBD4mv9vME28oRBjH7RzGw5baRypAYEVjMTOYBmLQqQZ4D/3Ilem2
         OuvKPUX2lln9FW9+L1pvdcT74XoZOcauar7HZWryRcM3xbjZcR7I7LyvYxOTjtn5OtEi
         Fp1D4NOqpORQlbzgqD8rJgT6KBf26LDHRKJ7LDIZjZU+krdaaHC/6cobpbVYD3FgHntU
         n792tXYOZYXE8dzaF2lZvPVS2OytxDLoUWfmVGogvRxMEkFiZ/ZvdEkS6Mo/aZ7IFEdI
         jSTg==
X-Gm-Message-State: APjAAAWlp4vdUtCY9aEYYWUDGhJYPRzi35zntopkNo8RT4S3QmRHN2cS
        e7IzfO+qqqNLMScWW5YpAe4rNw==
X-Google-Smtp-Source: APXvYqwfZcwhFY9pJB/xMLdQlIh6iSHBKEb0/JDEEeFmpBZa/4TMmX4e2vCJC6uxFdd/4HVuFcZjsg==
X-Received: by 2002:a37:4e8f:: with SMTP id c137mr24147053qkb.127.1562783186289;
        Wed, 10 Jul 2019 11:26:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w16sm1303926qki.36.2019.07.10.11.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 11:26:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlHIO-00023S-VL; Wed, 10 Jul 2019 15:26:24 -0300
Date:   Wed, 10 Jul 2019 15:26:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190710182624.GG4051@ziepe.ca>
References: <20190710174800.34451-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710174800.34451-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 10, 2019 at 10:48:00AM -0700, Nathan Chancellor wrote:
> clang warns several times:
> 
> drivers/infiniband/sw/siw/siw_cq.c:31:4: warning: implicit conversion
> from enumeration type 'enum siw_wc_status' to different enumeration type
> 'enum siw_opcode' [-Wenum-conversion]
>         { SIW_WC_SUCCESS, IB_WC_SUCCESS },
>         ~ ^~~~~~~~~~~~~~
> 
> Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
> Link: https://github.com/ClangBuiltLinux/linux/issues/596
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/infiniband/sw/siw/siw_cq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Weird that gcc doesn't warn on this by default..

Applied to for-next, thanks

Jason
