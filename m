Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBD870FB2
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 05:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfGWDNa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 23:13:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44821 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfGWDN3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 23:13:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so18331289pfe.11
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 20:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fRFZsdNPvDsMk94Q8NG3P/W+Km058oAnJHBvKza1iOQ=;
        b=DhEtWP1C5MhiQUCIJhO+C//hpG//XUNPs4r4CW1kx6EML9P+NlKpYL+PYYpUgzDoKN
         Fy4fGdiurpcsLJfODl/DEN1CsWYA5+0Hd3hAxIPkJ+yipRP2o633Oak+JOtNu4ESIllJ
         cLOKTClSjTa5LrpMpCgK5Z/B/xeg5ws7lGO3UAPTfNRy/SG/YiQD/ZcoOM343OHgAnSW
         FvJe0eFoksKjIUfjU+8OyeZNx2lOS1Y2cT3cWeDIXc2Tuh4jJ/ETfUi/c6bKjvNWn2jB
         UykgbqRT7qCryYSmb5FlBiFiO4yp6MRL5MBmNKkXWpyNVI6jyIEvtRnNXQnERvxuN3+K
         AjkA==
X-Gm-Message-State: APjAAAUfDcdG/0lFvwIovo/NBWBC2SrbFt/aj1f0ND4a2FowoJsxKYWs
        TuLB55AyFVPsIgyLVDYtL6fSQTo+iuI=
X-Google-Smtp-Source: APXvYqwbJoplbD5MzmOQgH/ax5wlVo+7uTDFO0js9d05xoduw+WgXGsN0Q9M2VF9GBOnAToGFKTVMg==
X-Received: by 2002:a17:90a:2190:: with SMTP id q16mr77626512pjc.23.1563851608387;
        Mon, 22 Jul 2019 20:13:28 -0700 (PDT)
Received: from asus.site ([2601:647:4000:52d2:bbe8:c2d7:f336:57bc])
        by smtp.gmail.com with ESMTPSA id t2sm36186831pgo.61.2019.07.22.20.13.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:13:26 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOOAkFF1ZXN0aW9uIGZvciBzcnB0IGluIGtlcm5lbC00LjE044CR?=
To:     oulijun <oulijun@huawei.com>, dledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
References: <16008407-2ffd-0bbb-717e-7e874a3a5ee0@huawei.com>
 <d4b60eb6-9e61-987e-d7ba-e3806faceedd@acm.org>
 <d2531a84-b0c2-3c39-141a-166a4a8dd8be@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c15e7a21-0e8b-b760-97dc-4bbd9a08b604@acm.org>
Date:   Mon, 22 Jul 2019 20:13:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d2531a84-b0c2-3c39-141a-166a4a8dd8be@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/22/19 6:30 PM, oulijun wrote:
> 在 2019/7/23 2:07, Bart Van Assche 写道:
>> On 7/19/19 11:54 PM, oulijun wrote:
>>> I am targeting a problem about RoCE and SCSI over RDMA from srpt in kernel-4.14. When insmod srpt.ko and insmod hns-roce-hw-v2.ko, it will
>>> report a warning in srpt_add_one:
>>>     ib_srpt srpt_add_one(hns_0) failed.
>>
>> How about the following patch?
>>
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index 1a039f16d315..e2a4a14763b8 100644
>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *device)
>>       srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
>>
>>       if (!srpt_service_guid)
>> -        srpt_service_guid = be64_to_cpu(device->node_guid);
>> +        srpt_service_guid = be64_to_cpu(device->node_guid) &
>> +            ~IB_SERVICE_ID_AGN_MASK;
>>
>>       if (rdma_port_get_link_layer(device, 1) == IB_LINK_LAYER_INFINIBAND)
>>           sdev->cm_id = ib_create_cm_id(device, srpt_cm_handler, sdev);
>>
> No, I did not find this patch in the latest kernel-5.3 or others.

What I meant is: can you try that patch?

Thanks,

Bart.
