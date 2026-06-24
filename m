Return-Path: <linux-rdma+bounces-22453-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4XELFs0WPGrfjggAu9opvQ
	(envelope-from <linux-rdma+bounces-22453-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 19:41:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB43E6C06B2
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 19:41:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nGGMg1S4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22453-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22453-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C172E302F6B3
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 17:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AA43DD502;
	Wed, 24 Jun 2026 17:41:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9AF2F7F0E
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 17:41:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322889; cv=none; b=dBaQI1ngXPSNu2Ts8I9gE9W0yzAfDwfu07yrR5SihaSjIj+rmsxSfJ2ba46N8FkvMAvk0QkEFwhciMEF11DUMaCywv13NRP3482BWOgMp86p/YhWZKWPCtSMYXgQEgGug7xFC+BEjDbJ8Msx7oHG8Tk8q4ccGCUv/eXHbZ8EiIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322889; c=relaxed/simple;
	bh=CZUZWGuAqbw6v2v4iaA9KHVMmfsMHkMS7XAdRFxDAj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7HAiQ0txGbkEEJneVhQVqq72iGSDB/Ai82m76+64/PXvbIWvOihFSmlLUdW9pQarhRCTUsC/WDuQohAOlWAIujnVWcvjSpZ07jdt1470cwRYrDdCsWCccHqXuC0IOrpkOB990kelTXtMM1ZykJjSuFvkigZI4S2VX7o77UGHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGGMg1S4; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso1109475e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 10:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782322886; x=1782927686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6JGu5iSrP0a+4zFMH8CpG9pJFd1BGtIH3YuDp9gYlpc=;
        b=nGGMg1S4kbDUDHVpYrXOQxXxzaNxuGdqv+HoNNixRf1cLRVD9XSDMrjYAUPUhkdOtn
         TmDABXFB7heX+j/S4wlz/rOMFYvwPicRDFT1ExX26VYHirfZDitkuNKNMlnjl6y0yagl
         Iqao7pBV+T1z7VDBw6ug9ZpJ2ZcUR9kQ9bjUgfr/c5qF+xNt/EAguxhcZWAcuQz6MMlM
         11XgP4xb7P7JQcLDWsoMQRoRFNqHmqGaNjZuYENKIbdn801rT0U9idCdgPIOofsQNONN
         nzSvPtjjfrl6bt3T4jGyyjlNHP+lFWXYBSfiXJ1IbB30Tx4wEYBnVXyVa3FwCsaRw0IP
         UNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782322886; x=1782927686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JGu5iSrP0a+4zFMH8CpG9pJFd1BGtIH3YuDp9gYlpc=;
        b=T/t+UnXst3eYRccW+sTxaAP+OpkItxj9RJMfHnvRo2alW9eMInOiLA+/wvi6lTLCGA
         j/sDRVQ+2+8mJASn6RamZd8mW5JXMvJs0pM+wQmMCxfqYxEXAq2HYtDfW7E+aNV1vHaT
         v+D7mDW+a4WJmmGai5yDPH1VVLm2lqlM+gQjayWCxxfaWCZCpZEZVEn+fznJnLt80f/r
         jlCinwFLykPrKQorjORYJfGDtH1k61IToEYei1eYba86zdXa6t4WjxHOSyaXyTNkggtn
         PR39nxYIun7aV0esxaF0jHKrmoaT5Fjvwi+xhLi3BmTVZypdSOiFqfKLjIG5XYMfT7gC
         XACQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ywW9LwCAFpfrb2iGUtjbkj2ap+bIPV2ujOD9xcop6vN66pxfKVjepPFEVW3Se8q4/H6VXjHpCl68x@vger.kernel.org
X-Gm-Message-State: AOJu0YzveerNeezN4R9NxqjT8Y78DozR7nKo0m5epQp9F/o8f4zyVVPX
	RAa9pD7r0qByQIh0KxDVpHJbSWOqWkfLkAV+YFTnuUOlKwfJvFrK2T/a
X-Gm-Gg: AfdE7cnTttwTCkM9GUuFctTP+4I+NFAPRi/Y/YS+sqqPWgCI2sEpygfXpAPJGqWEXLK
	o5hS6VfSiDC+pCyzIOLVvtNVin+rQ2od1uXSSnWsDa1I1Wgv/1B6IVI1dDG6naz6lREQwNmCXbA
	Xv3+z8miH/b1fFmaubn6FDKH5ZisBnKtBnQn5HSYCcULoQLitZO0SlXh+Sr0ItJNgs+Td+FSmap
	7wLF8XqacFDy8MI2qNemRIVk7KfAViSjzccPoAd8Ef+jcpRcs7de+rD3KCNaZn6JakgbdbDQl13
	/r1Bx47KPXWUfFxwFxUaBlsaTJmWYvlE/mwTmUaGp4A/LvloBmRwTfjYi/zglRDR+TDygu9eVtC
	tLCz6vBZ/r4WSZlDKO0VmnSLMgoBR9Z2YXpxsQ+TUuPtzme1CXdI9J4IQ6mHs0oeR2WkVJabcrL
	7hF8HF5p0fJeCElJFV2KcKPqCk3WgKruDab14p37G17nlNKn7MjpiaRSD6xD4nXzdij0ipIEPfO
	/YZoCPgdqEzCpdtrF4=
X-Received: by 2002:a05:600c:4f82:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-492632b6eccmr19189735e9.16.1782322886052;
        Wed, 24 Jun 2026 10:41:26 -0700 (PDT)
Received: from [10.128.11.131] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926494f0e2sm37415e9.1.2026.06.24.10.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 10:41:25 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <90076649-7522-4c29-b8d9-956571aeeb6b@gmail.com>
Date: Wed, 24 Jun 2026 18:41:24 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma v1 1/2] RDMA/zrdma: Add basic framework for ZTE
 Dinghai Ethernet Protocol Driver for RDMA
To: zhang.yanze@zte.com.cn, jgg@ziepe.ca, leon@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 wei.quan@zte.com.cn, han.junyang@zte.com.cn, ran.ming@zte.com.cn,
 han.chengfei@zte.com.cn
References: <20260624164852120pLCX6txujHU8n4GMakGbe@zte.com.cn>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260624164852120pLCX6txujHU8n4GMakGbe@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-22453-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[julianbraha@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:zhang.yanze@zte.com.cn,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:wei.quan@zte.com.cn,m:han.junyang@zte.com.cn,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB43E6C06B2

Hi Yanze,

On 6/24/26 09:48, zhang.yanze@zte.com.cn wrote:
> +++ b/drivers/infiniband/hw/zrdma/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config INFINIBAND_ZRDMA
> +   tristate "ZTE Ethernet Protocol Driver for RDMA"
> +   depends on INFINIBAND
> +   help
> +       Say Y or M here to enable support for the ZTE DingHai (ZXDH) Ethernet
> +       Protocol Driver for RDMA. This driver provides RDMA over Converged
> +       Ethernet (RoCE) functionality for ZTE DingHai network adapters.
> +       If you choose to build this driver as a module, it will be built as
> +       a module named zrdma.

You've got a duplicate dependency on INFINIBAND for your
INFINIBAND_ZRDMA config option. There's already an
'if INFINIBAND .. endif' that wraps the kconfig file import in
drivers/infiniband/Kconfig

- Julian Braha

