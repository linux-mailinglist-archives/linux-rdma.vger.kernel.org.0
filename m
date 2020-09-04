Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8425DAE5
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgIDOEY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 10:04:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45386 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730496AbgIDOEW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Sep 2020 10:04:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084E4FRh079032;
        Fri, 4 Sep 2020 14:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=o+Knbr3aSaiJzMkSTH2PN7Lrt4gyqRKlMIJELwp82jg=;
 b=Ye3pbd71XHD3oUJc2A9RxKTOghozikUVamYgqlrjUrFoqmA0EBq+dtMLYbH/i9bQsMhB
 Fd6DzPyncIsSoNx38x2Eykf0Qs3Fn3PWTyk4qnk//7wOcabhb3r+mDq6/w0GH1WErgWr
 DtzXiDbInCWDgQgRG+3qznjagUeuXtTH3igv8AInHbUKqhEwpJPacDm/C/R7ySPkv1QF
 arAeqivwmdXvuIGahEDElhLzoUgJy5tK1Gs7tKBWdzN9quOk2lOuhtXOs/b5NUAItz5y
 4pzekurL8goXGU6CTAxox07ZM00iybQ7tMbxeQuL/BXZk/aeWhcp3e3dEjM7mln716qJ 8g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eympkr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 14:04:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084E1CmD053673;
        Fri, 4 Sep 2020 14:02:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33bhs4g662-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 14:02:14 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084E2DKU017447;
        Fri, 4 Sep 2020 14:02:13 GMT
Received: from [10.159.211.29] (/10.159.211.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 07:02:12 -0700
Subject: Re: Finding the namespace of a struct ib_device
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <5fa7f367-49df-fb1d-22d0-9f1dd1b76915@oracle.com>
 <20200903173910.GO24045@ziepe.ca>
 <a5899aa9-4553-1307-0688-f07f3a919ce8@oracle.com>
 <20200904113244.GP24045@ziepe.ca>
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Organization: Oracle Corporation
Message-ID: <be812cb4-4b80-5ee5-4ed8-9d44f0a06edd@oracle.com>
Date:   Fri, 4 Sep 2020 22:02:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904113244.GP24045@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040129
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/4/20 7:32 PM, Jason Gunthorpe wrote:
> On Fri, Sep 04, 2020 at 12:01:12PM +0800, Ka-Cheong Poon wrote:
>> On 9/4/20 1:39 AM, Jason Gunthorpe wrote:
>>> On Thu, Sep 03, 2020 at 10:02:01PM +0800, Ka-Cheong Poon wrote:
>>>> When a struct ib_client's add() function is called. is there a
>>>> supported method to find out the namespace of the passed in
>>>> struct ib_device?  There is rdma_dev_access_netns() but it does
>>>> not return the namespace.  It seems that it needs to have
>>>> something like the following.
>>>>
>>>> struct net *rdma_dev_to_netns(struct ib_device *ib_dev)
>>>> {
>>>>          return read_pnet(&ib_dev->coredev.rdma_net);
>>>> }
>>>>
>>>> Comments?
>>>
>>> I suppose, but why would something need this?
>>
>>
>> If the client needs to allocate stuff for the namespace
>> related to that device, it needs to know the namespace of
>> that device.  Then when that namespace is deleted, the
>> client can clean up those related stuff as the client's
>> namespace exit function can be called before the remove()
>> function is triggered in rdma_dev_exit_net().  Without
>> knowing the namespace of that device, coordination cannot
>> be done.
> 
> Since each device can only be in one namespace, why would a client
> ever need to allocate at a level more granular than a device?


A client wants to have namespace specific info.  If the
device belongs to a namespace, it wants to associate those
info with that device.  When a namespace is deleted, the
info will need to be deleted.  You can consider the info
as associated with both a namespace and a device.


-- 
K. Poon
ka-cheong.poon@oracle.com


