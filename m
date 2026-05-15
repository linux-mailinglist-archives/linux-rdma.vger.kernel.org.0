Return-Path: <linux-rdma+bounces-20757-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD7mEZ+qBmoOmQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20757-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 07:09:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6254976E
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 07:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B164E30167B8
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 05:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0562E3DEAC9;
	Fri, 15 May 2026 05:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ey7bwlA2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F43DEFE4
	for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 05:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778821763; cv=none; b=uAb1l07mzCZt4wTxFD/o077++V5qA+92dyDVM/quqbLNMRU0eCjaDZsD2DQnnS5gqgd25Z7YfuQ9BGsTj4L1cq/4PEQQ71Ve+V2eA4AG1B5s5rCsuINwnqKYwFGYE5BLKolJ2uR/GbZLGUpzWFRQF+eFlR07aNhp4Zcnq3UndTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778821763; c=relaxed/simple;
	bh=OwtjSsmh2bjZvbPpcCkLZmdhL8zYpHDC78+7skjJcIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEnKWtMmYgc3Axi1/K5VE3G6C8ERVeAmrkzLqxy4T+iUgbwNz0aNiAwtG1Qf9MmXQ2vGOyCofe+QwN2b/2GPbQ4iFOrfL8imJxLx6HFh5q/RJ86SQoQSCzJpYKN68olABOmCbh6vHcOzpYkjEi6JUzhEZ4vNixJDCia73/yJ0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ey7bwlA2; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac4a8f98-7986-42d3-b6ca-28f514791b79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778821759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRPxaxwfO/BvZYZRx9bZyW2jRCny4Mnqi4QzNGPMgNM=;
	b=ey7bwlA2CrHTMnrV4pctiBCKR1qzPX4WWRMherY+ZkN3Y79hp/I9+Ai87dBc+gF18EE2dx
	gdNJeDFTBZgxV2iIx6UuDlKBAhd6ui/E8ut+rpz+l/oyHC7ia++mvshDI9VjIDVLRUnoVY
	JkE0u5Kx14U6lawUnfQOlYKaJwf+Ctg=
Date: Thu, 14 May 2026 22:09:11 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Add initialization of AH cache
 rhashtable
To: Yonatan Nachum <ynachum@amazon.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org,
 mrgolin@amazon.com, sleybo@amazon.com, matua@amazon.com,
 gal.pressman@linux.dev, Firas Jahjah <firasj@amazon.com>
References: <20260512061121.2177521-1-ynachum@amazon.com>
 <20260512061121.2177521-2-ynachum@amazon.com>
 <346a4118-4902-46a6-9245-ef37322b30b1@linux.dev>
 <20260514100214.GA22423@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260514100214.GA22423@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 10F6254976E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20757-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action


在 2026/5/14 3:02, Yonatan Nachum 写道:
> On Wed, May 13, 2026 at 10:12:01PM -0700, Zhu Yanjun wrote:
>> 在 2026/5/11 23:11, Yonatan Nachum 写道:
>>> New EFA devices don't support the creation of multiple address handles
>>> to the same remote on the same PD.
>>> To overcome this limitation, introduce an AH cache rhashtable which will
>>> store the refcounts of the same AH creation on the same PD and will
>>> allow the driver to manage AH reuse. The hashtable key is the
>>> combination of PD and GID. Add initialization and teardown logic for the
>>> rhashtable.
>>>
>>> Reviewed-by: Firas Jahjah <firasj@amazon.com>
>>> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
>>> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
>>> ---
>>>   drivers/infiniband/hw/efa/Makefile       |  4 +--
>>>   drivers/infiniband/hw/efa/efa_ah_cache.c | 30 ++++++++++++++++++++
>>>   drivers/infiniband/hw/efa/efa_ah_cache.h | 36 ++++++++++++++++++++++++
>>>   drivers/infiniband/hw/efa/efa_com.c      | 12 +++++++-
>>>   drivers/infiniband/hw/efa/efa_com.h      |  5 +++-
>>>   5 files changed, 83 insertions(+), 4 deletions(-)
>>>   create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
>>>   create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h
>>>
>>> diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.h b/drivers/infiniband/hw/efa/efa_ah_cache.h
>>> new file mode 100644
>>> index 000000000000..25288fdf778a
>>> --- /dev/null
>>> +++ b/drivers/infiniband/hw/efa/efa_ah_cache.h
>>> @@ -0,0 +1,36 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>>> +/*
>>> + * Copyright 2026 Amazon.com, Inc. or its affiliates. All rights reserved.
>>> + */
>>> +
>>> +#ifndef _EFA_AH_CACHE_H_
>>> +#define _EFA_AH_CACHE_H_
>>> +
>>> +#include <linux/refcount.h>
>>> +#include <linux/rhashtable.h>
>>> +
>>> +#define EFA_AH_GID_SIZE 16
>>> +
>>> +struct efa_ah_cache_key {
>>> +	u8 gid[EFA_AH_GID_SIZE];
>>> +	u16 pd;
>>> +};
>> I am not sure if we add __packed to avoid memory hole.
>>
>> Zhu Yanjun
> Currently there is no holes in the struct (verified using pahole) and we
> Zero-initialize AH cache key so I don't think packed is really needed.

I’m wondering whether you’ve tested this on all architectures.

Explicitly using `__packed` or ensuring proper memory alignment

would likely be a better solution to avoid memory holes in the key 
structure.

Zhu Yanjun


>
> Thanks

-- 
Best Regards,
Yanjun.Zhu


