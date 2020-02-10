Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310E515817D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 18:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgBJRgG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 12:36:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:40669 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgBJRgG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 12:36:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 09:36:05 -0800
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="226217506"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.206.58]) ([10.254.206.58])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Feb 2020 09:36:04 -0800
Subject: Re: [PATCH for-next 00/16] New hfi1 feature: Accelerated IP
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
 <20200210133134.GN25297@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <84596806-a9ff-1c2a-7116-abd9fa9d2213@intel.com>
Date:   Mon, 10 Feb 2020 12:36:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210133134.GN25297@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/10/2020 8:31 AM, Jason Gunthorpe wrote:
> On Mon, Feb 10, 2020 at 08:18:05AM -0500, Dennis Dalessandro wrote:
>> This patch series is an accelerated ipoib using the rdma netdev mechanism
>> already present in ipoib. A new device capability bit,
>> IB_DEVICE_RDMA_NETDEV_OPA, triggers ipoib to create a datagram QP using the
>> IB_QP_CREATE_NETDEV_USE.
>>
>> The highlights include:
>> - Sharing send and receive resources with VNIC
>> - Allows for switching between connected mode and datagram mode
> 
> There is still value in connected mode?

It's really a compatibility thing. If someone wants to change modes that 
will work. There won't be any benefit to connected mode though. The goal 
is just to not break.

> >> - Increases the maximum datagram MTU for opa devices to 10k
>>
>> The same spreading capability exploited by VNIC is used here to vary
>> the receive context that receives the packet.
>>
>> The patches are fully bisectable and stepwise implement the capability.
> 
> This is alot of code to send without a performance
> justification.. What is it? Is it worth while?

It avoids the scalability problem of connected mode, the number of QPs. 
Incoming packets are spread into multiple receive contexts increasing 
parallelism. The MTU is increased to allows 10K. It also reduces/removes 
the verbs TX overhead by allowing packets to be sent through the SDMA 
engines directly.

>> Gary Leshner (6):
>>        IB/hfi1: Add functions to transmit datagram ipoib packets
>>        IB/hfi1: Add the transmit side of a datagram ipoib RDMA netdev
>>        IB/hfi1: Remove module parameter for KDETH qpns
>>        IB/{rdmavt,hfi1}: Implement creation of accelerated UD QPs
>>        IB/{hfi1,ipoib,rdma}: Broadcast ping sent packets which exceeded mtu size
>>        IB/ipoib: Add capability to switch between datagram and connected mode
>>
>> Grzegorz Andrejczuk (7):
>>        IB/hfi1: RSM rules for AIP
>>        IB/hfi1: Rename num_vnic_contexts as num_netdev_contexts
>>        IB/hfi1: Add functions to receive accelerated ipoib packets
>>        IB/hfi1: Add interrupt handler functions for accelerated ipoib
>>        IB/hfi1: Add rx functions for dummy netdev
> 
> This dummy netdev thing seemed very strange

One of the existing uses of dummy netdev seems to be to tie multiple 
hardware interfaces together. We are using a similar concept for two 
software interfaces. Those being VNIC and AIP. The dummy netdev here 
will own the receiving resources which are shared.


-Denny
