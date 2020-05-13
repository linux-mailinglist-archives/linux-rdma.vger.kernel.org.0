Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5D71D2094
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 23:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgEMVCw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 17:02:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57436 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgEMVCw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 17:02:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DKrGE5066369;
        Wed, 13 May 2020 21:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/3boRfPP9/nbgsqYwmPrKIYlI9iF/ok9lCvoAeyY0C8=;
 b=oeTy6T3zpL4mid5izCz7pT+UpH2DE7F4GbmYlPnijWMIOmwl1oLne/oN8vZWIXNpwjqd
 BOfjNNdQnghQVw32Y/8iDTTBJF5tQjKg8y2+AHV+myeNNb4vueg+1X0uKlF3NXoxjO/T
 ekycOEODQ2IFMlRLc4iT774jd8MWSg8/OZ8yTtCyGdNaKj3WGtaELuumPpwdcYNRp02C
 tKs/mxGz/G3trHiYHz+eh9PIRCY3rehwMfJHlUfPy5eVTP+JCIEPshTB0pKvsktVgp04
 S73lasR+gRwRsXIl8YtzYsLKwK9psYtPLUboRfxnJbADGsAW5qRKYrzEOj9Pk4zusm+R Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3100xwes3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 21:02:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DL2avo119257;
        Wed, 13 May 2020 21:02:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3100ymv2q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 21:02:46 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DL2juF006783;
        Wed, 13 May 2020 21:02:45 GMT
Received: from dhcp-10-159-252-198.vpn.oracle.com (/10.159.252.198)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 14:02:45 -0700
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
 <33fc99e2-e9fc-3c8c-e47f-41535f514c2d@oracle.com>
 <20200513150021.GD29989@ziepe.ca>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <c761da30-3663-4932-dd72-3501f15c0197@oracle.com>
Date:   Wed, 13 May 2020 14:02:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513150021.GD29989@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=11
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=11 mlxlogscore=999 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130177
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Please find my comments inline - 

On 5/13/20 8:00 AM, Jason Gunthorpe wrote:
> On Mon, May 11, 2020 at 02:26:30PM -0700, Divya Indi wrote:
>>>> @@ -1123,6 +1156,18 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
>>>>  
>>>>  	send_buf = query->mad_buf;
>>>>  
>>>> +	/*
>>>> +	 * Make sure the IB_SA_NL_QUERY_SENT flag is set before
>>>> +	 * processing this query. If flag is not set, query can be accessed in
>>>> +	 * another context while setting the flag and processing the query will
>>>> +	 * eventually release it causing a possible use-after-free.
>>>> +	 */
>>> This comment doesn't really make sense, flags insige the memory being
>>> freed inherently can't prevent use after free.
>> I can definitely re-phrase here to make things clearer. But, the idea here is
>> in the unlikely/rare case where a response for a query comes in before the flag has been
>> set in ib_nl_make_request, we want to wait for the flag to be sent before proceeding. 
>> The response handler will eventually release the query so this wait avoids that if the flag has not been set
>> else 
>> 	"query->flags |= IB_SA_NL_QUERY_SENT;" 
>> will be accessing a query which was freed due to the above mentioned race.
>>
>> It is unlikely since getting a response => We have actually sent out the query to ibacm.
>>
>> How about this -
>>
>> "Getting a response is indicative of having sent out the query, but in an unlikely race when 
>> the response comes in before setting IB_SA_NL_QUERY_SENT, we need to wait till the flag is set to
>> avoid accessing a query that has been released."
> It still makes no sense, a flag that is set before freeing the memory
> is fundamentally useless to prevent races.

Here the race is -

1. ib_nl_send_msg()
2. query->flags |= IB_SA_NL_QUERY_SENT
3. return;

-------------

response_handler() {
wait till flag is set.
....
kfree(query);

}

Here, if the response handler was called => Query was sent
and flag should have been set. However if response handler kicks in
before line 2, we want to wait and make sure the flag is set and
then free the query.

Ideally after ib_nl_send_msg, we should not be accessing the query
because we can be getting a response/timeout asynchronously and cant be
sure when. 

The only places we access a query after it is successfully sent [response handler getting called
=> sending was successful] -
1. ib_nl_request_timeout
2. While setting the flag.

1. is taken care of because the request list access is protected by a lock
and whoever gets the lock first deletes it from the request list and
hence we can only have the response handler OR the timeout handler operate on the
query.

2. To handle this is why we wait in the response handler. Once the flag is
set we are no longer accessing the query and hence safe to release it.

I have modified the comment for v2 as follows -

      /*
+        * In case of a quick response ie when a response comes in before
+        * setting IB_SA_NL_QUERY_SENT, we can have an unlikely race where the
+        * response handler will release the query, but we can still access the
+        * freed query while setting the flag.
+        * Hence, before proceeding and eventually releasing the query -
+        * wait till the flag is set. The flag should be set soon since getting
+        * a response is indicative of having successfully sent the query.
+        */


Thanks,
Divya

>
> Jason
