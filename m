Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB3212A571
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2019 02:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfLYBnL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Dec 2019 20:43:11 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8269 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfLYBnL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Dec 2019 20:43:11 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e02be8b0000>; Tue, 24 Dec 2019 17:42:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 24 Dec 2019 17:43:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 24 Dec 2019 17:43:10 -0800
Received: from [10.2.174.185] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Dec
 2019 01:43:09 +0000
Subject: Re: [PATCH 1/1] pyverbs: fix speed_to_str(), to handle disabled links
To:     Noa Osherovich <noaos@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20191221013256.100409-1-jhubbard@nvidia.com>
 <20191221013256.100409-2-jhubbard@nvidia.com>
 <fefd5386-d54b-a58e-29df-91a6dd94ccf0@mellanox.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6fa745c5-dc74-aae0-c3be-6564e146b068@nvidia.com>
Date:   Tue, 24 Dec 2019 17:40:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <fefd5386-d54b-a58e-29df-91a6dd94ccf0@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577238156; bh=D7JQpiAYYmZ1q8B5dq6c/FNn5WNecZogCYfvYiqEUc8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UCsgZimOPDROFUxrU0HvpCcRhh4TjBXDRTX22tiZm8S7rmzD+QzQXvcPkD7S/U5mb
         2jVg17jv9AO/7vYMnKiGSlQu3+YWx4n8S/hHFnqpEmLF/0HvtF1qGB0L2HY0UUKJgp
         p9rEV3za24mvQ0z5msXcBSkVjwmqY/ELu2nSMM9HNftSR24mCxoB/XPZXypnZtWod9
         ZWsWjYljqQQaTjvL7KqlMpC2R7ApTwiTUfUNMZEjCckfp8EiN0w5aVVpw8IO0IcCp6
         Vz82AhBUjj82RDHCF6c+Fe6lMe+zUy9GH82WdLseIDTWHv+doKdWGjgYicC7IeCWTM
         MaL+0bPWjwP8w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/23/19 6:39 AM, Noa Osherovich wrote:
...
>> diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
>> index 33d133fd..cf7b75de 100755
>> --- a/pyverbs/device.pyx
>> +++ b/pyverbs/device.pyx
>> @@ -923,8 +923,8 @@ def width_to_str(width):
>>    
>>    
>>    def speed_to_str(speed):
>> -    l = {1: '2.5 Gbps', 2: '5.0 Gbps', 4: '5.0 Gbps', 8: '10.0 Gbps',
>> -         16: '14.0 Gbps', 32: '25.0 Gbps', 64: '50.0 Gbps'}
>> +    l = {0: '0.0 Gbps', 1: '2.5 Gbps', 2: '5.0 Gbps', 4: '5.0 Gbps',
>> +         8: '10.0 Gbps', 16: '14.0 Gbps', 32: '25.0 Gbps', 64: '50.0 Gbps'}
>>        try:
>>            return '{s} ({n})'.format(s=l[speed], n=speed)
>>        except KeyError:
> 
> This seems OK to me. BTW, what's the reported active_width for disabled links?
> Maybe width_to_str could use a similar fix.
> 

Thanks for reviewing this! The reported active_width for disabled links on my
systems is showing up the same as for active links ("4X" in this case). So I don't
think we need a fix for width_to_str().

thanks,
-- 
John Hubbard
NVIDIA
