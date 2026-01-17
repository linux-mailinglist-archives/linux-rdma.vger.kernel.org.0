Return-Path: <linux-rdma+bounces-15660-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D761D3905C
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Jan 2026 19:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17CA6302B104
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Jan 2026 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB0A2D7814;
	Sat, 17 Jan 2026 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4H4/Euf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595529993F
	for <linux-rdma@vger.kernel.org>; Sat, 17 Jan 2026 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768674129; cv=none; b=V1Gqk5eNA5LYTraA+4EF1N/1WgLULzNdLHCMzGZBNM2LJyTCCen3dMP5Ar2+GRyH9PvYV6qfb1KtDm4CJWORDp+HHYHR1db6PrI4fw4+KNuWCPy0IKxVW51RZPKDFSTb6BQ4fHCkk6g9bQ2lDrI+CP7FRA8orWL5SjUHYReJta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768674129; c=relaxed/simple;
	bh=JnM8CbNRefHft1AycEX+JI6KttGYEDyvHeicK3qvoOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sR7Q97j1wp5BnMKV6fbYWpudEQLgLwKNZhy90M4SaGz3kiZYhGTQ7ufgpzRBRRIutgGPYkI2IOygMRNNIaRsDaqWolP48FwnEbhDhH94l313u54umNrMkTHa3KhLppp8Lcbocrl8M5AAksjWdtEKP6bSOVidnUdaFjXnTQVyuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4H4/Euf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768674125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1XwfyBOA2rxjy0dGHmw0NBN5mZlkaFY9bVx7FsHrVU=;
	b=i4H4/Euff8APNJUzYmex79Pa2CpFE4CHHPMM59ZMlk4g0q9t29MFF88Fc4FauaUDm2Jv6q
	fDvYftVZ44wrKZBeK5lTuUm4f9HVRC4IUO1zoj8/2qBnNY6PWS5QylX70CbNk1DRWbL/T4
	t21hj/8W6Tu3RtfTcqouBvUasQDIksA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-hgAFbccKNUaAQkdMGGmumA-1; Sat,
 17 Jan 2026 13:22:02 -0500
X-MC-Unique: hgAFbccKNUaAQkdMGGmumA-1
X-Mimecast-MFC-AGG-ID: hgAFbccKNUaAQkdMGGmumA_1768674118
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 029F21956094;
	Sat, 17 Jan 2026 18:21:58 +0000 (UTC)
Received: from [10.44.32.32] (unknown [10.44.32.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48F9518001D5;
	Sat, 17 Jan 2026 18:21:50 +0000 (UTC)
Message-ID: <45be7c3e-bd87-4448-aff1-d91794099391@redhat.com>
Date: Sat, 17 Jan 2026 19:21:48 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] dt-bindings: dpll: add common
 dpll-pin-consumer schema
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
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
 <92bfc390-d706-4988-b98d-841a50f10834@redhat.com>
 <CAL_Jsq+m7-wop-AU-7R-=2JsUqb+2LsVTXCbZw==1XuAAQ4Tkg@mail.gmail.com>
 <a5dad0f9-001c-468f-99bc-e24c23bc9b36@redhat.com>
 <CAL_JsqJhqp-cgj604eEgxD47gJci0d3CFYf1wC_t1c00OptTiQ@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CAL_JsqJhqp-cgj604eEgxD47gJci0d3CFYf1wC_t1c00OptTiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 1/17/26 12:39 AM, Rob Herring wrote:
> On Fri, Jan 16, 2026 at 1:00 PM Ivan Vecera <ivecera@redhat.com> wrote:
>>
>> On 1/16/26 4:23 PM, Rob Herring wrote:
>>> On Thu, Jan 15, 2026 at 6:02 AM Ivan Vecera <ivecera@redhat.com> wrote:
>>>>
>>>> On 1/8/26 7:23 PM, Ivan Vecera wrote:
>>>>> Introduce a common schema for DPLL pin consumers. Devices such as Ethernet
>>>>> controllers and PHYs may require connections to DPLL pins for Synchronous
>>>>> Ethernet (SyncE) or other frequency synchronization tasks.
>>>>>
>>>>> Defining these properties in a shared schema ensures consistency across
>>>>> different device types that consume DPLL resources.
>>>>>
>>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>>> ---
>>>>>     .../bindings/dpll/dpll-pin-consumer.yaml      | 30 +++++++++++++++++++
>>>>>     MAINTAINERS                                   |  1 +
>>>>>     2 files changed, 31 insertions(+)
>>>>>     create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
>>>>> new file mode 100644
>>>>> index 0000000000000..60c184c18318a
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
>>>>> @@ -0,0 +1,30 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/dpll/dpll-pin-consumer.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: DPLL Pin Consumer
>>>>> +
>>>>> +maintainers:
>>>>> +  - Ivan Vecera <ivecera@redhat.com>
>>>>> +
>>>>> +description: |
>>>>> +  Common properties for devices that require connection to DPLL (Digital Phase
>>>>> +  Locked Loop) pins for frequency synchronization (e.g. SyncE).
>>>>> +
>>>>> +properties:
>>>>> +  dpll-pins:
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>> +    description:
>>>>> +      List of phandles to the DPLL pin nodes connected to this device.
>>>>> +
>>>>> +  dpll-pin-names:
>>>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>>>> +    description:
>>>>> +      Names for the DPLL pins defined in 'dpll-pins', in the same order.
>>>>> +
>>>>> +dependencies:
>>>>> +  dpll-pin-names: [ dpll-pins ]
>>>>> +
>>>>> +additionalProperties: true
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 765ad2daa2183..f6f58dfb20931 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -7648,6 +7648,7 @@ M:      Jiri Pirko <jiri@resnulli.us>
>>>>>     L:  netdev@vger.kernel.org
>>>>>     S:  Supported
>>>>>     F:  Documentation/devicetree/bindings/dpll/dpll-device.yaml
>>>>> +F:   Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
>>>>>     F:  Documentation/devicetree/bindings/dpll/dpll-pin.yaml
>>>>>     F:  Documentation/driver-api/dpll.rst
>>>>>     F:  drivers/dpll/
>>>>
>>>> Based on private discussion with Andrew Lunn (thanks a lot), this is
>>>> wrong approach. Referencing directly dpll-pin nodes and using their
>>>> phandles in consumers is at least unusual.
>>>>
>>>> The right approach should be referencing dpll-device and use cells
>>>> to specify the dpll pin that is used.
>>>
>>> You only need a cells property if you expect the number of cells to
>>> vary by provider.
>>>
>>> However, the DPLL device just appears to be a clock provider and
>>> consumer, so why not just use the clock binding here? Also, there is
>>> no rule that using foo binding means you have to use foo subsystem in
>>> the kernel.
>>
>> Hmm, do you mean something like this example?
>>
>> &dpll0 {
>>       ...
>>       #clock-cells = <2>; /* 1st pin index, 2nd pin type (input/output) */
>>
>>       input-pins {
>>           pin@2 {
>>               reg = <2>;
>>               ...
>>           };
>>           pin@4 {
>>               reg = <4>;
>>               ...
>>           };
>>       };
>>       output-pins {
>>           pin@3 {
>>               reg = <3>;
>>           };
>>       };
>> };
>> &phy0 {
>>       ...
>>       clock-names = "rclk0", "rclk1", "synce_ref";
>>       clocks = <&dpll0 2 DPLL_INPUT>,
>>                <&dpll0 4 DPLL_INPUT>,
>>                <&dpll0 3 DPLL_OUTPUT>;
>>       ...
>> };
> 
> No, clock providers are always the clock outputs, and clock consumers
> are the clock inputs. So something like this:
> 
> &dpll0 {
>       ...
>       #clock-cells = <1>; /* 1st pin index */
> 
>       // clocks index corresponds to input pins on dpll0 */
>       clocks = <&phy0 0>, <&phy0 1>, <&phy1 0>, <&phy1 1>
> };
> &phy0 {
>       ...
>       #clock-cells = <1>;
>       clocks = <&dpll0 3>;
>       ...
> };

Fully understand now... will modify the patch-set accordingly.
Thanks for the advises.

Ivan


