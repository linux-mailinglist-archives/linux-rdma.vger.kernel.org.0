Return-Path: <linux-rdma+bounces-15307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4F5CF4C34
	for <lists+linux-rdma@lfdr.de>; Mon, 05 Jan 2026 17:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 987B030F2BA4
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jan 2026 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E68E32E134;
	Mon,  5 Jan 2026 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbjlcouJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452B324B27
	for <linux-rdma@vger.kernel.org>; Mon,  5 Jan 2026 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630246; cv=none; b=rheVrlDifNX+X/38cyRnHaf6ez2PXwYKOwDjmBnz8qDw8mlilYWqceBD3RqZoWn7ZKUKDaY9s/5m6mcfUPjSJq2JbDuFK1N5N7bz6b6g11YkKtN8jvhLuoj1loNPiKE0/gQCMfgqsVxkUFwFfaKlAJ2acvbblRAHSlfnjFT7HTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630246; c=relaxed/simple;
	bh=41PDqGT/J89UTl4bu3bwe45Dw8kT1aCfLaGp+kS+sX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSn6N8BO5bovqAcY2Uwt1NljQ/hj7qsbOXXHSKmyrC06CPRHkxbr7TJamlNqhmmxx6tJ5jKKixokiBmS1nnyy3ctqr2kssmS8ZI5NDVFkY0q7pG46PTdXXzUt4qQm5NDHYSHRL81n0PAXlFPEypIgNKrwLqkoJbL7eOw4nRa9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbjlcouJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767630243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46dE8wQn1HVL0x3WTf36oZBc8LAD4VTY8ItMtpTUnY8=;
	b=fbjlcouJm3yQi7P7iMdlXD9Tc9fgxKSm9cszc0JiT7F5bmKgypTIkDuQtzX3VOudNSPjFX
	MwskC8zeHA74zvdqZybyvdUxjB6cQOfdvcMM8un37UEgTnU39/AKoKB3viEiT0woMkVIeK
	AFoK31aVOsf6OkYUrCCQOI2tiat1qEg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-qAfVWpaVPVmwinV2Ig6kOw-1; Mon,
 05 Jan 2026 11:24:00 -0500
X-MC-Unique: qAfVWpaVPVmwinV2Ig6kOw-1
X-Mimecast-MFC-AGG-ID: qAfVWpaVPVmwinV2Ig6kOw_1767630236
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C443F1956050;
	Mon,  5 Jan 2026 16:23:55 +0000 (UTC)
Received: from [10.44.32.50] (unknown [10.44.32.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 982321956048;
	Mon,  5 Jan 2026 16:23:44 +0000 (UTC)
Message-ID: <5db81f5b-4f35-46e4-8fec-4298f1ac0c4e@redhat.com>
Date: Mon, 5 Jan 2026 17:23:42 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 01/13] dt-bindings: net: ethernet-controller:
 Add DPLL pin properties
To: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 Petr Oros <poros@redhat.com>, Michal Schmidt <mschmidt@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 Horatiu Vultur <Horatiu.Vultur@microchip.com>
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-2-ivecera@redhat.com>
 <2de556f0-d7db-47f1-a59e-197f92f93d46@lunn.ch>
 <20251217004946.GA3445804-robh@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20251217004946.GA3445804-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 12/17/25 1:49 AM, Rob Herring wrote:
> On Thu, Dec 11, 2025 at 08:56:52PM +0100, Andrew Lunn wrote:
>> On Thu, Dec 11, 2025 at 08:47:44PM +0100, Ivan Vecera wrote:
>>> Ethernet controllers may be connected to DPLL (Digital Phase Locked Loop)
>>> pins for frequency synchronization purposes, such as in Synchronous
>>> Ethernet (SyncE) configurations.
>>>
>>> Add 'dpll-pins' and 'dpll-pin-names' properties to the generic
>>> ethernet-controller schema. This allows describing the physical
>>> connections between the Ethernet controller and the DPLL subsystem pins
>>> in the Device Tree, enabling drivers to request and manage these
>>> resources.
>>
>> Please include a .dts patch in the series which actually makes use of
>> these new properties.
> 
> Actually, first you need a device (i.e. a specific ethernet
> controller bindings) using this and defining the number of dpll-pins
> entries and the names.

The goal of this patch is to define properties that allow referencing
dpll pins from other devices. I included it in this series to allow
implementing helpers that use the property names defined in the schema.

This series implements the dpll pin consumer in the ice driver. This is
usually present on ACPI platforms, so the properties are stored in _DSD
ACPI nodes. Although I don't have a DT user right now, isn't it better
to define the schema now?

Thinking about this further, consumers could be either an Ethernet
controller (where the PHY is not exposed and is driven directly by the
NIC driver) or an Ethernet PHY.

For the latter case (Ethernet PHY), I have been preparing a similar
implementation for the Micrel phy driver (lan8814) on the Microchip EDS2
board (pcb8385). Unfortunately, the DTS is not upstreamed yet [1], so I
cannot include the necessary bindings here.

Since there can be multiple consumer types (Ethernet controller or PHY),
would it be better to define a dpll-pin-consumer.yaml schema instead
(similar to mux-consumer)?

Thanks for the advice,
Ivan

[1] 
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=1031294&state=*


