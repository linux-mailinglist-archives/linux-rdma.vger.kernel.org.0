Return-Path: <linux-rdma+bounces-15359-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E55CFEEEF
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 17:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6589434B381C
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A0F39A814;
	Wed,  7 Jan 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8rMdmFi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE85399A4B
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803055; cv=none; b=eGw2nCk89jZLpNitukrXDcFs6YjIlOzuu9bFJUgsAilrykHrGEzwR46VThGiGiaMrAD16Xqls0e437zgfXgkBgyokXXuYm2udSEVL9FjjfjvUt/nZYl0TWpzOONYy0kix4d1pYfICo5mZzZV38gp2YL2Z44E2K3jxez+eTxHpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803055; c=relaxed/simple;
	bh=U+4V9kZhIJ53Qp8akWz44aVV3ahWbnLCmQhJYp3f2m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQv3Myfld9Khy+pVtKLihx5w2HYmWxmWyTWJn20Y8IfEHEV3Hc7YbRJvHWK7JG30ABUk6JgihhuDBou7NzuwXcxVuO2JYzpBYySj3LGiHx8gRx5a58I+aNv2tK9PyG6TY7Oz8a9BoytORLokeESZGVhft8F+7f0oJRfgvcHlt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8rMdmFi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767803039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sN2vQaF8rLYlwVoaTYwGxcXdAruqPXep/xxEwK8q/D8=;
	b=J8rMdmFiKVsy5xa++slz1dqlaP/DcHv4Ta0hrS58e2+xJu16LJO4hwGka161NiGP0dIhlh
	27pnaefSp4QxW3m0PME4vb3pHnaYaB/V+xh8G41rNkIUg41WI1VShDTjxafZu+5wZwri8b
	C7RCVNmo5mCT3l2g1Cb4CjtfgH97/Ts=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-_cIzh2sSM7Kp46SHWjHbXQ-1; Wed,
 07 Jan 2026 11:23:55 -0500
X-MC-Unique: _cIzh2sSM7Kp46SHWjHbXQ-1
X-Mimecast-MFC-AGG-ID: _cIzh2sSM7Kp46SHWjHbXQ_1767803031
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C976519560B5;
	Wed,  7 Jan 2026 16:23:50 +0000 (UTC)
Received: from [10.44.32.248] (unknown [10.44.32.248])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E5C41956048;
	Wed,  7 Jan 2026 16:23:41 +0000 (UTC)
Message-ID: <66815c08-8408-4651-b039-d47925ae125e@redhat.com>
Date: Wed, 7 Jan 2026 17:23:40 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 01/13] dt-bindings: net: ethernet-controller:
 Add DPLL pin properties
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
 <5db81f5b-4f35-46e4-8fec-4298f1ac0c4e@redhat.com>
 <CAL_JsqJoybgJTAbSjGbTBxo-v=dbYY68tT309CV98=ohWhnC=w@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CAL_JsqJoybgJTAbSjGbTBxo-v=dbYY68tT309CV98=ohWhnC=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Rob,

On 1/7/26 4:15 PM, Rob Herring wrote:
> On Mon, Jan 5, 2026 at 10:24 AM Ivan Vecera <ivecera@redhat.com> wrote:
>>
>> On 12/17/25 1:49 AM, Rob Herring wrote:
>>> On Thu, Dec 11, 2025 at 08:56:52PM +0100, Andrew Lunn wrote:
>>>> On Thu, Dec 11, 2025 at 08:47:44PM +0100, Ivan Vecera wrote:
>>>>> Ethernet controllers may be connected to DPLL (Digital Phase Locked Loop)
>>>>> pins for frequency synchronization purposes, such as in Synchronous
>>>>> Ethernet (SyncE) configurations.
>>>>>
>>>>> Add 'dpll-pins' and 'dpll-pin-names' properties to the generic
>>>>> ethernet-controller schema. This allows describing the physical
>>>>> connections between the Ethernet controller and the DPLL subsystem pins
>>>>> in the Device Tree, enabling drivers to request and manage these
>>>>> resources.
>>>>
>>>> Please include a .dts patch in the series which actually makes use of
>>>> these new properties.
>>>
>>> Actually, first you need a device (i.e. a specific ethernet
>>> controller bindings) using this and defining the number of dpll-pins
>>> entries and the names.
>>
>> The goal of this patch is to define properties that allow referencing
>> dpll pins from other devices. I included it in this series to allow
>> implementing helpers that use the property names defined in the schema.
>>
>> This series implements the dpll pin consumer in the ice driver. This is
>> usually present on ACPI platforms, so the properties are stored in _DSD
>> ACPI nodes. Although I don't have a DT user right now, isn't it better
>> to define the schema now?
> 
> I have no idea what makes sense for ACPI and little interest in
> reviewing ACPI bindings. While I think the whole idea of shared
> bindings is questionable, really it's a question of review bandwidth
> and so far no one has stepped up to review ACPI bindings.

It depends... shared bindings allow drivers to read property values
without need to have separate OF and ACPI codepaths.

>> Thinking about this further, consumers could be either an Ethernet
>> controller (where the PHY is not exposed and is driven directly by the
>> NIC driver) or an Ethernet PHY.
>>
>> For the latter case (Ethernet PHY), I have been preparing a similar
>> implementation for the Micrel phy driver (lan8814) on the Microchip EDS2
>> board (pcb8385). Unfortunately, the DTS is not upstreamed yet [1], so I
>> cannot include the necessary bindings here.
>>
>> Since there can be multiple consumer types (Ethernet controller or PHY),
>> would it be better to define a dpll-pin-consumer.yaml schema instead
>> (similar to mux-consumer)?
> 
> The consumer type doesn't matter for that. What matters is you have
> specific device bindings and if they are consumers of some
> provider/consumer style binding, then typically each device binding
> has to define the constraints if there can be multiple
> entries/connections (e.g. how many interrupts, clocks, etc. and what
> each one is).
> 
> Hard to say what's needed for DPLL exactly because I know next to
> nothing about it.

The motivation is to describe the interconnection between an Ethernet
controller (or PHY) and a DPLL device. In SyncE scenarios, the NIC or
PHY provides a recovered clock output received from the physical port,
and the signal is routed to specific DPLL pin(s). The DPLL device then
locks onto this signal, filters jitter/wander, and provides a stable,
phase-aligned clock back to the NIC. When a NIC or PHY package supports
multiple Ethernet ports, it may allow selecting which port's recovered
clock signal is routed to the DPLL pin.

The goal of this entire series is to allow NIC drivers to register their
own pins (per port) on top of existing pins from the DPLL device. To do
so, it is necessary to know which DPLL device pin is connected to the
NIC's recovered clock output.

The NIC/PHY acts as a consumer of the DPLL pin(s) provided by the DPLL
device. As I mentioned in my previous email, I am working on the
implementation of this feature (recovered clock selection) for the
Micrel driver (a DT area user). If it is acceptable to you, I can omit
the first patch that introduces DT properties from this series and add
it to the series that will introduce the feature for the Micrel driver.

Thanks,
Ivan


