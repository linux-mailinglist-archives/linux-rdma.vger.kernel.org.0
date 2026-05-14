Return-Path: <linux-rdma+bounces-20676-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOcvFQqdBWr4YwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20676-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:59:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06AF5400B9
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F21923023500
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6643A3E70;
	Thu, 14 May 2026 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SilB3sf8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiIa6MiB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732832E6B8
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752772; cv=none; b=ozeMBvLtmYkBBNGuznJODAhjMu05dWl/qAVtFMpqvl+WcfcjZy33B4QzMzmRQb5uy+ed3rCnHeWdHsBh2LyfkHw+X46J42dtK3ZIhrCEGNUcquZ/HM+LAZP5Zs+9ZEi57iLV6GsPu49IEowHWuFP8OflfiYiuyO//3wBIIX1omI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752772; c=relaxed/simple;
	bh=Aw1rftcdt6YTrtW0NCisJSYrXSElOtw3iV4XCyjxsMg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IzI55fURlrk7SwKm1BqoqoC+Gmdbfv2riBuT1l6cuWnM06yL2Ws2AQOqBBCieVMk4KlK9/PwidIItFOfe/+9zUzc1qv7j+1vt3MwON0J/avMxbZPIRsble13Ag1ahoQzILnMEpcv7nzuWh8hmUrfYopAoBM/vKUQ5nbxewMh4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SilB3sf8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiIa6MiB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778752770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yId0OGCN9Tt1w4yeRXxaYIu4JDjsDwkiLLT58G6INsk=;
	b=SilB3sf8RffC3uOaiuDutwH5QITlKJm25KNnfE5beXXziSoCarzmA+IxArMt+blO6P173F
	K6CW7TGI6axDv3bDL1ctHZzBJYADFWopWxYLHE8LKLT4vLKAOrSoaKZD/JIOiJJxdQ6r3E
	JkPfxcsu7qSXWg/7EM5nqObj5zPWGmQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-J0uQv5TzNjey3vLt_0mpzw-1; Thu, 14 May 2026 05:59:28 -0400
X-MC-Unique: J0uQv5TzNjey3vLt_0mpzw-1
X-Mimecast-MFC-AGG-ID: J0uQv5TzNjey3vLt_0mpzw_1778752768
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fdacff6d2so5011225e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778752767; x=1779357567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yId0OGCN9Tt1w4yeRXxaYIu4JDjsDwkiLLT58G6INsk=;
        b=YiIa6MiBX1w9+rpn46cTGOsvFKKHTjqxMeBWhCZ+Txes4cZDSkcBLjOmcSyXYG8B9o
         hRkqmt8vRvOzZnr6yxYJejWR2K0S4liOygS8OoaEz51FbMj5TTHT0L51snvMhg9CunIc
         1TVycjiFxTqk6XI3tpfr/vVCYDp7I5Q4mAIuaBYzXeFgEgLC5yK+gfkYB+kobcqF+Def
         viLCpDSLPZ3rMVXHR8ZxCbYmVY3t9JRoO9KfglQOKqFd0b+IlJrC8sUVWNupqsg6P65x
         x3i6si2iG4x81lcCDAtGFiOH9cfaA4T/ylKwea2kMp9IJZLlPLL/NZA+cjHj9aTi1E9A
         zmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778752767; x=1779357567;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yId0OGCN9Tt1w4yeRXxaYIu4JDjsDwkiLLT58G6INsk=;
        b=BXGlRyVfmlGp4J9ZwpxQlxkPXHDJ4xYeO4lhl5g+nmECWuH0LYNPSzZPE8L4SMBs6a
         DMAu1i5xA0ZKXhV0Imi1VK5sLHTrQMeSNfarkDQGEpohgOYyEcoe9xEMdhwnXFaiWf8Z
         UblBY91AH7wGgbXOB9wyeV9yESDCALG8TTePqGNpTLXDHX4pjQHx+dacfXmwWy3wgMti
         gFkGbcBnHR2PnPpoySX/SYbP5fdqG/VnGp/4yXYD1rmDVu4VrosJA0ddyOlixzrKcUqg
         QAd6wMExel1Kcjmu2pVCceff7qBG+YHQWn746lOUdv6DDvLb9uVbNWyV9kcaDsk33VL3
         wLGA==
X-Forwarded-Encrypted: i=1; AFNElJ/Hpe/6z5yzmLvNv7bjK1l3sd1lZGbHVYi1f8pXPz5A2O+tCHqVsyS20DWAZ+PfEHhi+TIEZYZVMQ8L@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvgjo8GL2ECs26SS+PK7P9mcZT3ccwzeZ5nrjJkzNxfbl6Nk5G
	KCt1q5mfp5FOMh26qWM+ZpqbnEMwh9zqarWbbT/3861EY6F9ylwXUcyA089k+Q7QG+0i5BVkbqP
	A81lM9Di89CG/G4C4uu+UNkT0PM+qeRJaNH+rppjbgHxbhR8ZmsKnat+FhRxhPa0=
X-Gm-Gg: Acq92OFwm33A5XCEHUQ48TfxiSgrRLkq+HeDaXxKu5HEI+mLOUIgVH0NvJdeSOE+JWG
	eR1uFXuV9fD1EUwkP62P1orbfZi8HrD+10Lu5jdIKrfljTn43viuuVRD3lWFRtXkbLq5bFP3Sak
	3t/F3ELtGzZI3mdAn7jRQhBnLlz0/FPiRT/YiPwBaGcWlcdER4jLvUIKKu7XSJxUy4QCsO/EkWC
	R3ivy5ZTs8GYp06sOJ3LXiK5LkaJ6iAs4GB4apCBP0IQXJg9uqhfnN7HS0ufvZFB7qppBvAvLna
	kUz2aQ/OPD2/U72ucTwARn7pkJdswBCkq0rI9v6FA2eb6pChEKV7VL7NXqdSoksMrGhkjkYuU0z
	v21KlQOM71WysTn2beKbNx2ew8wWTjeLS6AzVI5O6JMfcvxwOu1WWXWM=
X-Received: by 2002:a05:600c:c4ab:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48fc9a3c1ffmr115144695e9.21.1778752767598;
        Thu, 14 May 2026 02:59:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c4ab:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48fc9a3c1ffmr115144295e9.21.1778752767108;
        Thu, 14 May 2026 02:59:27 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb4c13b3sm36447265e9.14.2026.05.14.02.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 02:59:26 -0700 (PDT)
Message-ID: <24313143-d0b2-41af-a95f-62d1f5a16439@redhat.com>
Date: Thu, 14 May 2026 11:59:25 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net/mlx5: Prepare eswitch infrastructure for
 satellite PF support
From: Paolo Abeni <pabeni@redhat.com>
To: Moshe Shemesh <moshe@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Akiva Goldberger <agoldberger@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260510053448.326823-1-tariqt@nvidia.com>
 <20260513192539.7fd96592@kernel.org>
 <639580c8-f93f-4945-acfa-ff116b841f6a@nvidia.com>
 <a0d4052c-2e8d-4dec-afcb-c8050f5d1ac7@redhat.com>
Content-Language: en-US
In-Reply-To: <a0d4052c-2e8d-4dec-afcb-c8050f5d1ac7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B06AF5400B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20676-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 5/14/26 11:53 AM, Paolo Abeni wrote:
> On 5/14/26 9:56 AM, Moshe Shemesh wrote:
>> On 5/14/2026 5:25 AM, Jakub Kicinski wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Sun, 10 May 2026 08:34:40 +0300 Tariq Toukan wrote:
>>>> This series prepares the mlx5 eswitch command interface and vport
>>>> infrastructure for satellite PF support.
>>>
>>> Could you perhaps start by explaining what "satellite PF" is?
>>> And how it differs from "socket direct"
>>
>> Satellite PF is another type of Physical Function, its role and 
>> privileges are similar to the host PF, but unlike host PF the Satellite 
>> PF is on the DPU and not on another host. So it's kind of "Satellite" 
>> for the ECPF which is also on the DPU.
>>
>> The next patchset will introduce the Satellite PF, while this patchset 
>> only does some preparations. Small changes to prepare the eswitch to 
>> manage another PF.
>>
>> While Socket Direct is a hardware PCIe topology, that adds another PCIe 
>> link to the NIC, the Satellite PF is just logical entity, by firmware 
>> configuration, no hardware change.
> 
> My understanding is that Jakub wants you to capture the above info in
> the cover letter.

I take my own words back. Actually I'm not sure about the above and
given the constant ML flood I think we prefer to avoid a repost if
possible. The series LGTM, please wait a bit for Jakub eventual explicit
repost request.

Thanks,

Paolo


