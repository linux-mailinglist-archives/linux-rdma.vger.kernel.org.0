Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC04153A95
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 22:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgBEV7P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 16:59:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:48241 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgBEV7P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Feb 2020 16:59:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 13:59:14 -0800
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="235737491"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.205.112]) ([10.254.205.112])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2020 13:59:13 -0800
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Goldman, Adam" <adam.goldman@intel.com>,
        linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
 <20200205191227.GE28298@ziepe.ca>
 <daa60df0-04e1-d33c-fdc9-5a3fea2688cb@intel.com>
 <20200205205402.GC25297@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <0f9fd27d-4bb8-b51d-1fdc-20a5b0d5d9e2@intel.com>
Date:   Wed, 5 Feb 2020 16:59:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200205205402.GC25297@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/5/2020 3:54 PM, Jason Gunthorpe wrote:
> On Wed, Feb 05, 2020 at 03:35:13PM -0500, Dennis Dalessandro wrote:
>> On 2/5/2020 2:12 PM, Jason Gunthorpe wrote:
>>> On Tue, Feb 04, 2020 at 08:55:20AM -0500, Goldman, Adam wrote:
>>>> From: "Goldman, Adam" <adam.goldman@intel.com>
>>>>
>>>> PSM2 will not run with recent rdma-core releases. Several tools and
>>>> libraries like PSM2, require the hfi1 name to be present.
>>>>
>>>> Recent rdma-core releases added a new feature to rename kernel devices,
>>>> but the default configuration will not work with hfi1 fabrics.
>>>>
>>>> Related opa-psm2 github issue:
>>>>     https://github.com/intel/opa-psm2/issues/43
>>>>
>>>> Fixes: 5b4099d47be3 ("kernel-boot: Perform device rename to make stable names")
>>>> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
>>>> Signed-off-by: Goldman, Adam <adam.goldman@intel.com>
>>>>    kernel-boot/rdma-persistent-naming.rules | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel-boot/rdma-persistent-naming.rules b/kernel-boot/rdma-persistent-naming.rules
>>>> index 9b61e16..95d6851 100644
>>>> +++ b/kernel-boot/rdma-persistent-naming.rules
>>>> @@ -25,4 +25,4 @@
>>>>    #   Device type = RoCE
>>>>    #   mlx5_0 -> rocex525400c0fe123455
>>>>    #
>>>> -ACTION=="add", SUBSYSTEM=="infiniband", PROGRAM="rdma_rename %k NAME_FALLBACK"
>>>> +ACTION=="add", SUBSYSTEM=="infiniband", KERNEL!="hfi1*", PROGRAM="rdma_rename %k NAME_FALLBACK"
>>>
>>> We are moving to the new names by default slowly, when wrong
>>> assumptions are found in other packages they need to be updated and
>>> their fixes pushed out.
>>>
>>> At some point the major distros will default this to On. People using
>>> leading edge distros can turn it off with the global switch Leon
>>> mentioned.
>>>
>>> This is the same process netdev went through when they introduced
>>> persistent names.
>>>
>>> If I recall, hfi was one of the reason this work was done. HFI has
>>> problems generating consistent names for its multi-function devices in
>>> various cases and I NAK'd the kernel hack to try and 'fix' that.
>>
>> So are you saying you won't take this patch then?
> 
> No, this is not a longterm solution. The point of upstream here is to
> highlight what needs to be fixed so leading edge distro can fix their
> stuff.
> 
>> I guess we can work with distros to get the right rules in place outside of
>> rdma-core so that things continue to work.
> 
> I would actively block an attempt to try and do an end-run around
> upstream like this. rdma-core is supposed to be the defacto
> configuration, not be modified randomly by distros as before.

No but users should be free to name their devices how they want should 
they not?

> You can request distros delay enabling renaming until psm/etc are
> fixed.

Not an end-run around upstream at all. I didn't mean to imply anything 
about how it's done, delaying the enabling, or whatever is fine for now. 
I just meant something that does *not* change/impact rdma-core.

> The distros know the users/cases where renaming is needed and can
> decide if they are more or less important than psm for default
> enablement.

Exactly. We are on the same page here.

>> You are correct someone tried to put forth a hack for the flip-flop name
>> thing [1]. However even if this was used as a solution for that issue we
>> would still have the same library looking for hfi1_0 problem.
> 
> It was always a bad design to hardwire strings like this, that library
> needs to be fixed up.
> 
> Do you remember when I was so annoyed that HFI1 created it's own char
> dev, and told you not to do it? This is yet another reason why...

> Why isn't psm keying off it's own chardev anyhow? There should be back
> links to the RDMA device in sysfs from there.

No arguments here. No sense in going down this road though at this point 
in the game.

-Denny
