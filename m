Return-Path: <linux-rdma+bounces-5881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C088A9C2ECF
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Nov 2024 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F7A1C20BED
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Nov 2024 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7B19ABB7;
	Sat,  9 Nov 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMpITeGs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E272556E;
	Sat,  9 Nov 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731173699; cv=none; b=V915u1cz4vYPPvqe16uNxCf6hZ5TxqOGl4b0wOyZ7L9a0c5Z0ChgHthgbBhYzwsLUdF0F6d9BXHU90so052bQ1kdzj0xuwux+LHxrUUzt7CfmRyWhUK32pCpavrK7txXdGba4VEejK4xLXA9vFrcOAva7MB3+Q7U24f13O7E/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731173699; c=relaxed/simple;
	bh=qFTm8Za3QWAObXa4rILHgS4yDzakJhp87oTUZ0iNcro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjU8JGZYhY7asPmQJFONePzgcjcJqvSc4wBTDZhyNhQT7/ByIEpYOfKmRJM/bJPBiA7PMtqWSGtPfdW4hEHR9Ojy6fUeQ3bmNV6qgcKvWUDEcUd6jvdC2l2Tawg8AJchf2J+U1I2NVE+ZedZP6+bD9HwsJ/dq6g1TM/NZSLgheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMpITeGs; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83ac817aac3so128708339f.0;
        Sat, 09 Nov 2024 09:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731173697; x=1731778497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4ULSEJCIEw/7KxTQb7YcDIbWQxKgP6eRQCQeyfFeIs=;
        b=YMpITeGsbOlWsI3fSqL3v6nqubHbUZKZy5l+GFWKuAQrRITwyGvxwuvb1JWMBdWXvP
         pKpprg2PWShUVIIOeV/l+LzGtWtwP0VJfMuymrafRbwNT56hMwkgd5WZ6n0cqW4SxLK6
         ARoYS0vUPF7C83K2rEQPIoQ1vqW9/Yh4ceElcsOwFBLUMsVHpUCFGsKtl36GXWLjRDun
         hbEfzPDxtXJ51NTA8Xw9M3I8dTcADb7WNck9pMsw+MyZEYPzb9FlBlgCg9pIHdgmd95H
         zubLeF0z0v4/vpiGa1kGvCl9sroCP4aqfZLOQ6Bi+xinkKpJ7JtrbDDjhYfUUkwLJS+F
         PmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731173697; x=1731778497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4ULSEJCIEw/7KxTQb7YcDIbWQxKgP6eRQCQeyfFeIs=;
        b=Exv5jGu3MaDDihsBzHtA2JCRc5/eqtbYcstEPDlDQFY1Vc8IGGd9a+Axo5PWpzZehH
         3sfsF7tbJD+0iKE9Ku7w+o0tcdNf6KiMy4svg46+XXM1bqFkQPqS6JiXO0CaUXvMUU65
         Z2H68hTdA7gMR9Z4UTtRGAWOGNFvMkyI8MXYyoOJNVG7ZzD2q60bK/mrxnq/kk+JZzsr
         u/tEuUYI9edSZYwp9FanW67td3dQ0JKwwi9fG+6586UHOPIm1/caKzoLyhjr7V/VcM3K
         cYpBzSnNlR/gVGkOcK/A8G/fR8FFJfXgEPzOZFakZEHobc9nmZxmR/SWbvcIMBj46loK
         pztQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0pnGlIcyiiVzvTxf1SIYn6EpNHuiLZoWb4Ryg7gNTWwbxlGZMOfUAspFUI5LKpKyIA7fUuuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUVBgJY5pzwmoi6IFTGKu5V1riE8BGdI9efHJdzZoNPlMFhWD
	nO6VeYKfFhoQaK4CoREM9mU69lPPbQP8+y7AIDr/QcpN75laFc2H
X-Google-Smtp-Source: AGHT+IFySXMafLzViu1XHdD7Em5OrKJJrNxOBVBY715SKFtJ0m8vUZG5IiJ50Ae7fLUyPy5sVVQrNA==
X-Received: by 2002:a05:6602:13c8:b0:83a:f447:f0b9 with SMTP id ca18e2360f4ac-83e032fa188mr839414739f.9.1731173697495;
        Sat, 09 Nov 2024 09:34:57 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:54c3:8c58:2087:8094? ([2601:282:1e02:1040:54c3:8c58:2087:8094])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4de7871553csm427008173.19.2024.11.09.09.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 09:34:56 -0800 (PST)
Message-ID: <d40cc960-f12e-4177-83d5-b573de41ed4c@gmail.com>
Date: Sat, 9 Nov 2024 10:34:55 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next 1/5] rdma: Add support for rdma monitor
To: Chiara Meiohas <cmeioahs@nvidia.com>, leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com,
 stephen@networkplumber.org, Chiara Meiohas <cmeiohas@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>
References: <20241107080248.2028680-1-cmeioahs@nvidia.com>
 <20241107080248.2028680-2-cmeioahs@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20241107080248.2028680-2-cmeioahs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 1:02 AM, Chiara Meiohas wrote:
> diff --git a/rdma/monitor.c b/rdma/monitor.c
> new file mode 100644
> index 00000000..0a2d3053
> --- /dev/null
> +++ b/rdma/monitor.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * monitor.c	RDMA tool
> + * Authors:     Chiara Meiohas <cmeiohas@nvidia.com>
> + */
> +
> +#include "rdma.h"
> +
> +/* Global utils flags */
> +extern int json;

use include utils.h instead

> +
> +static void mon_print_event_type(struct nlattr **tb)
> +{
> +	static const char *const event_types_str[] = {
> +		"[REGISTER]",
> +		"[UNREGISTER]",
> +		"[NETDEV_ATTACH]",
> +		"[NETDEV_DETACH]",
> +	};
> +	enum rdma_nl_notify_event_type etype;
> +	static char unknown_type[32];

why static?

> +
> +	if (!tb[RDMA_NLDEV_ATTR_EVENT_TYPE])
> +		return;
> +
> +	etype = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_EVENT_TYPE]);
> +	if (etype < ARRAY_SIZE(event_types_str)) {
> +		print_string(PRINT_ANY, "event_type", "%s\t",
> +			     event_types_str[etype]);
> +	} else {
> +		snprintf(unknown_type, sizeof(unknown_type), "[UNKNOWN 0x%02x]", etype);

wrap at about 80 columns; in this case etype should go on the next line

