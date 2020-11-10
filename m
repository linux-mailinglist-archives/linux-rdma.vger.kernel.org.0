Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEA32AD7DD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Nov 2020 14:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbgKJNlZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Nov 2020 08:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbgKJNlZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Nov 2020 08:41:25 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A0C0613CF
        for <linux-rdma@vger.kernel.org>; Tue, 10 Nov 2020 05:41:25 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id q7so2025929qvt.12
        for <linux-rdma@vger.kernel.org>; Tue, 10 Nov 2020 05:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SMCHyYQ6JN9Tw0XiHQc2rDlJH0TI4VqmvKvthC2CIQo=;
        b=OCcwk+EfYsFc0zbPWbQlZCdovJ5r7vn1vHdvzvoL/UWKmlYslSF9eAmLtPTmnAUBQO
         Qf2usvs7bXO0BJvObaGGcjlH9a7PJzvQCxHzY7/E4AVAw9HV8yNBFM1UmPAFJakZH0FM
         TH6CV5NYH9Gt80G7DsbbpwROkL+hBYsxNPVT8bfiRw765UligGYKBNZCHBPptQssAnBR
         KJpx6mxFIMFtclsMYzJe+M3fq+2g8mOGuX+blJzKFfTdz8qvubfR9EsMIkXG4woDyIvn
         tw/m1xTI0lAET+5mrrpl78782S69qP0knd/pQDtyzERkFK5pLhhBIP6vdbJl/L6x6WdP
         92MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMCHyYQ6JN9Tw0XiHQc2rDlJH0TI4VqmvKvthC2CIQo=;
        b=hcOq3b59fxhH2PwKepATN3vb+mEJJdo1XGVMfiPZqr6N/BQp6T5s4S24gXfxW7OI61
         ooy25zWuy/8HXo5wYVjIMYlLJF8Gt4e1tRxCSeiVcJIyaQ0kvWZ/8SEtzbwHoz/8COG+
         bv8YvWado8Wg0vsehX+45Lnbf6SLjsBx4yXbK6I7rUWQu1UQbFaLWAXGUmYW2QZVrVKx
         3uvMJXre4s9kmiTywk7ECAhFn7bBL9Ha+ks5SN39t4AV75+a2myhBl+o5LVUlmPtitfC
         pwVdWjFrT3GB+BF3vuPybLGtHKYqjQ056yMudR7o0js2qeV9wBYbHKx/zh+vpG93Fbnt
         z2Vw==
X-Gm-Message-State: AOAM533xnrKVg5VoypXEqpn3LoR2zOaF37cbuw23aj3JCsHYOiwMa/z2
        ty7m4nxl8ZMnBy+cnT344KuGfg==
X-Google-Smtp-Source: ABdhPJyaqyWhKjcmKRSgzo9QlgovWPTAP/Cc1vROwqTLo9mTPpzC7s+L4Vb9sR+VQ2BfGpFgHxDOwA==
X-Received: by 2002:a0c:a5a2:: with SMTP id z31mr20236933qvz.15.1605015684496;
        Tue, 10 Nov 2020 05:41:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id e18sm8018950qtc.39.2020.11.10.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 05:41:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kcTti-002Q93-Uy; Tue, 10 Nov 2020 09:41:22 -0400
Date:   Tue, 10 Nov 2020 09:41:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device
 information dump
Message-ID: <20201110134122.GL244516@ziepe.ca>
References: <20201103135719.GK5429@unreal>
 <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
 <20201103142243.GM36674@ziepe.ca>
 <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
 <20201105200005.GJ36674@ziepe.ca>
 <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
 <20201108234935.GC244516@ziepe.ca>
 <7a9866b6-fa33-0b95-4bda-4c83112be369@amazon.com>
 <20201109175700.GF244516@ziepe.ca>
 <6c77ad03-db3b-a1f8-cd28-a744585ba26d@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c77ad03-db3b-a1f8-cd28-a744585ba26d@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 10, 2020 at 09:49:11AM +0200, Gal Pressman wrote:
> On 09/11/2020 19:57, Jason Gunthorpe wrote:
> > On Mon, Nov 09, 2020 at 11:03:47AM +0200, Gal Pressman wrote:
> > 
> >>> The thing is, is is still useless. You have to consult sysfs to
> >>> understand what bus it is scoped on to do anything further with
> >>> it. Can't just assume it is PCI.
> >>
> >> This can be solved with Parav's suggestion.
> > 
> > Now you are adding more stuff.
> > 
> > What is wrong with reading sysfs? sysfs is where topology information
> > lives, why do we need to denormalize things?
> 
> And yet you have lspci so you don't have to dig through the sysfs files by hand
> for that topology.
> Please drop this patch.

If you want to add something to rdma tool it can read sysfs and disply it

Jason
