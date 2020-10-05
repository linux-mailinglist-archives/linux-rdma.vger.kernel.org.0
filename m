Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6232833F8
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 12:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJEK1v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 06:27:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44544 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgJEK1u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Oct 2020 06:27:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095AO4AD161013;
        Mon, 5 Oct 2020 10:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nilkxz2PQtBNyQd2VtiL15epeapo36pLa5GTEiFXafQ=;
 b=lpSf/KvEXx4PIGg5QInI8Iu3XePFI5PFiQtAjZwy4RYmoK98U4+U85nxqsHR1XncXSPD
 JzVIVGHD+ILlWeGvqqev9kqmz8NsxM0ovDucUpWJ0yARyxXCfEbnGK0TpcOUtvuc/QHS
 YGhu9llX+OJFXjxOMW+PeZoCUOTTkqK2htM1A03woSBvTpu2+oLnhuAKvuR35IEMLcY2
 SxabMb2AazAq0fsCwTIOEZUR7FZVESIjcZMUILuWoIPhpNm7ch1iq5PAq3Ku8Zq7QsMx
 cyW7tpy0Z2lK71cjogup+SFhnBGADwBfhtSjBuI8hiT56oM0fgmJaR96nuhAFOGb+p8L DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33xetamx2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 05 Oct 2020 10:27:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095AOi9w188586;
        Mon, 5 Oct 2020 10:27:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33y36waxw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Oct 2020 10:27:48 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 095ARlx5019586;
        Mon, 5 Oct 2020 10:27:47 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Oct 2020 03:27:47 -0700
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <9f8984ec-31e4-d71e-d55e-5cf115066e96@oracle.com>
 <20200907071819.GL55261@unreal>
 <69fdae5f-5824-9151-0a00-a7453382eee0@oracle.com>
 <20200907090438.GM55261@unreal>
 <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
 <20200907102225.GA421756@unreal>
 <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
 <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
 <20200929174037.GW9916@ziepe.ca>
 <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
 <20201002140445.GJ9916@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
Date:   Mon, 5 Oct 2020 18:27:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002140445.GJ9916@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9764 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9764 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050078
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/2/20 10:04 PM, Jason Gunthorpe wrote:
> On Wed, Sep 30, 2020 at 06:32:28PM +0800, Ka-Cheong Poon wrote:
>> After the aforementioned check on a namespace, what can the client
>> do?  It still needs to use the existing ib_register_client() to
>> register with RDMA subsystem.  And after registration, it will get
>> notifications for all add/remove upcalls on devices not related
>> to the namespace it is interested in.  The client can work around
>> this if there is a supported way to find out the namespace of a
>> device, hence the original proposal of having rdma_dev_to_netns().
> 
> Yes, the client would have to check the netns and abort client
> registration.
> 
> Arguably many of our current clients are wrong in this area since they
> only work on init_net anyhow.
> 
> It would make sense to introduce a rdma_dev_to_netns() and use it to
> block clients on ULPs that use the CM outside init_net.


Will send a simple patch for this.


>> that namespace to use it.  If there are a large number of namespaces,
>> there won't be enough devices to assign to all of them (e.g. the
>> hardware I have access to only supports up to 24 VFs).  The shared
>> mode can be used in this case.  Could you please explain what needs
>> to be done to support a large number of namespaces in exclusive
>> mode?
> 
> Modern HW supports many more than 24 VFs, this is the expected
> interface


Do you have a ballpark on how many VFs are supported?  Is it in
the range of many thousands?

BTW, while the shared mode is still here, can there be a simple
way for a client to find out which mode the RDMA subsystem is using?


>> BTW, if exclusive mode is the future, it may make sense to have
>> something like rdma_[un]register_net_client().
> 
> I don't think we need this
> 
>>>> A new connection comes in and the event handler is called for an
>>>> RDMA_CM_EVENT_CONNECT_REQUEST event.  There is no obvious namespace info regarding
>>>> the event.  It seems that the only way to find out the namespace info is to
>>>> use the context of struct rdma_cm_id.
>>>
>>> The rdma_cm_id has only a single namespace, the ULP knows what it is
>>> because it created it. A listening ID can't spawn new IDs in different
>>> namespaces.
>>
>> The problem is that the handler is not given the listener's
>> rdma_cm_id when it is called.  It is only given the new rdma_cm_id.
> 
> The new cm_id starts with the same ->context as the listener, the ULP should
> use this to pass any data, such as the namespace.


This is what I suspected as mentioned in the previous email.  But
this makes it inconvenient if the context is already used for
something else.


>>> It seems like a ULP error to drive cm_id lifetime entirely from the
>>> per-net stuff.
>>
>> It is not an ULP error.  While there are many reasons to delete
>> a listener, it is not necessary for the listener to die unless the
>> namespace is going away.
> 
> It certainly currently is.
> 
> I'm skeptical ULPs should be doing per-ns stuff like that. A ns aware
> ULP should fundamentally be linked to some FD and the ns to use should
> derived from the process that FD is linked to. Keeping per-ns stuff
> seems wrong.


It is a kernel module.  Which FD are you referring to?  It is
unclear why a kernel module must associate itself with a user
space FD.  Is there a particular reason that rdma_create_id()
needs to behave differently than sock_create_kern() in this
regard?

While discussing about per namespace stuff, what is the reason
that the cma_wq is a global shared by all namespaces instead of
per namespace?  Is there a problem to have a per namespace cma_wq?


-- 
K. Poon
ka-cheong.poon@oracle.com


