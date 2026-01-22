Return-Path: <linux-rdma+bounces-15880-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IlbCXT+cWkaaQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15880-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 11:39:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9777F655E0
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 11:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D7C286A9EA
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06938B7DB;
	Thu, 22 Jan 2026 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwJ03Hjo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED39318EFA
	for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077631; cv=none; b=iWMZN3Q0UkS/MWrZhQcXbpm4qwnzturNm7z/aAJDWNJKU7i1ibyx57GBr2qyWbIJ3rED1XN5rxQNdFYPwGSu3TWfoeUTN5ieFq07i50dCYV4spTZWvP8IjJUMagLJqNEQuMJwNaracG247JioRlr3q/eue07+zTRYvzqOZndjiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077631; c=relaxed/simple;
	bh=tg/IkCOS31JEAFn9hXteDNcfnMrrp5E8OzmuJ6Fv1ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/VmcTksp2RRu6VTu+7DqDEVh+Lp8GPtk5MN7v4KgMJw5lb+Ps/9rOhozs/0PGYSBD+Tkl90SDchmDgvv/xGF9MU/b7L9v17KPgXfq1cWu0eVoCshsC+6DZ2dwI+YSHuOIfKNd3WsJMrF3JxKMyT5DoVt8hzABhvWU8DIUFKPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwJ03Hjo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432d2670932so725476f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jan 2026 02:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769077628; x=1769682428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ls0I+qbyQNmKr9L7fTc+L/4yBpF7MV4e3ITS1qwBIFs=;
        b=HwJ03Hjo+RmbhWRY1+FoU3ZTzQwtvJFfgJVZlU6XJy5IEd4m9LbRfO0bRQPePuz2E9
         +RuDJz65lw5ggL6YXnQRe/AJWpssSo3ajuhVin6IXVXBaA+wxuOXD6+Z4m64Hm39crDG
         ifJSmqdr08DWL+WSy7+KLaiCEfmZgJJ1wZh2VDfvPh6rCJD4LQSMbYNFojdzGSliR5YG
         8nyQkQmXdWqeJ3IDPkOEQ6tN/yut21PXHbyXukWZJgJH3MSomJTjAhX+D3CfgXuAgmim
         E1acloDGkE7lWDgf4Yfx598T8gI8TTYRLSyQPE/MMRa9N4LrdsdkwcyHh48lF23claom
         Cz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769077628; x=1769682428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ls0I+qbyQNmKr9L7fTc+L/4yBpF7MV4e3ITS1qwBIFs=;
        b=pVLbdwD60DIGtxjHox84PTZL2IgMA72PLURRzsFlV7dhmTBzLcrhG4y5T7mQwOeQsT
         0XoSasTZBrLl9wnw+eXKGZyZ5tUI5EgLD2C+d3wMVTx+Nd5ReKNq95nQeE2RMIK8NoB4
         O0VCgS9EaNcUTTzR9iNMjFdx/IzS5UwudfXSRc4rmSvmCu6pJw806cvF9KR8g3J8q7sw
         9dVJWsVU0RVryM7iPp9+qGjZ1+4OftlrvVSRUQfSVQkk8v70aLztbGh9dg+sIRhgUEfD
         CRHtvQMObnDzEwpx9RuPJsF6+yqLBMk1kDYWj/nHA4McMz3VeW5QuFGC6VhDRisHsqzR
         603Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzKHkQ0TO3UWsyduhdkmVpxSAMt1HjL2Jv3YZ69roCMAqViGynNWIkIajquXsgCc004qx+fF/aWgiV@vger.kernel.org
X-Gm-Message-State: AOJu0YynlVZ1s+gMPCzhtWv5TbsRknxa6+s45j7OYTkeaCi0Mw17T2VG
	Qtg6hc8gavWWt3/I3uGOojhARkdY8PcMih7/qpSuKXuxG249nMY0V1uf
X-Gm-Gg: AZuq6aJgkR7DHVEbImsSIQqnKGtdnP6Go5/Gj+o2dgv1kEgvKFTNM9Q/zN3bL9Zut9+
	rzliYjG2tzLChbBCkyxGoy/St/6fQICBeUbgDV7dOkat1AsoZATqGMmbacMQssYdXKOlYqWGbmi
	X/fSsF1S57HR9+jDGa64jPm8OI7Db08TL1OOevDGWp44155VRIt+Obtv44nx5q7mTKLBjz677rj
	nqYNjQQxpM8Ry6Y5zYKYomEQ4jz9sV16A5F0fFqukH0M/2hIaOUfKS/fWEcHlnxqzb1BNP7gBbP
	59/oLT41ESNcP8JfaJsY/EwbO+g4Srup0Z3PiudKRj72/mDaFWFeqk8DAikzSD2RJNRA7HMXsww
	u0avMWZfgsGTPIP/t3F8Nkqk2zOjvV4B7usQz+8I3Kv9w0MxXiBogz+94L9zAyCu58mtbToDMS+
	gSxa7eYbmHQ8E2RPBESxM+TgHiqQy1jdMs5w==
X-Received: by 2002:a05:6000:1888:b0:435:982d:97ee with SMTP id ffacd0b85a97d-435982d99dcmr11152658f8f.57.1769077627762;
        Thu, 22 Jan 2026 02:27:07 -0800 (PST)
Received: from [10.221.200.32] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb1fsm43860796f8f.35.2026.01.22.02.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 02:27:07 -0800 (PST)
Message-ID: <6a055080-e4f1-4a1d-98ba-dca81a26b3a0@gmail.com>
Date: Thu, 22 Jan 2026 12:27:08 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fix memory leak in
 esw_acl_ingress_lgcy_setup()
To: Zilin Guan <zilin@seu.edu.cn>, saeedm@nvidia.com
Cc: leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
References: <20260120134640.2717808-1-zilin@seu.edu.cn>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260120134640.2717808-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-15880-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 9777F655E0
X-Rspamd-Action: no action



On 20/01/2026 15:46, Zilin Guan wrote:
> In esw_acl_ingress_lgcy_setup(), if esw_acl_table_create() fails,
> the function returns directly without releasing the previously
> created counter, leading to a memory leak.
> 
> Fix this by jumping to the out label instead of returning directly,
> which aligns with the error handling logic of other paths in this
> function.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
> 
> Fixes: 07bab9502641 ("net/mlx5: E-Switch, Refactor eswitch ingress acl codes")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
> index 1c37098e09ea..49a637829c59 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
> @@ -188,7 +188,7 @@ int esw_acl_ingress_lgcy_setup(struct mlx5_eswitch *esw,
>   		if (IS_ERR(vport->ingress.acl)) {
>   			err = PTR_ERR(vport->ingress.acl);
>   			vport->ingress.acl = NULL;
> -			return err;
> +			goto out;
>   		}
>   
>   		err = esw_acl_ingress_lgcy_groups_create(esw, vport);

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patch.
Tariq

