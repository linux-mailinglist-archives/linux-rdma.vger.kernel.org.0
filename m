Return-Path: <linux-rdma+bounces-18281-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IyrBoG2uWnJMQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18281-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 21:16:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DDA2B21C0
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 21:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2576304024F
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 20:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F47347FED;
	Tue, 17 Mar 2026 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o33C6yRk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DF384247
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778556; cv=none; b=O2If9T9qmCH19KANvR8v85Fdw28j/qvEZO8ODQKPis4oz/wG/YXZlubWvTAhKsK/GQBBtAKTNeKQSH4lqqR/IH6cxV92Z9j+I/nOUHzPyu9JG7Ss5qVRlYfnYMb4VxjPpad3tBurBRgnMoIRxGT6yrsbeOaLBvPOYU3C7nszm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778556; c=relaxed/simple;
	bh=nz13+eGGdSW/9erFsoGuUtyGkuC0g3D6z0OmshPBnng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqqbuPpWiSv1xiRGQ9NIG5dShAAXlQkzOpkWkoOy3fkPD5ZIpOTyuSQKgi31668RAq9EpUWuQk/5EiyhJaM4D3pEAaRBPaog5UAVlol9idlm18EWjarxA/yBg/gLqjtfSqMkPtsmC5s+ThlsniPTlRC+Lsd/9Ug5vNxV7IDC90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o33C6yRk; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <82c1eb3b-be32-4128-b9f1-f2f0273c390e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773778552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYyE79GaBNpDsukSQte8wHVzSKL7JpiJDXjmVx/XWJs=;
	b=o33C6yRkcZYryn+ri9W1CRWVIteRL/qcApswFvmT1EcLSGGmhKsLEPgsxtjsyCub+3bO64
	Ur8LRWVI4ESbQKTuVieUYYuikLlqMKf398JtFKds/bmS60mYfZb3ZFRWfI3Jzy8AtexRLY
	JktV46rGgJ0JsYdjPFbFuRm8J3Oi3JY=
Date: Tue, 17 Mar 2026 13:15:42 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Replace use of system_unbound_wq with
 system_dfl_wq
To: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20260313154023.298325-1-marco.crivellari@suse.com>
 <20260316201301.GL61385@unreal>
 <c5374d12-84ed-4298-92d3-90062988f68d@linux.dev>
 <5de82ef1-3df6-44f8-a3c1-c6568c1110cf@linux.dev>
 <20260317190314.GC61385@unreal>
 <089fe865-0077-4253-85de-1bb05216b6e7@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <089fe865-0077-4253-85de-1bb05216b6e7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18281-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,kernel.org,gmail.com,linutronix.de,ziepe.ca];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 60DDA2B21C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/17/26 12:31 PM, Yanjun.Zhu wrote:
>
> On 3/17/26 12:03 PM, Leon Romanovsky wrote:
>> On Tue, Mar 17, 2026 at 10:24:11AM -0700, Yanjun.Zhu wrote:
>>> On 3/17/26 7:38 AM, Zhu Yanjun wrote:
>>>> 在 2026/3/16 13:13, Leon Romanovsky 写道:
>>>>> On Fri, Mar 13, 2026 at 04:40:23PM +0100, Marco Crivellari wrote:
>>>>>> This patch continues the effort to refactor workqueue APIs,
>>>>>> which has begun
>>>>>> with the changes introducing new workqueues and a new
>>>>>> alloc_workqueue flag:
>>>>>>
>>>>>>      commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and
>>>>>> system_dfl_wq")
>>>>>>      commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>>>>>>
>>>>>> The point of the refactoring is to eventually alter the default
>>>>>> behavior of
>>>>>> workqueues to become unbound by default so that their workload
>>>>>> placement is
>>>>>> optimized by the scheduler.
>>>>>>
>>>>>> Before that to happen, workqueue users must be converted to the
>>>>>> better named
>>>>>> new workqueues with no intended behaviour changes:
>>>>>>
>>>>>>      system_wq -> system_percpu_wq
>>>>>>      system_unbound_wq -> system_dfl_wq
>>>>>>
>>>>>> This way the old obsolete workqueues (system_wq,
>>>>>> system_unbound_wq) can be
>>>>>> removed in the future.
>>>>> I recall earlier efforts to replace system workqueues with
>>>>> per‑driver queues,
>>>>> because unloading a driver forces a flush of the entire system
>>>>> workqueue,
>>>>> which is undesirable for overall system behavior.
>>>>>
>>>>> Wouldn't it be better to introduce a local workqueue here and use
>>>>> that instead?
>>>> Thanks.
>>>>
>>>> 1.The initialization should be:
>>>>
>>>> my_wq = alloc_workqueue("my_driver_queue", WQ_UNBOUND | 
>>>> WQ_MEM_RECLAIM,
>>>> 0);
>>>> if (!my_wq)
>>>>      return -ENOMEM;
>>>>
>>>> 2. The Submission should be:
>>>>
>>>> queue_work(my_wq, &my_work);
>>>>
>>>> 3. Destroy should be:
>>>>
>>>> destroy_workqueue()
>>>>
>>>> Thanks,
>>>> Zhu Yanjun
>>> Hi, Leon
>>>
>>> The diff for a new work queue in rxe is as below. Please review it.
>> I'm not sure that you need second workqueue and destroy_workqueue
>> already does flush_workqueue. There is no need to call it explicitly.
> flush_workqueue() can be removed.
>
> The introduction of the second workqueue is due to rxe_wq being 
> heavily utilized by QP tasks.
>
> The additional workqueue helps offload and distribute the workload, 
> preventing rxe_wq from becoming a bottleneck.
>
> If you believe that the workload on rxe_wq is not significant, I can 
> simplify the design
>
> by removing the second workqueue and using rxe_wq for all work items 
> instead.
>
> Zhu Yanjun

Hi, Leon

The latest commit is as below:

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c 
b/drivers/infiniband/sw/rxe/rxe_odp.c
index bc11b1ec59ac..98092dcc1870 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
          work->frags[i].mr = mr;
      }

-    queue_work(system_unbound_wq, &work->work);
+    rxe_queue_work(&work->work);

      return 0;

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c 
b/drivers/infiniband/sw/rxe/rxe_task.c
index f522820b950c..0131829b5641 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,11 +6,13 @@

  #include "rxe.h"

+/* work for rxe_task */
  static struct workqueue_struct *rxe_wq;

  int rxe_alloc_wq(void)
  {
-    rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
+    rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND | WQ_MEM_RECLAIM,
+                WQ_MAX_ACTIVE);
      if (!rxe_wq)
          return -ENOMEM;

@@ -254,6 +256,13 @@ void rxe_sched_task(struct rxe_task *task)
      spin_unlock_irqrestore(&task->lock, flags);
  }

+/* Helper to queue auxiliary tasks into rxe_wq.
+ */
+void rxe_queue_work(struct work_struct *work)
+{
+    queue_work(rxe_wq, work);
+}
+
  /* rxe_disable/enable_task are only called from
   * rxe_modify_qp in process context. Task is moved
   * to the drained state by do_task.
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h 
b/drivers/infiniband/sw/rxe/rxe_task.h
index a8c9a77b6027..60c085cc11a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -36,6 +36,7 @@ int rxe_alloc_wq(void);

  void rxe_destroy_wq(void);

+void rxe_queue_work(struct work_struct *work);
  /*
   * init rxe_task structure
   *    qp  => parameter to pass to func

>
>>
>> Thanks
>>
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c
>>> b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> index bc11b1ec59ac..03199fef47fb 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> @@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct 
>>> ib_pd *ibpd,
>>>           work->frags[i].mr = mr;
>>>       }
>>>
>>> -    queue_work(system_unbound_wq, &work->work);
>>> +    rxe_queue_aux_work(&work->work);
>>>
>>>       return 0;
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c
>>> b/drivers/infiniband/sw/rxe/rxe_task.c
>>> index f522820b950c..a2da699b969e 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_task.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
>>> @@ -6,19 +6,36 @@
>>>
>>>   #include "rxe.h"
>>>
>>> +/* work for rxe_task */
>>>   static struct workqueue_struct *rxe_wq;
>>>
>>> +/* work for other rxe jobs */
>>> +static struct workqueue_struct *rxe_aux_wq;
>>> +
>>>   int rxe_alloc_wq(void)
>>>   {
>>> -    rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
>>> +    rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND | WQ_MEM_RECLAIM,
>>> +                WQ_MAX_ACTIVE);
>>>       if (!rxe_wq)
>>>           return -ENOMEM;
>>>
>>> +    rxe_aux_wq = alloc_workqueue("rxe_aux_wq",
>>> +                WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
>>> +    if (!rxe_aux_wq) {
>>> +        destroy_workqueue(rxe_wq);
>>> +        return -ENOMEM;
>>> +
>>> +    }
>>> +
>>>       return 0;
>>>   }
>>>
>>>   void rxe_destroy_wq(void)
>>>   {
>>> +    flush_workqueue(rxe_aux_wq);
>>> +    destroy_workqueue(rxe_aux_wq);
>>> +
>>> +    flush_workqueue(rxe_wq);
>>>       destroy_workqueue(rxe_wq);
>>>   }
>>>
>>> @@ -254,6 +271,14 @@ void rxe_sched_task(struct rxe_task *task)
>>>       spin_unlock_irqrestore(&task->lock, flags);
>>>   }
>>>
>>> +/* rxe_wq for rxe tasks. rxe_aux_wq for other rxe jobs.
>>> + */
>>> +void rxe_queue_aux_work(struct work_struct *work)
>>> +{
>>> +    WARN_ON_ONCE(!rxe_aux_wq);
>>> +    queue_work(rxe_aux_wq, work);
>>> +}
>>> +
>>>   /* rxe_disable/enable_task are only called from
>>>    * rxe_modify_qp in process context. Task is moved
>>>    * to the drained state by do_task.
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.h
>>> b/drivers/infiniband/sw/rxe/rxe_task.h
>>> index a8c9a77b6027..e1c0a34808b4 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_task.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_task.h
>>> @@ -36,6 +36,7 @@ int rxe_alloc_wq(void);
>>>
>>>   void rxe_destroy_wq(void);
>>>
>>> +void rxe_queue_aux_work(struct work_struct *work);
>>>   /*
>>>    * init rxe_task structure
>>>    *    qp  => parameter to pass to func
>>>
>>> Zhu Yanjun
>>>
>>>>> Thanks
>>>>>
>>>>>> Link:
>>>>>> https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
>>>>>> Suggested-by: Tejun Heo <tj@kernel.org>
>>>>>> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
>>>>>> ---
>>>>>>    drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c
>>>>>> b/drivers/infiniband/sw/rxe/rxe_odp.c
>>>>>> index bc11b1ec59ac..d440c8cbaea5 100644
>>>>>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>>>>>> @@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct
>>>>>> ib_pd *ibpd,
>>>>>>            work->frags[i].mr = mr;
>>>>>>        }
>>>>>>    -    queue_work(system_unbound_wq, &work->work);
>>>>>> +    queue_work(system_dfl_wq, &work->work);
>>>>>>          return 0;
>>>>>>    --
>>>>>> 2.53.0
>>>>>>

