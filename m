Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA443A3E87
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 11:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhFKJFt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 11 Jun 2021 05:05:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3845 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhFKJFt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 05:05:49 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G1ZWz2mJqzWnVD;
        Fri, 11 Jun 2021 16:58:55 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:03:49 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:03:48 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Fri, 11 Jun 2021 17:03:48 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liuyixing (A)" <liuyixing1@huawei.com>
Subject: Re: [PATCH v2 for-next 2/2] RDMA/hns: Support direct WQE of userspace
Thread-Topic: [PATCH v2 for-next 2/2] RDMA/hns: Support direct WQE of
 userspace
Thread-Index: AQHXWEtQg8DRntyV4Uu+yrDnRFqx9A==
Date:   Fri, 11 Jun 2021 09:03:48 +0000
Message-ID: <b54cd6c9af3e424383d7737252e38105@huawei.com>
References: <1622705834-19353-1-git-send-email-liweihang@huawei.com>
 <1622705834-19353-3-git-send-email-liweihang@huawei.com>
 <20210603191226.GD1002214@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/6/4 3:12, Jason Gunthorpe wrote:
> On Thu, Jun 03, 2021 at 03:37:14PM +0800, Weihang Li wrote:
> 
>> +	hr_qp->has_mmaped = true;
>> +	pfn = context->uar.dwqe_page + pgoff;
>> +	prot = pgprot_device(vma->vm_page_prot);
> 
> Why doesn't this use pgprot_writecombine() ? Does the devce really need
> nGnRE not GRE?
> 
> Jason
> 

We use ST4 instructions to write 64 Bytes at a time, these instructions can
guarantee the integrity of the data with nGnRE prot on our device. And with this
prot, we can make direct wqe achieve better performance than NC.

Thanks
Weihang
