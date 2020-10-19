Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4CF292753
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Oct 2020 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgJSM3w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Oct 2020 08:29:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:14506 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgJSM3w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Oct 2020 08:29:52 -0400
IronPort-SDR: okcpZdhVydxPvG2kg/uYEBpz0ieMHtWSbWMgvI0OPZRXnGmrYtnor3cD+UegUvhmkzuIZw0mgD
 v3UkGPl9+CZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="167129650"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="167129650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 05:29:49 -0700
IronPort-SDR: x87ka5a9Q0SCCEkKHWiDCafrDk7BcCKamDnVfvpX/s3dYYWbdpJry1SXpNNPNCOOX0h36LUJZ5
 yjBPVev3tzMg==
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="465509312"
Received: from ashaulsk-mobl1.ger.corp.intel.com (HELO [10.214.247.170]) ([10.214.247.170])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 05:29:46 -0700
Subject: Re: dynamic-sg patch has broken rdma_rxe
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Gal Pressman <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
 <20201014225125.GC5316@nvidia.com>
 <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
 <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
 <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com>
 <20201016003127.GD6219@nvidia.com>
 <796ca31aed8f469c957cb850385b9d09@intel.com>
 <20201016115831.GI6219@nvidia.com>
 <9fa38ed1-605e-f0f6-6cb6-70b800a1831a@linux.intel.com>
 <20201019121211.GC6219@nvidia.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <29ab34c2-0ca3-b3c0-6196-829e31d507c8@linux.intel.com>
Date:   Mon, 19 Oct 2020 13:29:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019121211.GC6219@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 19/10/2020 13:12, Jason Gunthorpe wrote:
> On Mon, Oct 19, 2020 at 10:50:14AM +0100, Tvrtko Ursulin wrote:
>>> overshoot the max_segment if it is not a multiple of PAGE_SIZE. Simply fix
>>> the alignment before starting and don't expose this implementation detail
>>> to the callers.
>>
>> What does not make complete sense to me is the statement that input
>> alignment requirement makes it impossible to connect to DMA layer, but then
>> the patch goes to align behind the covers anyway.
>>
>> At minimum the kerneldoc should explain that max_segment will still be
>> rounded down. But wouldn't it be better for the API to be more explicit and
>> just require aligned anyway?
> 
> Why?
> 
> The API is to not produce sge's with a length longer than max_segment,
> it isn't to produce sge's of exactly max_segment.
> 
> Everything else is an internal detail

(Half-)pretending it is disconnected from PAGE_SIZE, when it really 
isn't, isn't the most obvious API design in my view.

In other words, if you let users pass in 4097 and it just works by 
rounding down to 4096, but you don't let them pass 4095, I just find 
this odd.

My question was why not have callers pass in page aligned max segment 
like today which makes it completely transparent.

Regards,

Tvrtko
