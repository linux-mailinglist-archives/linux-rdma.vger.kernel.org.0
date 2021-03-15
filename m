Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FF33A9F4
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Mar 2021 04:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhCODV1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 14 Mar 2021 23:21:27 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5088 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhCODVO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Mar 2021 23:21:14 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DzM8x5M20zYKF1;
        Mon, 15 Mar 2021 11:19:29 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 15 Mar 2021 11:21:11 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 15 Mar 2021 11:21:12 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Mon, 15 Mar 2021 11:21:11 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC v2 rdma-core 5/6] libhns: Add direct verb to support
 config DCA memory pool
Thread-Topic: [PATCH RFC v2 rdma-core 5/6] libhns: Add direct verb to support
 config DCA memory pool
Thread-Index: AQHXENQxBje7Mi4ULU2ThT/0U31I4w==
Date:   Mon, 15 Mar 2021 03:21:11 +0000
Message-ID: <293b470d01f246d28eb055a7d351e0ae@huawei.com>
References: <1614847759-33139-1-git-send-email-liweihang@huawei.com>
 <1614847759-33139-6-git-send-email-liweihang@huawei.com>
 <20210312142747.GB2356281@nvidia.com>
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

On 2021/3/12 22:28, Jason Gunthorpe wrote:
> On Thu, Mar 04, 2021 at 04:49:18PM +0800, Weihang Li wrote:
>> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
>> index 656b0f9..db37dce 100644
>> +++ b/libibverbs/verbs.h
>> @@ -918,6 +918,7 @@ enum ibv_qp_create_flags {
>>  	IBV_QP_CREATE_CVLAN_STRIPPING		= 1 << 9,
>>  	IBV_QP_CREATE_SOURCE_QPN		= 1 << 10,
>>  	IBV_QP_CREATE_PCI_WRITE_END_PADDING	= 1 << 11,
>> +	IBV_QP_CREATE_DYNAMIC_CONTEXT_ATTACH	= 1 << 13,
>>  };
> 
> No, all the stuff related to these kinds of extensions must be in the
> hnsdv.h and can't be used with the normal APIs at all
> 
> Jason
> 

OK, we will add a hnsdv_create_qp instead.

Thank you,
Weihang
