Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9D81CE777
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 23:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgEKVbl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 17:31:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52040 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgEKVbk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 17:31:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BLH0vk142002;
        Mon, 11 May 2020 21:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=huL3IFLcj3ydyiZXNJ4ber1yEInwSlzGJ9VkS6Dp42Q=;
 b=YLEpzczbTEmRIbH1kWrZsq8a5Fsy1f0VDLS7pBTLhvl0QOK6hLKfk/fRu86NSrYicmB+
 SjN12PFAiAURb9vZrA7aCC2b6Z2FoFloQYTV2XJJghNgkE03v23vliTC9g7wMEu1hpar
 J67OzQ/x0cdg5Re+qdFC4O7qMiFWK3/DtJ8pm2MsX+3l/GDdaxROp9vACmIR+catm6sb
 ICU9+2i3sjDZWZ+cmrKqrUbZVfdFvJE47EwHVbHP7WQcLjr1eJIFv0BVvEFViV2b4uAb
 EVqUUXtmu1LINNHcF447I5Sani9hZt9GQxzWmOg4fhpt2boSnbhm7PvCYUSwMPU99G0H Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30x3gsfmdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 21:31:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BLDtgq035616;
        Mon, 11 May 2020 21:31:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30ydsp2y0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 21:31:27 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04BLVQcV005112;
        Mon, 11 May 2020 21:31:26 GMT
Received: from dhcp-10-159-239-226.vpn.oracle.com (/10.159.239.226)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 14:31:25 -0700
Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
To:     Hillf Danton <hdanton@sina.com>, Mark Bloch <markb@mellanox.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
 <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
 <20200508110302.17872-1-hdanton@sina.com>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <a1075c70-c03a-8d94-e58f-0ea7d008ed67@oracle.com>
Date:   Mon, 11 May 2020 14:30:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508110302.17872-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=13 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0
 suspectscore=13 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110160
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Hillf,

Please find my comments inline -

On 5/8/20 4:03 AM, Hillf Danton wrote:
> On Thu, 7 May 2020 12:36:29 Mark Bloch wrote:
>> On 5/7/2020 11:34, Divya Indi wrote:
>>> This patch fixes commit -
>>> commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
>>>
>>> Above commit adds the query to the request list before ib_nl_snd_msg.
>>>
>>> However, if there is a delay in sending out the request (For
>>> eg: Delay due to low memory situation) the timer to handle request timeout
>>> might kick in before the request is sent out to ibacm via netlink.
>>> ib_nl_request_timeout may release the query if it fails to send it to SA
>>> as well causing a use after free situation.
>>>
>>> Call Trace for the above race:
>>>
>>> [<ffffffffa02f43cb>] ? ib_pack+0x17b/0x240 [ib_core]
>>> [<ffffffffa032aef1>] ib_sa_path_rec_get+0x181/0x200 [ib_sa]
>>> [<ffffffffa0379db0>] rdma_resolve_route+0x3c0/0x8d0 [rdma_cm]
>>> [<ffffffffa0374450>] ? cma_bind_port+0xa0/0xa0 [rdma_cm]
>>> [<ffffffffa040f850>] ? rds_rdma_cm_event_handler_cmn+0x850/0x850
>>> [rds_rdma]
>>> [<ffffffffa040f22c>] rds_rdma_cm_event_handler_cmn+0x22c/0x850
>>> [rds_rdma]
>>> [<ffffffffa040f860>] rds_rdma_cm_event_handler+0x10/0x20 [rds_rdma]
>>> [<ffffffffa037778e>] addr_handler+0x9e/0x140 [rdma_cm]
>>> [<ffffffffa026cdb4>] process_req+0x134/0x190 [ib_addr]
>>> [<ffffffff810a02f9>] process_one_work+0x169/0x4a0
>>> [<ffffffff810a0b2b>] worker_thread+0x5b/0x560
>>> [<ffffffff810a0ad0>] ? flush_delayed_work+0x50/0x50
>>> [<ffffffff810a68fb>] kthread+0xcb/0xf0
>>> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
>>> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
>>> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
>>> [<ffffffff816f25a7>] ret_from_fork+0x47/0x90
>>> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
>>> ....
>>> RIP  [<ffffffffa03296cd>] send_mad+0x33d/0x5d0 [ib_sa]
>>>
>>> To resolve this issue, we introduce a new flag IB_SA_NL_QUERY_SENT.
>>> This flag Indicates if the request has been sent out to ibacm yet.
>>>
>>> If this flag is not set for a query and the query times out, we add it
>>> back to the list with the original delay.
>>>
>>> To handle the case where a response is received before we could set this
>>> flag, the response handler waits for the flag to be
>>> set before proceeding with the query.
>>>
>>> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>>> ---
>>>  drivers/infiniband/core/sa_query.c | 45 ++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 45 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
>>> index 30d4c12..ffbae2f 100644
>>> --- a/drivers/infiniband/core/sa_query.c
>>> +++ b/drivers/infiniband/core/sa_query.c
>>> @@ -59,6 +59,9 @@
>>>  #define IB_SA_LOCAL_SVC_TIMEOUT_MAX		200000
>>>  #define IB_SA_CPI_MAX_RETRY_CNT			3
>>>  #define IB_SA_CPI_RETRY_WAIT			1000 /*msecs */
>>> +
>>> +DECLARE_WAIT_QUEUE_HEAD(wait_queue);
>>> +
>>>  static int sa_local_svc_timeout_ms = IB_SA_LOCAL_SVC_TIMEOUT_DEFAULT;
>>>  
>>>  struct ib_sa_sm_ah {
>>> @@ -122,6 +125,7 @@ struct ib_sa_query {
>>>  #define IB_SA_ENABLE_LOCAL_SERVICE	0x00000001
>>>  #define IB_SA_CANCEL			0x00000002
>>>  #define IB_SA_QUERY_OPA			0x00000004
>>> +#define IB_SA_NL_QUERY_SENT		0x00000008
>>>  
>>>  struct ib_sa_service_query {
>>>  	void (*callback)(int, struct ib_sa_service_rec *, void *);
>>> @@ -746,6 +750,11 @@ static inline int ib_sa_query_cancelled(struct ib_sa_query *query)
>>>  	return (query->flags & IB_SA_CANCEL);
>>>  }
>>>  
>>> +static inline int ib_sa_nl_query_sent(struct ib_sa_query *query)
>>> +{
>>> +	return (query->flags & IB_SA_NL_QUERY_SENT);
>>> +}
>>> +
>>>  static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
>>>  				     struct ib_sa_query *query)
>>>  {
>>> @@ -889,6 +898,15 @@ static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
>>>  		spin_lock_irqsave(&ib_nl_request_lock, flags);
>>>  		list_del(&query->list);
>>>  		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
> Here it also needs to do wakeup as sleeper might come while sending, no
> matter the failure to send.

We only sleep in the response handler. If we could not send a query, then
response handler is not triggered and hence no one would be waiting on this query.

Thanks,
Divya

>>> +	} else {
>>> +		query->flags |= IB_SA_NL_QUERY_SENT;
>>> +
>>> +		/*
>>> +		 * If response is received before this flag was set
>>> +		 * someone is waiting to process the response and release the
>>> +		 * query.
>>> +		 */
>>> +		wake_up(&wait_queue);
>>>  	}
>>>  
>>>  	return ret;
> With minor changes added on top of your work it now looks like the diff
> below (only including the wakeup part).
>
> --- a/drivers/infiniband/core/sa_query.c
> +++ b/drivers/infiniband/core/sa_query.c
> @@ -863,6 +863,11 @@ static int ib_nl_send_msg(struct ib_sa_q
>  	return rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, gfp_mask);
>  }
>  
> +static inline bool ib_sa_nl_query_sending(struct ib_sa_query *query)
> +{
> +	return query->flags & IB_SA_NL_QUERY_SENDING;
> +}
> +
>  static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
>  {
>  	unsigned long flags;
> @@ -874,6 +879,8 @@ static int ib_nl_make_request(struct ib_
>  
>  	/* Put the request on the list first.*/
>  	spin_lock_irqsave(&ib_nl_request_lock, flags);
> +	/* info others we're having work to do */
> +	query->flags |= IB_SA_NL_QUERY_SENDING;
>  	delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
>  	query->timeout = delay + jiffies;
>  	list_add_tail(&query->list, &ib_nl_request_list);
> @@ -883,13 +890,15 @@ static int ib_nl_make_request(struct ib_
>  	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>  
>  	ret = ib_nl_send_msg(query, gfp_mask);
> +	/* safe to delete it with IB_SA_NL_QUERY_SENDING set */
> +	spin_lock_irqsave(&ib_nl_request_lock, flags);
>  	if (ret) {
>  		ret = -EIO;
> -		/* Remove the request */
> -		spin_lock_irqsave(&ib_nl_request_lock, flags);
>  		list_del(&query->list);
> -		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>  	}
> +	query->flags &= ~IB_SA_NL_QUERY_SENDING;
> +	wake_up(&wait_queue);
> +	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>  
>  	return ret;
>  }
>
>
>>> @@ -994,6 +1012,21 @@ static void ib_nl_request_timeout(struct work_struct *work)
>>>  		}
>>>  
>>>  		list_del(&query->list);
>>> +
>>> +		/*
>>> +		 * If IB_SA_NL_QUERY_SENT is not set, this query has not been
>>> +		 * sent to ibacm yet. Reset the timer.
>>> +		 */
>>> +		if (!ib_sa_nl_query_sent(query)) {
>>> +			delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
>>> +			query->timeout = delay + jiffies;
>>> +			list_add_tail(&query->list, &ib_nl_request_list);
>>> +			/* Start the timeout if this is the only request */
>>> +			if (ib_nl_request_list.next == &query->list)
>>> +				queue_delayed_work(ib_nl_wq, &ib_nl_timed_work,
>>> +						delay);
>>> +			break;
>>> +		}
>>>  		ib_sa_disable_local_svc(query);
>>>  		/* Hold the lock to protect against query cancellation */
>>>  		if (ib_sa_query_cancelled(query))
>>> @@ -1123,6 +1156,18 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
>>>  
>>>  	send_buf = query->mad_buf;
>>>  
>>> +	/*
>>> +	 * Make sure the IB_SA_NL_QUERY_SENT flag is set before
>>> +	 * processing this query. If flag is not set, query can be accessed in
>>> +	 * another context while setting the flag and processing the query will
>>> +	 * eventually release it causing a possible use-after-free.
>>> +	 */
>>> +	if (unlikely(!ib_sa_nl_query_sent(query))) {
>> Can't there be a race here where you check the flag (it isn't set)
>> and before you call wait_event() the flag is set and wake_up() is called
>> which means you will wait here forever? or worse, a timeout will happen
>> the query will be freed and them some other query will call wake_up()
>> and we have again a use-after-free.
>>
>>> +		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>>> +		wait_event(wait_queue, ib_sa_nl_query_sent(query));
>> What if there are two queries sent to userspace, shouldn't you check and make sure
>> you got woken up by the right one setting the flag?
>>
>> Other than that, the entire solution makes it very complicated to reason with (flags set/checked without locking etc)
>> maybe we should just revert and fix it the other way?
>>
>> Mark 
>>
>>> +		spin_lock_irqsave(&ib_nl_request_lock, flags);
>>> +	}
>>> +
>>>  	if (!ib_nl_is_good_resolve_resp(nlh)) {
>>>  		/* if the result is a failure, send out the packet via IB */
>>>  		ib_sa_disable_local_svc(query);
>>>
