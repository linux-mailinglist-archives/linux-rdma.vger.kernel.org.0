Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D88188F0D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 21:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCQUgT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 16:36:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37980 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQUgT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 16:36:19 -0400
Received: by mail-qt1-f194.google.com with SMTP id e20so18781508qto.5
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NRL+rFj8iTOXMxbcEI6wvpftyj7DZ5j4v32M1+NFYz0=;
        b=WSQMDhyHN+/0MJbaYkq4Nghj60ImuG7mERlSFPrjIgquOdtwsK6Z1R2PPXxmcr6Nl2
         lAoYGKVgg63o3evSBw7tfJ94dXyJWb2uYk5//CgungQQBLKvRT1zeeCWXhOzi1iKr/pF
         3aOQ1WF/TXSFgHtKMRaJ9K3fevhYcbexd8NzEWZ97R4fGlXgvJpB9apaRW62oNFbe4jh
         j62d3d8bbPFAanJfE5xSE+pt2HxC+7qRLv8DN+fJmuWZcmlWVnJ1tUKaWsuZO30Muppw
         bbAt6OGFbuCNbv87LdfnzoheZIaASCCkRhyuA9rfuzuY/4nUVVXxsSSPL9JMHq9DIxnf
         EjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NRL+rFj8iTOXMxbcEI6wvpftyj7DZ5j4v32M1+NFYz0=;
        b=OssUR1A7QCht0N0VbdKnaojhofIgWJxHDqZ/qAGItCS/+EcjFSwoma4WLMLK/cL4DS
         AHa4YKp75ylrUaf2GfsASyFws2X6l3+z+xlL5lPLtv/xlYDYJSsfr/ZJwT6dcoC5fGix
         dcBkg/xMOW1VZKNvoqRoANG2wjalaX1wQLQNXUmODrzPotffx8dk2+pXU0WnIfwj08aa
         tUalnKbQVagGOzTxbDrrjk8Z2YYcPWKAOWXMbKweDzCo9QnATkAuXGlwSP94FAuIFGE+
         CuDHs84yMRab76CFR2OJLj8IoXjAh+UBBAI3BQYaPBLgV2qdmnWO4lF6gRtNnpuOByJ4
         HFlg==
X-Gm-Message-State: ANhLgQ223paj//TE2XOUy2SHvA3H1zX0/wgIq92eyVmi9bcmskvzWIN6
        RJ4xxHgZ8tbnIOBiAUPJTr0=
X-Google-Smtp-Source: ADFU+vtepzx1nqFPpsAM1U4n9aVqgkBQ20MS/lvDaO4zzom9Iwd8wrko+hb9mVO00F+G3+nBZ3IsUw==
X-Received: by 2002:aed:3244:: with SMTP id y62mr1077946qtd.242.1584477377608;
        Tue, 17 Mar 2020 13:36:17 -0700 (PDT)
Received: from anon-dhcp-153.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f93sm3010515qtd.26.2020.03.17.13.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 13:36:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 4/5] IB/core: cache the CQ completion vector
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <078fd456-b1bc-a103-070b-d1a8ea6bff9c@mellanox.com>
Date:   Tue, 17 Mar 2020 16:36:14 -0400
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, leonro@mellanox.com,
        jgg@mellanox.com, dledford@redhat.com, idanb@mellanox.com,
        shlomin@mellanox.com, Oren Duer <oren@mellanox.com>,
        vladimirk@mellanox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <82D6A70B-A201-4592-A031-F8EC581C0123@gmail.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-5-maxg@mellanox.com>
 <448195E1-CE26-4658-8106-91BAFF115853@gmail.com>
 <078fd456-b1bc-a103-070b-d1a8ea6bff9c@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Mar 17, 2020, at 11:41 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>=20
>=20
> On 3/17/2020 5:19 PM, Chuck Lever wrote:
>> Hi Max-
>>=20
>>> On Mar 17, 2020, at 9:40 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>>>=20
>>> In some cases, e.g. when using ib_alloc_cq_any, one would like to =
know
>>> the completion vector that eventually assigned to the CQ. Cache this
>>> value during CQ creation.
>> I'm confused by the mention of the ib_alloc_cq_any() API here.
>=20
> Can't the user use ib_alloc_cq_any() and still want to know what is =
the final comp vector for his needs ?

If your caller cares about the final cv value, then it should not use
the _any API. The point of _any is that the caller really does not care,
the cv value is hidden because it is not consequential. Your design
breaks that assumption/contract.


>> Is your design somehow dependent on the way the current =
ib_alloc_cq_any()
>> selects comp_vectors? The contract for _any() is that it is an API =
for
>> callers that simply do not care about what comp_vector is chosen. =
There's
>> no guarantee that the _any() comp_vector allocator will continue to =
use
>> round-robin in the future, for instance.
>=20
> it's fine. I just want to make sure that I'll spread the SRQ's =
equally.

The _any algorithm is simplistic, it spreads cvs for the system as a =
whole.
All devices, all callers. You're going to get some bad degenerate cases
as soon as you have multiple users of the SRQ facility.

So, you really want to have a more specialized comp_vector selector for
the SRQ facility; one that is careful to spread cvs per device, =
independent
of the global allocator, which is good enough for normal cases.

I think your tests perform well simply because there was no other =
contender
for comp_vectors on your test system.


>> If you want to guarantee that there is an SRQ for each comp_vector =
and a
>> comp_vector for each SRQ, stick with a CQ allocation API that enables
>> explicit selection of the comp_vector value, and cache that value in =
the
>> caller, not in the core data structures.
>=20
> I'm Ok with that as well. This is exactly what we do in the nvmf/rdma =
but I wanted to stick also with the SRP target approach.
>=20
> Bart,
>=20
> Any objection to remove the call for ib_alloc_cq_any() from ib_srpt =
and use ib_alloc_cq() ?
>=20
>=20
>>=20
>>=20
>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>> ---
>>> drivers/infiniband/core/cq.c | 1 +
>>> include/rdma/ib_verbs.h      | 1 +
>>> 2 files changed, 2 insertions(+)
>>>=20
>>> diff --git a/drivers/infiniband/core/cq.c =
b/drivers/infiniband/core/cq.c
>>> index 4f25b24..a7cbf52 100644
>>> --- a/drivers/infiniband/core/cq.c
>>> +++ b/drivers/infiniband/core/cq.c
>>> @@ -217,6 +217,7 @@ struct ib_cq *__ib_alloc_cq_user(struct =
ib_device *dev, void *private,
>>> 	cq->device =3D dev;
>>> 	cq->cq_context =3D private;
>>> 	cq->poll_ctx =3D poll_ctx;
>>> +	cq->comp_vector =3D comp_vector;
>>> 	atomic_set(&cq->usecnt, 0);
>>>=20
>>> 	cq->wc =3D kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), =
GFP_KERNEL);
>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>> index fc8207d..0d61772 100644
>>> --- a/include/rdma/ib_verbs.h
>>> +++ b/include/rdma/ib_verbs.h
>>> @@ -1558,6 +1558,7 @@ struct ib_cq {
>>> 	struct ib_device       *device;
>>> 	struct ib_ucq_object   *uobject;
>>> 	ib_comp_handler   	comp_handler;
>>> +	u32			comp_vector;
>>> 	void                  (*event_handler)(struct ib_event *, void =
*);
>>> 	void                   *cq_context;
>>> 	int               	cqe;
>>> --=20
>>> 1.8.3.1
>>>=20
>> --
>> Chuck Lever
>> chucklever@gmail.com
>>=20
>>=20
>>=20

--
Chuck Lever
chucklever@gmail.com



