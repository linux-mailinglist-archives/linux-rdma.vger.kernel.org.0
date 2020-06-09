Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7469B1F3E87
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2020 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgFIOph (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jun 2020 10:45:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50184 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgFIOph (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jun 2020 10:45:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059EgQUR045115;
        Tue, 9 Jun 2020 14:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ggzgWATD6Kx+nyZOYo+YNp1tvcXMTXTuRYFbNe0R4W4=;
 b=oAqprH5D3NyzzIMVCwCVLd7UaPPZnHtRsRea2NYScdJ5vjotG63sstzdUzDOOqvyti0D
 bxSePo7NWEXf/cbdnNILflhaojqvJkorM68DKov3M3vjLGQxR0XUSn4qn87ycDEvyeB6
 FZXUaVFUh8NIXBtt8i+69p3aMkedabkBpYOrRzVPpTEfE3L5ZV1PEtJuW5Wb8WskOf3l
 nYsbJ+3aQtoJAWD4emnjK1qfNQP8qQwAWYUdLm6cwf3Y7rHCOrrkQ3wOtUwtOCN6Q6oV
 GXY/lqE70fC/0CPDgtapvY25QVn5EvQdkOLWOC8YM9wxdS++az/JoS2ezCNGCKrzOhqb MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3smw27u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 14:45:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059EhhV2177567;
        Tue, 9 Jun 2020 14:45:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31gn2wtmyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 14:45:24 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 059EjNeU016245;
        Tue, 9 Jun 2020 14:45:23 GMT
Received: from dhcp-10-159-155-165.vpn.oracle.com (/10.159.155.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 07:45:23 -0700
Subject: Re: [PATCH v3] IB/sa: Resolving use-after-free in ib_nl_send_msg
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
References: <1591627576-920-1-git-send-email-divya.indi@oracle.com>
 <1591627576-920-2-git-send-email-divya.indi@oracle.com>
 <20200609070026.GJ164174@unreal>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <ee7139ff-465e-6c43-1b55-eab502044e0f@oracle.com>
Date:   Tue, 9 Jun 2020 07:45:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200609070026.GJ164174@unreal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=13
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=13
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090112
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

Thanks for taking the time to review.

Please find my comments inline -

On 6/9/20 12:00 AM, Leon Romanovsky wrote:
> On Mon, Jun 08, 2020 at 07:46:16AM -0700, Divya Indi wrote:
>> Commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
>> -
>> 1. Adds the query to the request list before ib_nl_snd_msg.
>> 2. Removes ib_nl_send_msg from within the spinlock which also makes it
>> possible to allocate memory with GFP_KERNEL.
>>
>> However, if there is a delay in sending out the request (For
>> eg: Delay due to low memory situation) the timer to handle request timeout
>> might kick in before the request is sent out to ibacm via netlink.
>> ib_nl_request_timeout may release the query causing a use after free situation
>> while accessing the query in ib_nl_send_msg.
>>
>> Call Trace for the above race:
>>
>> [<ffffffffa02f43cb>] ? ib_pack+0x17b/0x240 [ib_core]
>> [<ffffffffa032aef1>] ib_sa_path_rec_get+0x181/0x200 [ib_sa]
>> [<ffffffffa0379db0>] rdma_resolve_route+0x3c0/0x8d0 [rdma_cm]
>> [<ffffffffa0374450>] ? cma_bind_port+0xa0/0xa0 [rdma_cm]
>> [<ffffffffa040f850>] ? rds_rdma_cm_event_handler_cmn+0x850/0x850
>> [rds_rdma]
>> [<ffffffffa040f22c>] rds_rdma_cm_event_handler_cmn+0x22c/0x850
>> [rds_rdma]
>> [<ffffffffa040f860>] rds_rdma_cm_event_handler+0x10/0x20 [rds_rdma]
>> [<ffffffffa037778e>] addr_handler+0x9e/0x140 [rdma_cm]
>> [<ffffffffa026cdb4>] process_req+0x134/0x190 [ib_addr]
>> [<ffffffff810a02f9>] process_one_work+0x169/0x4a0
>> [<ffffffff810a0b2b>] worker_thread+0x5b/0x560
>> [<ffffffff810a0ad0>] ? flush_delayed_work+0x50/0x50
>> [<ffffffff810a68fb>] kthread+0xcb/0xf0
>> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
>> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
>> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
>> [<ffffffff816f25a7>] ret_from_fork+0x47/0x90
>> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
>> ....
>> RIP  [<ffffffffa03296cd>] send_mad+0x33d/0x5d0 [ib_sa]
>>
>> To resolve the above issue -
>> 1. Add the req to the request list only after the request has been sent out.
>> 2. To handle the race where response comes in before adding request to
>> the request list, send(rdma_nl_multicast) and add to list while holding the
>> spinlock - request_lock.
>> 3. Use GFP_NOWAIT for rdma_nl_multicast since it is called while holding
>> a spinlock. In case of memory allocation failure, request will go out to SA.
>>
>> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>> Fixes: 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list
>> before sending")
> Author SOB should be after "Fixes" line.

My bad. Noted.

>
>> ---
>>  drivers/infiniband/core/sa_query.c | 34 +++++++++++++++++-----------------
>>  1 file changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
>> index 74e0058..042c99b 100644
>> --- a/drivers/infiniband/core/sa_query.c
>> +++ b/drivers/infiniband/core/sa_query.c
>> @@ -836,6 +836,9 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
>>  	void *data;
>>  	struct ib_sa_mad *mad;
>>  	int len;
>> +	unsigned long flags;
>> +	unsigned long delay;
>> +	int ret;
>>
>>  	mad = query->mad_buf->mad;
>>  	len = ib_nl_get_path_rec_attrs_len(mad->sa_hdr.comp_mask);
>> @@ -860,35 +863,32 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
>>  	/* Repair the nlmsg header length */
>>  	nlmsg_end(skb, nlh);
>>
>> -	return rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, gfp_mask);
>> +	spin_lock_irqsave(&ib_nl_request_lock, flags);
>> +	ret =  rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, GFP_NOWAIT);
> It is hard to be convinced that this is correct solution. The mix of
> gfp_flags and GFP_NOWAIT at the same time and usage of
> ib_nl_request_lock to protect lists and suddenly rdma_nl_multicast() too
> makes this code unreadable/non-maintainable.

Prior to 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list
before sending"), we had ib_nl_send_msg under the spinlock ib_nl_request_lock.

ie we had -

1. Get spinlock - ib_nl_request_lock 
2. ib_nl_send_msg
	2.a) rdma_nl_multicast
3. Add request to the req list
4. Arm the timer if needed.
5. Release spinlock

However, ib_nl_send_msg involved a memory allocation using GFP_KERNEL.
hence, was moved out of the spinlock. In addition, req was now being 
added prior to ib_nl_send_msg [To handle the race where response can
come in before we get a chance to add the request back to the list].

This introduced another race resulting in use-after-free.[Described in the commit.]

To resolve this, sending out the request and adding it to list need to 
happen while holding the request_lock.  
To ensure minimum allocations while holding the lock, instead of having
the entire ib_nl_send_msg under the lock, we only have rdma_nl_multicast
under this spinlock.

However, do you think it would be a good idea to split ib_nl_send_msg
into 2 functions -
1. Prepare the req/query [Outside the spinlock]
2. Sending the req - rdma_nl_multicast [while holding spinlock]

Would this be more intuitive? 

>> +	if (!ret) {
> Please use kernel coding style.
>
> if (ret) {
>   spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>   return ret;
>   }
>
>  ....

Noted. Will make this change.

>
>> +		/* Put the request on the list.*/
>> +		delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
>> +		query->timeout = delay + jiffies;
>> +		list_add_tail(&query->list, &ib_nl_request_list);
>> +		/* Start the timeout if this is the only request */
>> +		if (ib_nl_request_list.next == &query->list)
>> +			queue_delayed_work(ib_nl_wq, &ib_nl_timed_work, delay);
>> +	}
>> +	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>> +
>> +	return ret;
>>  }
>>
>>  static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
>>  {
>> -	unsigned long flags;
>> -	unsigned long delay;
>>  	int ret;
>>
>>  	INIT_LIST_HEAD(&query->list);
>>  	query->seq = (u32)atomic_inc_return(&ib_nl_sa_request_seq);
>>
>> -	/* Put the request on the list first.*/
>> -	spin_lock_irqsave(&ib_nl_request_lock, flags);
>> -	delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
>> -	query->timeout = delay + jiffies;
>> -	list_add_tail(&query->list, &ib_nl_request_list);
>> -	/* Start the timeout if this is the only request */
>> -	if (ib_nl_request_list.next == &query->list)
>> -		queue_delayed_work(ib_nl_wq, &ib_nl_timed_work, delay);
>> -	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>> -
>>  	ret = ib_nl_send_msg(query, gfp_mask);
>>  	if (ret) {
>>  		ret = -EIO;
>> -		/* Remove the request */
>> -		spin_lock_irqsave(&ib_nl_request_lock, flags);
>> -		list_del(&query->list);
>> -		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>>  	}
> Brackets should be removed too.
Noted.
>>  	return ret;
>> --
>> 1.8.3.1
>>
