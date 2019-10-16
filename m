Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A69D87C5
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 07:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfJPFLJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 01:11:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:50402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732659AbfJPFLI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Oct 2019 01:11:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C1428B38A;
        Wed, 16 Oct 2019 05:11:06 +0000 (UTC)
Subject: Re: [PATCH hmm 08/15] xen/gntdev: Use select for DMA_SHARED_BUFFER
To:     Jason Gunthorpe <jgg@ziepe.ca>, Felix.Kuehling@amd.com,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-mm@kvack.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-rdma@vger.kernel.org
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-9-jgg@ziepe.ca>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <6f60f558-20db-1749-044d-a46697258c39@suse.com>
Date:   Wed, 16 Oct 2019 07:11:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191015181242.8343-9-jgg@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 15.10.19 20:12, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> DMA_SHARED_BUFFER can not be enabled by the user (it represents a library
> set in the kernel). The kconfig convention is to use select for such
> symbols so they are turned on implicitly when the user enables a kconfig
> that needs them.
> 
> Otherwise the XEN_GNTDEV_DMABUF kconfig is overly difficult to enable.
> 
> Fixes: 932d6562179e ("xen/gntdev: Add initial support for dma-buf UAPI")
> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
