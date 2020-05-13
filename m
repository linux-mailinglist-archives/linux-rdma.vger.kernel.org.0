Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6934E1D1B6E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgEMQoW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 12:44:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:44837 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgEMQoV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 12:44:21 -0400
IronPort-SDR: EwYU17sjNqNmft4ChhauVyfMHByao/fAO/kOXQkf8j/0mk7coUn0pmlGVUwtIDuqsFynpJJ0yp
 4ptbUwmpt3Ig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 09:44:21 -0700
IronPort-SDR: WBI5QqbYZ73SKTCyUjGkU+wcxh4PGRQsNMR9w/YiRdkD2soA3iztShTerG0OpEpvuy8yHAVq8A
 t6+qIYwAkWjQ==
X-IronPort-AV: E=Sophos;i="5.73,388,1583222400"; 
   d="scan'208";a="464191476"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.205.167]) ([10.254.205.167])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 09:44:18 -0700
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
To:     Leon Romanovsky <leon@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Israel Rukshin <israelr@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, maxg@mellanox.com,
        sergeygo@mellanox.com, Chuck Lever <chuck.lever@oracle.com>
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal> <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
 <20200512201303.GA19158@mellanox.com>
 <98a0d1aa-6364-a2f1-37f6-9c69e1efaa0b@acm.org>
 <20200512230625.GB19158@mellanox.com>
 <b9dab6bf-d1b8-40c0-63ba-09eb3f4882f5@grimberg.me>
 <20200513071855.GQ4814@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <be388f26-9b86-b826-5d4b-8dec201ea5ef@intel.com>
Date:   Wed, 13 May 2020 12:44:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513071855.GQ4814@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/13/2020 3:18 AM, Leon Romanovsky wrote:
> On Tue, May 12, 2020 at 05:53:34PM -0700, Sagi Grimberg wrote:
>>
>>>>>>>> FMR is not supported on most recent RDMA devices (that use fast memory
>>>>>>>> registration mechanism). Also, FMR was recently removed from NFS/RDMA
>>>>>>>> ULP.
>>>>>>>>
>>>>>>>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>>>>>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>>>>>>>    drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
>>>>>>>>    drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
>>>>>>>>    drivers/infiniband/ulp/iser/iser_memory.c    | 188 ++-------------------------
>>>>>>>>    drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +++---------------
>>>>>>>>    4 files changed, 40 insertions(+), 372 deletions(-)
>>>>>>>
>>>>>>> Can we do an extra step and remove FMR from srp too?
>>>>>>
>>>>>> Which HCA's will be affected by removing FMR support? Or in other words,
>>>>>> when did (Mellanox) HCA's start supporting fast memory registration? I'm
>>>>>> asking this because there is a tradition in the Linux kernel not to
>>>>>> remove support for old hardware unless it is pretty sure that nobody is
>>>>>> using that hardware anymore.
>>>>>
>>>>> We haven't entirely been following that in RDMA.. More like when
>>>>> people can't test any more it can go.
>>>>>
>>>>> For FMR the support was dropped in newer HW so AFAIK, nobody tests
>>>>> this and it just stands in the way of making FRWR work properly.
>>>>>
>>>>> Do the ULPs stop working or do they just run slower with some regular
>>>>> MR flow?
>>>>
>>>> I'm not sure. I do not have access to RDMA adapters that do not support
>>>> FRWR.
>>>>
>>>> A possible test is to check on websites for used products whether old
>>>> RDMA adapters are still available. Is the InfiniHost adapter one of the
>>>> adapters that supports FMR? It seems like that adapter is still easy to
>>>> find.
>>>
>>> I don't know - AFAIK nobody does any testing on those cards any
>>> more, and doesn't test the ULPs either.
>>>
>>> I know Leon has pushed to remove the mthca driver in the past.  At one
>>> point there was a suggestion that drivers that do not support FRWR
>>> should be dropped, but I don't remember if mthca is the last one or
>>> not.
>>>
>>> There has been a big push to purge useless old stuff, look at the
>>> entire arch removals for instance. The large RDMA drivers fall under
>>> the same logic, IMHO.
>>
>> I think we should remove this support, if there is a user of this
>> somewhere he can safely use iscsi. Let alone that iser uses the fmr
>> pools which leaves rkeys exposed for caching purposes. So I'd much
>> rather remove it than trying to fix it.
> 
> Agree, given the fact that no one is even going to try to fix.
> 
> We don't see new contributors in this community who are not affiliated
> with RDMA companies and they are not testing and have no plans to test FMR.
> 
> I feel that we can't even say if FMR and old cards work :).

qib still works.

-Denny

