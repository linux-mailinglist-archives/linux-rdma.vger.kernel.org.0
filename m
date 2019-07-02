Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E244A5DAE5
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 03:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfGCBcU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 21:32:20 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17748 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfGCBcU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jul 2019 21:32:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1bba730000>; Tue, 02 Jul 2019 13:11:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Jul 2019 13:11:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Jul 2019 13:11:32 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Jul
 2019 20:11:28 +0000
Subject: Re: [RFC] mm/hmm: pass mmu_notifier_range to
 sync_cpu_device_pagetables
To:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20190608001452.7922-1-rcampbell@nvidia.com>
 <20190702195317.GT31718@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <b0252869-588f-0333-1878-1f90b8b0c17b@nvidia.com>
Date:   Tue, 2 Jul 2019 13:11:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190702195317.GT31718@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562098291; bh=pJF5x4345qO6YQIaFfIRkH4NCd5wxJwRshnLYN1SQEs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IUcePnf0Csnlm1B5f0YiScyxFBIq1oVLcXkX1R9Dzr/JAedpYocU+1YoARltFSzXL
         iLdan7eOA9VcM2WT0J99ARUqKv5co1QJpNjVJxlyi6VrWEaAa0ctcAejwHVY5FPzkK
         6qPdataKyAZrPuuUre4m/2Ync8rx0qmtlLizKB0GuEBNOc7D6cSYMtShRnxwP6YfbL
         3wiZCF40d0ZkSYRtNGF6wQbfuTiye4gz/az2kzjXcRQxdB6y8stFF9aKIkrjk41ZR6
         r8/YZuQpFxYBeyEUBl5MVMoyTkBxn2IdZdr2j6jfNvfE62puz7tcnkRFcL9kLfVfv5
         5CgD7awfl1YKw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 7/2/19 12:53 PM, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2019 at 05:14:52PM -0700, Ralph Campbell wrote:
>> HMM defines its own struct hmm_update which is passed to the
>> sync_cpu_device_pagetables() callback function. This is
>> sufficient when the only action is to invalidate. However,
>> a device may want to know the reason for the invalidation and
>> be able to see the new permissions on a range, update device access
>> rights or range statistics. Since sync_cpu_device_pagetables()
>> can be called from try_to_unmap(), the mmap_sem may not be held
>> and find_vma() is not safe to be called.
>> Pass the struct mmu_notifier_range to sync_cpu_device_pagetables()
>> to allow the full invalidation information to be used.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> ---
>>
>> I'm sending this out now since we are updating many of the HMM APIs
>> and I think it will be useful.
> 
> This make so much sense, I'd like to apply this in hmm.git, is there
> any objection?
> 
> Jason
> 
Not from me. :-)

Thanks!
