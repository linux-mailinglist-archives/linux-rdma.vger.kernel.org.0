Return-Path: <linux-rdma+bounces-15476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D4D14339
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 17:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9A843049C4E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7036E46D;
	Mon, 12 Jan 2026 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGnOWOpN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73F3644A7
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236770; cv=none; b=cgLnSvn8mNOp/n+Wx/YW1+iA6/Vv0aWNIcB2VZ1+NqywF+1L8K/Z1ew+pygnq2HXOXcR6j+t/CvSdRohMw6lb4L6alCbyXz9oTMu46aHQCryg6l9XnlhVOQIc0zULxw8BEo/5EWaQHnOnsSyDkmuZvstlBI32SBEfkevSqRhJ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236770; c=relaxed/simple;
	bh=efldYqSwp2SNEEvW3E88bChSvw2Uz7vxSEpeuTyNRik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHCNcxsKC2qcPqGAGNS1a/vsdASuFo7SXdV2txVVScW12RsVLmKVSKB9+49WATu/odSG3jkZPymY3b8X/87nrDyBP188U59ewg7c229sNuxXzAGWPM/4gogq779k1PhMacCq9HUh8ccm8a67VqB2gCB2DapwiYut8oDoOebzSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGnOWOpN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768236767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNUxirVuC6Amib0RnMLuE2BYHWTtcIWHH53MESKRWvY=;
	b=DGnOWOpNMJmBhDT3IsZBECenV2sM5kbTWjlZpVlzJEA9vB9x/FiPgT+oEpn0dfOn7u1WGA
	UGDxV0YcqDzvgh+w1cJ34tKC9ltds3nWbBP2oh3PdQNn0SChPQxlBU6g6YUl4Mb/CU67Hu
	0C3lVB03WIAUeB1N/LuyhN0RlQmDlhA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-hepfzZdONg65ms3TNDv15w-1; Mon,
 12 Jan 2026 11:52:46 -0500
X-MC-Unique: hepfzZdONg65ms3TNDv15w-1
X-Mimecast-MFC-AGG-ID: hepfzZdONg65ms3TNDv15w_1768236763
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A42DF19560B2;
	Mon, 12 Jan 2026 16:52:42 +0000 (UTC)
Received: from [10.44.34.128] (unknown [10.44.34.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4323819560B2;
	Mon, 12 Jan 2026 16:52:35 +0000 (UTC)
Message-ID: <323241f0-9d70-4b4a-b32b-b14d0efc037b@redhat.com>
Date: Mon, 12 Jan 2026 17:52:33 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/12] dpll: Add helpers to find DPLL pin fwnode
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
 <20260108182318.20935-4-ivecera@redhat.com>
 <20260109-cooperative-chinchilla-of-swiftness-aebbc8@quoll>
 <25f49485-2228-4aa5-9023-0b00cc10a4da@redhat.com>
 <22bdda82-9ebf-4381-a7d4-edbf97408a5f@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <22bdda82-9ebf-4381-a7d4-edbf97408a5f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 1/12/26 5:16 PM, Krzysztof Kozlowski wrote:
> On 09/01/2026 11:22, Ivan Vecera wrote:
>>
>>
>> On 1/9/26 10:55 AM, Krzysztof Kozlowski wrote:
>>> On Thu, Jan 08, 2026 at 07:23:09PM +0100, Ivan Vecera wrote:
>>>> Add helper functions to the DPLL core to retrieve a DPLL pin's firmware
>>>> node handle based on the "dpll-pins" and "dpll-pin-names" properties.
>>>>
>>>> * `fwnode_dpll_pin_node_get()`: matches the given name against the
>>>>     "dpll-pin-names" property to find the correct index, then retrieves
>>>>     the reference from "dpll-pins".
>>>> * `device_dpll_pin_node_get()`: a wrapper around the fwnode helper for
>>>>     convenience when using a `struct device`.
>>>>
>>>> These helpers simplify the process for consumer drivers (such as Ethernet
>>>> controllers or PHYs) to look up their associated DPLL pins defined in
>>>> the DT or ACPI, which can then be passed to the DPLL subsystem to acquire
>>>> the pin object.
>>>>
>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>> ---
>>>>    drivers/dpll/dpll_core.c | 20 ++++++++++++++++++++
>>>>    include/linux/dpll.h     | 15 +++++++++++++++
>>>>    2 files changed, 35 insertions(+)
>>>>
>>>
>>> I don't see cells defined in your binding. Neither updated property.c.
>>>
>> WDYM by property.c ?
> 
> Each standardized phandle reliationship is supposed to be reflected with
> device links (at least of now... maybe it already changed after this LPC?)

Do you mean 'supplier_bindings' in drivers/of/property.c ?

Thanks,
Ivan


