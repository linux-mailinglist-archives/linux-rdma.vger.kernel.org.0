Return-Path: <linux-rdma+bounces-2803-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733BB8FA379
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 23:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90DE282E01
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 21:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D040E13C682;
	Mon,  3 Jun 2024 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs+3QsX2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370313BAFA;
	Mon,  3 Jun 2024 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450583; cv=none; b=kYXX3Pjcat4AOopT38Hxza6v2QiEF8/TN2Vto/4Vi+r0L/s3wK47KpON37gwERDZ6jvjIWaiOmf8J+IjFIswKqXDvKZJjZBPXqJB1D1rDao8jD/sOw/vsJWARmoe3U/XF+RqefnI5idVmUBm0ZUNErl7yrVsLJbaDw+gAwfsT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450583; c=relaxed/simple;
	bh=yP79aolh8GQFN+IHos8AknZ14rK4+i6ta2F7QFhKUwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oizL6pjQ7F4zP07GhTf//XxVUmV1HDOG6cYCY+jNR1g/oNXBVrrXePYKUPawaaQ0gwVVKL2PsAcKmTAbJc2wHqTPPkVtLJVEkEXdkPujDoLbNdvv9h6cfTLk1Jz5h+jSwpAaInmy/qRuKmF8YNCgLu4qkF3YzO2ThpzOSfaKRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs+3QsX2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35e1fcd0c0fso453531f8f.0;
        Mon, 03 Jun 2024 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717450580; x=1718055380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f1v+KA04jP8QqbiGIVQWtQ3w6aQ7F0PDEMAzrcid//c=;
        b=Fs+3QsX2Va8RV26k9MFN3rN7hHu+M6ao8T82+RjXgAQKoU00n1A3fX0h3cMYMPa4dV
         EctG2zDJMGBsW11yFrkQ1smjRMEGAhMQH4E8jQ9QYGo6j/emVbguWW+R10XWOhGJiVMt
         kVk/aMTb0Lbgp7gvhPR/gNdNOGsllJiOPYy/40ZsBVkChFXacKGY6/etcmQniXJJWnWc
         j6aKNJ/GoqKkga2CvMd7DTpmObE8o0oLT9dCCoN+xCKh+/sczAB30D2yMXU1TQotPEOY
         5ZHa7GmhlSyNTgmN4SFeYDUpvCZp2JvPmUUkU5XrqInV9X3Z442BitxBiCnmeDXsFhCc
         mzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450580; x=1718055380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1v+KA04jP8QqbiGIVQWtQ3w6aQ7F0PDEMAzrcid//c=;
        b=rKDH/+D716hctIi/P7ZEjs2MiLuvrXbwE+jhp3gFSx09SHTWB+hdb/fSeAp4yDYtKR
         i/XSTGbOtsAZJgkhL9699BNltwLDC0jKE/WLjNPM/NkBjIWhmeRLfYGXZcKbxMu4MR2b
         U2JiafLibh7T5y0ENnzSL5jHw8WvhQFdG1DG7CZf8PbwpL8hUpw6tJlHAiTs5pPRw22c
         AlH+OUbizD9fsGAiI0WifDwLR4OtqNuenV+gKGuVy0wDEyQwBErSDpaZZaJXLr6TVMey
         mYxDuOazwIkyLRDprN5PUMvyUEC2Y0R3hAGK9YlGZXVJHEi8E12wSFrdUp5Vh2Zp/Oc4
         hh0A==
X-Forwarded-Encrypted: i=1; AJvYcCVF9QKvkcvWy/9Fum3oj4lsUbPwU5oiSoRYba1HQ0YygIle3yZPWQPICS7qFYiiMGuM9Ne6/PS9jVXFJtBfhjIG9rdxxkS8B5RkUqDuOpMimYTWl6oCWjjwQUOHtykqk5LWO2l1bU7EyoKVm/kGzcXRf3kvIqaJUaXT+Wn4p84Liw==
X-Gm-Message-State: AOJu0Yz8UvM7AcAuy2u+Tg5FKZiF0VMXFoEDHolve3Tu3mjq5SuXv+Uf
	QfrnM8X+uwc3m4uNYx+DW/F2+wHhDbT2Y8mHoAP2uobIKbUCX2We
X-Google-Smtp-Source: AGHT+IF0Clu7RK4ucCAEU/naKfWxRCfok8IEwF6MNnG+Ktajd2eXm/hayWmXHEvuyzqClFcCcgWCdQ==
X-Received: by 2002:a05:6000:90:b0:354:df59:c9a4 with SMTP id ffacd0b85a97d-35e0f259bacmr7192816f8f.9.1717450579951;
        Mon, 03 Jun 2024 14:36:19 -0700 (PDT)
Received: from [172.27.34.192] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0f1fsm9882380f8f.15.2024.06.03.14.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 14:36:19 -0700 (PDT)
Message-ID: <eedb6e7e-bd99-400d-81d9-6f72e6009acb@gmail.com>
Date: Tue, 4 Jun 2024 00:36:16 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v3 2/2] net/mlx5e: Add per queue netdev-genl stats
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, nalramli@fastly.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240529031628.324117-3-jdamato@fastly.com>
 <5b3a0f6a-5a03-45d7-ab10-1f1ba25504d3@gmail.com>
 <ZlzGjXxVD-JClqIy@LQ3V64L9R2>
 <eda43490-8d77-4d7d-9b24-1aafd073d760@gmail.com>
 <Zl4X82y3ecR2Mnye@LQ3V64L9R2>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <Zl4X82y3ecR2Mnye@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2024 22:22, Joe Damato wrote:
> On Mon, Jun 03, 2024 at 02:11:14PM +0300, Tariq Toukan wrote:
>>

...

>>
>> I still don't really like this design, so I gave some more thought on
>> this...
>>
>> I think we should come up with a new mapping array under priv, that maps i
>> (from real_num_tx_queues) to the matching sq_stats struct.
>> This array would be maintained in the channels open/close functions,
>> similarly to priv->txq2sq.
>>
>> Then, we would not calculate the mapping per call, but just get the proper
>> pointer from the array. This eases the handling of htb and ptp queues, which
>> were missed in your txq_ix_to_chtc_ix().
> 
> Maybe I am just getting way off track here, but I noticed this in
> drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c in
> set_pflag_tx_port_ts:
> 
>    if (!err)
>      priv->tx_ptp_opened = true;
> 
> but what if enable is false, meaning the user is disabling ptp via
> ethtool?
> 

This bool field under priv acts as a flag, means: ptp was ever opened.
It's the same idea as max_opened_tc, but with boolean instead of numeric.

> In that case, shouldn't this be:
> 
>    if (!err)
>      priv->tx_ptp_opened = enabled;
> 
> Because it seems like the user could pass 0 to disable ptp, and with
> the current code then trigger mlx5e_close_channels which would call
> mlx5e_ptp_close, but priv->tx_ptp_opened might still be true even
> though ptp has been closed. Just a guess as I really don't know much
> about this code at all, but it seems that the MLX5E_PFLAG_TX_PORT_TS
> will be set in set_pflag_tx_port_ts based on enable, which then
> affects how mlx5e_open_channels behaves.
> 
> Likewise in mlx5e_ptp_close_queues, maybe
> rx_ptp_opened and tx_ptp_opened should be set to false there?
> 
> It seems like the user could get the driver into an inconsistent
> state by enabling then disabling ptp, but maybe I'm just reading
> this all wrong.
> 
> Is that a bug? If so, I can submit:
> 
> 1. ethtool tx_ptp_opened = false
> 2. rx_ptp_opened = tx_ptp_opened = false in mlx5e_ptp_close_queues
> 
> to net as a Fixes ?
> 
> I am asking about this from the perspective of stats, because in the
> qos stuff, the txq2sq_stats mapping is created or removed (set to
> NULL) in mlx5e_activate_qos_sq and mlx5e_deactivate_qos_sq /
> mlx5e_qos_deactivate_queues, respectively.
> 
> This means that priv->txq2sq_stats could be a valid sq_stats or
> invalid for deactivated TCs and qos. It seems like ptp should work
> the same way, but I have no idea.
> 
> If ptp did work the same way, then in base the code would check if
> ptp was disabled and obtain the stats from it, if there are any from
> it being previously enabled.
> 
> That seems like more consistent behavior, but sorry if
> I'm totally off on all of this.
> 

