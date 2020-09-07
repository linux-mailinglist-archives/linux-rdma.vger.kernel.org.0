Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B85925F219
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 05:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIGDfx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Sep 2020 23:35:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44664 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgIGDfw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Sep 2020 23:35:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0873YnRJ043332;
        Mon, 7 Sep 2020 03:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GRojt9+0Q4AKuBaVlaNo3WGPnzGQAi1kMP5iRyO4f7c=;
 b=Daco75qiG8BumFK1Jx1V3q+5Sknn43yb/06utyYKIX03CPoarIvYrPf6VHCXE1jVWmg4
 ut49J95mALGWwhaWvEyKU4WW58ebaItbIdXky25+gRkr4Pev2aHhIvXwkZfgF8lDZgqp
 tv34Qhiip9w1v6GHMbI7YhxBmXXpac1cSOCj1Q+56QbvXROqwEprr7F8X91TqgjWn+79
 TJYiWImLkGacL5tIFbdXDa+w/A0qCdr+jYjBz4SQFg4Jg8iUCupKRyBnnq1b1m3nUxXX
 vj2wX3mjGor8rZ17Pn/yRtSRfRncn2mfr2+9AIHmR/nfGW9rawH/q8IMc8OtpoNe7OzY SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mkm7av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Sep 2020 03:35:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0873UsEG084926;
        Mon, 7 Sep 2020 03:33:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33cmjydqgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Sep 2020 03:33:47 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0873Xk2w022047;
        Mon, 7 Sep 2020 03:33:46 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 06 Sep 2020 20:33:46 -0700
Subject: Re: Finding the namespace of a struct ib_device
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
References: <5fa7f367-49df-fb1d-22d0-9f1dd1b76915@oracle.com>
 <20200903173910.GO24045@ziepe.ca>
 <a5899aa9-4553-1307-0688-f07f3a919ce8@oracle.com>
 <20200904113244.GP24045@ziepe.ca>
 <be812cb4-4b80-5ee5-4ed8-9d44f0a06edd@oracle.com>
 <20200906074442.GE55261@unreal>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <9f8984ec-31e4-d71e-d55e-5cf115066e96@oracle.com>
Date:   Mon, 7 Sep 2020 11:33:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200906074442.GE55261@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009070034
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070035
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/6/20 3:44 PM, Leon Romanovsky wrote:
> On Fri, Sep 04, 2020 at 10:02:10PM +0800, Ka-Cheong Poon wrote:
>> On 9/4/20 7:32 PM, Jason Gunthorpe wrote:
>>> On Fri, Sep 04, 2020 at 12:01:12PM +0800, Ka-Cheong Poon wrote:
>>>> On 9/4/20 1:39 AM, Jason Gunthorpe wrote:
>>>>> On Thu, Sep 03, 2020 at 10:02:01PM +0800, Ka-Cheong Poon wrote:
>>>>>> When a struct ib_client's add() function is called. is there a
>>>>>> supported method to find out the namespace of the passed in
>>>>>> struct ib_device?  There is rdma_dev_access_netns() but it does
>>>>>> not return the namespace.  It seems that it needs to have
>>>>>> something like the following.
>>>>>>
>>>>>> struct net *rdma_dev_to_netns(struct ib_device *ib_dev)
>>>>>> {
>>>>>>           return read_pnet(&ib_dev->coredev.rdma_net);
>>>>>> }
>>>>>>
>>>>>> Comments?
>>>>>
>>>>> I suppose, but why would something need this?
>>>>
>>>>
>>>> If the client needs to allocate stuff for the namespace
>>>> related to that device, it needs to know the namespace of
>>>> that device.  Then when that namespace is deleted, the
>>>> client can clean up those related stuff as the client's
>>>> namespace exit function can be called before the remove()
>>>> function is triggered in rdma_dev_exit_net().  Without
>>>> knowing the namespace of that device, coordination cannot
>>>> be done.
>>>
>>> Since each device can only be in one namespace, why would a client
>>> ever need to allocate at a level more granular than a device?
>>
>>
>> A client wants to have namespace specific info.  If the
>> device belongs to a namespace, it wants to associate those
>> info with that device.  When a namespace is deleted, the
>> info will need to be deleted.  You can consider the info
>> as associated with both a namespace and a device.
> 
> Can you be more specific about which info you are talking about?


Actually, a lot of info can be both namespace and device specific.
For example, a client wants to have a different PD allocation policy
with a device when used in different namespaces.


> And what is the client that is net namespace-aware from one side,
> but from another separate data between them "manually"?


Could you please elaborate what is meant by "namespace aware from
one side but from another separate data between them manually"?
I understand what namespace aware means.  But it is not clear what
is meant by "separating data manually".  Do you mean having different
behavior in different namespaces?  If this is the case, there is
nothing special here.  An admin may choose to have different behavior
in different namespaces.  There is nothing manual going on in the
client code.


-- 
K. Poon
ka-cheong.poon@oracle.com


