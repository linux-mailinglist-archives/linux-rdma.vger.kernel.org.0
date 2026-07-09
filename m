Return-Path: <linux-rdma+bounces-22927-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0kvYFxlQT2rgeAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22927-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:39:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E6772DD5A
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:39:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=VIS+K0JE;
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22927-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22927-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7142C3026F1F
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 07:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08883C1974;
	Thu,  9 Jul 2026 07:38:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from sender-op-o19.zoho.eu (sender-op-o19.zoho.eu [136.143.169.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02AC1E4AF
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 07:38:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582716; cv=pass; b=iPtBf7Io1Wm0BP4TRppGlFeBa7N5tvfle+uEHF3zj+JQfZlwBWmAwk2tlGZuBdcaQoDfL3ZCzuWvmtiFoN29C+0nBpqdvhNqEz8AAsMF2qJYTRnYWWqYXaiFRjduk9k3ZFCql21RzqXBAWynyXnlI+8wPag6mQBzGLTVa0HQ/mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582716; c=relaxed/simple;
	bh=rYXFS9xHWuxQzCIZzhwsqpVUQPKRsFxknlyN1JD5Vos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaQ5qnP88Yq2afFGyYY3cu/KCiwTs/FT51hWbIjTg3Ik8Hk4ATvu7A45tZjeGcuCe14ZlBPb8gmrhMr3QskrYiAgEs94BN4nXVJkqQi2e/9FUBKlIkgIeDLcRNucSCuQNTr+9x/QBr+Enij6571U37/UoI2lmuLHEE5oOXlcX8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=VIS+K0JE; arc=pass smtp.client-ip=136.143.169.19
ARC-Seal: i=1; a=rsa-sha256; t=1783581779; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=VK21chKWofYbNuJIrzzGpsRRVvHoqOi+e6wXH1BWKh4LB7/UZ7VL1cXqbSj2ObBR9WvPplyYuKKIWi29nOOi/zFerjGiiINthO4HrDtV3rY3zucH+RAQQUnhIKHPfXehqHd6036pcjjgLSuFm2hG8emUBH/tmxDTS2E0Uzx3ly8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783581779; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VFtLFkRLEWW8l7BwPhVXWJVcL1yGskcHu0COgJoFJaw=; 
	b=leuhatw7b67vDhbFlfCyG2s9zDd+q6T1sQ5dVwlS5WqRKZ1N4xdFvUTO01WSjQwCGSRJQ39nEYXon12zRl6hP+9gpBiaXFW9cYMbN06YxgTYqg329Ar2zQbPntsdS2d84zjXN0ISs6pjSriBD5TYqAPnfJrIRI+j0UGWx9azpa4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783581779;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VFtLFkRLEWW8l7BwPhVXWJVcL1yGskcHu0COgJoFJaw=;
	b=VIS+K0JEDOAfm7QoGp134j5BPE88sBezBKc+E4lxROnWoooj+UD2INEh+yYOQ9sW
	1F2h+mPbUTQsvOG95UhLo1VqURjB8FTCWLMJvvGam8NN6JjNDp1T/DHrOrsEsI+RYh+
	UgPkKd/ns3XSayic4fI4YwSnyX9iPqql+7ufVcLc=
Received: by mx.zoho.eu with SMTPS id 1783581778052657.1501097294694;
	Thu, 9 Jul 2026 09:22:58 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: fix responder UAF on IB_QP_MAX_DEST_RD_ATOMIC modify_qp
Date: Thu,  9 Jul 2026 09:22:53 +0200
Message-ID: <20260709072253.8918-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <d4af0c54-3bd6-401c-905a-ce546f2da475@linux.dev>
References: <20260708224550.1281-1-security@auditcode.ai> <d4af0c54-3bd6-401c-905a-ce546f2da475@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[auditcode.ai,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[auditcode.ai:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22927-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[security@auditcode.ai,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,ziepe.ca,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@auditcode.ai,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,auditcode.ai:from_mime,auditcode.ai:dkim,auditcode.ai:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79E6772DD5A

Hi Zhu Yanjun, thanks for the review.

> > BUG: KASAN: slab-use-after-free in rxe_receiver+0x4f78/0x89e0 [rdma_rxe]
> > Workqueue: rxe_wq do_work [rdma_rxe]
> Can you share all the stack trace with us? Thanks a lot.

Sure. The read side -- the recv_task kworker running rxe_receiver() on
the freed rd_atomic resource array -- from the pre-fix v6.19 kernel
(CONFIG_KASAN generic, rxe loopback):

  BUG: KASAN: slab-use-after-free in rxe_receiver+0x4f78/0x89e0 [rdma_rxe]
  Read of size 4 at addr ffff88800b79f84c by task kworker/u8:2/51
  CPU: 0 UID: 0 PID: 51 Comm: kworker/u8:2 Not tainted 6.19.0 #1
  Workqueue: rxe_wq do_work [rdma_rxe]
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4d/0x70
   print_report+0x170/0x4f3
   kasan_report+0xda/0x110
   rxe_receiver+0x4f78/0x89e0 [rdma_rxe]
   do_work+0x144/0x470 [rdma_rxe]
   process_one_work+0x611/0xe80
   worker_thread+0x52e/0xdc0
   kthread+0x30c/0x630
   ret_from_fork+0x2fd/0x3e0
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  The buggy address belongs to the object at ffff88800b79f800
   which belongs to the cache kmalloc-1k of size 1024
  The buggy address is located 76 bytes inside of
   freed 1024-byte region [ffff88800b79f800, ffff88800b79fc00)

The freed kmalloc-1k object is qp->resp.resources[] (the rd_atomic
array); it is freed by the concurrent
ib_modify_qp(IB_QP_MAX_DEST_RD_ATOMIC) thread in
free_rd_atomic_resources() <- rxe_qp_from_attr(), while this recv_task
kworker reads it. This was a kasan_multi_shot run and the per-object
Allocated-by/Freed-by backtraces were lost in the splat storm -- I can
send a single-shot capture that includes those two stacks if it would
help.

> If alloc_rd_atomic_resources fails, that is, qp->resp.resources is NULL.
> After rxe_enable_task(&qp->recv_task);  qp->resp.resources(NULL) will be
> used in resp. This will cause problems.
> drivers/infiniband/sw/rxe/rxe_resp.c:656:    res = &qp->resp.resources[qp->resp.res_head];
> drivers/infiniband/sw/rxe/rxe_resp.c:1325:        struct resp_res *res = &qp->resp.resources[i];

Good catch -- you're right. Re-enabling recv_task before the error
check resumes the responder against a NULL qp->resp.resources on the
ENOMEM path. v2 moves rxe_enable_task() below the error check, so the
responder is re-enabled only once a fresh array has been installed and
stays quiesced on failure:

	rxe_disable_task(&qp->recv_task);
	free_rd_atomic_resources(qp);
	err = alloc_rd_atomic_resources(qp, max_dest_rd_atomic);
	if (err)
		return err;
	rxe_enable_task(&qp->recv_task);

rxe_disable_task()/rxe_enable_task() are state-based (TASK_STATE_DRAINED
/IDLE), not refcounted, so leaving recv_task drained on the failed
modify is safe and recoverable: a subsequent successful modify_qp or a
QP destroy both handle the DRAINED state.

I'll send this as [PATCH v2].

Thanks,
Ibrahim

