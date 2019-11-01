Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D386EEC943
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 20:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKATyJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 15:54:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38826 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfKATyJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Nov 2019 15:54:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id t26so14461325qtr.5
        for <linux-rdma@vger.kernel.org>; Fri, 01 Nov 2019 12:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z+FjZERGJpTwj4Fyw0MaJE9Sqa2BYsQ42uoE0CYrL0A=;
        b=YeDYRdeeYeznofBfYHEGTgJUYYibnJM0tHbeYYbzhUa89eqWcwDFuoBvkqzuDcLc2T
         ofUfxex6y2BB77lEIINYfCe3LRDUm2ccatiS5G5es+IEQBkayJMlTpCysQ5WVX1USGCS
         jgTaU5H2sKmYyCCp5OAsj9y1/GibOpmNaDDE7+kpDMj1ch/KbEMGdmr4C8OACqF5MRIR
         AUJyBIqsDG9vpkYNm8vhMLDcsm1loVPhr52oeBb6m4QlAeB/pAlZ5GeOmXDE0INv1FyD
         pucRz+47DC7NbtxxhTdRuHewQn65NgI1RX8osOjLNPQ54S6sL1WB7AFJyClzypTR7d0s
         bh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z+FjZERGJpTwj4Fyw0MaJE9Sqa2BYsQ42uoE0CYrL0A=;
        b=JC+Ob7Pvb3GTLlNSlD130Imjyie8yqBMdvDOV1lloAecq1RZ/hvJJqa751MDAA1XXI
         mFKe3DKBpn1FAQzr+jicSveBjuhPXCM4v5CJrd1vsl33jDhm/aQ+o/3FYotpRt9pysFu
         Eg2s0TbcDW5PxwNyv1+0dlOVR0LKxzyHY1J77LAzzQuEf1ulKUUJZPoLRkqqop/HVCRr
         GM03//OzqHP8kYDPPb7f/2LbhuvKGpABoKrOvLPRJ4Mdm2Q4M5EOKqm6IUanJwslOhpd
         jg0HAONXB8rVno8JSq6xRwqtao7O60US4Sw2FB4HbaiWjFh2+LxwVmfZxq3sSNd+3TCz
         Vpdg==
X-Gm-Message-State: APjAAAVhYQouj72qmX018h57G9yOKYitBCYowYRJmExTDlc2wyRL+XtA
        8lzXqVQflCc/+Bi2UnvSWAUxvA==
X-Google-Smtp-Source: APXvYqwugaF2JaYgADF6rOYRryDEd9+U+cO7L5fZ9F8hMoRL3wZJoN0ghN8hXeUNkkXowjkn9kbsRA==
X-Received: by 2002:a0c:fdcc:: with SMTP id g12mr11930964qvs.104.1572638047703;
        Fri, 01 Nov 2019 12:54:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id a18sm4727748qkc.2.2019.11.01.12.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 12:54:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iQczm-00025n-Ng; Fri, 01 Nov 2019 16:54:06 -0300
Date:   Fri, 1 Nov 2019 16:54:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 00/15] Consolidate the mmu notifier interval_tree and
 locking
Message-ID: <20191101195406.GA6732@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 05:10:17PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> 8 of the mmu_notifier using drivers (i915_gem, radeon_mn, umem_odp, hfi1,
> scif_dma, vhost, gntdev, hmm) drivers are using a common pattern where
> they only use invalidate_range_start/end and immediately check the
> invalidating range against some driver data structure to tell if the
> driver is interested. Half of them use an interval_tree, the others are
> simple linear search lists.

Now that we have the most of the driver changes tested and reviewed
I'm going to move this series into linux-next via the hmm tree, minus
the xen gntdev patches as they are not working yet.

I will keep collecting acks and any additional changes.

Thanks,
Jason
