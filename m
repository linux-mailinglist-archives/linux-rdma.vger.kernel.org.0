Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9E94AA2
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 18:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfHSQmO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 12:42:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34888 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSQmO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 12:42:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so1531176pgv.2
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 09:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/SgCR6oER8heYDGAa7K9Y340FbXU+SUw6h+xCBbQS94=;
        b=Xo2683UqbBsmFlJpJGDv/4RdjnOvrGesDQiq6ELdY+SLbdbdX6dHThwuxwDxEm6WAQ
         f50Sw/oLAaXFByAho1VmISWXV6oWmiE4f28unK2SdaqvzeNHfX7ncje0GCyJ/bUvuJxl
         J0HNosNGb4mrv8LeTNmQ1WGeoyF2oYPOIScCJaaPkSUD3dEb4vfQ+L7dS90ZrXVptKgq
         J5rJoRSWFAaIIB5qAXix3QTWnh/ktKw+VvZtBZAOk+5XGpgREPxq34kmkax+J4fD9oLX
         DBDeeAjnxDxgi8o3SuXwa3OH1BgS7No4/gnCaxHmDTNQVZPH6slUF0meRN1Hpcb0skJc
         rykA==
X-Gm-Message-State: APjAAAWZtzP7XFEqkh/qFgRBdQ/TiWPsjsGBfykZs3oGBN1ZNE1DMJux
        xzIHUqE3Kxd6Mn13NAy1U21dR36N
X-Google-Smtp-Source: APXvYqxuGRD1lHObtPyYc4rhH0VwQme+h3NQecJdLG0JGZEa7nBzTPVSfKdeE917NLBh5+xN7XZ0ww==
X-Received: by 2002:a17:90a:ec07:: with SMTP id l7mr21386748pjy.39.1566232933224;
        Mon, 19 Aug 2019 09:42:13 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id bt18sm13917442pjb.1.2019.08.19.09.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:42:12 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOOAkFF1ZXN0aW9uIGZvciBzcnB0IGluIGtlcm5lbC00LjE044CR?=
To:     oulijun <oulijun@huawei.com>, dledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
References: <16008407-2ffd-0bbb-717e-7e874a3a5ee0@huawei.com>
 <d4b60eb6-9e61-987e-d7ba-e3806faceedd@acm.org>
 <d2531a84-b0c2-3c39-141a-166a4a8dd8be@huawei.com>
 <c15e7a21-0e8b-b760-97dc-4bbd9a08b604@acm.org>
 <b99eb729-2a1d-5c2e-970c-e3a9baf5d6bd@huawei.com>
 <e39e78fb-cf7a-b27f-89e3-b753131673d8@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e2b80987-a6ff-4693-f15d-5a7c41732401@acm.org>
Date:   Mon, 19 Aug 2019 09:42:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e39e78fb-cf7a-b27f-89e3-b753131673d8@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/23/19 6:35 PM, oulijun wrote:
> 在 2019/7/23 11:25, oulijun 写道:
>> 在 2019/7/23 11:13, Bart Van Assche 写道:
>>> On 7/22/19 6:30 PM, oulijun wrote:
>>>> 在 2019/7/23 2:07, Bart Van Assche 写道:
>>>>> On 7/19/19 11:54 PM, oulijun wrote:
>>>>>> I am targeting a problem about RoCE and SCSI over RDMA from srpt in kernel-4.14. When insmod srpt.ko and insmod hns-roce-hw-v2.ko, it will
>>>>>> report a warning in srpt_add_one:
>>>>>>      ib_srpt srpt_add_one(hns_0) failed.
>>>>> How about the following patch?
>>>>>
>>>>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>>> index 1a039f16d315..e2a4a14763b8 100644
>>>>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>>> @@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *device)
>>>>>        srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
>>>>>
>>>>>        if (!srpt_service_guid)
>>>>> -        srpt_service_guid = be64_to_cpu(device->node_guid);
>>>>> +        srpt_service_guid = be64_to_cpu(device->node_guid) &
>>>>> +            ~IB_SERVICE_ID_AGN_MASK;
>>>>>
>>>>>        if (rdma_port_get_link_layer(device, 1) == IB_LINK_LAYER_INFINIBAND)
>>>>>            sdev->cm_id = ib_create_cm_id(device, srpt_cm_handler, sdev);
>>>>>
>>>> No, I did not find this patch in the latest kernel-5.3 or others.
>>> What I meant is: can you try that patch?
 >
> if we don't add the patch (IB/srpt: Add RDMA/CM support) and only merge your patch, it will not resolve our question.
> 
> if we add the patch(IB/srpt: Add RDMA/CM support) and merge your patch, it will success.

Did you apply my patch on top of kernel v4.14 or on top of a more recent 
kernel version?

Thanks,

Bart.
