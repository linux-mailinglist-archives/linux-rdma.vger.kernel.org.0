Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5D4159BD1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 22:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgBKV6E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 16:58:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:54292 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbgBKV6E (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Feb 2020 16:58:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 13:58:03 -0800
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="226645934"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.206.58]) ([10.254.206.58])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Feb 2020 13:58:02 -0800
Subject: Re: [PATCH for-next 00/16] New hfi1 feature: Accelerated IP
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
 <20200210133134.GN25297@ziepe.ca>
 <84596806-a9ff-1c2a-7116-abd9fa9d2213@intel.com>
 <20200210183249.GA4182@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <cf3d8011-a9c5-9e63-131b-42a5dd45e4f8@intel.com>
Date:   Tue, 11 Feb 2020 16:58:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210183249.GA4182@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/10/2020 1:32 PM, Jason Gunthorpe wrote:
> On Mon, Feb 10, 2020 at 12:36:02PM -0500, Dennis Dalessandro wrote:
>> On 2/10/2020 8:31 AM, Jason Gunthorpe wrote:
>>> On Mon, Feb 10, 2020 at 08:18:05AM -0500, Dennis Dalessandro wrote:
>>>> This patch series is an accelerated ipoib using the rdma netdev mechanism
>>>> already present in ipoib. A new device capability bit,
>>>> IB_DEVICE_RDMA_NETDEV_OPA, triggers ipoib to create a datagram QP using the
>>>> IB_QP_CREATE_NETDEV_USE.
>>>>
>>>> The highlights include:
>>>> - Sharing send and receive resources with VNIC
>>>> - Allows for switching between connected mode and datagram mode
>>>
>>> There is still value in connected mode?
>>
>> It's really a compatibility thing. If someone wants to change modes that
>> will work. There won't be any benefit to connected mode though. The goal is
>> just to not break.
> 
> I am a bit confused by this.. I thought the mlx5 implementation
> already could select connected mode?
> 
> Why were core ipoib changes needed?

I don't think so, patch 15/16 seemed to be necessary to get connected 
mode to work with the rdma netdev.

> 
>>>> The patches are fully bisectable and stepwise implement the capability.
>>>
>>> This is alot of code to send without a performance
>>> justification.. What is it? Is it worth while?
>>
>> It avoids the scalability problem of connected mode, the number of QPs.
>> Incoming packets are spread into multiple receive contexts increasing
>> parallelism. The MTU is increased to allows 10K. It also reduces/removes the
>> verbs TX overhead by allowing packets to be sent through the SDMA engines
>> directly.
> 
> No numbers to share?

No numbers directly but I can say that AIP enables line-rate performance 
between two nodes with Datagram Mode, it also provides IPoFabric latency 
improvements relative to standard Datagram Mode without AIP.

-Denny
