Return-Path: <linux-rdma+bounces-14239-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E048C310FB
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 13:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5E5E34DE2E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85872EC0A2;
	Tue,  4 Nov 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvGnXHbp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58925F99B
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260681; cv=none; b=V9iPKaCcjC9xu8NaaHR8oncBASNSnDYk9dfqd37Sd8QKPj33BB6ZgK2+gmB5KkojbG6GUUVm9qLe0Uau3YTCFg9MEhjGxEJjWOaLsGcQUGN5VpN1A6wJzoLBmGoOVWtXrwlNWXx81qOArAU+2WhPDHxh9ZuxjoiwJmbEgIWJLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260681; c=relaxed/simple;
	bh=Tm7Z1rbJg1xBtYLywrxZOtnC4oE4srr+4uBIseDYWug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ML9cZT/tQoVu+/gHTC8/TF1bgqU+wugTIfowIm0XBkHlLOu3/uCEzp2XENO/3n1NnAbyLyUbdbMk6hrEVrIewvP5+kWXI4CZuCTavdgdJKL2Hn38wyrIAhNB8673kVlLJDnD7wYDthZ8J3ibThg7MSn9SLONK0yOPjRCr5mxz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvGnXHbp; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-81efcad9c90so63793126d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 04 Nov 2025 04:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260679; x=1762865479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eNACkyQqVSo6Hmo5PjkrfufaeZZc3fNY7YlAuWMuRq0=;
        b=dvGnXHbpBabcXnzRnM6SfnJRJdhcUrfu7DWxWACFpfYxqxVPLOHCOV250+gGlVqaCN
         FoxYutoTSt/9t4Wzi/xkydfelXC0MWBN6itwSaSmkMFQJjM0FpT1+GkmH0IPqXW0U8lR
         A0Y9d1t2S0vKXFrMsguWkeFGiEjvg8IHfldf0S6UZvTikVD3jCJl9eQI91vo3RFmLafZ
         JPdDBrAtwVfVMkJrlQkhomY2RSc0gePKqxcdHf1vTUfLUINmXZHnZkgfT+cnJt9b9y5B
         IOmCKKUhgw7V7uJ0ZVz9Fg6iS3w4jR3cOSt2O/Eybs+9pw7oO7VKwOfRjxE7swYYJv6I
         MDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260679; x=1762865479;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNACkyQqVSo6Hmo5PjkrfufaeZZc3fNY7YlAuWMuRq0=;
        b=Ak7XPJYfUyw19HCdFe6z7l5JAE4HeiLAV+Ty51snvtor0pqzyZuPV8pM52GO+ZSmiC
         g+/ExDZ6vReyqR9zWzEiYj6thtKjb2yb2fobXaTiF1xaP7u1Pf+SziyL5qKCmHVF9dW9
         V12OeW+l33VN+rbCdg3c76/h5ak9QdXLaHdULXK4RKYDQvy9qcINybHlje8GJes6n8VN
         mpGn/ORMT1qJQ+BNAaEqMoAAqV2YjLisbWbonG7JwWmdnmjNHEVB5/JptJcTRUnaclk4
         n4iYPISndqWDR6dk4JUk4t6aiBzQcCn/zr7Nhe0tS9JpkGSCKrWzyFrRJvPva3wsYl64
         8X2w==
X-Forwarded-Encrypted: i=1; AJvYcCWJbOVDGy6gDsk8DewIn1C8jtgPFtnU2nBlCP6e1EP/ipSf/3ef3mikw0GlBoPqd0D+f4QUQVo5ngXw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz79sYh5p1dSP6FEdM7gfQHDsJWL47vKV0TOAIyNiutgwfUr8jF
	+EVci9o145USK5nCeOHKD+WjrWcKGvEE/ZT7slU87QQJlRv028rmkX8y
X-Gm-Gg: ASbGncvzP6xoVqZUk8mwxcYX+/exuv43jFlkG78meohKjsyMbPAkjInsmmsbA05J08W
	brHwaxGdjRpl4a7tpgyrPtPWCTgNCbhAUYL2aPh7CjkDdqu1D4OMGDpG4smovZHs4xuAvu1+rpz
	qFJ/oIl+o2Kk34pixg9KPHst+eTcymP9jSChhLFhp5ZbJCeF0+lClTszs/0aEiNnPoTIocFNhe5
	iOFbeX40AcjeZZQvusZ6AXef/BFQ2RcQyDF1Ue+X3+hhJHq66fEJ38AAo5oixfWpsNukCgNuQYu
	z4ICWolRPIPOGuCENf65LAr+9EZnd2Ae1XP/OWV0aw28Wtp73EOmegFf4V6ky6f5tLrcG+lIfAR
	N96ot6VVIfdZzc8p0t9O7asU7jESblolJ4wQVIBMWf7aymqf49S7G3GqLMkMFnV3Wg8p7grJhpK
	0dMaDKhcLUQQazCAxmx8/3jbEq8bgMFcRArfXbzg7u754B7L/ETYP+CSU=
X-Google-Smtp-Source: AGHT+IFm58ty03czXFexlH5hj0mLZA/g2M5F1UsdQEG3Wd5VnU77sQjl9srK3J0v7dmYKkp7SqLOlQ==
X-Received: by 2002:a05:6214:262e:b0:880:5edf:d177 with SMTP id 6a1803df08f44-8805edfd5b5mr52809046d6.11.1762260678910;
        Tue, 04 Nov 2025 04:51:18 -0800 (PST)
Received: from ?IPV6:2600:4040:93b8:5f00:52dd:c164:4581:b7eb? ([2600:4040:93b8:5f00:52dd:c164:4581:b7eb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060e906efsm19114706d6.45.2025.11.04.04.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:51:18 -0800 (PST)
Message-ID: <6aa2f011-3ba5-4614-950d-d8f0ec62222b@gmail.com>
Date: Tue, 4 Nov 2025 07:51:16 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Manish Chopra <manishc@marvell.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vladimir Oltean <olteanv@gmail.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
References: <20251103194554.3203178-1-daniel.zahka@gmail.com>
 <20251103194554.3203178-3-daniel.zahka@gmail.com>
 <mhm4hkz52gmqok56iuiukdcz2kaowvppbqrfi3zxuq67p3otit@5fhpgu2axab2>
 <db5c46b4-cc66-48bb-aafb-40d83dd3620c@gmail.com>
Content-Language: en-US
In-Reply-To: <db5c46b4-cc66-48bb-aafb-40d83dd3620c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/4/25 6:38 AM, Daniel Zahka wrote:
>
>
> On 11/4/25 5:14 AM, Jiri Pirko wrote:
>> I did some research. 0/DEVICE_DEFAULT should not be ever reported back
>> from FW. It's purpose is for user to reset to default FW configuration.
>> What's the usecase for that? I think you could just avoid
>> 0/DEVICE_DEFAULT entirely, for both get and set.
>
> I find that 0/DEVICE_DEFAULT is reported back on my device. I have 
> observed this same behavior when using the mstconfig tool for setting 
> the parameter too.

e.g.
$ dmesg | grep -i mlx | grep -i firmware
[   10.165767] mlx5_core 0000:01:00.0: firmware version: 28.46.1006

$ ./mstconfig -d 01:00.0 -b ./mlxconfig_host.db query SWP_L4_CHECKSUM_MODE

Device #1:
----------

Device type:        ConnectX7
Name:               CX71143DMC-CDAE_FB_Ax
Description:        ConnectX-7 Ethernet adapter card; 100 GbE OCP3.0; 
Single-port QSFP; Multi Host; 2 Host; PCIe 4.0 x16; Crypto and Secure Boot
Device:             01:00.0

Configurations:                                          Next Boot
         SWP_L4_CHECKSUM_MODE DEVICE_DEFAULT(0)

