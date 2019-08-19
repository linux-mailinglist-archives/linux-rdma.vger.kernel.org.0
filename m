Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD1B9257C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 15:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfHSNtJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 09:49:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39950 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfHSNtJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 09:49:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id s145so1418417qke.7
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2QJBBrk2RDKDjvzSpz7hE5/bdPbL3kz0BstO/QCP5SY=;
        b=gzjwUiW3+qFJiUWpgdWKSohVlhkezzuOaBZVpeO8kODqnwWh1RBNPYC4kV2YZi6epz
         M2ko2nGqaCRNIBJAtBtRREnV/HTkjGmHY830rQ9yn9hvGKSptqrmCsVLkQ3y/u1Gb173
         5PvzhoM/GC21C4RcttamZSs0MSFfQmxfikOdFq0vsPqOqVk6wXMj61OOXywI5yIFU2sr
         j0HlTU2Unu1vS0GexAUE1s+nvg4VU36GpGRX41+OojgSsWbW1Ke2np9IaKQ71CG9I689
         zQf/HxAmG9NBRsVKNbJw+viEssUdcVu+9KnT2Kc6SsYura0wU9Suxpff/iVh0ir+8gJh
         USwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2QJBBrk2RDKDjvzSpz7hE5/bdPbL3kz0BstO/QCP5SY=;
        b=HUIRK1ulZe94Lk2CsE0+A2oPeIO56WL+KDMe8oeoKP49gK7EhAiQ7pVNect4w/7WD3
         7O3IazUHA6jh7jikHtWRWZAUdkjItYSNMq3E3LRwwz8gDrDfFfqtAJ/cfJg+nDQjCADm
         EdSu8Ob/fsQsH18eKI9WkQzXRrKUGLMEswoWVAIEW+hDJ9fT1cwHbewqO/NdSXxdkBOd
         b0kjqUYN+r2U+c4ey0i16LXnLfLNNmqT1K3x2TD06rDmFYA4d2VWTNMR2qJvNVM743hT
         nuR8MbrKmSfAshKQ174Acx6694tXrzCIFUtTij5RrlMuIqqsUgukqwqUcyqM0BwhIWWK
         grcQ==
X-Gm-Message-State: APjAAAVi+KkiPoYPqZvn87LZXxTRqCWSRx15iA1tfJQViSjrHgDKiHGW
        qa63ZUBO8NRhPcrGu/LcW+K1QA==
X-Google-Smtp-Source: APXvYqx+4n0Fkbf7iRR52lBAvDXp5oM63La03I/Itnk+Jc1p2d5/6bibA9OB5jgla/+wDREnpJsNww==
X-Received: by 2002:ae9:ee07:: with SMTP id i7mr21624928qkg.410.1566222548641;
        Mon, 19 Aug 2019 06:49:08 -0700 (PDT)
Received: from [192.168.1.119] (c-67-189-171-39.hsd1.ma.comcast.net. [67.189.171.39])
        by smtp.googlemail.com with ESMTPSA id t124sm7062467qke.31.2019.08.19.06.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 06:49:08 -0700 (PDT)
Subject: Re: [PATCH] RDMA/srpt: Filter out AGN bits
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hal Rosenstock <hal@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        oulijun <oulijun@huawei.com>
References: <20190814151507.140572-1-bvanassche@acm.org>
 <20190819122126.GA6509@ziepe.ca>
 <c8bf9c9e-6f4b-b3f3-2c12-72fab52f6a05@dev.mellanox.co.il>
 <20190819134608.GE5080@mellanox.com>
From:   Hal Rosenstock <hal@dev.mellanox.co.il>
Message-ID: <861760ab-7abc-746e-223e-c59e2c85e8da@dev.mellanox.co.il>
Date:   Mon, 19 Aug 2019 09:49:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819134608.GE5080@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/19/2019 9:46 AM, Jason Gunthorpe wrote:
> On Mon, Aug 19, 2019 at 09:40:24AM -0400, Hal Rosenstock wrote:
>> On 8/19/2019 8:21 AM, Jason Gunthorpe wrote:
>>> On Wed, Aug 14, 2019 at 08:15:07AM -0700, Bart Van Assche wrote:
>>>> The ib_srpt driver derives its default service GUID from the node GUID
>>>> of the first encountered HCA. Since that service GUID is passed to
>>>> ib_cm_listen(), the AGN bits must not be set. Since the AGN bits can
>>>> be set in the node GUID of RoCE HCAs, filter these bits out. This
>>>> patch avoids that loading the ib_srpt driver fails as follows for the
>>>> hns driver:
> 
> What is the actual problem anyhow? Is some roce GUID using the local
> bits and overlapping with the IB_CM_ASSIGN_SERVICE_ID? 
> 
> Ie generated VF MAC or something?
> 
>>>>   ib_srpt srpt_add_one(hns_0) failed.
>>>>
>>>> Cc: oulijun <oulijun@huawei.com>
>>>> Reported-by: oulijun <oulijun@huawei.com>
>>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>>>  drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>> index e25c70a56be6..114bf8d6c82b 100644
>>>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>> @@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *device)
>>>>  	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
>>>>  
>>>>  	if (!srpt_service_guid)
>>>> -		srpt_service_guid = be64_to_cpu(device->node_guid);
>>>> +		srpt_service_guid = be64_to_cpu(device->node_guid) &
>>>> +			~IB_SERVICE_ID_AGN_MASK;
>>>
>>> This seems kind of sketchy, masking bits in the GUID is going to make
>>> it non-unique.. Should we do this only for roce or something?
>>>
>>> Hal, do you have any insight?
>>
>> include/rdma/ib_cm.h:#define IB_SERVICE_ID_AGN_MASK
>> cpu_to_be64(0xFF00000000000000ULL)
>>
>> IB_SERVICE_ID_AGN_MASK masks entire first byte of OUI which seems like
>> too much to me as it contains company related bits.
>>
>> Would it work just masking the first 2 bits (local/global and X bits) ?
> 
> Maybe if we see a local GUID it should generate a random global GUID
> instead.

I think the OpenIB OUI could be used for that if you want...

> Jason
> 
