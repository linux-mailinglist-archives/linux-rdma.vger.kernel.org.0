Return-Path: <linux-rdma+bounces-17042-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFj/DMWImWmQUwMAu9opvQ
	(envelope-from <linux-rdma+bounces-17042-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 11:28:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F416CA7A
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 11:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 727DA301703D
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 10:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF48033032E;
	Sat, 21 Feb 2026 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Szn+TSDn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A8329E50
	for <linux-rdma@vger.kernel.org>; Sat, 21 Feb 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771669697; cv=none; b=DVJT/K0usuqKF7sCbwyIwOd683ilWALJpOpesHwdEYhBDWQSaHARzkHfis701pDXQolBdtlGemLYnqjkug8HgE+N/6XPtnNKHo2f417NY+KvoTu+wBpuH4IZBeLy7bX96FMNoUAi3QLhJJB9vHQLKxgp7iPSZiolnOTEfIaHUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771669697; c=relaxed/simple;
	bh=/s+SEEiPMc0bkUJXL4uO6bDigv3PZMyOm7SfZ+0ZaQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzDV+glRp1woXH79Hf/cSukc3eeZUMJKLy2HKSBMfjtbOhZKzQMdyr8/1z/RhH1ib2ddOH0PYr4/+iibtkz02b2qdtNp0f7Dj92G6DjgN8KCPFu+Yb4NvP/r1NnWMGqFVozJQ1rxgb5wxCNaBqtd67ILf7p2Nb13tEPidFYWlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Szn+TSDn; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b244fc9b-6161-4353-8eaa-914644c9c31c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771669693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OE/jhhKZszyhcMtiWaepIH+sIXtYc36Quc/erjuILb8=;
	b=Szn+TSDn3HARqyBg+o+p32Z+IAXf3ogTafU+xfeX1b/uH4OWg/+hI2aOOFcMs0w7Du0cYy
	qSBNwx/8JkvvoDeAMMu7Woeg/ezaj9tV65Be4HiwJ3U2oi3mJN64dXQKcEJqm9LiQmND6v
	eIoHiZ4naLW4sFgHsLjlfi0uPCTL854=
Date: Sat, 21 Feb 2026 02:28:09 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Generate async error for r_key violations
To: Evan Green <evgreen@meta.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Wei Lin Guay <wguay@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20260212164355.3585961-1-evgreen@meta.com>
 <9264c8bf-e3cd-46db-b1a9-63a556ecb1d4@linux.dev>
 <B810FD4C-0D5B-4FAB-A6C1-6201CF44E829@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <B810FD4C-0D5B-4FAB-A6C1-6201CF44E829@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17042-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[meta.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 8C8F416CA7A
X-Rspamd-Action: no action


在 2026/2/20 9:59, Evan Green 写道:
> Hi Yanjun,
>
> ﻿> On 2/12/26, 11:48 AM, "yanjun.zhu" <yanjun.zhu@linux.dev <mailto:yanjun.zhu@linux.dev>> wrote:
>>
>> On 2/12/26 8:43 AM, Evan Green wrote:
>>> Table 63 of the IBTA spec lists R_Key violations as a class C
>>> error. 9.9.3.1.3 Responder Class C Fault Behavior indicates an
>>> affiliated asynchronous error should be generated at the responder
>>> if the error can be associated to a QP but not a particular RX WQE.
>>
>> This paragraph should be the descriptions in the commit log.
>>
>>
>> "C9-222.1.1: For an HCA responder using Reliable Connection service, for
>> a Class C responder side error, the error shall be reported to the requester
>> by generating the appropriate NAK code as specified in Table 63 Re-
>> sponder Error Behavior Summary on page 448. If the error can be related
>> to a particular QP but cannot be related to a particular WQE on that re-
>> ceive queue (e.g. the error occurred while executing an RDMA Write Re-
>> quest without immediate data), the error shall be reported to the
>> responder’s client as an Affiliated Asynchronous error. See Section
>> 10.10.2.3 Asynchronous Errors on page 576 for details. If the error can be
>> related to a particular WQE on a given receive queue, the QP shall be
>> placed into the error state and the error shall be reported to the re-
>> sponder’s client as a Completion error. See Section 10.10.2.2 Completion
>> Errors on page 575."
> Apologies for the delayed response, I'm having an awful time setting up a mail client with proper formatting.
>
> Sure, I'll add this and send a v2.
>
>>
>> In this commit, a new asynchrounous event
>> RESPST_ERR_RKEY_VIOLATION_EVENT is introduced and implemented based on
>> 9.9.3.1.3. It is not a bug fix. As such, no FIXES tag.
>>
>>
>> I am fine with this. I am just wondering if this similar feature has
>> already been implemented in iWARP driver or not.
> I... can't tell, kind of? I see three places where QP_ACCESS_ERR events are generated in siw. They do look like R_Key violation scenarios, though I don’t see any any spots where SIW_WC_REM_ACCESS_ERR is produced as an error code.

Thank you very much. I’ve also looked into the iWARP driver and have 
similar thoughts to yours. If you’re interested in working on the iWARP 
driver, you’re welcome to implement this feature there as well—it’s 
entirely up to you. I simply hope that both iWARP and RXE continue to 
improve over time.

Thanks,

Yanjun.Zhu

>
>>
>> Thanks,
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev <mailto:yanjun.zhu@linux.dev>>
> Thank you!
> -Evan
>
>
>
>
-- 
Best Regards,
Yanjun.Zhu


