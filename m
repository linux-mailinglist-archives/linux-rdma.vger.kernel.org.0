Return-Path: <linux-rdma+bounces-15406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FE3D0ABE7
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 15:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0811030C80E0
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31930FF23;
	Fri,  9 Jan 2026 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zkc0naX0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135D310624
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970077; cv=none; b=U38txP3wIcS4QF/iTXpI3Bqf6l+k8sNiMkm1XM1HcD5Jd/tgwmvV+G/gjzhypU8mV7X4x9Oqe2OVNh/aTa2Qqwl/yQ5EIa+4J2LdbAnXPAtAB4irx8xLJrcOMJc6+KrstwyRWvviilRE43TAhhBq8o2zCjhgjSr4bn9uyHPxQeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970077; c=relaxed/simple;
	bh=tMyA0jgWZUY05/4RNiG0ugxFC1DgjIcO68pVnGKa2J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGOQvkvh3I2jp7wxlJaMoO84MogjKKFcgwkL7iYxUTYGRV0DChImLzjikwafHrmdEKqCwbX1SVzMF9UT7YzoyYUoAAjEuMaG56ZQAVibG6mnTt2JhI2RzpaYXs3wz2LMPJg3jOb+ONXeGsAARUHcpdh8LQev7XLLCtXTaSol3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zkc0naX0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767970074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBvA9+9FowTNDc9kk7N2zTDw3Fsb1HWru+YFGxNPkjM=;
	b=Zkc0naX0z97aotOdN/uXbjoIHSp8ShWc1WLppbMdVWZR5mvy4FrU6em5iyNPuxPyHpfVeG
	7mtMI284QbrDmvcLjyuO7bs+bhE4kiZEDakjTpIhWHcG7uI2q3CQsRtt4klJ1jPLS7YM5y
	PtD5Y7gMglbls2BN/Y9VsObDtWpd+A4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-EL9hj0GqOFSDltbe3aIfHw-1; Fri,
 09 Jan 2026 09:47:49 -0500
X-MC-Unique: EL9hj0GqOFSDltbe3aIfHw-1
X-Mimecast-MFC-AGG-ID: EL9hj0GqOFSDltbe3aIfHw_1767970064
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 282091955F34;
	Fri,  9 Jan 2026 14:47:44 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65C3A19560B4;
	Fri,  9 Jan 2026 14:47:37 +0000 (UTC)
Message-ID: <dba89495-3963-4ce4-a3dc-6187f22dbd9e@redhat.com>
Date: Fri, 9 Jan 2026 15:47:35 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 12/12] ice: dpll: Support
 E825-C SyncE and dynamic pin discovery
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 Rob Herring <robh@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Richard Cochran <richardcochran@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mark Bloch <mbloch@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>,
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
References: <20260108182318.20935-1-ivecera@redhat.com>
 <20260108182318.20935-13-ivecera@redhat.com>
 <IA3PR11MB8986036A2826A4EE758A456EE582A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <IA3PR11MB8986036A2826A4EE758A456EE582A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 1/9/26 7:15 AM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Ivan Vecera
>> Sent: Thursday, January 8, 2026 7:23 PM
>> To: netdev@vger.kernel.org
>> Cc: Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Rob Herring <robh@kernel.org>; Leon
>> Romanovsky <leon@kernel.org>; Andrew Lunn <andrew+netdev@lunn.ch>;
>> linux-rdma@vger.kernel.org; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Kubalewski, Arkadiusz
>> <arkadiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org;
>> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
>> devicetree@vger.kernel.org; Conor Dooley <conor+dt@kernel.org>; Jiri
>> Pirko <jiri@resnulli.us>; Richard Cochran <richardcochran@gmail.com>;
>> Prathosh Satish <Prathosh.Satish@microchip.com>; Vadim Fedorenko
>> <vadim.fedorenko@linux.dev>; Mark Bloch <mbloch@nvidia.com>; linux-
>> kernel@vger.kernel.org; Tariq Toukan <tariqt@nvidia.com>; Lobakin,
>> Aleksander <aleksander.lobakin@intel.com>; Jonathan Lemon
>> <jonathan.lemon@gmail.com>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
>> Saeed Mahameed <saeedm@nvidia.com>; David S. Miller
>> <davem@davemloft.net>
>> Subject: [Intel-wired-lan] [PATCH net-next 12/12] ice: dpll: Support
>> E825-C SyncE and dynamic pin discovery
>>
>> From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>
>> Add DPLL support for the Intel E825-C Ethernet controller. Unlike
>> previous generations (E810), the E825-C connects to the platform's
>> DPLL subsystem via MUX pins defined in the system firmware (Device
>> Tree/ACPI).
>>
>> Implement the following mechanisms to support this architecture:
>>
>> 1. Dynamic Pin Discovery: Use the fwnode_dpll_pin_find() helper to
>>     locate the parent MUX pins defined in the firmware.
>>
>> 2. Asynchronous Registration: Since the platform DPLL driver may probe
>>     independently of the network driver, utilize the DPLL notifier
>> chain
>>     (register_dpll_notifier). The driver listens for DPLL_PIN_CREATED
>>     events to detect when the parent MUX pins become available, then
>>     registers its own Recovered Clock (RCLK) pins as children of those
>>     parents.
>>
>> 3. Hardware Configuration: Implement the specific register access
>> logic
>>     for E825-C CGU (Clock Generation Unit) registers (R10, R11). This
>>     includes configuring the bypass MUXes and clock dividers required
>> to
>>     drive SyncE signals.
>>
>> 4. Split Initialization: Refactor `ice_dpll_init()` to separate the
>>     static initialization path of E810 from the dynamic, firmware-
>> driven
>>     path required for E825-C.
>>
>> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_dpll.c   | 715 +++++++++++++++++--
>> -
>>   drivers/net/ethernet/intel/ice/ice_dpll.h   |  25 +
>>   drivers/net/ethernet/intel/ice/ice_lib.c    |   3 +
>>   drivers/net/ethernet/intel/ice/ice_ptp.c    |  29 +
>>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c |   9 +-
>>   drivers/net/ethernet/intel/ice/ice_tspll.c  | 217 ++++++
>> drivers/net/ethernet/intel/ice/ice_tspll.h  |  13 +-
>>   drivers/net/ethernet/intel/ice/ice_type.h   |   6 +
>>   8 files changed, 925 insertions(+), 92 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
>> b/drivers/net/ethernet/intel/ice/ice_dpll.c
>> index 4eca62688d834..06575d42de6e9 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>> @@ -5,6 +5,7 @@
> 
> ...
> 
>> +/**
>> + * ice_dpll_init_fwnode_pins - initialize pins from device tree
>> + * @pf: board private structure
>> + * @pins: pointer to pins array
>> + * @start_idx: starting index for pins
>> + * @count: number of pins to initialize
>> + *
>> + * Initialize input pins for E825 RCLK support. The parent pins
>> (rclk0,
>> +rclk1)
>> + * are expected to be defined in the device tree (ACPI). This
>> function
>> +allocates
> Device Tree and ACPI are different firmware interfaces, aren't they?
> Writing "device tree (ACPI)" can mislead readers about where the
> fwnode-backed discovery is expected to come from.

Will fix.

> The code looks good for me.
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thank you, Alex.
Ivan


