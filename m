Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA249BF9DA
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 21:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfIZTKG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Sep 2019 15:10:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42980 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbfIZTKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Sep 2019 15:10:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id f16so2722213qkl.9
        for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2019 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kPm13+hfVfTMqFNlaF96i+4PFmnUDofHIMpVFc9T2xA=;
        b=m8S6eW1VF5xyRoXEp7k15UhvuOKx6cMY3WweVku/Ofvwn4XWjTp4e3cfsFnbWOSvhI
         nAR34fZyc2UqIBbNOU4kNGWHLZkrSQfxSPvGa3n9gVWEh6xqbq3/zhyPI4wJNaSkZEgy
         3wWyUaM0vPS/Em+zlgPrT1Nbt3DUM58p4gHesOMHNUaveO9HirvSf/jxuIBAwT7tyNVG
         K4t4ttLgcfcoGmMroYYOQzff1Gq8W+rmn8sF1vXBCfhfFGDUr//U0LEXVdi0Crt+iDgM
         uKNKLMxhU3qStiiJbXiHfZqIXkBxcl+J+jK0Q54662jsaROm03AqjPmi+N0747JQOH4G
         dtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kPm13+hfVfTMqFNlaF96i+4PFmnUDofHIMpVFc9T2xA=;
        b=dXSL5L4EIMJkB0hkczH+M6/33oZ2gD7lVZuI6jxz1wYRpAb7tyU3BA8CtDCC2jWH40
         FDqEUFKvTj2KjUuKYT76CcfNzHQ0jIiVEzjHnmatTzn4u9a2kLGPfOI7Nx8C+bGRBAjs
         7hQ8prCqLlFXeqk1YuBduKx0agArVkMveIuewOFhZCbJgsEWxLQWy84P9N8li+Hxdxd0
         D1IpOLGT/8zjPPBZidboYcXNQLlqZ1blhlXztsWe8HV1QQyacPqyd+OZGebw1+X9wjV9
         jBzygsgWN08ukWX2eMbuxrp7dhoJ4rCU7J2BK8knhuApkmNDfMuCFrmvUa9i+m1Lo4Vo
         Lwzw==
X-Gm-Message-State: APjAAAU4pIpBjm961YKIOpWGCpG+y9hiP9/3v4SuwVhJomO9GxRnsQkQ
        W3DAkQm8hzVk05V1C74Q/ncgNw==
X-Google-Smtp-Source: APXvYqyg+K9iZ/IoQn7iCWaXs5g6tuhrzXPGbUeGmHbdglGNwsZnM4Og4RKvCA2ueURi7QXlMKPmJQ==
X-Received: by 2002:a37:b07:: with SMTP id 7mr441858qkl.386.1569525003941;
        Thu, 26 Sep 2019 12:10:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id s16sm57686qkg.40.2019.09.26.12.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Sep 2019 12:10:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iDZ9O-0006jT-Kk; Thu, 26 Sep 2019 16:10:02 -0300
Date:   Thu, 26 Sep 2019 16:10:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell
 overflow recovery support
Message-ID: <20190926191002.GB626@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-7-michal.kalderon@marvell.com>
 <20190919180224.GE4132@ziepe.ca>
 <a0e19fb2-cd5c-4394-16d6-75ac856340b4@amazon.com>
 <20190920133817.GB7095@ziepe.ca>
 <MN2PR18MB3182FEF24664E620E357B83AA1870@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190925192101.GA626@ziepe.ca>
 <MN2PR18MB3182090D42CE1A01CF8C9D18A1870@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182090D42CE1A01CF8C9D18A1870@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 25, 2019 at 07:37:38PM +0000, Michal Kalderon wrote:

> > I suppose I was expecting that the when the object was no longer to be
> > shown to userspace the mmap_xa's were somehow neutralized too so new
> > mmaps cannot be established.

> Adding/removing entries is dynamic and done on qp / cq creation and
> destruction, Could be done all the time. To neutralize them is only
> to add some interface that Make sure the entry is deleted like wait
> for the event that refcnt reaches zero before freeing the memory, Or
> leave it as it is now and only free the memory in the mmap_free.

nothing needs to wait, it just needs to make sure future mmap to that
offset will not succeed

Jason
