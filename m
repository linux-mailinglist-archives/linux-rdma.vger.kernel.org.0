Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7A3628AF
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 20:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389249AbfGHSse (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 14:48:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41134 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbfGHSse (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 14:48:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x68IhsaO030527;
        Mon, 8 Jul 2019 18:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9L+6tNo6/Js/Fs+4rHNN6VA6XVt717PhOqy1iR6GuTg=;
 b=iKTnDohQ0owkh/1YSZxfbGThctmkgoarMRF073cvJ0mgkoe75xLPdWrdcACD44FRVaPd
 0/s+Ohw4TnbwqRmpJMprfHHOa9U1lGrEmYs6sbwPpTEhFFjbs/BWPsUNoQHr+3mDWAE3
 8mKx0fMJf/ovlBFSQNorfNnDjYtouk5Gfk/YG1hQA4kLR+iXhFNoTAlN82mU6o1j8nVs
 QfamXZZmm2MbAmz6e9FBocoJbkY7ZY2hiafaht3AywRvyl7n8b/h50OnroShsgrKQu43
 1y8Z3an9KwSoIwHvhIgMxZi5AIbiO4CFuQreMvFz3Hwv1OsoK6PYMrhFg4yQdhxJbPNN hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tjk2tg6ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 18:47:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x68Ilf27061727;
        Mon, 8 Jul 2019 18:47:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tjkf2btpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 18:47:43 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x68IlgYt029228;
        Mon, 8 Jul 2019 18:47:42 GMT
Received: from [10.65.147.235] (/10.65.147.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jul 2019 11:47:42 -0700
Subject: Re: [PATCH v3] RDMA/core: Fix race when resolving IP address
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1562584584-13132-1-git-send-email-dag.moxnes@oracle.com>
 <20190708175025.GA6976@ziepe.ca>
From:   Dag Moxnes <dag.moxnes@oracle.com>
Message-ID: <4b9ae7b8-310c-e0b6-7a8e-33e6d5bef83d@oracle.com>
Date:   Mon, 8 Jul 2019 20:47:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708175025.GA6976@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907080233
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080232
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Jason,

Regards,
Dag

Den 08.07.2019 19:50, skrev Jason Gunthorpe:
> On Mon, Jul 08, 2019 at 01:16:24PM +0200, Dag Moxnes wrote:
>> Use neighbour lock when copying MAC address from neighbour data struct
>> in dst_fetch_ha.
>>
>> When not using the lock, it is possible for the function to race with
>> neigh_update, causing it to copy an invalid MAC address.
>>
>> It is possible to provoke this error by calling rdma_resolve_addr in a
>> tight loop, while deleting the corresponding ARP entry in another tight
>> loop.
>>
>> This will cause the race shown it the following sample trace:
>>
>> rdma_resolve_addr()
>>    rdma_resolve_ip()
>>      addr_resolve()
>>        addr_resolve_neigh()
>>          fetch_ha()
>>            dst_fetch_ha()
>>              n->nud_state == NUD_VALID
> It isn't nud_state that is the problem here, it is the parallel
> memcpy's onto ha. I fixed the commit message
>
> This could also have been solved by using the ha_lock, but I don't
> think we have a reason to particularly over-optimize this.
>
>>   drivers/infiniband/core/addr.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
> Applied to for-next, thanks
>
> Jason

