Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9FD1CE19D
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 19:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgEKRXO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 13:23:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:26892 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbgEKRXO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 13:23:14 -0400
IronPort-SDR: j6yKb/G5s68ltjbCGk5PNhX+t1zK/AZWLQsHbdtefkT5ybL/+M/qQ0GIirFhBAc0lqxYkYcqV2
 XbP15yoMwIPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 10:23:13 -0700
IronPort-SDR: 5bilANEf+8r+OcJILAZ5I/o7Rl5cHGiFuAtfiEkv1yc+dIR0Cd+k6oDvocPMcDM4rPVbWU/am6
 wZu6fWzxdAsg==
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="408989758"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.232]) ([10.254.204.232])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 10:23:12 -0700
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
 <caa96e5b-b467-d52c-e75d-9c5da11702b9@intel.com>
 <20200511171130.GV26002@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <b62f6374-19fc-db89-a635-6f89d518af70@intel.com>
Date:   Mon, 11 May 2020 13:23:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200511171130.GV26002@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/11/2020 1:11 PM, Jason Gunthorpe wrote:
>>>> +/**
>>>> + * rdma_mtu_from_attr - Return the mtu of the port from the port attribute.
>>>> + * @device: Device
>>>> + * @port_num: Port number
>>>> + * @attr: port attribute
>>>> + *
>>>> + * Return the MTU size supported by the port as an integer value.
>>>> + */
>>>> +static inline int rdma_mtu_from_attr(struct ib_device *device, u8 port,
>>>> +				     struct ib_port_attr *attr)
>>>> +{
>>>> +	if (rdma_core_cap_opa_port(device, port))
>>>> +		return attr->phys_mtu;
>>>
>>> Why not just always set this?
>>
>> Because this is a new field and other vendor devices does not set it at all.
> 
> Fix the other drivers to set it to the 'else' branch..

Seems reasonable. We'll do that in the next version.

-Denny

