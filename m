Return-Path: <linux-rdma+bounces-12192-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F506B060F2
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 16:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FAF581DFD
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4382E3AEA;
	Tue, 15 Jul 2025 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fffvTAaP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7392E041E;
	Tue, 15 Jul 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587999; cv=none; b=kj3pLU+/+tBzgTBKMMlLMw2VX1Tx7IE7WPlsTfUbwba0sq2y1jAzKXjPvtYfrZdeZo8spzui07rWbNt1Kfk/GJxMCqgbh2AfLOfFX4UIaVtI+Dcdg4jrfOFkCgByC6LaYsUlyVSnnai8oT89BNlEAlXFOnQ0BS5UbfMDuVYMqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587999; c=relaxed/simple;
	bh=5B0Cs/z2PiZzG1qVGUsvXQhJahtBwNXl++Lfm/ifQnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDgGvWswc/oPcRV4AaL5lV0YDNb3A8X9Wb5QEn0bYFnlQswUc0JEDoZ2ADibtwtUVUCIkineQD2Gp6qFMFBnG/F88S5P7Dvd5U0O9yV7Y8E0PSPAsK6wLZHn5VsK2STjWsKPzrfe7xxT+jWRwP3t+dhv8RlXigklYIgUvoP2n+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fffvTAaP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0d7b32322so903077966b.2;
        Tue, 15 Jul 2025 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752587996; x=1753192796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aNwRbRqWK0fatB8fxz0SpC6c5/9HkHUwS99RcbYSQM=;
        b=fffvTAaPlfEsR7LgH4F4psYsY4XiqSJoF+l6OFqn74xY1mCHNYA+1VXfa3FcvvDtC1
         jKgUQoqmLQ1NZ221yTp3YEQjt9+Q59FWgE0MP+NX4UunAFnyuq8QSKp0R7nmZBu+fO7F
         IzWV8KX1DyXTl3aMylLh90eepP2W6Ugdh8gdgPlrF9ptQVMzDkSl+nOhD1TA+VSmeaec
         MDiAB+jq9XM1Er0eJy/cTxiY1JtQDqydnGJ/JM8zVukcEy90SV1O092VhaoiZS1agM/R
         Y1O8scqpQTOJIgt6Mi74sbjZD1o8ssd5vzWzSYyGV5ptpNF+8/pUZh9Tp7mZ9WU78vRu
         3KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587996; x=1753192796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aNwRbRqWK0fatB8fxz0SpC6c5/9HkHUwS99RcbYSQM=;
        b=G/QSIzQ27ZakgHMi7hv1X+sVIuS7cc20VrD5IMZZ8K9N7j5C4HS5qGdWPyMqHPbifV
         LMCIUViHKegt7pQ1JbLe8L47S8HnsZNIRxnwHjPDeeiNCS2PIOHxuvEW9MOPHrEz9NHb
         tuErBZeGyhhUj36/YmMs1WBlBTWCn2SfukH146A6PP8u7PGZ1wmnkMiqQZBXrGTRISU2
         jZpgbajBnPQQ71vQwSk1kUs38wnphJHy62xwuyD8Qx6ZedjawqWQsjkEI66VrN9FItga
         eRAduAkn/7GPNugIK8etPsdOwOalfj+ckx0YgceqeC3ofHDkCppDqAjr5CU6b9gIJaPu
         L2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUTZKR7OwYfzscaIHda8a8sM1G4BiL+B4cJl44v4D5bbrbiWV6mjjFBiDC/8Wpj96KCG1x5YooTpMw=@vger.kernel.org, AJvYcCUVBUxdnUbZ3KDZ28Gsd180Zsmoh7f6RosXohPYacagAMlwflpi0UM9pQkm30l+uBH4eE9ej5inq7eluw==@vger.kernel.org, AJvYcCUj96QpY+iHn4AoUZlZYXFui7ydz7A1bFOOkuPEvXZKlzKYj74lGveb7O5SzXIUi1er2A2iU48H@vger.kernel.org, AJvYcCXq+9Bq5qwbkhQHIaFjF7FJYn69qwKiYI6704M6ND17WY/JcMc+zk9GcYwZizpszM3mETRdmrValWBWWWgC@vger.kernel.org
X-Gm-Message-State: AOJu0YzlccwyZYCPvPTASOnv+0WuxxEbd4qwu+MWh0KmkHxO8AgSsynv
	ude6KLyc6UAVOddONm3l5N+Po57YK3PTFTvYbSj/Nm1Vv54l/7vw0KR1
X-Gm-Gg: ASbGncsr00pMvM3o7UWPeA0SqYeFfw6fy9r0MqktuP7SGVizl8dEJ1sYKbEeV8wbi02
	uKQXrNbgIeV5olRwtfjiK4WnDls6d/qTGkYzp6djjxAy8NOC2xTJcviEokQkqc++qNl+e3VIwyW
	mpPW8T4Uz/NNkwMIZHze2dYToVkBQDQ92avGlY3C8C1qK3ZeryiYIfKtgN1DMCby+5GZu5IQzAG
	Evkeec+PJGsYOSzgjA2GwQiYrQzH/ptgImZwAqKdb87cttxtGk9BrwfrLlh8Zb9QQc19FcQNJ9i
	KOIlAgpGNH8po1eZ5No49G4dMXsNN26qPcLzODKpAfsQIWA5o5Gz4vbH/vXO4Qew8S3tnIrNhl+
	9E/9+fK6IqoCA9sQ1camd47XhBJQpxT5SJxJCXPY0W+Jn8g==
X-Google-Smtp-Source: AGHT+IF7+qcYv45SXbbrxsf029P5Fbar2rFM/IYkk30spoM3aAc/JjHKYOlRXfHnVz8iGqBalqILwQ==
X-Received: by 2002:a17:907:3ea4:b0:ae0:da16:f550 with SMTP id a640c23a62f3a-ae6fc3a8c72mr2025439466b.49.1752587995443;
        Tue, 15 Jul 2025 06:59:55 -0700 (PDT)
Received: from [172.27.34.41] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee44basm996503666b.42.2025.07.15.06.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:59:55 -0700 (PDT)
Message-ID: <b921eefe-3220-4b38-8b41-be6ddd98f913@gmail.com>
Date: Tue, 15 Jul 2025 16:59:43 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 2/3] net/mlx5e: Add device PCIe congestion
 ethtool stats
To: Jakub Kicinski <kuba@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeed@kernel.org>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
 <1752130292-22249-3-git-send-email-tariqt@nvidia.com>
 <20250711162504.2c0b365d@kernel.org>
 <nqfa765k7djsxh7w5hecuzt6r4hakbyocrp5wtqv63jyrjv3z2@qdar7f2osjcj>
 <20250714082600.15113118@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250714082600.15113118@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/07/2025 18:26, Jakub Kicinski wrote:
> On Sat, 12 Jul 2025 07:55:27 +0000 Dragos Tatulea wrote:
>>> The metrics make sense, but utilization has to be averaged over some
>>> period of time to be meaningful. Can you shad any light on what the
>>> measurement period or algorithm is?
>>
>> The measurement period in FW is 200 ms.
> 
> SG, please include in the doc.
>   
>>>> +	changes = cong_event->state ^ new_cong_state;
>>>> +	if (!changes)
>>>> +		return;
>>>
>>> no risk of the high / low events coming so quickly we'll miss both?
>> Yes it is possible and it is fine because short bursts are not counted. The
>> counters are for sustained high PCI BW usage.
>>
>>> Should there be a counter for "mis-firing" of that sort?
>>> You'd be surprised how long the scheduling latency for a kernel worker
>>> can be on a busy server :(
>>>   
>> The event is just a notification to read the state from FW. If the
>> read is issued later and the state has not changed then it will not be
>> considered.
> 
> 200ms is within the range of normal scheduler latency on a busy server.
> It's not a deal breaker, but I'd personally add a counter for wakeups
> which did not result in any state change. Likely recent experience
> with constant EEVDF regressions and sched_ext is coloring my judgment.
> 

NP with that.
We'll add it as a followup patch, after it's implemented and properly 
tested.

Same applies for the requested devlink config (replacing the sysfs).

For now, I'll respin without the configuration part and the extra counter.

