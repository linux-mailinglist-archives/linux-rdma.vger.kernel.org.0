Return-Path: <linux-rdma+bounces-21696-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SmD9OWVhIGpD2QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21696-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 19:16:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ACC63A1A2
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 19:16:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=J43NUAr6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21696-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21696-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E6B630683F6
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B22B44D6BD;
	Wed,  3 Jun 2026 17:12:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E5F441031
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 17:12:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506747; cv=none; b=BEVezQWW17oAGfOTRPSnZ67wRV7FYCZ/cRixBRJP35gyzFk+z6Xto/tgmyDCtuTekpppkjuAxe/jT0bMgK8WNxrxDufGZB5t4IBHLdHpZRWsnyl2WcXMIkEoigfbBHdHvgmFuYcQAZ4qS9UEKJ1EF1u1AJ1u9Psiw5xSz0iC/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506747; c=relaxed/simple;
	bh=TN5VN5nZYGpZ0cgk6I+DWPRMt4OBymg3kF+L1ZSTg10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkMI3MCE/QAe/5sMwLmkGmz9OLqwBBZuSw4mYNuTnhIFUTj5cYS/cftcg4UF2rABotdyq2JCLdCOo/5ghr73s4GoCWp5CIxjBPgZbnkde1YSCYabIuCkgch7hZg1xyMoE8zJIPvhCG7GdIiK1IO/EhD93icShuEjTa8gCsDeImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=J43NUAr6; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eec22fab7so3689447f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2026 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780506745; x=1781111545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WShIXeDXg6osn/1BPpnCqqp3TWGu+yv09MQ0gxlHZ/8=;
        b=J43NUAr6UxcD6FhnwU3H5ssro/H+8XGFqQJSoNhiMs3ztDp8Q8P4c0V4dndmvxoB9u
         HGLYWSSg/r/hz7VWdpSLHoZXMi9kTS9DtnC8iKQWzEpjAIUj+BYzxmxi4S7E5BSmqwfn
         rkkklpjH0ZOVxOShxgYaB4k9F71N8npU26s3nDsEymw6CQ+de50yUol829sxw9znEOKC
         tgW2CPTzcTc+wzz9f3pYS+fJ8gXhWlSeVPAGv2b87BtaKX8qFi/1JAVnIrRzksUXckom
         cGdxPwDy3l3pkO/Cv0IoLx3U0SLmT5DwSOr08RKc8RGcbYpX47iCv4rsl1mJ26oum2Oy
         koPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506745; x=1781111545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WShIXeDXg6osn/1BPpnCqqp3TWGu+yv09MQ0gxlHZ/8=;
        b=hIa9hcUk2uASF/oklzvGgg+Mbhp+aorItdxVfA7ov/rwp40/9GyWnpd5s2Cm45sg11
         TFxgz5gsVRH6Ny8D+XDcOmanZSOeQjSj9sr4ofEpHM99XT0IvcoL0JsuwCVygMnqt1z1
         r20PyHJ9W/po6yWvhLb3P8eZsSqddpBAff3yCYjV9wCETCLV6rNr2caVuP+51d9OsmLw
         Ik/vUSr+b8mg5eHei+p2DRZCVBj9wrA2o4BdiDluIpba3I6Ed2L9DhIxqHfC5sCA1soe
         xrPjMPd3fzjykLKET0vWyn94uljMmqxMhcuXoRp4P0A54zmMvF4DjPQg8cMUsoE70pX7
         IFGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/j4hWS++j8xdJVpU8YmSAP5Akwx2CzcxVtFX3rujPnDLkiS9w4Z6zWRThfEo/iRXbVXiImc6ATr4wh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywekh8UlHqqhH+RP5oxXKF8Oq40EYmv6if6vR5s3gguDaSMluwT
	2OXfDNhZT1yyuANetBRPy4VG2LmO/UggpbYUT1+mjl+gQqX9f3FBjZoH8Futdwgb/Z8=
X-Gm-Gg: Acq92OHLwIbK6LyBme0m076HZM3paiMfIxoxD1GpuFsZmt2cWo+GUxuQhMT0ArZuR8/
	FQ5RkOesAexoSqQmFIDU3dDnsbU2MR4J2RvLt5phkK7psYtrRRVSExI8ylaGXumNKyjpvg0DRbg
	69f9GflMjfLOYF6n/tERmSvIglxhJi2ntjm92nzGYG63hplfV/cmLxSST9l6kQP+fWHEzGDR6Qa
	PnD7OV48vYw0iCbiqrrDhQE8F+YivN7JYlmH2BunUpr7VVZZCRAADs+1aV5NS7UTaM1aEG7sLkI
	3HVIiBjOJg5sq2qhjreKFsOoh5ql9Pr/h/be6BmokP/giy4bjDtftzBQJqhGvWbhAD7br/GYdEq
	8kaFJP1OTZlhuwjybYL4TgMx3kDBJ9BOmB0SpEYZXyp3D8AREVUPJ/BH66Gusrr3i7fMhJ3dplk
	uwXZpTakXUIOIucB0vwmhYuWqeyT77G83nuSKzOnwH560oJo1x+dq9V7cCQKSDYt3F
X-Received: by 2002:a5d:5f8c:0:b0:45e:f29d:d42d with SMTP id ffacd0b85a97d-4602181eea2mr6197828f8f.25.1780506744671;
        Wed, 03 Jun 2026 10:12:24 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm8997419f8f.9.2026.06.03.10.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 10:12:24 -0700 (PDT)
Message-ID: <b087dc20-7398-4ad3-9787-efef883d81b1@blackwall.org>
Date: Wed, 3 Jun 2026 20:12:22 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 0/2] devlink: add generic device max_sfs
 parameter
Content-Language: en-US, bg
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Petr Machata <petrm@nvidia.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Amery Hung <ameryhung@gmail.com>
References: <20260603102646.404797-1-tariqt@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603102646.404797-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21696-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:vdumitrescu@nvidia.com,m:daniel.zahka@gmail.com,m:aleksandr.loktionov@intel.com,m:przemyslaw.kitszel@intel.com,m:akiyano@amazon.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:gal@nvidia.com,m:ameryhung@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[razor@blackwall.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,gmail.com,intel.com,amazon.com,marvell.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,blackwall.org:mid,blackwall.org:from_mime,blackwall.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61ACC63A1A2

On 03/06/2026 13:26, Tariq Toukan wrote:
> Hi,
> 
> This series by Nikolay introduces a new generic devlink device
> parameter, max_sfs, to control the number of light-weight NIC
> subfunctions (SFs) that can be created on a device.
> 
> The first patch adds the generic devlink parameter and infrastructure
> support.
> The second patch implements support for the parameter in the mlx5
> driver.
> 
> With this addition, users can enable or disable SF creation directly via
> devlink, without relying on external vendor-specific tools.
> 
> Regards,
> Tariq
> 
>
Need to rebase due to commit d603517771d8 ("devlink: pass param values by 
pointer"). Sorry for the noise.



