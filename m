Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4FD285AA9
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 10:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgJGIk4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 04:40:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54440 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGIkz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 04:40:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0978eAvp055022;
        Wed, 7 Oct 2020 08:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qpjQZyiq3Pi1kHvSn+dmnsCCKlAt4CkINQaol40BmrM=;
 b=E+Bz/zZXwHtGMpCtKlsipgzKBfA7TK/h+j7fkXJbqVyrLGaFUdxHe6FWvu6jKei1Xrng
 kVVKCmBfq8GR7Nooe7o5Yc6b5NhRgqOQw6RBCMIxpqNdknLz1/Ot9k2YjILFnX5oeUsG
 exg7KOEOTdU5TqG6NlmMkEiz4OyRUZ+Fszw4i71o0ER8FShthPk1OanRJ0RUjeo71u2X
 2OgynFkQcgWtAmlkowixsrsTHk/mjGBoZ3X9Kaeo+NqXD5eD/RpqZ46giBAwHv21dSdq
 SEIKVjrKdnMuEsuTS97ApH4BXQqdxd0JcGf91COepJcV3BjSD5MKZ1EzFnNDl628Iciu 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33xetb0kp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 08:40:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0978ZIpI127217;
        Wed, 7 Oct 2020 08:38:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33y2vp7u7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 08:38:54 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0978cqea029262;
        Wed, 7 Oct 2020 08:38:53 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 01:38:52 -0700
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <20200929174037.GW9916@ziepe.ca>
 <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
 <20201002140445.GJ9916@ziepe.ca>
 <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
 <20201005131611.GR9916@ziepe.ca>
 <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
 <20201005142554.GS9916@ziepe.ca>
 <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
 <20201005154548.GT9916@ziepe.ca>
 <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
 <20201006124627.GH5177@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
Date:   Wed, 7 Oct 2020 16:38:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006124627.GH5177@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070059
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/6/20 8:46 PM, Jason Gunthorpe wrote:
> On Tue, Oct 06, 2020 at 05:36:32PM +0800, Ka-Cheong Poon wrote:
> 
>>>>> Kernel modules should not be doing networking unless commanded to by
>>>>> userspace.
>>>>
>>>> It is still not clear why this is an issue with RDMA
>>>> connection, but not with general kernel socket.  It is
>>>> not random networking.  There is a purpose.
>>>
>>> It is a problem with sockets too, how do the socket users trigger
>>> their socket usages? AFAIK all cases originate with userspace
>>
>> A user starts a namespace.  The module is loaded for servicing
>> requests.  The module starts a listener.  The user deletes
>> the namespace.  This scenario will have everything cleaned up
>> properly if the listener is a kernel socket.  This is not the
>> case with RDMA.
> 
> Please point to reputable code in upstream doing this


It is not clear what "reputable" here really means.  If it just
means something in kernel, then nearly all, if not all, Internet
protocols code in kernel create a control kernel socket for every
network namespaces.  That socket is deleted in the per namespace
exit function.  If it explicitly means listening socket, AFS and
TIPC in kernel do that for every namespaces.  That socket is
deleted in the per namespace exit function.

It is very common for a network protocol to have something like
this for protocol processing.  It is not clear why RDMA subsystem
behaves differently and forbids this common practice.  Could you
please elaborate the issues this practice has such that the RDMA
subsystem cannot support it?



-- 
K. Poon
ka-cheong.poon@oracle.com


