Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9C1D41CE
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 01:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgENXoP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 19:44:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40074 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgENXoP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 May 2020 19:44:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04ENav25022912;
        Thu, 14 May 2020 23:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4VSSVYFMtKB6nhuT4ys68cZ+quQNnBan4qG3X81aHWE=;
 b=K1ymOkpu6dFTbnyILU5YoJeXa0iJ1TopyH551DJAjPcmtXv+VOWUtImcjbAy0vVW+tsz
 dA0TW2A0ByNd0o2RoZlJjDJT8LQmXVxgLWCK/W263a8UAVgh9Oi9J6VeVp1yFWHwi1gW
 /xCUf8eydfi4Vw4LSn6dLTGq95XwocUBNhQoJ6MA38gY9oJovcj2EAePu5FUxBcNm+Qz
 K3GR+KF1VafuAygheM/6O88vfWAueAN2YQpMmwA5lI4METoaDzxiXc8VNZxOg5l2n30j
 xb0nC63ur4SlxfzYCfdt0uL56Em9OOYOjBQZb5ZWGlSJNBrx5BultKyUv/52Rg4mm6VP KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3100yg5qby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 23:43:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04ENc801029208;
        Thu, 14 May 2020 23:41:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3100ydm0e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 23:41:55 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04ENfqYn016817;
        Thu, 14 May 2020 23:41:52 GMT
Received: from [10.74.106.88] (/10.74.106.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 May 2020 16:41:52 -0700
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     Sagi Grimberg <sagi@grimberg.me>,
        Aron Silverton <aron.silverton@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     bvanassche@acm.org, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        israelr@mellanox.com, shlomin@mellanox.com
References: <20200514120305.189738-1-maxg@mellanox.com>
 <905E7E0C-1F87-4552-A7E3-5C49EDBED138@oracle.com>
 <5c48f60b-23b7-da64-6f37-f52de7bb625d@oracle.com>
 <479add48-6fdb-f925-c3b9-699c6aa4cfbf@grimberg.me>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <0ea6349f-1915-3493-3bd7-0bc8086c5b66@oracle.com>
Date:   Thu, 14 May 2020 16:41:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <479add48-6fdb-f925-c3b9-699c6aa4cfbf@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=2 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=2 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005140201
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/14/20 3:23 PM, Sagi Grimberg wrote:
> 
>>> +Santosh
>>>
>>> You probably meant to copy the RDS maintainer? Not sure if this 
>>> should have
>>> also been sent to netdev@vger.kernel.org.
>>>
>> Thanks Aron.
>>
>>>
>>>> On May 14, 2020, at 7:02 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>>>>
>>>> This series removes the support for FMR mode to register memory. 
>>>> This ancient
>>>> mode is unsafe and not maintained/tested in the last few years. It 
>>>> also doesn't
>>>> have any reasonable advantage over other memory registration methods 
>>>> such as
>>>> FRWR (that is implemented in all the recent RDMA adapters). This 
>>>> series should
>>>> be reviewed and approved by the maintainer of the effected drivers 
>>>> and I
>>>> suggest to test it as well.
>>>>
>> I know the security issue has been brought up before and this plan of 
>> removal of FMR support was on the cards
> 
> Actually, what is unsafe is not necessarily fmrs, but rather the
> fmr_pool interface. So Max, you can keep fmr if rds wants it, but
> we can get rid of fmr pools.
>
Good point. We aren't using the fmr_pools.

>> but on RDS at least on CX3 we
>> got more throughput with FMR vs FRWR. And the reasons are well
>> understood as well why its the case.
> 
> Looking at the rds code, it seems that rds doesn't do any fast
> registration at all, rkeys are long lived and are only invalidated (or
> unmaped) when need recycling or when a socket is torn down...
> 
> So I'm not clear exactly about the model here, but seems to me
> its almost like rds needs something like phys_mr, which is static for
> all of its lifetime. It seems that fmrs just create a hassle for
> rds, unless I'm missing something...
> 
> Having said that, it surely isn't the most secure behavior...
> At least its not the global dma rkey...
>
There are couple of layers but you can see the FRWR code inside,
net/rds/ib_frmr.c. The MR allocation as well as free/invalidation
is managed from user-land instead of ULP data path. There are
couple of cases where some use_once semantics does MR invalidation
within kernel but thats only because userland indicated that MR
key can be invalidated after issued RDMA ops is complete.

>> Is it possible to keep core support still around so that HCA's which
>> supports FMR, ULPs can still can leverage it if they want.
>>  From RDS perspective, if the HCA like CX3 doesn't support both modes,
>> code prefers FMR vs FRWR and hence the question.
> 
> Max can start by removing fmr_pools, fmrs can stay as there is nothing
> fundamentally wrong with them. And apparently there are still users.

That will surely help if its an option. RDS don't use fmr_pools so no
issues there.

Regards,
Santosh


