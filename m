Return-Path: <linux-rdma+bounces-15481-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F146D14AE3
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C5533000919
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B6E3806A8;
	Mon, 12 Jan 2026 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtrZVPCH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35203806A2
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241238; cv=none; b=C6hAkoc+hRCRShka4PqJkkBiupPGKxbaCL7d6LDp+2T6oYb41AI/3T7E1ioLnbuaoVaI2IXF8wx2bbx52GUkwVukFULmNWesowGKlm1/YVMP9Fc13oBq9wKqHXQIKUkevYiMS+xLkoHuOiW/fFOKwnQW0y9vLaVv+OICCOPoLcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241238; c=relaxed/simple;
	bh=NvDyeDgHvqmkUu7ojmnVMY3szfEihgKDFkrLZZfycdY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O8E8iRwfpJteGxRraGjKIbJGDhT8gI9uFXz5HtZFgkLU23LwzEKaeAkt33VIm3yjQvlUPFHNFKqYCvoY1gG3GMCFajg3zuPn473oEjQ/s5DQy9yDOPOLj/sG+MXsHgSk/9dkgZC2JAJ8nOZqv1v8zaWXd8IqMNqp5Bo5Vdl7OiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtrZVPCH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768241235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=id5XPqkuM+zrpYOCKhCCCDsyMuntmPe6ENzF1N8Jw8o=;
	b=QtrZVPCHOHOhbMgePac0giW9DUhdOCspmNhdfwEbAQoIjaNm3pzK+UvgPV8uLiWBHEUiyx
	tXYZpg+X6Li6cYjEarV2e7x4YwccGn0LfteTt7kB73vIoAIhlMED67gx4M4nckytbd/6Pc
	tLP7/6pMgGbTD7brVEZxo+y2+Jd/35E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-GFrrsXd3Pdau7aSSVBCihg-1; Mon,
 12 Jan 2026 13:07:13 -0500
X-MC-Unique: GFrrsXd3Pdau7aSSVBCihg-1
X-Mimecast-MFC-AGG-ID: GFrrsXd3Pdau7aSSVBCihg_1768241230
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF7ED18002C4;
	Mon, 12 Jan 2026 18:07:09 +0000 (UTC)
Received: from [10.44.34.128] (unknown [10.44.34.128])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE4E019560AB;
	Mon, 12 Jan 2026 18:07:02 +0000 (UTC)
Message-ID: <1fc327e0-fd35-4192-80c8-7b73bb9cb9c3@redhat.com>
Date: Mon, 12 Jan 2026 19:07:01 +0100
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
 <fd07e1f8-455c-464f-9760-9d16d450a7d5@redhat.com>
 <cbf482be-4aa8-488f-9f78-181f8f145c28@kernel.org>
 <bee863d4-81a4-421c-b57e-b27843ca308b@redhat.com>
Content-Language: en-US
In-Reply-To: <bee863d4-81a4-421c-b57e-b27843ca308b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 1/12/26 5:48 PM, Ivan Vecera wrote:
> 
> 
> On 1/12/26 5:14 PM, Krzysztof Kozlowski wrote:
>> On 09/01/2026 15:11, Ivan Vecera wrote:
>>>>>> +  Common properties for devices that require connection to DPLL
>>>>>> (Digital Phase
>>>>>> +  Locked Loop) pins for frequency synchronization (e.g. SyncE).
>>>>>> +
>>>>>> +properties:
>>>>>> +  dpll-pins:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>>> +    description:
>>>>>> +      List of phandles to the DPLL pin nodes connected to this 
>>>>>> device.
>>>>>> +
>>>>>> +  dpll-pin-names:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>>>>> +    description:
>>>>>> +      Names for the DPLL pins defined in 'dpll-pins', in the same
>>>>>> order.
>>>>>> +
>>>>>> +dependencies:
>>>>>> +  dpll-pin-names: [ dpll-pins ]
>>>>>
>>>>> Binding should go to dtschema. See also commit
>>>>> 3282a891060aace02e3eed4789739768060cea32 in dtschema or other examples
>>>>> how to add new provider/consumer properties.
>>>
>>> Quick questions... if the dpll pin consumer properties schema should go
>>> to dtschema...
>>>
>>> 1) Should I remove this patch from this series? So this schema won't be
>>>      a part of kernel
>>
>> Yes.
> 
> OK, will remove this patch from the series and create PR against
> dtschema and ...
> 
>>> 2) dtschema does not contain dpll-device and dpll-pin schemas now, I
>>
>> The provider, so the #foo-cells should be in dtschema as well.
> 
> ... include dpll.yaml and dpll-pin.yaml as well.

Well, after dtschema investigation, I should make a PR with
dpll-pin-consumer.yaml and dpll-pin-producer.yaml.

Correct?

Thanks,
Ivan


