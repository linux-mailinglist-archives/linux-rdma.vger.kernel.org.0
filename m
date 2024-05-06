Return-Path: <linux-rdma+bounces-2288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE8E8BC986
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 10:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294AB1F21E78
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708E11411F8;
	Mon,  6 May 2024 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyeGQgnM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB41411C8;
	Mon,  6 May 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983966; cv=none; b=HvhLnn/6iPX9KBXCXdpeJKMS0tXSMRTRlfkB+EZqviZE47lGxS2Kv+DKiW0iyCBAVUf5UUu4FLx14+fvWRJE5CYo0mr+MkVvdkH7/yCELdB2E0CmFuRBwvlb66Mt7FMjB6yajfmcSmYaZe3AcxYooxpzBS0UwQGTEHIuO9s/HgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983966; c=relaxed/simple;
	bh=7+eDm5TeUm1AP6UiGE9zKjcJXu2JlpVyW5y6tdKRRyk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=seGuhbXCLY3urFi+cN5im2qbCwiXeoekH0gfqPHzStSOqGkmp6cmIjypQoNVU3jVuG+RrmL+D6yecxiugGz+6QRUrYHySIicWoKo/EMsZiXS8FrlsYkYm9DEBQt3pjPE1gSV5ifxneFeoFUbqb7zLn1c6wkwhcwAyWXJcmkdwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyeGQgnM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b7a26326eso11617335e9.3;
        Mon, 06 May 2024 01:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714983963; x=1715588763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+60zAT7F46IrP7vFuTziIV1AaHIR2IlJuib9TgQr3Q=;
        b=TyeGQgnMd3Lm0CNaCNZtY2dorVG3LglI20Q9rvwnuUKhN4a0VK7b1oKG5FKuJRQ9kG
         UplgfMHqAH3dj/RL9Ov1iSWyY4ePgzkPrlvwIcfVG49trwGqggo0lnP1A74fJ01veovw
         x1q2b7IexBdM94tpFWWFeHHYtpW8mINr+ploKbG+w79BUONpHhLZcbPgRL38aDgxKN/N
         M1poE0vIAVOXXT3aXP124de2qajUBT9ca3+xssQwwr6hNsZO2Rv19c+Ec8F8CPnp3hER
         u+fZP913Xdio22n3rDe6KZyVmQGBLeC8TcHdKBQZOr+Ckd4xapYcGCz0f5HxX6T6w9rx
         9XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714983963; x=1715588763;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+60zAT7F46IrP7vFuTziIV1AaHIR2IlJuib9TgQr3Q=;
        b=uFdrqtupSiTWrygjr0op6UsuiQ0oYlpZyMde830TyZZDt0at9EwmifZgQ/rsn058oR
         ErXJa8Jv4G1+NY8hAHj2iK9AapvaZMqWf412tMEOzA1kYERPJ0uZ+BKwviyslVndHFs7
         xBVzoTfod8By/gRFuAiXwajB663HkiG832BBG4elbo5tLmLURUNkqK3AX5TGNfpFkD7b
         hYd3GY8sgJjhLn8Mc7KtaqGqo6oSg6ZrL2cN2r0bzfHMLPRl9wy0FcO6eEQNhXcch87I
         QIlrAL6Z0jR1ZDBpJEN1fcjH3cv/jq6Jh7kgbQq5EM19QPFrttPsl0R1MzvmSPyRAWLW
         ec2w==
X-Forwarded-Encrypted: i=1; AJvYcCXWUXhw4Q+PW+TEC76dEQ8LkR5n+zKptxuzNq7yF5CcZaoiZUFRYiFGjnq9LLP164/16Wr7pBt4dc2Lr/IapURVTQh5ibRzKjnOTA==
X-Gm-Message-State: AOJu0YwWuZ+L4kRSyfqHCEaWmvqGAN1/Q4R+/mb9d85y9amzoGKihyOI
	5FhuxD479uhUhDKGrCSxr45ozTXdXvboTzlkRMc8b/BOeatgt8PZvdGh5pqa
X-Google-Smtp-Source: AGHT+IHO9M0y7K4W0qJmoVM+1kKrJqZuzDRMIP69jZu+QiiYgUgpsq4TODJygwVfqrvPN7flYphRGg==
X-Received: by 2002:a05:600c:4e16:b0:41a:6229:396b with SMTP id b22-20020a05600c4e1600b0041a6229396bmr7441454wmq.10.1714983962708;
        Mon, 06 May 2024 01:26:02 -0700 (PDT)
Received: from [10.16.155.254] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c1d8c00b0041bcb898984sm15239524wms.31.2024.05.06.01.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 01:26:02 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <7b0e61e1-8d50-4431-bd0a-6398c618a609@linux.dev>
Date: Mon, 6 May 2024 10:26:01 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [question] when bonding with CX5 network card that support ROCE
To: shaozhengchao <shaozhengchao@huawei.com>, saeedm@nvidia.com,
 tariqt@nvidia.com, borisp@nvidia.com, shayd@nvidia.com, msanalla@nvidia.com,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, weizhang@nvidia.com,
 kliteyn@nvidia.com, erezsh@nvidia.com, igozlan@nvidia.com
Cc: netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org
References: <756aaf3c-5a15-8d18-89d4-ea7380cf845d@huawei.com>
Content-Language: en-US
In-Reply-To: <756aaf3c-5a15-8d18-89d4-ea7380cf845d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.05.24 06:46, shaozhengchao wrote:
> 
> When using the 5.10 kernel, I can find two IB devices using the 
> ibv_devinfo command.
> ----------------------------------
> [root@localhost ~]# lspci
> 91:00.0 Ethernet controller: Mellanox Technologies MT27800 Family 
> [ConnectX-5]
> 91:00.1 Ethernet controller: Mellanox Technologies MT27800 Family
> ----------------------------------
> [root@localhost ~]# ibv_devinfo
> hca_id: mlx5_0
>          transport:                      InfiniBand (0)
>          fw_ver:                         16.31.1014
>          node_guid:                      f41d:6b03:006f:4743
>          sys_image_guid:                 f41d:6b03:006f:4743
>          vendor_id:                      0x02c9
>          vendor_part_id:                 4119
>          hw_ver:                         0x0
>          board_id:                       HUA0000000004
>          phys_port_cnt:                  1
>                  port:   1
>                          state:                  PORT_ACTIVE (4)
>                          max_mtu:                4096 (5)
>                          active_mtu:             1024 (3)
>                          sm_lid:                 0
>                          port_lid:               0
>                          port_lmc:               0x00
>                          link_layer:             Ethernet
> 
> hca_id: mlx5_1
>          transport:                      InfiniBand (0)
>          fw_ver:                         16.31.1014
>          node_guid:                      f41d:6b03:006f:4744
>          sys_image_guid:                 f41d:6b03:006f:4743
>          vendor_id:                      0x02c9
>          vendor_part_id:                 4119
>          hw_ver:                         0x0
>          board_id:                       HUA0000000004
>          phys_port_cnt:                  1
>                  port:   1
>                          state:                  PORT_ACTIVE (4)
>                          max_mtu:                4096 (5)
>                          active_mtu:             1024 (3)
>                          sm_lid:                 0
>                          port_lid:               0
>                          port_lmc:               0x00
>                          link_layer:             Ethernet
> ----------------------------------
> But after the two network ports are bonded, only one IB device is
> available, and only PF0 can be used.
> [root@localhost shaozhengchao]# ibv_devinfo
> hca_id: mlx5_bond_0
>          transport:                      InfiniBand (0)
>          fw_ver:                         16.31.1014
>          node_guid:                      f41d:6b03:006f:4743
>          sys_image_guid:                 f41d:6b03:006f:4743
>          vendor_id:                      0x02c9
>          vendor_part_id:                 4119
>          hw_ver:                         0x0
>          board_id:                       HUA0000000004
>          phys_port_cnt:                  1
>                  port:   1
>                          state:                  PORT_ACTIVE (4)
>                          max_mtu:                4096 (5)
>                          active_mtu:             1024 (3)
>                          sm_lid:                 0
>                          port_lid:               0
>                          port_lmc:               0x00
>                          link_layer:             Ethernet
> 
> The current Linux mainline driver is the same.
> 
> I found the comment ("If bonded, we do not add an IB device for PF1.")
> in the mlx5_lag_intf_add function of the 5.10 branch driver code.

Not sure if rdma lag is enabled for this or not. /proc/net/bonding will 
provide more more details normally.

Zhu Yanjun

> This indicates that wthe the same NIC is used, only PF0 support bonding?
> Are there any other constraints, when enable bonding with CX5?
> 
> Thank you
> Zhengchao Shao


