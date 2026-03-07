Return-Path: <linux-rdma+bounces-17653-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKuQN16Dq2n/dgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17653-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:46:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 883FC229709
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 02:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DE253029AF4
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 01:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD10D3115BC;
	Sat,  7 Mar 2026 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjCI2jzE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46428314C
	for <linux-rdma@vger.kernel.org>; Sat,  7 Mar 2026 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847953; cv=none; b=ECMtZNaKwonzXxx71OoCSrxgxYgUBHSr9rzZDn0CwebgdGK4swBNn3JxMg50VXYgCPZA0433U8ztY4IHTd8U51NIKo0QbqmttAATqn4AIuuWvg6kY3WHuqTQy/anwXXFwa5Vt23kSKTzaMEUiTK0GRiqhvoAyz4iWbVLA2oUO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847953; c=relaxed/simple;
	bh=27K6ObaIImAk85OCrFJ7jXYD2Gmqhz2oKSrKGLs8Id0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/HnKb9n3tpHQEg1j9mhLxfL6GgMC/cTP39DpN4EmQoW/NsdCRPu+1zC8ivs7C1DP5fNHEfqs70VcMlHEHMAtYVmHOk6az2tzxIwPfQAIP7NcDXdMYN0IdGXqE+SmqB4Hp8sJUxaOtB69vu57pi+42P6Bv6Dgd11kO6c7TcimTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjCI2jzE; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4638fe85a7eso3975572b6e.2
        for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 17:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772847951; x=1773452751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqDuTjXTwPHX6x4InRYGVJApkLP3ItbdWcKuWcdcmGU=;
        b=IjCI2jzEb8WDlnZUKSfBkOnaGiZ30Et+uAzsdwlayWq/WMRYQ3e/DGOl9/5x7zj466
         XTW6bKv0jPU76HKSkRW5w076AOoPt61MfYBLr58snzQrtDC/4TG0orR8yImM7Uw9hcpB
         9lIvr6+J7i53T7TMKf3wg18n2hOnXt5kNK2QRolALuLgQPhiadw/Zt/6Bjhno5rvlAaw
         EVqZGX4+5c1g1DHpPKXXRfqHWslpT0qqRedU+KlMYrfGPZkwkmJIKesteUHQ4K9Zl3L3
         pOKA4im5762P3hqxhQehXVMYbBFIyTdRyL0FTVuWZhnZHhuH/cizFgU9AHVQYWIakYZq
         xlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772847951; x=1773452751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqDuTjXTwPHX6x4InRYGVJApkLP3ItbdWcKuWcdcmGU=;
        b=lZutNQYL+htwzw9DB1qwmEu+7m7aGa7f0Y1seCPUrReFqTAmyi3epH7Jsl8lxiDB5s
         lHCRsTE6rFQIN59HQLa5UDTM3REdHaqrb6NYUhxRR8T/fDi0Sj+6dpOEnZKPb4vQmnOO
         +cQhysmWrDHBc12ky3t8vxWFK6WcjfcvtDnyCkRD5fcr+ggRDcVWqfFm81k9Zwyf36q7
         M0LoMBeQejgSDp/GQWm59ZnDXQNR+n1K6wD8ZpgBTYwhtMFh5DJFteSHdvr1tbCEU5FE
         z57QlfuX3XWo7BwnHVSRdN0Tyy0MJ8tDkqVKS8K3sbF4Adm9D1d9hp+rCAHlASbtV2s4
         y5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3wD8+DGvcKdzC6GZQKLdvzOCa3bshWgL3qK6JrSSA7erWMCOAXXgM18vcrbMS32sNwnaRTsZKAhk7@vger.kernel.org
X-Gm-Message-State: AOJu0YwobkNyEbg1V3+EueyU6IwY1PV+BV7Rv51Bzwqd0IwcNBrwCISl
	XpWVQbb5hMH3LaBxKAGpaqUsS2y102xdkTs3vqpR01Pifu/tKgyWOaNt
X-Gm-Gg: ATEYQzycChXD0W9FQynnrqGWGmhuuPWg7X3Ws6NejW7COJZeCJk+dVmYFXmRDbZUxri
	zgKyGNFaC0pD4jeFC9wjKfcgj9qe0ItuRh8c7JUd9lqQFwpFG6ykqnGfeb/SzbBvx+2LW3ltRRo
	pT+YCdVk0OcGtawVu1qnuQ7l4Plq0t7FwMTH7SVOrOZuXytuGJn/ifscftem2oXWjzBEN+nSbKp
	A9CCbK5G1tajA9Dtcrata0/1q4HRjY4Nsm9NqN08LhKa1hnMc4i+4LpaRjwclRYVgWltwwa6bZd
	zjbizrfSWVq1HQerHj34s6x3Cl9MFaF5x5OpGuzAYWcAonJdA1y/qLXtj1ITepj2ui+erVxZGap
	h7bif3pHBHWJW/aRRraR++ZVt1mHiu7ey/vUYKUNR+gBgmCpVIYfMSZx/yn0hxRHzXv7Eq7b8Ur
	1qF5MRqSZOfel58CuhMMjlxedeQQhNRDUkzv2JsjH0Exx4ZCJmuTngSiXmpc/6XvAtDjSEQ6+ob
	vQ6o6u1bJZM+BI3NQ==
X-Received: by 2002:a05:6808:151e:b0:45e:e07c:3fd8 with SMTP id 5614622812f47-466dcb47a12mr2086422b6e.43.1772847951167;
        Fri, 06 Mar 2026 17:45:51 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:481e:870c:b200:7ebe? ([2601:282:1e02:1040:481e:870c:b200:7ebe])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-416e68368a8sm2857838fac.14.2026.03.06.17.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 17:45:50 -0800 (PST)
Message-ID: <d8e79d96-3dfd-4008-85a3-f2cb1da2845c@gmail.com>
Date: Fri, 6 Mar 2026 18:45:49 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/4] rdma: Add resource FRMR pools show
 command
Content-Language: en-US
To: Chiara Meiohas <cmeiohas@nvidia.com>, leon@kernel.org,
 stephen@networkplumber.org
Cc: michaelgur@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Patrisious Haddad <phaddad@nvidia.com>
References: <20260302155200.2611098-1-cmeiohas@nvidia.com>
 <20260302155200.2611098-3-cmeiohas@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260302155200.2611098-3-cmeiohas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 883FC229709
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
	TAGGED_FROM(0.00)[bounces-17653-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.869];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

On 3/2/26 8:51 AM, Chiara Meiohas wrote:
> diff --git a/rdma/res-frmr-pools.c b/rdma/res-frmr-pools.c
> new file mode 100644
> index 00000000..97d59705
> --- /dev/null
> +++ b/rdma/res-frmr-pools.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * res-frmr-pools.c	RDMA tool
> + * Authors:    Michael Guralnik <michaelgur@nvidia.com>
> + */
> +
> +#include "res.h"
> +#include <inttypes.h>
> +
> +#define FRMR_POOL_KEY_SIZE 21
> +#define FRMR_POOL_KEY_HEX_SIZE (FRMR_POOL_KEY_SIZE * 2)
> +union frmr_pool_key {
> +	struct {
> +		uint8_t ats;
> +		uint32_t access_flags;
> +		uint64_t vendor_key;
> +		uint64_t num_dma_blocks;
> +	} __attribute__((packed)) fields;

why is packed needed on this struct? why can't the fields be re-arranged
to not require it and just let the extra 3B be at the end unused?

> +	uint8_t raw[FRMR_POOL_KEY_SIZE];
> +};
> +


