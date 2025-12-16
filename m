Return-Path: <linux-rdma+bounces-15037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3342CCC46E1
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 17:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67A83302E5B0
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D218432143E;
	Tue, 16 Dec 2025 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKItq4mR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7121CC5C
	for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903814; cv=none; b=aDDsHfX4+XIH6tJ7BtIkbK0bvCZgy9v9520p4oXhJNW03clOV5prQdLP7A/6rAa1VMUGI7x6RIcAQGm+sXQGfrodMSo0319wAD8yKlb02lZhuybjTh0rLTB5FnkoXkBJ+IWHT7BCR8wQfZ99FZWv5/BnLKc6QaKwVJ99LKJA+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903814; c=relaxed/simple;
	bh=amfFNKZq1GUMZKx6J2ykCTUYk0BUEzTOlZF4aDqDJBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9m30Izr6Jxjj7rvBwYwZM2YGJnjteoerlciYjpuYAlrlaPWI2D1fpHwCFjjaiKQUAOQHRqpS29E3jtyXxQxihkzysgwRxEtVXYkobcb2wZ2Wt6ybxEsJ5SiaF/xAIvIn3Pmv4ayWlVUMAcOVqxX8OuKj52SoyRMfucAnm8T63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKItq4mR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765903811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQaoEdb2Gv5mzjmA2yph1YCAS1Og7y9869UiTShKwOw=;
	b=KKItq4mRB1UlHZarN80DDrTdYhCfxw3lI3bVMgdBoRRTe1XcGxTGCGltW2tuvoEcw/j+FA
	TXwNPKsdAJrRIhPbVPwFM6aCU7BheeItteG5CGZe1xdC+uL8R2JijmekIrv91y189vroPw
	z8K+kuJJLpiWR9BflOa0+4Y+QzyB8Qo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-6LyMfdK8OfiS9pzsl521xg-1; Tue,
 16 Dec 2025 11:50:06 -0500
X-MC-Unique: 6LyMfdK8OfiS9pzsl521xg-1
X-Mimecast-MFC-AGG-ID: 6LyMfdK8OfiS9pzsl521xg_1765903802
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E77E3180121B;
	Tue, 16 Dec 2025 16:50:01 +0000 (UTC)
Received: from [10.45.224.214] (unknown [10.45.224.214])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04967180044F;
	Tue, 16 Dec 2025 16:49:53 +0000 (UTC)
Message-ID: <2a50d5a3-3116-43e6-ada7-d6c02c483708@redhat.com>
Date: Tue, 16 Dec 2025 17:49:52 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v2 12/12] ice: dpll:
 Support E825-C SyncE and dynamic pin discovery
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 Rob Herring <robh@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Richard Cochran <richardcochran@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Willem de Bruijn <willemb@google.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mark Bloch <mbloch@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
References: <20251215203037.1324945-1-ivecera@redhat.com>
 <20251215203037.1324945-13-ivecera@redhat.com>
 <IA3PR11MB8986B2F4DBD3CDBAE5753C8AE5AAA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <IA3PR11MB8986B2F4DBD3CDBAE5753C8AE5AAA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 12/16/25 2:28 PM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> ...
>> +		/* Register rclk pin */
>> +		pin = &pf->dplls.rclk;
>> +		dpll_pin_on_pin_unregister(parent->pin, pin->pin,
>> +					   &ice_dpll_rclk_ops, pin);
>> +
>> +		/* Drop fwnode pin reference */
>> +		dpll_pin_put(parent->pin, &parent->tracker);
>> +		parent->pin = NULL;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +out:
>> +	kfree(work);
> It looks like you free the embedded work_struct pointer instead of the allocated ice_dpll_pin_work container @ice_dpll_pin_notify().
> Isn't it?

You are right, will fix this in non-RFC submission.

>> +}
>> +
>> ...
>> +static int ice_dpll_init_info_e825c(struct ice_pf *pf)
>> +{
>> +	struct ice_dplls *d = &pf->dplls;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	d->clock_id = ice_generate_clock_id(pf);
>> +	d->num_inputs = ICE_SYNCE_CLK_NUM;
>> +
>> +	d->inputs = kcalloc(d->num_inputs, sizeof(*d->inputs),
>> GFP_KERNEL);
> It looks like for E825-C the allocated pin info (d->inputs and related fields) is never freed:
> error paths in ice_dpll_init_info_e825c() return after kcalloc() without cleanup, and ice_dpll_deinit() explicitly skips ice_dpll_deinit_info() for this MAC.

You are right, this is Arek's code part. I don't see any problem to call
ice_dpll_deinit_info() also for this MAC (.outputs, .pps.input_prio and
.eec.input_prio should be NULL for e825c so it is safe to kfree them).

Will add correct cleanup into ice_dpll_init_info_e825c() and call
ice_dpll_deinit_info() also for this MAC.

> With the best regards
> Alex
> 
>> +	if (!d->inputs)
>> +		return -ENOMEM;
>> +
>> +	ret = ice_get_cgu_rclk_pin_info(&pf->hw, &d->base_rclk_idx,
>> +					&pf->dplls.rclk.num_parents);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < pf->dplls.rclk.num_parents; i++)
>> +		pf->dplls.rclk.parent_idx[i] = d->base_rclk_idx + i;
>> +
>> +	if (ice_pf_src_tmr_owned(pf)) {
>> +		d->base_1588_idx = ICE_E825_1588_BASE_IDX;
>> +		pf->dplls.pin_1588.num_parents = pf-
>>> dplls.rclk.num_parents;
>> +		for (i = 0; i < pf->dplls.pin_1588.num_parents; i++)
>> +			pf->dplls.pin_1588.parent_idx[i] = d-
>>> base_1588_idx + i;
>> +	}
>> +	ret = ice_dpll_init_pins_info(pf,
>> ICE_DPLL_PIN_TYPE_RCLK_INPUT);
>> +	if (ret)
>> +		return ret;
>> +	dev_dbg(ice_pf_to_dev(pf),
>> +		"%s - success, inputs: %u, outputs: %u, rclk-parents:
>> %u, pin_1588-parents: %u\n",
>> +		 __func__, d->num_inputs, d->num_outputs, d-
>>> rclk.num_parents,
>> +		 d->pin_1588.num_parents);
>> +	return 0;
>> +}
>> +
>> ...
>> +int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port,
>> bool *active,
>> +				      enum ice_synce_clk output)
>> +{
>> +	u8 active_clk;
>> +	u32 val;
>> +
>> +	switch (output) {
>> +	case ICE_SYNCE_CLK0:
>> +		ice_read_cgu_reg(hw, ICE_CGU_R10, &val);
>> +		active_clk = FIELD_GET(ICE_CGU_R10_SYNCE_S_REF_CLK,
>> val);
>> +		break;
>> +	case ICE_SYNCE_CLK1:
>> +		ice_read_cgu_reg(hw, ICE_CGU_R11, &val);
>> +		active_clk = FIELD_GET(ICE_CGU_R11_SYNCE_S_BYP_CLK,
>> val);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
> ice_read_cgu_reg() return codes are ignored, can you explain why?

Arek's code... will fix in the non-RFC submission.

Thanks a lot Alex for your sharp eyes. ;-)

Ivan


