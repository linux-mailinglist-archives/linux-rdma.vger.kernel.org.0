Return-Path: <linux-rdma+bounces-20946-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCq9Gw3FC2qWMQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20946-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 04:03:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C036F5763FB
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 04:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 968E6301AD3E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 02:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05E521E097;
	Tue, 19 May 2026 02:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JzPun4E1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB521D3CC
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156211; cv=none; b=pderURXgI9qZKYCFcHEeGpzBrBesCGEhGzcsY8bcLOA1uCrkXx2rwL7EudUcDBAWXV1pa6TPL43uPUd9G+nh3lOjh8w5SPDRMrA/WtUHkxFDAc/J9KZgE3y4vBMqOcnD86Qiwnvu2rEZGMQzNh32NfikzA0jtKMBn0ie1OjiNrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156211; c=relaxed/simple;
	bh=TyhqiFRdhHu1smRWBkGSLgrOyqhLwvFrcrLtSt/mA1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csGEZ3fwei+XgOI7aTC5sFIFgZeL84N5+rBGyGXolmdJXdtz3qGmbK8uoi+wCHGji2Qd0U6nm4UNxgeQ+pgNLNx8tjeC2SfNwAZfAfRHbGwLpZnnCq93kSUkBiAwaIExwdrgFqRKXK5MzyuLBzJ8Pb4qwNkOIr6uC2EkKY5ouZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JzPun4E1; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0ae59679-5cc9-48e4-87e9-63299684acf8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779156207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+vWqV874IPpW4ewBwgUwR84urpudDG5k0br4WNEn1c=;
	b=JzPun4E1WbRSFPXpNDBpTV9/RTC3QWNsYye1BSG6Sw3wpB5KXCF4NfhMwTH0VPvHij2pJ+
	4sez3O5qgcbsjMHmjbBsosANXxcyu3J+NHSIVGpvX79MrNyxmvzENSkIBneUM9TSdIP5a0
	eSshyq2ZIawZIqZEB1kSgwC6k2sJfJU=
Date: Mon, 18 May 2026 19:03:18 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] RDMA/rxe: fix shared memory TOCTOU in receive path
To: Tristan Madani <tristmd@gmail.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
References: <20260518215040.1598586-1-tristan@talencesecurity.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260518215040.1598586-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20946-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C036F5763FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/5/18 14:50, Tristan Madani 写道:
> RXE queue buffers are mapped read-write into userspace. The receive
> path reads WQE fields from these shared buffers, which lets a
> concurrent userspace thread modify them between validation and use.

To be honest, can you implement the above? If yes, please show us the 
steps to reproduce this problem.

Thanks a lot.
Zhu Yanjun

> 
> Patch 1 fixes a heap overflow in the SRQ path where num_sge is
> validated but then re-read for the memcpy size calculation.
> 
> Patch 2 addresses the non-SRQ path by copying the WQE to a
> kernel-local buffer before processing, preventing TOCTOU on
> fields used in check_length and copy_data.
> 
> Tristan Madani (2):
>    RDMA/rxe: fix TOCTOU heap overflow in get_srq_wqe
>    RDMA/rxe: copy WQE to local buffer in non-SRQ receive path
> 
>   drivers/infiniband/sw/rxe/rxe_resp.c | 33 ++++++++++++++++++++++++---
>   1 file changed, 28 insertions(+), 5 deletions(-)
> 


