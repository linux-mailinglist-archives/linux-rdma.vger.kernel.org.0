Return-Path: <linux-rdma+bounces-13311-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4417B54ACB
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 13:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A293BC6C9
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12913009FA;
	Fri, 12 Sep 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mwmWvLNi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E43009E3
	for <linux-rdma@vger.kernel.org>; Fri, 12 Sep 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675715; cv=none; b=YLBiTr5PjbkbqXu6sFErd9/PM9XTCOWK7eY/NN6r/t8X0SFf5q13Q17ZLQBTgfyMhfkzwg5Yp1bvVFNREfnTKilLeortL1xloq5cE6HLx1sq5mFEloOp4WyIF1fJa5VKdbRpc4jxz2bZ5LfNqF4LWr6KexZTS6VZeCe7HufmzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675715; c=relaxed/simple;
	bh=e5L+tVWzscZr4jLHDRbnNlvC5wSer04cc3J4F0Re2yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFnPEUF7ZJ85g7XSLB4BPnxGNlM0SUKLKHxVO9+iolLOFIzptQe8zUpOz0b+d20nFHsGsfS8kVR8xLgK4DS8vomTjSmqRwqV5vmJdDN6OibWXUR/TlG17fC5m5C7VY/RK9/g+2hHdR+lQRf5YaXK6e07c3VkK/SpkWLXwIp0nZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mwmWvLNi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-560888dc903so2042948e87.2
        for <linux-rdma@vger.kernel.org>; Fri, 12 Sep 2025 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757675711; x=1758280511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y79xIpnC424FlOC64ZAsCAV+HYrgKwpFVZghrIQKO/0=;
        b=mwmWvLNiXML6exy4SRXlTldwGg6pMxhlr2TDF/7r2m8nA1D5kLFX2CLPLNmcVh60OI
         ucX3z7bq1gtD8cUHmFrkIL+HugwnqzuTCzdrZuGz3DY8pcQBtDIr9ICTVxIJvsiBzIOt
         KBmjJWxNuXi/c75xo5pqh2SEtQlmUlmNM2GzbbaIBSyBq9ttp5aZYOgu07pu5JzBsPwe
         4akkqM2jiK8Zxp7eROQ09tSc2SNqLn2lqdqn+UHrMoBEi/EvveY78lK33EascoHarWRQ
         zYi/35xeuoYzX2FTi98CcXYbwh+3TROE3VWxymt1ivvcfdP9E2pXN09smovEYPVrJt23
         Ossg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757675711; x=1758280511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y79xIpnC424FlOC64ZAsCAV+HYrgKwpFVZghrIQKO/0=;
        b=ga3pX1Z3VgEdam4ibe9UfACCXV97sttpekZzFO0GA78KiHx/oiW7PVZiWehjKPjJjx
         StCAaxoiOXv7euI/oZcGGpwx7XSX5yRLqdDAK5td8Hkz3G5dkZSJzzafEHLUaJW0xy9g
         J9YhZvJhUVXj/iei6BFSbJMxAD/f3W47dmj7qgBC9ijFSrGnbMyGqip9yp5MrBpqkOuS
         T0NGbfQtNIip8mVVSBrltP+zKXKHGvZKzCi3viVbx3tWF/igZko3UVaM6i80zF0zpyUt
         s9i/23789rxhbUc5z2r51+zgZ2lg0aBvCN653/SaswgZ6UEUehD/XPbjJxqSQjFK//O8
         kgBg==
X-Forwarded-Encrypted: i=1; AJvYcCX20ER26vX0Pw/Dq0GVMvi43O+vkUx95VXjWuTogChl1jlVuYN1kXzc+hkkfhEKyvTIME65ZNYmaQUI@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZ63BPLH2RuuY407hwmIlb7gXhQKGiFYHwMT/titoqFVMRA2Z
	Ubb0rfIlqHKIPpFXiRFSUIR+gXzLOkqHfWy+ADwaE+x2ogORT14MyVVkTXbB9ONCYBI=
X-Gm-Gg: ASbGncvxlckiATRNp5JLTC0IYfMgz09jfVvgqT5Elivn/RuR74u/8Bu9XT/POVT8Uoh
	voFSjkVxN56uRhHlX2V3CcPPTcmncVj1xRf0Hg/f67yH/10vgK6Ww8Q8z7nZWyuscKQSnsurr56
	kjtDoFcTUUIq38fxejeogPkoMK89zhIdl0M0dK3ZRksB8ebSFNkoI67v/VnLZ5qegeKujmRx7Mq
	i0xLcDEOr1L/qK9Ff2AaKiuTcmbBXvWTUA2SJkiRNv728QNStQld+z5SBmOx7Ydws74K4crVnkz
	0WxmTQfwKbuH3jILPjFwFwZG5gXSt0pxoiZoSmMRmMsJToUGExf06kqq0+jkrUwpZi4rCkgLFkd
	G3q0q+tYg1/IQc7Q02ND1/xkfkbGZMOZxu4qm12MFJwSixmpTgY8I3hPmEDuaS4ot3f/Tf7bO85
	4Pzg==
X-Google-Smtp-Source: AGHT+IEX8lJuZL1YVpyfdl9mCWUkwiQ29IuRWpeUaJuKHQ4wANXuzKH9Gz1hogCk60GadYXtZCSGpA==
X-Received: by 2002:ac2:4e99:0:b0:55f:65f2:8740 with SMTP id 2adb3069b0e04-5704e34edd5mr666546e87.42.1757675711175;
        Fri, 12 Sep 2025 04:15:11 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460f138sm1063220e87.111.2025.09.12.04.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:15:10 -0700 (PDT)
Message-ID: <4daaaa7e-7a02-4e4c-be3e-c390d7f6e612@blackwall.org>
Date: Fri, 12 Sep 2025 14:15:06 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net 1/1] net/bonding: add 0 to the range of
 arp_missed_max
To: Pradyumn Rahar <pradyumn.rahar@oracle.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Cc: anand.a.khoje@oracle.com, rama.nichanamatlu@oracle.com,
 manjunath.b.patil@oracle.com, rajesh.sivaramasubramaniom@oracle.com
References: <20250912091635.3577586-1-pradyumn.rahar@oracle.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250912091635.3577586-1-pradyumn.rahar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 12:16, Pradyumn Rahar wrote:
> NetworkManager uses 0 to indicate that the option `arp_missed_max`
> is in unset state as this option is not compatible with 802.3AD,
> balance-tlb and balance-alb modes.
> 
> This causes kernel to report errors like this:
> 
> kernel: backend0: option arp_missed_max: invalid value (0)
> kernel: backend0: option arp_missed_max: allowed values 1 - 255
> NetworkManager[1766]: <error> [1757489103.9525] platform-linux: sysctl: failed to set 'bonding/arp_missed_max' to '0': (22) Invalid argument
> NetworkManager[1766]: <warn>  [1757489103.9525] device (backend0): failed to set bonding attribute 'arp_missed_max' to '0'
> 
> when NetworkManager tries to set this value to 0
> 
> Signed-off-by: Pradyumn Rahar <pradyumn.rahar@oracle.com>
> ---
>   drivers/net/bonding/bond_options.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 3b6f815c55ff..243fde3caecd 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -230,7 +230,7 @@ static const struct bond_opt_value bond_ad_user_port_key_tbl[] = {
>   };
>   
>   static const struct bond_opt_value bond_missed_max_tbl[] = {
> -	{ "minval",	1,	BOND_VALFLAG_MIN},
> +	{ "minval",	0,	BOND_VALFLAG_MIN},
>   	{ "maxval",	255,	BOND_VALFLAG_MAX},
>   	{ "default",	2,	BOND_VALFLAG_DEFAULT},
>   	{ NULL,		-1,	0},

This sounds like a problem in NetworkManager, why not fix it?
The kernel code is correct and there are many other options which don't make sense in these
modes, we're not going to add new states to them just to accommodate broken user-space code.

The option's definition clearly states:
                .unsuppmodes = BIT(BOND_MODE_8023AD) | BIT(BOND_MODE_TLB) |
                                BIT(BOND_MODE_ALB)

Cheers,
  Nik

