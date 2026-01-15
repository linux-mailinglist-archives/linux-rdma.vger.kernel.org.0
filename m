Return-Path: <linux-rdma+bounces-15583-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE4D245E4
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 13:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D2A93075C04
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF1F357A31;
	Thu, 15 Jan 2026 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyU40Rho"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038311CBA
	for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478525; cv=none; b=MJdb5BcYkC9l3j1p9vb7Quj5e/CqpkL1vvZn107YNRmlYUUiFkSbptLaObtWoY1zk7qqvB683LC924ho6PrjHFli0GETzNvpgHargc1Kh8AsguBy8CH0zASagA9nCESBW2NrwLNPjdYp4rxTbfa+dtJeyHMMasNAYmPUP3DlGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478525; c=relaxed/simple;
	bh=RgSCItvIzITjg76iDqAPErZBX5BArJAS6aQlRSuCTf8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m1noNyLEw2AyVeIO32MJUY8+qs+/2Tp+jG7UW4+sIwVFiJ1hVMWeMJXQ6vx5WgzZxuWBtPR1pSYejZviiQmy2UNBRErCVok3KxAsz3FfWwn381zRCk4s4eaNB2iTTXXmKFsr21pl1uo8HTvV0ldHeygyQUCmydepjjuUeapZkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyU40Rho; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768478522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4t6OWwNa16OqY64IWC39VX/QLXVgOz/FT6ehthBksPk=;
	b=WyU40RhoVkVJQJVbWwR0QGbGnqdP5JgVnFd4r2MKnqrosUX6GrG4LE9o2uSqpXqeSc773c
	cy/S/aagm5QG4iiU8UzDStmliamFJ+Z0KCbe2x62eN9+KcHI8514EnhzkuvYOAnlH2A9wS
	HeggnT/S9prr//tbDDyim5dbQXJxk0g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-uI448jlmOA-U__5D4zdMPg-1; Thu,
 15 Jan 2026 07:01:56 -0500
X-MC-Unique: uI448jlmOA-U__5D4zdMPg-1
X-Mimecast-MFC-AGG-ID: uI448jlmOA-U__5D4zdMPg_1768478513
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E6D319560B2;
	Thu, 15 Jan 2026 12:01:52 +0000 (UTC)
Received: from [10.44.32.221] (unknown [10.44.32.221])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 38B0618001D5;
	Thu, 15 Jan 2026 12:01:44 +0000 (UTC)
Message-ID: <92bfc390-d706-4988-b98d-841a50f10834@redhat.com>
Date: Thu, 15 Jan 2026 13:01:42 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] dt-bindings: dpll: add common
 dpll-pin-consumer schema
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>
References: <20260108182318.20935-1-ivecera@redhat.com>
 <20260108182318.20935-2-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260108182318.20935-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 1/8/26 7:23 PM, Ivan Vecera wrote:
> Introduce a common schema for DPLL pin consumers. Devices such as Ethernet
> controllers and PHYs may require connections to DPLL pins for Synchronous
> Ethernet (SyncE) or other frequency synchronization tasks.
> 
> Defining these properties in a shared schema ensures consistency across
> different device types that consume DPLL resources.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   .../bindings/dpll/dpll-pin-consumer.yaml      | 30 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 31 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
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
> +description: |
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
> +
> +additionalProperties: true
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 765ad2daa2183..f6f58dfb20931 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7648,6 +7648,7 @@ M:	Jiri Pirko <jiri@resnulli.us>
>   L:	netdev@vger.kernel.org
>   S:	Supported
>   F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
> +F:	Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
>   F:	Documentation/devicetree/bindings/dpll/dpll-pin.yaml
>   F:	Documentation/driver-api/dpll.rst
>   F:	drivers/dpll/

Based on private discussion with Andrew Lunn (thanks a lot), this is
wrong approach. Referencing directly dpll-pin nodes and using their
phandles in consumers is at least unusual.

The right approach should be referencing dpll-device and use cells
to specify the dpll pin that is used.

Also Krzysztof mentioned there are missing update of supplier_bindings
in drivers/of/property.c to ensure that proper dev_links between
producer and consumer are created.

I will send a v2 of this patch-set with addressed another issues found
by patchwork bot and including the DT schema (this patch) to review
if it is ok.

Thanks,
Ivan


