Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 677E212FD3F
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgACTvG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 14:51:06 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39948 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgACTvG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 14:51:06 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so16665524qvb.7
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=20UZVGh9lMCX1VEX5j+FQUz4EkoGFM1MrKDAUKLEH4I=;
        b=Y8af05+hjyuyMA6LAMBmLCoFvwauwEM6/UwLa0OShgwhybk9pG+hkp9z34GGNKV8ai
         /wP/X4K2RtYuFcAKkr5Xfy2xu7rwC/MxlJ04D0wAyol2K25Qh+/6C0bKW/SQxyL/StGM
         uAFKZOGmLvSxAHJ9CUTC4DIHhpG88C/3d+wCJVbkXFQcGZ8p7TFSoY/3vis4RFeDtrvE
         1IUffFLRk+E/9JIg2vxtAYWumj2yhYvHe2dIdqUUuPiE9xg6ATLFzYQNt2zg0vgMgxaq
         VuCuU1RCAUmRyG599RYtvvv52bWpRRIeuLCjBeTBc88RTk+Vrt0vYYLspJlzsttENH+t
         SzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=20UZVGh9lMCX1VEX5j+FQUz4EkoGFM1MrKDAUKLEH4I=;
        b=GVtox8e+5+K+aplEgHBmQ62sAdAHvAcT3CZoU8p7WYbb4hxNheOJkotl017bKscI1f
         L4cM0q53OZ1EWPDyT/Ee4trAoz76madRaSYfHySdkILZBPxNahw+ljTl6LNxxfXlKBM0
         2XeX1vW9BdNrCn6yqUSfAf6sf6UO1ftv6id6w/7BgNTtZKfOEKATXgKxcO13VJntsc2z
         8ZVeMA6gEZqtB6IIvPtXaKdoncfD7CaD3shhNHKNqFvlfv/0tDMKVTmqx2ctO1YbBO6K
         9cYPSTA4msMyZKNcbA5fwBf8ikcUdbJxFNddV4qnqZaQt+2uCBZGTTLf9R//SXx+NGlK
         BrvA==
X-Gm-Message-State: APjAAAXRtrvkqJFlMosJolj9z91TAg/BIK6aOiLshLXm9kOyUwxl1N0c
        X3LTi1USXgZR9JC2NaebGkZCPSlIv/0=
X-Google-Smtp-Source: APXvYqzTl9zpjjT+H2AHlodVRcdyopqp6XYVMh8btVQBpbjPt1VmFzt5zfODKGgkOpzc0qhiDpklQQ==
X-Received: by 2002:a05:6214:1242:: with SMTP id q2mr71430700qvv.178.1578081065067;
        Fri, 03 Jan 2020 11:51:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 200sm17092305qkh.84.2020.01.03.11.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 11:51:04 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inSyO-00059H-8k; Fri, 03 Jan 2020 15:51:04 -0400
Date:   Fri, 3 Jan 2020 15:51:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Simplify the calculation and usage of
 wqe idx for post verbs
Message-ID: <20200103195104.GA19725@ziepe.ca>
References: <1575981902-5274-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575981902-5274-1-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 10, 2019 at 08:45:02PM +0800, Weihang Li wrote:
> From: Yixian Liu <liuyixian@huawei.com>
> 
> Currently, the wqe idx is calculated repeatly everywhere it is used.
> This patch defines wqe_idx and calculated it only once, then just use it
> as needed.
> 
> Fixes: 2d40788825ac ("RDMA/hns: Add support for processing send wr and
> receive wr")

Please don't wrap fixes tags

> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  3 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 37 +++++++++++--------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 43 ++++++++++++-----------------
>  3 files changed, 35 insertions(+), 48 deletions(-)

Applied to for-next, thanks

Jason
