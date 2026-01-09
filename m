Return-Path: <linux-rdma+bounces-15404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D420D0A953
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 15:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4769307D803
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 14:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF135CBDC;
	Fri,  9 Jan 2026 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmjZ2ynY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75935E524
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967940; cv=none; b=j/TCAMkJWBZYAgs5xz2DHfSgZIqyS0asU3s5xkpvlc/7Zgs/Ml9khGc6imr+W3eugZfyQG2J11sooyqEzoXqJ35+ebog6w3XDeq3NK2yf8YOvHOkCcxsQ4E8jSmVmYrJoOReqweVkHa70HAyGRneZ82CLDKg33YgihAexsXVRuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967940; c=relaxed/simple;
	bh=653xgRhAmWITmeXWF3vggllg1g3sfZR8tHQrhqWfIU4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MuyGLAIkVdVm7DLXGmeJ9jaQMXLQKIwofxUn9UqU7qfOEhV8MjnCMM/I/9digsF40vpZRTKkAvGeZTNnnbqnkBUGXtHXWXQ67MKW06AfU3mBUUTwXgCdqBkv4S055+bTr4wNqHM+h0CMuX2hJVDFiUYvOjlCyXXqg4PeQMmA6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmjZ2ynY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767967937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcr1hWAXxXMTm+MOI2pLQIo/wtCHSaw2hi1H8FmkX8c=;
	b=KmjZ2ynYShcgjzjjfmGZ9KuezdGqqRwks3w+LXz61Ogi6lQPukOc21rSMLP2IKWq8mWaXB
	bnuJqoeM7NudSEWqhfxagbnK+Ben13c96nACdf6vfwyTJHr1oIxEil1mvN9OGiH0oeLJVg
	SAbCUCWwKJEncxkamujGygiHSzdirAE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-wRIAoh3BOniKE_S44Jwm1g-1; Fri,
 09 Jan 2026 09:12:11 -0500
X-MC-Unique: wRIAoh3BOniKE_S44Jwm1g-1
X-Mimecast-MFC-AGG-ID: wRIAoh3BOniKE_S44Jwm1g_1767967928
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D95E31956058;
	Fri,  9 Jan 2026 14:12:07 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11B1030002D2;
	Fri,  9 Jan 2026 14:12:00 +0000 (UTC)
Message-ID: <fd07e1f8-455c-464f-9760-9d16d450a7d5@redhat.com>
Date: Fri, 9 Jan 2026 15:11:59 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 01/12] dt-bindings: dpll: add
 common dpll-pin-consumer schema
From: Ivan Vecera <ivecera@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Rob Herring <robh@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-rdma@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Richard Cochran <richardcochran@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
References: <20260108182318.20935-1-ivecera@redhat.com>
 <20260108182318.20935-2-ivecera@redhat.com>
 <20260109-wonderful-acoustic-civet-e030da@quoll>
 <a581a86d-d49c-4761-bd68-989a7a12cb56@redhat.com>
Content-Language: en-US
In-Reply-To: <a581a86d-d49c-4761-bd68-989a7a12cb56@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 1/9/26 11:22 AM, Ivan Vecera wrote:
> 
> 
> On 1/9/26 10:48 AM, Krzysztof Kozlowski wrote:
>> On Thu, Jan 08, 2026 at 07:23:07PM +0100, Ivan Vecera wrote:
>>> Introduce a common schema for DPLL pin consumers. Devices such as 
>>> Ethernet
>>> controllers and PHYs may require connections to DPLL pins for 
>>> Synchronous
>>> Ethernet (SyncE) or other frequency synchronization tasks.
>>>
>>> Defining these properties in a shared schema ensures consistency across
>>> different device types that consume DPLL resources.
>>>
>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>> ---
>>>   .../bindings/dpll/dpll-pin-consumer.yaml      | 30 +++++++++++++++++++
>>>   MAINTAINERS                                   |  1 +
>>>   2 files changed, 31 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin- 
>>> consumer.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin- 
>>> consumer.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin- 
>>> consumer.yaml
>>> new file mode 100644
>>> index 0000000000000..60c184c18318a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
>>> @@ -0,0 +1,30 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/dpll/dpll-pin-consumer.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: DPLL Pin Consumer
>>> +
>>> +maintainers:
>>> +  - Ivan Vecera <ivecera@redhat.com>
>>> +
>>
>> You miss select. Without it this binding is no-op.
> 
> Will fix.
> 
>>> +description: |
>>
>> Drop |
> 
> Will do.
> 
>>> +  Common properties for devices that require connection to DPLL 
>>> (Digital Phase
>>> +  Locked Loop) pins for frequency synchronization (e.g. SyncE).
>>> +
>>> +properties:
>>> +  dpll-pins:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description:
>>> +      List of phandles to the DPLL pin nodes connected to this device.
>>> +
>>> +  dpll-pin-names:
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>> +    description:
>>> +      Names for the DPLL pins defined in 'dpll-pins', in the same 
>>> order.
>>> +
>>> +dependencies:
>>> +  dpll-pin-names: [ dpll-pins ]
>>
>> Binding should go to dtschema. See also commit
>> 3282a891060aace02e3eed4789739768060cea32 in dtschema or other examples
>> how to add new provider/consumer properties.

Quick questions... if the dpll pin consumer properties schema should go
to dtschema...

1) Should I remove this patch from this series? So this schema won't be
    a part of kernel
2) dtschema does not contain dpll-device and dpll-pin schemas now, I
    expect they should be added as well... or? I'm asking because there
    is also e.g. hwlock-consumer.yaml in dtschema but no hwlock

Thanks,
Ivan

> Will do.
> 
> Thanks for advice...
> 
> Ivan
> 


