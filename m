Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF5D2838EE
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 17:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgJEPEa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 11:04:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57416 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgJEPE3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Oct 2020 11:04:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095F3pKt027246;
        Mon, 5 Oct 2020 15:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ekSsWfcX6Pkhw5Yh5V8zJxeTtuv0E1eBp8Tw8uTRt6A=;
 b=h9wAx+PBOCB8lUOwgo4uEJ6Iy6AhwRS1uq5BeQgUbYYJ7agc7TaiOGA0QV4QCHikDEVh
 eekcPrdC4u/ir7ZHnICvKaUFWe5qArRnIEQ2CLODkSPJVkt/IcuzxcL7imBS8n70dxDh
 6eBJyVgIyJsrcRbFH2XMzc7poJ8wPXMiCeIJyrz76cZfRBU+fdciu8tfvuPvBmYqTKck
 +/wxqLbxh0vboBrTschbfPdCJF+N/HnuNr+Lq2DbuCogyGkYgrMaDnzHzlNu+yUZ2rRQ
 KCHdrjs9U5f8tpmDCJHA9zlqmnp/1Yn0deC4Fv+VVhc7I2zG91Babqh5M2BJ0eW9XTt1 AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33ym34b40k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 05 Oct 2020 15:04:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095F04jd194004;
        Mon, 5 Oct 2020 15:02:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33y37vdche-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Oct 2020 15:02:27 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 095F2QgS013434;
        Mon, 5 Oct 2020 15:02:27 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Oct 2020 08:02:26 -0700
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
 <20200907102225.GA421756@unreal>
 <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
 <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
 <20200929174037.GW9916@ziepe.ca>
 <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
 <20201002140445.GJ9916@ziepe.ca>
 <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
 <20201005131611.GR9916@ziepe.ca>
 <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
 <20201005142554.GS9916@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
Date:   Mon, 5 Oct 2020 23:02:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005142554.GS9916@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9764 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9764 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050115
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/5/20 10:25 PM, Jason Gunthorpe wrote:
> On Mon, Oct 05, 2020 at 09:57:47PM +0800, Ka-Cheong Poon wrote:
>>>> It is a kernel module.  Which FD are you referring to?  It is
>>>> unclear why a kernel module must associate itself with a user
>>>> space FD.  Is there a particular reason that rdma_create_id()
>>>> needs to behave differently than sock_create_kern() in this
>>>> regard?
>>>
>>> Somehow the kernel module has to be commanded to use this namespace,
>>> and generally I expect that command to be connected to FD.
>>
>>
>> It is an unnecessary restriction on what a kernel module
>> can do.  Is it a problem if a kernel module initiates its
>> own RDMA connection for doing various stuff in a namespace?
> 
> Yes, someone has to apply policy to authorize this. Kernel modules
> randomly running around using security objects is not OK.


The policy is to allow this.  It is not random stuff.
Can the RDMA subsystem support it?


> Kernel modules should not be doing networking unless commanded to by
> userspace.


It is still not clear why this is an issue with RDMA
connection, but not with general kernel socket.  It is
not random networking.  There is a purpose.


>> Any kernel module can initiate a TCP connection to do various
>> stuff without worrying about namespace deletion problem.  It
>> does not cause a problem AFAICT.  If the module needs to make
>> sure that the namespace does not go away, it can add its own
>> reference.  Is there a particular reason that RDMA subsystem
>> needs to behave differently?
> 
> We don't have those kinds of ULPs.


So if the reason of the current rdma_create_id() behavior
is that there is no such user, I am adding one.  It should
be clear that this difference between kernel socket and
rdma_create_id() causes a problem in namespace handling.


>> For scalability and namespace separation reasons as cma_wq is
>> single threaded.  For example, there can be many work to be done
>> in one namespace.  But this should not have an adverse effect on
>> other namespaces (as long as there are resources available).
> 
> This is a design issue of the cma_wq, it can be reworked to not need
> single threaded, nothing to do with namespaces


As mentioned, there are at least two parts.  The above is
on scalability.  There is also the namespace separation reason.
The goal is to make sure that processing of one namespace
should not have unwanted (positive nor negative) effect on
processing of other namespaces.  If the cma_wq is re-designed,
number of namespaces should be one input parameter on creating
how many threads and other resources allocation/scheduling.
One cma_wq per namespace is the simplest allocation.


-- 
K. Poon
ka-cheong.poon@oracle.com


