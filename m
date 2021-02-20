Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB543204D3
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Feb 2021 10:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhBTJrv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 20 Feb 2021 04:47:51 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4629 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTJrv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 20 Feb 2021 04:47:51 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DjNq91cvwzYBDn;
        Sat, 20 Feb 2021 17:45:41 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 20 Feb 2021 17:47:05 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 20 Feb 2021 17:47:04 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.006;
 Sat, 20 Feb 2021 17:47:04 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC rdma-core 0/5] libhns: Add support for Dynamic Context
 Attachment
Thread-Topic: [PATCH RFC rdma-core 0/5] libhns: Add support for Dynamic
 Context Attachment
Thread-Index: AQHW/P+g64h4ciCwYkiRw06zMjvQFw==
Date:   Sat, 20 Feb 2021 09:47:04 +0000
Message-ID: <ae4b61de7912437c9445ad83430e3475@huawei.com>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
 <20210209193849.GR4247@nvidia.com>
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

On 2021/2/10 3:39, Jason Gunthorpe wrote:
> On Sun, Feb 07, 2021 at 11:12:49AM +0800, Weihang Li wrote:
>> The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
>> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
>> enables DCA feature, the WQE's buffer will not be allocated when creating
>> but when the users start to post WRs. This will reduce the memory
>> consumption when there are too many QPs are inactive.
>>
>> Please note that we didn't find the right way to get user's configuration,
>> so in #4 we still use environment variable to achieve this. We will be
>> appreciated if anyone can provide some sugggestions.
> 
> That is definately not going to work.. It should be some dv thing,
> dv create qp or a dv customization of the parent domain spring to mind
> 
> Jason
> 

Thank you, we will use the parameter of verbs_open_device() named
private_data to allow user pass the DCA configurations into the driver
according to the way of mlx5dv_open_device().

Weihang
