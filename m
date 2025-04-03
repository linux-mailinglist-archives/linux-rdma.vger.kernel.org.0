Return-Path: <linux-rdma+bounces-9141-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F86CA7A496
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 16:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C83189B41D
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9F24BC08;
	Thu,  3 Apr 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4LZbYjc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C1134CF;
	Thu,  3 Apr 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688994; cv=none; b=s3Vx6Zmkj5ko77GvVeIZublmr80w19ej8TtPQMaIvgvMT6Ixpkk+ygnaqRujGs3/Cg7/02EKTSmKWZ1sBNDvSgKZmm9zrNIlyQlAUTqfM2u4hWGe28hgru00XOkz/9u17d6ngv5o1e1+E3a063sl1atwlK4WBmpgCuYK1ktETwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688994; c=relaxed/simple;
	bh=QLW4F+GbLFXGMNGtOghcIQjJ+dG5UU8FxWvxshVfG+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzBsneevSb8s+O9oQTXZ7Y/KT8waqNrJSjFiKG80HVvnQxvL6H6/9EHkWc7eFugdCTxgB3uZ4D6upSWAbaNwp7XcfFXhvqEMYLyO5uSrIfPKl94uCOvXHPMppTP+Ml/7245pkqd1CtyTy61FjFwoG0nrd9INHl4cFrACWlnUAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4LZbYjc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf848528aso7034065e9.2;
        Thu, 03 Apr 2025 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743688990; x=1744293790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2b/4SGMPaDzgoq6vXPcXF69oy6ff324UOzskeW/a6I8=;
        b=L4LZbYjc5XHgXlFlb7aFkWQ3+OuXsLAXBc1mU/NThLSjZom4AcXtQnQ+JZfia8MjAH
         FqfkroHE2khqUtT6x7S+ZD5N011o/tBtBGI0/+q5rB3mmS0Ix6yodt5bt0rDpxslArI+
         dRrvSUr4QmsZSIuVyaiJ/UQxF9/Yh4FYXc9/QzdmXKISKbSpzrE5P1BpmnGmwiAMLLxw
         Bu1FzXo8T1briARzM1XYluu8giHkqpSUUS2/3anikV7PG8Yc7qqEDmbC+JoGvzrkNccC
         OgsdPwb5oJkKj4hRUu4bGk/z7gwl45J153USf96J7p0tN8Z/Q+yb2JQoT6N/w60568lj
         pwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743688990; x=1744293790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2b/4SGMPaDzgoq6vXPcXF69oy6ff324UOzskeW/a6I8=;
        b=TpzU9bAw9Ov61Oz1jARGjPnAF+D5AEJEMsGwgm7t5XSoXsBGSkEsDil1T7xx+lsb+H
         nQrF2BOKUSBX/CN7xHt8xEFv/pait3quuXQecVo7+bPNnfaDHfdPOdbwlnmkLbjUUTKF
         MJK4026QgXdL93Ff6qj+jZ0ZGGulexEaMWHfWaHl7nbt53ts57IwoZxe6RC+w3w27g/Z
         PHQufurCt+Aaz6qzuJw57oUz58WTEuUDIVYhczD+YV+aqwywLpEiXTig+EfWTDT/4X7z
         RGmiHv62OwVY28zH6ZzVnXxKysEfeyP9f4+5wSji5IN9PD0PHKoldv5eH3BxgkJLcQJM
         OzvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE32HmS/zhyMRoni0x8WYWHeCM/ewoX2XUQT4vb88cuYZ8GAdUYq7qnfTbWWfIUITGefYW69mWsqxF38Y=@vger.kernel.org, AJvYcCV/OARPoCX1cbubQIFAMDDsqUYE46bE0xogeZcMKmJMoHNLhvcDEHL21T7n+vR4DbzoamsLpmNX4rFzHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9mG/Hu9bcCZsb8MvBx5XNp8kTmpvpkPuhtkJbJoJ+WWJBWvs
	Gk2VuW05eR2E9T+6QfoiWLelB0tagtGraRLSGvvwnExwplUTMqKd
X-Gm-Gg: ASbGncv8+i0a9LYQQyhhuv3LKq+6vOVS9qUF9WYKzTnoVrCH+AvUavJHNNGfjNI9o9e
	m22l6h4mnzkuRl1t+bGfo2IdY374aR2HMbBvaopGys7jjP5PaZWt+h53lkl80xTTncKBvhHniFf
	NRrtiu0qjhIhg4WG5INgzRyXjktZfqqUzo48pP+xe/K7JY7dIyr669YJpOXY3PlpGNduz30NGbu
	YKHrly4FPHlwY9fU0ob10zEO0StNy/GDYD7GCO2XhgozwLMAfAkxY/XEFT/owtQVFjBLvnM0BQb
	xYule1LNlfgjzp3f21W9PyH8qZvp6xD4tVAcK/oGMNhxXtDBHs324JKTdWelEcd4Zys/wuojGta
	d
X-Google-Smtp-Source: AGHT+IG2htx9pVU9WR+nsKfD/U9REodWqnHBAE2wZMug1j8tBHoBQsU0NkpWfxwYI/FiHoXhYGiIIw==
X-Received: by 2002:a05:600c:42c2:b0:43d:1824:aadc with SMTP id 5b1f17b1804b1-43ebcb90409mr28235755e9.29.1743688988746;
        Thu, 03 Apr 2025 07:03:08 -0700 (PDT)
Received: from [172.27.62.155] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a153sm20249905e9.2.2025.04.03.07.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 07:03:08 -0700 (PDT)
Message-ID: <a23ccc3b-bb4d-4352-bd7e-ab0f3ef82585@gmail.com>
Date: Thu, 3 Apr 2025 17:03:04 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix potential null dereference when enable
 shared FDB
To: =?UTF-8?B?Q2hhcmxlcyBIYW4o6Z+p5pil6LaFKQ==?= <hanchunchao@inspur.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org"
 <leon@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "markzhang@nvidia.com" <markzhang@nvidia.com>,
 "mbloch@nvidia.com" <mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <526e6240c8964fefa80b4bc759c44c04@inspur.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <526e6240c8964fefa80b4bc759c44c04@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/04/2025 12:52, Charles Han(韩春超) wrote:
> -ENXIO indicates "No such device or address". I've found that in mlx5/core, if mlx5_get_flow_namespace() returns null, it basically returns -EOPNOTSUPP.
> 

Please do not top-post.

+1.
If namespace is not found it's due to lack of support.


> -----邮件原件-----
> 发件人: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 发送时间: 2025年4月2日 19:02
> 收件人: Charles Han(韩春超) <hanchunchao@inspur.com>
> 抄送: netdev@vger.kernel.org; linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org; saeedm@nvidia.com; leon@kernel.org; tariqt@nvidia.com; andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; markzhang@nvidia.com; mbloch@nvidia.com
> 主题: Re: [PATCH] net/mlx5: fix potential null dereference when enable shared FDB
> 
> On 4/2/25 11:43, Charles Han wrote:
>> mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
>> without NULL check may lead to NULL dereference.
>> Add a NULL check for ns.
>>
>> Fixes: db202995f503 ("net/mlx5: E-Switch, add logic to enable shared
>> FDB")
>> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Acked-by: Tariq Toukan <tariqt@nvidia.com>

>> ---
>>    .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 10 ++++++++++
>>    drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c       |  5 +++++
>>    2 files changed, 15 insertions(+)
>>
>> diff --git
>> a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>> index a6a8eea5980c..dc58e4c2d786 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>> @@ -2667,6 +2667,11 @@ static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
>>    	if (master) {
>>    		ns = mlx5_get_flow_namespace(master,
>>    					     MLX5_FLOW_NAMESPACE_FDB);
>> +		if (!ns) {
>> +			mlx5_core_warn(master, "Failed to get flow namespace\n");
>> +			return -EOPNOTSUPP;
> 
> I would return -ENXIO in such cases, you were searching and not found that.
> 
> IOW it is obvious that dereferencing a null ptr is not supported.
> 
> If you agree, please apply the same comment for your other patch:
> https://lore.kernel.org/netdev/20250402093221.3253-1-hanchunchao@inspur.com/T/#u
> 
>> +		}
>> +
>>    		root = find_root(&ns->node);
>>    		mutex_lock(&root->chain_lock);
>>    		MLX5_SET(set_flow_table_root_in, in, @@ -2679,6 +2684,11 @@ static
>> int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
>>    	} else {
>>    		ns = mlx5_get_flow_namespace(slave,
>>    					     MLX5_FLOW_NAMESPACE_FDB);
>> +		if (!ns) {
>> +			mlx5_core_warn(slave, "Failed to get flow namespace\n");
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>>    		root = find_root(&ns->node);
>>    		mutex_lock(&root->chain_lock);
>>    		MLX5_SET(set_flow_table_root_in, in, table_id, diff --git
>> a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
>> index a47c29571f64..18e59f6a0f2d 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
>> @@ -186,6 +186,11 @@ static int mlx5_cmd_set_slave_root_fdb(struct mlx5_core_dev *master,
>>    	} else {
>>    		ns = mlx5_get_flow_namespace(slave,
>>    					     MLX5_FLOW_NAMESPACE_FDB);
>> +		if (!ns) {
>> +			mlx5_core_warn(slave, "Failed to get flow namespace\n");
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>>    		root = find_root(&ns->node);
>>    		MLX5_SET(set_flow_table_root_in, in, table_id,
>>    			 root->root_ft->id);
> 


