Return-Path: <linux-rdma+bounces-14320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF972C427CE
	for <lists+linux-rdma@lfdr.de>; Sat, 08 Nov 2025 06:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6932C188FE89
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Nov 2025 05:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950A2777E0;
	Sat,  8 Nov 2025 05:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6rzkZ9a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8E19DF62;
	Sat,  8 Nov 2025 05:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762580314; cv=none; b=N8/g90y+PQPgViOrQT166Eg+mUukt9D87THnn8McP6zmV6YoimxCEdlbUBPqPGsd8IJEJt6x/cgG7Cen3Jn//5yINquLJC5nNHXpOH9OGjl5p20YkXyrf68u3EDVR3lkt2a24AwJ08ENgVC2yP0noO29WNXzPTYifI7xlcADVfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762580314; c=relaxed/simple;
	bh=w6GXV8F8qq8Ivlsip/h/QX7gHcMdkkyqZQffmsH93Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGo0f2+Ys6FOeruPJqU1Lku63wnfEHbwk7+hTV94xHRXOj5Sr9NXyVUS3suQWg3xDsV1sxHqeEQrxCYDdslbmrn1l1AsAtDKYYiYiodfxBC5FpTVDc2bJxj+ifiV+VoWlaRq5qUMck/ElPlU23wjfaya0I3tX77nmsf9M6lDzxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6rzkZ9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC516C19422;
	Sat,  8 Nov 2025 05:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762580313;
	bh=w6GXV8F8qq8Ivlsip/h/QX7gHcMdkkyqZQffmsH93Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6rzkZ9aOnGt/EQ9R93dim8mBYYjOjakJehQ5+rN7x3rvkrZwgPe3DNMNBLOS6Sh4
	 mImZKwWN8OxH6gjwHfbPpky8S4xfaMEw4jAyYKPEkT3ztoZqWXNpmZBCg3s9GW11DH
	 ubqLYGlFVZD9/bwsgi4HUeIL+tGoVZRpcmwSzbCHe4/tKN/YY1WJFNFfWmJhYpQvYq
	 aLmPydUhP1j4nb/QPh4Bpfzi2TidyWlqi7OIYoBoMGpHxUbV0BbBU/eCT9rJf0d0LI
	 UGX4tJ2pBMvLkxAGG5WdK5NuaGVKDGXY0wPCPhO3ZVQAVKzkoatva84A/KHH/1yljJ
	 uT5/heaaQlZPQ==
Date: Fri, 7 Nov 2025 21:38:32 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Manish Chopra <manishc@marvell.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
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
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
Message-ID: <aQ7XWOI68rVDRewR@x130>
References: <20251103194554.3203178-1-daniel.zahka@gmail.com>
 <20251103194554.3203178-3-daniel.zahka@gmail.com>
 <mhm4hkz52gmqok56iuiukdcz2kaowvppbqrfi3zxuq67p3otit@5fhpgu2axab2>
 <db5c46b4-cc66-48bb-aafb-40d83dd3620c@gmail.com>
 <6aa2f011-3ba5-4614-950d-d8f0ec62222b@gmail.com>
 <p3pj3mu4mabgninwowqikegeotxgzhc4yptf7qrfhns37bnkoz@ugkbgvlkxqxb>
 <78db1fab-e482-4ebc-82ce-ba84b3f561e2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78db1fab-e482-4ebc-82ce-ba84b3f561e2@gmail.com>

On 04 Nov 09:48, Daniel Zahka wrote:
>
>
>On 11/4/25 9:39 AM, Jiri Pirko wrote:
>>Tue, Nov 04, 2025 at 01:51:16PM +0100, daniel.zahka@gmail.com wrote:
>>>
>>>On 11/4/25 6:38 AM, Daniel Zahka wrote:
>>>>
>>>>On 11/4/25 5:14 AM, Jiri Pirko wrote:
>>>>>I did some research. 0/DEVICE_DEFAULT should not be ever reported back
>>>>>from FW. It's purpose is for user to reset to default FW configuration.
>>>>>What's the usecase for that? I think you could just avoid
>>>>>0/DEVICE_DEFAULT entirely, for both get and set.
>>>>I find that 0/DEVICE_DEFAULT is reported back on my device. I have
>>>>observed this same behavior when using the mstconfig tool for setting the
>>>>parameter too.
>>>e.g.
>>>$ dmesg | grep -i mlx | grep -i firmware
>>>[   10.165767] mlx5_core 0000:01:00.0: firmware version: 28.46.1006
>>>
>>>$ ./mstconfig -d 01:00.0 -b ./mlxconfig_host.db query SWP_L4_CHECKSUM_MODE
>>>
>>>Device #1:
>>>----------
>>>
>>>Device type:        ConnectX7
>>>Name:               CX71143DMC-CDAE_FB_Ax
>>>Description:        ConnectX-7 Ethernet adapter card; 100 GbE OCP3.0;
>>>Single-port QSFP; Multi Host; 2 Host; PCIe 4.0 x16; Crypto and Secure Boot
>>>Device:             01:00.0
>>>
>>>Configurations:                                          Next Boot
>>>         SWP_L4_CHECKSUM_MODE DEVICE_DEFAULT(0)
>>This is next-boot value. You should query current (--enable_verbosity)
>>to show in param get.
>
>I am still seeing that DEVICE_DEFAULT(0) is read back:
>
>$ ./mstconfig --enable_verbosity -d 01:00.0 -b ./mlxconfig_host.db 
>query SWP_L4_CHECKSUM_MODE
>
>Device #1:
>----------
>
>Device type:        ConnectX7
>Name:               CX71143DMC-CDAE_FB_Ax
>Description:        ConnectX-7 Ethernet adapter card; 100 GbE OCP3.0; 
>Single-port QSFP; Multi Host; 2 Host; PCIe 4.0 x16; Crypto and Secure 
>Boot
>Device:             01:00.0
>
>Configurations:                  Default             Current       Next Boot
>        SWP_L4_CHECKSUM_MODE DEVICE_DEFAULT(0) DEVICE_DEFAULT(0)    
>DEVICE_DEFAULT(0)
>

When default value of nvconfig is managed by FW, 0 will always mean
DEVICE_DEFAULT, and it is a way for the driver to reset back to default on
write, but on read FW should never return it, so this is a FW bug.

But this shouldn't block this series so just return 'default', from the 
driver perspective we should return 'default' when we know 0 means that.


