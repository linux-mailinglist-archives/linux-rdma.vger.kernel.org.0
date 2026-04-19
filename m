Return-Path: <linux-rdma+bounces-19429-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIQPL3xN5GlZTwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19429-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2026 05:35:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4226642302D
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2026 05:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9CA0301D332
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2026 03:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D05372EDB;
	Sun, 19 Apr 2026 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q2IzFVWB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C393373BF6
	for <linux-rdma@vger.kernel.org>; Sun, 19 Apr 2026 03:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776569708; cv=none; b=O/0uxltzZEpsk8iJ6w7DisP5TCcdGWk56GeyEfjC6pCSgNDxLLucSENkHaiX+GN3zocIca9hj9Ai0KO6yzxwy8GHszXXAwvRh705VJVWbCr4s7+kydvaD5NYabju9lG6uPz6xyvjJcl/idjLaGD9sbH5uGDokLa4YM5SaAdAVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776569708; c=relaxed/simple;
	bh=ofQiTMHl4DWKqY/+S2NOYeSF5dxNp7Ur5u8hVXEiVjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXH/9MBCOURfZMYfw/SM23eZVRIcYM2Hnq2YxRx7PA1a61CVwhtT5WbywbOXVs+d2bNhwlBA5SDwhLrmL0aoezm2/Qky0+G77kOvoMmsUIp+HIbNxj6r8M0xuZDfDnGrO5oB6I57vpfNsXs30FngVJxQ5jsp80H2iefOXAZUkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q2IzFVWB; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7176fdf5-55ed-4e95-ba15-52286975eccb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776569685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DtKdbUbvKyMZZwB9YhEiF+u1y7IWhOmIfywqditr5c=;
	b=Q2IzFVWBDZU9cvt6m6iOr/5FDr5G87q9FwawivRw/8Un+F+jDkipceof/UB6Gqi64lMB/x
	tnXIAEp/00TFZEoGqYMvzupiCMUEGABb3tbdE6AgZeTBke9XnAy80XS4/mu8C/YWIJsns2
	dbxoDKt1Bpv/HCSFB9Wok2tKjNl6RWE=
Date: Sat, 18 Apr 2026 20:34:33 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: reject non-8-byte ATOMIC_WRITE payloads
To: Michael Bommarito <michael.bommarito@gmail.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260418162141.3610201-1-michael.bommarito@gmail.com>
 <06470bbf-ee39-4094-8c01-5860935af0f8@linux.dev>
 <CAJJ9bXza+XAX36-Fse1aW7FM-=G11bqKqf6Ds_9sArzUbZh9-w@mail.gmail.com>
 <1bd36ce7-e3dd-4ff5-867a-b8b9ade90a1e@linux.dev>
 <CAJJ9bXxd5jzzGcsf-sTw-v2zk-9Q0AtDrNwXRtyh-m5O9tr-6Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAJJ9bXxd5jzzGcsf-sTw-v2zk-9Q0AtDrNwXRtyh-m5O9tr-6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19429-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,fujitsu.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 4226642302D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


在 2026/4/18 18:57, Michael Bommarito 写道:
> On Sat, Apr 18, 2026 at 7:18 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>> The fix should stand on its own, and the test case can be added as a
>> follow-up patch under tools/testing/selftests/rdma (or rdma-core if more appropriate).
>> This keeps each patch focused on a single logical change and makes review easier.
> It seems like mainlining rdma tests might not be a good idea.  I found
> the last time here:
> Kamal Heib, 23 Oct 2019 — [PATCH for-next] selftests: rdma: Add rdma tests
>
> I put the tests here and will PR it into linux-rdma/rdma-core tomorrow:
> https://github.com/mjbommar/rdma-core/blob/4104d991a764de4aad9f645a2f0ec723f6076209/tests/test_rxe_atomic_write_oob.py

Thanks a lot. I am fine with the above link.

Zhu Yanjun

>
> Thanks,
> Mike Bommarito

-- 
Best Regards,
Yanjun.Zhu


