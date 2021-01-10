Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CC12F0707
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Jan 2021 13:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbhAJMIS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Jan 2021 07:08:18 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5078 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJMIR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Jan 2021 07:08:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffaee070000>; Sun, 10 Jan 2021 04:07:37 -0800
Received: from [172.27.0.98] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 10 Jan
 2021 12:07:33 +0000
Subject: Re: [PATCH 2/3] IB/isert: remove unneeded semicolon
To:     Leon Romanovsky <leonro@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <sagi@grimberg.me>, <oren@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
 <20210110111903.486681-2-mgurtovoy@nvidia.com>
 <20210110113643.GI31158@unreal>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <290f62a9-12fa-2a1a-298e-2e8d2aa7045c@nvidia.com>
Date:   Sun, 10 Jan 2021 14:07:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210110113643.GI31158@unreal>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610280457; bh=jczYWmqzwh7Bd5VtA9t+a0NKo3QZz5EuIm+5zhmOyuw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=fy8bQZV8Jj2HcgeDL2koylgOudqNHJcuN/a7cgWqEdUdsBsntCaZfW0LRjgIythM8
         sZnf3+QfiflM9/BvhRTOG8jrfR4qLAhMRrOAxZYeLKpyLz0LYEC/wH340UDc4Gj/5o
         LRx8lg91yf+0l/r4ylM2MxMm6A/8ysIpUXKuxgOqyuIxj4BSsHD1Asvyms/AX4HH9V
         f0WN5mYnHKwpg5zJr7P8X8G0WUH/ZdkX6mwAp318WMl7kp55q6OaTSyL/I8pIejpN2
         HS1spWABB27LIKgshd/VGo0THk7to5g74Hbwpg2d0RVM8VRjmvHeNBIuQlcMRbGaax
         AbP2c6kmgUa7A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 1/10/2021 1:36 PM, Leon Romanovsky wrote:
> On Sun, Jan 10, 2021 at 11:19:02AM +0000, Max Gurtovoy wrote:
>> No need to add semicolon after closing bracket.
>>
>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/infiniband/ulp/isert/ib_isert.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
>> index 5958929b7dec..96514f675427 100644
>> --- a/drivers/infiniband/ulp/isert/ib_isert.c
>> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
>> @@ -1991,7 +1991,7 @@ isert_set_dif_domain(struct se_cmd *se_cmd, struct ib_sig_domain *domain)
>>   	if (se_cmd->prot_type == TARGET_DIF_TYPE1_PROT ||
>>   	    se_cmd->prot_type == TARGET_DIF_TYPE2_PROT)
>>   		domain->sig.dif.ref_remap = true;
>> -};
>> +}
> The same goes for iser_set_dif_domain() and iser_cleanup_handler().

Good catch, I'll send iSER fixes in different series.

This series is for minor fixes for iSERT.

>
> Thanks
>
>>   static int
>>   isert_set_sig_attrs(struct se_cmd *se_cmd, struct ib_sig_attrs *sig_attrs)
>> --
>> 2.25.4
>>
