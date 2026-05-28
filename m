Return-Path: <linux-rdma+bounces-21435-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E8lLZ+GGGq6kggAu9opvQ
	(envelope-from <linux-rdma+bounces-21435-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:17:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 396285F62B1
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D450C308889B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E62A34389E;
	Thu, 28 May 2026 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpycXfcU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314793FE348
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992013; cv=none; b=G8qy88dLm5jnotNThSIc4+AsyqAfMepHdjnsurkgjPowiOO11EVeUKX4WTNBMUWDKGYaE6L+TF2dZbUtRHetwsglm8X9pM6t7V5t3IxszpfsZ65nnOKaXmf54WqrUpAyzWnxaUZQScCYzCL2/y/3fSi1ZCSGrlwouGoVI1qXAOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992013; c=relaxed/simple;
	bh=olgS644GXBJ8sN4D9PdM4exux7HJbLCjd7+u5JgazSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsRqRFXrcSAV/lnvmT2BRTHHNB5HGPY0G8v7FZUfB48oQbE3BbjcTIhLkdkez3Kr61J5MuVfbuHcI6wQ5Sk6W0Qpmrkk/5fec4rZn6HrptSj7YPhtIzQWpbW8bfNQeD+erSRfx99cWIshlLNl3Vj5q59OLuuALKQV42wcQzpxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpycXfcU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba4a1a0325so88876035ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779992011; x=1780596811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpxsk/T+HI611YA3BXnCwNdpS4kyHfnhJj1enlM0vqI=;
        b=EpycXfcUm6voEldLgmN0HiW7hPTdOUp6fx4Zgv2wDzUiEy973E0M0+Y0xxAnDt1p0l
         dIgX78/JUiYLxeLpEFPyYYil6gtohU64dPvZ1Dcl16mX/hKaKVgDLsKp/5KeRbHV8++x
         eQigHHLT5ZT4IVdWGEeMvK7C9HPvYHW88GyBM7qaznqzYe5PsWAuSmC4kx9COKFszGNW
         rG9+qqMO1V+06u2avvy5cfYqUQAOFYiT1eJtUGqBfLDMyvP0b4eQoUs2L8fJaZYGAxAU
         /UKC6H3ZYcPnMJ8xxM5yDXtWfLaMA2PO2ao8DNR5WbYrZwUOq6RaSfhXEc1fGhOZVFFw
         3EVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992011; x=1780596811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dpxsk/T+HI611YA3BXnCwNdpS4kyHfnhJj1enlM0vqI=;
        b=ELYTntkLbFEPAEqnjzH4YyGmkFI3+C74oyTsaS24OfOrckkbLdFCDu2eV5kuJwObtL
         r65GY1SKvP69QVUFPfCb06Z8orCfmIrNjSZ5rm7O7oGy+6QLxAv0UBd/UcK3y6+M4ojt
         oYITxMz8RHKX+MG5pOlqi4tB7ltOtHOKPtFRs3EH+5NfLh1y5YUBJjzTv/BT4g3Nc1X5
         mHyzCleyD1mXA4Q3rIZFMAabrL1wJzVUuyV1trwS6CssLwywZNVoGN9qy75116HhpUZJ
         ecOXFg5SLcIVGSMN6sN0LbiYKcb6hmURxHe+XAEz3GmDjLpr2rhZSET5OqZ3HmXOThR/
         2XYw==
X-Forwarded-Encrypted: i=1; AFNElJ9hVGg+fsKXGeKVk5vcnG4zRVGjGmgAeINuX8/MJSEjjPVkeOhiL/jEMFi1zlpvlM1AH4PtKX4Bi/+4@vger.kernel.org
X-Gm-Message-State: AOJu0YyCaMiPoGuJZnTTMElilSCfGE0qTYl8RSslwrmdudFKZxMEpVQn
	higkYxsV+Ttx+tE8pKTE4dn8xTZbIiED1gu9mJaT/OuoSjFMAGCx93A+7XR9l2cZcA==
X-Gm-Gg: Acq92OEEf8p5r5YVAv4eVOI2UXA6a/nq7sKZF2f23mstFRl1gk0llmbjofuODjfAKOx
	dYd8WbgQmiIxFTWOUAB5neAEsjliLQ3dfBA5J5IYd5rwzlPnm451ZjDyk/rCjVbc4kHFOqXJlAr
	Xq3vB+sLmZNCbVn+yUxWQCYzrncSxN8i5kijqWwIAmB4oZ8pzf/cync1alVgL0qcCbB80vKM7zL
	qHMS4V+SrDm8d91AtPxOXBu+fgEc8J+//H7g/Jf6IVLe+J/8McDvtkNZBGzO2vh1CCfyJCMfFDY
	vtzBwyxo9ZC/OezM1BX83rxhUjG+vVjiDdlkl75Y4AKLtXMWIr1DHJm2wOeEsdIRj8hZ4zAyneP
	Rfn9aCoMWH01aJ/JAUxsMBeMIb6lDxx9iB7csW3OT0lhez0hMl9MerLUCTroqh1FFJjkGEQi3nI
	44MqvZ01Bm/FAv+ONbVYuAqwxKCkpbEjD6NTDX9vu8uzmnKiHDRPlh6ZMUNvnt7hJkOS6MQlat
X-Received: by 2002:a17:902:c94a:b0:2bd:9728:5e42 with SMTP id d9443c01a7336-2beb074b967mr322151685ad.31.1779992011034;
        Thu, 28 May 2026 11:13:31 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf1e38a934sm174895ad.0.2026.05.28.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:13:30 -0700 (PDT)
Date: Thu, 28 May 2026 18:13:26 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 06/11] selftests: Fix arm64 IO barriers to match kernel
Message-ID: <ahiFxtmspbETiqWw@google.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21435-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 396285F62B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-15 02:30 PM, Jason Gunthorpe wrote:
> The tools/include readl/writel MMIO accessors on arm64 use
> inner-shareable barriers (dmb ish) while the kernel uses
> outer-shareable (dmb osh).  Fix them to match.
> 
> Add __io_bw() and __io_ar() definitions matching the kernel's
> arch/arm64/include/asm/io.h, including the dummy control dependency
> in __io_ar() that orders MMIO reads against all subsequent
> instructions.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  tools/arch/arm64/include/asm/barrier.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/arch/arm64/include/asm/barrier.h b/tools/arch/arm64/include/asm/barrier.h
> index abdc64fc3c70f0..3f7fcb2a27541e 100644
> --- a/tools/arch/arm64/include/asm/barrier.h
> +++ b/tools/arch/arm64/include/asm/barrier.h
> @@ -28,6 +28,20 @@
>  #define dma_rmb()	asm volatile("dmb oshld" ::: "memory")
>  #define dma_wmb()	asm volatile("dmb oshst" ::: "memory")
>  
> +/* Match arch/arm64/include/asm/io.h: use osh barriers for device MMIO */
> +#define __io_bw()	dma_wmb()
> +#define __io_ar(v)							\
> +({									\
> +	unsigned long tmp;						\
> +									\
> +	dma_rmb();							\
> +									\
> +	asm volatile("eor	%0, %1, %1\n"				\
> +		     "cbnz	%0, ."					\
> +		     : "=r" (tmp) : "r" ((unsigned long)(v))		\
> +		     : "memory");					\
> +})
> +

Let's put these in tools/arch/arm64/include/asm/io.h so that the tools
headers are more aligned with the kernel headers, and so that the arm64
io.h overrides are done in the same way as the x86 overrides in
tools/arch/x86/include/asm/io.h.

Something like this (untested):

diff --git a/tools/arch/arm64/include/asm/io.h b/tools/arch/arm64/include/asm/io.h
new file mode 100644
index 000000000000..8a5de4fe2afd
--- /dev/null
+++ b/tools/arch/arm64/include/asm/io.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_ASM_ARM64_IO_H
+#define _TOOLS_ASM_ARM64_IO_H
+
+#include <asm/barrier.h>
+
+#define __io_bw()      dma_wmb()
+#define __io_ar(v)                                                     \
+({                                                                     \
+       unsigned long tmp;                                              \
+                                                                       \
+       dma_rmb();                                                      \
+                                                                       \
+       asm volatile("eor       %0, %1, %1\n"                           \
+                    "cbnz      %0, ."                                  \
+                    : "=r" (tmp) : "r" ((unsigned long)(v))            \
+                    : "memory");                                       \
+})
+
+#include <asm-generic/io.h>
+
+#endif /* _TOOLS_ASM_ARM64_IO_H */
diff --git a/tools/include/asm/io.h b/tools/include/asm/io.h
index eed5066f25c4..1090a2c387f4 100644
--- a/tools/include/asm/io.h
+++ b/tools/include/asm/io.h
@@ -4,6 +4,8 @@

 #if defined(__i386__) || defined(__x86_64__)
 #include "../../arch/x86/include/asm/io.h"
+#elif defined(__aarch64__)
+#include "../../arch/arm64/include/asm/io.h"
 #else
 #include <asm-generic/io.h>
 #endif


>  #define smp_store_release(p, v)						\
>  do {									\
>  	union { typeof(*p) __val; char __c[1]; } __u =			\
> -- 
> 2.43.0
> 

