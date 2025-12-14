Return-Path: <linux-rdma+bounces-14987-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D70ECBC003
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Dec 2025 21:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2885E301B2E6
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Dec 2025 20:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A837329DB6C;
	Sun, 14 Dec 2025 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+VtpiFe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C46287516
	for <linux-rdma@vger.kernel.org>; Sun, 14 Dec 2025 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765744940; cv=none; b=nQDPy0BQ7m3jEk6+edGThUqt7SXH7K5VIdbT6pQ3v/WDJzt0GfOKrMtFZiTDSELSq11rb7AE+7W+WwZ60rRwTihlXQoJ/zfQo8y1M3Vd0U37h8IEzJGnClNG/yfGQVOvEDwe1uUWOLxmF9dbMAq54E+NUW5G1koP5haXSFQH7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765744940; c=relaxed/simple;
	bh=jEa658HLG0UG+Gha1cEfa5pm1E3PYVGVzZ3jVK5gWUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdq83y6IY3TyjVPVcQE6Fvze0BclH64a6xbHcJtRj6sc3IR7wCQJeVeynYSlWgAoDhYZ53Ffc/ggBFaMHbK8IG9smCzZhUQOBJ/L8iyNJ08FMFRrOizxkmp5mJScguUgWaYudbAeSvz5pbEClVaXUvyWBz5/biGZbS5QnzM0CuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+VtpiFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765744936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dtrcaVLTNzNgFmQjfOcQvmiNkCId0/CKPWI6nsR8CY=;
	b=N+VtpiFesTTcp/VqlGBZ5DiC9dCAZ0AeDL+49ZSbF7PkRl0LXxRDx/tO6al0k7o4Ixb8TV
	UkkPRxEInVu0kJ+BuBhEXr+OOzimTxblm2TY2oxX5wLG9lrhKPe0BePu6cc89tijkV9yeK
	fe8hzBor3KbOZdyXYChARZVyBnaIz8Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-ZenklePwOjaeAwlmJE1OgQ-1; Sun,
 14 Dec 2025 15:42:12 -0500
X-MC-Unique: ZenklePwOjaeAwlmJE1OgQ-1
X-Mimecast-MFC-AGG-ID: ZenklePwOjaeAwlmJE1OgQ_1765744929
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A1331956063;
	Sun, 14 Dec 2025 20:42:08 +0000 (UTC)
Received: from [10.45.224.53] (unknown [10.45.224.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B170180045B;
	Sun, 14 Dec 2025 20:41:57 +0000 (UTC)
Message-ID: <89eaccbb-bfcf-4dac-b7b7-f4259de75dd2@redhat.com>
Date: Sun, 14 Dec 2025 21:41:53 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 01/13] dt-bindings: net: ethernet-controller:
 Add DPLL pin properties
To: Andrew Lunn <andrew@lunn.ch>
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
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-2-ivecera@redhat.com>
 <2de556f0-d7db-47f1-a59e-197f92f93d46@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <2de556f0-d7db-47f1-a59e-197f92f93d46@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 12/11/25 8:56 PM, Andrew Lunn wrote:
> On Thu, Dec 11, 2025 at 08:47:44PM +0100, Ivan Vecera wrote:
>> Ethernet controllers may be connected to DPLL (Digital Phase Locked Loop)
>> pins for frequency synchronization purposes, such as in Synchronous
>> Ethernet (SyncE) configurations.
>>
>> Add 'dpll-pins' and 'dpll-pin-names' properties to the generic
>> ethernet-controller schema. This allows describing the physical
>> connections between the Ethernet controller and the DPLL subsystem pins
>> in the Device Tree, enabling drivers to request and manage these
>> resources.
> 
> Please include a .dts patch in the series which actually makes use of
> these new properties.
> 
> 	Andrew

Hi Andy,

I would include this but the development of this series was done on
Microchip EVB-LAN9668 EDS2 development board [1] and its DTS is not
present in upstream tree. The base DTS for this board is at vendor's
github repo [2]. The second development environment was/is ACPI based
Intel GNR-D platform and the goal is to use unified fwnode API so
ACPI is providing _DSD nodes to specify dpll-pin-names and dpll-names
properties.

Ivan

[1] https://www.microchip.com/en-us/development-tool/ev83e85a
[2] 
https://github.com/microchip-ung/linux/blob/bsp-6.12-2025/arch/arm/boot/dts/microchip/lan966x-pcb8385.dts


