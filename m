Return-Path: <linux-rdma+bounces-3329-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC2290F1FB
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94C12817A3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4D213AA40;
	Wed, 19 Jun 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+SfKNmB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1AD1411D7;
	Wed, 19 Jun 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810466; cv=none; b=u0zs3Qncz21cswmbHpAjfNrP67KCEh8kUyHtg0J19uqdBbp+bcukyxozL21bZ/WfGnnIEZ7aXtegarksA6v0QRqT5i5QY02BIatGUScYO23Es+EUEvNLWkqHACNAmpyrYBD6Xzr9d+SxiBu6Nzy1L/e+Vz1T3GCyFB4rRYGGOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810466; c=relaxed/simple;
	bh=KhSfJ4C9g703OX8e3GlopxaArmHVXCI9LGJLDMc19B4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRPb3GVBbLI8ZJ2douMoGKUyrr5V4jRtrouimW0V8Mv5tO0o8m7laNQkkoUcbNV8IQqVaQllMiqY2F9Rwp2zMdrdN9Nv7pReI17sF32qMaLHKnrgLXZk7f6Zm4KUbpdSmJM26G120tpCflxGTRlXikt/rQc/wpk9hEE9j8zGwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+SfKNmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7CEC2BBFC;
	Wed, 19 Jun 2024 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718810465;
	bh=KhSfJ4C9g703OX8e3GlopxaArmHVXCI9LGJLDMc19B4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E+SfKNmBu9nRoqGbUEf6dgIZyKMfBu//1hY/rxaUmxvRJ4IyHJkGKtOAk+3P540rs
	 8UZWiYT1W8n527IPRo44/wMcgdHoueDlWOE8ZC+v1haXC2YHtdRYBi2ob7xHOhwrPv
	 hv/MarYsZVzzsAtLruZZXeeRofecye4DIlYB7t9jlKbynl9Z4KKxxs755w91Ndr2DP
	 NC7uGz+khxLPRa6hqN8D23ISJNEZbHYNIP/wv1yl73rWmYttZajya8qqz9mWyYLyOJ
	 aym/OlPx/r2ORCx//hxgw8dhYjGEPp1MY9vAdBtJ3p5GaOANTsvj1KCceeB894jxvz
	 4VwS1vCKGuOVQ==
Date: Wed, 19 Jun 2024 08:21:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Andrew Lunn <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "ogabbay@kernel.org"
 <ogabbay@kernel.org>, Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <20240619082104.2dcdcd86@kernel.org>
In-Reply-To: <45e35940-c8fc-4f6c-8429-e6681a48b889@habana.ai>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
	<20240613082208.1439968-10-oshpigelman@habana.ai>
	<10902044-fb02-4328-bf88-0b386ee51c78@lunn.ch>
	<bddb69c3-511b-4385-a67d-903e910a8b51@habana.ai>
	<621d4891-36d7-48c6-bdd8-2f3ca06a23f6@lunn.ch>
	<45e35940-c8fc-4f6c-8429-e6681a48b889@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 07:16:20 +0000 Omer Shpigelman wrote:
> >> Are you referring to get_module_eeprom_by_page()? if so, then it is not
> >> supported by our FW, we read the entire data on device load.
> >> However, I can hide that behind the new API and return only the
> >> requested page if that's the intention.  
> > 
> > Well, if your firmware is so limited, then you might as well stick to
> > the old API, and let the core do the conversion to the legacy
> > code. But i'm surprised you don't allow access to the temperature
> > sensors, received signal strength, voltages etc, which could be
> > exported via HWMON.
> 
> I'll stick to the old API.
> Regaring the sensors, our compute driver (under accel/habanalabs) exports
> them via HWMON.

You support 400G, you really need to give the user the ability
to access higher pages.

