Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC6915463C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 15:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBFOcE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 09:32:04 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42452 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbgBFOcE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Feb 2020 09:32:04 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so4594038qtq.9
        for <linux-rdma@vger.kernel.org>; Thu, 06 Feb 2020 06:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pyov8FWczadKme8MmKIuLoy6Cco1Gr8F1ki//7JnOus=;
        b=WtfTXcpxEKjugOdoQ3xRt6ZtM85WSP/qurSvrIDFedMQ2O9pvih8+hrmBuSGbGmtGa
         N1n3Fw8knLnnvb4ofVFPGUTG8T0U0PeyP8xMS3/9Phf4gnK3Xkuo5liOPa6zSihQt050
         bHZ6g4WV7jzYWWvSMRUIjVeclvvWj1QN/pRkO/wlWK/FS9lTji60yAGE2RAh4DvLbG3A
         AJscWPn+Yr6fwftqrnGtCXO/BsrB/LhpM8M7B90l4AynGy1W+ewNGKa5Hg98AllDlDfW
         F8d0+S5Wal6FlyjvAqBXml5yz3NfepnpIaBxYYKBSvjyeI6ovASl9pm85dJE0IsAYwq1
         2pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pyov8FWczadKme8MmKIuLoy6Cco1Gr8F1ki//7JnOus=;
        b=W+8oNuYqr8/GpbdtepPk5ZR1yOWvZQG9XiPZoZHNePRUYqqFQBCDUKb6vGG26wzcWY
         IybpVFvh/fB9ELeMqThhn82yieg8xi/ZVE+bU5ZED31e0ccRFSjmrIVXdVXYQq+g9XyX
         bji1/SfEgDxQYBwON/qG0Zh34Q7lOCIfJ8zUqhCmscbrMVYduIP+K82omVmVfBwsLgc+
         tpuHGMDwCnRCgrLd4bJJDQCpPLqswC2ZFMFjxmsCgnUIX4bzyYGRGs7B/qEEWeEzJdaH
         wiuXIqgrCBWBjV0PYnTJSdcdq8NcStia5OLa6MQCKdLBr7d9gBCNkU+9l5jhUCjCQABw
         zugQ==
X-Gm-Message-State: APjAAAWD5IYEhwxMgusQ5WEtfx4VbelgqR4eYtaVWWK4m79zUEUQ7yQ6
        tsgYclzqwfn78Eqw/puMOxWOXA==
X-Google-Smtp-Source: APXvYqxaFmlEZVaYCGxniyRdpgnZCuo+d+DFXAYGbH+kt4gdysoKdLuey3EiRMl+NGSIfVqKZgszig==
X-Received: by 2002:ac8:7695:: with SMTP id g21mr2570013qtr.99.1580999522855;
        Thu, 06 Feb 2020 06:32:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 69sm1464198qkk.106.2020.02.06.06.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 06:32:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iziCH-0005pg-Sr; Thu, 06 Feb 2020 10:32:01 -0400
Date:   Thu, 6 Feb 2020 10:32:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: Tree for Jan 30 + 20200206
 (drivers/infiniband/hw/mlx5/)
Message-ID: <20200206143201.GF25297@ziepe.ca>
References: <20200130152852.6056b5d8@canb.auug.org.au>
 <df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org>
 <ee5f17b6-3282-2137-7e9d-fa0008f9eeb0@infradead.org>
 <20200206073019.GC414821@unreal>
 <20200206114033.GF414821@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200206114033.GF414821@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 06, 2020 at 01:40:33PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 06, 2020 at 09:30:19AM +0200, Leon Romanovsky wrote:
> > On Wed, Feb 05, 2020 at 09:31:15PM -0800, Randy Dunlap wrote:
> > > On 1/30/20 5:47 AM, Randy Dunlap wrote:
> > > > On 1/29/20 8:28 PM, Stephen Rothwell wrote:
> > > >> Hi all,
> > > >>
> > > >> Please do not add any v5.7 material to your linux-next included
> > > >> branches until after v5.6-rc1 has been released.
> > > >>
> > > >> Changes since 20200129:
> > > >>
> > > >
> > > > on i386:
> > > >
> > > > ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> > > > ERROR: "__divdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> > > >
> > > >
> > > > Full randconfig file is attached.
> > > >
> > > >
> > >
> > > I am still seeing this on linux-next of 20200206.
> >
> > Sorry, I was under wrong impression that this failure is connected to
> > other issue reported by you.
> >
> > I'm looking on it right now.
> 
> Randy,
> 
> I'm having hard time to reproduce the failure.
> ➜  kernel git:(a0c61bf1c773) ✗ git fixes
> Fixes: a0c61bf1c773 ("Add linux-next specific files for 20200206")
> ➜  kernel git:(a0c61bf1c773) ✗ wget https://lore.kernel.org/lkml/df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org/2-config-r9621
> from https://lore.kernel.org/lkml/df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org/
> ➜  kernel git:(a0c61bf1c773) ✗ mv 2-config-r9621 .config
> ➜  kernel git:(a0c61bf1c773) ✗ make ARCH=i386 -j64 -s M=drivers/infiniband/hw/mlx5
> ➜  kernel git:(a0c61bf1c773) ✗ file drivers/infiniband/hw/mlx5/mlx5_ib.ko
> drivers/infiniband/hw/mlx5/mlx5_ib.ko: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), BuildID[sha1]=49f81f5d56f7caf95d4a6cc9097391622c34f4ba, not stripped
> 
> on my 64bit system:
> ➜  kernel git:(rdma-next) file drivers/infiniband/hw/mlx5/mlx5_ib.ko
> drivers/infiniband/hw/mlx5/mlx5_ib.ko: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), BuildID[sha1]=2dcb1e30d0bba9885d5a824f6f57488a98f0c95d, with debug_info, not stripped

You need to link to see it..

From bee7b242c2c6a3bfb696cd5fa37d83a731f3ab15 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Thu, 6 Feb 2020 10:27:54 -0400
Subject: [PATCH] IB/mlx5: Use div64_u64 for num_var_hw_entries calculation

On i386:

ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
ERROR: "__divdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

Fixes: f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR capabilities")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 0ca9581432808c..9b88935f805ba2 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6543,7 +6543,7 @@ static int mlx5_ib_init_var_table(struct mlx5_ib_dev *dev)
 					doorbell_bar_offset);
 	bar_size = (1ULL << log_doorbell_bar_size) * 4096;
 	var_table->stride_size = 1ULL << log_doorbell_stride;
-	var_table->num_var_hw_entries = bar_size / var_table->stride_size;
+	var_table->num_var_hw_entries = div64_u64(bar_size, var_table->stride_size);
 	mutex_init(&var_table->bitmap_lock);
 	var_table->bitmap = bitmap_zalloc(var_table->num_var_hw_entries,
 					  GFP_KERNEL);
-- 
2.25.0

