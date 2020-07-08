Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E85217C6D
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 03:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgGHBHN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 21:07:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48180 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbgGHBHN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 21:07:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068121lT157159;
        Wed, 8 Jul 2020 01:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uhXQFE3P/OMTe2ST4dAYlyPeRRmwc3UKygXwg0CEW3Y=;
 b=N+DK1E+V5JhLJkFgF43NtKAGcoTuhEOQsQtPIQHLngQVl82tWIEavuPLwJL1GK/JW96/
 U9XyWrlplluXtmeZvq1s4K/6khGpFI/fPXz94x4H44RCHSRogV8OjEysADlFHiFKDQsW
 qcbgBX9h+Bm1pn1HpBpQPgdW+D1vAQ+IiChdvCwSMAd0zLBofOl3HKE4qQqXA9nvqniN
 vCx9GTLVKYho8tb6UCgOLi6XypaiGBmwmG1CFF9m5Y1Y1j8/oIoGRBMNsSQAygj53ll0
 i5r0lbaq6gITm4Zp6W1L8lR79SKO3syHMeSIiNnWoHpLHcB3RDQIBpjm/hXVaokyK3EQ 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 323wackemj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 08 Jul 2020 01:07:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06814GEP135666;
        Wed, 8 Jul 2020 01:05:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3233py2mut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jul 2020 01:05:05 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 068154Wj017086;
        Wed, 8 Jul 2020 01:05:04 GMT
Received: from dhcp-10-159-235-215.vpn.oracle.com (/10.159.235.215)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jul 2020 18:05:04 -0700
Subject: Re: [PATCH v4] IB/sa: Resolving use-after-free in ib_nl_send_msg
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
References: <1592964789-14533-1-git-send-email-divya.indi@oracle.com>
 <20200702190738.GA759483@nvidia.com>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <d078d705-9930-7abd-84c8-9b7d41aad722@oracle.com>
Date:   Tue, 7 Jul 2020 18:05:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702190738.GA759483@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 cotscore=-2147483648
 suspectscore=11 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080002
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Jason.

Appreciate your help and feedback for fixing this issue.

Would it be possible to access the edited version of the patch?
If yes, please share a pointer to the same.

Thanks,
Divya


On 7/2/20 12:07 PM, Jason Gunthorpe wrote:
> On Tue, Jun 23, 2020 at 07:13:09PM -0700, Divya Indi wrote:
>> Commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
>> -
>> 1. Adds the query to the request list before ib_nl_snd_msg.
>> 2. Moves ib_nl_send_msg out of spinlock, hence safe to use gfp_mask as is.
>>
>> However, if there is a delay in sending out the request (For
>> eg: Delay due to low memory situation) the timer to handle request timeout
>> might kick in before the request is sent out to ibacm via netlink.
>> ib_nl_request_timeout may release the query causing a use after free situation
>> while accessing the query in ib_nl_send_msg.
>>
>> Call Trace for the above race:
>>
>> [<ffffffffa02f43cb>] ? ib_pack+0x17b/0x240 [ib_core]
>> [<ffffffffa032aef1>] ib_sa_path_rec_get+0x181/0x200 [ib_sa]
>> [<ffffffffa0379db0>] rdma_resolve_route+0x3c0/0x8d0 [rdma_cm]
>> [<ffffffffa0374450>] ? cma_bind_port+0xa0/0xa0 [rdma_cm]
>> [<ffffffffa040f850>] ? rds_rdma_cm_event_handler_cmn+0x850/0x850
>> [rds_rdma]
>> [<ffffffffa040f22c>] rds_rdma_cm_event_handler_cmn+0x22c/0x850
>> [rds_rdma]
>> [<ffffffffa040f860>] rds_rdma_cm_event_handler+0x10/0x20 [rds_rdma]
>> [<ffffffffa037778e>] addr_handler+0x9e/0x140 [rdma_cm]
>> [<ffffffffa026cdb4>] process_req+0x134/0x190 [ib_addr]
>> [<ffffffff810a02f9>] process_one_work+0x169/0x4a0
>> [<ffffffff810a0b2b>] worker_thread+0x5b/0x560
>> [<ffffffff810a0ad0>] ? flush_delayed_work+0x50/0x50
>> [<ffffffff810a68fb>] kthread+0xcb/0xf0
>> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
>> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
>> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
>> [<ffffffff816f25a7>] ret_from_fork+0x47/0x90
>> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
>> ....
>> RIP  [<ffffffffa03296cd>] send_mad+0x33d/0x5d0 [ib_sa]
>>
>> To resolve the above issue -
>> 1. Add the req to the request list only after the request has been sent out.
>> 2. To handle the race where response comes in before adding request to
>> the request list, send(rdma_nl_multicast) and add to list while holding the
>> spinlock - request_lock.
>> 3. Use non blocking memory allocation flags for rdma_nl_multicast since it is
>> called while holding a spinlock.
>>
>> Fixes: 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list
>> before sending")
>>
>> Signed-off-by: Divya Indi <divya.indi@oracle.com>
>> ---
>> v1:
>> - Use flag IB_SA_NL_QUERY_SENT to prevent the use-after-free.
>>
>> v2:
>> - Use atomic bit ops for setting and testing IB_SA_NL_QUERY_SENT.
>> - Rewording and adding comments.
>>
>> v3:
>> - Change approach and remove usage of IB_SA_NL_QUERY_SENT.
>> - Add req to request list only after the request has been sent out.
>> - Send and add to list while holding the spinlock (request_lock).
>> - Overide gfp_mask and use GFP_NOWAIT for rdma_nl_multicast since we
>>   need non blocking memory allocation while holding spinlock.
>>
>> v4:
>> - Formatting changes.
>> - Use GFP_NOWAIT conditionally - Only when GFP_ATOMIC is not provided by caller.
>> ---
>>  drivers/infiniband/core/sa_query.c | 41 ++++++++++++++++++++++----------------
>>  1 file changed, 24 insertions(+), 17 deletions(-)
> I made a few edits, and applied to for-rc
>
> Thanks,
> Jason
