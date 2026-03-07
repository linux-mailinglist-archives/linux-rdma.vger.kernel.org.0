Return-Path: <linux-rdma+bounces-17652-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDQLJEyDq2n/dgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17652-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:45:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 387F82296F4
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0907A30265B9
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 01:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E739C3191D0;
	Sat,  7 Mar 2026 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCKDDBs/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AE31AA8F
	for <linux-rdma@vger.kernel.org>; Sat,  7 Mar 2026 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847944; cv=none; b=aavUX4KUcPvSH0NMlEs872spiBTU/1/ciMLbUI2slVHPrsfFNPH+uKr65l8bZOkyIMWpL0cfca6qXnpojm8/Z8N/muUqM0H0DKw9Wu2IKeJcxwkuHP5BjIAvq1KajmubGn9xvb4J6KVugXjwCVzTOKt7/x7EBlmN/rxBhc1de/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847944; c=relaxed/simple;
	bh=tIcnesEX5pvJrJP6mxto2J3YWaErfy6PMHz/co58Hk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOtG9FGnx50ETjKy1KUslHyQr4N/veJ7BGCz/pJjWiP9Mh1aDV57M/Gv0iBPgWRTxIb3hez0SG6CQvmZj52Q5oV2ifJrk/cZ2DhM+bJM3RypKk7+WNowA1xp9LEC2DhWI/Ef8tqigiZmBCVRSX6qeImnJYpqjjbzVNrkc85OE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCKDDBs/; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40438e0cba6so3299176fac.1
        for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 17:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772847941; x=1773452741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAXbtfx1R4MWQt4sPmc7JCtd9Ano5uGSzagBUlJwAoM=;
        b=XCKDDBs/tW1ktDinLMNEWLNkzbLd8ynr/gk2zgBvr/dh1kxZnFPRTAjJi9I/TiJeYC
         dnsdXnvw5rfk5q54saYxKQ3TT3awryV3es71uCMZTNoTN3hnoSORnDd7PLEOr3LEcst/
         v+YJKiCTs2fEUGVI4Vql71f2MeqvcR4YzhzWzHNMb41Q5qQH9aUmRR5/I6/z8eodSIOE
         ENnRUkZVWKLW8qlCAxruToSVOMrp1lCivoHfMDLVtTSJ+l1Zc/SaekwkhHqdv7/904aR
         URFJMFmBmKnTF/zxl66vvI9ojfCUu8tl3u+pDw4MnPmYbInT3ffjfPz82fi8mzRDpPNS
         FknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772847941; x=1773452741;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAXbtfx1R4MWQt4sPmc7JCtd9Ano5uGSzagBUlJwAoM=;
        b=tBKvClQlFU6jjrDoPXjL9dGh3ISBklpL9ClVUQyZB3ZTZbpFpow3QEAKx3nzl8yJ2/
         4Tvy1fR+WGq3m1w4XQBe3d4d/KOeQzBvG/tTR30PgjH/L1XsMDkhnIBdXLMB6VMCAcP3
         TvpRrOOlkvPtZfh7GtYJR/9+aNcOpEG9AinmhxTaTr84whQLg8yHRB7Op2q55JoTkGLh
         3lB8KNB4dd7rXkR+EK7L1BFGKf4qroMbmFMph825YwuaAZE9r99dHUuODGxuJAaocQ/S
         j5R+UAuId9lOkxOiw8szQ8foOzlBJwl9CQlKqjBLivrkxkJRru4RmT6oWi/Lno0YP6DQ
         p5eg==
X-Forwarded-Encrypted: i=1; AJvYcCX2+X86+W6CaLB96nN5l6UL6gy9SLRSA2tBHhVpR6PHwVUhbQa1r2vWZULk6Kji1BFgsiMr1/aNB3oO@vger.kernel.org
X-Gm-Message-State: AOJu0YxUo8cluvYveNGf3n86qbUWrmMuVyensTMkwrjmiio14qWN2X+f
	ZQ1HkczHie/xzR9MmrUU3XvuoeInD3eo3ZBn/Fx41q3qkQT3DzbIHeON
X-Gm-Gg: ATEYQzx4isJ6Z2VEUjuqxFeH/W7qELuZaCanbTo54E7ymwwepIOYXlvq3vk3NTp9geV
	RMuewDhRiEwPHFgOk5Z952fwfx0k6gmgCIBf7nsAKRYdplPr1YVyEBVxofNz+N1DvxOI9deAEzd
	CIlN6uX7TLxxARRAUs2vj8TMl8dJO+itIh6WExu9hrM6HNEhvn6kE2tX41EzcKgUD1VA83Cw/0z
	eJoiffD58DpplbTBl7C1V/kprpyky0H/Kzeiu79vrgahQxDaBwODuNQmvxSwQ5rk0phhMEyjXhX
	uoiuq0cBXNDHkf9zvzBEqhLw2JbLjvsVYwax8H9X7QTKkhvLq1bsvBVmyd9C39bdV5vl05nG2by
	Y+XR2hWY1xQ3/9thNez4WGlTPMO9msjYoA+fIGWWzR+4fkvtIPj8/csVVsZ2/+2E1ppLf3oZAxz
	iIGn3g6/9x4MhyccPlriMMoBZxsBm2s70IEMNyJkSjryGsg0Wq04fSJsr55n4eqkcuyBTJvem7t
	SMZuj4PxoPkXHl1hw==
X-Received: by 2002:a05:6870:374f:b0:40e:eb2c:8f6b with SMTP id 586e51a60fabf-416e448a08fmr2339974fac.26.1772847940680;
        Fri, 06 Mar 2026 17:45:40 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:481e:870c:b200:7ebe? ([2601:282:1e02:1040:481e:870c:b200:7ebe])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-416e68368a8sm2857838fac.14.2026.03.06.17.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 17:45:40 -0800 (PST)
Message-ID: <2a638f50-6d22-4abe-9f20-74367a0f3295@gmail.com>
Date: Fri, 6 Mar 2026 18:45:38 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 0/4] Introduce FRMR pools
Content-Language: en-US
To: Chiara Meiohas <cmeiohas@nvidia.com>, leon@kernel.org,
 stephen@networkplumber.org
Cc: michaelgur@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260302155200.2611098-1-cmeiohas@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260302155200.2611098-1-cmeiohas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 387F82296F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-17652-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.877];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 8:51 AM, Chiara Meiohas wrote:
> From Michael:
> 
> This series adds support for managing Fast Registration Memory Region
> (FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
> pool behavior.
> 

Claude has some quibbles with the patches:


1. Type mismatch: RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD

In rdma/include/uapi/rdma/rdma_netlink.h:
> +     RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,     /* u64 */

In rdma/res-frmr-pools.c (res_frmr_pools_one_set_aging):
> +     uint32_t aging_period;
> +     mnl_attr_put_u32(rd->nlh,
RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,
> +                      aging_period);

The uapi header documents this attribute as u64, but the code declares a
uint32_t variable and sends it with mnl_attr_put_u32(). This mismatch
means userspace will send a 4-byte attribute when the kernel expects 8
bytes, leading to either a parse error or silent data truncation.

Fix: use uint64_t and mnl_attr_put_u64() to match the uapi annotation,
or correct the uapi comment to reflect the intended wire type.

---

2. Type mismatch: RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED

In rdma/include/uapi/rdma/rdma_netlink.h:
> +     RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,           /* u8 */

In rdma/res-frmr-pools.c (res_frmr_pools_line):
> +     uint32_t queue_handles = 0, pinned_handles = 0;
> +     if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED])
> +             pinned_handles = mnl_attr_get_u32(
> +                     nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED]);

In rdma/res-frmr-pools.c (res_frmr_pools_one_set_pinned):
> +     uint32_t pinned_value;
> +     mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,
> +                      pinned_value);

The uapi header marks this as u8, but the code reads and writes it as u32
using mnl_attr_get_u32() and mnl_attr_put_u32(). The type used in
userspace must match the kernel's attribute definition.

Fix: decide on the actual wire type and make the uapi comment, variable
declaration, and mnl accessor consistent. If u32 is correct, change the
comment to /* u32 */; if u8 is correct, use uint8_t and mnl_attr_put_u8().

---

3. Declared but unimplemented: res_frmr_pools_idx_parse_cb

In rdma/res.h:
> +int res_frmr_pools_idx_parse_cb(const struct nlmsghdr *nlh, void *data);

This function is declared alongside all the other *_idx_parse_cb symbols,
but there is no corresponding definition in rdma/res-frmr-pools.c.

Because res_frmr_pools uses id=0 in RES_FUNC:
> +RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
> +      frmr_pools_valid_filters, true, 0);

the macro's idx path is never triggered, so this won't cause a link error
in practice. However, the declaration is misleading and inconsistent with
the other resource types where the idx callback exists because they pass a
non-zero id. Either implement the function (if per-index lookup is
planned) or remove the declaration from res.h.

---



