Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F46209DB2
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2020 13:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404246AbgFYLqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jun 2020 07:46:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:62621 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404239AbgFYLqs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jun 2020 07:46:48 -0400
IronPort-SDR: 5dhpT8W3FYbymZ8XM7gaZ91/wEhrjl4uYP4TwbyP0iG2ZoBzMuf5Wk91g+KsBEt/jJDo5JQPjJ
 QG3e19dLMe3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="146347215"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="146347215"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 04:46:48 -0700
IronPort-SDR: 376tIEsclCU6o0vPNAYLFFkyJNbmhDq580xgtZtcjt8KutaVnkffug8DktBnG1EfoR27G3Fk8h
 leFqmYIiQdYA==
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="452977553"
Received: from agrubba-mobl.ger.corp.intel.com (HELO [10.254.201.208]) ([10.254.201.208])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 04:46:47 -0700
Subject: Re: [PATCH for-rc 0/2] Fixes for module unload
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
References: <20200623202519.106975.94246.stgit@awfm-01.aw.intel.com>
 <20200624190108.GN6578@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <d048f1ed-6a63-9a35-e7e7-d8eb062fb8c7@intel.com>
Date:   Thu, 25 Jun 2020 07:46:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624190108.GN6578@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/24/2020 3:01 PM, Jason Gunthorpe wrote:
> On Tue, Jun 23, 2020 at 04:32:18PM -0400, Dennis Dalessandro wrote:
>> Two fixes for unload path. One is where the module use count got messed up in a
>> previous fix, we missed hitting these paths. I missed hitting these paths. The
>> other patch is going back to kfree for the dummy netdev. We are currently
>> re-working how this dummy netdev stuff works and will send a series for-next
>> soon.
>>
>> Dennis Dalessandro (2):
>>        IB/hfi1: Restore kfree in dummy_netdev cleanup
>>        IB/hfi1: Fix module use count flaw due to leftover module put calls
> 
> I fixed the bogus Fixes line, please be more carefull
> 
> Applied to for-rc
>

Ah, I see the bug in my presubmit checks script. Will catch it next time.

-Denny

