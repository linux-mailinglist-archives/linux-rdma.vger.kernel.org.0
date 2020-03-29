Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F3F196E8F
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgC2Qwa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Mar 2020 12:52:30 -0400
Received: from mx.sdf.org ([205.166.94.20]:61333 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbgC2Qwa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Mar 2020 12:52:30 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02TGq4Aa019498
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sun, 29 Mar 2020 16:52:05 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02TGq45F000077;
        Sun, 29 Mar 2020 16:52:04 GMT
Date:   Sun, 29 Mar 2020 16:52:04 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bart Van Assche <bvanassche@acm.org>, lkml@sdf.org
Subject: Re: [RFC PATCH v1 42/50] drivers/ininiband: Use get_random_u32()
Message-ID: <20200329165204.GC4675@SDF.ORG>
References: <202003281643.02SGhN9T020186@sdf.org>
 <OF05D43316.2F69D46F-ON0025853A.00513FE8-0025853A.00528B66@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
In-Reply-To: <OF05D43316.2F69D46F-ON0025853A.00513FE8-0025853A.00528B66@notes.na.collabserv.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 29, 2020 at 03:01:36PM +0000, Bernard Metzler wrote:
> -----"George Spelvin" <lkml@sdf.org> wrote: -----
>> Subject: [EXTERNAL] [RFC PATCH v1 42/50] drivers/ininiband: Use 
get_random_u32()
>>
>> There's no need to get_random_bytes() into a temporary buffer.
>>
>> This is not a no-brainer change; get_random_u32() has slightly weaker
>> security guarantees, but code like this is the classic example of when
>> it's appropriate: the random value is stored in the kernel for as long
>> as it's valuable.
>>
>> TODO: Could any of the call sites be further weakened to prandom_u32()?
>> If we're randomizing to avoid collisions with a *cooperating* (as opposed
>> to malicious) partner, we don't need cryptographic strength.
>>
>> Signed-off-by: George Spelvin <lkml@sdf.org>
>> Cc: Doug Ledford <dledford@redhat.com>
>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>> Cc: linux-rdma@vger.kernel.org
>> Cc: Faisal Latif <faisal.latif@intel.com>
>> Cc: Shiraz Saleem <shiraz.saleem@intel.com>
>> Cc: Bart Van Assche <bvanassche@acm.org>
>> Cc: Bernard Metzler <bmt@zurich.ibm.com>

>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>> b/drivers/infiniband/sw/siw/siw_verbs.c
>> index 5fd6d6499b3d7..42f3ced4ca7c7 100644
>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> @@ -1139,7 +1139,7 @@ int siw_create_cq(struct ib_cq *base_cq, const
>> struct ib_cq_init_attr *attr,
>>  		rv = -ENOMEM;
>>  		goto err_out;
>>  	}
>> -	get_random_bytes(&cq->id, 4);
>> +	cq->id = get_random_u32();
>>  	siw_dbg(base_cq->device, "new CQ [%u]\n", cq->id);
>>  
>>  	spin_lock_init(&cq->lock);

> Speaking for the siw driver only, these two changes are looking
> good to me. What is needed is a pseudo-random number, not
> to easy to guess for the application. get_random_u32() provides that.
> 
> Thanks!
> 
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

Just so you know, get_random_u32() is still crypto-strength: it is
unguessable even to a resourceful attacker with access to large amounts
of other get_random_u32() output.

prandom_u32() is much cheaper, but although well seeded and distributed 
(so equally resistant to accidental collisions), *is* guessable if someone 
really wants to work at it.

Many intra-machine networks (like infiniband) are specifically not 
designed to be robust in the face of malicious actors on the network.
A random transaction ID is sent in the clear, and a malicious actor 
wanting to interfere could simply copy it.

In such cases, there's no need for crypto-grade numbers, because the
network already assumes that nobody's actively trying to create
collisions.

You seem to be saying that the siw driver could use prandom_u32().
