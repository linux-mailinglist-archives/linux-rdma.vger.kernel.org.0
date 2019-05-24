Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81E729E19
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 20:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfEXSdZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 14:33:25 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35185 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbfEXSdZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 14:33:25 -0400
Received: by mail-vs1-f68.google.com with SMTP id q13so6495359vso.2
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T7oP6aiiwGSSJ1sv66niJcd7PA24SVMZ9uM8zYabpcw=;
        b=F/Jsq9Mp7qkohtxwkf8Tki9kIIGVnAegq0OjfsmHhwueqIcU/eC1NBMQPv44mPL/0j
         17P8RLkEoDYpV4bEwr2IgB1dLBWGfg7w4PMLwDGXpJCaFU2B6zsAtNCQ1Kce983b2cif
         tYFq7rxCyhW5bZgQcXkfieBP2Peh17cu3Ka9QtNysPEFUrCVkDpMOcTzbMqug61FfhcS
         mdvCTNL3tqexEq5cUPhKVEeW229/Kn5aF09HIpV2L04jPhbV8lAe2c7Z/eTaIql1LqBa
         tJGXAPj1PewiVVIx8UZETeK2FI7LYS2Hg0jqxHDCKjIDrR73REs9xrCaUnKQSd6mlsee
         fnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T7oP6aiiwGSSJ1sv66niJcd7PA24SVMZ9uM8zYabpcw=;
        b=awkRXibw7A/DFHk1GoQro2nLHIPoe009LqYYc01G2yMDp5E7Dhl+okC/s/d/n0r342
         0GrBv3Gcz+YD5n8C7BUY+AhbVuBqnROiWSCWxO4Db8dVqryyDNZ0u2QL1I457ELt6ISG
         hEr3UH0Cd3RChyd7ZAF9LrftaYhm0Od2uKmrVWWK3CGjxd0pGQREE9LJau+D9NFvco8P
         iejVthj9N4FK9yN7kTDQh9g86fjNOJm66cyUt1uBUYmDDab/dekXePn5ScvGxpoKh/Ul
         r8LOYUqPtuhyKqWk28afAhO7oHxlXAUflXWEkYvOpuT6zPExws+W+GWA0+tQoOQvYJdk
         m7EQ==
X-Gm-Message-State: APjAAAU3g8OacK9s+TDEHjAYhMXwBnqrKTVNd8L7aSTSnPUWWPHh+eH3
        C5h3AGIzQUwiMwG5Ggjc0kA7ww==
X-Google-Smtp-Source: APXvYqwc1q/Jw79h+DIQO8cCg97QMBpdu6Oi012i5nG+CMXC+bDLOoKiCbl3UWSrVv25fkPdR4t3Uw==
X-Received: by 2002:a67:fd93:: with SMTP id k19mr40032114vsq.45.1558722804212;
        Fri, 24 May 2019 11:33:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id c71sm1424296vke.19.2019.05.24.11.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 11:33:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hUF0N-0001KF-C8; Fri, 24 May 2019 15:33:23 -0300
Date:   Fri, 24 May 2019 15:33:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerd Rausch <gerd.rausch@oracle.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Aron Silverton <aron.silverton@oracle.com>,
        Sharon Liu <sharon.s.liu@oracle.com>,
        "ZUOYU.TAO" <zuoyu.tao@oracle.com>
Subject: Re: <infiniband/verbs.h> & ICC
Message-ID: <20190524183323.GJ16845@ziepe.ca>
References: <54a40ca4-707b-d7a8-16b0-7d475e64f957@oracle.com>
 <20190524013033.GA13582@mellanox.com>
 <e9d86a45-a3b0-e303-027b-02474ed3a2ac@oracle.com>
 <20190524150707.GC16845@ziepe.ca>
 <2b1565e9-b262-e31d-cfec-6ca1da189090@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b1565e9-b262-e31d-cfec-6ca1da189090@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 11:20:48AM -0700, Gerd Rausch wrote:
> Hi Jason,
> 
> On 24/05/2019 08.07, Jason Gunthorpe wrote:
> > On Thu, May 23, 2019 at 11:14:42PM -0700, Gerd Rausch wrote:
> > 
> >> I can't say that I'm thrilled with this behavior though,
> >> as it appears error-prone:
> >> As soon as an enum value goes out of range for an "int", the
> >> type silently changes, potentially rendering structures and functions silently incompatible.
> >> It's quite the pitfall (e.g. the foo.c vs bar.c case above).
> > 
> > Indeed, I would be very careful using this extension with
> > non-anonymous enums :)
> > 
> > However, an anonymous enum can never have storage allocated, so it
> > doesn't experience any ABI concern.
> > 
> 
> Sure it can:
> 
> % cat foo.c
> struct foo {
> 	enum { FOO = 1UL << 31 } foo;
> } foo = { FOO };

I meant top level anonymous enums :)

Jason
