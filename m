Return-Path: <linux-rdma+bounces-17546-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDLEBcamqWnwBgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17546-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 16:52:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41464214E15
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 16:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9CB530D642A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F336DA09;
	Thu,  5 Mar 2026 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAB3pCoz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C73CB2E5
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725394; cv=none; b=F/YPpTfq0sW7hTsdkxY2xLm5ZFiiC6dP8XKkVMM29mQ4pzCjZsTX2aKHXBV9YyFaS4rGtSVGeFTRt2C6RTFGIZvGCpWCLzE7qlndDIGmNrLjdYVEGjG384segzVuNyvStnmpB5MjFQMD7UidgFaTK+GfEZeUTTGGOzPWdLpzMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725394; c=relaxed/simple;
	bh=wZwLapQXxG7D+Qlav1XZFe2kQjdkfUMBUlFhr2GSoR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haeODo3KMmv8gk3woa4w76PthbistlPeLQkBwwypcXGIc8ob0b+QlxZNczmunmxWSGdphXY7UUUvyA7F5zaOyr9K1clk1n1kA438IkqXHKMiItoEREcaitZcErWSY44AN0qlkZthZts+mjb0cUJRonz5eJspdnyBh+SHFWNSqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAB3pCoz; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2be1c918173so6771941eec.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 07:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772725391; x=1773330191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VHdXwqWfI2lXOxROY4OA5+qg4q5UeIXxvdk5YcxjXU=;
        b=hAB3pCozekmvwYsigwsTkjeZQNv56bN7N0oC9Jo1oFHK+SIbx8uN8aRAimE6TWR0p9
         QVP3yze9c/zWkcqPcgBo5fc6BGLkKrFcyqRgMZAMx2YXbWRetPeNXnyRHq9fv+VgeKp7
         /P8VH02hP0Xu2dkOZehW9365tal2eyV2GIQU26EzqAaFI7YfDkKJdqJTTt/3lR3p1CaK
         bLcrIlvTvaf+13RHASB2C0HabkFvvXhAKD9iioAmpI5gZru7U840QcGy5fcGTDjJLuhg
         mHsyXK4e2ZBeX/GGHPY2z62wgsAp0+nLr8qdXT9xBW61h9zPuDW6bSifb4QgpleY5R0Y
         brog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772725391; x=1773330191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VHdXwqWfI2lXOxROY4OA5+qg4q5UeIXxvdk5YcxjXU=;
        b=VJADWrw9er+mRLuyYzPhmsJltlb344l0sey2Z5VNSM4b1Tr1hGm2rg79Xcvm9gvJ2h
         Y+PxgSJIogQiAsGDxsW/kshUqfO31zyxINoMSj3reOnZl7bE5DDUm4xTHq2NOTEzTJzm
         I4TI9HMEzOAqcg7KiCn+6EPz/xavyCWwxH8XtINvv+TEw5yV6Z/8TAFlfbPdOCgOb0m2
         1igjxIfzuc+M5HrS34hf01iEoFDgrzYJM5zsHAHWJWzvw5WmH2k6aNB3bMJfO/l/UaoN
         9jywqF/+gW4JnWxwKLBMcThodkOo3F9hBz8i8h1xJTSdkRcfbLxiSc4Zvlo53bm2gude
         ydiA==
X-Forwarded-Encrypted: i=1; AJvYcCVAiNN7vWfuxG0JAo6Gg2VBTlUqgvgYUQb8MMqlbPKpLrQ9BKaSzFaJ4iEPaTepxrfHvDvWxw4fdySt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6FR9BYWoX/0qmwvaH/faFqnU4d9b/ZdszRxPN0j55NEtYhKsu
	oK0p0f9DbYM1QqOj9kR9gWt5B/lAh4uXUtq8Xs+CxTUPro2DtnGy8Fjn
X-Gm-Gg: ATEYQzwN/ub4Sqfg+g4nB/LvWlCa5xQAxlJXqGrrBaTMG1vBvRgbka4BwtSvt2P+/be
	durXnBCJhQ48IOz/jBOCyZqlSpTcxDsdcigsJc5kjy0xq1fV8/5GwNwlvkNg7LP90ubJDZdQpE6
	PKu+Bh/92ibVAaboTmazNtKRW8gNR/WUMeZX9X8/arYj8bq1NrzedjDswmHN9EoN2lazP5MjcL4
	NwQoCEfcaF8kt8V+WfZFEjGcTJyqt6uIeq2V+X+3AuJzNT4vGdzexxOFDIdZSvJWF/XeMivUl5f
	fnkDkP8MMVEwSf+nQbFnJkPRfgTqlJcp8hoIkyUTs5shAYLZVy1HbDjCgitWrqqp9SdN7mOXWrL
	PpoTa9O/Kz2pzdyeb1MpPKKai3VqUA5yP4cfNUsswzw1ZNmTk7tEfUhQnlJmQUsHd//BeWZTVjb
	6AMT1Q0/6lgPipMQQOHnLhFU9AUDGODGNWSRSCzzEPUFkrUT6eSbh9ZPwS2Q6YNI6X7uv//4k=
X-Received: by 2002:a05:7300:f18e:b0:2be:1dc7:99ae with SMTP id 5a478bee46e88-2be30fbcdbdmr2671438eec.6.1772725391326;
        Thu, 05 Mar 2026 07:43:11 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21d6::12ef? ([2620:10d:c090:400::5:3cc2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be2f5f1f4dsm3556315eec.25.2026.03.05.07.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 07:43:10 -0800 (PST)
Message-ID: <43433a0f-f063-4b12-ad3a-16bd6aa9cc31@gmail.com>
Date: Thu, 5 Mar 2026 07:43:08 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V4 5/5] eth: mlx5: Move pause storm errors to pause
 stats
To: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, alok.a.tiwari@oracle.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, davem@davemloft.net, dg573847474@gmail.com,
 donald.hunter@gmail.com, edumazet@google.com, gal@nvidia.com,
 horms@kernel.org, idosch@nvidia.com, jacob.e.keller@intel.com,
 kernel-team@meta.com, kory.maincent@bootlin.com, kuba@kernel.org,
 lee@trager.us, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux@armlinux.org.uk, mbloch@nvidia.com,
 mike.marciniszyn@gmail.com, o.rempel@pengutronix.de, pabeni@redhat.com,
 saeedm@nvidia.com, tariqt@nvidia.com, vadim.fedorenko@linux.dev
References: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
 <20260302230149.1580195-6-mohsin.bashr@gmail.com>
 <d02ac6b1-7322-49d9-881d-126b3a8d1d17@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <d02ac6b1-7322-49d9-881d-126b3a8d1d17@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 41464214E15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17546-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/5/26 6:12 AM, Tariq Toukan wrote:
> If we return here, tx_pause_storm_events remains unset, while rx/ 
> tx_pause_frames are already assigned.
> Is that acceptable? I'm probably fine with it.

Right. Since we are aggregating across all prio and if we fail 
mid-flight, IMO, we should not report partial sum which maybe inaccurate.

