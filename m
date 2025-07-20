Return-Path: <linux-rdma+bounces-12325-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35076B0B4D6
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D237A918B
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D9D1EF36C;
	Sun, 20 Jul 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI5A7Idw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A2AD24;
	Sun, 20 Jul 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753006295; cv=none; b=mmGRM95GeNqHdxooGUGeUN0V6YT8kbhagl00MsGfHvDLFgHX0vCXvXZWN8LByL6a76yjhnQe0cd9Yq1Z7ckRiNqGfZze+iwQbzDllh95N3nnTWzZc4yBKOpd7o9xrTEwDIz56u82QMxnTZyDMtJDPnRddKIB8OPX70LBY1Phorc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753006295; c=relaxed/simple;
	bh=MEmze2/KZRm/Fg7Y6ZlAMO/Flv4J768QynVfXRHbNaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsLO8rygu9lski0zsec6tYP8j+lgahaJV6AfCytaAZ0vl62V2jCqxb6Rnq3mgM4mZtw3vcDVafj/9BmPfOBG0alCMsWYJITJ94v37H6knYuCJPwrZZybOLYZQnrMmZhEEKPQwHmZqJJuIvmkjgFO6QlIByvTozHXcFF8rMZUfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QI5A7Idw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4555f89b236so33413885e9.1;
        Sun, 20 Jul 2025 03:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753006293; x=1753611093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdRTpizrrU5e3G8Qae8BhJ1GHYpNCsEA8s4Rmi93U9U=;
        b=QI5A7IdwFyg533ugC5W3TcdWitsVLj/Kfni9xIAEUAIZH1cJ61PnlqX+4Mvzbms+gM
         mWE+BcH4tgWfCCK1Y7Qtu5j2nk37rLMteZIr8ZcBRELKEKWmJGm6DfIwiu0U/19PXoMp
         YfF03vHRwbFO7lzvf0gLnaPFthKu3b4dYzIeIRPJ1JCvt8Bbqm0JiojWK3xujfXBSOUV
         OJZyEZADV22FnjeKtv9ozr8BMtuQbJdjapZdtct8vdCxftKhRj/WAx0044AxwaeUTfyw
         px2qJpaywoQ3Bw9EPIkAnxVO7Y6xUwdkUAZDHApksZLuqHqDDk6iOc/Jl8RUq/eoK9No
         HiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753006293; x=1753611093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdRTpizrrU5e3G8Qae8BhJ1GHYpNCsEA8s4Rmi93U9U=;
        b=Zsi8EhY9dHAm+fOe2STos9ktrsaIru1tNQFkrVTa2b+jmoFY8KHbT+791xJLzhucZG
         yAVJ4PhHq52ZTkFS0qLLF7mvKdwb04pexaS/cAhK8dZ7nJ/h1kUFmOsXgBMqbw0J7SIp
         mtY5nawR/5nrFGJ2/a9Dy8m7mYxMTOUjxfW2W3fzaHRyLfKA08ahjppUnF2aQ6xNRVEu
         /tenIvcHhfWl3lp0+1SkF4QXBxdXxm5AFOVekqMb9HZ1BKLMVH8HBSSrO64MB+NQJdGt
         fE3SzIrv7MfeJTG0oB7Sg5x+AUQGhrjDoMMINGYYDZgLHTS8H7jCLcdm7H+d3LltoDN8
         Pd5g==
X-Forwarded-Encrypted: i=1; AJvYcCUROAmIlafjjH0aHHFGm8KiphxQ4CwTydwTiWNDWXV13aDPIEoIlAwhro+RkmSvpnOaPn27tnKZMEk=@vger.kernel.org, AJvYcCWHUsBIOyCzaGW8g6DOvnUIlkugAxrTr7urYPFVnDLeZUtvGSVZCMDF91V+OK7UNXr9/5mUB1TK@vger.kernel.org, AJvYcCXcslcLQpTX6YAgw4VFzFRSvKtr+lb9cFgWhLzJbF74nOduHwj+EX3jaWsOmhXqN4NsFlVP2yFugevRKw==@vger.kernel.org, AJvYcCXiH+l5hNGB9FDSxj4HxgIhQbSmY93cciqtDwRhM8dRPxPeScG9f3I3/iIEeL1cudivUe9gq/X/WWDVjSZy@vger.kernel.org
X-Gm-Message-State: AOJu0YzPv9sApn+samv1nWJeV/+ej4c+VJjmAQAKIcgMyMNBLdcP4SW3
	WEljSWlKpiA65Bl2GP9ppdeurRAhECcCoVmQFHO/EKZ30lzTXAMa4gK5
X-Gm-Gg: ASbGnctuOCPi15wnI3OnUPdqRNQIPznUGr5ziZfTnBjKHa7D2iJOuC2C08f5Bw7ZZVs
	cxQm0DkZrhfoyKl8FcAZPvi+Kacehn8RQMnUKItXXCSLquKwNuyICi/kHYF2oaW503cyVlAfGDq
	AZYXjWQZbQ9zG5/vwFdR+pF20ZJU4FJPqdW39M2ox9cINqSceEjVlDfyxrwJIAiDIujgWE4OEDL
	vZticupxflp26yd7Vv4OeLAQUKAt8t1XJSg7p+jaoMeeJFtsEv55qglfhdHuefTVYd8e+oNqrHa
	ZjGBDFGeg+pZlIOqqZ6yTxf0NeK9yKDnuok0Md4WLuK5udu9jG/KHImAEXBiztU2m5NDSPNqZe3
	BdCBReS3QCFtn/0W0aAHCFssu9MComSo519Fmr4dfZ2sxlR/CK36x7kIPjQ==
X-Google-Smtp-Source: AGHT+IF2s+ysLSvlfEeRDPjVCEmq+qa5T5BlTc61WRYN/BrMqkjiw4nWQHAfv2AZZ83vJjydX+cmVA==
X-Received: by 2002:a05:600c:64ca:b0:456:1752:2b43 with SMTP id 5b1f17b1804b1-4562e39ba8dmr145529555e9.21.1753006292314;
        Sun, 20 Jul 2025 03:11:32 -0700 (PDT)
Received: from [172.27.57.153] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45627898725sm114520565e9.1.2025.07.20.03.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 03:11:31 -0700 (PDT)
Message-ID: <f132d14c-0d82-495f-8f6d-bf87ecb4bc75@gmail.com>
Date: Sun, 20 Jul 2025 13:11:27 +0300
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
 <20250718174844.71062bc9@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250718174844.71062bc9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/07/2025 3:48, Jakub Kicinski wrote:
> On Thu, 17 Jul 2025 19:07:21 +0300 Tariq Toukan wrote:
>> +	DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY,	/* u64 */
> 
> /me pulls out a ruler
> 
> 50 characters, -ENAMETOOLONG

We'll address.

