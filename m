Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1DF1CE72D
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 23:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgEKVLu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 17:11:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38658 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgEKVLu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 17:11:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BL70nI133523;
        Mon, 11 May 2020 21:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8rJnnjudDG8o1gMfcWeFlPJcaBQ58zmQlTl62GDpyRU=;
 b=qVL5BiKyKwoOHkDieP0PlZn+m1hBmbIZwsRlFAbmnRV7meP3znJ1wDSy9mkzZCOPZagb
 UQWPM70HgQtJXwibYAQT+wRdkcJOaRW/0tOuP6GjFxAgXNqn35SLS7Tzg9CO9ncTvxbw
 3trYhVzXvbg6ziYufareesHzVXek5NseITAbt34FvxPGUFhfsyz+5LCq48C5yul25pgB
 4ZNT0hNS+CIpJnfcm6xoIbj+Kn2U1D0BBmvO5/zN6l6TLl91p4AzArutGokJG2sIqQ/c
 5dxDlLZNU8OWMwegXmwP14KtrPUipSj/ZFpOQWxLOhXqMwjpX+gmBmXwISs1OHmQpVkr IA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30x3gsfj5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 21:11:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BL7c2k138858;
        Mon, 11 May 2020 21:11:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30x63nepa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 21:11:40 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04BLBd4f015077;
        Mon, 11 May 2020 21:11:39 GMT
Received: from dhcp-10-159-239-226.vpn.oracle.com (/10.159.239.226)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 14:11:39 -0700
Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
To:     Mark Bloch <markb@mellanox.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
 <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
 <7572e503-312c-26a8-c8c2-05515f1c4f84@mellanox.com>
 <MW3PR11MB4665120FE43314C22A862324F4A50@MW3PR11MB4665.namprd11.prod.outlook.com>
 <b387f32b-c990-614b-c631-b38ddf821757@mellanox.com>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <9cdcdf41-5ae9-dcac-d72a-77482ea6a59e@oracle.com>
Date:   Mon, 11 May 2020 14:10:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b387f32b-c990-614b-c631-b38ddf821757@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=11
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=11 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110159
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Mark,

Please find my comments inline -

On 5/7/20 2:40 PM, Mark Bloch wrote:
>
> On 5/7/2020 13:16, Wan, Kaike wrote:
>>
>>> -----Original Message-----
>>> From: Mark Bloch <markb@mellanox.com>
>>> Sent: Thursday, May 07, 2020 3:36 PM
>>> To: Divya Indi <divya.indi@oracle.com>; linux-kernel@vger.kernel.org; linux-
>>> rdma@vger.kernel.org; Jason Gunthorpe <jgg@ziepe.ca>; Wan, Kaike
>>> <kaike.wan@intel.com>
>>> Cc: Gerd Rausch <gerd.rausch@oracle.com>; Håkon Bugge
>>> <haakon.bugge@oracle.com>; Srinivas Eeda <srinivas.eeda@oracle.com>;
>>> Rama Nichanamatlu <rama.nichanamatlu@oracle.com>; Doug Ledford
>>> <dledford@redhat.com>
>>> Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
>>>
>>>
>>>> @@ -1123,6 +1156,18 @@ int ib_nl_handle_resolve_resp(struct sk_buff
>>>> *skb,
>>>>
>>>>  	send_buf = query->mad_buf;
>>>>
>>>> +	/*
>>>> +	 * Make sure the IB_SA_NL_QUERY_SENT flag is set before
>>>> +	 * processing this query. If flag is not set, query can be accessed in
>>>> +	 * another context while setting the flag and processing the query
>>> will
>>>> +	 * eventually release it causing a possible use-after-free.
>>>> +	 */
>>>> +	if (unlikely(!ib_sa_nl_query_sent(query))) {
>>> Can't there be a race here where you check the flag (it isn't set) and before
>>> you call wait_event() the flag is set and wake_up() is called which means you
>>> will wait here forever?
>> Should wait_event() catch that? That is,  if the flag is not set, wait_event() will sleep until the flag is set.
>>
>>  or worse, a timeout will happen the query will be
>>> freed and them some other query will call wake_up() and we have again a
>>> use-after-free.
>> The request has been deleted from the request list by this time and therefore the timeout should have no impact here.
>>
>>
>>>> +		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>>>> +		wait_event(wait_queue, ib_sa_nl_query_sent(query));
>>> What if there are two queries sent to userspace, shouldn't you check and
>>> make sure you got woken up by the right one setting the flag?
>> The wait_event() is conditioned on the specific query (ib_sa_nl_query_sent(query)), not on the wait_queue itself.
> Right, missed that this macro is expends into some inline code.
>
> Looking at the code a little more, I think this also fixes another issue.
> Lets say ib_nl_send_msg() returns an error but before we do the list_del() in
> ib_nl_make_request() there is also a timeout, so in ib_nl_request_timeout()
> we will do list_del() and then another one list_del() will be done in ib_nl_make_request().
>
>>> Other than that, the entire solution makes it very complicated to reason with
>>> (flags set/checked without locking etc) maybe we should just revert and fix it
>>> the other way?
>> The flag could certainly be set under the lock, which may reduce complications.
> Anything that can help here with this.
> For me in ib_nl_make_request() the comment should also explain that not only ib_nl_handle_resolve_resp()
> is waiting for the flag to be set but also ib_nl_request_timeout() and that a timeout can't happen
> before the flag is set.

ib_nl_request_timeout() would re-queue the query to the request list if the flag is not set. 
However, makes sense! Noted, il add the comment in ib_nl_make_request to make things more clear.

Thanks,
Divya

> Mark
>  
>> Kaike
>> i
