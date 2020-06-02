Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8357B1EC30B
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 21:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgFBTuR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 15:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgFBTuR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jun 2020 15:50:17 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2646C08C5C0
        for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2020 12:50:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c185so13779933qke.7
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2020 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QvCsB0PVS7CynSuPm893zY4nLBK4JjrCQe68TzbJ2/w=;
        b=PNQJOo4NCvQo7Nl6vNISAlpyJuKBLwzvinHrY5qCznokm+V2Bdfq3hY4mJ1Mia/rQ2
         KcmGMX9YL6Lff1dhmhrLnAoFYhqQkTRG8Vm/biA8PbbPLIAkm9DJsj5k3Hi9948jOAst
         vzKdwhCt+yF/wB9sCwPwkrDVadMPEoQXq7bOoPiDoDdX+3xJLSbKpBBGZyVsAk2PZDMI
         3tu6DhKyWuP4VfEcSdiMx8AFJn5IDdbI/UO9tudIjxAxxI5T3nOqzoqr4bZtvwymf2w7
         zZYO5HTIQa3siO2RMF/A/IB8t9jUrlqT3k9KitUiHvaPxPyL8iVqV0VllPZ1dhZnuJx3
         Yp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QvCsB0PVS7CynSuPm893zY4nLBK4JjrCQe68TzbJ2/w=;
        b=PEZdxGHxE1Q4pdM6nHTnUT1ImS9eHlp4I1UyjOo1zobqHjWrN5u0HYeojwXM/ltVBo
         8vD8nOA4WsTh5ve/HJqhAset0+bgFeL6U1fKWQpXPrW50jTB2vT58mVHV8PeSEoGqFpR
         +nFn6+z56yb1n4upVDGzHK2X35lPf6ty/C2ceqaRZ+YaFOiG/B8s89gJ/+QCUgQvGZsv
         MZL0Bc/jTvKAo+kq4AuD7IA/fVcOTOpMS6Re7qYlQkPUMKJfArA9wsx8czszsP5F2FIW
         sxjvacypijiu+he7PfkG5mZyZ1+vkD+NApJPkeFxSieTJyM/YWWfmMbN+EwuDHZI6Dd1
         ddtw==
X-Gm-Message-State: AOAM532VywJ3cWQT+lj+qCMz3e7FvxRSu7CKts69eUWnPZkkpcU09PnF
        pNSN82KycuRc6XBc+jGwH9xMpQ==
X-Google-Smtp-Source: ABdhPJxyiK4yz0ganTNe8de/k3FggbOuNF3cPf3FjltocqFPic12xPMwzvJp62kzvddYBykTRylmQA==
X-Received: by 2002:a37:a7c3:: with SMTP id q186mr25606794qke.499.1591127416013;
        Tue, 02 Jun 2020 12:50:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 207sm3250120qki.134.2020.06.02.12.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 12:50:15 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgCvP-000Jad-3I; Tue, 02 Jun 2020 16:50:15 -0300
Date:   Tue, 2 Jun 2020 16:50:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Benjamin Drung <benjamin.drung@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Race condition between / wrong load order of ib_umad and ib_ipoib
Message-ID: <20200602195015.GD6578@ziepe.ca>
References: <6c58097c2310a57a987959660a8612467d8bd96c.camel@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c58097c2310a57a987959660a8612467d8bd96c.camel@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 02, 2020 at 05:11:31PM +0200, Benjamin Drung wrote:
> Hi,
> 
> after a kernel upgrade to version 4.19 (in-house built with Mellanox
> OFED drivers), some of our systems fail to bring up their IPoIB devices
> on boot. Different HCAs are affected (e.g. MT4099 and MT26428). We are
> using rdma-core on Debian and have IPoIB devices (like `ib0.dddd`)
> configured in `/etc/network/interfaces`. Big cluster seem to be more
> affected than smaller ones. In case of the failure, we see this kernel
> message:
> 
> ```
> ib0.dddd: P_Key 0xdddd is not found
> ```

I think this means you are missing some IPoIB bug fixes?

This warning means ipoib was started before the subnet manager had
programmed in the pkey table. (ie it is a race)

The way it is supposed to work is for IPoIB to create the interface
anyhow in the down state and wait for the SM to program the pkey, then
move to the up state.

> Pinging other hosts will fail then with:
> 
> ```
> ping: sendmsg: Network is unreachable
> ```

This suggests ipoib is stuck down, so it missed the pkey change
event..

> changing the order in this configuration file to load `ib_umad` before
> `ib_ipoib`, the servers come up correctly.

This is probably just adding enough delay that the SM has setup pkey
table before starting ipoib...

Jason 
