Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1972204B0
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 13:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfEPL2o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 07:28:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33611 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfEPL2o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 07:28:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so3024643wrx.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 04:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vXDRNLgoGMN6g5/iZYTdUiGMMZTk0J2NCfgCWTFIutA=;
        b=TVmjG0TfVEMMNGe1AtUDLcVjQgtJ1wzQvJLsA4/x6fPx7ed3r5jbOKVdVcAt9Ux4OW
         XHxhN+3CmxOo+MXxW/cWzBEF9/ZXS20kjmwPJWW+hoPeHv51j9eceAX81LMSQOyCGfzB
         twKcXUB6ShNGWvYTcrsRlwWh0eM2prPh5IOV5QoqA+8pldsRiTmkxFx2O5lZGxckshVo
         bLdFhravRTn5+rzns9XwRTiwrKA53/+uH9IFIBBRJayx9J1j+reYrYS2HiLQWlYWxpxF
         4FgPEEyIYXp5jskXi3WXdGwIXEfCiC7eQcLXjrDPbHOfLb3y0q1eA+SrMYwr/d0oKoaB
         t29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vXDRNLgoGMN6g5/iZYTdUiGMMZTk0J2NCfgCWTFIutA=;
        b=YErJGr12aS2V9A5xgM/NgDCpH2jWdFyZ7OwMwmOMdybRxeYbW3yrC1YsNmY1l21geh
         loQyaa2P8LAvUP6QpClLgPYA2JBhpGGrVjBkvjJTYBS3jojS8KRzaJIYy5MpV3Bg7dgk
         9ZPcj01Lf2AYN6TL3mqyQSHC7UM0OAf+I/eCQtSTHXeeyvEfPxVfChbT5gmFWLE1ajuz
         EEbNJtOxiS1EVVcEb4yovfl5o2p2NomzxgLGl6XJJ3ortT/rYfSd/Y9c7fqCIuEfTD/n
         SJ/5JpeNWEtAlfpTLoou2yXUi/wAMFNMN1T/xePGqNyiyh8kurkaEBikDAUaGoF+aAJU
         L1zA==
X-Gm-Message-State: APjAAAWeK3U9FJ8we9jqOcYEKGDPbFQkNkb69S3WY/XaL+uCqYpN4XUR
        g3B8Xn09yUluMUbS2mQSVSM=
X-Google-Smtp-Source: APXvYqyopLYCbCObCsDFf1BfsMPIdmbj2QILez8vuEbIJODm//lC7xxy8sOr5KvA9xM2s82ADHRWkA==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr12892749wrj.121.1558006122809;
        Thu, 16 May 2019 04:28:42 -0700 (PDT)
Received: from kheib-workstation (bzq-79-181-17-143.red.bezeqint.net. [79.181.17.143])
        by smtp.gmail.com with ESMTPSA id x6sm6931250wru.36.2019.05.16.04.28.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 04:28:42 -0700 (PDT)
Message-ID: <3c53c827f287df7f46b58c7f5e2fd23207a83683.camel@gmail.com>
Subject: Re: [PATCH for-next] RDMA/providers: Simplify ib_modify_port for
 RoCE providers
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Date:   Thu, 16 May 2019 14:28:40 +0300
In-Reply-To: <20190516111607.GA22587@ziepe.ca>
References: <20190516105308.29450-1-kamalheib1@gmail.com>
         <20190516111607.GA22587@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 2019-05-16 at 08:16 -0300, Jason Gunthorpe wrote:
> On Thu, May 16, 2019 at 01:53:08PM +0300, Kamal Heib wrote:
> > For RoCE ports the call for ib_modify_port is not meaningful, so
> > simplify the providers of RoCE by return OK in ib_core.
> > 
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/core/device.c              | 23 ++++++-----
> >  drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ----
> >  drivers/infiniband/hw/mlx4/main.c             |  8 ----
> >  drivers/infiniband/hw/mlx5/main.c             |  6 ---
> >  drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 -
> >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  6 ---
> >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 -
> >  drivers/infiniband/hw/qedr/main.c             |  1 -
> >  drivers/infiniband/hw/qedr/verbs.c            |  6 ---
> >  drivers/infiniband/hw/qedr/verbs.h            |  2 -
> >  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 -
> >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 38 -------------
> > ------
> >  .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 -
> >  drivers/infiniband/sw/rxe/rxe_verbs.c         | 18 ---------
> >  14 files changed, 14 insertions(+), 107 deletions(-)
> 
> We have more roce only drivers than this, why isn't everything
> changed?
> 
> Jason

Not all of them implements modify_port().

Thanks,
Kamal

