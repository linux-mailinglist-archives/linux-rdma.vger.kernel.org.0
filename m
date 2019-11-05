Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 448B8F001B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 15:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfKEOoF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 09:44:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:34178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfKEOoF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 09:44:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80C58AF3E;
        Tue,  5 Nov 2019 14:44:03 +0000 (UTC)
Subject: Re: [PATCH v2 08/15] xen/gntdev: Use select for DMA_SHARED_BUFFER
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-9-jgg@ziepe.ca> <20191101182611.GA31478@ziepe.ca>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <66b50cf6-89ac-81c8-e29a-b34f7f38633e@suse.com>
Date:   Tue, 5 Nov 2019 15:44:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191101182611.GA31478@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 01.11.19 19:26, Jason Gunthorpe wrote:
> On Mon, Oct 28, 2019 at 05:10:25PM -0300, Jason Gunthorpe wrote:
>> From: Jason Gunthorpe <jgg@mellanox.com>
>>
>> DMA_SHARED_BUFFER can not be enabled by the user (it represents a library
>> set in the kernel). The kconfig convention is to use select for such
>> symbols so they are turned on implicitly when the user enables a kconfig
>> that needs them.
>>
>> Otherwise the XEN_GNTDEV_DMABUF kconfig is overly difficult to enable.
>>
>> Fixes: 932d6562179e ("xen/gntdev: Add initial support for dma-buf UAPI")
>> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: xen-devel@lists.xenproject.org
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Reviewed-by: Juergen Gross <jgross@suse.com>
>> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>> ---
>>   drivers/xen/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Juergen/Oleksandr/Xen Maintainers:
> 
> Would you take this patch through a xen related tree? The only reason
> I had in this series is to make it easier to compile-test the gntdev
> changes.

Yes, I can take it for 5.5.


Juergen
