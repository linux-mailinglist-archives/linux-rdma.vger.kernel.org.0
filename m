Return-Path: <linux-rdma+bounces-20957-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CmIC7QvDGo4ZAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20957-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 11:39:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D81057B6E2
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 11:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFF1E306C2B9
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626E3EE1F0;
	Tue, 19 May 2026 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ol8Dxqi2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kzS8TZ9P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18823328B71
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182037; cv=none; b=FK93r/0Hv6V73oGWaWsRdt3TcXaOErIDhYmItnynR/4tciXXp7w+kdYgalEBa49DEyoRhFnkZVyuB/nfvZy8pQwr9rv4wh1ZoCw2zo0tM8GVP3oQ90/9hdSj2GS39j4/amzKCmTeuHBHbavD5iYuYZD1mtZHYcu6YNFpd3Jb5qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182037; c=relaxed/simple;
	bh=Yr1naL0WjdE/A41/zRFmRBexEGZFRcqrl24tfALYhsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UijFwWraXGLMoL3QG4uBmDp5DhQumgwlwR9Mb2uUt5GoANuKZavo+WvnjG3Z0z0iyCrxo2lAzIEarHVDEe9DWlyarZvt90UdEB7ZjVSB2tS5oukIA/DF9INA5yTqpN1WsL3KzQ6zPPSCk5P2vKUKXkpKOS9Qg96TU56xOQqf6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ol8Dxqi2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kzS8TZ9P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779182034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ay6gidP+I0vDJI41cdYOxuCXaLwaNuaZ5No08B1GxG8=;
	b=Ol8Dxqi25hQ6IXxSqiO1cOoy6IsI1V4B1YCbGhcJbqzR7QO8LwnYxzwlGuajn5wSau9RVk
	rTgT4zcBtAjy4D9rk6GASeU1L5xXlpyzQTC8r/BRbHJq0n2R8hZQwkuyNhXLQxtHtsMKKg
	CkgxNIJ8cTY0VE19W+FJCGaNFTs3BI4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-fU7HTuV2OsOd_hQ8zKekIA-1; Tue, 19 May 2026 05:13:47 -0400
X-MC-Unique: fU7HTuV2OsOd_hQ8zKekIA-1
X-Mimecast-MFC-AGG-ID: fU7HTuV2OsOd_hQ8zKekIA_1779182026
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a3aee3813so1469016f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 02:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779182026; x=1779786826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay6gidP+I0vDJI41cdYOxuCXaLwaNuaZ5No08B1GxG8=;
        b=kzS8TZ9PwmvjiUtfteHUSRJQXMamRtUNezZie+71KLNVxleIJdZXqNtys/tI7nuUMB
         ftGq+H/WNYCV9wtKNapLA4Rns/q8Mrf+BuFOlNtukCyfgPw5e+xebopmWAmFdsHJTi0a
         ptrBv1eMqjLsznhxwxk5o29EJBMQUs1ImeaWQP4HpyOSWGOSGu/IJTqr8A5xPF+mM0cp
         OrZzxS92VSZSLiipmFDDBFxIu/yGJrsctC1JL3R6ZKZZtUJS5ogIaXS6F566e5ubIH5T
         UqRSTmfGFwSREVcoatJ1i9t/fzT4HY4+Gbop2J+lQ6Au2K7fAbo/UYKd9rbAfC2zM6/E
         VIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182026; x=1779786826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ay6gidP+I0vDJI41cdYOxuCXaLwaNuaZ5No08B1GxG8=;
        b=RWlD5iBoiv3sPw3FLnQSYJRTrLBnlZZRNXUq4ZxCVvnmqZfTQHX/rjXaWRiLqvRrLf
         NrlYc6fRbHl85anlmgKgMhZbiYfrkBzGOdPTtgdlbzjglK5GqfigAQl03Ef91mPyy3r4
         NyYGjVmltZhDDMQ08K1DV4mDnE0JFykz2LOYSqeHmIUNVu03n07rUNyB2Jr0IG+1NVm3
         sNb+F5KNJnEn6236aibyVcJ4wktkAZLA33OniegNHkRsYu5RaxPQOnBPAakPLwAHZ/pB
         +y+nkfj1pe5bxuBS0D5VfUo24R8rB0a/IdjlmwqQUiWaLn80LGZu1Sv9nZ7dIesD8p3V
         MUGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WQE2T8fj7RGZq+/1wLDbP70t5uzoPoemoncugLxXtSnTI8iF6/fc5cpKgWX2lRkpoqu2SMhB3IWHj@vger.kernel.org
X-Gm-Message-State: AOJu0Yze9927fzXC5qFKEF8g8u4XpE3xB2S4Cnn53P7J8uymETKAg45k
	gDIEgvEsVKTezydAAQ/g/A/ewYj9OMpGnt2boS3CW46UKHBSFoIIrHCieC8M/6/y4V6tYCK3bOw
	AywH4ZTjHL2XdI/0j21tXCGI/rC2B1/NdxZNR3WiTeg76Bdc0nw2cHBnDNoxT1vs=
X-Gm-Gg: Acq92OFlm2kyPgHKLj7GZjJwhkj5d9eHqocb8MiIm16mUlKrWsc+H2m9jLSefIWV13F
	Hcld9Uil6ovC6hMLJybRgW0pIjFjUn+wzE7rIWqHvgD2yxg0j0txj/3ccpLyn/4lL+oq2fVocDY
	+NA8ocU0DCl8Nqx4EtU2vNEAEXHL+tjf3KmxCXTBPfAemgABQin2GfyX8Z2xmM/IsQwP/9ALuhC
	WEp4uHEXy0tZzys6Z2FTR9ubkMNE/UAigA9OhVvxeUO0O4gcUJ8UWwMuS+P9OgcJXBXz6bI/4G7
	6hF4RVUCzvJRnbyBoLfShB38RxF0YdpTmHIc1sZWKjpbZDRFyuUDe+Zhfvzr3vVyPtavtYRD5O4
	+/BScCinuP0V/xz69SuHoSAwVwgjjlZWcGLyebjvF0DMXRHZ+dlsg6Sq+yrJm8RQurQ==
X-Received: by 2002:a5d:64e4:0:b0:43e:b0f8:66f1 with SMTP id ffacd0b85a97d-45e5c5aebdcmr30874767f8f.43.1779182026488;
        Tue, 19 May 2026 02:13:46 -0700 (PDT)
X-Received: by 2002:a5d:64e4:0:b0:43e:b0f8:66f1 with SMTP id ffacd0b85a97d-45e5c5aebdcmr30874709f8f.43.1779182026043;
        Tue, 19 May 2026 02:13:46 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1aeafsm46379303f8f.23.2026.05.19.02.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:13:45 -0700 (PDT)
Message-ID: <ef633a47-0ed0-4a10-8316-d88a7c0e7c54@redhat.com>
Date: Tue, 19 May 2026 11:13:43 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 9/9] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
To: Ratheesh Kannoth <rkannoth@marvell.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, oss-drivers@corigine.com
Cc: akiyano@amazon.com, andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com,
 arkadiusz.kubalewski@intel.com, brett.creeley@amd.com, darinzon@amazon.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 horms@kernel.org, idosch@nvidia.com, ivecera@redhat.com, jiri@resnulli.us,
 kuba@kernel.org, leon@kernel.org, mbloch@nvidia.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, petrm@nvidia.com,
 Prathosh.Satish@microchip.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, sgoutham@marvell.com, tariqt@nvidia.com,
 vadim.fedorenko@linux.dev
References: <20260514062537.3813802-1-rkannoth@marvell.com>
 <20260514062537.3813802-10-rkannoth@marvell.com>
 <agbLlpli-whxptBX@rkannoth-OptiPlex-7090>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <agbLlpli-whxptBX@rkannoth-OptiPlex-7090>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-20957-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Queue-Id: 2D81057B6E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 9:30 AM, Ratheesh Kannoth wrote:
> On 2026-05-14 at 11:55:37, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
>> Replace the file-scope static npc_priv with a kcalloc'd struct filled
>> from hardware bank/subbank geometry at init (num_banks is no longer a
>> const compile-time constant; drop init_done and use a non-NULL
>> npc_priv pointer for liveness). Thread npc_priv_get() / pointer access
>> through the CN20K NPC code paths, extend teardown to kfree the root
>> struct on failure and in npc_cn20k_deinit, and adjust MCAM section
>> setup to use the discovered subbank count.
>>
> 
>>>  #include "cn20k/reg.h"
>>>  #include "rvu_npc_fs.h"
>>>
>>> -static struct npc_priv_t npc_priv = {
>>> -	.num_banks = MAX_NUM_BANKS,
>>> -};
>>> +static struct npc_priv_t *npc_priv;
>> Since npc_priv and dstats are still declared as global file-scope variables,
>> won't probing multiple RVU devices cause these pointers to be overwritten?
>> If a second device is probed, the allocations for the first device would be
>> leaked and both devices would end up sharing the second device's state.
>> On device unbind, devres will automatically free dstats, leaving a dangling
>> global pointer. Additionally, npc_cn20k_deinit() explicitly frees npc_priv
>> and sets it to NULL.
>> If a userspace process reads a debugfs file after device unbind, could it
>> cause a NULL pointer dereference on npc_priv or a use-after-free when
>> accessing the dstats array?
> While a global file-scope pointer introduces a shared-state risk in
> drivers that support multiple instances, the structural design and
> physical topology of the OcteonTX2 platform eliminate this hazard.
> 
> First, the system architecture dictates that exactly one physical RVU
> Admin Function (AF) hardware block exists per SoC layout. Because the
> hardware platform cannot expose multiple active AF instances, there is
> no parallel or sequential device probing sequence to trigger a race
> condition, overwrite existing allocations, or cause memory leaks between distinct devices.

Since at least another revision of this series is needed (see my
previous email), and the code depends on the above H/W constraints,
please document it explicitly somewhere inside the code. A build time or
run time check would possibly be even better.

>> 	for (int bank = npc_priv->num_banks - 1; bank >= 0; bank--) {
>> 		for (int idx = npc_priv->bank_depth - 1; idx >= 0; idx--) {
>>            ...
>> 			if (stats < dstats[0][bank][idx])
>> 				dstats[0][bank][idx] = 0;
>>    ...
>> }
>> Since dstats is still statically sized using MAX_NUM_BANKS and related
>> macros, will this result in out-of-bounds accesses if the hardware returns
>> larger values?
>> Similarly, the en_map bitmap is sized using these same static constants.
>> Could operations like set_bit(index, npc_priv->en_map) in
>> npc_cn20k_enable_mcam_entry() corrupt the npc_priv_t structure if the
>> hardware dimensions exceed the static bitmap size?
> 
> The static definitions for the tracking arrays and bitmaps are based
> strictly on the silicon's hard limits, preventing any possibility of
> out-of-bounds corruption.
> 
> The compile-time constants (MAX_NUM_BANKS, MAX_NUM_SUB_BANKS, and
> MAX_SUBBANK_DEPTH) do not represent arbitrary bounds; they define the
> absolute, physical maximum limits across all existing and planned SoC
> variants for the CN20K hardware profile. The hardware registers cannot
> expose configuration dimensions that exceed these maximum architectural limits
> because the underlying silicon layout lacks the physical lines or registers
> to support larger structures.
A similar remark here.

/P


