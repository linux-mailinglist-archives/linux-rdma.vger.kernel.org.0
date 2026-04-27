Return-Path: <linux-rdma+bounces-19597-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLz0AKur72kCDwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19597-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:32:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3D4789F9
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38D6130A8508
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D913EBF16;
	Mon, 27 Apr 2026 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8HK9Rkg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425703BC680
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314439; cv=none; b=V0AXeQ9aFHePl2EAtmIluHi93QfgBzpTrpofhvizCUdOlyXVshID4YXyq3Ik/1oAc+kBqzRlc1d8pJs6kBuC3XAqBM9/v38Qqfpa1Gkkh6O1smny72tdQV3L87uVnEjp0sPk62C/6smu/DISH9gR5M5lF9/O9szg1vfzFJ6TnTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314439; c=relaxed/simple;
	bh=hfkSb5iSK+jnG60DLGgd+UagdkvWshNa7oLEFPu+t10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=az42dHvlnnZoJr0MgKzfcedjG9by4isGZ9xGn2Hab1KcgG5DYXOxFqjGDffr9tPJ7oSz/uPtJGF6Iuc/hVt8xa03O3/2KX7loGzYC59oLoPvzuSk7W+X2JAy34FS2UC/sFMRQnZDzascL9nTEhqx4SFbpaBNYEqz/eEQBgUJOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8HK9Rkg; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4645dde00a7so8117336b6e.1
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 11:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777314437; x=1777919237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUxrFoC8fiASca5qWozFg3oZ8Q9N01+/TQY2br6q3VU=;
        b=L8HK9RkgWrv6nUTzfogIxwsJdEHW+phreVVAqCTMP7+x4J8+w77VbeVmGYbQhtC6hx
         ZuHPtkESsyJr8hvj5amfMql/9w27Fpc4XBODbQkLXCFtJgDJ5DKod/FxPwk9NVSLkL2Q
         P5S4x/fgsV0i1w8jilvdxasdIPPQC1T22kdswSWrsMn2kJ+nzejAhTDQeinmc2wgicaI
         PoihBmqT1g0ozW7vbSyrqNyM6r3BDMZVHid7OFif+iOlzI7x1uM6movOkb8Ly33HutLG
         MLlbPlPfp+mlopj6hEe2CAgtyPzJOBFl+TUYu38CJ0nebGIA0o0ui3DXRQmvjSGcBZif
         YqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777314437; x=1777919237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUxrFoC8fiASca5qWozFg3oZ8Q9N01+/TQY2br6q3VU=;
        b=YIbEOtnh1Q1BOQQOhjB9Q55ZQObtdpLWeiNXTG6DIDzxp4s3TVgCba0x4zsp6WUI7M
         qviRxLFvxRH5UJBBP2JQTYnewoaBrlEBACM3DTRrs1B+zT6I9m9aiUzvPovjG+NOxrjr
         KTjvIDQskPy3SkihBZ3G+4gv62C+NAmajAoXS5F0QFVkY5fbq2yNqWrCVFtuPB4y+O8Z
         MZNXTHd4FCn+41WGhZVo+MZm8RlIipKvp3WVqAxlWyYG6Pntnu1xJFoOKbfmGltg3IcW
         l4bBpEnD3J+EmAXMqHJBf+p2W0/nPNKj+oTNnb4zXNEokYCtsA1aR8rvnVIY2vMji2Pd
         7Xsw==
X-Forwarded-Encrypted: i=1; AFNElJ95U63ZsYA9JQhiCzmdCnsdHizK8k0+3v2ubFK6HVYRs2SDQbIpCUvBz4aKANUkebrTnljH4M+gzpgX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfk1G7ONdwWhTs0REB5o5ayjgkT0tFDW1yo8Zq98T1K+P/QpS8
	cAt2vaDplMYOYzUnv0kZhcMBLGno5vvELJckCO/Z7tSo55nB5jZMRz2m
X-Gm-Gg: AeBDieueyRT/w/nET2RrdLS+aP0Gsp3Bu6j4rbflHss1yRafyBTQfucOH6egguM/nL5
	AyOstzzWuv08emK6PkPkwI2hnuEyXy+lsy6e6jZiHU+0ZmOHJrpqYFseb/ZcU1AN8UxrJ9c5k35
	RjlXxmEAq/Q2TH1Ukvh7w/cki2kaYtvX9Ux3bxnGFaqin4iUf7pukP86qwJ93wvIGb+Fs1U3RgS
	Hwt7jYwue3PlofEM1I9yVlN/YFKOT8ZER340UAgPK1F/rFz0mZwedCvLN/3vHl+zwR2XliJTO9m
	6vMSe/MyCgUxC5Z9CR8ViGiehSBrygDhMVxv3Wz3wyCxgzsBs2h7V1bq6K1oaKG0gAWEXx/jg1b
	kB4Qo3HvhcGfVeW2X8+g9HMZ/UMWtrSxPfERBLoMmkX1BxulNTb3C/xkXjt8q6qNwEdWxAMiB3y
	a6FiZkJ7cRUEVbBq0VhRk8u+Zan3wJL/I5JCupssbqEE8tZd3LJVAFdJY1qJrKlWJ+JzX1sv3CZ
	ER607yuw5kfeDvpSFmVcPRZzVku
X-Received: by 2002:a05:6808:3448:b0:472:c4ba:32d9 with SMTP id 5614622812f47-47c26cba3fdmr138293b6e.20.1777314437166;
        Mon, 27 Apr 2026 11:27:17 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:7006:cec4:dca9:62e0? ([2601:282:1e02:1040:7006:cec4:dca9:62e0])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7de986a6da5sm124806a34.20.2026.04.27.11.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 11:27:16 -0700 (PDT)
Message-ID: <77e1a762-e204-497b-b7cb-40d5a93f8ec7@gmail.com>
Date: Mon, 27 Apr 2026 12:27:15 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next 1/4] rdma: Update headers
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Chiara Meiohas <cmeiohas@nvidia.com>
Cc: leon@kernel.org, michaelgur@nvidia.com, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Patrisious Haddad <phaddad@nvidia.com>
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
 <20260330173118.766885-2-cmeiohas@nvidia.com>
 <20260427112505.684c21f3@phoenix.local>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260427112505.684c21f3@phoenix.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72D3D4789F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-19597-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

On 4/27/26 12:25 PM, Stephen Hemminger wrote:
> On Mon, 30 Mar 2026 20:31:15 +0300
> Chiara Meiohas <cmeiohas@nvidia.com> wrote:
> 
>> From: Michael Guralnik <michaelgur@nvidia.com>
>>
>> Update rdma_netlink.h file up to kernel commit dbd0472fd7a5
>> ("RDMA/nldev: Expose kernel-internal FRMR pools in netlink")
>>
>> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
>> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
>> Reviewed-by: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> The upstream macro names changed, the iproute2 build is broken after
> current headers sync.
> 
> In file included from res.c:7:
> res.h: In function ‘_res_frmr_pools’:
> res.h:203:26: error: ‘RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET’ undeclared (first use in this function); did you mean ‘RDMA_NLDEV_CMD_FRMR_POOLS_GET’?
>   203 | RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> res.h:56:44: note: in definition of macro ‘RES_FUNC’
>    56 |                 _command = res_get_command(command, rd);                               \
>       |                                            ^~~~~~~
> res.h:203:26: note: each undeclared identifier is reported only once for each function it appears in
>   203 | RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> res.h:56:44: note: in definition of macro ‘RES_FUNC’
>    56 |                 _command = res_get_command(command, rd);                               \
>       |                                            ^~~~~~~


Looks like the merged API does not have the _RES part of the uapi:

kernel vs iproute2:

@@ -590,19 +590,19 @@
 	/*
 	 * FRMR Pools attributes
 	 */
-	RDMA_NLDEV_ATTR_FRMR_POOLS,		/* nested table */
-	RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY,	/* nested table */
-	RDMA_NLDEV_ATTR_FRMR_POOL_KEY,		/* nested table */
-	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS,	/* u8 */
-	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
-	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
-	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,	/* u64 */
-	RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
-	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
-	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
-	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
-	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
-	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOLS,			/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_ENTRY,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS,		/* u8 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS, /* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE,		/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,	/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,		/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY, /* u64 */

 	/*

