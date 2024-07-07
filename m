Return-Path: <linux-rdma+bounces-3696-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8447F9298E2
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 18:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325321F214F2
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF23A8D8;
	Sun,  7 Jul 2024 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqQi8hYq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B21DDCE
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720370331; cv=none; b=S6X8QF69eLpctfqZ0IGJhjt765xMJTpKXkcTim6xjWLSAXY4JJH7j4sf8mlpNasMvCBYCeee0cec0VlsAgxu90yIe5qIvWjf0alzMI3DNTWQRZQCQ6zPB0zaoNX1wlBBGZHTm+Bp/PskT3v1KfpjhCblovSgYStzEZPkDD/PH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720370331; c=relaxed/simple;
	bh=8i6p8Gs40zH7SuHTbPfpgh/uEMha32VXmRpOf1OrbOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czgrJktPm5AKT9OMGTeD5cJPX1prZDqLtliLCjWb0jH7Csh3mXEX8u+BpgCTbouLsS0xbBeG4am0Ch51sv616YjnDoQp575dxczw/Ck9ERrP1q6ieeoYUinatww90G5M5EHkOuPCZa3/98ndSM2xBk9Jex2GaCy/78JbqIBsrmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqQi8hYq; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7fb51934e59so9911039f.1
        for <linux-rdma@vger.kernel.org>; Sun, 07 Jul 2024 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720370329; x=1720975129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKb5M8RBFKYLABFniAHbNV3KWEL0bcEvw8jCBYX7YFw=;
        b=dqQi8hYq8Vcb3tpncDrBMJWYxNyH8Qx0iCCX+0SBAXYGaSn4hgAU5wggDSIbCyU0ZP
         CqhOGlmUlik4AsKs0MUuuRB4TDA+7Zf8NhUmIJBG1fgm6H8vIyAE3ljul4QtH7OpxXi0
         SRZsNkX2XYiT6YiOXW49Eqa4v3gReJ6jJRzVtO9nDPCYFvF86X+Fq0iynRt8NBg4Klr9
         LwvqDW4X+2GUc/3ATwtbZezfvLX4iowH31sHar9GZn0RyB2pkc4xnnhhbhX8EYpbVAJG
         v8GJmlQUc9HAOsi9PfmScRvDFX/JvI2ZnoYRbZ7aVWkA6c4mtu5ggf5hT8+rwXuJvMw7
         TEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720370329; x=1720975129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKb5M8RBFKYLABFniAHbNV3KWEL0bcEvw8jCBYX7YFw=;
        b=C6Fx/JTfXrPwMmAZ4g/G9Wgsj/qaxl5Ghqe/McI4q3f2f9gtXyjZxJqE+maUM95xjt
         bAGRpSorEuK9QIFcZ3m2n9VZLBdnGIkdjxZFJi0jCpoeEHOpU6AtDHI+35xocf5VcLm9
         t9JhG8VbE61BmlXSGxQwwZzRl0s8Wq+OGNPNNr8s6omUC2n9Fv8Xb77Xc5X+fb8yF72q
         FIpgl/nYNthMRxh4Jj3teNd0kfumvtiTSp8UaP7rXXV+MtG1b8ZDlEJeIk6fhx/wu4kn
         DPnNMpOndBLYGXh66YSeLQNqLo4SYulMAizOTbEeeBpjffG6K1KSox8EM0W2HWwwt8MX
         ZYlg==
X-Forwarded-Encrypted: i=1; AJvYcCUdhxycn+ZlLqccZUZbCNNP9Y3GsOlTuKZHoBwvT7Q56Q7uWGbHg4taz2Z15F5WU7JYfF1j28w4RndlrfTE9k+6lWgTr7qLTM/Bew==
X-Gm-Message-State: AOJu0YyjvFeQQxe3ECFvLUcNT/9iKCHdrmU0sEQySDqnc4LTrnfipznI
	WMCwYL77fQ3R1P34q21ebncgdaq+dyShXTej3RKbK5aP62iSHQmAYZcY3XH3
X-Google-Smtp-Source: AGHT+IFtKVjlzOD/VZ3oHNa9psKtqGK3bgw7wxKmEfE4E8Gve4j4OSyEm+MwOX7ZbcF2OnQuh/MfdA==
X-Received: by 2002:a05:6602:4249:b0:7f6:1590:44a2 with SMTP id ca18e2360f4ac-7f66f99935dmr606652439f.3.1720370328895;
        Sun, 07 Jul 2024 09:38:48 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:8da3:78f8:d573:7ac? ([2601:282:1e02:1040:8da3:78f8:d573:7ac])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f8c15f2e24sm118425739f.25.2024.07.07.09.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 09:38:48 -0700 (PDT)
Message-ID: <d0ea373e-977d-41df-b5c6-34ab8b2dd865@gmail.com>
Date: Sun, 7 Jul 2024 10:38:47 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND iproute2-next 0/2] Supports to add/delete IB devices
 with type SMI
Content-Language: en-US
To: Mark Zhang <markzhang@nvidia.com>, leonro@nvidia.com
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org
References: <20240704062901.1906597-1-markzhang@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240704062901.1906597-1-markzhang@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/24 12:28 AM, Mark Zhang wrote:
> This series supports to add/delete an IB device with type SMI. This is
> complimentary to the kernel patches that support to IB sub device
> and mlx5 implementation.
> 
> https://lore.kernel.org/all/cover.1718553901.git.leon@kernel.org/
> 
> Thanks
> 
> Mark Zhang (2):
>   rdma: update uapi header
>   rdma: Supports to add/delete a device with type SMI
> 
>  man/man8/rdma-dev.8                   |  40 +++++++++
>  rdma/dev.c                            | 120 ++++++++++++++++++++++++++
>  rdma/include/uapi/rdma/rdma_netlink.h |  13 +++
>  rdma/rdma.h                           |   2 +
>  rdma/utils.c                          |   2 +
>  5 files changed, 177 insertions(+)
> 

applied to iproute2-next

