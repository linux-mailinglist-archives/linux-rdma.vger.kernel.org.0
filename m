Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFC816469D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 15:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgBSOOL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 09:14:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:28131 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbgBSOOK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 09:14:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 06:14:09 -0800
X-IronPort-AV: E=Sophos;i="5.70,459,1574150400"; 
   d="scan'208";a="229120155"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.151]) ([10.254.204.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2020 06:14:08 -0800
Subject: Re: RDMA device renames and node description
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Honggang LI <honli@redhat.com>,
        Gal Pressman <galpress@amazon.com>
References: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
 <20200218140444.GB8816@unreal>
 <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
 <20200219071129.GD15239@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <bea50739-918b-ae6f-5fac-f5642c56f1da@intel.com>
Date:   Wed, 19 Feb 2020 09:14:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219071129.GD15239@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/19/2020 2:11 AM, Leon Romanovsky wrote:
> On Tue, Feb 18, 2020 at 12:11:47PM -0500, Dennis Dalessandro wrote:
>> On 2/18/2020 9:04 AM, Leon Romanovsky wrote:
>>> On Fri, Feb 14, 2020 at 01:13:53PM -0500, Dennis Dalessandro wrote:
>>>> Was there any discussion on the upgrade scenario for existing deployments as
>>>> far as device-rename changing node descriptions?
>>>>
>>>> If someone is running an older version of rdma-core they are going to have a
>>>> certain set of node descriptions for each node. This could be in logs, or
>>>> configuration databases, who knows what. Now if they upgrade to a new
>>>> version of rdma-core their node descriptions all automatically change out
>>>> from under them by default.
>>>>
>>>> Of course the admin could disable the rename prior to upgrade and as Leon
>>>> pointed out previously the upgrade won't remove the disablement file. The
>>>> problem is they would have to know to do that ahead of time.
>>>
>>> Dennis,
>>>
>>> It was discussed and the conclusion was that most if not all users are
>>> using one of two upgrade and strategy.
>>
>> Do you have a pointer to a thread I can read, I apparently missed it?
> 
> First, we started to talk about it even before patches were sent.
> See this summary from LPC 2017:
>   * the sysadmin will be able to disable this for "backward support"
> https://lore.kernel.org/linux-rdma/20170917125603.GA5788@mtr-leonro.local/
> Second, during the submission too, just need to continue to google it :)

So it was discussed at a meeting 2 years ago that not everyone was at, I 
certainly wasn't, and you summarized with:

		* predictable or persistent device names?
			* need to be able to rename a device

That's not very helpful. Even Jason's presentation that is linked there 
does not address the down side to the node rename especially as far as 
the impact to node description is concerned.

I have looked at the original submission and again I don't see any 
mention of the node description problem. Just an admission that the 
names are harder to read and not what everyone is used to but being 
consistent in scripts is much more important [1].

I'd have to say the script angle is far less important than 
configuration files for thousands of nodes of a large deployment being 
obsoleted without an end user's knowledge beforehand.

>>
>>> First option is to rely on distro and every distro behaves differently
>>> in such cases, some of them won't change anything till their last user
>>> dies :) and others more dynamic with more up-to-date packages already
>>> adopted our default.
>>
>> This is the issue I see. The problem is when the distro doesn't know any
>> better and pulls in a new rdma-core and breaks things unintentionally. Up to
>> date is good, but up to date that brings with it what is essentially an ABI
>> breakage is not.
> 
> ABI breakage is a strong word, luckily enough it is not defined at all.
> We never considered dmesg prints, device names, device ordering as an
> ABI. You can't rely on debug features too, they can disappear too.

Agree, it is a strong word and we can call it what you want. The point 
is you should be able to rely on the node description not being changed 
out from under you unnecessarily though. We aren't talking about a debug 
feature here but a core feature to real world deployments.

Could you envision a patch to a user space library that just changes a 
devices hostname to something that was HW specific because it makes 
scripting easier? I contend that in some cases the node description 
remaining constant is just as important.

> So the bottom line, the expectation that distro should fix all broken
> software before enabling device renaming and their bugs are not excuse
> to declare ABI breakage.

Again, call it what you want, but you can't deny this change to force 
the rename by default has not broken things. For the record I'm not even 
talking about PSM2 here. There are other, more far reaching implications.

>>
>>> Second option is to use numerous OFED stacks, which are expected to
>>> provide full upgrade to all components which will work smoothly.
>>
>> Yeah I'm sure OFED will handle things for themselves.
> 
> At the end, OFED stacks behave like "mini-distros", so if they manage to
> handle it, distro should do the same.
  The difference there is to the distro the RDMA sub system is but one 
small part. To OFED it is the sole focus. So I expect OFED stacks to be 
more agile at handling this sort of thing.

[1]https://patchwork.kernel.org/patch/10870445/

-Denny
