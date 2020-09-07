Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8516B2600F9
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgIGQ5E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 12:57:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37156 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbgIGQ5A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 12:57:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 087DjOs9193916;
        Mon, 7 Sep 2020 13:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gl3bwxRirJtPTuVM+wPREJxsFT11EF9883Lv4b6wVfI=;
 b=c/iiP9m568CgIUe0mlMJpDaB3yzowakTdVnjIFACNNAw9gi6KCoh4BRoW+4h+dyMYLht
 YEkUJo29TZw9xf+aNBErRJrMW210n47nQ/Ht0uUMs1DeyJDw4pK26XELl3cujZ4V7MCx
 zuaa0cp+VDBgJnlGpPdAlhLvXmsrTgc5uiEQZ1JY/RN6/vijuILrYBFbqLUwuyJiXYyp
 /qOuuhh6QXNp7Vit/WRWra4JtqXLZEisQlUalk0BKmqVKjNk+tpdGAlAK7dQ9rd7juwY
 Hn4HJ7Gg06b+BOeduTC+dYoDPJmR8zEqW7lB9FXnqkCSZ4mL6CIvgeab/8XATt3ZxFP7 Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 33c23qpv68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Sep 2020 13:48:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 087DfTXa161016;
        Mon, 7 Sep 2020 13:48:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33cmepnppg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Sep 2020 13:48:27 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 087DmPPm030085;
        Mon, 7 Sep 2020 13:48:25 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Sep 2020 06:48:25 -0700
Subject: Re: Finding the namespace of a struct ib_device
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
References: <20200903173910.GO24045@ziepe.ca>
 <a5899aa9-4553-1307-0688-f07f3a919ce8@oracle.com>
 <20200904113244.GP24045@ziepe.ca>
 <be812cb4-4b80-5ee5-4ed8-9d44f0a06edd@oracle.com>
 <20200906074442.GE55261@unreal>
 <9f8984ec-31e4-d71e-d55e-5cf115066e96@oracle.com>
 <20200907071819.GL55261@unreal>
 <69fdae5f-5824-9151-0a00-a7453382eee0@oracle.com>
 <20200907090438.GM55261@unreal>
 <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
 <20200907102225.GA421756@unreal>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
Date:   Mon, 7 Sep 2020 21:48:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907102225.GA421756@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009070135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070135
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/7/20 6:22 PM, Leon Romanovsky wrote:
> On Mon, Sep 07, 2020 at 05:28:23PM +0800, Ka-Cheong Poon wrote:
>> On 9/7/20 5:04 PM, Leon Romanovsky wrote:
>>> On Mon, Sep 07, 2020 at 04:24:26PM +0800, Ka-Cheong Poon wrote:
>>>> On 9/7/20 3:18 PM, Leon Romanovsky wrote:
>>>>> On Mon, Sep 07, 2020 at 11:33:38AM +0800, Ka-Cheong Poon wrote:
>>>>>> On 9/6/20 3:44 PM, Leon Romanovsky wrote:
>>>>>>> On Fri, Sep 04, 2020 at 10:02:10PM +0800, Ka-Cheong Poon wrote:
>>>>>>>> On 9/4/20 7:32 PM, Jason Gunthorpe wrote:
>>>>>>>>> On Fri, Sep 04, 2020 at 12:01:12PM +0800, Ka-Cheong Poon wrote:
>>>>>>>>>> On 9/4/20 1:39 AM, Jason Gunthorpe wrote:
>>>>>>>>>>> On Thu, Sep 03, 2020 at 10:02:01PM +0800, Ka-Cheong Poon wrote:
>>>>>>>>>>>> When a struct ib_client's add() function is called. is there a
>>>>>>>>>>>> supported method to find out the namespace of the passed in
>>>>>>>>>>>> struct ib_device?  There is rdma_dev_access_netns() but it does
>>>>>>>>>>>> not return the namespace.  It seems that it needs to have
>>>>>>>>>>>> something like the following.
>>>>>>>>>>>>
>>>>>>>>>>>> struct net *rdma_dev_to_netns(struct ib_device *ib_dev)
>>>>>>>>>>>> {
>>>>>>>>>>>>              return read_pnet(&ib_dev->coredev.rdma_net);
>>>>>>>>>>>> }
>>>>>>>>>>>>
>>>>>>>>>>>> Comments?
>>>>>>>>>>>
>>>>>>>>>>> I suppose, but why would something need this?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> If the client needs to allocate stuff for the namespace
>>>>>>>>>> related to that device, it needs to know the namespace of
>>>>>>>>>> that device.  Then when that namespace is deleted, the
>>>>>>>>>> client can clean up those related stuff as the client's
>>>>>>>>>> namespace exit function can be called before the remove()
>>>>>>>>>> function is triggered in rdma_dev_exit_net().  Without
>>>>>>>>>> knowing the namespace of that device, coordination cannot
>>>>>>>>>> be done.
>>>>>>>>>
>>>>>>>>> Since each device can only be in one namespace, why would a client
>>>>>>>>> ever need to allocate at a level more granular than a device?
>>>>>>>>
>>>>>>>>
>>>>>>>> A client wants to have namespace specific info.  If the
>>>>>>>> device belongs to a namespace, it wants to associate those
>>>>>>>> info with that device.  When a namespace is deleted, the
>>>>>>>> info will need to be deleted.  You can consider the info
>>>>>>>> as associated with both a namespace and a device.
>>>>>>>
>>>>>>> Can you be more specific about which info you are talking about?
>>>>>>
>>>>>>
>>>>>> Actually, a lot of info can be both namespace and device specific.
>>>>>> For example, a client wants to have a different PD allocation policy
>>>>>> with a device when used in different namespaces.
>>>>>>
>>>>>>
>>>>>>> And what is the client that is net namespace-aware from one side,
>>>>>>> but from another separate data between them "manually"?
>>>>>>
>>>>>>
>>>>>> Could you please elaborate what is meant by "namespace aware from
>>>>>> one side but from another separate data between them manually"?
>>>>>> I understand what namespace aware means.  But it is not clear what
>>>>>> is meant by "separating data manually".  Do you mean having different
>>>>>> behavior in different namespaces?  If this is the case, there is
>>>>>> nothing special here.  An admin may choose to have different behavior
>>>>>> in different namespaces.  There is nothing manual going on in the
>>>>>> client code.
>>>>>
>>>>> We are talking about net-namespaces, and as we wrote above, the ib_device
>>>>> that supports such namespace can exist only in a single one
>>>>>
>>>>> The client that implemented such support can check its namespace while
>>>>> "client->add" is called. It should be equal to be seen by ib_device.
>>>>>
>>>>> See:
>>>>>     rdma_dev_change_netns ->
>>>>>     	enable_device_and_get ->
>>>>> 		add_client_context ->
>>>>> 			client->add(device)
>>>>
>>>>
>>>> This is the original question.  How does the client's add() function
>>>> know the namespace of device?  What is your suggestion in finding
>>>> the net namespace of device at add() time?
>>>
>>> As I wrote above, "It should be equal to be seen by ib_device.", check net
>>> namespace of your client.
>>
>>
>> Could you please be more specific?  A client calls ib_register_client() to
>> register with the RDMA framework.  Then when a device is added, the client's
>> add() function is called with the struct ib_device.  How does the client
>> find out the namespace "seen by the ib_device"?  Do you mean that there is
>> a variant of ib_register_client() which can take a net namespace as parameter?
>> Or is there a variant of struct ib_client which has a net namespace field?
>> Or?  Thanks.
> 
> "Do you mean that there is a variant of ib_register_client()
> which can take a net namespace as parameter?"
> 
> No, it doesn't exist but it is easy to extend and IMHO the right
> thing to do.


This may require a number of changes and the way a client interacts with
the current RDMA framework.  For example, currently a client registers
once using one struct ib_client and gets device notifications for all
namespaces and devices.  Suppose there is rdma_[un]register_net_client(),
it may need to require a client to use a different struct ib_client to
register for each net namespace.  And struct ib_client probably needs to
have a field to store the net namespace.  Probably all those client
interaction functions will need to be modified.  Since the clients xarray
is global, more clients may mean performance implication, such as it takes
longer to go through the whole clients xarray.

There are probably many other subtle changes required.  It may turn out to
be not so straight forward.  Is this community willing the take such changes?
I can take a stab at it if the community really thinks that this is preferred.

Thanks.


-- 
K. Poon
ka-cheong.poon@oracle.com


