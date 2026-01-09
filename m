Return-Path: <linux-rdma+bounces-15389-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA7FD08509
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 10:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D32AC3013BEA
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC78335097;
	Fri,  9 Jan 2026 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBLbo8yV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9449335076;
	Fri,  9 Jan 2026 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952140; cv=none; b=lFrEC4U79cMGVIyZz8nH30nYJauEUieN6BjGh7FDjR3b3bWP2/+YuOuAmUhljWf7TSJVYPTqA633AvH7x/uwAyz8MK99pl4yIGVsLcv9Zs/Z18878ExgO+Z7qWvKUCbj+EVUrip53+lInhgd7qEW793CNt8tgN/psohXXGVC30g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952140; c=relaxed/simple;
	bh=MIwSXM1zovhg5eHe8m4nTjGNEqVe+MTA5jK9Sla1M04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=carhiRAALAszxK07tbUvjrUF86ZApQaDSA6+e9oPynn1aZgTqR7l2vYL/7Olkd4M5f/xcQFdEM6jACzndKzkYLDi7w5pkg+ibhXhgI94PIJFVVnBU0NXMmviIKqeiFysGiPppmxp3XL/2F3oQYJCy7dovhOSue/Uv8ZO2JI2aAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBLbo8yV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3030C4CEF1;
	Fri,  9 Jan 2026 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767952139;
	bh=MIwSXM1zovhg5eHe8m4nTjGNEqVe+MTA5jK9Sla1M04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBLbo8yVVaeiwX3jIw0nuglrBWi1Qo1wwdQE7tlVUgeE90V97/GEkd6kcumCWToZy
	 8JOZ21uG5bpw505JprJUpum3eJq7r5XtYrvpjod+4v76/ObOXwO4JyOq/pVoH+HUFe
	 8CcQTrmCOwMim+omIJcvpgtn2VtNixN6BR2baV7DxMp1dBRoOo8Mw0ZUK6W11gkkaN
	 cELSLTHTV8JngEOScacTlJY1lV1RtJ4GbPJSA3Lr6q6QxpnzBKk3u0cUBqRyXnNMVr
	 qU4Rti7jY3eOLy9fyJQlilxQOj969N5dcewuBodz7fguQsRgINSw4OG8ryDTnrno69
	 L/D58F3AsLxew==
Date: Fri, 9 Jan 2026 10:48:57 +0100
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
Subject: Re: [PATCH net-next 01/12] dt-bindings: dpll: add common
 dpll-pin-consumer schema
Message-ID: <20260109-wonderful-acoustic-civet-e030da@quoll>
References: <20260108182318.20935-1-ivecera@redhat.com>
 <20260108182318.20935-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108182318.20935-2-ivecera@redhat.com>

On Thu, Jan 08, 2026 at 07:23:07PM +0100, Ivan Vecera wrote:
> Introduce a common schema for DPLL pin consumers. Devices such as Ethernet
> controllers and PHYs may require connections to DPLL pins for Synchronous
> Ethernet (SyncE) or other frequency synchronization tasks.
> 
> Defining these properties in a shared schema ensures consistency across
> different device types that consume DPLL resources.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  .../bindings/dpll/dpll-pin-consumer.yaml      | 30 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
> new file mode 100644
> index 0000000000000..60c184c18318a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dpll/dpll-pin-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DPLL Pin Consumer
> +
> +maintainers:
> +  - Ivan Vecera <ivecera@redhat.com>
> +

You miss select. Without it this binding is no-op.

> +description: |

Drop |


> +  Common properties for devices that require connection to DPLL (Digital Phase
> +  Locked Loop) pins for frequency synchronization (e.g. SyncE).
> +
> +properties:
> +  dpll-pins:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      List of phandles to the DPLL pin nodes connected to this device.
> +
> +  dpll-pin-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      Names for the DPLL pins defined in 'dpll-pins', in the same order.
> +
> +dependencies:
> +  dpll-pin-names: [ dpll-pins ]

Binding should go to dtschema. See also commit
3282a891060aace02e3eed4789739768060cea32 in dtschema or other examples
how to add new provider/consumer properties.


Best regards,
Krzysztof


