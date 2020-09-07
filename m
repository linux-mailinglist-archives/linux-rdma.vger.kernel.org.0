Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2D525F4F9
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgIGIYl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 04:24:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53558 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgIGIYk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 04:24:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0878O4UR087295;
        Mon, 7 Sep 2020 08:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XiDqqsNUytfqbgVV0BtPzZE9hnFY0oe2pv471whbO8U=;
 b=Kg4OfFpWH2qZtIhLAHzO/eGY6xtq/SjRV+oDH1sDdmiOoqY1k2ibTCviymbCXtDA5GMy
 xcTdCY4JoFexXpDECz7Zts39iYUv92bTQpVBS7AGJCG3lIUXJ7jgVNT1PZNGS8LPLYYE
 NgvRJ/w8gB6/0LzFZmJGv2hGfzpZWJ5ffEgRlMcnj5T2YNHLdqs56lsrZASz7z4CU2Yk
 KdpMXx4XSrZApivMpLYHK7f4RGld7Wf1YF3BOZA+QCocAFI+Dl266/DknxxuLq85ypPb
 CBwzoNc6zeX1i9xJ+9Lo2vPI3fChOIcRjdV40w95dDHfkxOIPZPAzG70Ank6aG5v253h 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33c3amn6pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Sep 2020 08:24:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0878KugQ106413;
        Mon, 7 Sep 2020 08:24:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33cmk00e8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Sep 2020 08:24:36 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0878OYlr030992;
        Mon, 7 Sep 2020 08:24:35 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Sep 2020 01:24:34 -0700
Subject: Re: Finding the namespace of a struct ib_device
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
References: <5fa7f367-49df-fb1d-22d0-9f1dd1b76915@oracle.com>
 <20200903173910.GO24045@ziepe.ca>
 <a5899aa9-4553-1307-0688-f07f3a919ce8@oracle.com>
 <20200904113244.GP24045@ziepe.ca>
 <be812cb4-4b80-5ee5-4ed8-9d44f0a06edd@oracle.com>
 <20200906074442.GE55261@unreal>
 <9f8984ec-31e4-d71e-d55e-5cf115066e96@oracle.com>
 <20200907071819.GL55261@unreal>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <69fdae5f-5824-9151-0a00-a7453382eee0@oracle.com>
Date:   Mon, 7 Sep 2020 16:24:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907071819.GL55261@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009070082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070083
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/7/20 3:18 PM, Leon Romanovsky wrote:
> On Mon, Sep 07, 2020 at 11:33:38AM +0800, Ka-Cheong Poon wrote:
>> On 9/6/20 3:44 PM, Leon Romanovsky wrote:
>>> On Fri, Sep 04, 2020 at 10:02:10PM +0800, Ka-Cheong Poon wrote:
>>>> On 9/4/20 7:32 PM, Jason Gunthorpe wrote:
>>>>> On Fri, Sep 04, 2020 at 12:01:12PM +0800, Ka-Cheong Poon wrote:
>>>>>> On 9/4/20 1:39 AM, Jason Gunthorpe wrote:
>>>>>>> On Thu, Sep 03, 2020 at 10:02:01PM +0800, Ka-Cheong Poon wrote:
>>>>>>>> When a struct ib_client's add() function is called. is there a
>>>>>>>> supported method to find out the namespace of the passed in
>>>>>>>> struct ib_device?  There is rdma_dev_access_netns() but it does
>>>>>>>> not return the namespace.  It seems that it needs to have
>>>>>>>> something like the following.
>>>>>>>>
>>>>>>>> struct net *rdma_dev_to_netns(struct ib_device *ib_dev)
>>>>>>>> {
>>>>>>>>            return read_pnet(&ib_dev->coredev.rdma_net);
>>>>>>>> }
>>>>>>>>
>>>>>>>> Comments?
>>>>>>>
>>>>>>> I suppose, but why would something need this?
>>>>>>
>>>>>>
>>>>>> If the client needs to allocate stuff for the namespace
>>>>>> related to that device, it needs to know the namespace of
>>>>>> that device.  Then when that namespace is deleted, the
>>>>>> client can clean up those related stuff as the client's
>>>>>> namespace exit function can be called before the remove()
>>>>>> function is triggered in rdma_dev_exit_net().  Without
>>>>>> knowing the namespace of that device, coordination cannot
>>>>>> be done.
>>>>>
>>>>> Since each device can only be in one namespace, why would a client
>>>>> ever need to allocate at a level more granular than a device?
>>>>
>>>>
>>>> A client wants to have namespace specific info.  If the
>>>> device belongs to a namespace, it wants to associate those
>>>> info with that device.  When a namespace is deleted, the
>>>> info will need to be deleted.  You can consider the info
>>>> as associated with both a namespace and a device.
>>>
>>> Can you be more specific about which info you are talking about?
>>
>>
>> Actually, a lot of info can be both namespace and device specific.
>> For example, a client wants to have a different PD allocation policy
>> with a device when used in different namespaces.
>>
>>
>>> And what is the client that is net namespace-aware from one side,
>>> but from another separate data between them "manually"?
>>
>>
>> Could you please elaborate what is meant by "namespace aware from
>> one side but from another separate data between them manually"?
>> I understand what namespace aware means.  But it is not clear what
>> is meant by "separating data manually".  Do you mean having different
>> behavior in different namespaces?  If this is the case, there is
>> nothing special here.  An admin may choose to have different behavior
>> in different namespaces.  There is nothing manual going on in the
>> client code.
> 
> We are talking about net-namespaces, and as we wrote above, the ib_device
> that supports such namespace can exist only in a single one
> 
> The client that implemented such support can check its namespace while
> "client->add" is called. It should be equal to be seen by ib_device.
> 
> See:
>   rdma_dev_change_netns ->
>   	enable_device_and_get ->
> 		add_client_context ->
> 			client->add(device)


This is the original question.  How does the client's add() function
know the namespace of device?  What is your suggestion in finding
the net namespace of device at add() time?


> "Manual" means that client will store results of first client->add call
> (in init_net NS) and will use globally stored data for other NS, which
> is not netdev way to work with namespaces. The expectation that they are
> separated without shared data between.


It is not clear why client needs to use globally stored data for other
net namespaces.  When an RDMA device is moved from init_net to another net
namespace, the client's remove() function is called first, and then the
client's add() function is called.  If a client can know the net namespace
of a device when add()/remove() is called, it can use namespace specific
data storage.  It does not need to store namespace specific data in a
global store.  The original question is how to find out the net namespace
of a device.



-- 
K. Poon
ka-cheong.poon@oracle.com


