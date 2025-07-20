Return-Path: <linux-rdma+bounces-12327-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A5BB0B4F9
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 12:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E289A17B6E4
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3581F3D56;
	Sun, 20 Jul 2025 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0i56vIc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FAD23DE;
	Sun, 20 Jul 2025 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753008462; cv=none; b=mDK3SSJwvKeOtpFVw1q/SYMRwGQz4kyhqXyum97jn8hVRVbFx6D2XDhkk1lOziFT1/XuF8kaLK8OVSFMV1GGqDH9cNybvKl5hmGIhuRubrLY/tgj9de4Rz4F8SGZ1EzIcYf4eq6FPara5vqDE38zS+q5Yhl4ES8n2p/sIlcKDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753008462; c=relaxed/simple;
	bh=WnmhAU+QbPNFjea0UMVWxGtAMHliXlZC4xHwI8GmgVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAZH33iIgZladuGOvK2Ogyt4CmbiZKcJRn3ULaUakVGhg+dQpf5RwIF7cJRu3VKcF6eTHRMXbG5hfz0gyWCHzG+93jOw2qWuDbtEhLh3XSZA5VdN/l/44+Lo3Qj9eNR52PycSKOHH5F919VlnFH2js/PwKD97QCu9fcJgNmEdVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0i56vIc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45629702e52so14271205e9.2;
        Sun, 20 Jul 2025 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753008459; x=1753613259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXppDYkB/CLtGMSTjlPO5sKSjzJTwa5EEMJH+XUJYU8=;
        b=g0i56vIcXL6LmIr14PG0GsCQQoeqD3rnG7lnbjUdyKdLJ6PeNQ3AnQIycwKfydd1eF
         qm0uguO2UYw00nlsrNqrvSr9yzCkk6RgW5eoJWSNrJjrbE+aICZYm4kHwj6N+4uC/WqT
         BCfbRgifd4YijNmMesLhvUm7Gp3ksFBwSs/DAGeI6jNxnq8VSpmqcNlbpXZrqIulYsES
         Mr121OeK4/r7LcKICM+iaYYO39oztaN5j0AYg5MKo4QfbzYRHwZei2ZIA5B4aM6Hh989
         +PhofYoayM/XmNEweBXDGc6X5JZ3cHfceR1BpOehdzfI+/9LOgC9QEk2gNTZQwZ8JfgC
         k0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753008459; x=1753613259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXppDYkB/CLtGMSTjlPO5sKSjzJTwa5EEMJH+XUJYU8=;
        b=tQjZnDzq4qFxwkuK/DG9DWDjB6Em/JIk9Nhf/GLBBmmcpr4+MoazLgW8QNJDi6NkmD
         FkG4FUVc8/obTSq3w2vyDHhgxZg/RmWNTa9hvL22XzrRLDEiY0ukZdA9JF7abqNflYLs
         Mm2zzufmdSbyGcUuhNEPjDAfGNT5igA1qQRcetnQs1QcaoPZy1ZHWHe7P9Z99pOq/qJ/
         vLODzKnNU81EiqZhDlOnkq7M6UZ9ePwkwY3ZkVV46wdf5ZKlo9+GvP3G8/wLl+UBGs+I
         jRQxRWr31EKinA70nDsXnNZ8M8vN0XXZz4oDALNhHOp9YodC2udaPbypeR8J08pMmGNz
         jALw==
X-Forwarded-Encrypted: i=1; AJvYcCUPzMFtZ4/DNoaIGwtDTvMO7+xdvRAnf/Ex3Iymo929S+4q4lMVsta17yDd/GgUZeR5RlC9hJiIoGoHsfFV@vger.kernel.org, AJvYcCV257mT0Vq+0yQ5Gq9Qk9ycDSnvFmv5i2GUcukL8/ZD3xI9e918cmQI6u52HZkZ8HK3j8cYqeT5nj8y1A==@vger.kernel.org, AJvYcCVR/1H4jasD+huwR+O8jbOvTtoC1PZaSTyg/3/N61lxSv+02Z/XnJzOetVYDRb5uzJjRv5wuTO9J6k=@vger.kernel.org, AJvYcCWnvUlAavvjPu2KBkFn2Ls0Iq2x4yQHQTqgrt7fNgge8gSLnejbc4zcbuFhRRPY4Ja+x+acpKRI@vger.kernel.org
X-Gm-Message-State: AOJu0YyNu8ydWl5HgzQxgeJB35IvZWAgGU8eiH2HbyVkXc0hUMOznX7I
	TxBErTK8T53DhWK4mZIdMUbxAXCwNKEW9X+MiDgN1ioMbXpfi59YHzFJ
X-Gm-Gg: ASbGncv19a+ybKptSUu49qFe36VfXHiYVzrrNsDQgvAd551X54cipsRLXVkHAjmP7Lp
	i+rUW2GG3NogI99nAvl4CnZRZxlsANCaAITpecKXi1X0ij+yxmt7MQjrX5vHrQEXCXPaaGwizMA
	AsLC6J2fb/Nkf2M0OaJ6meVDaCVTsINx21dkC51sK9ljqTPj+lUDZUeKnX6J0Dl2DgGwuKy+opb
	NwTXFaIBJOyZ1Ll3aBL5Ay3HMFS+mSXQPOQ1XE5/iFpPOr9+3on/z3U0M68WfBm7Ajnrgt5eoZ0
	JBHxX9I0O9PPtSs0NoovUCIPe+7lUoUED3EiDnZ9WUdZBXNx9w7OWDh+F1dHhfw57EPMwY5AAHJ
	vtLd6x+GjwQ6RiGUNr67qmkumrzc3P7TYuZaeeh1eh+JvjP/p95pqeFutfQ==
X-Google-Smtp-Source: AGHT+IGFX2jZ4V6/iEd8Ara4dWX6b93jNPyhb58hgpz2fHfo6DiHF+DpKuDmcFkoxMPT94DFoU2yDw==
X-Received: by 2002:a05:600c:4ed3:b0:456:1a69:94fb with SMTP id 5b1f17b1804b1-4562e33d914mr159581915e9.13.1753008458288;
        Sun, 20 Jul 2025 03:47:38 -0700 (PDT)
Received: from [172.27.57.153] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca486edsm7329869f8f.56.2025.07.20.03.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 03:47:37 -0700 (PDT)
Message-ID: <8933092f-c178-4207-acce-107c471d606e@gmail.com>
Date: Sun, 20 Jul 2025 13:47:33 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] devlink: Make health reporter grace period
 delay configurable
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>,
 Jiri Pirko <jiri@nvidia.com>, Saeed Mahameed <saeed@kernel.org>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Shahar Shitrit <shshitrit@nvidia.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Brett Creeley <brett.creeley@amd.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Cai Huoqing
 <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
References: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
 <1752768442-264413-5-git-send-email-tariqt@nvidia.com>
 <20250718175136.265a64aa@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250718175136.265a64aa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/07/2025 3:51, Jakub Kicinski wrote:
> On Thu, 17 Jul 2025 19:07:21 +0300 Tariq Toukan wrote:
>> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>> index e72bcc239afd..42a11b7e4a70 100644
>> --- a/include/uapi/linux/devlink.h
>> +++ b/include/uapi/linux/devlink.h
>> @@ -634,6 +634,8 @@ enum devlink_attr {
>>   
>>   	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
>>   
>> +	DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY,	/* u64 */
>> +
>>   	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
>>   	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
>>   	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
> 
> BTW the patch from Carolina to cut the TC attributes from the main enum
> is higher prio that this.
> 

WIP. We'll send it soon.


