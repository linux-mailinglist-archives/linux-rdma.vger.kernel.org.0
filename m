Return-Path: <linux-rdma+bounces-5420-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C269A0216
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 09:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471781C21C89
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 07:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383AC198E81;
	Wed, 16 Oct 2024 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+Q1aMNR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC1A18E055;
	Wed, 16 Oct 2024 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062340; cv=none; b=KbUFJD4vkipKZDtY0skRykXFqccY1y1pJhyOixWxsyA6av5hc23kOH0t2xNqPYGdYnwQp3g6qch65tQOmY4tNR7L0qQWNP1GJ3NqfisumB6DIhdZR+hqjsbFVKqmeLQTg8Y0zl5e16M8oKFaf3+msnIt0d6BFnOGYiVXxJ/OkZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062340; c=relaxed/simple;
	bh=1OogScL2vT4XUM2tcbueT9ISiraqTBs5OYjEXM2+FAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOfb+zbVk+P4AikYN7ZIj+gVq1It4Sk0oMH45s7BWc9tf6jg/tr3ftYAuZhxwqaLo1V32uoNFleBiVsLx212DfO6sYcr6wyrTzkf5Fby1DlMntCcWFL2EVIjHVDC7ERx3gDwfe5ogxIHz3poOLIVfTzpHuhMA3yPJXGeeyWLufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+Q1aMNR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so49032975e9.2;
        Wed, 16 Oct 2024 00:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729062336; x=1729667136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZaY3fagvzjZhfsBlFcJM1lLgrhfRU5uGWy8xx6ku30=;
        b=S+Q1aMNReF1l+IxpMFBMmcriUHuWJ1gAkR0hY44TdsvjPkwa4txFHR4YIFoNCfifwu
         wUFm8yEpdBiMmoRgsjJ+1P9rap2FM5YkQFA3gNG/UzrSlmOHSrwihnyAjK2r+xfMwPFr
         2jAlHiaGoGBMZHvmF8+OuEWTMsrDuVMtkKwdEcYySe6Z9EBHfyZumaAEWFmcjk1kbBk7
         Qw+GcZbTXWfnGrIZjqDBof+XsXmaj+2cUGzIdzpe9OrwBfQwp0spefbzKjtiiQiC7gGt
         thsMBdenlxbqLLebGm7htI+OAcZoLrObbQQLfmaXuN9Gvrk/6F0yuBAcrsBK+es4tcjL
         UxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729062336; x=1729667136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZaY3fagvzjZhfsBlFcJM1lLgrhfRU5uGWy8xx6ku30=;
        b=ZM9Fu9oWFFRGs5kuCdh/4p0qxGYKsJkilPplQGV9U25qYQfDW6HGC0R/gv3toCFwPb
         OO9cDJzLVndqoUzAwQxoX6FQf5JRa2SY06ks2/Lgjd1M76BmYcNp8Vgh5gaPh04Co0b/
         4beO1EpPV9aDyq3Xr3J1DMjLumYw5iuMv5TCDlw9g/WZYKWxsIXwo+MzPElspRUxbjnn
         trP2iWrfYRqbS+lJBUASVz04v5C0hCpjdu1QP5JSQ62beQjmUTQmAio5jG5X3vz0rIUj
         vmSRHEumUcvw0uwXgiZmO76F6tpt7bRbxmoHRogA+JWDgQyXPnqQkAym11GMaaEIbZn9
         LAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgiyQ6L4flJ0wychLtQ0uu6riOqpcqyYm3L33zk91fmittRhQjCWvFGCfePXRgVoc+ctHOxU6a@vger.kernel.org, AJvYcCW0x/Lp/wXsZrDcxe0eY5EseY6EsnZGpRU5vFkth05nzyFJWPOqeetUiY9Cf63bVdlMnTGJU7ZxPcsw@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0RjsVA7X8l4Ybrg6CAGLirKGuAFLMtf9mZLx5qulzJnV4lMS
	BcFA28ACYbAM5KeqGf5w7zsvVcf6JGIDjOmwxdWSqamEZC7Q6iCRY2oc/A==
X-Google-Smtp-Source: AGHT+IE16Hq0npDuN0cxS/mTJafo7XptCpY29htdTR4xWXoh3N2qZFroC8n7wIuCsJDmoD9P3p6Zkg==
X-Received: by 2002:a05:600c:35ce:b0:431:50cb:2398 with SMTP id 5b1f17b1804b1-43150cb2511mr8498975e9.2.1729062335937;
        Wed, 16 Oct 2024 00:05:35 -0700 (PDT)
Received: from [172.27.19.181] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f55df27sm40143325e9.9.2024.10.16.00.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 00:05:35 -0700 (PDT)
Message-ID: <3efc849a-7f53-48fb-b26b-920f82ba3632@gmail.com>
Date: Wed, 16 Oct 2024 10:05:32 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] net/mlx5: missing sysfs hwmon entry for ConnectX-4 cards
To: Jakub Kicinski <kuba@kernel.org>, saeedm@nvidia.com, tariqt@nvidia.com,
 Til Kaiser <mail@tk154.de>
Cc: leonro@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, cratiu@nvidia.com,
 Adham Faris <afaris@nvidia.com>
References: <bc8ba1b7-e4ad-40b5-b69d-9ea1e7a18a40@tk154.de>
 <20241015080617.79e90a06@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241015080617.79e90a06@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/10/2024 18:06, Jakub Kicinski wrote:
> On Thu, 10 Oct 2024 17:11:21 +0200 Til Kaiser wrote:
>> I noticed on our dual-port 100G ConnectX-4 cards (MT27700 Family)
>> running Linux Kernel version 6.6.56 and the latest ConnectX-4 firmware
>> version 12.28.2302 that we do not have a sysfs hwmon entry for reading
>> temperature values.
>> When running Kernel version 6.6.32, the hwmon entry is there again, and
>> I can read the temperature values of those cards.
>> Strangely, this problem doesn't occur on our ConnectX-4 Lx cards
>> (MT27710 Family), regardless of which Kernel version I use.
>>
>> I looked into the mlx5 core driver and noticed that it is checking the
>> MCAM register here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c?h=v6.6.56#n380.
>> When I removed that check, the hwmon entry reappeared again.
>>
>> Looking into recent mlx5 commits regarding this MCAM register, I found
>> this commit:
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.6.56&id=fb035aa9a3f8fd327ab83b15a94929d2b9045995.
>> When I reverted this commit, the hwmon entry also reappeared again.
>>
>> I also found a firmware bug fix regarding that register inside the
>> ConnectX-4 Lx bug fix history here (Ref. 2339971):
>> https://docs.nvidia.com/networking/display/connectx4lxfirmwarev14321900/bug+fixes+history.
>> I couldn't find such a firmware fix for the non-Lx ConnectX-4 cards. So,
>> I'm unsure whether this might be a mlx5 driver or firmware issue.
> 
> Hi, any word on this? Sounds like a fairly straightforward problem.
> 

Hi,

Thanks for your report.

The hwmon sysfs entry should appear only on capable device/fw.

The driver initially used a wrong offset for the cap bit, until noticed 
and fixes.

According to your description above, it seems to me that your FW doesn't 
have the cap bit enabled. When reverting to the wrong offset, the driver 
"happen" to point to some other enabled but unrelated feature..

Let me double check with the FW team regarding your specific FW 
version/device.

Regards,
Tariq


