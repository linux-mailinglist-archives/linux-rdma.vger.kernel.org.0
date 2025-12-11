Return-Path: <linux-rdma+bounces-14975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FD5CB71CE
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 21:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 110C430393C1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4EA31AA9E;
	Thu, 11 Dec 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i7Qp0ceJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871D314D2B;
	Thu, 11 Dec 2025 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765483043; cv=none; b=FJk0H5w9/kYjo/X28QcblSR3eaFWXTVMmSULoHSH6DBm3mozmUQ5yEDZBcdUYwU6XgJ7QEs20pZcDG0XHDVQvO8QYoZKTaDx7IydAOfDVPgVGWxcKj7yoOHOmZKslaq5tfDFfS4Ksp38hQ0jvg8JNwFwNQLbZhH5VyIfJqcU2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765483043; c=relaxed/simple;
	bh=2zPUdaMCrtIj668myNZ+Nbc5FdMCx+hekduQa59mElQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/gnStLQHLifrJsKcvxxhDy9LPfxubTHruLu0bG9MeXmoDbWij2onaS/eCy4k9BX85SB/xHWYQCX4FC5KF2eh5zh3TvJXvqnOEGWHNEoHt1ZYCAKeGWBr1jvs+IcuBWuYhPQf3GeO2sAMnvZoa5LDoiVzd8lBrd6EegD9kNlEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i7Qp0ceJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=owhNvb4BmlJlqJlDYQvQvwlr0ivxIOfTUUdM9/4+rQM=; b=i7Qp0ceJdAJQniU1oAQZ2ziaWY
	/9miFVeSUnvCNeDVJB/0egU/rrhzjvqhGrQZuLqhojFepglZJoBq+Ees43SbR60fuyLoqg/qPMqz5
	+bih+o6neGABIFBASpxL67XtScpm0bEL+d9yrg2G0XpCt+CA/vVnxSY9omYavlfZbcc4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vTmmS-00GfyF-J7; Thu, 11 Dec 2025 20:56:52 +0100
Date: Thu, 11 Dec 2025 20:56:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC net-next 01/13] dt-bindings: net:
 ethernet-controller: Add DPLL pin properties
Message-ID: <2de556f0-d7db-47f1-a59e-197f92f93d46@lunn.ch>
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211194756.234043-2-ivecera@redhat.com>

On Thu, Dec 11, 2025 at 08:47:44PM +0100, Ivan Vecera wrote:
> Ethernet controllers may be connected to DPLL (Digital Phase Locked Loop)
> pins for frequency synchronization purposes, such as in Synchronous
> Ethernet (SyncE) configurations.
> 
> Add 'dpll-pins' and 'dpll-pin-names' properties to the generic
> ethernet-controller schema. This allows describing the physical
> connections between the Ethernet controller and the DPLL subsystem pins
> in the Device Tree, enabling drivers to request and manage these
> resources.

Please include a .dts patch in the series which actually makes use of
these new properties.

	Andrew

