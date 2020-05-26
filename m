Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61B71E219E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 14:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgEZMIT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 08:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgEZMIS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 May 2020 08:08:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E028C03E96D
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2020 05:08:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v79so10142288qkb.10
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2020 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3sNXpcfwj4xm34azJki9t/I5tvb8FbYSE1Ld3Cew5Nw=;
        b=n7xTimxsrWNPWfvZJM/qR/YvwNPJy8raYbP49JGqtkJwL3HT3awx0EYnrJ/2pQX0e7
         nORjVTByfBCVPfOsLCJ0rG9TOzsyrmYpD09q0L7f9W1SlDO3i4OZ4b89RkF1iXIYVvJi
         o+wpONJdf8r7/XvwQtBCh7CisVc/ZC5okGXSvmZ5cHtTGLVe4+3kMz8FZ25Fw76eAREB
         +0gkfyimsSDLt0sAdFTBtqx1Jv/wkn8aZo6QDjoBoaWjUcBqKa3Gl7W66Gw+0Vb/vg92
         PYAVD5I7nx9RFCOXXIoU1PbIwYm6cuEZH3jCI6jGNid+Pf7LBqV29S8Fc39m+5QJlgij
         d37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3sNXpcfwj4xm34azJki9t/I5tvb8FbYSE1Ld3Cew5Nw=;
        b=dWP8UKVzxycZCnCAs0BXCI8VU4w3ELvnQHqlZYmDPrnl47aVMsgnjEzZqmia6arTyb
         cLboN4+OyvIete8PDzTMxWDNb4qv8YsG2NR0oWihUOj3N1ip/6xYSSo9AMbsLRaUgOAw
         8mU/F13TPh8BiyoYSkQ1vfRI31HQBX6SlrZRPs9WmC+RKom5QqkCZBhDP48p4dG4NBx/
         BY3s0W7XaH7ckIOaXoxiRzQNz3SyM87+lhLi7Fl7srifg70eikCAPFExz/wh2FuSXI2g
         bXKSOGoaD5D8gmj+tTJ1TcjS5FDpbdU2Vc5sGGAW9svDxJBjKHRS+STqqv/SMt/5bTua
         bitA==
X-Gm-Message-State: AOAM533WsRMEmk81A/tlMnwzcuD5GPSCD4z6h0HO6n8ex5uYow4Ybuh4
        wG29IoY4pb8XGWHxC2mZg1NRWQ==
X-Google-Smtp-Source: ABdhPJw3k99jhPwo+OrcN6BO6SsiIpMPXBxp3XBS4NFGy2LdMn6Icgm4SbOh7EcFDyiNc8jPvum3AQ==
X-Received: by 2002:a05:620a:54b:: with SMTP id o11mr954617qko.222.1590494897693;
        Tue, 26 May 2020 05:08:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q4sm18670957qtf.35.2020.05.26.05.08.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 05:08:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdYNU-0004rc-Gp; Tue, 26 May 2020 09:08:16 -0300
Date:   Tue, 26 May 2020 09:08:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 2/9] RDMA/hns: Add CQ flag instead of
 independent enable flag
Message-ID: <20200526120816.GL744@ziepe.ca>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
 <1589982799-28728-3-git-send-email-liweihang@huawei.com>
 <20200525170647.GA16200@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A02387A2A@DGGEML522-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A02387A2A@DGGEML522-MBX.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 26, 2020 at 02:57:39AM +0000, liweihang wrote:
> > Also, if someone wants a project, all this endless stuff should be
> > using genmask and field_prep instead of this home grown stuff.
> > 
> I took a look at this macro, FILED_PREP() can indeed simplify lots of
> similar codes in the hns driver. I will take a try and maybe prepare a
> patch/series to use it in v5.9.

If you look in the git history you can find some Coccinelle spatch
stuff that makes work like this not too hard

eg 91b60a7128d96244794beb9b324eb39273872da2 did something similar for
the IBA CM MADs

Jason
