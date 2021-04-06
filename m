Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF93552ED
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 13:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbhDFL5E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 6 Apr 2021 07:57:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3515 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243397AbhDFL5E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 07:57:04 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FF5YW2n2FzRZ6W;
        Tue,  6 Apr 2021 19:54:55 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEML403-HUB.china.huawei.com (10.3.17.33) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 6 Apr 2021 19:56:54 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 6 Apr 2021 19:56:54 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Tue, 6 Apr 2021 19:56:55 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 3/6] RDMA/core: Add necessary spaces
Thread-Topic: [PATCH for-next 3/6] RDMA/core: Add necessary spaces
Thread-Index: AQHXKr4Bpg3ag8fmY0ect+O376cbug==
Date:   Tue, 6 Apr 2021 11:56:54 +0000
Message-ID: <35a345dba4814345b9a69874c7a61191@huawei.com>
References: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
 <1617697184-48683-4-git-send-email-liweihang@huawei.com>
 <YGwexRBkApaxvnGp@unreal>
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

On 2021/4/6 16:41, Leon Romanovsky wrote:
>> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
>> index da8adad..ee5ab1c 100644
>> --- a/drivers/infiniband/core/iwcm.c
>> +++ b/drivers/infiniband/core/iwcm.c
>> @@ -211,7 +211,7 @@ static void free_cm_id(struct iwcm_id_private *cm_id_priv)
>>   */
>>  static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
>>  {
>> -	BUG_ON(atomic_read(&cm_id_priv->refcount)==0);
>> +	BUG_ON(atomic_read(&cm_id_priv->refcount) == 0);
> Simply delete this BUG_ON.
> 
> Thanks
> 

Sure, thank you.

Weihang
