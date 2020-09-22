Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465BA27428A
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIVM7e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 08:59:34 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10558 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgIVM7e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Sep 2020 08:59:34 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f69f5290001>; Tue, 22 Sep 2020 05:59:21 -0700
Received: from [172.27.12.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 12:59:32 +0000
Subject: Re: [PATCH rdma-core 4/8] verbs: Implement ibv_query_gid and
 ibv_query_gid_type over ioctl
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
References: <20200914063503.192997-1-yishaih@nvidia.com>
 <20200914063503.192997-5-yishaih@nvidia.com>
 <20200921165312.GX3699@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <cfecd5dd-4b1f-41e5-0744-7f11aa974bf6@nvidia.com>
Date:   Tue, 22 Sep 2020 15:59:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921165312.GX3699@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600779561; bh=AUcJYZ0vuRT0fsW7aXpUkU0KsO/uSMnfmg/fEWR7e70=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=AeZ/WqQyJsnTiErjMP1RD2T9rxkzwYu892vPrxc5oG7zG6MiQhsnLuk+pwB0nwJtw
         Sd6B2xcCsK7/4yOUCZlzlbOD0Hx3qgpPBRTOpXO0ipANFXPttMfpoUvI9ifsgoX3c5
         SM2/Y1FBxrer7b0RteYo50UbK5hONdaN0Q2nXAKuV9ZjGLFKAc6mfhrcMvNB2abz/i
         VRdOihYa6lECMy+m60UgBjSRWB4AupHUkKwmirCWZCVP6Dd8hkkgb9MVLShNLrUJ6T
         jj9sEI9HqaJYjauccaYhQVonWMhe5viTasWYoHD1ko8JxdZnL9aBBWtBf9Y2Hc28Df
         jF5wLc7ezK5Yw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/21/2020 7:53 PM, Jason Gunthorpe wrote:
> On Mon, Sep 14, 2020 at 09:34:59AM +0300, Yishai Hadas wrote:
>
>> diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
>> index 9427aba..9dec4e6 100644
>> +++ b/libibverbs/verbs.c
>> @@ -216,10 +216,8 @@ LATEST_SYMVER_FUNC(ibv_query_port, 1_1, "IBVERBS_1.1",
>>   				sizeof(*port_attr));
>>   }
>>   
>> -LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
>> -		   int,
>> -		   struct ibv_context *context, uint8_t port_num,
>> -		   int index, union ibv_gid *gid)
>> +int _ibv_query_gid(struct ibv_context *context, uint8_t port_num, int index,
>> +		   union ibv_gid *gid)
>>   {
>>   	struct verbs_device *verbs_device = verbs_get_device(context->device);
>>   	char attr[41];
>> @@ -240,6 +238,29 @@ LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
>>   	return 0;
>>   }
> This should be moved to be near query_sysfs_gid_entry() and given a
> better name
>
> Jason

OK, will rename it to be query_sysfs_gid() and will move it to be near 
the above which reads the full gid entry information.
In addition, will do the same for _ibv_query_gid_type(), will move to 
cmd_device.c and rename it to be query_sysfs_gid_type().

Yishai

