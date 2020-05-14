Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA181D3905
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 20:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgENSUt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 14:20:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgENSUt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 May 2020 14:20:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EIH9gr130004;
        Thu, 14 May 2020 18:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=C96f5nTuYdzQCUFp8e/sk3brVbI0X1hHW8foPlGfO3c=;
 b=j4NnjwX0+x4OUGzfp1McyDai8y3WlaQ0IbkgeCDwQakCCNO5sWWb7R94SEUyzCuhEi9R
 0WW5qoa9u4ABPhYyXx8JrbIHdKeHG+kL3chVk12M7lJkxyEWpnAnpBhhwdD4O7hxeCnO
 GAYmPkEkIVwHehDfY3/L4A43BDl4F0U/qM6qkHMvtk2qfGib1JOXMvc4b8G3P7KjQmHQ
 ptvETaHT27YH/M5wSAFK0AIHGaVP9a0GMtClGy8Gf+cNKx+vqwHsB1yiY55ARROqahCv
 slDwu1MiFW6kspveAf4dkX0jxlDr2JwAqG0ivraDYiI0SM4wnQT/sZb+XdpVRqrYjqaZ Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3100xwv8qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 18:20:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EII7Xe161087;
        Thu, 14 May 2020 18:18:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3100yd5trv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 18:18:35 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04EIIXJU010721;
        Thu, 14 May 2020 18:18:33 GMT
Received: from [10.74.104.165] (/10.74.104.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 May 2020 11:18:32 -0700
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     Aron Silverton <aron.silverton@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     bvanassche@acm.org, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        sagi@grimberg.me, israelr@mellanox.com, shlomin@mellanox.com
References: <20200514120305.189738-1-maxg@mellanox.com>
 <905E7E0C-1F87-4552-A7E3-5C49EDBED138@oracle.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <5c48f60b-23b7-da64-6f37-f52de7bb625d@oracle.com>
Date:   Thu, 14 May 2020 11:18:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <905E7E0C-1F87-4552-A7E3-5C49EDBED138@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140162
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/14/20 8:13 AM, Aron Silverton wrote:
> +Santosh
> 
> You probably meant to copy the RDS maintainer? Not sure if this should have
> also been sent to netdev@vger.kernel.org.
> 
Thanks Aron.

> 
>> On May 14, 2020, at 7:02 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>>
>> This series removes the support for FMR mode to register memory. This ancient
>> mode is unsafe and not maintained/tested in the last few years. It also doesn't
>> have any reasonable advantage over other memory registration methods such as
>> FRWR (that is implemented in all the recent RDMA adapters). This series should
>> be reviewed and approved by the maintainer of the effected drivers and I
>> suggest to test it as well.
>>
I know the security issue has been brought up before and this plan of 
removal of FMR support was on the cards but on RDS at least on CX3 we
got more throughput with FMR vs FRWR. And the reasons are well
understood as well why its the case.

Is it possible to keep core support still around so that HCA's which
supports FMR, ULPs can still can leverage it if they want.
 From RDS perspective, if the HCA like CX3 doesn't support both modes,
code prefers FMR vs FRWR and hence the question.

Also while re-posting the series, please copy me on the patches.

Regards,
Santosh

