Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1122837A9
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 16:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgJEOZ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 10:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgJEOZ4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Oct 2020 10:25:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AD6C0613CE
        for <linux-rdma@vger.kernel.org>; Mon,  5 Oct 2020 07:25:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d20so12091482qka.5
        for <linux-rdma@vger.kernel.org>; Mon, 05 Oct 2020 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Am9bINX9DgiYOqVX2mbmATJhOuip87QrRNQB+uDBQQk=;
        b=Yuxx8RPwPDz+OJTvPyO3MrNED7QCwAZv9rEKUiGRRbj/Z4cW6bU4I1ETG/+xbYgxlF
         vi3LpdtE/kRpliifxrUGmla5wVWNf0TCkWEi4OK4pQQevbNZFfvRpJzbGil7S2wN+/kJ
         B+DmH2ptudUuqrc7yoBAY8BATexLY6pL9gQMIaxOfwGxBQDJ8eM5NU06xbeA/6iGCkFu
         FdwKw8dUdBro8vFiz8oN4h+IuKNRnY/8sJ3OruItuxO2Gl54o+akKNKABo3+rwd/j6qy
         fWK5VWJ4We3tpMGnRspSzU4Rafhw2wYDIUO2fZbxnOPrczBmTVgllFOfpyssS6zeA3g5
         SEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Am9bINX9DgiYOqVX2mbmATJhOuip87QrRNQB+uDBQQk=;
        b=Y8RB0noVaNDFm97qZZK/guVAku1WX6AiUl7H3ymiRSczP1ppzKlqCgDpvq9odHDC9Z
         VmljMt6hWO2Kaq2K01Rba5s12wYT0vH4z1yn11VixjIeb4vcuQCxxEN6pJ6HUl4Fr5nt
         cS4ruDLYMzM1F+bpt1WUPS6FnTTFu/gfb5y53whCt/z/2utTTwqy7SXXM8Mrslqb9SaO
         cCTHkZDPzbCbiq5s4vhgVAimj/sQPL2NcXt1462VO0pzWZMQp7a7DMPyadQul/LVE+tC
         /zvLyVOSFBlmcunE162sIwfg0erRn4MVHdqVeVOhI1Nph+krYnADNfi410Y30iZ/+Gws
         DBhQ==
X-Gm-Message-State: AOAM532b/tH7r0jzmeq8iMkgWWnzFGAk1gZXqLWiXrN/aJdWutTi/yxM
        YlXbtQOabB6vmyjRLVwV9T5yuw==
X-Google-Smtp-Source: ABdhPJzXZVeBHBzIGJEot6DXZc1KL53bxLd2Fh5oXGgaw1MbD703HNa4IOcawvgbVKV0hMXYa+JYlg==
X-Received: by 2002:a37:624c:: with SMTP id w73mr166659qkb.185.1601907955391;
        Mon, 05 Oct 2020 07:25:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d12sm348183qtb.9.2020.10.05.07.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:25:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kPRR4-007eYq-7Q; Mon, 05 Oct 2020 11:25:54 -0300
Date:   Mon, 5 Oct 2020 11:25:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201005142554.GS9916@ziepe.ca>
References: <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
 <20200907102225.GA421756@unreal>
 <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
 <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
 <20200929174037.GW9916@ziepe.ca>
 <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
 <20201002140445.GJ9916@ziepe.ca>
 <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
 <20201005131611.GR9916@ziepe.ca>
 <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 05, 2020 at 09:57:47PM +0800, Ka-Cheong Poon wrote:
> > > It is a kernel module.  Which FD are you referring to?  It is
> > > unclear why a kernel module must associate itself with a user
> > > space FD.  Is there a particular reason that rdma_create_id()
> > > needs to behave differently than sock_create_kern() in this
> > > regard?
> > 
> > Somehow the kernel module has to be commanded to use this namespace,
> > and generally I expect that command to be connected to FD.
> 
> 
> It is an unnecessary restriction on what a kernel module
> can do.  Is it a problem if a kernel module initiates its
> own RDMA connection for doing various stuff in a namespace?

Yes, someone has to apply policy to authorize this. Kernel modules
randomly running around using security objects is not OK.

Kernel modules should not be doing networking unless commanded to by
userspace.

> Any kernel module can initiate a TCP connection to do various
> stuff without worrying about namespace deletion problem.  It
> does not cause a problem AFAICT.  If the module needs to make
> sure that the namespace does not go away, it can add its own
> reference.  Is there a particular reason that RDMA subsystem
> needs to behave differently?

We don't have those kinds of ULPs.

> For scalability and namespace separation reasons as cma_wq is
> single threaded.  For example, there can be many work to be done
> in one namespace.  But this should not have an adverse effect on
> other namespaces (as long as there are resources available).

This is a design issue of the cma_wq, it can be reworked to not need
single threaded, nothing to do with namespaces

Jason
