Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0EC50C23
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 15:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfFXNkr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 09:40:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48962 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFXNkr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 09:40:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ODd6aD182875;
        Mon, 24 Jun 2019 13:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=K7gxshFfPe2+xR4//0ULdZekh1PFmPKPu4U8BpZy7mA=;
 b=yuYGx49Tzx/Jtm8s465BBJcEzBNkqNtBd40c78YE4O31ukp5rIf6N3L0m7FAbk+8MgPQ
 WvgNwQcn0V4gi4lLtQrtbL7AIwyIO0PrYTKdZqShSwo5whlCbi0D5qAc/eh0suGBqg/o
 Yuq7w2L87U02b5a+an6qjUBM0igjU/4LM+6EusScHP7CJzmAQv16DB/6UfBUG6v0VaC1
 zZWurWYMiGIS3rKEtnmwk8/DC2U2y111cu191sk4cxpl/cANWtzYoFXCrmaVJh3O66w5
 qaszDMICh2vnb31LM7job2wVJaHpg+/AczkvNY0SzjFkJdTZO/LfNNUAXuKoFRNFGCwC gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t9cyq6e2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 13:40:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ODdnAB027610;
        Mon, 24 Jun 2019 13:40:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t99f39d48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 13:40:19 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5ODeH4k007088;
        Mon, 24 Jun 2019 13:40:17 GMT
Received: from [10.172.157.165] (/10.172.157.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 06:40:17 -0700
Subject: Re: [PATCH] RDMA/core: Fix race when resolving IP address
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@mellanox.com>
References: <1561126156-10162-1-git-send-email-dag.moxnes@oracle.com>
 <20190621145604.GS19891@ziepe.ca>
From:   Dag Moxnes <dag.moxnes@oracle.com>
Message-ID: <e9b4abe6-0acb-c169-fbac-4e62d2ad2808@oracle.com>
Date:   Mon, 24 Jun 2019 15:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190621145604.GS19891@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240112
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,


Thanks for the review.


On 6/21/19 4:56 PM, Jason Gunthorpe wrote:
> On Fri, Jun 21, 2019 at 04:09:16PM +0200, Dag Moxnes wrote:
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
>> Change-Id: I3c5f982b304457f0a83ea7def2fac70315ed38b4
>>   drivers/infiniband/core/addr.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
>> index 2f7d141598..e4945fd1bb 100644
>> +++ b/drivers/infiniband/core/addr.c
>> @@ -333,12 +333,16 @@ static int dst_fetch_ha(const struct dst_entry *dst,
>>   	if (!n)
>>   		return -ENODATA;
>>   
>> +	read_lock_bh(&n->lock)
Miising semicolon at end of statement. Sorry about that.
>>   	if (!(n->nud_state & NUD_VALID)) {
>> -		neigh_event_send(n, NULL);
>>   		ret = -ENODATA;
>>   	} else {
>>   		memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
>>   	}
>> +	read_unlock_bh(&n->lock);
>> +
>> +	if (ret)
>> +		neigh_event_send(n, NULL);
>>   
>>   	neigh_release(n);
> Can we write this with less spaghetti please, maybe:
>
> static int dst_fetch_ha(const struct dst_entry *dst,
> 			struct rdma_dev_addr *dev_addr,
> 			const void *daddr)
> {
> 	struct neighbour *n;
> 	int ret = 0;
>
> 	n = dst_neigh_lookup(dst, daddr);
> 	if (!n)
> 		return -ENODATA;
>
> 	read_lock_bh(&n->lock);
> 	if (!(n->nud_state & NUD_VALID)) {
> 		read_unlock_bh(&n->lock);
> 		goto out_send;
> 	}
> 	memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
> 	read_unlock_bh(&n->lock);
>
> 	goto out_release;
>
> out_send:
> 	neigh_event_send(n, NULL);
> 	ret = -ENODATA;
> out_release:
> 	neigh_release(n);
>
> 	return ret;
> }

Personally I find it more readable when the unlock is done in one place,

but sure, I can rewrite it the way you suggest if the reviewers agree that

that way is preferable.

Regards,

-Dag


> Also, Parav should look at it.
>
> Thanks,
> Jason
