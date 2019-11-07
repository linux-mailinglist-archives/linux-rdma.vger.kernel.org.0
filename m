Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F707F3996
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 21:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKGUgd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 15:36:33 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43770 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKGUgd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Nov 2019 15:36:33 -0500
Received: by mail-qt1-f195.google.com with SMTP id l24so3840121qtp.10
        for <linux-rdma@vger.kernel.org>; Thu, 07 Nov 2019 12:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=71LM+xH1wkNpW127vr6ZxQkFrR5SvDtsBzUQHq660ZY=;
        b=D3bFpO22vYKzoP0y0kJzENmUIyEWWuBeZdrbWOd1NSHyV6jshwYAek9v0UQlPVNFPm
         gMM8Mo2Kxc8gRUHzzjxaadcVCTPEcRYvCbAIX8OusFUjw7o9YpFUkiK3RoQQUeow2ms9
         eGazhDIo9mJpashFsikQQIbjd6TISyD1pZmFKifpX4Zhcl//XXhGcH3+Zo5Kzt51FlB3
         w1yAflYz0ICBGX3upadZlsBXvu1aRMmxOCzSLHPZYss2G0V4O2B7ESmEO3vtegVYkAKW
         tSKEpqMzverpHSnG3I+axEeI7kQum6AfY8LA3KuUKxqL3srA0wFn9Z1ou/8PeWVKM40a
         a1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=71LM+xH1wkNpW127vr6ZxQkFrR5SvDtsBzUQHq660ZY=;
        b=DVkUp39/kx6nRGinwrsp9SZ/1TV5S+UaUjz0MbWZHxKT3SISDnvSJztmTOrJmfbYch
         PL5fwHWNHO1EyLPST+pLjNfWY0MpshNSUUmM/RoOqcanlFnXc45QAmCDpH/HDLHF48c9
         7+5LplcWdoe56Yx1mCLLKX4wr01SRAd757CsjPg4bhqNFplidn5ZOtx8beSd+sw1DuVa
         CkaaeBgyKxrn52DLJmgk6xpKYAUUuGnaL+qe3Ina5LfJe55E7jKPQIh/A1G7LvtTzPy6
         +nKM/reKhDBxamek4hx6c2jzeerd5C8GegMIinDMekL8sQoto7g1UNDRsamr1lNykhiS
         8ZHw==
X-Gm-Message-State: APjAAAXK+FY/VNFCkUU3Tz9aS5pgw9hUVUwLXhhz3rK92S+HOvbaBtdq
        mhP8+FwRDOPxIDHruLh4MZlllQ==
X-Google-Smtp-Source: APXvYqyNBsBryLeEi7SIRoAPqzH4cK3zfUarxZiwLJPOIp00fgPi4tyHDHRm5q/vs9/sR4SDhwZ/Hw==
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr6108730qtp.7.1573158991013;
        Thu, 07 Nov 2019 12:36:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q17sm2194836qtq.58.2019.11.07.12.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 12:36:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSoW5-0000Io-Qj; Thu, 07 Nov 2019 16:36:29 -0400
Date:   Thu, 7 Nov 2019 16:36:29 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 09/15] xen/gntdev: use mmu_range_notifier_insert
Message-ID: <20191107203629.GF6730@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
 <3938b588-c6c5-3bd1-8ea9-47e4d5b2045c@oracle.com>
 <20191105023108.GN22766@mellanox.com>
 <a62e58f6-d98b-1feb-d0ca-fb8210f3e831@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a62e58f6-d98b-1feb-d0ca-fb8210f3e831@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 05, 2019 at 10:16:46AM -0500, Boris Ostrovsky wrote:

> > So, I suppose it can be relaxed to a null test and a WARN_ON that it
> > hasn't changed?
> 
> You mean
> 
> if (use_ptemod) {
>         WARN_ON(map->vma != vma);
>         ...
> 
> 
> Yes, that sounds good.

I amended my copy of the patch with the above, has this rework shown
signs of working?

@@ -436,7 +436,8 @@ static void gntdev_vma_close(struct vm_area_struct *vma)
        struct gntdev_priv *priv = file->private_data;
 
        pr_debug("gntdev_vma_close %p\n", vma);
-       if (use_ptemod && map->vma == vma) {
+       if (use_ptemod) {
+               WARN_ON(map->vma != vma);
                mmu_range_notifier_remove(&map->notifier);
                map->vma = NULL;
        }

Jason
