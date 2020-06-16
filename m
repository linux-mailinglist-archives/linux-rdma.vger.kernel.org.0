Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7293B1FBEFA
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 21:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgFPT1k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 15:27:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:23540 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbgFPT1j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 15:27:39 -0400
IronPort-SDR: AkyFKd/E97A+/I65rfINP6EYBi9uYhYh1pzC2IHJpWWpbP1AJuttyPpVBBZgpz/pmOkHwM0MOa
 +JRiCEPVnaBA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 12:27:38 -0700
IronPort-SDR: X1d2gdq4I4K3pT9jV9GHxwgNGeuicUngZN6mFETxVj5yJoK+zaHFaVkNOPAHv1KqmftsOR/2ap
 6ScDHRtROnHQ==
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="449955767"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.207.107]) ([10.254.207.107])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 12:27:36 -0700
Subject: Re: [PATCH v3 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, dledford@redhat.com,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
References: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
 <20200511160618.173205.23053.stgit@awfm-01.aw.intel.com>
 <20200527040350.GA3118979@ubuntu-s3-xlarge-x86>
 <9e9147ad-6d7c-9381-72f3-dc2f3d0723fd@intel.com>
 <20200601135722.GE4872@ziepe.ca>
 <20200616005650.GA1347657@ubuntu-n2-xlarge-x86>
 <20200616062534.GB2141420@unreal>
 <53f86386-780d-4b06-9848-f8a6eede57ee@intel.com>
 <20200616192112.GG4160762@iweiny-DESK2.sc.intel.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <a27d361e-9122-1825-72e7-6a4d2a0627ec@intel.com>
Date:   Tue, 16 Jun 2020 15:27:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616192112.GG4160762@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/16/2020 3:21 PM, Ira Weiny wrote:
> On Tue, Jun 16, 2020 at 03:14:51PM -0400, Dennis Dalessandro wrote:
>> On 6/16/2020 2:25 AM, Leon Romanovsky wrote:
>>> On Mon, Jun 15, 2020 at 05:56:50PM -0700, Nathan Chancellor wrote:
>>>> On Mon, Jun 01, 2020 at 10:57:22AM -0300, Jason Gunthorpe wrote:
>>>>> On Mon, Jun 01, 2020 at 09:48:47AM -0400, Dennis Dalessandro wrote:
>>>>>
>>>>>> They should probably all be in "enum ib_mtu". Jason any issues with us donig
>>>>>> that? I can't for certain recall the real reason they were kept separate in
>>>>>> the first place.
>>>>>
>>>>> It is probably OK
>>>>>
>>>>> Jason
>>>>
>>>> I don't mind taking a wack at this if you guys are too busy (I'm rather
>>>> tired of seeing the warning across all of my builds). However, I am
>>>> wondering how far should this be unwound? Should 'enum opa_mtu' be
>>>> collapsed into 'enum ib_mtu' and then all of the opa conversion
>>>> functions be eliminated in favor of the ib ones? It looks like
>>>> OPA_MTU_8192 and OPA_MTU_10240 are used in a few places within
>>>> drivers/infiniband/hw/hfi1, should all of those instances be converted
>>>> over to IB_MTU_* and the defines at the top of
>>>> drivers/infiniband/hw/hfi1/hfi.h be eliminated?
>>
>> My opinion is yes.
>>
>>> We rather keep separation due to logic separation.
>>
>> To be fair, "you" rather. Not we. I'd like some others to weigh in here.
>> Increasing the available MTUs an an enum just makes sense. Why does it
>> matter if IB doesn't need them right now. Maybe someday.
>>
>>> While ib_* defines come from IBTA and interoperable across different
>>> devices and vendors, opa_* definitions are Intel proprietary ones used
>>> for the product that was canceled.
>>
>> But does it hurt to have more potentially available? Can you please explain
>> the technical reason here?
> 
> The problem is that the IBTA _may_ define those enums to mean something
> different in the future.  Hopefully, the Intel representatives within the IBTA
> would try to make them compatible but I don't know that 10K 'fits' with the
> IBTA's future.  8K seems like a reasonable extension for the IBTA but again we
> as Linux developers can't say that will happen for sure.  We just don't control
> what the IBTA does in that regard.
> 

I guess I buy that. However I believe I have seen it claimed in the past 
that we aren't the IBTA, we are the Linux kernel and can do what we 
think makes sense. But to be honest I don't feel strongly, and I'm not 
gonna argue strongly one way or the other.

-Denny

