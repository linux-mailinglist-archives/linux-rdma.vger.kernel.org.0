Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B725C2677E9
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Sep 2020 06:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgILEqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Sep 2020 00:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725795AbgILEqw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 12 Sep 2020 00:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599886008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcjRpDjrmSGoRJjM8o6GsZSZ+Sh5D+O0hyvZu9UTKXM=;
        b=YqyUwn1JxP+gK6XYlckG0rX7KdOtL3RcSfRyuPA+Jswe8APrbGzv0eWmdhv4iu+ow6PkVK
        wwOAxAcGAKkRPX4gtfsosgEc3WlolPH/Qad4tuYoU/+s6q5AhmkopM/k6n6ngSjFEmcyto
        2xLbRpqPhxlVgxYFRaGkj30m20/CiEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-nKRcDuUkOnu5nyOXPZlhJQ-1; Sat, 12 Sep 2020 00:46:44 -0400
X-MC-Unique: nKRcDuUkOnu5nyOXPZlhJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BC76801AC5;
        Sat, 12 Sep 2020 04:46:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1FD35C22B;
        Sat, 12 Sep 2020 04:46:36 +0000 (UTC)
Subject: Re: [IB/srpt] c804af2c1d: last_state.test.blktests.exit_code.143
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org, lkp@lists.01.org
References: <20200802060925.GW23458@shao2-debian>
 <f8ef3284-4646-94d9-7eea-14ac0873b03b@acm.org>
 <ed6002b6-cd0c-55c5-c5a5-9c974a476a95@mellanox.com>
 <0c42aeb4-23a5-b9d5-bc17-ef58a04db8e8@grimberg.me>
 <128192ad-05ff-fa8e-14fc-479a115311e0@acm.org>
 <20200824133019.GH1152540@nvidia.com>
 <2a2ff3a5-f58e-8246-fd09-87029b562347@acm.org>
 <20200908182232.GP9166@nvidia.com>
 <e8a240aa-9e9b-3dca-062f-9130b787f29b@acm.org>
 <6c86453d-d7ae-a36b-d827-7812999abc96@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <ba743253-5fc5-1fda-8d6e-d2d6e82ea13e@redhat.com>
Date:   Sat, 12 Sep 2020 12:46:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6c86453d-d7ae-a36b-d827-7812999abc96@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tested-by: Yi Zhang <yi.zhang@redhat.com>


This patch fixed the issue I filed[1] which use rdma_rxe for nvme-rdma 
testing.

[1]
http://lists.infradead.org/pipermail/linux-nvme/2020-August/018988.html

Thanks
Yi

On 9/12/20 6:00 AM, Bart Van Assche wrote:
> On 2020-09-08 19:01, Bart Van Assche wrote:
>> The above patch didn't compile, but the patch below does and makes the hang
>> disappear. So feel free to add the following to the patch below:
>>
>> Tested-by: Bart Van Assche <bvanassche@acm.org>
>>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index c36b4d2b61e0..23ee65a9185f 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -1285,6 +1285,8 @@ static void disable_device(struct ib_device *device)
>>   		remove_client_context(device, cid);
>>   	}
>>
>> +	ib_cq_pool_destroy(device);
>> +
>>   	/* Pairs with refcount_set in enable_device */
>>   	ib_device_put(device);
>>   	wait_for_completion(&device->unreg_completion);
>> @@ -1328,6 +1330,8 @@ static int enable_device_and_get(struct ib_device *device)
>>   			goto out;
>>   	}
>>
>> +	ib_cq_pool_init(device);
>> +
>>   	down_read(&clients_rwsem);
>>   	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
>>   		ret = add_client_context(device, client);
>> @@ -1400,7 +1404,6 @@ int ib_register_device(struct ib_device *device, const char *name)
>>   		goto dev_cleanup;
>>   	}
>>
>> -	ib_cq_pool_init(device);
>>   	ret = enable_device_and_get(device);
>>   	dev_set_uevent_suppress(&device->dev, false);
>>   	/* Mark for userspace that device is ready */
>> @@ -1455,7 +1458,6 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
>>   		goto out;
>>
>>   	disable_device(ib_dev);
>> -	ib_cq_pool_destroy(ib_dev);
>>
>>   	/* Expedite removing unregistered pointers from the hash table */
>>   	free_netdevs(ib_dev);
> Hi Jason,
>
> Please let me know how you want to proceed with this patch.
>
> Thanks,
>
> Bart.
>

