Return-Path: <linux-rdma+bounces-5023-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBF497D5D1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 14:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C011F23A5E
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 12:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873EE16DECB;
	Fri, 20 Sep 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NN/OszTa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234CF16ABC6
	for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2024 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836679; cv=none; b=gLlbjaP28dxZvMSogHYrKtNXZ3b9ujJd/ibQvtJn3dfjGrE9nwoc02kcjDQufUjyxSxKNiXHyb/+lLzp+HMBSFAhw1qD4qWkXCeTT0j/+epz4mbwmp8JhZGhmud9CuEzph/tpzpQR1dpdzH3mrYVvcx4OCEgRsSklYtLRRwyhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836679; c=relaxed/simple;
	bh=lZz/D0yQlTmVoZ9F0DI0OokR9dxgJE3Vt4L76O2x4A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxvG5qYehuIWBGhQPOPZalPxYb6krhSeLYaRYTKvn+b8yv2BUtFlcWZZTH+LadjNCZ1GYNOq+xAdE3AtUHjC1A2gmBJaH/UcToWRSEnok97JtSy1HmAPfVgx82dUb1UyFgxRgwJOj1QuSdfQoGTW1rTdEJIhCqs810K4Iq5svjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NN/OszTa; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d86ba879-874c-45e3-8158-64d3abdcb317@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726836674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJSv3jfp3fGjVx0COe7tr+nr24AFeC9YXQj5U90zPNk=;
	b=NN/OszTaDwlhTgvlN5sZkk7QgGLCKIFTpyYXYyEhVGMNbaW1FZlKyDpnjb/0nojAAjB2m7
	GhafgqBBUOI6jf9k6W6jFF6RGY2wApBMAxXgCWsOdGF5+1K/1TU6Vxv4pTC9HqUSkOQ6cl
	e/C44JTkGG6wwQbCDFob8wlBxeY2IYQ=
Date: Fri, 20 Sep 2024 20:51:02 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [MAINLINE 2/2] rds: ib: Add Dynamic Interrupt Moderation to CQs
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <20240918083552.77531-3-haakon.bugge@oracle.com>
 <6971720d-3639-4a80-a17b-48489bfadb0a@linux.dev>
 <AAE98F7B-F556-4C9E-BB3B-3907790D801B@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <AAE98F7B-F556-4C9E-BB3B-3907790D801B@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/20 17:42, Haakon Bugge 写道:
> 
> 
>> On 20 Sep 2024, at 09:47, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>> 在 2024/9/18 16:35, Håkon Bugge 写道:
>>> With the support from ib_core to use Dynamic Interrupt Moderation
>>> (DIM) from legacy ULPs, which uses ib_create_cq(), we enable that
>>> feature for the receive and send CQs in RDS.
>>
>> Hi, Haakon
>>
>> I am interested in this patch series. I just wonder if the performance of rds is increased after DIM is used in legacy ULPs?
>> That is, is there any benefit to legacy ULPs after DIM is used?
>>
>> Do you have any test results about this DIM?
> 
> Yes, please see the cover letter of this commit.

Which Oracle Linux distro includes this feature?
And what is the kernel version?

Zhu Yanjun

> 
> 
> Thxs, Håkon
> 
>>
>> Thanks,
>> Zhu Yanjun
>>
>>> A set of rds-stress runs have been done. bcopy read + write for
>>> payload 8448 and 16640 bytes and ack/req of 256 bytes. Number of QPs
>>> varies from 8 to 128, number of threads (i.e. rds-stress processes)
>>> from one to 16 and a depth of four. A limit has been applied such that
>>> the number of processes times the number of QPs never exceeds 128. All
>>> in all, 61 rds-stress runs.
>>> For brevity, only the rows showing a +/- 3% deviation or larger from
>>> base is listed. The geometric mean of the ratios (IOPS_test /
>>> IOPS_base) is calculated for all 61 runs, and that gives the best
>>> possible "average" impact of the commits.
>>> In the following, "base" is v6.11-rc7. "test" is the same
>>> kernel with the following two commits:
>>>         * rds: ib: Add Dynamic Interrupt Moderation to CQs (this commit)
>>>         * RDMA/core: Enable legacy ULPs to use RDMA DIM
>>> This is executed between two X8-2 with CX-5 using fw 16.35.3502. These
>>> BM systems were instantiated with one VF, which were used for the
>>> test:
>>>                                   base     test
>>>     ACK    REQ  QPS  THR  DEP     IOPS     IOPS  Percent
>>>     256   8448    8    1    4   634463   658162      3.7
>>>     256   8448    8    2    4   862648   997358     15.6
>>>     256   8448    8    4    4   950458  1113991     17.2
>>>     256   8448    8    8    4   932120  1127024     20.9
>>>     256   8448    8   16    4   944977  1133885     20.0
>>>    8448    256    8    2    4   858663   975563     13.6
>>>    8448    256    8    4    4   934884  1098854     17.5
>>>    8448    256    8    8    4   928247  1116015     20.2
>>>    8448    256    8   16    4   938864  1123455     19.7
>>>     256   8448   64    1    4   965985   918445     -4.9
>>>    8448    256   64    1    4   963280   918239     -4.7
>>>     256  16640    8    2    4   544670   582330      6.9
>>>     256  16640    8    4    4   554873   597553      7.7
>>>     256  16640    8    8    4   551799   597479      8.3
>>>     256  16640    8   16    4   553041   597898      8.1
>>>   16640    256    8    2    4   544644   578331      6.2
>>>   16640    256    8    4    4   553944   594627      7.3
>>>   16640    256    8    8    4   551388   594737      7.9
>>>   16640    256    8   16    4   552986   596581      7.9
>>> Geometric mean of ratios: 1.03
>>> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
>>> ---
>>>   net/rds/ib_cm.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>> diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
>>> index 26b069e1999df..79603d86b6c02 100644
>>> --- a/net/rds/ib_cm.c
>>> +++ b/net/rds/ib_cm.c
>>> @@ -259,6 +259,7 @@ static void rds_ib_cq_comp_handler_recv(struct ib_cq *cq, void *context)
>>>   static void poll_scq(struct rds_ib_connection *ic, struct ib_cq *cq,
>>>        struct ib_wc *wcs)
>>>   {
>>> + int ncompleted = 0;
>>>    int nr, i;
>>>    struct ib_wc *wc;
>>>   @@ -276,7 +277,10 @@ static void poll_scq(struct rds_ib_connection *ic, struct ib_cq *cq,
>>>    rds_ib_mr_cqe_handler(ic, wc);
>>>      }
>>> + ncompleted += nr;
>>>    }
>>> + if (cq->dim)
>>> + rdma_dim(cq->dim, ncompleted);
>>>   }
>>>     static void rds_ib_tasklet_fn_send(unsigned long data)
>>> @@ -304,6 +308,7 @@ static void poll_rcq(struct rds_ib_connection *ic, struct ib_cq *cq,
>>>        struct ib_wc *wcs,
>>>        struct rds_ib_ack_state *ack_state)
>>>   {
>>> + int ncompleted = 0;
>>>    int nr, i;
>>>    struct ib_wc *wc;
>>>   @@ -316,7 +321,10 @@ static void poll_rcq(struct rds_ib_connection *ic, struct ib_cq *cq,
>>>      rds_ib_recv_cqe_handler(ic, wc, ack_state);
>>>    }
>>> + ncompleted += nr;
>>>    }
>>> + if (cq->dim)
>>> + rdma_dim(cq->dim, ncompleted);
>>>   }
>>>     static void rds_ib_tasklet_fn_recv(unsigned long data)
>>> @@ -542,6 +550,7 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
>>>    ic->i_scq_vector = ibdev_get_unused_vector(rds_ibdev);
>>>    cq_attr.cqe = ic->i_send_ring.w_nr + fr_queue_space + 1;
>>>    cq_attr.comp_vector = ic->i_scq_vector;
>>> + cq_attr.flags |= IB_CQ_MODERATE;
>>>    ic->i_send_cq = ib_create_cq(dev, rds_ib_cq_comp_handler_send,
>>>        rds_ib_cq_event_handler, conn,
>>>        &cq_attr);
>>> @@ -556,6 +565,7 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
>>>    ic->i_rcq_vector = ibdev_get_unused_vector(rds_ibdev);
>>>    cq_attr.cqe = ic->i_recv_ring.w_nr;
>>>    cq_attr.comp_vector = ic->i_rcq_vector;
>>> + cq_attr.flags |= IB_CQ_MODERATE;
>>>    ic->i_recv_cq = ib_create_cq(dev, rds_ib_cq_comp_handler_recv,
>>>        rds_ib_cq_event_handler, conn,
>>>        &cq_attr);
>>
> 


