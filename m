Return-Path: <linux-rdma+bounces-7174-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5089A18D1A
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 08:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F32A47A44AA
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1771C3034;
	Wed, 22 Jan 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcHKa0ET"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DD828EC;
	Wed, 22 Jan 2025 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737532303; cv=none; b=Hb0kUGyP8TwVgbVo2Jx4W6ccuBIA9Q55O7wBCKuIil+O0LvsBN5GERtWqjfmZdfbqoVkoFK/wJpQSw38rZqSO2xvyzSVN69+z3MrQ9GnGLoRKwkothy/ncQrTFz7LPqWpBjlJck87M/L4pcfMFqD6Zu4QqKWohWTjQ+xQeKWFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737532303; c=relaxed/simple;
	bh=msNhgHEYXHG3C130zRedQp0KghXab41wBWaPBjnjDiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5pctgH1SASXGm6Fv5NXX2gOOtWUx/e8fFT23qwSAsrzBBMd/c5k5n/0dXlJHhg6WKQF+pcdB0Cq6nXzGfXfGuHyfZ+l/MAxNIMsnKay5a4//oZeZFT68Xv7P0SpmeSSM2f7ES+zMTMetmb+3aEvwP6KlviEes6yso+42EKIHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcHKa0ET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011E4C4CED6;
	Wed, 22 Jan 2025 07:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737532302;
	bh=msNhgHEYXHG3C130zRedQp0KghXab41wBWaPBjnjDiA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OcHKa0ETgCGkBiVXh/ew2CBSZ99NvZ+uQdhJ8DMLYKfBvzvEZepe2h7xvvdMSfhmX
	 9rwz3hSzhhRQRIhlYetOiiLol4uTtJHw0KZi0caUOTMkgzsVGkiYu+63DwtdUi+S4F
	 Ao18BpYEpYV7V/RIRUVRioefdSufwF4MM2NW+IoXoeuXRBVvb943wXvTEZRUIYop9w
	 vbyRGUNCsGNcNQh0it/CpQ0OG+km+Pb+ipu+lt4U7B0pjZE7UAbUWDUT/8cNQnC3ol
	 Q9s0M5jbx6nQd0XRm8bKDkl5g5txdIQ/jE+Xf3sjQwbjW+6eNPTrhpJQkdi5rUE2Aw
	 0TuLx/coAVXVQ==
Message-ID: <4959c2c0-564a-4e3c-9650-228dede9a1f9@kernel.org>
Date: Wed, 22 Jan 2025 08:51:29 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/21] hwmon: Fix the type of 'config' in struct
 hwmon_channel_info to u64
To: "lihuisong (C)" <lihuisong@huawei.com>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org,
 netdev@vger.kernel.org, linux-rtc@vger.kernel.org, oss-drivers@corigine.com,
 linux-rdma@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linuxarm@huawei.com, linux@roeck-us.net, jdelvare@suse.com,
 kernel@maidavale.org, pauk.denis@gmail.com, james@equiv.tech,
 sudeep.holla@arm.com, cristian.marussi@arm.com, matt@ranostay.sg,
 mchehab@kernel.org, irusskikh@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 louis.peens@corigine.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 kabel@kernel.org, W_Armin@gmx.de, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, alexandre.belloni@bootlin.com,
 jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
 zhenglifeng1@huawei.com, liuyonglong@huawei.com
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <870c6b3e-d4f9-4722-934e-00e9ddb84e2e@kernel.org>
 <d42bf49b-e71b-d31e-2784-379076ebf370@huawei.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <d42bf49b-e71b-d31e-2784-379076ebf370@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/01/2025 09:14, lihuisong (C) wrote:
> 
> 在 2025/1/21 15:47, Krzysztof Kozlowski 写道:
>> On 21/01/2025 07:44, Huisong Li wrote:
>>> The hwmon_device_register() is deprecated. When I try to repace it with
>>> hwmon_device_register_with_info() for acpi_power_meter driver, I found that
>>> the power channel attribute in linux/hwmon.h have to extend and is more
>>> than 32 after this replacement.
>>>
>>> However, the maximum number of hwmon channel attributes is 32 which is
>>> limited by current hwmon codes. This is not good to add new channel
>>> attribute for some hwmon sensor type and support more channel attribute.
>>>
>>> This series are aimed to do this. And also make sure that acpi_power_meter
>>> driver can successfully replace the deprecated hwmon_device_register()
>>> later.
>> Avoid combining independent patches into one patch bomb. Or explain the
>> dependencies and how is it supposed to be merged - that's why you have
>> cover letter here.
> These patches having a title ('Use HWMON_CHANNEL_INFO macro to simplify 
> code') are also for this series.
> Or we need to modify the type of the 'xxx_config' array in these patches.
> If we directly use the macro HWMON_CHANNEL_INFO, the type of 'config' 
> has been modifyed in patch 1/21 and these driver don't need to care this 
> change.

None of above addresses my concern. I am dropping the series from my
inbox/to-review box.

Best regards,
Krzysztof

