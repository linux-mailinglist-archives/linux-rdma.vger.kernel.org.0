Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EB82A46C0
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 14:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgKCNl7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 08:41:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:25485 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgKCNl6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Nov 2020 08:41:58 -0500
IronPort-SDR: k/oTAfFhJ9gZXNowxrvYEjuH2DfOQ1D3Nyt/2VtW+bt0dG/qpTvv/6mzlijokEdRbA5taoHNmu
 e5K3mnz+7lbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="169156977"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="169156977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 05:41:58 -0800
IronPort-SDR: 0lkPVRStevKvuHjmGu0t607rGAkskgQQc7fhWgg+x0/0/f4pXQrf7DcMlISLtVecK/WMvhqK7P
 /Wk6B2w2IaHA==
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="538494148"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.251]) ([10.254.204.251])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 05:41:57 -0800
Subject: Re: [PATCH for-rc v1] IB/hfi1: Move cached value of mm into handler
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, Jann Horn <jannh@google.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>
References: <20201029012243.115730.93867.stgit@awfm-01.aw.intel.com>
 <20201103002239.GI36674@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <be4067af-f491-81f6-39e2-771366f89086@cornelisnetworks.com>
Date:   Tue, 3 Nov 2020 08:41:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103002239.GI36674@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/2/2020 7:22 PM, Jason Gunthorpe wrote:
> On Wed, Oct 28, 2020 at 09:22:43PM -0400, Dennis Dalessandro wrote:
> 
>> Will add a Cc for stable once the patch is finalized. I'd like to get
>> some more feedback on this patch especially in the mmu_interval_notifier
>> stuff.
> 
> Which mmu_interval_notifier stuff in this patch?
> 
> Can you convert this last usage of mmu_notifier in mmu_rb_handler to
> use an interval notifier? I seem to remember thinking it was the right
> thing but too complicated for me to attempt

The call to mmu_interval_notifier_insert() in set_rcvarray_entry() 
specifically. Instead of passing the saved mm I changed it to use current.

Yes we may be able to convert to the interval notifier for the rest of 
it. I'd rather do that as a separate patch and get this fixed for 5.10 
and in the stable kernels and do that as a for-next sort of thing.

-Denny
