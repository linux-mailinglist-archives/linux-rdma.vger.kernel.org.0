Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE23092811
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 17:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfHSPLZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 11:11:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40971 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfHSPLY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 11:11:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so1386670pgg.8
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 08:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6J6lEWblAK4hsi7AVZjnjOuY7FG+3npadeKpaVWTO30=;
        b=DS10kI40SeyOw0jwTBjqgd3ewuNB58aBYHj5bO4NIjQlbUGNVPSaZcR4wM7FQp+MiM
         eTnpvIa/sTPwqsJXjvPFNDLi9K4cWDwDfVTmCO6o5ae02TCiMbvP7a9m9soMMbfdMGe6
         Qzn42ruXXsh5LJ0naM0brxYSKayVZVkr487p0X6nKxZ6UcS1qJEx8JppMxI/wSV7PWeJ
         /UAoZjysoKtV2mRPZAELCFdLwE+EGNC1MWX25FUg0vprW02+HrY+2NAs59aYWlpERBf2
         dRHrdN4Q8kC+Tfeu2g2wj+PVS8xIsONlnAlcKGT48yIIQBUEl7bOrUB+dNvP3AMb2+3S
         gPWw==
X-Gm-Message-State: APjAAAXsuPLz5mGjHRKXLkA0OxSsX6IUjjLncLgHnCGPi+Yf4oYzVgDQ
        ifPNDEMNJvQ8QXTcB4XO2K8=
X-Google-Smtp-Source: APXvYqxj0WAaACmO+A2NGDQE+rnIfB9c9/LInBz22E5S/LXM8VDpEEDFL12QQtZKQ3KU3VdMSzypcg==
X-Received: by 2002:a63:9249:: with SMTP id s9mr19746973pgn.356.1566227483737;
        Mon, 19 Aug 2019 08:11:23 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l4sm12628151pjq.9.2019.08.19.08.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:11:22 -0700 (PDT)
Subject: Re: [PATCH] RDMA/srpt: Filter out AGN bits
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Hal Rosenstock <hal@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        oulijun <oulijun@huawei.com>
References: <20190814151507.140572-1-bvanassche@acm.org>
 <20190819122126.GA6509@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d2429292-be75-ee67-2cce-081d9d0aa676@acm.org>
Date:   Mon, 19 Aug 2019 08:11:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819122126.GA6509@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/19/19 5:21 AM, Jason Gunthorpe wrote:
> On Wed, Aug 14, 2019 at 08:15:07AM -0700, Bart Van Assche wrote:
>> The ib_srpt driver derives its default service GUID from the node GUID
>> of the first encountered HCA. Since that service GUID is passed to
>> ib_cm_listen(), the AGN bits must not be set. Since the AGN bits can
>> be set in the node GUID of RoCE HCAs, filter these bits out. This
>> patch avoids that loading the ib_srpt driver fails as follows for the
>> hns driver:
>>
>>    ib_srpt srpt_add_one(hns_0) failed.
>>
>> Cc: oulijun <oulijun@huawei.com>
>> Reported-by: oulijun <oulijun@huawei.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>   drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index e25c70a56be6..114bf8d6c82b 100644
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *device)
>>   	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
>>   
>>   	if (!srpt_service_guid)
>> -		srpt_service_guid = be64_to_cpu(device->node_guid);
>> +		srpt_service_guid = be64_to_cpu(device->node_guid) &
>> +			~IB_SERVICE_ID_AGN_MASK;
> 
> This seems kind of sketchy, masking bits in the GUID is going to make
> it non-unique.. Should we do this only for roce or something?

Hi Jason and Hal,

The I/O controller GUID can be used in the srp_daemon configuration file 
for filtering purposes. The srp_daemon only supports IB networks.

In the IBTA spec I found the following about the I/O controller GUID: 
"An EUI-64 GUID used to uniquely identify the controller. This could be 
the same one as the Node/Port GUID if there is only one controller."

Does uniqueness of the I/O controller GUID only matter in InfiniBand 
networks or does it also matter in other RDMA networks?

How about using 0 as default value for the srpt_service_guid in RoCE 
networks?

Thanks,

Bart.

