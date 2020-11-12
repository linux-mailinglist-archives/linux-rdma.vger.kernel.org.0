Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B14B2B1104
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 23:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgKLWI0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 17:08:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:29237 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbgKLWI0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 17:08:26 -0500
IronPort-SDR: kjfnFdJx9rIOZrPL+c0u72kAMz31dgbm1e3mhr/tWRLAULI8N1IgX8v795y5Dgq4SGUHkFhJPh
 +zBdDtd185dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158166282"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="158166282"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 14:08:25 -0800
IronPort-SDR: oSJg95d+2qGVSc9BPM+O7l7Ft+ZCzI1FJhAPLj7FpsqLPipmi/QzvoSu8Ic+EkeguCaQj4BSR8
 w12mNhyiftGw==
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="542419330"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.205.29]) ([10.254.205.29])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 14:08:23 -0800
Subject: Re: [PATCH for-rc v2] IB/hfi1: Move cached value of mm into handler
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, Jann Horn <jannh@google.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20201112025837.24440.6767.stgit@awfm-01.aw.intel.com>
 <20201112171439.GT3976735@iweiny-DESK2.sc.intel.com>
 <b45c2303-a78e-a3b6-fcd2-371886caf788@cornelisnetworks.com>
Message-ID: <ba7df075-ab50-3344-aacb-656ae10b517a@cornelisnetworks.com>
Date:   Thu, 12 Nov 2020 17:08:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <b45c2303-a78e-a3b6-fcd2-371886caf788@cornelisnetworks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/12/2020 5:06 PM, Dennis Dalessandro wrote:
> On 11/12/2020 12:14 PM, Ira Weiny wrote:
>> On Wed, Nov 11, 2020 at 09:58:37PM -0500, Dennis Dalessandro wrote:
>>> Two earlier bug fixes have created a security problem in the hfi1
>>> driver. One fix aimed to solve an issue where current->mm was not valid
>>> when closing the hfi1 cdev. It attempted to do this by saving a cached
>>> value of the current->mm pointer at file open time. This is a problem if
>>> another process with access to the FD calls in via write() or ioctl() to
>>> pin pages via the hfi driver. The other fix tried to solve a use after
>>> free by taking a reference on the mm. This was just wrong because its
>>> possible for a race condition between one process with an mm that opened
>>> the cdev if it was accessing via an IOCTL, and another process
>>> attempting to close the cdev with a different current->mm.
>>
>> Again I'm still not seeing the race here.  It is entirely possible 
>> that the fix
>> I was trying to do way back was mistaken too...  ;-)  I would just 
>> delete the
>> last 2 sentences...  and/or reference the commit of those fixes and help
>> explain this more.
> 
> I was attempting to refer to [1], the email that started all of this.

That link should be:
[1] https://marc.info/?l=linux-rdma&m=159891753806720&w=2

-Denny

