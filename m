Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C707270A2A
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 04:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgISCuI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 18 Sep 2020 22:50:08 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:36364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISCuI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 22:50:08 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 66152BE69B3241E9E3BF;
        Sat, 19 Sep 2020 10:35:02 +0800 (CST)
Received: from dggema702-chm.china.huawei.com (10.3.20.66) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 19 Sep 2020 10:35:02 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema702-chm.china.huawei.com (10.3.20.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 19 Sep 2020 10:35:02 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Sat, 19 Sep 2020 10:35:01 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 1/9] RDMA/hns: Refactor process about opcode
 in post_send()
Thread-Topic: [PATCH v2 for-next 1/9] RDMA/hns: Refactor process about opcode
 in post_send()
Thread-Index: AQHWhod3V4urJchahE+e/OuI5OAMRA==
Date:   Sat, 19 Sep 2020 02:35:01 +0000
Message-ID: <8c42a99876d74a4a8557d8e0e98889b1@huawei.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
 <1599641854-23160-2-git-send-email-liweihang@huawei.com>
 <20200918134715.GA304004@nvidia.com>
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

On 2020/9/18 21:47, Jason Gunthorpe wrote:
> On Wed, Sep 09, 2020 at 04:57:26PM +0800, Weihang Li wrote:
>>  
>> +	ret = set_ud_opcode(ud_sq_wqe, wr);
>> +	if (unlikely(ret)) {
>> +		ibdev_err(ibdev, "unsupported opcode, opcode = %d.\n",
>> +			  wr->opcode);
> 
> No random prints like this. If this is kernel only and something
> in-kernel is busted then it is just
> 
>   if (WARN_ON(ret))
> 
> Same for every place in this patch
> 
> Jason
> 

Thanks for you suggestion, I will modify them.

Weihang
