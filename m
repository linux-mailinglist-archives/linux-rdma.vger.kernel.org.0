Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF473A0A9F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 05:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhFID32 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 8 Jun 2021 23:29:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4527 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhFID32 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 23:29:28 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0CCH1VvwzZf1K;
        Wed,  9 Jun 2021 11:24:43 +0800 (CST)
Received: from dggpeml100023.china.huawei.com (7.185.36.151) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 11:27:31 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100023.china.huawei.com (7.185.36.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 11:27:31 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Wed, 9 Jun 2021 11:27:31 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v4 for-next 03/12] RDMA/core: Use refcount_t instead of
 atomic_t on refcount of ib_mad_snoop_private
Thread-Topic: [PATCH v4 for-next 03/12] RDMA/core: Use refcount_t instead of
 atomic_t on refcount of ib_mad_snoop_private
Thread-Index: AQHXU6UjflaGDqHyIk29TX2a/UIk0Q==
Date:   Wed, 9 Jun 2021 03:27:31 +0000
Message-ID: <3030ed2300d140a4b4e1101464679f3b@huawei.com>
References: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
 <1622194663-2383-4-git-send-email-liweihang@huawei.com>
 <20210608180410.GA977963@nvidia.com>
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

On 2021/6/9 2:04, Jason Gunthorpe wrote:
> On Fri, May 28, 2021 at 05:37:34PM +0800, Weihang Li wrote:
>> The refcount_t API will WARN on underflow and overflow of a reference
>> counter, and avoid use-after-free risks.
>>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/core/mad_priv.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
>> index 4aa16b3..25e573d 100644
>> --- a/drivers/infiniband/core/mad_priv.h
>> +++ b/drivers/infiniband/core/mad_priv.h
>> @@ -115,7 +115,7 @@ struct ib_mad_snoop_private {
>>  	struct ib_mad_qp_info *qp_info;
>>  	int snoop_index;
>>  	int mad_snoop_flags;
>> -	atomic_t refcount;
>> +	refcount_t refcount;
>>  	struct completion comp;
>>  };
> 
> Since this is never used I changed this to just delete it
> 
> Jason
> 

Sure, thanks.

Weihang
