Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1120527E6B3
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 12:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgI3Kck (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 06:32:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48218 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3Kck (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Sep 2020 06:32:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAQ1Bi121843;
        Wed, 30 Sep 2020 10:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DYQ+8Ip/Vf3XxRn/i7dVq//uv5Q3Tz6/2xGMMpSs5Y8=;
 b=Dk77wjpJfEfYESZEGFwR62uHPyBI1k4VvZJxVUAyQWKmULXV3wV1B/Az64mHz4eSOUiI
 BOSfFytEIOOZ76pGAa5iswj/7bskjsNnhv6J7NkcvyDxXmjHJmbW4I1iC/g5xGTpajjc
 yMp2SATaVZXr7crutm/wrqpcjU1nw9+ZvM18f8Pv+8MSExu64Sx1oMviO0MYz6FKxq+n
 yJx/EI8k5F6ocGVjAirTI0Rz98ilbgjLJGDxBfjt6DsUAJSJuiP0GkzmTKOIRCX5tibm
 1+LhzfByArBDPxSLWSLKF7EE0UPinLBFM1eAk+CQSVtGPUaJf35IKzOxT2nu0vyKzvsn 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33su5ayu8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 10:32:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAOspu115173;
        Wed, 30 Sep 2020 10:32:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33uv2f5uku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 10:32:38 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UAWapA008079;
        Wed, 30 Sep 2020 10:32:37 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Sep 2020 03:32:36 -0700
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <be812cb4-4b80-5ee5-4ed8-9d44f0a06edd@oracle.com>
 <20200906074442.GE55261@unreal>
 <9f8984ec-31e4-d71e-d55e-5cf115066e96@oracle.com>
 <20200907071819.GL55261@unreal>
 <69fdae5f-5824-9151-0a00-a7453382eee0@oracle.com>
 <20200907090438.GM55261@unreal>
 <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
 <20200907102225.GA421756@unreal>
 <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
 <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
 <20200929174037.GW9916@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
Date:   Wed, 30 Sep 2020 18:32:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929174037.GW9916@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300083
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/30/20 1:40 AM, Jason Gunthorpe wrote:
> On Wed, Sep 30, 2020 at 12:57:48AM +0800, Ka-Cheong Poon wrote:
>> On 9/7/20 9:48 PM, Ka-Cheong Poon wrote:
>>
>>> This may require a number of changes and the way a client interacts with
>>> the current RDMA framework.  For example, currently a client registers
>>> once using one struct ib_client and gets device notifications for all
>>> namespaces and devices.  Suppose there is rdma_[un]register_net_client(),
>>> it may need to require a client to use a different struct ib_client to
>>> register for each net namespace.  And struct ib_client probably needs to
>>> have a field to store the net namespace.  Probably all those client
>>> interaction functions will need to be modified.  Since the clients xarray
>>> is global, more clients may mean performance implication, such as it takes
>>> longer to go through the whole clients xarray.
>>>
>>> There are probably many other subtle changes required.  It may turn out to
>>> be not so straight forward.  Is this community willing the take such changes?
>>> I can take a stab at it if the community really thinks that this is preferred.
>>
>>
>> Attached is a diff of a prototype for the above.  This exercise is
>> to see what needs to be done to have a more network namespace aware
>> interface for RDMA client registration.
> 
> An RDMA device is either in all namespaces or in a single
> namespace. If a client has some interest in only some namespaces then
> it should check the namespace during client registration and not
> register if it isn't interested. No need to change anything in the
> core code.


After the aforementioned check on a namespace, what can the client
do?  It still needs to use the existing ib_register_client() to
register with RDMA subsystem.  And after registration, it will get
notifications for all add/remove upcalls on devices not related
to the namespace it is interested in.  The client can work around
this if there is a supported way to find out the namespace of a
device, hence the original proposal of having rdma_dev_to_netns().


>> Is the RDMA shared namespace mode the preferred mode to use as it is the
>> default mode?
> 
> Shared is the legacy mode, modern systems should switch to namespace
> mode at early boot


Thanks for the clarification.  I originally thought that the shared
mode was for supporting a large number of namespaces.  In the
exclusive mode, a device needs to be assigned to a namespace for
that namespace to use it.  If there are a large number of namespaces,
there won't be enough devices to assign to all of them (e.g. the
hardware I have access to only supports up to 24 VFs).  The shared
mode can be used in this case.  Could you please explain what needs
to be done to support a large number of namespaces in exclusive
mode?

BTW, if exclusive mode is the future, it may make sense to have
something like rdma_[un]register_net_client().


>> Is it expected that a client knows the running mode before
>> interacting with the RDMA subsystem?
> 
> Why would a client care?


Because it may want to behave differently.  For example, in shared
mode, it may want to create shadow device structure to hold per
namespace info for a device.  But in exclusive mode, a device can
only be in one namespace, there is no need to have such shadow
device structure.


>> Is a client not supposed to differentiate different namespaces?
> 
> None do today.


This is probably the case as calling rdma_create_id() in kernel can
disallow a namespace to be deleted.  There must be no client doing
that right now.  My code is using RDMA in a namespace, hence I'd
like to understand more about the RDMA subsystem's namespace support.
For example, what is the reason that the cma_wq is a global queue
shared by all namespaces instead of per namespace?  Is it expected
that the work load will be low enough for all namespaces such that
they will not interfere with each other?


>> A new connection comes in and the event handler is called for an
>> RDMA_CM_EVENT_CONNECT_REQUEST event.  There is no obvious namespace info regarding
>> the event.  It seems that the only way to find out the namespace info is to
>> use the context of struct rdma_cm_id.
> 
> The rdma_cm_id has only a single namespace, the ULP knows what it is
> because it created it. A listening ID can't spawn new IDs in different
> namespaces.


The problem is that the handler is not given the listener's
rdma_cm_id when it is called.  It is only given the new rdma_cm_id.
Do you mean that there is a way to find out the listener's rdma_cm_id
given the new rdma_cm_id?  But even if the listener's rdma_cm_id can
be found, what is the mechanism to find out the namespace of that
listener's namespace in the handler?  The client may compare that
pointer with every listeners it creates.  Is there a better way?


>> (*) Note that in __rdma_create_id(), it does a get_net(net) to put a
>>      reference on a namespace.  Suppose a kernel module calls rdma_create_id()
>>      in its namespace .init function to create an RDMA listener and calls
>>      rdma_destroy_id() in its namespace .exit function to destroy it.
> 
> Yes, namespaces remain until all objects touching them are deleted.
> 
> It seems like a ULP error to drive cm_id lifetime entirely from the
> per-net stuff.


It is not an ULP error.  While there are many reasons to delete
a listener, it is not necessary for the listener to die unless the
namespace is going away.


> This would be similar to creating a socket in the kernel.


Right and a kernel socket does not prevent a namespace to be deleted.


>>      __rdma_create_id() adds a reference to a namespace, when a sys admin
>>      deletes a namespace (say `ip netns del ...`), the namespace won't be
>>      deleted because of this reference.  And the module will not release this
>>      reference until its .exit function is called only when the namespace is
>>      deleted.  To resolve this issue, in the diff (in __rdma_create_id()), I
>>      did something similar to the kern check in sk_alloc().
> 
> What you are running into is there is no kernel user of net
> namespaces, all current ULPs exclusively use the init_net.
> 
> Without an example of what that is supposed to be like it is hard to
> really have a discussion. You should reference other TCP in the kernel
> to see if someone has figured out how to make this work for TCP. It
> should be basically the same.


The kern check in sk_alloc() decides whether to hold a reference on
the namespace.  What is in the diff follows the same mechanism.


-- 
K. Poon
ka-cheong.poon@oracle.com


