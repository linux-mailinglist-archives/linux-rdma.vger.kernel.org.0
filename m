Return-Path: <linux-rdma+bounces-17644-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHqAF3puq2lqdAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17644-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 01:16:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE193228F20
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 01:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 866343030742
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 00:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637A1FCFEF;
	Sat,  7 Mar 2026 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f326SsiA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21519AD8B
	for <linux-rdma@vger.kernel.org>; Sat,  7 Mar 2026 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842615; cv=none; b=pD2pMa82YtXIeugF3bcrKo+ePZJqqo27N0geoOCuka5GJJXEausTc4zW2oa0tu5/VA9n8sJCrSWQ3sGBQ1s16zoH2DvAASszPBG53bWJTsE2FKr8V9qC+aqsNTImDpwEG3Izv7E5rA1MkBuOpmNMIstWUl1EDI+8NG5AWJsSSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842615; c=relaxed/simple;
	bh=1jv0YDV7RqtdHN2gn4yLfwYeFPs7ErJgmFYQAG6c4fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRwTHUaOutPbLG86+OLwgf34oRHBrEXAcCcPbX0wP3mD2wxrElK70nHJYpLb+9/I/+NOP+zmRS2OCXx0wJ9N3MwwSAWcYM/x/0Mr33VfoUY3rBD5VgdyMOTkZ/JjO1HAx8jhMa9EVBkE90NSCB5fptA7KlgxIporZbzg7b/dw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f326SsiA; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40427db1300so3406445fac.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 16:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772842613; x=1773447413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khtC211O1SPtjgbhHkTQFVSuPgpVRPnMlK9wnraiQFs=;
        b=f326SsiAz7HyCwRtKvTPOZwnlA0cFq66ndD7DS3dBnG7oMXxo0HQxpoh2d36FsLIgb
         vKd3OOVWAYm8a2fF4GhMRCOvNAxONvbyYEfL3XhuOgbAKE647wN8d0kWVgoSCTwgEmHd
         zQTC7HwgeLhi+kaeqHrrVKn7Oq7mbmF10syOm28Q9FxgUYNFXfxunUZxamfN3MkmyX8I
         z9BZD3A5p3wPI6vZI1TMt97rzu5KTDQQGo2nFQwZB7RHzpHRHiQF1aDYKaEzjMcYE2kA
         vHLhSmmPOPUuDYlIYcw9pVNXoBfEq/hhCkVraZmAP6AnIgvj2UPKGA5+ZOqX2r0vNAip
         E2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772842613; x=1773447413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khtC211O1SPtjgbhHkTQFVSuPgpVRPnMlK9wnraiQFs=;
        b=trJVPBEEU6XFtjuM8sbkhlVqU2hNyy3rFpr8ga9zm+1c0Kd9yE43KJYoqyngYnJ4yK
         5JpAvLAfHX/Ybzc6IsTjSGhAx9Cx+fkXsUk12KK/9zEXPdUklKQg25LfMdztTASt+/r2
         JqO8GmFrCyEsMbq1LBXmNvTvA5mEbxnxocp566rnGZdsrjYgKOyaqK3ze+n/NklFLl3l
         dZTJqrVvBzdDYAVSKcWv/vxfKaumsZccyuRW/IDZpWkV0pfU5TXmDPQ8ST98+Q4XuBwx
         cSwLLN4b8DmAWY+Wju98igK4+BLeaQOgbdIxIzRBMw2BdHmXjV/iP2dmMaJqTDQdlPNZ
         mHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtrwl0z3DQ9HnKwLBoX1bO11jveM9auXTAEnO+nBISaE1pKQvP2p3XROgZ2iRIbIZg+ai0wMni2O1Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyKD0kryXlP3wFQoTcIEiV8kLETcCtfyuklCg3KRnOAKw932yeV
	GNfKUDsQxc+vJ4TfYVvFOV5+m93957wBv9uefci8JsFmjCrOyJd3lhNM
X-Gm-Gg: ATEYQzw44mxRajrCcpD3lGN3CPjxoZFmQsSP0je8g5VHzLW2YCr7c3ntlseF8U+opaB
	55Z8sqJ+6zolFW4MXSrqkJkmS7VR+NsNU8mziW3OBOnasVA3buEMICLqBWH5sbJvk5BArKZ81+3
	t0F0qbLv4Y0F86irZ0OtG3lELdP89Sta73y2I4qnHng8QKJ5RyQrMhNw0KWAgpTJZcW8M/t8QLm
	EP3Db/n8YNs0rAlMou+zeKJYHAvVr0T85wpSc3E9spz8PGPpcY/o2Gh/z1vW9FFgTv3SyFGipYe
	U1vD4W0HIR6qrPqbWOYfrcp7mZn/vX08SDtfNS/VbeiiC/8uRciLCzud83zvHQPWa6n+ZVo05oH
	qDPV7P4M43Wt1DOMqm2vIljIjBKj9ZIjfm2HjLKEec5+kMKb23dbeI2z8CfmylqP2h6rtZ6O3gS
	FmEKemaqejxtBC0yfRzXaiSnbC9azuaFwmCRNl8zY75hG/XGZJQ+LR36C6eA2voKZqPYK/IGsh7
	bj4xOnLWHhBrF7SNN9F/Levdm4c
X-Received: by 2002:a05:6871:7817:b0:409:770e:84a with SMTP id 586e51a60fabf-416e4415b81mr2392465fac.34.1772842612701;
        Fri, 06 Mar 2026 16:16:52 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:481e:870c:b200:7ebe? ([2601:282:1e02:1040:481e:870c:b200:7ebe])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-416e61b9c24sm2739930fac.0.2026.03.06.16.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 16:16:52 -0800 (PST)
Message-ID: <8d4e0668-9f96-44fa-bfd5-898e6f5a2827@gmail.com>
Date: Fri, 6 Mar 2026 17:16:51 -0700
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
X-Rspamd-Queue-Id: BE193228F20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-17644-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.873];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 8:51 AM, Chiara Meiohas wrote:
> From Michael:
> 
> This series adds support for managing Fast Registration Memory Region
> (FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
> pool behavior.
> 
> FRMR pools are used to cache and reuse Fast Registration Memory Region
> handles to improve performance by avoiding the overhead of repeated
> memory region creation and destruction. This series introduces commands
> to view FRMR pool statistics and configure pool parameters such as
> aging time and pinned handle count.
> 

reference to the kernel side patches? have those been merged?


