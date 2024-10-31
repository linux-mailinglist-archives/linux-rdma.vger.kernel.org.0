Return-Path: <linux-rdma+bounces-5672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E39B8104
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 18:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2224A1F22B41
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9CF1C1AB3;
	Thu, 31 Oct 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Tm9fylOI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C61A0B00
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395054; cv=none; b=pmhKySbvP26m7Mws9FSYvXH/qmUCvWFJBBG5ORdgivuB9dtzEhf3LCHbI+MK1fl0om28hW0EhSR4jCH/4HF69OydXZjalq4qYoxd5Ug/oZgM4gn4wW1Ine3mPtlzuF6vGh121dnmwyahlpSBDlSUZpycv3BtAF5qxUvlHzVqNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395054; c=relaxed/simple;
	bh=bx0jessu0KfLRZtCqrKGlDJ3ti7ypTOq/nU0abf7IMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRTdg/xoUirIv+7d8qp07uCuyFJp4hjhUiEWYFzqXnWrKrq1NcHXQ1eGYE4WVUuyUgF7TsXl8lY8frqbrn7OPbCKeC1Ny1tBX6yTqJJFJWqdpPLv9OLhDiFHPt3N3AWI+trBXwdafT30u3pk20TrfMZysZIi0V8TH43aWqtSPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Tm9fylOI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so819264f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730395050; x=1730999850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yuVL5XevAlSQZiTVvR3V3r/+5ebo7kY9AfDcEkuoaT4=;
        b=Tm9fylOI8o3RBB7refl2qDn20v4IulV4ZCK4YXcswsL5fFskYp4jvguqX+xCFC0GLn
         hAuYQGLVOfiUL70RFgUMtjdXRGwiVlDxpbfei60Ut/FHceOAAXr6WVOIKxZ1WWiau/kI
         GQxPv+JvLHtNTCeD/R3MNsl2ihOyMm4ivWR5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395050; x=1730999850;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuVL5XevAlSQZiTVvR3V3r/+5ebo7kY9AfDcEkuoaT4=;
        b=MgAp6N9WdI+prgJpdsNe3+P5G7se2yiT7YIDLg4TZL2LhueTpsjJQmDtzvAnb6FdII
         sSDk3RNR6VFl83Ziyu761cETeryuFdxhR5InRcjOcGE6LplxHIJU8klyXTFc+LbivuCW
         EB0ChQQrzilHpB8sDlgbi/53XeREyCz/vTi20uKtPXhlitlrLg7hQk6fBRZPqEReCPGk
         pwRTq1IyDzFt94ErZF/F6/c4YR6tmF6FotvfbxvBh7xFWQKngzfq/svznSbZK6cqwowg
         vjU366c+YNyQwURxpm1FiRaMynnafDYcalmN/mP1+VrIJzNEM1GQEl8VqSbXga3G/dY6
         9APA==
X-Forwarded-Encrypted: i=1; AJvYcCU0vTzdshzTdK2LILtBzZtHU9c0S5AIeVTx/7yPBgUOj7Ka9TR2pOwHfKWAMD9pCwN6i61mdp9+7kW5@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/FjLr4kszrG1LHNGVVC2HDdl4bQdxKnC7TVJEVMZxR61jIs/
	urNGdyQRUy2Y6Tlr87slr6nsEetFg31lMoRcZVkwgHNtZ1YwA5gsCh/ySDPbKQ==
X-Google-Smtp-Source: AGHT+IFjT29yi5SX0dw1nHhzoYLJGP+01L3NL5a3fZUFudXflNMBcjs32Cnleu5VTb7EMdHUUlSccA==
X-Received: by 2002:a05:6000:ac1:b0:37d:3280:203a with SMTP id ffacd0b85a97d-381b7057644mr5887676f8f.10.1730395049620;
        Thu, 31 Oct 2024 10:17:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c08sm2713960f8f.17.2024.10.31.10.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:17:28 -0700 (PDT)
Message-ID: <5ab60ad8-5625-41d3-b20a-4137a8f4c19a@broadcom.com>
Date: Thu, 31 Oct 2024 10:17:17 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend PATCH 2/2] dim: pass dim_sample to net_dim() by reference
To: Caleb Sander Mateos <csander@purestorage.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Brett Creeley
 <brett.creeley@amd.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, David Arinzon
 <darinzon@amazon.com>, "David S. Miller" <davem@davemloft.net>,
 Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Felix Fietkau <nbd@nbd.name>, Geetha sowjanya <gakula@marvell.com>,
 hariprasad <hkelam@marvell.com>, Jakub Kicinski <kuba@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Leon Romanovsky <leon@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Louis Peens <louis.peens@corigine.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Noam Dagan <ndagan@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Roy Pledge <Roy.Pledge@nxp.com>, Saeed Bishara <saeedb@amazon.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Sean Wang <sean.wang@mediatek.com>,
 Shannon Nelson <shannon.nelson@amd.com>, Shay Agroskin <shayagr@amazon.com>,
 Simon Horman <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>, Tal Gilboa <talgi@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 oss-drivers@corigine.com, virtualization@lists.linux.dev
References: <20241031002326.3426181-1-csander@purestorage.com>
 <20241031002326.3426181-2-csander@purestorage.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20241031002326.3426181-2-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 17:23, Caleb Sander Mateos wrote:
> net_dim() is currently passed a struct dim_sample argument by value.
> struct dim_sample is 24 bytes. Since this is greater 16 bytes, x86-64
> passes it on the stack. All callers have already initialized dim_sample
> on the stack, so passing it by value requires pushing a duplicated copy
> to the stack. Either witing to the stack and immediately reading it, or
> perhaps dereferencing addresses relative to the stack pointer in a chain
> of push instructions, seems to perform quite poorly.
> 
> In a heavy TCP workload, mlx5e_handle_rx_dim() consumes 3% of CPU time,
> 94% of which is attributed to the first push instruction to copy
> dim_sample on the stack for the call to net_dim():
> // Call ktime_get()
>    0.26 |4ead2:   call   4ead7 <mlx5e_handle_rx_dim+0x47>
> // Pass the address of struct dim in %rdi
>         |4ead7:   lea    0x3d0(%rbx),%rdi
> // Set dim_sample.pkt_ctr
>         |4eade:   mov    %r13d,0x8(%rsp)
> // Set dim_sample.byte_ctr
>         |4eae3:   mov    %r12d,0xc(%rsp)
> // Set dim_sample.event_ctr
>    0.15 |4eae8:   mov    %bp,0x10(%rsp)
> // Duplicate dim_sample on the stack
>   94.16 |4eaed:   push   0x10(%rsp)
>    2.79 |4eaf1:   push   0x10(%rsp)
>    0.07 |4eaf5:   push   %rax
> // Call net_dim()
>    0.21 |4eaf6:   call   4eafb <mlx5e_handle_rx_dim+0x6b>
> 
> To allow the caller to reuse the struct dim_sample already on the stack,
> pass the struct dim_sample by reference to net_dim().
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com> 
#bcm{sysport,genet}.c

Thanks!
-- 
Florian

