Return-Path: <linux-rdma+bounces-16477-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFZzK6MugmlFQAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16477-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:21:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68BDCB59
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C702308A5C3
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF62798ED;
	Tue,  3 Feb 2026 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqiF60qh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E22517A5
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139035; cv=none; b=UhM02lx6kMDnc5UUXocYnaEiTO/L6GbZJu6L0ozOxlDcvOnczIe6SPNOZpYDNk8eLFFzIw5ba7NfhpczZ+XtAkhR5dCpEGHAMDRP9/HV5xOizs3mB1ipmpWPzPgBus3FDWAvtjYRFlH2kE0EKSOhWhAkXjy4OwoFhN3ET1xNSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139035; c=relaxed/simple;
	bh=L+tfV6h2aIEs31IPZyRpeRladsy47nV8RT4uOW/3s6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeUhGa32vO+8ZbKSdZTaQJS5mti8s2ZTDuypRn3264H8WPyIjgHtYiLxMO6KHPgJ6XoBPVlxS8dvNCp86mwzo5Rja+YOISDpR8FpotGEk+0Iaf9crc49qWN5EHpH65su3L+nhUXSEurlh+VwE5yIXhl4WL5D0niY9JkeSz9Bl04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqiF60qh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770139033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7bWkTI4zqaEsibgzb4DhWv0fCgI0/Cq4xXCwoJlLUw=;
	b=CqiF60qhRAf3sf9lrWX3sGcv1JJyp92cMbOrhojGmVTC7VstpzhuUmRd9PbPPFPBaDCkcd
	BOkIRp1R5AeQst8JPo24n0QK6Zi/0AB1mH8mzDHkrMi3d4GudgkjWGiEclFNVh0FSpECDN
	SZ6b2HpUcRIigw36ox2dtDdea1WydTQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-Vn56I230NhuLOl4ARr0TCw-1; Tue,
 03 Feb 2026 12:17:08 -0500
X-MC-Unique: Vn56I230NhuLOl4ARr0TCw-1
X-Mimecast-MFC-AGG-ID: Vn56I230NhuLOl4ARr0TCw_1770139024
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 424DC1954204;
	Tue,  3 Feb 2026 17:17:03 +0000 (UTC)
Received: from [10.45.224.28] (unknown [10.45.224.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 791DC19560B4;
	Tue,  3 Feb 2026 17:16:56 +0000 (UTC)
Message-ID: <b8d56202-cae9-4759-bed9-0556dbca571e@redhat.com>
Date: Tue, 3 Feb 2026 18:16:54 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v4,9/9] ice: dpll: Support E825-C SyncE and dynamic pin
 discovery
To: Simon Horman <horms@kernel.org>
Cc: richardcochran@gmail.com, arkadiusz.kubalewski@intel.com,
 przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com,
 andrew+netdev@lunn.ch, pabeni@redhat.com, saeedm@nvidia.com,
 kuba@kernel.org, tariqt@nvidia.com, netdev@vger.kernel.org,
 grzegorz.nitka@intel.com, poros@redhat.com, davem@davemloft.net,
 vadim.fedorenko@linux.dev, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, aleksander.lobakin@intel.com,
 jonathan.lemon@gmail.com, jiri@resnulli.us, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, Prathosh.Satish@microchip.com,
 leon@kernel.org, edumazet@google.com, mbloch@nvidia.com
References: <20260202171638.17427-10-ivecera@redhat.com>
 <20260203161120.1894163-1-horms@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260203161120.1894163-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,lunn.ch,redhat.com,nvidia.com,kernel.org,vger.kernel.org,davemloft.net,linux.dev,resnulli.us,lists.osuosl.org,microchip.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16477-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0F68BDCB59
X-Rspamd-Action: no action

On 2/3/26 5:11 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps seehttps://netdev-ai.bots.linux.dev/ai-local.html
> ---
> ice: dpll: Support E825-C SyncE and dynamic pin discovery
> 
> This patch implements SyncE support for the E825-C Ethernet controller
> using the DPLL subsystem, with dynamic pin discovery via firmware (ACPI)
> and asynchronous registration using the DPLL notifier chain.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
>> index 4eca62688d83..a8c99e49bfae 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> [ ... ]
> 
>> @@ -528,6 +529,92 @@ ice_dpll_pin_disable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>>   	return ret;
>>   }
>>
>> +/**
>> + * ice_dpll_rclk_update - updates the state of rclk pin on a device
>> + * @pf: private board struct
>> + * @pin: pointer to a pin
>> + * @port_num: port number
>> + *
>> + * Update struct holding pin states info, states are separate for each parent
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - OK
>> + * * negative - error
>> + */
>> +static int ice_dpll_rclk_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
>> +				u8 port_num)
>> +{
>> +	int ret;
>> +
>> +	for (u8 parent = 0; parent < pf->dplls.rclk.num_parents; parent++) {
>> +		ret = ice_aq_get_phy_rec_clk_out(&pf->hw, &parent, &port_num,
>> +						 &pin->flags[parent], NULL);
> Is it safe to pass &parent as an output parameter when it's also the loop
> counter? Looking at ice_aq_get_phy_rec_clk_out():
> 
>      int ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 *phy_output, ...)
>      {
>          cmd->phy_output = *phy_output;  // Read as input
>          status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
>          if (!status) {
>              *phy_output = cmd->phy_output;  // Write back from firmware
>          ...
> 
> The firmware could potentially return a different value than was sent,
> which would be written back to 'parent', corrupting the loop counter.
> 
> This corrupted value is then used as an array index:
> 
>> +		if (ret)
>> +			return ret;
>> +
>> +		ice_dpll_pin_store_state(pin, parent,
>> +					 ICE_AQC_GET_PHY_REC_CLK_OUT_OUT_EN &
>> +					 pin->flags[parent]);
> Both pin->flags[parent] and pin->state[parent] (inside
> ice_dpll_pin_store_state) could access out of bounds if firmware returns
> a value >= ICE_DPLL_RCLK_NUM_MAX (which is 2).
> 
> Would it be safer to use a separate variable for the phy_output parameter
> and validate that firmware echoes back the expected value?

Yes, there should be a separate variable like in previous code prior
this refactor...

<snip>
         case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
-               for (parent = 0; parent < pf->dplls.rclk.num_parents;
-                    parent++) {
-                       u8 p = parent; <--- HERE
-
-                       ret = ice_aq_get_phy_rec_clk_out(&pf->hw, &p,
-                                                        &port_num,
- 
&pin->flags[parent],
-                                                        NULL);
</snip>

Arek, I will fix it by myself.

Thanks,
Ivan


