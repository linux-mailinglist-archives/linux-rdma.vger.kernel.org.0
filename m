Return-Path: <linux-rdma+bounces-807-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0736841AFB
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 05:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C11B23F65
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 04:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53E637711;
	Tue, 30 Jan 2024 04:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joL9zUif"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF62374E9;
	Tue, 30 Jan 2024 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706588748; cv=none; b=Op1P+1SQJMtV33e5p9bTwgfXjkKaSy9legfAONrn0ckHHoXWWJ9MXuO6eabHI2tZ2Jp6ol+Aup7AkNKLdWRh41s9Hd5Tj915ua3A5/3I7gsXiznBs7TcioQAd4+ih61/QAi60zLgHocWzkyoCvRgxYyEYpWQA63JwcMgZgNcnQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706588748; c=relaxed/simple;
	bh=XICM0oAtdISW5wifA2LPI0rqIpUaKmfx63mDyMRbC4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETw9xbt/KwxUDqoMtLwB65f2LEwgcpotNYs0mpczW5YvSCNzsvLytQWnwD2oG0YL5S+TDDPeImNdjI4CvFuDGOoxK4TGmrLTO+ZvwV5+A9cfvjI3H+u+DagEQ4efrcUnHJN3l4aTtLvpQYd0rHVzBGRP4/Bhb4rPFzqt+mKsARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joL9zUif; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68c444f9272so14927056d6.3;
        Mon, 29 Jan 2024 20:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706588746; x=1707193546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AHazMTJo3ftxGOybhu8r+ldeS3EjtdJgqSS2/cHkgQ=;
        b=joL9zUiflWneT1GhTnsIpdPa2cmMPAmWsnPotRMd1eAgOa/Gx3lU2q1ZPJorrOpLtB
         Y+9LYZsvoagpd0Mud1E2kJd4eEvfRdzD9FEriVqGeyg1tA4MsudwJJciqRM0SETJGyQa
         kVJW73SArG7wL5VJ8ZnoJwMk5UFaZgs2D/S1JQ+eDQA9YosPMFrsifElez26GNHDHi9p
         kX14e9B/BZwOaRdqZ/c23f6NKWDYwdAqH6Ruq1e/4b5Ohfx7h02MGGrD6nzo41ubdbar
         NYne2lwMRgy7TUV1sqanRC3DAH1otZhL/fsE36VJRfIEEwEkaKaTXmof6LgdXP97H8ZZ
         huQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706588746; x=1707193546;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AHazMTJo3ftxGOybhu8r+ldeS3EjtdJgqSS2/cHkgQ=;
        b=d5AXHf86IEz18DGtfFdu69fpZHRalFaH4OtfIJ2Tgq7YFmvFvieUVUnyKJ3NRQedZ2
         Ev+VlG85gq9jiyNgO8Edeo/hjwH7Uitz+jv/urK9z7c6xIiqNP3wmBcvtbpWuaLH4/jv
         hb4sFL3Z4u8L7V3CO4Rzkt0mccO78hhd/6C/PCHMJxLRPlM6FLIAU4aGnoxOICsnnOQg
         2PaAITUCCVpzt6A0Ic0isYdXpVEwjNYawTc01ywoTIfZn3cPPAghjtr1biEQFgbIleUW
         DTcwhR1xx83I1817bPQJNVrCGQIX7n81YkzhFXFA6b5G+R/L5LnzmMzhwUM4oKn6tMz4
         WzZA==
X-Gm-Message-State: AOJu0YxUIRknYIJJXXqtonVZqN/hcxT2BgDv8G1/QCE1r+0lg7vSLIXM
	BtQX3FkDKupFng1B9QztQO54/f9oUAZ5W4Vpun0a4tSMvywa0EHO
X-Google-Smtp-Source: AGHT+IGy9UUdmNDz4l38U/OoB7UBhcXnjASGv2Y2KlMX0Ay6yVuxW3W+63dk5v8No/mNIN7kt1bguA==
X-Received: by 2002:a05:6214:491:b0:683:d9df:ca5a with SMTP id pt17-20020a056214049100b00683d9dfca5amr9750417qvb.108.1706588745707;
        Mon, 29 Jan 2024 20:25:45 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a166700b00783da2644besm3320146qko.136.2024.01.29.20.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 20:25:45 -0800 (PST)
Message-ID: <8c178bd1-e0c9-4e29-9b63-dd298298bc7b@gmail.com>
Date: Mon, 29 Jan 2024 20:25:42 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stable-rc: 6.1: mlx5: params.c:994:53: error:
 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
Content-Language: en-US
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-stable <stable@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 linux-rdma@vger.kernel.org, lkft-triage@lists.linaro.org,
 Sasha Levin <sashal@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
References: <CA+G9fYvYQRnBbZhHknSKbwYiCr_3vPwC5zPz2NsV9_1F7=paQQ@mail.gmail.com>
 <2024012915-enlighten-dreadlock-54e9@gregkh>
 <CA+G9fYs3_M9E3w+uWky5X1hEgoJU4e92ECqSywerqSkF8KVGvA@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <CA+G9fYs3_M9E3w+uWky5X1hEgoJU4e92ECqSywerqSkF8KVGvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/29/2024 6:52 PM, Naresh Kamboju wrote:
> On Mon, 29 Jan 2024 at 21:58, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, Jan 29, 2024 at 09:17:31PM +0530, Naresh Kamboju wrote:
>>> Following build errors noticed on stable-rc linux-6.1.y for arm64.
>>>
>>> arm64:
>>> --------
>>>    * build/gcc-13-lkftconfig
>>>    * build/gcc-13-lkftconfig-kunit
>>>    * build/clang-nightly-lkftconfig
>>>    * build/clang-17-lkftconfig-no-kselftest-frag
>>>    * build/gcc-13-lkftconfig-devicetree
>>>    * build/clang-lkftconfig
>>>    * build/gcc-13-lkftconfig-perf
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> Build errors:
>>> ------
>>> drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In function
>>> 'mlx5e_build_sq_param':
>>> drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: error:
>>> 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
>>>    994 |                     (mlx5_ipsec_device_caps(mdev) &
>>> MLX5_IPSEC_CAP_CRYPTO);
>>>        |
>>> ^~~~~~~~~~~~~~~~~~~~~
>>>
>>> Suspecting commit:
>>>    net/mlx5e: Allow software parsing when IPsec crypto is enabled
>>>    [ Upstream commit 20f5468a7988dedd94a57ba8acd65ebda6a59723 ]
>>
>> Something looks very odd here, as the proper .h file is being included,
>> AND this isn't a build failure on x86, so why is this only arm64 having
>> problems?  What's causing this not to show up?
> 
> As per the Daniel report on stable-rc review on 6.1, these build failures also
> reported on System/390.

The build failure is legitimate here since 
drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h guards all of 
the definitions and enumerations under a CONFIG_MLX5_EN_IPSEC which is 
not enabled in the build configuration that failed.

This is implicitly fixed upstream with 
8c582ddfbb473c1d799c40b5140aed81278e2837 ("net/mlx5e: Handle hardware 
IPsec limits events") which relocates the #ifdef CONFIG_MLX5_EN_IPSEC 
below and allows the MLX5_IPSEC_CAP_CRYPTO enum value, amongst others to 
be visible to code that is not guarded with CONFIG_MLX5_EN_IPSEC. This 
specific commit does not apply cleanly to the stable-6.1 branch, so 
maybe the best we can come up with is this targeted change that does the 
same thing against 6.1:

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h 
b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 16bcceec16c4..785f188148d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -34,7 +34,6 @@
  #ifndef __MLX5E_IPSEC_H__
  #define __MLX5E_IPSEC_H__

-#ifdef CONFIG_MLX5_EN_IPSEC

  #include <linux/mlx5/device.h>
  #include <net/xfrm.h>
@@ -146,6 +145,7 @@ struct mlx5e_ipsec_sa_entry {
         struct mlx5e_ipsec_modify_state_work modify_work;
  };

+#ifdef CONFIG_MLX5_EN_IPSEC
  int mlx5e_ipsec_init(struct mlx5e_priv *priv);
  void mlx5e_ipsec_cleanup(struct mlx5e_priv *priv);
  void mlx5e_ipsec_build_netdev(struct mlx5e_priv *priv);
-- 
Florian

