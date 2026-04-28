Return-Path: <linux-rdma+bounces-19619-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHm7Gj4Y8GmNOQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19619-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 04:15:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D447CAA8
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 04:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CECC9301F483
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 02:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFC638E5DA;
	Tue, 28 Apr 2026 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vz0mdGHY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7077355F47
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342523; cv=none; b=QTjAzBT+EtVHXSleNwpG91CrWHYjZ/C1Vq6FF0Itkxo0SZgI/hCOtJB/WnbqjzKm+7OBQw32z6kWxuK5BhSxaWr/SJC+jjXZ6JwNm4I2frHQ+fMZx6jgXB65fMm9M3XBn518CAGOTXb83knJxO2sgKNMpFF9JpdSy5jRM2YEMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342523; c=relaxed/simple;
	bh=nkxGLuW7w9llD4Cl9gHgWH4rjRfRUjEizKs4BPfT1yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTqu8uCYps0OyqxCHc1hO+vNSPbGn3GstE2O/nEcmUMqfvzFReTN3WiGrQq/4K7FugkVkoNxwUmLd6pgBRb0vmCsy20O2dpUCfaxy4qDMlfSNrfq7OlIQIgPxNaihEcttU23scoSbeq+aAiy2vh40oHwGlkXdeYqRyns0T4svOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vz0mdGHY; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0ef2f2e0-e437-4ec9-8ebe-21c702041acb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777342519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgOjJvb3XCt8mC/UY9IfviKJMwFQRRCL4Ls6LrRK7cc=;
	b=Vz0mdGHY4kVuJd5Ugnz2O1/ak4KIVNdmKRax5MkaosCA3xhQiLrHgGj4FPBvqUYUSrJHZG
	+yflVg4jwYAZyJPx6G30xXqs+jTA4DhjNCAxpbq1PXZ/lQpykYNzfOxd78wyUxY/n6V5jL
	3Y2kbSw6uy+Vb2awkzIo9yJiGJ8VtLA=
Date: Mon, 27 Apr 2026 19:15:14 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in
 kernel_sock_shutdown().
To: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 linux-rdma@vger.kernel.org,
 syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
References: <20260425060436.2316620-1-kuniyu@google.com>
 <20260425060436.2316620-2-kuniyu@google.com>
 <030d3487-b5b9-4067-8b8c-89b4e8756e1a@linux.dev>
 <86499305-4522-4a82-a689-0247f2d5f6c0@kernel.org>
 <4196fe33-88c2-416d-ac20-b68bf7f328a6@linux.dev>
 <CAAVpQUAh2KT=YpfDO5nkqrzH0kbAXEBVe6jtOtLc93wjs3N7Fg@mail.gmail.com>
 <e2e1406f-8d9d-4a96-949d-e75096446d1a@linux.dev>
 <9681c9e2-79a9-4d72-b1ad-229ba6d7aab7@kernel.org>
 <0cf42593-0149-4019-a51b-36f74ff67f51@linux.dev>
 <CAAVpQUDVb4VDibeXz-DmAHF7gOAvDenSTGA6DpEwwS5HaQjM5w@mail.gmail.com>
 <0c1258e2-7060-4084-9a07-dd7af8262dec@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <0c1258e2-7060-4084-9a07-dd7af8262dec@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: DB1D447CAA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-19619-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]


在 2026/4/27 17:58, David Ahern 写道:
> On 4/27/26 6:52 PM, Kuniyuki Iwashima wrote:
>> To be clear, you meant implementing David' idea, right ?
>> I'm asking because dellink won't need locking then.
> dellink is not needed with my suggestion. It was added to manage
> basically a refcount on the socket to close on last rxe delete in the

This is my original implementation.

@Kuniyuki Iwashima, can you reproduce this problem in your local host or 
other test environments?

If yes, can you make tests after applying the commit in the link: 
https://patchwork.kernel.org/project/linux-rdma/patch/20260424043522.22901-1-yanjun.zhu@linux.dev/

Thanks a lot.

Zhu Yanjun

> namespace.

-- 
Best Regards,
Yanjun.Zhu


