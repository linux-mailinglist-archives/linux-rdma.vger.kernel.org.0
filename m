Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD7B287320
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 13:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgJHLI4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 07:08:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36822 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgJHLIz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 07:08:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098B4EdT104738;
        Thu, 8 Oct 2020 11:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OMYc8pOl6k7ZZefUN/F1xPIrmkFF8Sq2etAmzt21bFs=;
 b=wRA6mK51mB36BcCAzEg+WrLhGXOMJL+NZuQtUQZrMGlSuE67+oHa7hYE7C/x90eB0kqq
 sShOrYj8kjhcaERLWbEKOR91WWmsVUWNMJMdjezzx7XT8wC1/0R9/SFbWgxULK2Wdro6
 o8IwyrypB6bRsSKnpa4j4yqBwsiTJsHrT9AwR1sbCZwRC6I+i8wu1iaavm1k4klf2CCd
 Jq9kJtntpnTkXKZ48EtFdA1ltxoAPMGdE0IwQm2qnCpWmS6VDonLukG3Q3w1zskP6kWJ
 8DGnYnKvNS+ZTwUYxDEG5gWflkbQtjHkIRBP+eKlyH/94Gn8hV0RvySqLeM4h8kfaF2T PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33xetb777b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Oct 2020 11:08:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098B4viu121187;
        Thu, 8 Oct 2020 11:08:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3410k10bvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Oct 2020 11:08:52 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 098B8o6c015141;
        Thu, 8 Oct 2020 11:08:51 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Oct 2020 04:08:49 -0700
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
References: <20201005131611.GR9916@ziepe.ca>
 <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
 <20201005142554.GS9916@ziepe.ca>
 <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
 <20201005154548.GT9916@ziepe.ca>
 <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
 <20201006124627.GH5177@ziepe.ca>
 <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
 <20201007111636.GD3678159@unreal>
 <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
 <20201008103641.GM13580@unreal>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
Date:   Thu, 8 Oct 2020 19:08:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008103641.GM13580@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080082
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/8/20 6:36 PM, Leon Romanovsky wrote:
> On Thu, Oct 08, 2020 at 06:22:03PM +0800, Ka-Cheong Poon wrote:
>> On 10/7/20 7:16 PM, Leon Romanovsky wrote:
>>> On Wed, Oct 07, 2020 at 04:38:45PM +0800, Ka-Cheong Poon wrote:
>>>> On 10/6/20 8:46 PM, Jason Gunthorpe wrote:
>>>>> On Tue, Oct 06, 2020 at 05:36:32PM +0800, Ka-Cheong Poon wrote:
>>>>>
>>>>>>>>> Kernel modules should not be doing networking unless commanded to by
>>>>>>>>> userspace.
>>>>>>>>
>>>>>>>> It is still not clear why this is an issue with RDMA
>>>>>>>> connection, but not with general kernel socket.  It is
>>>>>>>> not random networking.  There is a purpose.
>>>>>>>
>>>>>>> It is a problem with sockets too, how do the socket users trigger
>>>>>>> their socket usages? AFAIK all cases originate with userspace
>>>>>>
>>>>>> A user starts a namespace.  The module is loaded for servicing
>>>>>> requests.  The module starts a listener.  The user deletes
>>>>>> the namespace.  This scenario will have everything cleaned up
>>>>>> properly if the listener is a kernel socket.  This is not the
>>>>>> case with RDMA.
>>>>>
>>>>> Please point to reputable code in upstream doing this
>>>>
>>>>
>>>> It is not clear what "reputable" here really means.  If it just
>>>> means something in kernel, then nearly all, if not all, Internet
>>>> protocols code in kernel create a control kernel socket for every
>>>> network namespaces.  That socket is deleted in the per namespace
>>>> exit function.  If it explicitly means listening socket, AFS and
>>>> TIPC in kernel do that for every namespaces.  That socket is
>>>> deleted in the per namespace exit function.
>>>>
>>>> It is very common for a network protocol to have something like
>>>> this for protocol processing.  It is not clear why RDMA subsystem
>>>> behaves differently and forbids this common practice.  Could you
>>>> please elaborate the issues this practice has such that the RDMA
>>>> subsystem cannot support it?
>>>
>>> Just curious, are we talking about theoretical thing here or do you
>>> have concrete and upstream ULP code to present?
>>
>>
>> As I mentioned in a previous email, I have running code.
>> Otherwise, why would I go to such great length to find
>> out what is missing in the RDMA subsystem in supporting
>> kernel namespace usage.
> 
> So why don't you post this running code?


Will it change the listening RDMA endpoint started by the module from
"rogue" to normal?  This is the fundamental problem.  This is the reason
I ask why the RDMA subsystem behaves like this in the first place.  If
the reason is just that there is no existing user, it is fine.  Unexpectedly,
the reason turns out to be that no kernel module is allowed to create its own
RDMA endpoint without a corresponding user space file descriptor and/or some
form of user space interaction.  This is a very serious restriction on how
the RDMA subsystem can be used by any kernel module.  This has to be sorted
out first.

Note that namespace does not really play a role in this "rogue" reasoning.
The init_net is also a namespace.  The "rogue" reasoning means that no
kernel module should start a listening RDMA endpoint by itself with or
without any extra namespaces.  In fact, to conform to this reasoning, the
"right" thing to do would be to change the code already in upstream to get
rid of the listening RDMA endpoint in init_net!



-- 
K. Poon
ka-cheong.poon@oracle.com


