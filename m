Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49227DD57
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 02:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgI3AWn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 20:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbgI3AWn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 20:22:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B39C061755
        for <linux-rdma@vger.kernel.org>; Tue, 29 Sep 2020 17:22:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b2so5251818qtp.8
        for <linux-rdma@vger.kernel.org>; Tue, 29 Sep 2020 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zsb7D7WYfYK7JiNlBETYZlTfptxIqlFMeellzlYnbCY=;
        b=XTGrYJINo3wICOpW1YzHVuXzCJX7nYj6VPkEkRZagWTqRzFw7lluiM8p/hkYwb+cWe
         2cpCuQZuUPCPAM0lgvzJTH2oA4yybuuAk92RniQ41AYEqH6TwhdzumUgPm3t39jieftP
         zKbcMTIVTGOZqFNxTkeA6uIZR2l+mNKXVzzqVxu3xsTqBS3WW2rRgahTPUYdxssDqZZm
         nkUBEHxk7Q+5Cdm3pYE8lZCC5p+gvIZvvkIuG8doTHIVt/d9b7pS6b+6nDyBe+qp0oDV
         M1wfUAPC91k2MIHhR5Xo1y7Bbadh4ykoCKuMMRx4jvTu1rJU5Bb4TjML8bcW8vs1wPgz
         WmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zsb7D7WYfYK7JiNlBETYZlTfptxIqlFMeellzlYnbCY=;
        b=tJiYbvuRa5uWEPLZR18Daok+TfWEmDtwGKPtpUK9pECZ3Dgrq2SqTcK/qycin15ndA
         eFXggX5H7TtryQ11GFuG5ogMdP63mBuNdWUv5zqYUHeb5YnJUrQustYfdS23FAuwxjg3
         eT3S4aQp4vKyxDbITZj43o5xcwzKWwVuJiTl0HPOzUIjq/RKnok85u9ffkBRPCP594wf
         HGtCLjUAQdnQEV61L3tlNVK5C3MYl2rNRP/My9DgBHfHEnL9CaiQkclWUBaFgTYzUQ7U
         RCuQg1/ePVCSIMKCNn8B+LnSOPEvKuGXv8y8X4rUCNP0ZC5xc8ysG80SWaVqzC1UhEnN
         4GMA==
X-Gm-Message-State: AOAM5331fp1t9V7Jp2Sa6vD3uoz7o9PVJleY923dq+tV7CKEaEhztID/
        MiocoM//k5rnliTdzRF+tcOc6A==
X-Google-Smtp-Source: ABdhPJxS23ZY/oR++69n/GUSqD/WdhqZsU9FJuXrv3/R0FDgg47LZqI01j7hov7oRbzRm9RFiKBsdQ==
X-Received: by 2002:ac8:4807:: with SMTP id g7mr6232385qtq.54.1601425361941;
        Tue, 29 Sep 2020 17:22:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id e24sm85399qka.76.2020.09.29.17.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 17:22:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kNPtI-003kie-Kk; Tue, 29 Sep 2020 21:22:40 -0300
Date:   Tue, 29 Sep 2020 21:22:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces
Message-ID: <20200930002240.GA9916@ziepe.ca>
References: <20200928202631.52020-1-kamalheib1@gmail.com>
 <20200928223602.GS9916@ziepe.ca>
 <20200929060438.GA73375@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929060438.GA73375@kheib-workstation>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 09:04:38AM +0300, Kamal Heib wrote:
> On Mon, Sep 28, 2020 at 07:36:02PM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 28, 2020 at 11:26:31PM +0300, Kamal Heib wrote:
> > > Before this patch, the rtnl_link_ops are set only for ipoib network
> > > devices that are created via the rtnl_link_ops->newlink() callback, this
> > > patch fixes that by setting the rtnl_link_ops for all ipoib network
> > > devices. Also, implement the dellink() callback to block users from
> > > trying to remove the base ipoib network device while allowing it only
> > > for child interfaces.
> > 
> > Why?
> >
> 
> This is needed to avoid the inconsistent user experience for PKeys that
> is created via netlink VS PKeys that is created via sysfs and the based
> ipoib interface, as you can see below the ipoib attributes are reported
> only for PKeys that is created via netlink in the 'ip -d link show'
> output:

Summarize this in the commit message please

Jason
