Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D44E87EF
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfJ2MT0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 08:19:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:5935 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733257AbfJ2MTZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 08:19:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 05:19:24 -0700
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="203547917"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.206.224]) ([10.254.206.224])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 29 Oct 2019 05:19:21 -0700
Subject: Re: [PATCH v2 06/15] RDMA/hfi1: Use mmu_range_notifier_inset for
 user_exp_rcv
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
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-7-jgg@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <a8644875-9133-9667-c04b-b40c296d68eb@intel.com>
Date:   Tue, 29 Oct 2019 08:19:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028201032.6352-7-jgg@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/28/2019 4:10 PM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This converts one of the two users of mmu_notifiers to use the new API.
> The conversion is fairly straightforward, however the existing use of
> notifiers here seems to be racey.
> 
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

I tested v1, and replied to it [1]. I can re-test with this version if 
you like as well.

[1] https://marc.info/?l=linux-rdma&m=157235130606412&w=2

-Denny
