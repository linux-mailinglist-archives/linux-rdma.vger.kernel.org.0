Return-Path: <linux-rdma+bounces-15390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4622D085CB
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 10:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62DD2302E33F
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E0C33506B;
	Fri,  9 Jan 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2x90MK0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46223BF9F;
	Fri,  9 Jan 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952507; cv=none; b=orHN2KNHya1a/rDYNYub9IbeVAB6HJmm6D0w5WOqOmAv0IfUrf42qZgJZDDPEeDN3qZDEfHXirOphfS+RfPyU69zBJidsVpz+XMJGfkSc2ReAcPO6pz4CSQMgB7WOjb3ZzTpvMJbI3wZ3vnnsZcKX4ajgRVZ62k0Y/x2UNWODm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952507; c=relaxed/simple;
	bh=IkP/SuZc1+HGIgfAujt+bjifZCCZ5ZU7yuwDHWYE8Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpGtyXaNXlOexS/ooQjfJpjBHa1kqZMo2VyVqMmsmXasQVPQ9KBgFNqwqiYOpT06UEvKSt0Uaxgm9Okg9zPon04AoXexTg1f34RG2gy5iQH6wO4oZrPlh5YxsfU2YQ+BnJjRBThX73+gtuWpj/FaW0PtNxjiLw2PpaRYwHO1wv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2x90MK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733D0C4CEF1;
	Fri,  9 Jan 2026 09:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767952507;
	bh=IkP/SuZc1+HGIgfAujt+bjifZCCZ5ZU7yuwDHWYE8Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2x90MK0EAhZ4PAprwB0+AyumDxUtdgTloJ+xSh5vPw0sT1j1J693MTOh5xuFExx3
	 upZKMBqEsOuYGvxG8IHrd2TWURcKuiIZSrxSd8ttBfdZg+DQhyuqdGBwoaTiBM/4nA
	 6jxM5+fxloGBhxQss83HRXT/+paQ76TAghTAjXeUzEpV7iC6LOm2m6Sf4ebbGFL9e0
	 Icjozkt6b9n/DCdcRmguLoAJy4vcgm5ZHWefXQiIb8lkU4xA29RofrsCSHUeHd5Exc
	 fwMKZVwioZzz7h/XOP9hYfEHgVdOA3eRdR0dedOg7hdMzVuebFAS9ZxzT7yKZAgpRD
	 nsGa3JxdJnusg==
Date: Fri, 9 Jan 2026 10:55:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: Re: [PATCH net-next 03/12] dpll: Add helpers to find DPLL pin fwnode
Message-ID: <20260109-cooperative-chinchilla-of-swiftness-aebbc8@quoll>
References: <20260108182318.20935-1-ivecera@redhat.com>
 <20260108182318.20935-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108182318.20935-4-ivecera@redhat.com>

On Thu, Jan 08, 2026 at 07:23:09PM +0100, Ivan Vecera wrote:
> Add helper functions to the DPLL core to retrieve a DPLL pin's firmware
> node handle based on the "dpll-pins" and "dpll-pin-names" properties.
> 
> * `fwnode_dpll_pin_node_get()`: matches the given name against the
>   "dpll-pin-names" property to find the correct index, then retrieves
>   the reference from "dpll-pins".
> * `device_dpll_pin_node_get()`: a wrapper around the fwnode helper for
>   convenience when using a `struct device`.
> 
> These helpers simplify the process for consumer drivers (such as Ethernet
> controllers or PHYs) to look up their associated DPLL pins defined in
> the DT or ACPI, which can then be passed to the DPLL subsystem to acquire
> the pin object.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/dpll/dpll_core.c | 20 ++++++++++++++++++++
>  include/linux/dpll.h     | 15 +++++++++++++++
>  2 files changed, 35 insertions(+)
> 

I don't see cells defined in your binding. Neither updated property.c.

Best regards,
Krzysztof


