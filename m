Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7D762A32
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 22:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbfGHUMS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 16:12:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42812 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbfGHUMS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 16:12:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x68K9QSY002867;
        Mon, 8 Jul 2019 20:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0acHncQWLgXnQHNrif/wO/N98O8sHefa/57hdRhle6Q=;
 b=DFrcOxtZ9GNbi191LnRrT7HrOyEUzZ3nzo3GgX3SaV2OqWQ9LLYVxYwPfUegliYpMeNz
 rt9BxXxNIq5xoBHnLeVZVgfYgoiqR+BAep/5nrQWdUUSkh2hBj7KSp4Nc6omZosmdmVt
 Zt2K0L2y315q5xQixTx3bChTGtHftYll/3K2JUD7f+rlocqg5jwPG3OpN7GzysiQDAem
 xWXxmYxmMm8hj+czPKA+dO32yHkHKkI9PLX6/KmAubfrjtzZ45DtL45aWz6nVXGwPngy
 WbOspL1vRg+R3wXEflxsvwUk0EpyumR0M1My1UDHHPCBO0GN0hN/VyRxSvd3NGbPtBb1 hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tjkkpggmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 20:11:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x68K8EK2063661;
        Mon, 8 Jul 2019 20:11:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tjjykdbk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 20:11:38 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x68KBX5r010633;
        Mon, 8 Jul 2019 20:11:33 GMT
Received: from [192.168.1.14] (/109.189.94.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jul 2019 13:11:33 -0700
Subject: Re: [PATCH v3] RDMA/core: Fix race when resolving IP address
To:     Jason Gunthorpe <jgg@ziepe.ca>, Mark Bloch <markb@mellanox.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1562584584-13132-1-git-send-email-dag.moxnes@oracle.com>
 <20190708175025.GA6976@ziepe.ca>
 <4b9ae7b8-310c-e0b6-7a8e-33e6d5bef83d@oracle.com>
 <63b9d2cb-f69c-d77c-7803-f08e2a6f755d@mellanox.com>
 <20190708193814.GF23996@ziepe.ca>
From:   Dag Moxnes <dag.moxnes@oracle.com>
Message-ID: <424b75d7-90ea-8d07-42b9-de9d507b0f85@oracle.com>
Date:   Mon, 8 Jul 2019 22:11:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708193814.GF23996@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907080251
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080251
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



Den 08.07.2019 21:38, skrev Jason Gunthorpe:
> On Mon, Jul 08, 2019 at 07:22:45PM +0000, Mark Bloch wrote:
>>
>> On 7/8/19 11:47 AM, Dag Moxnes wrote:
>>> Thanks Jason,
>>>
>>> Regards,
>>> Dag
>>>
>>> Den 08.07.2019 19:50, skrev Jason Gunthorpe:
>>>> On Mon, Jul 08, 2019 at 01:16:24PM +0200, Dag Moxnes wrote:
>>>>> Use neighbour lock when copying MAC address from neighbour data struct
>>>>> in dst_fetch_ha.
>>>>>
>>>>> When not using the lock, it is possible for the function to race with
>>>>> neigh_update, causing it to copy an invalid MAC address.
>>>>>
>>>>> It is possible to provoke this error by calling rdma_resolve_addr in a
>>>>> tight loop, while deleting the corresponding ARP entry in another tight
>>>>> loop.
>>>>>
>>>>> This will cause the race shown it the following sample trace:
>>>>>
>>>>> rdma_resolve_addr()
>>>>>     rdma_resolve_ip()
>>>>>       addr_resolve()
>>>>>         addr_resolve_neigh()
>>>>>           fetch_ha()
>>>>>             dst_fetch_ha()
>>>>>               n->nud_state == NUD_VALID
>>>> It isn't nud_state that is the problem here, it is the parallel
>>>> memcpy's onto ha. I fixed the commit message
>>>>
>>>> This could also have been solved by using the ha_lock, but I don't
>>>> think we have a reason to particularly over-optimize this.
>> Sorry I'm late to the party, but why not just use: neigh_ha_snapshot()?
> Yes, that is much better, please respin this
OK, will do!
Can I still post it as a v4? Or should I do it differently as you 
already applied it?

Regards,
-Dag
>
> Thanks,
> Jason

