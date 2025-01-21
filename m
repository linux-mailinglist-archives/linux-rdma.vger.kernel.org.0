Return-Path: <linux-rdma+bounces-7149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD26A17DB4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 13:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0079E16B6F9
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 12:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3301F151B;
	Tue, 21 Jan 2025 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGxs+pk9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509481D554;
	Tue, 21 Jan 2025 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461956; cv=none; b=pD9/Bz4aysIW6XPHWwPDLywyoGJV3eq5N+T1okE+SwAF8wih78lS5bLWwhw4wTATcl5i3iFJPFmvL9aDQi4rKp/0/UUdNM2fwCI1xTrkMKtHpngj5cXX/50dPdE/tFqHwKjZRosVIxAh9MIOJX8sW2iZ0Lf65JJuowl6GAlrp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461956; c=relaxed/simple;
	bh=sPesZWYC0ulEJj/gesJPmVOOyLfPgsGZKiiMssRCLcU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BIIoOnl1eOC7ze4x3NvELKOI0fgC8Rfysu5NS59XiOXKMNNhQ5x2SMP7J6H4XcPeeTBXKQBbMcXSJqXbWNnFRX82Pm0FezWVeTVNW8uUhe0mskhev+TdOhG4oaVUKoS5d0okybGAkBkeWcQIYGLb50txEHCarEuPQg34GaWGfWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGxs+pk9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737461955; x=1768997955;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sPesZWYC0ulEJj/gesJPmVOOyLfPgsGZKiiMssRCLcU=;
  b=jGxs+pk9Czd0TRSNFjT4SUeyymLccvvh0CKFcZHTdxZu97ZOO1kuWSOt
   AmMxmV1CkWT3bNQPwNK1urxn53nI2FgN1zRwLJzi6NvzQDTXhpHl5aCZe
   NUgo70btqPNZRNXjm5pqN09cHG2dFWZNyD5dBzXDlJx9eljNM2DozFwoe
   CGYYqfkGuVXIoV3I2oPcY02w3X19LVhuAc5tw5TaxsOxFLKK/w0CBOjZP
   nepX2xsI3RgPQtOTPd7mf7L/mmD4YTpWjslB3NWtts/Fh8cLTeSUImhKR
   G/xP9bJvkr1/ZieQ5dOOrJurQE0NARn9nbcbL4PThwy/o07sohsC4Feba
   Q==;
X-CSE-ConnectionGUID: Ndw0UAZJQg+MRYZ3bRbGDQ==
X-CSE-MsgGUID: kNelo3TwQaCvORPfdvV2+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="38115461"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="38115461"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 04:19:14 -0800
X-CSE-ConnectionGUID: gH3zVvHuQEysE1CEtIUNmw==
X-CSE-MsgGUID: XYxDmMaMQhuYGVua7yV6Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="111790831"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 04:19:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jan 2025 14:18:56 +0200 (EET)
To: Huisong Li <lihuisong@huawei.com>
cc: linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    arm-scmi@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
    linux-rtc@vger.kernel.org, oss-drivers@corigine.com, 
    linux-rdma@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    linuxarm@huawei.com, linux@roeck-us.net, jdelvare@suse.com, 
    kernel@maidavale.org, pauk.denis@gmail.com, james@equiv.tech, 
    sudeep.holla@arm.com, cristian.marussi@arm.com, matt@ranostay.sg, 
    mchehab@kernel.org, irusskikh@marvell.com, andrew+netdev@lunn.ch, 
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
    pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
    louis.peens@corigine.com, hkallweit1@gmail.com, linux@armlinux.org.uk, 
    kabel@kernel.org, W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
    alexandre.belloni@bootlin.com, krzk@kernel.org, 
    jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, 
    zhenglifeng1@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH v1 19/21] platform/x86: dell-ddv: Fix the type of 'config'
 in struct hwmon_channel_info to u64
In-Reply-To: <20250121064519.18974-20-lihuisong@huawei.com>
Message-ID: <844c5097-eeb7-7275-7558-83ca4e5ee4b2@linux.intel.com>
References: <20250121064519.18974-1-lihuisong@huawei.com> <20250121064519.18974-20-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Jan 2025, Huisong Li wrote:

> The type of 'config' in struct hwmon_channel_info has been fixed to u64.
> Modify the related code in driver to avoid compiling failure.

Does this mean that after applying part of your series but not yet this 
patch, compile would fail? If so, it's unacceptable. At no point in a 
patch series are you allowed to cause a compile failure because it hinders 
'git bisect' that is an important troubleshooting tool.

So you might have to combine changes to drivers and API if you make an 
API change that breaks driver build until driver too is changed. Note that 
it will impact a lot how quickly your patches can be accepted as much 
higher level of coordination is usually required if your patch is touching 
things all over the place, but it cannot be avoided at times. And 
requirement of doing minimal change only will be much much higher in such 
a large scale change.

--
 i.

> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index e75cd6e1efe6..efb2278aabb9 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -86,7 +86,7 @@ struct thermal_sensor_entry {
>  
>  struct combined_channel_info {
>  	struct hwmon_channel_info info;
> -	u32 config[];
> +	u64 config[];
>  };
>  
>  struct combined_chip_info {
> @@ -500,7 +500,7 @@ static const struct hwmon_ops dell_wmi_ddv_ops = {
>  
>  static struct hwmon_channel_info *dell_wmi_ddv_channel_create(struct device *dev, u64 count,
>  							      enum hwmon_sensor_types type,
> -							      u32 config)
> +							      u64 config)
>  {
>  	struct combined_channel_info *cinfo;
>  	int i;
> @@ -543,7 +543,7 @@ static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_device *w
>  							    struct dell_wmi_ddv_sensors *sensors,
>  							    size_t entry_size,
>  							    enum hwmon_sensor_types type,
> -							    u32 config)
> +							    u64 config)
>  {
>  	struct hwmon_channel_info *info;
>  	int ret;
> 

