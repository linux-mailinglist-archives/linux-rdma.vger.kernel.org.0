Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45EA2E0B22
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 19:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfJVR6X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 13:58:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32818 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfJVR6X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 13:58:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so28150584qtd.0
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eIBqZPIL9lWCHVPBIQMtPrTLxfK89BZ1hdzXod0rGi8=;
        b=jcze28WDC+TzlqwTacEl9hZAgVP4ZqsycW1bvaBP+9KRjUTbM+H7cvDgVu5qqhfCpP
         /3xkdWPhuGWxQgChqCTlyvFw+RqmYDRzDchuPh9cIAiuGhwvgmkJ9MKRm8l5xE2GJFM+
         n81oBjkXMHA1aj1zqMMOnNgVD8jhfcSjeXdhJH0ndGQCzz+NH7Itmi7Dv+K5+nvUhXC/
         YNrP5b5T1G9n+Aqo6s41yE/xSIzAjnMVwVvxsaCRiwt0MQKVWiAnt1BCHRkxM5X0hyOw
         YY8ygAFkwaKuLmlGD98cyZ/LVSYcGY494y/EI+PJa/eJ4PxeuR9mr7dd1z6/LH8aBe5W
         56Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eIBqZPIL9lWCHVPBIQMtPrTLxfK89BZ1hdzXod0rGi8=;
        b=L3AwX5wSOksxWt202cXfmtz5V5RJl9xnVy2yatSfqfxDtx/HZbNhZplz//iXwWzE46
         qlg9Ns5XPLMxUJ8jIimAUUOnBABCAnR5B+t1Q+OxGP97Wt88m7TCK/piL0wNKzn+Uv+I
         IeGqKvrA2TEWH+GwPSb25R5R1uW0+JTasH1UN4QUCclmgnFukauDmiIZ/OsZqCeEcI08
         +dlVXziI1WdSJL4KMJeXySIiRwuM3BDY0t2M/ZU8rWhXcCUA6tjx6ESrkdxQMRl1GD/u
         sNd8hHfPc7CyADy+JSAHCOWHcQ4NvxelHE0De9VEvVwqphPWNo7emVZhDPMYqlU+KQZb
         sFRw==
X-Gm-Message-State: APjAAAVMjgM8nC/ttlI40q2kWiHFD0wzGG70Gs1Pt/pz8Qu9K7TrJLak
        Me4BqH5vGy+IadKivBfJdFj1eQchan0=
X-Google-Smtp-Source: APXvYqzuCHrg/b/mkd9EC788k+TQDmW95BubuMm8ANhk/k2UJi1z5E8r0BOMXWOYHoQD40hGigA6Yw==
X-Received: by 2002:ac8:23e8:: with SMTP id r37mr4804893qtr.365.1571767102562;
        Tue, 22 Oct 2019 10:58:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h3sm3031491qte.62.2019.10.22.10.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 10:58:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMyQH-0007D3-E8; Tue, 22 Oct 2019 14:58:21 -0300
Date:   Tue, 22 Oct 2019 14:58:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Yuval Shaia <yuval.shaia@oracle.com>, bharat@chelsio.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] iw_cxgb3: Remove the iw_cxgb3 provider code
Message-ID: <20191022175821.GB23952@ziepe.ca>
References: <20191022174710.12758-1-yuval.shaia@oracle.com>
 <ba91bb6c42e18e72cd6eaa705067a9cb30a02853.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba91bb6c42e18e72cd6eaa705067a9cb30a02853.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 01:57:18PM -0400, Doug Ledford wrote:
> On Tue, 2019-10-22 at 20:47 +0300, Yuval Shaia wrote:
> > diff --git a/kernel-headers/rdma/rdma_user_ioctl_cmds.h b/kernel-
> > headers/rdma/rdma_user_ioctl_cmds.h
> > index b8bb285f..b2680051 100644
> > +++ b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
> > @@ -88,7 +88,6 @@ enum rdma_driver_id {
> >         RDMA_DRIVER_UNKNOWN,
> >         RDMA_DRIVER_MLX5,
> >         RDMA_DRIVER_MLX4,
> > -       RDMA_DRIVER_CXGB3,
> >         RDMA_DRIVER_CXGB4,
> >         RDMA_DRIVER_MTHCA,
> >         RDMA_DRIVER_BNXT_RE,
> 
> This is the same bug the kernel patch had.  We can't change that enum.

This patch shouldn't touch the kernel headers, delete the driver, then
we will get the kernel header changes on the next resync.

Jason

