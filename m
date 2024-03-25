Return-Path: <linux-rdma+bounces-1557-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E955288B655
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 01:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1207B2897E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 23:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AE682D63;
	Mon, 25 Mar 2024 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miVONJQ5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33918174F;
	Mon, 25 Mar 2024 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407987; cv=none; b=Z29K7eEwFD8D9Ohg3BbTwPi3/uonv1sd4VSpiOX0NiG+X2J5cC5E2pTG3FS04dqsrvjD9TEsy4aALd/UAQZmy/4UOWM7LX2QUQi1vWaFK2EFl1oiP816I30FVOk1K1N7YaL8bcb4Ic60ipXATPmKPZkh/QKgeURO/KrkAOBSDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407987; c=relaxed/simple;
	bh=1QyVL22FJBxcb4t1+dh5JP6zFPMFsBApFX/CuykGQcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRMHVPKE1Fd9LSqmSwz8I1rSNnJkX4Wy6WS6K2IDieW1JHO8u/bvy5Zm+5hGyQGE9PP93o/8FqhNcJvlJbFPDmOqumSRoR3PEyq/YDPQHzLxq2hfalYGx5Su+DUMiG6Z9Txgs9OZmct7yg8oTNh/02gudtTvlu6UgUAM7UML6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miVONJQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81ECC433F1;
	Mon, 25 Mar 2024 23:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711407987;
	bh=1QyVL22FJBxcb4t1+dh5JP6zFPMFsBApFX/CuykGQcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=miVONJQ5NXRsG7mtEQGjb5OCHUFlD7yIcjL8Zczot8iH1PlPuzLpzXUWN779YGM8y
	 sdRSypBm9jXhiqw1IzSFooBJQq5k1wtRXrJIOTx4xbzUnA1RJeHfwPvxzQkJwqjAA2
	 N6YIqez7RTTZpmbSlWcSMzhmaSXkYG9rvLI4m7dYZcw7TieXzKum/7A5nU+P13vC61
	 T1cLGk10rXaP0S8Iok04wj1ZA1e/YPTPkHaE8qnOaUkw/8fA7OGzdEbCdysSpVND4U
	 Gsl75wBe1MjtRVXYky/7xx56/oe9JwwwMEAsu3NP0isHTJVisTQU7YEP34h3oAU2oc
	 dvb52RefFwqtw==
Message-ID: <ea5a0baa-64f3-40f8-a775-433eeb0b430e@kernel.org>
Date: Tue, 26 Mar 2024 08:06:22 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/28] Remove PCI_IRQ_LEGACY
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
 Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240325175941.GA1443646@bhelgaas>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240325175941.GA1443646@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/24 02:59, Bjorn Helgaas wrote:
> I applied all these to pci/enumeration for v6.10, thanks!
> 
> I added acks and reviewed-by and will update if we receive more, and
> adjusted subject lines to add "... instead of PCI_IRQ_LEGACY" and in
> some cases to match history of the file.

Thanks Bjorn !

-- 
Damien Le Moal
Western Digital Research


