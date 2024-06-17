Return-Path: <linux-rdma+bounces-3194-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B6F90A868
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 10:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232C11F2183A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4419049B;
	Mon, 17 Jun 2024 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrPbou6g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8BE17F5;
	Mon, 17 Jun 2024 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613046; cv=none; b=HDxVmjDIDFJxpUJyU/kkqqeebd/n4OlXK8E8doGF/1SpGNtZGWknmin1KmJmUunM75B3quV0mRAWuxGLn2VfGrwa7XT+NwrmYJ7KNPAPTOtBQJBnFWANH7LMhAevRCRmm72yC8Kk59hAINPs/R0ATdFsKUdIAogWLNmFE6imF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613046; c=relaxed/simple;
	bh=yYxw7L+gzDilEI/XWHbKIFjpkH6nrx3hA+WiZNpLLP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qTKOlwO4OTakvHKmFp/vPqrbcRr9yU3NLSlTHepGYMB01OaxfBSVPipKxfZTA2ryNxVeZm7XwzxkSb0OvHLiEp0+2LFmFF66DTZX/u03z8RKfY0Tub/bDOf6o2XTF7ioZQRuzTrP0eZwSgzxxBJ2+EnixRCJjIHSeZnOV8aZHjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrPbou6g; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so3554974f8f.1;
        Mon, 17 Jun 2024 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718613043; x=1719217843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVSDet1jU8e9qxWG/OSUjestn/66Ck7NYAywURhS3+I=;
        b=ZrPbou6gOgZDcOGEH/lITWZ5rRSCmZuSBFEhg1W1hIAUqmbuuthowKjSH6hWMa0u6c
         xlnJuo1BwgIZ/FahOZtZYQG4n0JvrRvDQLiHQPJsdGBhwmX4pVT7NnkBMId4l9u7izVE
         V1EAsQZoWfG3Ax3IUctuXWrys7zenqskwCqJte/ySkDlwEdvfQeItAWbFRfDX7kT2BCy
         L73sItveiGSqAuy6TClWOAODjHU2y7groaWhe9+a9vFjnxCDeiN2NvhZyglfarxtdUhT
         d5i1GLcvRxng9sNm87iqpcFmPrkpMNczqzwB+ZUk7kbjq8lkKHkdtDVn5UbGecOukzKM
         7gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718613043; x=1719217843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVSDet1jU8e9qxWG/OSUjestn/66Ck7NYAywURhS3+I=;
        b=VHVHdQ7C7dOrS8M0a8ONEs5W9lALLVYaK6sSwIXSz1GmSe6f+Ds62ZSfpRpIr3fHaa
         kha9NiDzM3E1+sTO36cjDp7fjZWut2w7CiOY5wQHMpxMaZlKjdFNYsYNPo21CMGK7ya8
         7t+a1EUjbC5S/doj5PWXLQOcvmcp5yrcQHCOgu+CP5xyhMqlRKEXRPwrQEwUnAJPSWUd
         qxtOcpYJ7ceMQxVR7Atl7Eo+TBwFjLgzwU+QhCXmT1w+r/2smoYv6l06G7N9NZPtE16V
         fwhD1x4fOGSGDU855ZhxfAWHFUu8IKNkUBdUuKJ8LfgULEYkvhbwOz96lt/sF3hhLqpq
         D27Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzPJdx6no6P2n0qcDg2L+dq2OPtqNKAmHZmj3Xcq3Z9ETe41Jcc6J+blYNnpWpOxC8/Be+1Q3ZKxtKPhOdC2Jpf0RgCRd2CdDcUjm1Xc8SK1C+Ne/FzTR2YSgEyD9oiM/eExzsXAEKm35ZEls24AqMqFG5+XeFOTbbxWkxwCDH5Q==
X-Gm-Message-State: AOJu0YxJkK02ADhnmHtB5q3JL65t5txhNCDyULVfTqdBWZ1xNc8dvdM7
	UCmVVF0cxmZSA8MX+iAwBY8N4jfKVGiCkPivUU+evbkHxtEab69M
X-Google-Smtp-Source: AGHT+IGbJvNXxttiBMa1KsFPj/tmntA/qNIHNUlo5b9laNDyBmWTRtbokJXpTeLkSl34hyQYAX13sA==
X-Received: by 2002:a5d:42cb:0:b0:360:82d6:5e98 with SMTP id ffacd0b85a97d-36082d65fa1mr4975741f8f.51.1718613042899;
        Mon, 17 Jun 2024 01:30:42 -0700 (PDT)
Received: from [10.158.37.53] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c9a0sm11331771f8f.27.2024.06.17.01.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 01:30:42 -0700 (PDT)
Message-ID: <9ec867ad-6b7b-4ca9-83c6-66e9aa674cae@gmail.com>
Date: Mon, 17 Jun 2024 11:30:40 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v5 2/2] net/mlx5e: Add per queue netdev-genl stats
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nalramli@fastly.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20240612200900.246492-1-jdamato@fastly.com>
 <20240612200900.246492-3-jdamato@fastly.com>
 <0a38f58a-2b1e-4d78-90e1-eb8539f65306@gmail.com>
 <20240613145817.32992753@kernel.org> <ZmtusKxkPzSTkMxo@LQ3V64L9R2>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ZmtusKxkPzSTkMxo@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/06/2024 1:12, Joe Damato wrote:
> On Thu, Jun 13, 2024 at 02:58:17PM -0700, Jakub Kicinski wrote:
>> On Thu, 13 Jun 2024 23:25:12 +0300 Tariq Toukan wrote:
>>>> +		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
>>>
>>> IIUC, per the current kernel implementation, the lower parts won't be
>>> completed in a loop over [0..real_num_rx_queues-1], as that loop is
>>> conditional, happening only if the queues are active.
>>
>> Could you rephrase this? Is priv->channels.params.num_channels
>> non-zero also when device is closed? I'm just guessing from
>> the code, TBH, I can't parse your reply :(
> 
> I don't mean to speak for Tariq (so my apologies Tariq), but I
> suspect it may not be clear in which cases IFF_UP is checked and in
> which cases get_base is called.
> 

Exactly.

> I tried to clear it up in my longer response with examples from
> code.
> 
> If you have a moment could you take a look and let me know if I've
> gotten it wrong in my explanation/walk through?

Thanks for the detailed explanation.

