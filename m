Return-Path: <linux-rdma+bounces-15858-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ly/K+EscWl1fAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15858-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 20:45:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F415C737
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 20:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9CDC5ACCCF
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E71320A22;
	Wed, 21 Jan 2026 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lambdal.com header.i=@lambdal.com header.b="SvT1/a1S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A036C0B3
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021685; cv=none; b=mnaP8b1NviPqfoWz8OjRP0WKcxBJYIDaTtHZmALG7mCnp/BSIBikQKOHOYgux9LMp4D3YwfcgMzpCSFM8LlNF5N2TDOybMXP2gd0DDjGrMJNwdO30FW86OT2aEOk0wZKRbgUwEsOU/gdbBOhNsSYmWmxKWELqM4TrvHm5VqF16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021685; c=relaxed/simple;
	bh=fDU/FZYKBnUL/eVuf7ZzfL2swvnJTMhUNQTr+O6blJw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=A/uhycAdh5BBKqEdKC3fjCJxa4dKHv1g0EMi79jhFLQ6Z5DdEpatzw8R0m8cmJ43HkMNpetbXclQ+wwwWeLJZxXY9HNlQvEAO7qvJ6Z4xOtYFMQ54vB0TpNvhESkxq+V2jPDzA7OQ402PyBeYPyYQS/EQRgpsR29rg9lg9GkpVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lambdal.com; spf=pass smtp.mailfrom=lambdal.com; dkim=pass (1024-bit key) header.d=lambdal.com header.i=@lambdal.com header.b=SvT1/a1S; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lambdal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lambdal.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b4520f6b32so223434eec.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lambdal.com; s=google; t=1769021679; x=1769626479; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1/SSFKkEc933R8HfYhnn2yQwfXCPtcVBT/pBNZE/gk=;
        b=SvT1/a1SybjmQ/TDTNKggMDyKV/FQjKrRw3lMiKTTETo33hmY3DNf3z68k/FgCvn/y
         zQRmN3V3/DA+pOgbOPVr+G6ZFD0zsXjCXC9vFUpa6d7wmXIJIZjIf+qnJ8XPGMqFl56f
         xrV+TSOj7BJE9qYYMmkYSg5NiacKT5KL/54f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769021679; x=1769626479;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1/SSFKkEc933R8HfYhnn2yQwfXCPtcVBT/pBNZE/gk=;
        b=NjplJZkMbSQgiiaoCMuNEk6zu1B6fgUGo8vzKMB9uQLowEGX2QE6OIzEQUMKY9WnxZ
         Mu4du85MS2j0HXvgThjHwH0XhzaF3plPLzUgRov+/8V95jKGqeV6hg99ik3llhtf4x+I
         LnM30BTRGsLHbH6YhVgH3CnYOOh92HnOk0ND/qx72npW6PIrMUTVCZag0v9/r1pNc3/0
         1xWVbu2YvpQAbASjefxlu7+uNiaGv3sqsNa4xtd4O3+rQGBc2o9foo6qyt1DDvrOoAdX
         EtMHbyv0zRN2caQuLENZjFvpZ2iIdtq6ApIt8H7r8GjEtUR5LA7Iok8CauFxeD/o1vf2
         iqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS/Ji6piJoJXeTPPrIFMP98XErG5jnSHNaBING2f8QTmQm2hGid5Z31JPdtLzO1pMOj3hRdoK2tyOc@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYeZUY/gz7eFcNTiN7mIWKVdpADYJPXH/LgKR57wzLROzeomp
	R5PsjtGdIjHQvbuIyLMmiQhlx0qqCTYTqqVgvGpz9HqOiWQallbfLGEfYGAW4ilJ04Q=
X-Gm-Gg: AZuq6aK+3cLFeO5utLL/gL/7fBQdKXLmMUyT+3qkE/nl5S8aR0QQ4ApdBe8RugD2Jts
	EtLtq7D54dvf83JROkbN2EA3nBP/EfIvqjYgodIirqfxDFjkID1dexLlaNBeEIpp94qnjfbdkM7
	xzeUwWyjrBXnwz+/Bh2jsaGxKkZO7MCEehcXqnn+nfxQH+al6KKBiyt/1pS7gDvrReaz90d64aW
	nWtKqw0OkGjzJrIlM8JP85FOeg+tk+p9N6LrgAT4GzlUyZKpKwvOOB32AarCnWEcb/hE6fyl2Rp
	o/J/4JOtmMqPZne1flnJ3VsOky97TvA8N3mLvQyC3jXn4ANT64YVPwe/EkKZl6AUAH2xvBkBH8P
	Ab1Hxu3SAuTqZw212HhYDzEjSsEcnGEKMJcO+2hzw8d4PootfM4XX9nNtiUHSRLntN4UQtpKYBr
	G6bUckOQ4N9msenz5xgjTvos+ykRi3VEg588Z2FsJB2Q4S05XlSmHqZHybnIvg9y4lF7/8jWuh
X-Received: by 2002:a05:7300:2155:b0:2b0:4b5b:6820 with SMTP id 5a478bee46e88-2b6fd78dfcdmr3627600eec.26.1769021678558;
        Wed, 21 Jan 2026 10:54:38 -0800 (PST)
Received: from [10.100.9.95] (LAMBDA-INC.bar2.SanFrancisco1.Level3.net. [4.15.73.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7093325e4sm6135704eec.28.2026.01.21.10.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 10:54:37 -0800 (PST)
Message-ID: <70f5170f-70eb-4244-9049-a994ec503ac6@lambdal.com>
Date: Wed, 21 Jan 2026 10:54:36 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
 leon@kernel.org
Cc: bilbao@vt.edu, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 carlos.bilbao@kernel.org
From: Carlos Bilbao <carlos.bilbao@lambdal.com>
Subject: [PATCH] RDMA/irdma: Use kvzalloc for paged memory DMA address array
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[lambdal.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[lambdal.com,quarantine];
	DKIM_TRACE(0.00)[lambdal.com:+];
	TAGGED_FROM(0.00)[bounces-15858-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.bilbao@lambdal.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lambdal.com:mid,lambdal.com:dkim]
X-Rspamd-Queue-Id: 56F415C737
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allocate array chunk->dmainfo.dmaaddrs using kvzalloc() to allow the
allocation to fall back to vmalloc when contiguous memory is unavailable
(instead of failing and logging page allocation warnings).

Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
 drivers/infiniband/hw/irdma/utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c
b/drivers/infiniband/hw/irdma/utils.c
index 0422787592d8..59ef9856fd25 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2257,7 +2257,7 @@ void irdma_pble_free_paged_mem(struct irdma_chunk
*chunk)
                                 chunk->pg_cnt);

 done:
-       kfree(chunk->dmainfo.dmaaddrs);
+       kvfree(chunk->dmainfo.dmaaddrs);
        chunk->dmainfo.dmaaddrs = NULL;
        vfree(chunk->vaddr);
        chunk->vaddr = NULL;
@@ -2274,7 +2274,7 @@ int irdma_pble_get_paged_mem(struct irdma_chunk
*chunk, u32 pg_cnt)
        u32 size;
        void *va;

-       chunk->dmainfo.dmaaddrs = kzalloc(pg_cnt << 3, GFP_KERNEL);
+       chunk->dmainfo.dmaaddrs = kvzalloc(pg_cnt << 3, GFP_KERNEL);
        if (!chunk->dmainfo.dmaaddrs)
                return -ENOMEM;

@@ -2295,7 +2295,7 @@ int irdma_pble_get_paged_mem(struct irdma_chunk
*chunk, u32 pg_cnt)

        return 0;
 err:
-       kfree(chunk->dmainfo.dmaaddrs);
+       kvfree(chunk->dmainfo.dmaaddrs);
        chunk->dmainfo.dmaaddrs = NULL;

        return -ENOMEM;
-- 2.50.1 (Apple Git-155)



