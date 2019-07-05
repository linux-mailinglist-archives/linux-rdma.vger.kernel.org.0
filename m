Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9232602D0
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 11:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfGEJDm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jul 2019 05:03:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45520 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbfGEJDl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Jul 2019 05:03:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x658xWvl187487;
        Fri, 5 Jul 2019 09:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1g1pDf5Otmvxw/VYPR3CC5244T59MboONzYhSU/S7LA=;
 b=QpX6MdG+eGOdrPIHnITLpxK1JW0TBiUfePLdu+fVR6qlR1oHg6f43StMcycND18fcTIS
 pxNZz3LMYUDiUl0iixVsip36/x3vjNsy9FdAWH0scxs39jUZukr4jGUdVC6q3Pdo5KxM
 dFIFy8uATPsmmIclFjN2Mu1vgaW55p/nhDQ1CXoezeehavSkskgXIk9AY+jzfaT6KeMO
 IO3qylfY9VnLTH6oxUYRdTfeWdw8TyYASirkf5FoXSJMcNjz0w5rj4QqibJZem8bPe6v
 UI1fscDMgUzVjEBjOPq6CNNnjbRO1pgIr+s8iNv6dowHnQPGg1e1mKXD51O79f2Byyd1 rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2te61qa109-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jul 2019 09:03:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x65933R7010009;
        Fri, 5 Jul 2019 09:03:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2th5qmdr72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jul 2019 09:03:15 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6593DPs021563;
        Fri, 5 Jul 2019 09:03:13 GMT
Received: from [192.168.1.14] (/109.189.94.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jul 2019 02:03:13 -0700
Subject: Re: [PATCH v2] RDMA/core: Fix race when resolving IP address
To:     Parav Pandit <pandit.parav@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1561711763-24705-1-git-send-email-dag.moxnes@oracle.com>
 <CAG53R5VQqqr0S6OU+13tcuxcvz922iuqoP-mWbaQERPc48964A@mail.gmail.com>
From:   Dag Moxnes <dag.moxnes@oracle.com>
Message-ID: <4e46889a-0b13-fa9b-fe8e-d9f6a44d714a@oracle.com>
Date:   Fri, 5 Jul 2019 11:03:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAG53R5VQqqr0S6OU+13tcuxcvz922iuqoP-mWbaQERPc48964A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9308 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907050117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9308 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907050117
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Den 05.07.2019 04:19, skrev Parav Pandit:
> On Fri, Jun 28, 2019 at 2:20 PM Dag Moxnes <dag.moxnes@oracle.com> wrote:
>> Use neighbour lock when copying MAC address from neighbour data struct
>> in dst_fetch_ha.
>>
>> When not using the lock, it is possible for the function to race with
>> neigh_update, causing it to copy an invalid MAC address.
>>
>> It is possible to provoke this error by calling rdma_resolve_addr in a
>> tight loop, while deleting the corresponding ARP entry in another tight
>> loop.
>>
>> Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
>> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
>>
>> ---
>> v1 -> v2:
>>     * Modified implementation to improve readability
>> ---
>>   drivers/infiniband/core/addr.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
>> index 2f7d141598..51323ffbc5 100644
>> --- a/drivers/infiniband/core/addr.c
>> +++ b/drivers/infiniband/core/addr.c
>> @@ -333,11 +333,14 @@ static int dst_fetch_ha(const struct dst_entry *dst,
>>          if (!n)
>>                  return -ENODATA;
>>
>> -       if (!(n->nud_state & NUD_VALID)) {
>> +       read_lock_bh(&n->lock);
>> +       if (n->nud_state & NUD_VALID) {
>> +               memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
>> +               read_unlock_bh(&n->lock);
>> +       } else {
>> +               read_unlock_bh(&n->lock);
>>                  neigh_event_send(n, NULL);
>>                  ret = -ENODATA;
>> -       } else {
>> -               memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
>>          }
>>
>>          neigh_release(n);
>> --
>> 2.20.1
>>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
>
> A sample trace such as below in commit message would be good to have.
> Or the similar one that you noticed with ARP delete sequence.
>
> neigh_changeaddr()
>    neigh_flush_dev()
>     n->nud_state = NUD_NOARP;
>
> Having some issues with office outlook, so replying via gmail.

Hi Parav,

Thanks for your review. I'll add a sample trace to the commit message as

you suggest.


Regards,

-Dag

