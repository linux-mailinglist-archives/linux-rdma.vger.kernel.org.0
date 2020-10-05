Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C060C283711
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJEN56 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 09:57:58 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39682 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgJEN55 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Oct 2020 09:57:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095DtEiR190207;
        Mon, 5 Oct 2020 13:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3IlC/RX782DvJVBZqv1YZ3qXuEvicmpJxKJ1vaZhkvw=;
 b=od2Tj4qCJtujy/5m0N+XzBHre+OdJ99mxQumDFYGIHSVV28b2E37gfotuNqHiLpoqLaF
 Ei9J4y6VBuWSbjDNwaZg00QFaRu5K1XGAlFhY/3nBGP2tn32jEMWq6u6lTz4M3owSAaU
 TxYqCOUinB5/7VIhjWdJoQDN433JWjlewIlJF2hIoQ03HQjiWz6TCN04/83j+XZJsEfH
 HfI7JKsa53dZsF/JwMsyxSxIlYB3Zi/+RbAiPXmSAWvZ3n8GwsEHA70HiLBcpxMkIBPQ
 zMfmWV6l22IVd5XgMnGpT2KwFrg1BpwKtMinD6Rpqe4XxuHJvOMTAZW3ozs8SR1oBXke fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33xetansub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 05 Oct 2020 13:57:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095DtCC6049229;
        Mon, 5 Oct 2020 13:57:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33y2vkjm2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Oct 2020 13:57:56 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 095DvtmR027170;
        Mon, 5 Oct 2020 13:57:55 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Oct 2020 06:57:55 -0700
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <69fdae5f-5824-9151-0a00-a7453382eee0@oracle.com>
 <20200907090438.GM55261@unreal>
 <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
 <20200907102225.GA421756@unreal>
 <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
 <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
 <20200929174037.GW9916@ziepe.ca>
 <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
 <20201002140445.GJ9916@ziepe.ca>
 <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
 <20201005131611.GR9916@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
Date:   Mon, 5 Oct 2020 21:57:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005131611.GR9916@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9764 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9764 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050105
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/5/20 9:16 PM, Jason Gunthorpe wrote:
> On Mon, Oct 05, 2020 at 06:27:39PM +0800, Ka-Cheong Poon wrote:
>> On 10/2/20 10:04 PM, Jason Gunthorpe wrote:
>>>> that namespace to use it.  If there are a large number of namespaces,
>>>> there won't be enough devices to assign to all of them (e.g. the
>>>> hardware I have access to only supports up to 24 VFs).  The shared
>>>> mode can be used in this case.  Could you please explain what needs
>>>> to be done to support a large number of namespaces in exclusive
>>>> mode?
>>>
>>> Modern HW supports many more than 24 VFs, this is the expected
>>> interface
>>
>> Do you have a ballpark on how many VFs are supported?  Is it in
>> the range of many thousands?
> 
> Yes
> 
>> BTW, while the shared mode is still here, can there be a simple
>> way for a client to find out which mode the RDMA subsystem is using?
> 
> Return NULL for the namespace


OK, will add that to rdma_dev_to_netns().


>>> The new cm_id starts with the same ->context as the listener, the ULP should
>>> use this to pass any data, such as the namespace.
>>
>> This is what I suspected as mentioned in the previous email.  But
>> this makes it inconvenient if the context is already used for
>> something else.
> 
> Don't see why. the context should be allocated memory, so the ULP can
> put several things lin there.
> 
>>> I'm skeptical ULPs should be doing per-ns stuff like that. A ns aware
>>> ULP should fundamentally be linked to some FD and the ns to use should
>>> derived from the process that FD is linked to. Keeping per-ns stuff
>>> seems wrong.
>>
>>
>> It is a kernel module.  Which FD are you referring to?  It is
>> unclear why a kernel module must associate itself with a user
>> space FD.  Is there a particular reason that rdma_create_id()
>> needs to behave differently than sock_create_kern() in this
>> regard?
> 
> Somehow the kernel module has to be commanded to use this namespace,
> and generally I expect that command to be connected to FD.


It is an unnecessary restriction on what a kernel module
can do.  Is it a problem if a kernel module initiates its
own RDMA connection for doing various stuff in a namespace?
Any kernel module can initiate a TCP connection to do various
stuff without worrying about namespace deletion problem.  It
does not cause a problem AFAICT.  If the module needs to make
sure that the namespace does not go away, it can add its own
reference.  Is there a particular reason that RDMA subsystem
needs to behave differently?


> We don't have many use cases where the kernel operates namespaces
> independently..


FWIW, I am adding code to do that.  It works fine using
TCP kernel socket.  It has the namespace deletion problem
with RDMA connection.


>> While discussing about per namespace stuff, what is the reason
>> that the cma_wq is a global shared by all namespaces instead of
>> per namespace?  Is there a problem to have a per namespace cma_wq?
> 
> Why would we want to do that?


For scalability and namespace separation reasons as cma_wq is
single threaded.  For example, there can be many work to be done
in one namespace.  But this should not have an adverse effect on
other namespaces (as long as there are resources available).


-- 
K. Poon
ka-cheong.poon@oracle.com


