Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC872DA9
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfGXLcz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jul 2019 07:32:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34978 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfGXLcy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Jul 2019 07:32:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so45114735qto.2
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2019 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eynjgUU3LO9/cX6Oi8VqmlxPxhsFPzKIycVhDFmwkho=;
        b=M8c9YZKYL5TIbtUIVVLH5qwpFoFyhUZ9ccOGIkFj4eVt+NECKrDV/Kkcji4bpstToy
         UPmw29H922tPtKY46av4Yuuua0qB4GXCEo25rkRUIVpsfuQvrhm2rN1+5swV89eUwije
         +1YrWpVEa1b++e3eZrgwLuk/hMOtTzvD0244mqysh/TPjzY0TENWGBUBjgUJ1huQ6MVY
         kpoXR7KhxUEnbbE1V+EPLuWhO6rD2kl68BV8aFYBIIexS7btc+0awTM3iRXyguhyQkAv
         kbFN1EJA3ccjPEZdYq7fif+3mvIXObB0JQLqcAbRNHT6my6ARwZgCFU4EwDOucFZ2gXI
         rnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eynjgUU3LO9/cX6Oi8VqmlxPxhsFPzKIycVhDFmwkho=;
        b=MNFN81SYzFKhBEnLqSZbwriBXy1XXVZhjTetv4FJS2XabAbmb8rKw7WksI+VdnGa06
         zlJUzi+toVesMYX8X/kQ/4LsIldpAR0n0l//J38Dxulg1OKa+HEC2oIWL6xsID9XGpib
         BlknRtfjyQPdwTinW/UESbRk7FBY+IWeFUSWMeK/rIPwmUhJBVKemqbxfHFjiKZlqX0s
         mte4t6auLHWbU+qOhyhQKWkKb476bjkB2LUnEm8ElNCsohMGsnzscYlZAnmMQIfmLzzH
         TywEPuTjH5S2EiR5q18G66ospYSDlslu0B9dm5dF1vM964uRKdV0jVFvSt1iu3Tv7OLK
         Gtvg==
X-Gm-Message-State: APjAAAWInQqH6ljv/IrAD1Gp4wd3O1qXtdOBVDUYWXfLfFgzwEfH34oc
        QvHwz8e2NAWV1kdh6+wRZFFaGg==
X-Google-Smtp-Source: APXvYqxDoEA7McnePKPXUTQRMBXSoB6Dq/gMsyEXzcL8Xc9EMyCc9NVWXUrhefddcSkU76K9Igsmlg==
X-Received: by 2002:a0c:b50c:: with SMTP id d12mr58124931qve.70.1563967974002;
        Wed, 24 Jul 2019 04:32:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y42sm30058475qtc.66.2019.07.24.04.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 04:32:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqFVs-0007jC-7Q; Wed, 24 Jul 2019 08:32:52 -0300
Date:   Wed, 24 Jul 2019 08:32:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     oulijun@huawei.com, xavier.huwei@huawei.com, dledford@redhat.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix build error
Message-ID: <20190724113252.GA28493@ziepe.ca>
References: <20190723024908.11876-1-yuehaibing@huawei.com>
 <20190724065443.53068-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724065443.53068-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 24, 2019 at 02:54:43PM +0800, YueHaibing wrote:
> If INFINIBAND_HNS_HIP08 is selected and HNS3 is m,
> but INFINIBAND_HNS is y, building fails:
> 
> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_exit':
> hns_roce_hw_v2.c:(.exit.text+0xd): undefined reference to `hnae3_unregister_client'
> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_init':
> hns_roce_hw_v2.c:(.init.text+0xd): undefined reference to `hnae3_register_client'
> 
> Also if INFINIBAND_HNS_HIP06 is selected and HNS_DSAF
> is m, but INFINIBAND_HNS is y, building fails:
> 
> drivers/infiniband/hw/hns/hns_roce_hw_v1.o: In function `hns_roce_v1_reset':
> hns_roce_hw_v1.c:(.text+0x39fa): undefined reference to `hns_dsaf_roce_reset'
> hns_roce_hw_v1.c:(.text+0x3a25): undefined reference to `hns_dsaf_roce_reset'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08 RoCE")
> Fixes: 08805fdbeb2d ("RDMA/hns: Split hw v1 driver from hns roce driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>  drivers/infiniband/hw/hns/Kconfig  | 6 +++---
>  drivers/infiniband/hw/hns/Makefile | 8 ++------
>  2 files changed, 5 insertions(+), 9 deletions(-)

did you test this approach with CONFIG_MODULES=n?

Jason
