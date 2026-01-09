Return-Path: <linux-rdma+bounces-15408-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9ED0B2CE
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 17:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 570D03119494
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0D5363C6F;
	Fri,  9 Jan 2026 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s/BekWOL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C891D363C5B
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975162; cv=none; b=r11VoOZL3bEsg2Y5yY//Xx/yBwnvSzotDlVRHtJtvNK67fTfrh03atEJnl1N7mBnCCSopkOra5NQLr09GesmpdbSONt5n/eBIJx1xQQtSlSAxVomg73hZuApkcBbEgayyMEEvBZwXCKzF0k7ASAZaMWMEf6r2BUKLJJONawGvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975162; c=relaxed/simple;
	bh=oBV9OHBf0Dq3/ev8OmQYEkjsWG4QQ65vMOuv6xZEzU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuRcPEFPLWCAdBfaYg0QtRYwHnBBmNEkK3+2QaB0jNh81dyYnFRQ8IKny1B6hOde/r2ZAsGYeyaSBs9YCp5EP7ZsortSdrHpIEP95s1U5dquVHuylADcbM6dOfho1+NY6Qd1wsQ2IpoDslC+A+UcBisYEMhwpVLa77Sr/IWGKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s/BekWOL; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <67ec1ef6-4148-42d8-a37d-56d089c6d686@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767975143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKUbx/Z1+Yt4q5NGapHD0PxmcD1lDzWGnEJYNLdw6QA=;
	b=s/BekWOLdsRBW/H9lUmDHMUGOMrh2PKQQVgUaBpcXEL5ebGzElBvaFnimjXKayq52OS5sv
	+0dQUR6T0rVlTxwJayh7VGLyCf1VwJ3mrXrfjwv6xe9Go/ZpGuMtNE4eV1NTO9ESXTXrO6
	cbJApz2ahZld+6YGW+MxdytZ4tGZCw0=
Date: Fri, 9 Jan 2026 16:12:18 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 05/12] dpll: Add notifier chain for dpll events
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>
References: <20260108182318.20935-1-ivecera@redhat.com>
 <20260108182318.20935-6-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260108182318.20935-6-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/01/2026 18:23, Ivan Vecera wrote:
> From: Petr Oros <poros@redhat.com>
> 
> Currently, the DPLL subsystem reports events (creation, deletion, changes)
> to userspace via Netlink. However, there is no mechanism for other kernel
> components to be notified of these events directly.
> 
> Add a raw notifier chain to the DPLL core protected by dpll_lock. This
> allows other kernel subsystems or drivers to register callbacks and
> receive notifications when DPLL devices or pins are created, deleted,
> or modified.
> 
> Define the following:
> - Registration helpers: {,un}register_dpll_notifier()
> - Event types: DPLL_DEVICE_CREATED, DPLL_PIN_CREATED, etc.
> - Context structures: dpll_{device,pin}_notifier_info  to pass relevant
>    data to the listeners.
> 
> The notification chain is invoked alongside the existing Netlink event
> generation to ensure in-kernel listeners are kept in sync with the
> subsystem state.
> 
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Petr Oros <poros@redhat.com>

LGTM, Thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

