Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C127020A3C3
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2020 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406601AbgFYRNR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jun 2020 13:13:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59708 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404214AbgFYRNR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jun 2020 13:13:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PHBrVw099469;
        Thu, 25 Jun 2020 17:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=O2oAybOKnv5QUXHZI7d3PqnO3UUsizB8APpv0ak4AVM=;
 b=xbQUWbbqnwSluxfyXODNKuOKx0ZL+OHo+RUklVWoxDq43edmZ4JX2mXgEhUHcwLhIq8V
 z1f5d+KT6Imxssp43v+/cnOp+tkHPm9x8Y/71v4DpfGd8588nl0wPPThKMxurBzOJcgS
 X7GGYIa7WLZUKmL+GzaduYiO64SsGkWwc+ZAVKiIvu9VL4EYhCjz3YbscO2ULDNMVUGd
 1Afpw4/X/KUViFtDhRPDMoKVLzLHKvFzhnAiV4a+pfALUDh0crX78Lx0EuLaosLM8Y8I
 pkNbJckTpFSdyhVkbt9T+CViq1dKKGSo+lg+3VNQPy3Tb5CFmP4XO5xLb8QHd7qhDH3g JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31uustsrvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jun 2020 17:13:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PH4HP5023308;
        Thu, 25 Jun 2020 17:11:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31uur9b9yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 17:11:11 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05PHB9ZM005551;
        Thu, 25 Jun 2020 17:11:09 GMT
Received: from dhcp-10-159-134-8.vpn.oracle.com (/10.159.134.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jun 2020 17:11:09 +0000
Subject: Re: [PATCH v4] IB/sa: Resolving use-after-free in ib_nl_send_msg
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
References: <1592964789-14533-1-git-send-email-divya.indi@oracle.com>
 <20200625100904.GE1446285@unreal>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <372b8c22-bac9-e737-bd54-0d9e2901de65@oracle.com>
Date:   Thu, 25 Jun 2020 10:11:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625100904.GE1446285@unreal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=11 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=11 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250108
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

Please find my comments inline -

On 6/25/20 3:09 AM, Leon Romanovsky wrote:
> On Tue, Jun 23, 2020 at 07:13:09PM -0700, Divya Indi wrote:
>> Commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
>> -
>> 1. Adds the query to the request list before ib_nl_snd_msg.
>> 2. Moves ib_nl_send_msg out of spinlock, hence safe to use gfp_mask as is.
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
>> 3. Use non blocking memory allocation flags for rdma_nl_multicast since it is
>> called while holding a spinlock.
>>
>> Fixes: 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list
>> before sending")
>>
>> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>> ---
>> v1:
>> - Use flag IB_SA_NL_QUERY_SENT to prevent the use-after-free.
>>
>> v2:
>> - Use atomic bit ops for setting and testing IB_SA_NL_QUERY_SENT.
>> - Rewording and adding comments.
>>
>> v3:
>> - Change approach and remove usage of IB_SA_NL_QUERY_SENT.
>> - Add req to request list only after the request has been sent out.
>> - Send and add to list while holding the spinlock (request_lock).
>> - Overide gfp_mask and use GFP_NOWAIT for rdma_nl_multicast since we
>>   need non blocking memory allocation while holding spinlock.
>>
>> v4:
>> - Formatting changes.
>> - Use GFP_NOWAIT conditionally - Only when GFP_ATOMIC is not provided by caller.
>> ---
>>  drivers/infiniband/core/sa_query.c | 41 ++++++++++++++++++++++----------------
>>  1 file changed, 24 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
>> index 74e0058..9066d48 100644
>> --- a/drivers/infiniband/core/sa_query.c
>> +++ b/drivers/infiniband/core/sa_query.c
>> @@ -836,6 +836,10 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
>>  	void *data;
>>  	struct ib_sa_mad *mad;
>>  	int len;
>> +	unsigned long flags;
>> +	unsigned long delay;
>> +	gfp_t gfp_flag;
>> +	int ret;
>>
>>  	mad = query->mad_buf->mad;
>>  	len = ib_nl_get_path_rec_attrs_len(mad->sa_hdr.comp_mask);
>> @@ -860,36 +864,39 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
>>  	/* Repair the nlmsg header length */
>>  	nlmsg_end(skb, nlh);
>>
>> -	return rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, gfp_mask);
>> -}
>> +	gfp_flag = ((gfp_mask & GFP_ATOMIC) == GFP_ATOMIC) ? GFP_ATOMIC :
>> +		GFP_NOWAIT;
> I would say that the better way will be to write something like this:
> gfp_flag |= GFP_NOWAIT;

You mean gfp_flag = gfp_mask|GFP_NOWAIT? [We dont want to modify the gfp_mask sent by caller]

#define GFP_ATOMIC      (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
#define GFP_KERNEL      (__GFP_RECLAIM | __GFP_IO | __GFP_FS)
#define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM)

If a caller passes GFP_KERNEL, "gfp_mask|GFP_NOWAIT" will still have __GFP_RECLAIM,
__GFP_IO and __GFP_FS set which is not suitable for using under spinlock.

Thanks,
Divya

>
> Thanks
