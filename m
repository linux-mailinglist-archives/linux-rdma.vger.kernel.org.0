Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10921CE769
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 23:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEKV1T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 17:27:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40936 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgEKV1T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 17:27:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BLH1Ng070270;
        Mon, 11 May 2020 21:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iRjRG99TjStKkGNNrMg3LWajl6FYHZFh+J9ppid1Bho=;
 b=bjbKP5W53wdrPunwcQm4apnuEwAhzO6dIcUcip1L3Uavr9EY9qTGc9D7qCBh9SCTlP53
 VUY8RFOX77m7nC9FKGDCuAJx5bgiobSoM4Q9vPZUQ9G4XdkmwSodR29eKFIRVhXrdRXm
 MgPvht3CO8sZNSm12+hZ7pdZLzniRPgy5laenvfBoFzY6qBpYWW72P0eUZGz0VuzDCgk
 V61jVbFNmG5eV+Pyw2nQC634kyLqmS2XntNc2rtycJr5H0+bx1AUJ7IwZCTIg5eTcqEc
 aL7ArXgWRkSe1WI3rcNH7POFjEipLiwUQjGNbZIjmCMHgEkxjaj7G/JIND0XnEXgYKUP ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30x3mbqkm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 21:27:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BLEU2r124520;
        Mon, 11 May 2020 21:27:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30xbgfsg91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 21:27:13 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04BLRBMc012689;
        Mon, 11 May 2020 21:27:11 GMT
Received: from dhcp-10-159-239-226.vpn.oracle.com (/10.159.239.226)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 14:27:11 -0700
Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
 <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
 <20200508000809.GM26002@ziepe.ca>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <33fc99e2-e9fc-3c8c-e47f-41535f514c2d@oracle.com>
Date:   Mon, 11 May 2020 14:26:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508000809.GM26002@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=13 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=13 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110160
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On 5/7/20 5:08 PM, Jason Gunthorpe wrote:
> On Thu, May 07, 2020 at 11:34:47AM -0700, Divya Indi wrote:
>> This patch fixes commit -
>> commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
>>
>> Above commit adds the query to the request list before ib_nl_snd_msg.
>>
>> However, if there is a delay in sending out the request (For
>> eg: Delay due to low memory situation) the timer to handle request timeout
>> might kick in before the request is sent out to ibacm via netlink.
>> ib_nl_request_timeout may release the query if it fails to send it to SA
>> as well causing a use after free situation.
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
>> To resolve this issue, we introduce a new flag IB_SA_NL_QUERY_SENT.
>> This flag Indicates if the request has been sent out to ibacm yet.
>>
>> If this flag is not set for a query and the query times out, we add it
>> back to the list with the original delay.
>>
>> To handle the case where a response is received before we could set this
>> flag, the response handler waits for the flag to be
>> set before proceeding with the query.
>>
>> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>>  drivers/infiniband/core/sa_query.c | 45 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
>> index 30d4c12..ffbae2f 100644
>> +++ b/drivers/infiniband/core/sa_query.c
>> @@ -59,6 +59,9 @@
>>  #define IB_SA_LOCAL_SVC_TIMEOUT_MAX		200000
>>  #define IB_SA_CPI_MAX_RETRY_CNT			3
>>  #define IB_SA_CPI_RETRY_WAIT			1000 /*msecs */
>> +
>> +DECLARE_WAIT_QUEUE_HEAD(wait_queue);
>> +
>>  static int sa_local_svc_timeout_ms = IB_SA_LOCAL_SVC_TIMEOUT_DEFAULT;
>>  
>>  struct ib_sa_sm_ah {
>> @@ -122,6 +125,7 @@ struct ib_sa_query {
>>  #define IB_SA_ENABLE_LOCAL_SERVICE	0x00000001
>>  #define IB_SA_CANCEL			0x00000002
>>  #define IB_SA_QUERY_OPA			0x00000004
>> +#define IB_SA_NL_QUERY_SENT		0x00000008
>>  
>>  struct ib_sa_service_query {
>>  	void (*callback)(int, struct ib_sa_service_rec *, void *);
>> @@ -746,6 +750,11 @@ static inline int ib_sa_query_cancelled(struct ib_sa_query *query)
>>  	return (query->flags & IB_SA_CANCEL);
>>  }
>>  
>> +static inline int ib_sa_nl_query_sent(struct ib_sa_query *query)
>> +{
>> +	return (query->flags & IB_SA_NL_QUERY_SENT);
>> +}
>> +
>>  static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
>>  				     struct ib_sa_query *query)
>>  {
>> @@ -889,6 +898,15 @@ static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
>>  		spin_lock_irqsave(&ib_nl_request_lock, flags);
>>  		list_del(&query->list);
>>  		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>> +	} else {
>> +		query->flags |= IB_SA_NL_QUERY_SENT;
>> +
>> +		/*
>> +		 * If response is received before this flag was set
>> +		 * someone is waiting to process the response and release the
>> +		 * query.
>> +		 */
>> +		wake_up(&wait_queue);
>>  	}
>>  
>>  	return ret;
>> @@ -994,6 +1012,21 @@ static void ib_nl_request_timeout(struct work_struct *work)
>>  		}
>>  
>>  		list_del(&query->list);
>> +
>> +		/*
>> +		 * If IB_SA_NL_QUERY_SENT is not set, this query has not been
>> +		 * sent to ibacm yet. Reset the timer.
>> +		 */
>> +		if (!ib_sa_nl_query_sent(query)) {
>> +			delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
>> +			query->timeout = delay + jiffies;
>> +			list_add_tail(&query->list, &ib_nl_request_list);
>> +			/* Start the timeout if this is the only request */
>> +			if (ib_nl_request_list.next == &query->list)
>> +				queue_delayed_work(ib_nl_wq, &ib_nl_timed_work,
>> +						delay);
>> +			break;
>> +		}
>>  		ib_sa_disable_local_svc(query);
>>  		/* Hold the lock to protect against query cancellation */
>>  		if (ib_sa_query_cancelled(query))
>> @@ -1123,6 +1156,18 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
>>  
>>  	send_buf = query->mad_buf;
>>  
>> +	/*
>> +	 * Make sure the IB_SA_NL_QUERY_SENT flag is set before
>> +	 * processing this query. If flag is not set, query can be accessed in
>> +	 * another context while setting the flag and processing the query will
>> +	 * eventually release it causing a possible use-after-free.
>> +	 */
> This comment doesn't really make sense, flags insige the memory being
> freed inherently can't prevent use after free.

I can definitely re-phrase here to make things clearer. But, the idea here is
in the unlikely/rare case where a response for a query comes in before the flag has been
set in ib_nl_make_request, we want to wait for the flag to be sent before proceeding. 
The response handler will eventually release the query so this wait avoids that if the flag has not been set
else 
	"query->flags |= IB_SA_NL_QUERY_SENT;" 
will be accessing a query which was freed due to the above mentioned race.

It is unlikely since getting a response => We have actually sent out the query to ibacm.

How about this -

"Getting a response is indicative of having sent out the query, but in an unlikely race when 
the response comes in before setting IB_SA_NL_QUERY_SENT, we need to wait till the flag is set to
avoid accessing a query that has been released."

Thoughts?

Thanks,
Divya

Jason

