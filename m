Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CE34945DD
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 03:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiATCvC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 21:51:02 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34045 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230154AbiATCvC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jan 2022 21:51:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2JWtMK_1642647059;
Received: from 30.43.105.54(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V2JWtMK_1642647059)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 Jan 2022 10:51:00 +0800
Message-ID: <bc98f3d7-e400-db94-4c75-b92b556011fa@linux.alibaba.com>
Date:   Thu, 20 Jan 2022 10:50:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
From:   Cheng Xu <chengyou@linux.alibaba.com>
Subject: Re: [PATCH rdma-next v2 08/11] RDMA/erdma: Add connection management
 (CM) support
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB26310055D86455FC7088EDB699589@BYAPR15MB2631.namprd15.prod.outlook.com>
 <9f8ab769-271e-32da-1357-7b316d34dc93@linux.alibaba.com>
 <BYAPR15MB263196636F8243CF6C653DE599599@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <BYAPR15MB263196636F8243CF6C653DE599599@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/19/22 5:56 PM, Bernard Metzler wrote:
> 
> 
>> -----Original Message-----
>> From: Cheng Xu <chengyou@linux.alibaba.com>
>> Sent: Wednesday, 19 January 2022 04:58
>> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca;
>> dledford@redhat.com
>> Cc: leon@kernel.org; linux-rdma@vger.kernel.org;
>> KaiShen@linux.alibaba.com; tonylu@linux.alibaba.com
>> Subject: [EXTERNAL] Re: [PATCH rdma-next v2 08/11] RDMA/erdma: Add
>> connection management (CM) support
>>
>>
>>
>> On 1/18/22 10:49 PM, Bernard Metzler wrote:
>>>
>>
>> <...>
>>
>>>> +		cm_id = cep->listen_cep->cm_id;
>>>> +
>>>> +		event.ird = cep->dev->attrs.max_ird;
>>>> +		event.ord = cep->dev->attrs.max_ord;
>>>
>>> Provide to the user also the negotiated  IRD/ORD of the
>>> reply. Things may have changed upon peer's request.
>>> See current siw code for the details.
>>>
>>
>> IRD/ORD in ERDMA hardware is fixed, no need to negotiate them in MPA
>> request/reply now. For this reason, we didn't follow siw with MPA v2.
> 
> How is that working? Is the idea that the adapter implements a fixed
> value which (hopefully) always exceeds any ULP requested IRD/ORD?

Yes, for better IRQ/ORQ queue buffer alignment in hardware, we use a fix
depth in our device. ULPs call iw_connect()/iw_accept() with ird/ord in
iw_cm_conn_param, if exceed, return -EINVAL immediately, this ensures
erdma always have enough IRQ/ORQ resources.

> In any case, the negotiated (even if fixed) value MUST be provided
> to the ULP's at both ends. In the erdma case, it is likely more than the
> ULP was asking for. See RFC 5040, section 6.1
> https://datatracker.ietf.org/doc/html/rfc5040#section-6.1
> 

I think the values of IRD/ORD does influence the behavior of ULPs,
the purpose of IRD/ORD negotiation is making sure that both ends of the
RNICs have enough resources, otherwise overflow may happens.

For ULPs, They always can post as many RDMA Read as they can (not exceed
the max_send_wr), no matter the value of IRD/ORD is, RDMA Read will be
delayed if ORD value goes to zero [1]. In erdma case with fix ORQ/IRQ
depth, the ORD/IRD is more likes a flow control credit. And we will
consider this.

[1] 
https://datatracker.ietf.org/doc/html/draft-hilland-rddp-verbs-00#section-6.5


> 
>>
>>>> +	} else {
>>>> +		cm_id = cep->cm_id;
>>>> +	}
>>>> +
>>>> +	if (reason == IW_CM_EVENT_CONNECT_REQUEST ||
>>>> +	    reason == IW_CM_EVENT_CONNECT_REPLY) {
>>>> +		u16 pd_len = be16_to_cpu(cep->mpa.hdr.params.pd_len);
>>>> +
>>>
>>> Does erdma support MPA protocol version 2, and enhanced connection
>>> setup protocol? In that case, some private data contain protocol
>>> information and must be hidden to the user.
>>>
>>
>> Now we follow MPA v1. And due to specially network environment in Cloud
>> VPC, we extend the MPA v1: We exchange information with a extend header,
>> which followed with original MPA v1 header.
> 
> This is control information placed between MPAv1 header and ULP's
> private data? So erdma is not interoperable with a device implementing
> IETF iWarp?
> 

Yes, but this is not the major reason. As I mentioned in the cover
letter, erdma is a RNIC provided by our MOC hardware in VPC
environment, and we do not sell erdma cards (indeed no single physical
cards, erdma is generated & accelerated by MOC) but the the VMs or bare
metals with ERDMA feature. No other iWarp devices in VPC physically, and
ERDMA can communicate with.

Thanks,
Cheng Xu,
