Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70B284973
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgJFJgo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 05:36:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46574 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgJFJgn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 05:36:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0969Tb6R008216;
        Tue, 6 Oct 2020 09:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8n1+ecsESoWr9ySE4tP6FMIllrRLEjDpu/WvsOpQasU=;
 b=f3hkVf1cVkeR/X98qzc+Nonx4pNx3OoHzyvKdJyBObSvaiLTHbq4xyB/hnkFdedUm958
 R+zFVpOOfQyj6uADZHTaAlaEpHSjRclyh0ZPXaDFE21MLnme52dUxUxeBYlKuflB0j/O
 69tnzWsljvJO76ensmxcZaNA0fEQcq2TPhyBztwRb1RCK767/u/53TY8HQ0VIMLozDpE
 Lk/tvRhyqNhkpTauoI8czD30m8WKnorh9KaSYiNHhLhfvK8LCikSAPDpEb0Jf9VN4cJG
 WjLObkZ9pEvtxVGan+8ISwIGCqAAmSEjC+Cl8Fpyj9g/p+eOGpdsc0bfFWzsoEsB5XCe 6Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33xhxmtxj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Oct 2020 09:36:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0969VTTo193429;
        Tue, 6 Oct 2020 09:36:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33y2vmr83b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 09:36:41 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0969aeap015360;
        Tue, 6 Oct 2020 09:36:40 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 02:36:39 -0700
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
 <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
 <20200929174037.GW9916@ziepe.ca>
 <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
 <20201002140445.GJ9916@ziepe.ca>
 <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
 <20201005131611.GR9916@ziepe.ca>
 <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
 <20201005142554.GS9916@ziepe.ca>
 <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
 <20201005154548.GT9916@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
Date:   Tue, 6 Oct 2020 17:36:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005154548.GT9916@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060060
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/5/20 11:45 PM, Jason Gunthorpe wrote:
> On Mon, Oct 05, 2020 at 11:02:18PM +0800, Ka-Cheong Poon wrote:
>> On 10/5/20 10:25 PM, Jason Gunthorpe wrote:
>>> On Mon, Oct 05, 2020 at 09:57:47PM +0800, Ka-Cheong Poon wrote:
>>>>>> It is a kernel module.  Which FD are you referring to?  It is
>>>>>> unclear why a kernel module must associate itself with a user
>>>>>> space FD.  Is there a particular reason that rdma_create_id()
>>>>>> needs to behave differently than sock_create_kern() in this
>>>>>> regard?
>>>>>
>>>>> Somehow the kernel module has to be commanded to use this namespace,
>>>>> and generally I expect that command to be connected to FD.
>>>>
>>>>
>>>> It is an unnecessary restriction on what a kernel module
>>>> can do.  Is it a problem if a kernel module initiates its
>>>> own RDMA connection for doing various stuff in a namespace?
>>>
>>> Yes, someone has to apply policy to authorize this. Kernel modules
>>> randomly running around using security objects is not OK.
>>
>> The policy is to allow this.  It is not random stuff.
>> Can the RDMA subsystem support it?
> 
> allow everything is not a policy


It is not allowing everything.  It is the simple case that
a kernel module can have a listener without the namespace
issue.  Kernel socket does not have this problem.


>>> Kernel modules should not be doing networking unless commanded to by
>>> userspace.
>>
>> It is still not clear why this is an issue with RDMA
>> connection, but not with general kernel socket.  It is
>> not random networking.  There is a purpose.
> 
> It is a problem with sockets too, how do the socket users trigger
> their socket usages? AFAIK all cases originate with userspace


A user starts a namespace.  The module is loaded for servicing
requests.  The module starts a listener.  The user deletes
the namespace.  This scenario will have everything cleaned up
properly if the listener is a kernel socket.  This is not the
case with RDMA.


>> So if the reason of the current rdma_create_id() behavior
>> is that there is no such user, I am adding one.  It should
>> be clear that this difference between kernel socket and
>> rdma_create_id() causes a problem in namespace handling.
> 
> It would be helpful to understand how that works, as I've said I don't
> think a kernel module should open listening sockets/cm_ids on every
> namespace without being told to do this.


The issue is not about starting a listener.  The issue is on
namespace deletion.




-- 
K. Poon
ka-cheong.poon@oracle.com


