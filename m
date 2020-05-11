Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE21CE711
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 23:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbgEKVHS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 17:07:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55204 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbgEKVHS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 17:07:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BL71iA061885;
        Mon, 11 May 2020 21:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=IAJQLbVwVP5lVN0Y4tvhElORwcq/7GVBvYMoChGS9P0=;
 b=GKJ5EedjP3Dlo0z6HOaxnd0AT0iQfG+koP9cVjxuwSqvWOIRFSTuE168QASjdwbGHHyE
 sEuhck3jjNRMTswPwUxM62rY2TZOZQ6wUt6tphXOwyQihWVidpTSmCOWo7FlIkP7mFjB
 llYCVeLJ1SWaWoGyN6ZsjiGIByIRxJkhsEXAegdY7TiTwvVjK+rHFsxh3wY1SDAEnLHH
 VkiFDKN+/OB/AJD74jL5fMEwFF9SJASNeqLH2VnjRBiOhnvFpy8SRd9qtbYlRdf+1GvM
 KMFLSkbRd4fqxykMNeOwIa2QjFNWqJmXvRSdTgzTvpQcCqSu2qYPKOMLfQfiboo1op+v LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30x3mbqh5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 21:07:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BKwEpk068680;
        Mon, 11 May 2020 21:07:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30x69rs11b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 21:07:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04BL76pk022354;
        Mon, 11 May 2020 21:07:06 GMT
Received: from dhcp-10-159-239-226.vpn.oracle.com (/10.159.239.226)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 14:07:05 -0700
Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
To:     "Wan, Kaike" <kaike.wan@intel.com>,
        Mark Bloch <markb@mellanox.com>,
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
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <54a2c84e-1745-cae5-e0b5-4d63013aef32@oracle.com>
Date:   Mon, 11 May 2020 14:06:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <MW3PR11MB4665120FE43314C22A862324F4A50@MW3PR11MB4665.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=11 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=11 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110159
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Thanks for taking the time to review. Please find my comments inline -

On 5/7/20 1:16 PM, Wan, Kaike wrote:
>
>> -----Original Message-----
>> From: Mark Bloch <markb@mellanox.com>
>> Sent: Thursday, May 07, 2020 3:36 PM
>> To: Divya Indi <divya.indi@oracle.com>; linux-kernel@vger.kernel.org; linux-
>> rdma@vger.kernel.org; Jason Gunthorpe <jgg@ziepe.ca>; Wan, Kaike
>> <kaike.wan@intel.com>
>> Cc: Gerd Rausch <gerd.rausch@oracle.com>; Håkon Bugge
>> <haakon.bugge@oracle.com>; Srinivas Eeda <srinivas.eeda@oracle.com>;
>> Rama Nichanamatlu <rama.nichanamatlu@oracle.com>; Doug Ledford
>> <dledford@redhat.com>
>> Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
>>
>>
>>> @@ -1123,6 +1156,18 @@ int ib_nl_handle_resolve_resp(struct sk_buff
>>> *skb,
>>>
>>>  	send_buf = query->mad_buf;
>>>
>>> +	/*
>>> +	 * Make sure the IB_SA_NL_QUERY_SENT flag is set before
>>> +	 * processing this query. If flag is not set, query can be accessed in
>>> +	 * another context while setting the flag and processing the query
>> will
>>> +	 * eventually release it causing a possible use-after-free.
>>> +	 */
>>> +	if (unlikely(!ib_sa_nl_query_sent(query))) {
>> Can't there be a race here where you check the flag (it isn't set) and before
>> you call wait_event() the flag is set and wake_up() is called which means you
>> will wait here forever?
> Should wait_event() catch that? That is,  if the flag is not set, wait_event() will sleep until the flag is set.
>
>  or worse, a timeout will happen the query will be
>> freed and them some other query will call wake_up() and we have again a
>> use-after-free.
> The request has been deleted from the request list by this time and therefore the timeout should have no impact here.
>
>
>>> +		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>>> +		wait_event(wait_queue, ib_sa_nl_query_sent(query));
>> What if there are two queries sent to userspace, shouldn't you check and
>> make sure you got woken up by the right one setting the flag?
> The wait_event() is conditioned on the specific query (ib_sa_nl_query_sent(query)), not on the wait_queue itself.
>
>> Other than that, the entire solution makes it very complicated to reason with
>> (flags set/checked without locking etc) maybe we should just revert and fix it
>> the other way?
> The flag could certainly be set under the lock, which may reduce complications. 

We could use a lock or use atomic operations. However, the reason for not doing so was that
we have 1 writer and multiple readers of the IB_SA_NL_QUERY_SENT flag and the readers 
wouldnt mind reading a stale value. 

Would it still be better to have a lock for this flag? 

Thanks,
Divya

>
> Kaike
>
