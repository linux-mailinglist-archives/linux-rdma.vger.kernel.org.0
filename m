Return-Path: <linux-rdma+bounces-15000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FA8CBE6F5
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 15:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB17130A35E4
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED53339B24;
	Mon, 15 Dec 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQFadLGs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289AB338932
	for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809852; cv=none; b=cD22tilqCydNLz2Bpf52uweXBH7YsDIIpUQzajtFFgl7VdqK14qi4OiSCvrvZcaSq83d04xmobvKbHjR6QfElUzb+iExRM/J3mWMEr1XERca6POqdGBdvqyMo666AXW35n70JW9v4XUBYDnnZZ6HLs5R8O7ajif5qkYbP94hEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809852; c=relaxed/simple;
	bh=0vhekefOl1ShmtPny0ZjERybUNTmzxVEXcWIToFpNVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edEVlC/ofHuodSOj8MK5HP1T3BG+f9bWuaYtLarvL8ZNK+A5bj0+Myg88vUJwGTxW2Rh3fALh0ElmDVR0bw3d37pqa5FsyKRid6bdKMcwNLNXi024YqT/cSTS13ow9VDKgPEyXJgJbcb16lkq/55x5rm3IYeNT1cxuXgXtcnuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQFadLGs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765809849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C51q4VVZgq0ClKfKyE5EVxJ653wbsH0MQVaHCdcWFjc=;
	b=TQFadLGsBx8o7VbMEvKaYCoyJfArywXBToMUMB0tcPpsvezIHPU6tBfWUl89g6n1/TgYXZ
	xoHUlAdlGtTgWzpJxfG/gwMnD6Xu91DB/N4qWjNj4Q9hJRO1Ny7U4DPjbhrairAEvlKGdF
	FtUFjvpTF+R2h5CaasLSNKlLefjzcDo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-jFvP-_CHPGu1Aag2bs8DpA-1; Mon,
 15 Dec 2025 09:44:05 -0500
X-MC-Unique: jFvP-_CHPGu1Aag2bs8DpA-1
X-Mimecast-MFC-AGG-ID: jFvP-_CHPGu1Aag2bs8DpA_1765809842
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E844D18002ED;
	Mon, 15 Dec 2025 14:44:01 +0000 (UTC)
Received: from [10.45.224.214] (unknown [10.45.224.214])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A244A180044F;
	Mon, 15 Dec 2025 14:43:53 +0000 (UTC)
Message-ID: <31e2a687-7e5d-40f2-ba5a-0c05db10e5ae@redhat.com>
Date: Mon, 15 Dec 2025 15:43:52 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 06/13] dpll: Support dynamic pin index
 allocation
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 Petr Oros <poros@redhat.com>, Michal Schmidt <mschmidt@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-7-ivecera@redhat.com>
 <7204d8f7-6482-4217-998f-2788d55f4235@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <7204d8f7-6482-4217-998f-2788d55f4235@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 12/15/25 3:10 PM, Przemek Kitszel wrote:
> On 12/11/25 20:47, Ivan Vecera wrote:
>> Allow drivers to register DPLL pins without manually specifying a pin
>> index.
>>
>> Currently, drivers must provide a unique pin index when calling
>> dpll_pin_get(). This works well for hardware-mapped pins but creates
>> friction for drivers handling virtual pins or those without a strict
>> hardware indexing scheme.
> 
> wouldn't it be better to just switch everything to allocated IDs?
> 
No, this would break original dpll_pin_get() logic. If a caller use
dynamic pin index allocation then in practice means that a new pin
is allocated. But if I have a HW pin with specific index then I want
to get the same ref-counted dpll_pin pointer by dpll_pin_get().

Ivan


