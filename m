Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D176CDD091
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 22:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfJRUrv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 16:47:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33158 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfJRUrv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Oct 2019 16:47:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id 71so2712420qkl.0
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ajp9s1qaNwz6bmaiY8C/7SU7SsSlLhlRpFO3uAx1pvQ=;
        b=Icr8JXO1Md/73c4Uc4OT7EyJ2kfieESwGNvpfGRYl4MTrcRl77yFDrQg4l6oZ2epYt
         D3fHGwDk5DgsKidnD1ylOSERVNK3l7fUFvxyFlqHg0oNx0MG3qE/d0ajGWsc0LkVLDo7
         fZw/ktp8jlLLoFvd4IcWoF6uYrUuCI3it/9kPBzJ6xZOtvos5gXDfuWq7bzllGnkY4t3
         ik6P1Te3rnAeogJch9WJrQF/mArGNGTIPlKFT2mpY6KYJc55qm28+JaHu/dZ/zkmg68Z
         OOrsvy/98sOGUaqv/Gda4F9rQZnQVf1XItNhZGntG7jqUTYNuvd3MIWQbVyJMv+stuwe
         lokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ajp9s1qaNwz6bmaiY8C/7SU7SsSlLhlRpFO3uAx1pvQ=;
        b=kxm7Da0y/i5U8t8nZeRo5csgt/ahTIuQxglk85vgbenldxKFgh6X0KPZDvmYhdYhNx
         6EPYL/mnp7cOG8kTiXBcH0IA52ndvKSH4pRERV/AqeGZv3TBH0aqfJFA2Jym5TC0YeKD
         gqJi2dDl0im1Fkxe7kw2OSLL3ilQH11kGshPHgIR00VNvEZ/ypZ1FV12W7ea0fOJGd4q
         TJkHja6lPZmXqnocKypg1N7SE9S5QxWnUQ4qlFlH4eiKBxpYRiRXXz1xQuMYvCz97oFv
         eQLO/IXiu3BO4u1SxsohKFz/+7IvixI/vGXwUx7S1uQdJKK1IChYU9SRkPEQ/MhZ7aTH
         aoMg==
X-Gm-Message-State: APjAAAUYbJG9cCyBQC1a/EyvobpoCiNSHcBWDnHU8lBhx/qE0NLQaBZP
        NnTWV9JMaNsuqxUcwISNHOAvpw==
X-Google-Smtp-Source: APXvYqxzYH68MxxJK4idc/6YfzmNnjDCM4KcPMYiWvvs3lLghlt0FOjtSRD57NRW8cUaInZaNrYDYQ==
X-Received: by 2002:a05:620a:530:: with SMTP id h16mr11189367qkh.396.1571431668544;
        Fri, 18 Oct 2019 13:47:48 -0700 (PDT)
Received: from ziepe.ca (ip-66-51-117-131.syban.net. [66.51.117.131])
        by smtp.gmail.com with ESMTPSA id w2sm4746556qtc.59.2019.10.18.13.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 13:47:48 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iLZA3-0001bi-46; Fri, 18 Oct 2019 17:47:47 -0300
Date:   Fri, 18 Oct 2019 17:47:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Adit Ranadive <aditr@vmware.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>
Subject: Re: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
Message-ID: <20191018204747.GB6087@ziepe.ca>
References: <20190930074252.20133-1-bharat@chelsio.com>
 <20191004181154.GA20868@ziepe.ca>
 <D4D8B4CD-CDA7-4587-BA10-E41A2DE89978@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4D8B4CD-CDA7-4587-BA10-E41A2DE89978@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 17, 2019 at 06:41:16AM +0000, Adit Ranadive wrote:
> On 10/4/19, 11:12 AM, "Jason Gunthorpe" <jgg@ziepe.ca> wrote:
> > 
> > On Mon, Sep 30, 2019 at 01:12:52PM +0530, Potnuri Bharat Teja wrote:
> > > remove iw_cxgb3 module from kernel as the corresponding HW Chelsio T3 has
> > > reached EOL.
> > > 
> > > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > 
> > Applied to for-next
> > 
> > Please also send a PR to delete cxgb3 from rdma-core
> > 
> 
> Is Chelsio going to send a PR for the deletion? It looks like otherwise
> rdma-core is broken for other providers when running with the for-next branch.
> 
> Also, it looks like the kernel-headers/update script in rdma-core needs to be
> updated to remove a header if required from the rdma_kernel_provider_abi
> section. Or is that expected to be manual?

Manual is probably fine, this doesn't happen often

And the bug introduced in this patch is just a bug that should be
fixed in the kernel now

Jason
