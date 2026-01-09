Return-Path: <linux-rdma+bounces-15405-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AE7D0A96F
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 15:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C62B301DE36
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9537328B47;
	Fri,  9 Jan 2026 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzquXjAv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4706235CBA5
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968378; cv=none; b=LBKhZta6ovfQ9aPEC/4WxkZBEKKE3120u/8EHqNrs/HsLmEyg1LBkjNUAh394pyw+AB8oY1xrPem91x56eZD5f6MeLFUiBRmLtvd+OjcGNknPJLpCKPeFNpGFFvtZwLMp9MtV0UISJCkCxR3slu+p4Rs6CsISqOUAI5df9GojWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968378; c=relaxed/simple;
	bh=WkKu2zRCrZeiRQHlrFcjimJCJ9ltl8LP5VCX9OqltC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhEd7SgVH2x0JAgoxr8ADo331Nt8G9AXClZuR8ZyJe8BQMPp0b3oC7+2h7gUYFsS0jZ8toNPXvcb4cOQyHugjxTHEoejTVGQpeG+JbSaiHPn+QM/C9Qbxioz0zqvJ9hOBD0peTJM+60ZAkXt680hAwZXXt2XAtY9fvterSw6y1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzquXjAv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767968376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/6WGCpxh3iEXP0zVTdiymBjWOoqngiNJ6AVVfx3sNs=;
	b=FzquXjAv3wKp/aLQ2x3rvhpk0sWez/2JwgPswJEikIh8aE1yKEs+wi/muKtIhC61ixLYeG
	HvjOiuC9amRfdqJCrgt/1J8OxcOcguF+6tyhX9f4LrVfF/2SL2qiQ+08XsOfozcYPTWlrS
	3Lu7f2f/6wK713XMOAzNsy9nsyR5i+M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-JKSJUgiINYezc9O3GZUFpg-1; Fri,
 09 Jan 2026 09:19:35 -0500
X-MC-Unique: JKSJUgiINYezc9O3GZUFpg-1
X-Mimecast-MFC-AGG-ID: JKSJUgiINYezc9O3GZUFpg_1767968371
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A172195608F;
	Fri,  9 Jan 2026 14:19:31 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80D741954196;
	Fri,  9 Jan 2026 14:19:23 +0000 (UTC)
Message-ID: <09ffc379-85e5-41ce-b781-66ba6bb9a6c7@redhat.com>
Date: Fri, 9 Jan 2026 15:19:22 +0100
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
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260109-cooperative-chinchilla-of-swiftness-aebbc8@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 1/9/26 10:55 AM, Krzysztof Kozlowski wrote:
> On Thu, Jan 08, 2026 at 07:23:09PM +0100, Ivan Vecera wrote:
>> Add helper functions to the DPLL core to retrieve a DPLL pin's firmware
>> node handle based on the "dpll-pins" and "dpll-pin-names" properties.
>>
>> * `fwnode_dpll_pin_node_get()`: matches the given name against the
>>    "dpll-pin-names" property to find the correct index, then retrieves
>>    the reference from "dpll-pins".
>> * `device_dpll_pin_node_get()`: a wrapper around the fwnode helper for
>>    convenience when using a `struct device`.
>>
>> These helpers simplify the process for consumer drivers (such as Ethernet
>> controllers or PHYs) to look up their associated DPLL pins defined in
>> the DT or ACPI, which can then be passed to the DPLL subsystem to acquire
>> the pin object.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   drivers/dpll/dpll_core.c | 20 ++++++++++++++++++++
>>   include/linux/dpll.h     | 15 +++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
> 
> I don't see cells defined in your binding. Neither updated property.c.

And if the cells are not required? I mean that dpll-names only specifies
array of phandles without parameters...

e.g.
dpll-pin-names = "abc", "def";
dpll-pins = <&dpll_pin_abc>, <&dpll_pin_def>;

Should '#dpll-pin-cells' be defined as constantly equal to 0?

Thanks,
Ivan

> 
> Best regards,
> Krzysztof
> 


