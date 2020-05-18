Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EA91D7E9B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 18:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgERQfI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 12:35:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35028 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERQfH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 May 2020 12:35:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04IGX0tT008921;
        Mon, 18 May 2020 16:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TumBeVhFfnNtOHtFFwX2l2xpbi9lkjVansV0214Fhkg=;
 b=UM1DpU1UCQ2Vm6tUUQTTLdWF+d1ALP8dzTVXkxS7KLR8kb0/8WXtJ12Ccn2Q5cYYJrcQ
 LpcgwXnGKjZmW219AtHlP5TQbv6h/5bp9eRT1ufBib3xc2FuJBndeqEtbnmZMbn1D5St
 1GH1c9R0l8ua/yhSUkgQ1hTCTAPGx6uu3clmne8fDhC6GO3qIm9P+HCK46dqdsUavKTK
 FmQLwlxdkTfk2k3SBv9h2mFi8+nDgU7a+N9sgSnMs8e0vJV9So841J+Gvrm5eal3D+yJ
 MQ2qgTiHJE+0N6WtiGROljA7zzYrhybKK10Q0uxXoG4Iyh01BNnqI9nnfnSdoGpNmLpW jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3127kqywe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 16:34:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04IGX3LK116966;
        Mon, 18 May 2020 16:34:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 312sxqsqpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 16:34:50 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04IGYlCI019690;
        Mon, 18 May 2020 16:34:47 GMT
Received: from [10.74.104.174] (/10.74.104.174)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 May 2020 09:34:46 -0700
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     Max Gurtovoy <maxg@mellanox.com>, Sagi Grimberg <sagi@grimberg.me>,
        Tom Talpey <tom@talpey.com>,
        Aron Silverton <aron.silverton@oracle.com>
Cc:     bvanassche@acm.org, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        israelr@mellanox.com, shlomin@mellanox.com
References: <20200514120305.189738-1-maxg@mellanox.com>
 <905E7E0C-1F87-4552-A7E3-5C49EDBED138@oracle.com>
 <5c48f60b-23b7-da64-6f37-f52de7bb625d@oracle.com>
 <479add48-6fdb-f925-c3b9-699c6aa4cfbf@grimberg.me>
 <0ea6349f-1915-3493-3bd7-0bc8086c5b66@oracle.com>
 <75f2cbe4-3a62-9b0e-93c7-fb076bf318bf@talpey.com>
 <53ac195c-dccd-3d30-9e11-f1389dc8332d@grimberg.me>
 <3e4c0d12-d0f9-87f4-a256-ebe7d881de08@mellanox.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <a01abcf6-64a5-5a66-4ee7-ac0b3aa9c83d@oracle.com>
Date:   Mon, 18 May 2020 09:34:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3e4c0d12-d0f9-87f4-a256-ebe7d881de08@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180140
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/17/20 3:51 AM, Max Gurtovoy wrote:
> 
> On 5/15/2020 9:59 PM, Sagi Grimberg wrote:
>>
>>> It's not only the fmr_pools. The FMR API operates on a page granularity,
>>> so a sub-page registration, or a non-page-aligned one, ends up exposing
>>> data outside the buffer. This is done silently, and is a significant
>>> vulnerability for most upper layers.
>>
>> You're right Tom, I forgot about that...
>> I guess I'd vote to remove it altogether then...
> 
> Santosh,
> 
> I don't really understand the mechanism you use from user/kernel 
> regarding the registration.
> 
> But I saw you use wait_event and wait for completing the 
> FRWR/INVALIDATION. For sure this is not optimal.
> 
> But can't really say what is the bottleneck in your case.
> 
> Can you share the numbers you get for FMR/FRWR benchmarks ?
> 
The upstream code for FRWR is behind the optimal code we have
been using. The invalidation path is removed from datapath
with proxy QP within the PD.

Anyway, please bounce your patches for me to review to make sure
nothing breaks. From various responses, it seems to be aligned to
move ahead with the patch-set, so lets go with it.

Regards,
Santosh
