Return-Path: <linux-rdma+bounces-6347-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C739E9FB2
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 20:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6AC163C06
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625881925A2;
	Mon,  9 Dec 2024 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po6kgxGp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482314E2CC;
	Mon,  9 Dec 2024 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772765; cv=none; b=KYBs5kqmF0z7D8htmY1j4fWqaESQVSsvyL6ZAxBMwSjSqhL2lWBgoE7vM+ib4SkTyTMsDjyCO7J6S1YnBAp4P5qUQfoOtp42g3F+lkNqGJpPq3EWsyllXMJJC9KQKLdT1IiGX7t1LBUezhqsfcdqVA06bWSqCLsgP7g2ykJzF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772765; c=relaxed/simple;
	bh=nDCRiAHwakK//Bcc+jnZyZLbxnMIpgMOIzyogEzEbPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sc5TpjIb1G+lMXLbryzb5wmdA7Hrwg4rzXNx+ndfQ9bGXxZri2NYNdFjiV5zmbOTUlGZ8yMNMI60I5OUEntzLq9wS7EvAmyZ/H80etHxQh3mwtvR/ROI9csp8JlRAWr5V5A9nRbPdWfSaah+iV6vhROoLgtuRTkeHnFoMtMRHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po6kgxGp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a044dce2so52709045e9.2;
        Mon, 09 Dec 2024 11:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733772762; x=1734377562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=si/c7TT8m5F0UrPdNlKaUK4J0Ajn01FxjzLYIr+vSE0=;
        b=Po6kgxGp1wbq9jND1CE34cfkTCoQhMVfg+Y0db7P0D4e3B1KeBC53szRTAzIXLeSJt
         /22BTyPQToE4AR9edyzq908WMuK7AQRSYPppI+o2rtBskyz9W5kATZZZDkf3ZhSBsHjf
         KhmrdkhNv1YYKwtw2BwcQ8LNvOU+NlhT6DIr/J7YU4wr36/3cwg8pxw/pMxu/g7IF6KW
         LwNM+QhWoofBXe77+fDsOE3faTLnJ9yFGT+eUVXcxOjdBlELfUo4H0GcCythxPqNmxyS
         LERgbtj3L9Xzk5Qu5PeqxXmiKakklhe02HMqhyOzI10oDJ0wlTyHzPAVcv6kvxGUWMGp
         2w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772762; x=1734377562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=si/c7TT8m5F0UrPdNlKaUK4J0Ajn01FxjzLYIr+vSE0=;
        b=SauPHjlW74dk3OryCtFAnWrwh87wFVKa9aTKINmq1YMxCXh35bDFme3Ldx/W2hR7EW
         o1EbaLje3vN5pq89yn7N6Zc4IcjFy+jT33hCnOJZNL5kcm+Kfe4PBK9iTlAubM01sHkj
         p+DxgCk9RbD0L7hpJZZ+szFCrEQzMG9WLNIdc1ASO/jAV84AHRkV34WTaK4CCAVYJtvk
         6BnSRnTbis5uIOUHY2QkXL8Wy/s0nbCH6j2/pHZxKXKwEU8jS3gBRGvH7EzW4SqqlIg+
         cEDrvcg44iAbrQJ5Hzm9VrZOsiW9LiV2jwNudBlatcTmkL4O9RqsOUcP1ptQTU/QZFuh
         Pwaw==
X-Forwarded-Encrypted: i=1; AJvYcCUKUOMEbTdMiEKViMxi/HoKf8JndvYV+4VH3UaKXTfXYH1p73Wr7x+ilAfOmt8DIiI/Qup3reky@vger.kernel.org, AJvYcCWAuaTW5fhQnmuAC03+1hCvuRXH0tiQcfPYDaEgBiF/lsOGIhy1fg1cwuYmFF/9/KPFqYsXUd/Lfdod@vger.kernel.org
X-Gm-Message-State: AOJu0Yz58KYFZSTiR8cE8zEThH9zpqohp2c5XAT/s0vYW2X6oykIpwQU
	THdKDmjaEnMfKHdgdVw/kdDxkg7kYrmUy7zGinC342oHFMu/zj8EoduuGQ==
X-Gm-Gg: ASbGnct7ytUy8oJciNJDAra1U1Q51RE6idevBsRnT+lGIHQk/EIRg6Rey7e77OwWnsI
	r2ZCKMgRsnxZ291RZ7ndGnjq5nIt3wVVkqMOgTObcak+9IR9KNGcX1ILh4fpXBtlAFYFvHeQsnE
	BRf9JBZFy7k6/xOyBzFUWr0N6zbWo8egpMObW27ry7HHZ0ufqC2NHbXbCtskOorXwI3TdMQpeUk
	t4gM4jPeijVD+am1tD6M+BvKt7QXLtTTUiP3K2QV/31Trzhs4sqn41ta7DfKrrtAePjEug=
X-Google-Smtp-Source: AGHT+IGy9kK+TKwZILlQ+2sLCkBGgZBkkzrfYL393vuDKxjYmcMjFd+MfkG6vhc6em8cm7Qo0wQTVA==
X-Received: by 2002:a05:6000:42c6:b0:385:f560:7916 with SMTP id ffacd0b85a97d-386453e7565mr1326423f8f.35.1733772761554;
        Mon, 09 Dec 2024 11:32:41 -0800 (PST)
Received: from [192.168.0.112] ([77.124.178.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a8758sm13788222f8f.27.2024.12.09.11.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 11:32:41 -0800 (PST)
Message-ID: <d4890336-db2d-49f6-9502-6558cbaccefa@gmail.com>
Date: Mon, 9 Dec 2024 21:32:11 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering + Rate
 management on traffic classes
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org
References: <20241204220931.254964-1-tariqt@nvidia.com>
 <20241206181345.3eccfca4@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241206181345.3eccfca4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/12/2024 4:13, Jakub Kicinski wrote:
> On Thu, 5 Dec 2024 00:09:20 +0200 Tariq Toukan wrote:
>> This patch series extends the devlink-rate API to support traffic class
>> (TC) bandwidth management, enabling more granular control over traffic
>> shaping and rate limiting across multiple TCs. The API now allows users
>> to specify bandwidth proportions for different traffic classes in a
>> single command. This is particularly useful for managing Enhanced
>> Transmission Selection (ETS) for groups of Virtual Functions (VFs),
>> allowing precise bandwidth allocation across traffic classes.
>>
>> Additionally the series refines the QoS handling in net/mlx5 to support
>> TC arbitration and bandwidth management on vports and rate nodes.
>>
>> Extend devlink-rate API to support rate management on TCs:
>> - devlink: Extend the devlink rate API to support traffic class
>>    bandwidth management
>>
>> Introduce a no-op implementation:
>> - net/mlx5: Add no-op implementation for setting tc-bw on rate objects
>>
>> Add support for enabling and disabling TC QoS on vports and nodes:
>> - net/mlx5: Add support for setting tc-bw on nodes
>> - net/mlx5: Add traffic class scheduling support for vport QoS
>>
>> Support for setting tc-bw on rate objects:
>> - net/mlx5: Manage TC arbiter nodes and implement full support for
>>    tc-bw
> 
> Do you expect TC bw allocation to work on non-leaf nodes?
> 

Yes. That's the point. It works.

> How does this relate to the rate API which Paolo added? He was asked
> to build in a way to integrate with devlink now devlink is growing
> extra features again, which presumably the other API will also need.
> And the integration may turn out to be challenging.
> 

AFAIU Paolo's work is not for shapers 'above' the network device level, 
i.e. groups.

