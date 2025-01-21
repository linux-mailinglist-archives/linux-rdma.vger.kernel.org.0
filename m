Return-Path: <linux-rdma+bounces-7155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C6A18285
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 18:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710DF167E60
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D351F4E4C;
	Tue, 21 Jan 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KvgkrE0r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238391B394B;
	Tue, 21 Jan 2025 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737479161; cv=none; b=msYKRArBOBArvqTHyL+IG+0CXSZWKgRihf17dEpzfx0Qtfg1EGGGdB79OGiaf6lkeVqgfZOKhdMB9jU3tF8DRZDzh9xQquzU6UYwudKSGNpsPqm2txyd8Xh781qWjaFl9zhjXCqmznTbh2pMgy01K27bb+rouuX4voPdNoAJEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737479161; c=relaxed/simple;
	bh=PmBFIKLTamNuhMcnkQsiWtJmWxFhkW3jVfnxJIvhdFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lERJ/fM1BNbKx/IwyJLA9/Vx9hVGspyklMdI6daDxtFYCqMe2oKFrpV3dW9t6jSpHfMf+q5viCo+ucS9FQd3XHLLrDLYuJzJOIsJj3ebCy+BAPP5jMYhRPlT5bkE346sI1WjGyrf7PPQnYITuHPIrd2ExEHhSo/hCbm5RA8q3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KvgkrE0r; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OItftmU3nmHodeFN5LD5V3oR/F2npmbkhzoTbe1kM+o=; b=KvgkrE0rogp+a/4Foip2XP4U8x
	7NhupLyR9KURgt2tWVnxxhnN+fuusBdQm2LJzlGsNJ8JxYZfRX7vxAPVEQnlQQRcp6gHKhf11OY5m
	j+euHjhojXFdazNYT0+Bl9oPNw1CYGN5PmAphZw7+ncC05I8+KC9iBfRDLnHhz1d9jGpqhLoYM/HG
	KiRudfiigr49OVXnJEIUqoWaqcGmlM83i4xUSx9zgkfaieokWY1Izd5dfoAME2pHX9PvhStQahys6
	4esaFGu1hvglBHtS3YKHfQMw8BMlhGhj5mkDW86sud/NMo3Gr+92HOZ2YpjTGKY9FzMXGhtGt+kOj
	VMBlOGuw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40242)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1taHh8-0007Tf-30;
	Tue, 21 Jan 2025 17:05:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1taHh0-00043L-1F;
	Tue, 21 Jan 2025 17:05:34 +0000
Date: Tue, 21 Jan 2025 17:05:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Huisong Li <lihuisong@huawei.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org, oss-drivers@corigine.com,
	linux-rdma@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linuxarm@huawei.com, linux@roeck-us.net, jdelvare@suse.com,
	kernel@maidavale.org, pauk.denis@gmail.com, james@equiv.tech,
	sudeep.holla@arm.com, cristian.marussi@arm.com, matt@ranostay.sg,
	mchehab@kernel.org, irusskikh@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, louis.peens@corigine.com, hkallweit1@gmail.com,
	kabel@kernel.org, W_Armin@gmx.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, alexandre.belloni@bootlin.com,
	krzk@kernel.org, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
	liuyonglong@huawei.com
Subject: Re: [PATCH v1 01/21] hwmon: Fix the type of 'config' in struct
 hwmon_channel_info to u64
Message-ID: <Z4_T3s7zn3UQNkbW@shell.armlinux.org.uk>
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <20250121064519.18974-2-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121064519.18974-2-lihuisong@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 21, 2025 at 02:44:59PM +0800, Huisong Li wrote:
>   */
>  struct hwmon_channel_info {
>  	enum hwmon_sensor_types type;
> -	const u32 *config;
> +	const u64 *config;
>  };
>  
>  #define HWMON_CHANNEL_INFO(stype, ...)		\
>  	(&(const struct hwmon_channel_info) {	\
>  		.type = hwmon_##stype,		\
> -		.config = (const u32 []) {	\
> +		.config = (const u64 []) {	\
>  			__VA_ARGS__, 0		\
>  		}				\
>  	})

I'm sorry, but... no. Just no. Have you tried building with only your
first patch?

It will cause the compiler to barf on, e.g. the following:

static u32 marvell_hwmon_chip_config[] = {
...

static const struct hwmon_channel_info marvell_hwmon_chip = {
        .type = hwmon_chip,
        .config = marvell_hwmon_chip_config,
};

I suggest that you rearrange your series: first, do the conversions
to HWMON_CHANNEL_INFO() in the drivers you have.

At this point, if all the drivers that assign to hw_channel_info.config
have been converted, this patch 1 is then suitable.

If there are still drivers that assign a u32 array to
hw_channel_info.config, then you need to consider how to handle
that without causing regressions. You can't cast it between a u32
array and u64 array to silence the warning, because config[1]
won't point at the next entry.

I think your only option would be to combine the conversion of struct
hwmon_channel_info and the other drivers into a single patch. Slightly
annoying, but without introducing more preprocessor yuckiness, I don't
see another way.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

