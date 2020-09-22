Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB627425D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 14:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgIVMrx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 08:47:53 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8911 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgIVMrw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Sep 2020 08:47:52 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f69f24a0000>; Tue, 22 Sep 2020 05:47:06 -0700
Received: from [172.27.12.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 12:47:51 +0000
Subject: Re: [PATCH rdma-core 3/8] verbs: Introduce a new query GID entry API
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
References: <20200914063503.192997-1-yishaih@nvidia.com>
 <20200914063503.192997-4-yishaih@nvidia.com>
 <20200921164936.GW3699@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <aad9ad94-f3a0-20a8-74fa-61439a7da77b@nvidia.com>
Date:   Tue, 22 Sep 2020 15:47:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921164936.GW3699@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600778826; bh=8YW30JdIQ49qdCnBpwRk+DNUXU8sHH/kUG8uDQkb57c=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=C1/B4MZiGgzJpRRlJ6/GUA//w3lehAFzymTVM+la+CD/Tzxt/9qreHJcKtpxndMn3
         rEk89xixXRHMDDlMhXTRlWqjxzuS75qMlP0JvErvSsn97llv+N2ojEbQrIOxc4gSx0
         RFsPwwpJXH9s7ZAhtN2SfZ7mCni+GYKbFV8da+e7+XS9NNmJQlNVPpROmKrF+BvaQh
         SMhLaHszz7+7n69WxVtlQWmAPGnQh4+aS2gQZKV2XbcCeCuUGHCAYMfZrLmy5nPrOZ
         YggeoJUaZTZXcyqIGWFsKE94tQJnHMMV+Iik8CFJvGAPka0HdGh+TKjEjw1Qi8CSa2
         YlFmghb3gAg7A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/21/2020 7:49 PM, Jason Gunthorpe wrote:
> On Mon, Sep 14, 2020 at 09:34:58AM +0300, Yishai Hadas wrote:
>> +static int query_sysfs_gid_ndev_ifindex(struct ibv_context *context,
>> +					uint8_t port_num, uint32_t gid_index,
>> +					uint32_t *ndev_ifindex)
>> +{
>> +	struct verbs_device *verbs_device = verbs_get_device(context->device);
>> +	char buff[IF_NAMESIZE] = {};
> This init is not necessary

OK

>
>> diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
>> index 9507ffd..9427aba 100644
>> +++ b/libibverbs/verbs.c
>> @@ -240,6 +240,14 @@ LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
>>   	return 0;
>>   }
>>   
>> +int _ibv_query_gid_ex(struct ibv_context *context, uint32_t port_num,
>> +		      uint32_t gid_index, struct ibv_gid_entry *entry,
>> +		      uint32_t flags, size_t entry_size)
>> +{
>> +	return ibv_cmd_query_gid_entry(context, port_num, gid_index, entry,
>> +				       flags, entry_size);
>> +}
> This extra function seems unncessary.
>
> We've been creating C files for each object type, the gid stuff could
> go in device.c
>
> Jason

In two patches ahead we introduce some mask to optimize ibv_query_gid() 
and ibv_query_gid_type() once they fallback over sysfs, so we may need 
to differentiate
between this external verb API to the internal command, but YES, all of 
this can be done under cmd_device.c, will be part of V1.

Thanks,
Yishai

