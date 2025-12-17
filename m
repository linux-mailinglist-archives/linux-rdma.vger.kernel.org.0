Return-Path: <linux-rdma+bounces-15040-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D634ACC5A33
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 01:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78F1F30036F5
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 00:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00E921CC68;
	Wed, 17 Dec 2025 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMwTSgad"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A30F1F0E29;
	Wed, 17 Dec 2025 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765932589; cv=none; b=LePYsgYPL2xzJnTsUTtk4nRhgqSkKMPIJVsXonM+68m4f2NC8nKD8TkjPso037fGvq7fbrD9NyfspvH429RxfkQsVDC/6CXxBjl8Z0dxe6gPY+h225HN0b0ap7JNc6DSLIcSm5InM/qcqW2pC46rA8sHBFha3z/ZgP9bBQs85fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765932589; c=relaxed/simple;
	bh=DNExHzFtlzkFnn3/GNMoj9gWvQBHtxOQZpew5LKKPUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWG9ojJS/4nm7UyqoFL9xhXe3ttk1NiBUqE0TXIzN7K5dOPzGHL/n511Q+jD/jgSBT7+2uyoDnjSyrTg3xN3YRyB2pEVFlzMXZRSXXBGVTG8Xn+dQuYgU9ZHtJnx9CfHUe0csPaXm0lB3A035KX3y4Cbb3FljQyDVd1d2evlNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMwTSgad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8108C4CEF1;
	Wed, 17 Dec 2025 00:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765932589;
	bh=DNExHzFtlzkFnn3/GNMoj9gWvQBHtxOQZpew5LKKPUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMwTSgadUHirIxyUBx2QnuZKJJ5FL5lg7rrvoDS6JUpWfwRhO5E94tsjMZPV79W6l
	 QIRhp1Cfw20qrRxdORrEJQmh9MKnyAAeoliIFDzJ+Tik/OguMSdckpu9mtS13TUsoS
	 kPtAS4XghFPE+c9YZGkq9TLuDeLCyibKkCdYIngpeAIztsxiEVORzspMqQK+xV66e5
	 KBfLrP1pB+0hVYtfgoT9oJUHy2pKUkgLNwAevg8lzAUbb4eeqKirhvM8SU8kcYcBU6
	 ig+05Kia3Evtel6azROtQiaPP9njbQOoZVOG6tTX6kQbSiGW5VVzQlie4CLxhr6Qg2
	 kUWJOBj9DuwBw==
Date: Tue, 16 Dec 2025 18:49:46 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <20251217004946.GA3445804-robh@kernel.org>
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-2-ivecera@redhat.com>
 <2de556f0-d7db-47f1-a59e-197f92f93d46@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de556f0-d7db-47f1-a59e-197f92f93d46@lunn.ch>

On Thu, Dec 11, 2025 at 08:56:52PM +0100, Andrew Lunn wrote:
> On Thu, Dec 11, 2025 at 08:47:44PM +0100, Ivan Vecera wrote:
> > Ethernet controllers may be connected to DPLL (Digital Phase Locked Loop)
> > pins for frequency synchronization purposes, such as in Synchronous
> > Ethernet (SyncE) configurations.
> > 
> > Add 'dpll-pins' and 'dpll-pin-names' properties to the generic
> > ethernet-controller schema. This allows describing the physical
> > connections between the Ethernet controller and the DPLL subsystem pins
> > in the Device Tree, enabling drivers to request and manage these
> > resources.
> 
> Please include a .dts patch in the series which actually makes use of
> these new properties.

Actually, first you need a device (i.e. a specific ethernet 
controller bindings) using this and defining the number of dpll-pins 
entries and the names. 

Rob

