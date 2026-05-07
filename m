Return-Path: <linux-rdma+bounces-20176-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJRmD6q9/GnSTAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20176-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 18:28:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 479904EC31B
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 18:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A4B1303D7B2
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C92288CB;
	Thu,  7 May 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM3sTvvw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A73A6B6A
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170853; cv=none; b=t0f2s6VAqsAkiq8BxG+64D8eHkFlBlc3RS54OGP4iY792gA9Oe7NeS7xc8biOEv9mB97TCGJgBJGszowA8qj3jYDFxClAE3vmwd7NssHYjVdcPZF/gQe943RpA2tH3jhcJiL2W6sLSxTtTzRaizq/XAi5gOfN3zFVzS7s4r0CzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170853; c=relaxed/simple;
	bh=zkf1WUEwq0NJqP7pNprYQYYYZC5d0HmnjXBi/YyVyEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cycFIhFcusNdP/g4yIMPvBaVWE/6J6K1IhgcwaBoqZYrSZ5ACuSeqbZS+gdg11wufotOMxdC2pkt+5R/Rn/+A6EMP/dPO73inNJ6LxWb+8/PwOZT/xyjCjZaJM9NuVPY/cgujZAl7sEcUajZPR3IDG2PEcPI62OGKiebTkADZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM3sTvvw; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479e6bc357eso412000b6e.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778170851; x=1778775651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkf1WUEwq0NJqP7pNprYQYYYZC5d0HmnjXBi/YyVyEw=;
        b=EM3sTvvwaE48pwBN7Qrw4Kkjl+Q2zByQrdWiRoHghhHRX6udpNWWMgWjCkeWC6uL1/
         kuf3iRiCWsTP/pvUrmKqjhgolGohLwZm0rdRHePvJOvcMdOAikzCVbsX+3sIiNhZ/pkk
         jDp9hK2J0KRlx5vMXWdHvwRp6pbOs/m9E/d0WCYOWyA89pFMrnydIdDanfMGu48pT6rk
         nP8LsjbFkl7TWJVJeqHW4vfuNMdseFnK3r1ZfAW8PBL96hlfUE/5iQyGkjmFA9/kdmTA
         BlykieDzHVAJaATTGSzqyNB2Byg9DP41RB/1D1NLDU7aTv2ejun+beZUqrc8HD4ca2jb
         Z6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170851; x=1778775651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkf1WUEwq0NJqP7pNprYQYYYZC5d0HmnjXBi/YyVyEw=;
        b=RDWqVzyMrFdbTTM0QJsZlSmF26gajVqTDrGN/pFF4ZpzBknOW5TInqoa7IxKD0G4Hs
         KFA1U4rt3Drn6Vh9LzMU1d4sWjlOoiWWUbcHZkiv4gkp+Dw6Ksep1nzZSOI9cRE3BRwp
         fvIC6cUZoaW9VCAWfO8+6QoKTFEbs6L19MySRDaPqkPO1gI6X00s9kiJml2C15YSfS/O
         toDBaMessiBJedh3QBymXpiL5agF5b9hWfm4axASIqIQppuWioYQG9FKA23KJ1vRwn0I
         SXYgrrooTp/wYB+LdaRuAvxpIkR+Xnf2EU7AlRZeqH8YhBbZp+31aPpAyMAmq7duEiO7
         rsJg==
X-Forwarded-Encrypted: i=1; AFNElJ+u1x4FNmkOA15yeqL50KxqiPvalEH7xhJSpwP5NY5JzMH/IBonNLY2iG7g3nhzlm0gK3ZgKpF9Xi1Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwyrQu2s2cvHzzC6uV5tDavRNn4Z+mX9kBgnO0W0krzUYsndh+0
	i/zPsvZrv6nE/R1NgwA9kqPk7M90JObzQVBeeSBPJlx1cJzCq2EzoO2W
X-Gm-Gg: AeBDieuoQwLteOKPrHEvcyzShSKjvi1VSfBNmHwUz0/RDL2yIG0PPlEYjvO+NJi5ss4
	9Yo2UL1m3qKXESge8SQ7+TaN7VVFMMrqv57E213LfeYzVrIjxrE7B/22YOOrUCHdOlU4tLXqhHc
	3InrWJlEHHzH7qml7uTEVPVzADS2q+/EOjDoOntStTetLFMRXlDhseikEmoaqpX/iPG7HpwsR4u
	s92TRCp9q1WNS2IZiiR05B1titB5vJ5RETCxbXivXXHi6Dkk0NJN3JUohHOZ2UFUk1TbFffJlHz
	7Q9VzR653RARhQJVXKNikN4MKBGSfO8VgRxUbuu3BDmogqxlCAobQOAhTlrQB4HWQ6xH/wQXeJx
	n7HDrSqs2kVC2isVSSb5CAQ3u8Ql6SWyJ5nERTBKj3G21W42EG+n7brlZQf6u2COQ7tYf79FLFJ
	xzZ5hfghEvHv9h4+/saUAaf4gcH/SEiKdtb1j4u9LozizYf9YiuP8nv6Ql8w4nuPJhESyQp0LGI
	+ww9JXdA+A+ehIVc7pOzTZbCS5I
X-Received: by 2002:a05:6808:d4b:b0:479:e7c7:dc71 with SMTP id 5614622812f47-4804251eb3amr4874509b6e.38.1778170851608;
        Thu, 07 May 2026 09:20:51 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:44c7:fa6e:bd21:8ab6? ([2601:282:1e02:1040:44c7:fa6e:bd21:8ab6])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-48061e6eb84sm1599617b6e.0.2026.05.07.09.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 09:20:50 -0700 (PDT)
Message-ID: <3cf0dcca-9a3f-4cee-83d7-f058f33bcc04@gmail.com>
Date: Thu, 7 May 2026 10:20:49 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next 1/4] rdma: Update headers
Content-Language: en-US
To: Chiara Meiohas <cmeiohas@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: leon@kernel.org, michaelgur@nvidia.com, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Patrisious Haddad <phaddad@nvidia.com>
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
 <20260330173118.766885-2-cmeiohas@nvidia.com>
 <20260427112505.684c21f3@phoenix.local>
 <77e1a762-e204-497b-b7cb-40d5a93f8ec7@gmail.com>
 <98c17c60-6747-4c2b-bfe4-ce9bbe560f6d@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <98c17c60-6747-4c2b-bfe4-ce9bbe560f6d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 479904EC31B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20176-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On 4/28/26 4:05 AM, Chiara Meiohas wrote:
> We will prepare a sync patch to align the names with the kernel and send
> it shortly.

what happened to this request? I see that Stephen had to post a patch
(not yet applied) to address this problem:

https://patchwork.kernel.org/project/netdevbpf/patch/20260505181045.748088-1-stephen@networkplumber.org/

We allow rdma to have separate uapi headers for convenience. Responses
to mistakes need to be timely.

