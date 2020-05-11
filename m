Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B771CDFE3
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgEKQE6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 12:04:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:64550 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730303AbgEKQE6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 12:04:58 -0400
IronPort-SDR: cV3TL5hHrsIRL3DSEG+b08aSi13G3PEjde31OHsunmyEY7LV7fFTqcDSZB91rx8/a38eUT6Isx
 AiWcml1tdFJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:04:57 -0700
IronPort-SDR: L9uMwhmtMQgvckPDpiIxJMPVF+95H6Br6u5OG8e/SLPIq0kkVx1VhtuvQF4a6gqzGVzAqa6oLe
 Rm2HsiNpapuQ==
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="408965604"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.232]) ([10.254.204.232])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:04:56 -0700
Subject: Re: [PATCH v2 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
References: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
 <20200323231511.64035.16923.stgit@awfm-01.aw.intel.com>
 <20200327164924.GY20941@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <caa96e5b-b467-d52c-e75d-9c5da11702b9@intel.com>
Date:   Mon, 11 May 2020 12:04:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200327164924.GY20941@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/27/2020 12:49 PM, Jason Gunthorpe wrote:
> On Mon, Mar 23, 2020 at 07:15:12PM -0400, Dennis Dalessandro wrote:
>> @@ -240,13 +241,11 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
>>   		priv->broadcast->mcmember.flow_label = mcmember->flow_label;
>>   		priv->broadcast->mcmember.hop_limit = mcmember->hop_limit;
>>   		/* assume if the admin and the mcast are the same both can be changed */
>> +		mtu = rdma_mtu_enum_to_int(priv->ca,  priv->port,
>> +					   priv->broadcast->mcmember.mtu);
>>   		if (priv->mcast_mtu == priv->admin_mtu)
>> -			priv->admin_mtu =
>> -			priv->mcast_mtu =
>> -			IPOIB_UD_MTU(ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu));
>> -		else
>> -			priv->mcast_mtu =
>> -			IPOIB_UD_MTU(ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu));
>> +			priv->admin_mtu = IPOIB_UD_MTU(mtu);
>> +		priv->mcast_mtu = IPOIB_UD_MTU(mtu);
> 
> Er, how did this ever work? Does the OPA SM not use the 6 & 7 values
> for the mtu in the path record? Why is it being changed now?

Prior to this patch series, we can only run AIP at a max mtu of 4K, even 
on OPA devices. Therefore, we need a way to get the max physical mtu for 
the underlying device.

> 
>> +/**
>> + * rdma_mtu_from_attr - Return the mtu of the port from the port attribute.
>> + * @device: Device
>> + * @port_num: Port number
>> + * @attr: port attribute
>> + *
>> + * Return the MTU size supported by the port as an integer value.
>> + */
>> +static inline int rdma_mtu_from_attr(struct ib_device *device, u8 port,
>> +				     struct ib_port_attr *attr)
>> +{
>> +	if (rdma_core_cap_opa_port(device, port))
>> +		return attr->phys_mtu;
> 
> Why not just always set this?

Because this is a new field and other vendor devices does not set it at all.

Sorry for the delayed response this got lost in the shuffle.

-Denny
