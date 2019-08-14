Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4068E02F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 23:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHNVxq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 17:53:46 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11271 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfHNVxq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Aug 2019 17:53:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5482f40000>; Wed, 14 Aug 2019 14:53:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 14 Aug 2019 14:53:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 14 Aug 2019 14:53:45 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Aug
 2019 21:53:42 +0000
Subject: Re: [PATCH v3 hmm 11/11] mm/mmu_notifiers: remove
 unregister_no_release
To:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-mm@kvack.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <intel-gfx@lists.freedesktop.org>,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190806231548.25242-1-jgg@ziepe.ca>
 <20190806231548.25242-12-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <84b35625-9877-0f35-155a-2d5ee1af4108@nvidia.com>
Date:   Wed, 14 Aug 2019 14:53:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806231548.25242-12-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565819636; bh=jn8qPKX3vGj+tzC7jfWRezHMQaQX7LZbuyruFud4LQQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DuHQyhEkn2nVu3F9JE1Jqs394XgDiOloB/DupeDvogYw6EVbMONwcehm4ND30nlJe
         coLB6ipCN1oIyc4w1mqCCYewK+PC5YV9u55ueYp2oaHr/1plVEnMB9PP5+CTSD2S+f
         /EwXD2xqdd7b1DugwUAbPGKM94w9rldbIHus7fAOpSWXDg6bOvnb9bZD9px5zT4R9w
         fNKaAnXFzpPWTG2T38iLy/xRORGPkKKaDbUB4Y5JUU/eQRUnl/o4i6ggHqZCwIPAQU
         XR1OQDE52UPDPt8SmWG+WQaZO6Cc6+YdybR1YFmKROUzj521DapTNnEGLy+4532Itg
         +dCm77lSoXV4A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/6/19 4:15 PM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> mmu_notifier_unregister_no_release() and mmu_notifier_call_srcu() no
> longer have any users, they have all been converted to use
> mmu_notifier_put().
> 
> So delete this difficult to use interface.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
