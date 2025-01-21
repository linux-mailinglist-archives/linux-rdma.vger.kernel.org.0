Return-Path: <linux-rdma+bounces-7156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7074A182BF
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 18:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669A916A1B4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7FE1F4E4C;
	Tue, 21 Jan 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GciTIOuO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3E5028C;
	Tue, 21 Jan 2025 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480018; cv=none; b=mofYLlVWpkMPZg7jc81//rtHm7zRJrhYXdLmIqCJ+uBUb1pFPhqVbRZDQKXIqBZgCFPdFZ/luehYcoCfueo5s4vc6EEHK3l/vdyMoHLC+6ynDq3eOVcf9wzl+0PljC9Dze2GnsbMrDKBN9fv/4TocJD/Xt+3ioi6oQuzoIN7JqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480018; c=relaxed/simple;
	bh=PCPunsqPN4gPnF5CQnn9TVFaGWmCub+QX478Qs/QqJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoxGLuEqNguNE4sxxdcFag8MvY4PiS7iiJXIRX1tFh9TqwjPYDkFffUTEIAHcz2q2j9fwG3hMSveVslwlBB3cD/pwF8DTne4VHd3Gw8nF/oRTabtoZg+kWGbGqIm/+vADN+yLP8PAPa9rhwY+H24TyxAo/Qj4IjmaldP7/hWOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GciTIOuO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5q9yQxZ7qCRWB5N9g0tbP/E5H3IqId9T8M1S/6gGqmU=; b=GciTIOuOH+7z6FIEQSCiuQWUdn
	Lac+a6Qas11PDpxfxikk9qKlgXiCCFtlMzAJe1E6UlpZbRM/x8QIuP107azsvGn60uKyXwEKhcfGg
	F2PDh74Iymh0jzLQOgqvUgqL6eb0J0yolXdifkFiIM4/+I2erxk+OTvJlAZOCp9raslRcnSoLHHn4
	MIa/v697Xq5DdoMXB5BqyasXJe2KNdGofqbYniMIiOvWQsPl0WF2vxFy4eB3fQIwgT49n0d9JQtLy
	BwESQqcEeDE2DrTRQIIvAVPJRj5jzu8cz+Kn4frH+wrQH89A/GjBRfrVtvZfl6qXufO5On9XJUF2l
	gHmPPi+g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53924)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1taHv3-0007VH-2A;
	Tue, 21 Jan 2025 17:20:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1taHuz-00044S-29;
	Tue, 21 Jan 2025 17:20:01 +0000
Date: Tue, 21 Jan 2025 17:20:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Huisong Li <lihuisong@huawei.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org, oss-drivers@corigine.com,
	linux-rdma@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linuxarm@huawei.com, jdelvare@suse.com, kernel@maidavale.org,
	pauk.denis@gmail.com, james@equiv.tech, sudeep.holla@arm.com,
	cristian.marussi@arm.com, matt@ranostay.sg, mchehab@kernel.org,
	irusskikh@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	louis.peens@corigine.com, hkallweit1@gmail.com, kabel@kernel.org,
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	alexandre.belloni@bootlin.com, krzk@kernel.org,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH v1 00/21] hwmon: Fix the type of 'config' in struct
 hwmon_channel_info to u64
Message-ID: <Z4_XQQ0tkD1EkOJ4@shell.armlinux.org.uk>
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <03b138e9-688f-4ebc-bd01-3d54fd20e525@gmx.de>
 <9add68ac-7d10-4011-9da8-1f2de077d3e9@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9add68ac-7d10-4011-9da8-1f2de077d3e9@roeck-us.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 21, 2025 at 06:50:00AM -0800, Guenter Roeck wrote:
> On 1/21/25 06:12, Armin Wolf wrote:
> > Am 21.01.25 um 07:44 schrieb Huisong Li:
> > > The hwmon_device_register() is deprecated. When I try to repace it with
> > > hwmon_device_register_with_info() for acpi_power_meter driver, I found that
> > > the power channel attribute in linux/hwmon.h have to extend and is more
> > > than 32 after this replacement.
> > > 
> > > However, the maximum number of hwmon channel attributes is 32 which is
> > > limited by current hwmon codes. This is not good to add new channel
> > > attribute for some hwmon sensor type and support more channel attribute.
> > > 
> > > This series are aimed to do this. And also make sure that acpi_power_meter
> > > driver can successfully replace the deprecated hwmon_device_register()
> > > later.
> 
> This explanation completely misses the point. The series tries to make space
> for additional "standard" attributes. Such a change should be independent
> of a driver conversion and be discussed on its own, not in the context
> of a new driver or a driver conversion.

I think something needs to budge here, because I think what you're
asking is actually impossible!

One can't change the type of struct hwmon_channel_info.config to be a
u64 without also updating every hwmon driver that assigns to that
member.

This is not possible:

 struct hwmon_channel_info {
         enum hwmon_sensor_types type;
-        const u32 *config;
+        const u64 *config;
 };

static u32 marvell_hwmon_chip_config[] = {
...
};

static const struct hwmon_channel_info marvell_hwmon_chip = {
        .type = hwmon_chip,
        .config = marvell_hwmon_chip_config,
};

This assignment to .config will cause a warning/error with the above
change. If instead we do:

-	.config = marvell_hwmon_chip_config,
+	.config = (u64 *)marvell_hwmon_chip_config,

which would have to happen to every driver, then no, this also doesn't
work, because config[1] now points beyond the bounds of
marvell_hwmon_chip_config, which only has two u32 entries.

You can't just change the type of struct hwmon_channel_info.config
without patching every driver that assigns to
struct hwmon_channel_info.config as things currently stand.

The only way out of that would be:

1. convert *all* drivers that defines a config array to be defined by
   their own macro in hwmon.h, and then switch that macro to make the
   definitions be a u64 array at the same time as switching struct
    hwmon_channel_info.config

2. convert *all* drivers to use HWMON_CHANNEL_INFO() unconditionally,
   and switch that along with struct hwmon_channel_info.config.

3. add a new member to struct hwmon_channel_info such as
   "const u64 *config64" and then gradually convert drivers to use it.
   Once everyone is converted over, then remove "const u32 *config",
   optionally rename "config64" back to "config" and then re-patch all
   drivers. That'll be joyful, with multiple patches to drivers that
   need to be merged in sync with hwmon changes - and last over several
   kernel release cycles.

This is not going to be an easy change!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

