Return-Path: <linux-rdma+bounces-15477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E377ED1432A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 17:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6064300875A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DBC2FA0DD;
	Mon, 12 Jan 2026 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHjjwW7b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E8374174
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236967; cv=none; b=X3sma/SMz4cikLneqpXoiMTlAZ8/FyOtyrzc8nOSqNnPL74MtMePM7cIeoaAF0wob5WmUSLENIrBSLwojEsqJ0Hm6szwpnSqPMpMFo2T5jPibb38/LpKqaDXWTopR7znmHC4NPMX+iUeAYMF71JfFIwxkuC5vWEjwhAx5Wm1odE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236967; c=relaxed/simple;
	bh=53PqF1HokUhim5dGFw3XiukMqRe1lpRwS6R3c9/xZMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2nftMyrOQCmOSdNKsrTeBI0/097N7LRTnWw3zt4sgmlBldLJP4rrjKkE5xyesadu0oJCcVyIPVgFPrZZn5mAWEkZbAVklGMY096ZPqel/t/NeuXO2UOajmwxJLd6icJP4WjhTizIpcuMdbRze+QPF+4LWqwu7SyLWNG59r8ApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHjjwW7b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768236965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bj92T4kdPMa4hTjyGAxNwL1RPMgnUsDf7pHcc06+7bY=;
	b=QHjjwW7bdHeR5exPL2MjQqUZP+tL6g6J8hz7XxjT1qVDpQtBnyHRWVGZuWNzmgAbzbQhPs
	6t/OPJghWZKnK9gzvWq5jJBHKTy0yncMNicjHf2vxZMTi/GcLagrP4GcsbGl7bt4H0Zovu
	yAcbOykEqa+hNxPlMrgMg4lkN+vajbE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-PtbRvg4BPEq--o89R600bQ-1; Mon,
 12 Jan 2026 11:55:46 -0500
X-MC-Unique: PtbRvg4BPEq--o89R600bQ-1
X-Mimecast-MFC-AGG-ID: PtbRvg4BPEq--o89R600bQ_1768236943
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D90D01800342;
	Mon, 12 Jan 2026 16:55:42 +0000 (UTC)
Received: from [10.44.34.128] (unknown [10.44.34.128])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9966F30001A7;
	Mon, 12 Jan 2026 16:55:35 +0000 (UTC)
Message-ID: <d444e846-5891-4bcb-96b8-9b3aa3f925bd@redhat.com>
Date: Mon, 12 Jan 2026 17:55:34 +0100
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
 <09ffc379-85e5-41ce-b781-66ba6bb9a6c7@redhat.com>
 <fcc35747-81f3-4a3a-8b5d-cf29e9c52bb2@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <fcc35747-81f3-4a3a-8b5d-cf29e9c52bb2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 1/12/26 5:20 PM, Krzysztof Kozlowski wrote:
> On 09/01/2026 15:19, Ivan Vecera wrote:
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
>>
>> And if the cells are not required? I mean that dpll-names only specifies
>> array of phandles without parameters...
>>
>> e.g.
>> dpll-pin-names = "abc", "def";
>> dpll-pins = <&dpll_pin_abc>, <&dpll_pin_def>;
>>
>> Should '#dpll-pin-cells' be defined as constantly equal to 0?
> 
> I don't understand how can you guarantee for every possible future
> device to have always cells=0. If that's the case then indeed you do not
> need cells, but this needs explanation. You are designing now entire
> ABI, so you must design it fully, not just "works for me now".

Get it, you are right... Theoretically is possible that number of cells
will be > 0.

Will add '#dpll-pin-cells'

Thanks,
Ivan


