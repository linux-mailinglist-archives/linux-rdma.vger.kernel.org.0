Return-Path: <linux-rdma+bounces-19289-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M+oFlvt3GkZYQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19289-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 15:19:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFC93EC787
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 15:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56D75300CA23
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30F2F90C5;
	Mon, 13 Apr 2026 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEQGkFAU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmYXJXeP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7022156C
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776086348; cv=none; b=a2x7R0hC+Qzaf8TnkvYhizLMmc0OHLV0GRgdEgMiEiSf2Et8+dFUIppBd6X15/+ur/sgzXGVvVE3zqN8VJIHzmaLK3lsEoU2D/N/i2Htq8clovAdVfV59/sW/VEMNf3D3QV5U0dsQU1xYjqbUAGdFIAOXxaA4UbM6mNCM3L2Wbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776086348; c=relaxed/simple;
	bh=tchUCn26E/co8gGiaVaMdaMujQkkkQCs11l6BKW+kp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPE8XYApWdiPeTcHdJM22Re2STusFQZ5orc8rOYDxcWc1K+2VpxhAQqSFh+q3diGB6C99FvLRRqlnBj/xDDGENm2ZkDcP0ND2Zn5jceWsPEVq31DibZbzh4IxJE4Z1NpQ33Wk3AIJVICORRPUzZWQFw6unfOtdzufR5dIZGohBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEQGkFAU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmYXJXeP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776086345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7k2xp3bBV4lET1Ny4Madx/DQczLuqXWtDe45ShURu9Y=;
	b=JEQGkFAUQH5/FEbAioDI6UhFTadktw7m/SeX4vINwtX9zYA2F3xc25BpLY9M3/hQihTsZa
	eVi+LKQy7SccGJhR6tkOW8sy1LUVvyLDI+QjFUGJWNubPXVO2OzBq+QKVOrofaT3wEykcO
	3FfcpcTZurZCzgpjcyqtdNUXDRnwnIA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-XypWXhy2Mj2C45UIYJjLTg-1; Mon, 13 Apr 2026 09:19:02 -0400
X-MC-Unique: XypWXhy2Mj2C45UIYJjLTg-1
X-Mimecast-MFC-AGG-ID: XypWXhy2Mj2C45UIYJjLTg_1776086341
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so36805335e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776086341; x=1776691141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7k2xp3bBV4lET1Ny4Madx/DQczLuqXWtDe45ShURu9Y=;
        b=JmYXJXePNlMkWsi0s2QNctmb3oATwyZfjbxzzQeIk5Im0yKU1IsePQfdQMWev4+yi6
         fnxnTkyD1XNTZsXNf8j48I5yPHeklbz7QVDw8KNMRhPT/l/pqCro7VemUPFJ7GZQtUf0
         XkP0YEwdLxMmQ/E1LSXyxOkHaai0FYSRLK04iSHziHVU5EtTEiiQlS2Gk+D0XkBGhgvh
         c9MxjjCcilNI/DbnAHs2LFmFjLm58pCUB0SR2bdW+dYsBYbNlA8LM5zPaNv9B4QM3RO9
         uEk6cveJV2HY3Rj+tPyx+gFYTh43t7RL8xNdv1ThU4yN8wO91JoJ3bEI+e0E0N0bw5hW
         DAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776086341; x=1776691141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7k2xp3bBV4lET1Ny4Madx/DQczLuqXWtDe45ShURu9Y=;
        b=h1NaNSe/tXSf5Eh+/ZWCx96mWi6tuwxe8wnApIaWYjFGHqbhvPUQmIXzngQNAhscwy
         drWfImGrSfxgbHgxr2mpzODOFnxDsnIdA2N5rZ0pi/YozUUbkQVCgeXMgNjhtn0gDpod
         P9Yyyrkf2iS9oIzN2yL5mT5+iItu9koX4/l8bWJNyLUeRo5UdHWsupg2Q1eEuMC2R9Cs
         Dh4SA2oj6o7HZhtby8ILjaawQuFDlfbxDKgHvWn8KQ113uEsL/vq9IICegxtiaRBA9Hb
         JQ7FFd44UGoY3Yuz/WL4OV0k6YtvMQFcrDieepYsLlhDLbd8uSuJfZUVH9gN9rticrx6
         uJsw==
X-Forwarded-Encrypted: i=1; AFNElJ8C/TRl0GK7dwJUy4PpvHNMoPJxwe+H9EnVUZxpT6osQrwEli/JT09TfRVBxtm04XkSnZ26oKLk4h0o@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfe2zevtR/czkVC4KpxE8+OSbYFxC/ewkQejAeHUY7jv9OYXfP
	7KpxHEQdwYlEeLASMb8+2++cn0vqQrecxQXLZNuL/i4JBRTPNeNIUYeaFnJUGaLFsvdWJaZFiun
	xBKwdOJB5TLx7pk/c9/35Fc6iW4gpg6x6D10Bo0PbqlVy1E0suNVRRRbGs5YGhbw=
X-Gm-Gg: AeBDiet9/WeBV60mEnqfm1PtMKMQvvMyqAMRryufh1VRgTM5V+g14qzYzZPc6ZyH6RZ
	lYrNpyv2wz6xWeSpkATBdKQNSsuNuPVgdb6Bpwnh5QMqCge9vdua0Em8ZZ5HszX0JCZ8CF132qG
	X1pEAD4sSxYazCC+XO4s+IPbbWLyqArUYFjFZ12pTNmNJ02wLbKsMPTjRTSmCf+JsBMLggyd6Bw
	yURZfm0puupZFSmsryMEY8smxLmgjniHR80PLlb8FbeXweJw4WSnwKMrWk2uojo102yrJbOFp7l
	F8R7Gq6VLPgxoe0N4r3aXMqaNOVHTYlkMCguF9gdK8H1o/AfRGlGs/ffuuYJfmm5BKw+C5KUg39
	/UfVf1mcyQjxkHitSI+MQyMkscdakds11DnTSC1l77FQj5AaUEkf2L+zc
X-Received: by 2002:a05:600c:c117:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-488d68af0e7mr124590435e9.19.1776086341105;
        Mon, 13 Apr 2026 06:19:01 -0700 (PDT)
X-Received: by 2002:a05:600c:c117:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-488d68af0e7mr124589985e9.19.1776086340631;
        Mon, 13 Apr 2026 06:19:00 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488df272d55sm67056435e9.15.2026.04.13.06.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 06:19:00 -0700 (PDT)
Message-ID: <346925be-bec3-47ee-866b-a6890b455a0b@redhat.com>
Date: Mon, 13 Apr 2026 15:18:58 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 4/7] devlink: Implement devlink param multi
 attribute nested data values
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, jiri@resnulli.us,
 chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 dtatulea@nvidia.com
References: <20260409025055.1664053-1-rkannoth@marvell.com>
 <20260409025055.1664053-5-rkannoth@marvell.com>
 <b52ce943-18f7-4402-8b6a-3d9f69bf7d19@redhat.com>
 <adzMvyIr7-uBtGlI@rkannoth-OptiPlex-7090>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <adzMvyIr7-uBtGlI@rkannoth-OptiPlex-7090>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-19289-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAFC93EC787
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/13/26 1:00 PM, Ratheesh Kannoth wrote:
> On 2026-04-13 at 16:24:41, Paolo Abeni (pabeni@redhat.com) wrote:
>> On 4/9/26 4:50 AM, Ratheesh Kannoth wrote:
>>> @@ -441,6 +448,7 @@ union devlink_param_value {
>>>  	u64 vu64;
>>>  	char vstr[__DEVLINK_PARAM_MAX_STRING_VALUE];
>>>  	bool vbool;
>>> +	struct devlink_param_u64_array u64arr;
>>
>> You mentioned that you intend to handle the possible CONFIG_FRAME_WARN
>> with a separate patch. IMHO such patch need to be part of this series,
>> or things will stay broken for an undefined amount of time until such
>> patch is merged separatelly.
> 
> Patch no: 3 in the same series.
> https://lore.kernel.org/netdev/20260409025055.1664053-4-rkannoth@marvell.com/#t

I fear that is not enough ?!? i.e. what's about
devl_param_driverinit_value_set()? Likely devlink_param->validate is
called with enough space available in the stack to not care about the
huge argument, but the mentioned helper is called quite deeper.

/P


