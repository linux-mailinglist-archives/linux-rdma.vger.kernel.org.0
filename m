Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD5493403
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 05:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349462AbiASESr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 23:18:47 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34040 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235242AbiASESp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 23:18:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2F6x.S_1642565923;
Received: from 30.43.106.202(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V2F6x.S_1642565923)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Jan 2022 12:18:44 +0800
Message-ID: <26c9b7fb-3a11-f247-f32e-185a68b64cdf@linux.alibaba.com>
Date:   Wed, 19 Jan 2022 12:18:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB2631DDA080CDD41142AEB45399589@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <BYAPR15MB2631DDA080CDD41142AEB45399589@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/18/22 8:53 PM, Bernard Metzler wrote:

<...>

>> +static int erdma_res_cb_init(struct erdma_dev *dev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ERDMA_RES_CNT; i++) {
>> +		dev->res_cb[i].next_alloc_idx = 1;
>> +		spin_lock_init(&dev->res_cb[i].lock);
>> +		dev->res_cb[i].bitmap = kcalloc(BITS_TO_LONGS(dev-
>>> res_cb[i].max_cap),
>> +						sizeof(unsigned long), GFP_KERNEL);
> 
> better stay with less than 80 chars per line
> throughout the patch series (I count currently 287 line wraps).
> 

The kernel now allows 100 chars per line, and the checkpath.pl also
checks using the new rule now. I will try to change this to 80 chars, 
but it actually makes some code not friendly for reading due to
indent.

<...>

>> +	switch (event) {
>> +	case NETDEV_UP:
>> +		dev->state = IB_PORT_ACTIVE;
>> +		erdma_port_event(dev, IB_EVENT_PORT_ACTIVE);
>> +		break;
>> +	case NETDEV_DOWN:
>> +		dev->state = IB_PORT_DOWN;
>> +		erdma_port_event(dev, IB_EVENT_PORT_ERR);
>> +		break;
>> +	case NETDEV_UNREGISTER:
>> +		ib_unregister_device_queued(ibdev);
>> +		break;
>> +	case NETDEV_REGISTER:
>> +	case NETDEV_CHANGEADDR:
> 
> No action needed here?
> 

Changing MAC address of ENIs in Alibaba Cloud makes no sense and is not
recommended, this will make the network unreachable and loss the 
connection. An ERDMA device is attached to an ENI, and no need to
process this event.

>> +	case NETDEV_CHANGEMTU:
>> +	case NETDEV_GOING_DOWN:
> 
> does erdma not have to take care about connected QPs
> if its associated link goes down? This event might be
> the right time to do cleanup, if needed (maybe also see siw
> driver)

The event of netdev down will be notified to the backend of virtio-net.
Virtio-net and ERDMA deivces are in the same MOC hardware (e,g, our DPU
chipset), and the event will be spread to ERDMA backend. After that,
ERDMA backend will process it, and notify to driver by AEQE or CQE with
error. No need to handle this in driver all together.

>> +	case NETDEV_CHANGE:
>> +	default:
>> +		break;
>> +	}
>> +
>> +	ib_device_put(ibdev);
>> +
>> +	return NOTIFY_DONE;
> 
> Better returning NOTIFY_OK here?
> 
> from <linux/notifier.h>:
>   #define NOTIFY_DONE     0x0000      /* Don't care */
>   #define NOTIFY_OK       0x0001      /* Suits me */
> 

I will check this.

Thanks,
Cheng Xu
