Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A85A91370F4
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 16:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgAJPSc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 10:18:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38756 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgAJPSc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 10:18:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so2137238qki.5
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 07:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B+3haEOPipgxF04LKi0J+YInzgh9D2MD8lHtCrVqiDM=;
        b=QXvHjzkN3bl3FPwoElPIAcEffEe6FEsvkWYcnH5XDtB7WDXbGRF7cGrWjgBqOWsqDn
         SXAs31Yolv9pnLf54Mmdtt0fNgBbzpzEgQ7SUqChFIni4MaWGywORjvr4MvRol9i4m1/
         JoPYUmkOQGD/0BYpQIgfoKlIuw+PKGQFYgeR4ZN/kUIEWXxAwvtR+gzQkEmuEW58pbZd
         A5dFxUzTlCeHaTrXxToyNHOoWuu4rOwSI0KOVuf7UPkzQBToBD/5Fwq4axLe88SDGihM
         jOcvSBG/MLjU9la8nFmt2U5Cm55ywTE7GGNbxobZSTELnLsqI3Wu5U2OoRxUEMn+JmUS
         E+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B+3haEOPipgxF04LKi0J+YInzgh9D2MD8lHtCrVqiDM=;
        b=HJUaSnWlsoIrc10LgA6EyIDLdKBoJ0GAwRivqi8st1dGjbEveDoOOGOsnyAcfGleDh
         DPtuK9Z5pGVyaWoFEjqBpCZK++P5rO05FV7jkmP9Nh9IQ3ujFkA4wcy9F23NVTc1xKdY
         7XPiMB9upZRsIPlwVIrfSInnRFjZpqIy/r+BIeOr8gXIYZk/6C2j+4p/kXp9GJcHcGBd
         Dq2554Spmh9j0coqDwshWGJLxJxqUf2uUjXOJGT6RQl8hjCyMBcyuvr5f0fVG7ha3Fxu
         pjQOKDhd1cN0Yo6T9ArGkXNCYXHUovK8fQ0XovCIJ3J32edCFUCQO17wG1FPLpejBddJ
         CEzw==
X-Gm-Message-State: APjAAAXGWZtoouwJU9hlTtG3k9LxJ+HK0ooW9v4ygsBRzrMp6JVcMj4G
        pq0wW6TTCBIIPyoVDNDTbgVLPg==
X-Google-Smtp-Source: APXvYqzBMOXJode2F7SI/B1+fbjNcnTWXuPJGDMESys3QTVdCMaKqVMJUntULHXPOnq02fycrVUJ/w==
X-Received: by 2002:a37:8e44:: with SMTP id q65mr3708908qkd.70.1578669511611;
        Fri, 10 Jan 2020 07:18:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id e2sm974002qkb.112.2020.01.10.07.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 07:18:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ipw3S-0001wK-9q; Fri, 10 Jan 2020 11:18:30 -0400
Date:   Fri, 10 Jan 2020 11:18:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Bugfix for posting a wqe with sge
Message-ID: <20200110151830.GA7407@ziepe.ca>
References: <1578571852-13704-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578571852-13704-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 09, 2020 at 08:10:52PM +0800, Weihang Li wrote:
> From: Lijun Ou <oulijun@huawei.com>
> 
> Driver should first check whether the sge is valid, then fill the valid
> sge and the caculated total into hardware, otherwise invalid sges will
> cause an error.
> 
> Fixes: 52e3b42a2f58 ("RDMA/hns: Filter for zero length of sge in hip08 kernel mode")
> Fixes: 7bdee4158b37 ("RDMA/hns: Fill sq wqe context of ud type in hip08")
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 41 ++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 16 deletions(-)

Applied to for-next, thanks

Jason
