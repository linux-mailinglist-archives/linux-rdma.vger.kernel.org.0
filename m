Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39481C4539
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 02:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfJBA5x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 20:57:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36126 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfJBA5x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 20:57:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so13268584qkc.3
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 17:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cd1nfIpT06rTGEEhuINkW6l/u4jXauotdcGRlyCl7yk=;
        b=V7mHnyLelycxvUtm5aap1PILKem0nOg2Jcmiov8R2GX09+n5Ao8jEzFp1Uv0W9QNBa
         21tfEYFwtNvmY/XOR6tIR7CwpVjPmL58/JVuYf/QfSqi4ymgX7g/KHMKpSqAlLHwO+Pf
         c9bm5m8m0uCDdPcNXWuFx6v1nDbA4WTfH0dNWoYWKElIKlDJFHJKWMDFidtpU51JkaxB
         cXFIANLnoZSVR/vBOAUVEYiMmlm4csKExzGDApe80WIal1QxxnsFxkzu2YfDpLT8l4/T
         BUOXFl6crUL7Onei1WYYBoADJU+i3HFvER5HKL3qFQEtj8z6YaATdhkF2X6sq+9/lxNi
         y6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cd1nfIpT06rTGEEhuINkW6l/u4jXauotdcGRlyCl7yk=;
        b=AO4h86sxbJZMfCFuKqGNC3tU5xsdkePbbQ6QJFaDXAKZq+VlZbJj3Dstum77Y5OLA1
         9+3ewSEr0Srl19Ao5JnnfUPt9XEiOecxS9lHZv1KzT38Op9LjoQdNcq5D6UC7oEveL2Z
         lxuwmCOImIouiQc1EojdkCBQRBncl03HFecsF0SznPljFpJ6/8dCCjLNh7Nlax6405Qo
         4+6f3gqZC5yFJj8RW0Tg88w55NGJlVu2Pe6pFTAGmsIc4tu3l6BZNhV9njeuJZBVffag
         Ms0yUBIW/ivRyDXAiofben28CEKR+i8awxEKBfrcykHWNykzgHeQ2DgM1S5iLmblsrQT
         sYyA==
X-Gm-Message-State: APjAAAVXtPUiAIpGiZcldbkyGa8vsreCx3vlWjN8VwFCMAL30Biqb1Ck
        b13/GW/SnovB9eqL+QPQMlRvcUyhcEk=
X-Google-Smtp-Source: APXvYqziauVh6euHl7bNfldnSyjyMa0PH/Kg2Ds2GXO1xMDZsQDxnGbzGsNrKjr/3vaX0h+Wc33qAA==
X-Received: by 2002:a05:620a:6cf:: with SMTP id 15mr1167388qky.112.1569977871956;
        Tue, 01 Oct 2019 17:57:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h9sm9076239qke.12.2019.10.01.17.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 17:57:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFSxi-0001ad-SF; Tue, 01 Oct 2019 21:57:50 -0300
Date:   Tue, 1 Oct 2019 21:57:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rdma/core: add __module_get()/module_put() to
 cma_[de]ref_dev()
Message-ID: <20191002005750.GA19628@ziepe.ca>
References: <20190930090455.10772-1-metze@samba.org>
 <20190930124122.GA24612@ziepe.ca>
 <31690de0-eef6-378b-2703-6cd13eb61461@samba.org>
 <20191001144534.GC22532@ziepe.ca>
 <d52b5baa-a7f3-a5eb-77ab-1e0a15e54d60@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d52b5baa-a7f3-a5eb-77ab-1e0a15e54d60@samba.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 12:03:14AM +0200, Stefan Metzmacher wrote:
> >>> Globally blocking module unload would break the existing dis-associate
> >>> flows, and blocking until listeners are removed seems like all rdma
> >>> drivers will instantly become permanetly blocked when things like SRP
> >>> or IPoIB CM mode are running?
> >>
> >> So the design is to allow drivers to be unloaded while there are
> >> active connections?
> >>
> >> If so is this specific to RDMA drivers?
> > 
> > No, it is normal for networking, you can ip link set down and unload a
> > net driver even though there are sockets open that might traverse it
> 
> Ok.
> 
> >>> I think the proper thing is to fix rxe (and probably siw) to signal
> >>> the DEVICE_FATAL so the CMA listeners can cleanly disconnect
> >>
> >> I just found that drivers/nvme/host/rdma.c and
> >> drivers/nvme/target/rdma.c both use ib_register_client();
> >> in order to get notified that a device is going to be removed.
> >>
> >> Maybe I should also use ib_register_client()?
> > 
> > Oh, yes, all kernel clients must use register_client and related to
> > manage their connection to the RDMA stack otherwise they are probably
> > racy. The remove callback there is the same idea as the device_fatal
> > scheme is for userspace.
> 
> Ok, thanks! I'll take a look at it.
> 
> > How do you discover the RDMA device to use? Just call into CM and let
> > it sort it out? That actually seems reasonable, but then CM should
> > take care of the remove() to kill connections, I suppose it doesn't..
> 
> On the client:
> 
> rdma_create_id()
> rdma_resolve_addr()
> rdma_resolve_route()
> rdma_connect()
> 
> On the server:
> rdma_create_id()
> rdma_bind_addr()
> rdma_listen()
> rdma_accept()
> 
> I just pass in an ipv4 or ipv6 addresses.

Ah, the only working flow today is to destroy your IDs when a remove
comes, and CM IDs become linked to a single rdma device so you know
which IDs to tear down on destroy

Jason
