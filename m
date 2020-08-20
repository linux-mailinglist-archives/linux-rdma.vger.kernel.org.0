Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E424C211
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 17:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgHTPX3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 11:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728104AbgHTPX2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Aug 2020 11:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597937007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B6jcRhOzH51qKJmUQ0MYnaaAcT5czw/UfJKwQmMngpE=;
        b=KukZQZyjoq1oPq1R2i65qEt8dp3F1fHpm+OgzUI5K2ol1Ch4kB1q7CAnPMk+zUBh1fgYxE
        Ehw6keduvyXeg778UJXqi/3wCr6sDqNcUfTpMDn6tbQi4/9qpK47ix7CX2+tJxoKdr3ILX
        MqL8EuQHYgFTSVaQGlhIeWquuF6oP3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-5KbBrnBBPNuu0R3cUKvD8Q-1; Thu, 20 Aug 2020 11:23:25 -0400
X-MC-Unique: 5KbBrnBBPNuu0R3cUKvD8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EBF080733A;
        Thu, 20 Aug 2020 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-149.pek2.redhat.com [10.72.12.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AF8F19C66;
        Thu, 20 Aug 2020 15:23:20 +0000 (UTC)
Subject: Re: [PATCH] RDMA/rxe: fix the parent sysfs read when the interface
 has 15 chars
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, yanjunz@mellanox.com,
        bvanassche@acm.org, kamalheib1@gmail.com
References: <20200820041336.24761-1-yi.zhang@redhat.com>
 <20200820114608.GB24045@ziepe.ca>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <ba68cd49-99cd-1287-d1b3-f033293981f8@redhat.com>
Date:   Thu, 20 Aug 2020 23:23:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200820114608.GB24045@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/20/20 7:46 PM, Jason Gunthorpe wrote:
> On Thu, Aug 20, 2020 at 12:13:36PM +0800, Yi Zhang wrote:
>> parent sysfs reads will yield '\0' bytes when the interface name
>> has 15 chars, and there will no "\n" output.
>>
>> reproducer:
>> Create one interface with 15 chars
>> [root@test ~]# ip a s enp0s29u1u7u3c2
>> 2: enp0s29u1u7u3c2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
>>      link/ether 02:21:28:57:47:17 brd ff:ff:ff:ff:ff:ff
>>      inet6 fe80::ac41:338f:5bcd:c222/64 scope link noprefixroute
>>         valid_lft forever preferred_lft forever
>> [root@test ~]# modprobe rdma_rxe
>> [root@test ~]# echo enp0s29u1u7u3c2 > /sys/module/rdma_rxe/parameters/add
>> [root@test ~]# cat /sys/class/infiniband/rxe0/parent
>> enp0s29u1u7u3c2[root@test ~]#
>> [root@test ~]# f="/sys/class/infiniband/rxe0/parent"
>> [root@test ~]# echo "$(<"$f")"
>> -bash: warning: command substitution: ignored null byte in input
>> enp0s29u1u7u3c2
>>
>> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
>>   drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> index bb61e534e468..91090cb1b08c 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> @@ -1056,7 +1056,7 @@ static ssize_t parent_show(struct device *device,
>>   	struct rxe_dev *rxe =
>>   		rdma_device_to_drv_device(device, struct rxe_dev, ib_dev);
>>   
>> -	return snprintf(buf, 16, "%s\n", rxe_parent_name(rxe, 1));
>> +	return snprintf(buf, 17, "%s\n", rxe_parent_name(rxe, 1));
>>   }
> This should be written as
>
>    return scnprintf(buf, PAGE_SIZE, "%s\n", rxe_parent_name(rxe, 1));
>
> All places in this file should be changed
Here is the only space use snprintf, will send v2 as you suggested, thanks.
> Jason
>

