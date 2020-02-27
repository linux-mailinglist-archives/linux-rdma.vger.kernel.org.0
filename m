Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D64531721A3
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 15:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgB0Oz1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 09:55:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:15960 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgB0Oz1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 09:55:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 06:55:26 -0800
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="231862972"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.202.200]) ([10.254.202.200])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Feb 2020 06:55:25 -0800
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
To:     Jason Gunthorpe <jgg@ziepe.ca>, Haim Boozaglo <haimbo@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200224194131.GV31668@ziepe.ca>
 <d3b6297e-3251-ec14-ebef-541eb3a98eae@mellanox.com>
 <20200226134310.GX31668@ziepe.ca> <20200226135749.GE12414@unreal>
 <20200226170946.GA31668@ziepe.ca>
 <1da164dc-9aff-038f-914a-c14d353c9e08@mellanox.com>
 <20200227133341.GG31668@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <b5a619bc-582d-908a-6c6e-5df5bbe4b4b2@intel.com>
Date:   Thu, 27 Feb 2020 09:55:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227133341.GG31668@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/27/2020 8:33 AM, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2020 at 09:48:45AM +0200, Haim Boozaglo wrote:
>>
>>
>> On 2/26/2020 7:09 PM, Jason Gunthorpe wrote:
>>> On Wed, Feb 26, 2020 at 03:57:49PM +0200, Leon Romanovsky wrote:
>>>> On Wed, Feb 26, 2020 at 09:43:10AM -0400, Jason Gunthorpe wrote:
>>>>> On Tue, Feb 25, 2020 at 10:25:49AM +0200, Haim Boozaglo wrote:
>>>>>>
>>>>>>
>>>>>> On 2/24/2020 9:41 PM, Jason Gunthorpe wrote:
>>>>>>> On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> When running "ibstat" or "ibstat -l", the output of CA device list
>>>>>>>> is displayed in an unsorted order.
>>>>>>>>
>>>>>>>> Before pull request #561, ibstat displayed the CA device list sorted in
>>>>>>>> alphabetical order.
>>>>>>>>
>>>>>>>> The problem is that users expect to have the output sorted in alphabetical
>>>>>>>> order and now they get it not as expected (in an unsorted order).
>>>>>>>
>>>>>>> Really? Why? That doesn't look like it should happen, the list is
>>>>>>> constructed out of readdir() which should be sorted?
>>>>>>>
>>>>>>> Do you know where this comes from?
>>>>>>>
>>>>>>> Jason
>>>>>>>
>>>>>>
>>>>>> readdir() gives us struct by struct and doesn't keep on alphabetical order.
>>>>>> Before pull request #561 ibstat have used this API of libibumad:
>>>>>> int umad_get_cas_names(char cas[][UMAD_CA_NAME_LEN], int max)
>>>>>>
>>>>>> This API used this function:
>>>>>> n = scandir(SYS_INFINIBAND, &namelist, NULL, alphasort);
>>>>>>
>>>>>> scandir() can return a sorted CA device list in alphabetical order.
>>>>>
>>>>> Oh what a weird unintended side effect.
>>>>>
>>>>> Resolving it would require adding a sorting pass on a linked
>>>>> list.. Will you try?
>>>>
>>>> Please be aware that once ibstat will be converted to netlink, the order
>>>> will change again.
>>>
>>> This is why I suggest a function to sort the linked list that tools
>>> needing sorted order can call. Then it doesn't matter how we got the list
>>>
>>> Jason
>>>
>>
>> I can just sort the list at the time of insertion of each node.
> 
> I'd rather not have to pay the sorting penalty for all users, it seems
> only a few command line tools need the sort

Should we really go out on limb here and assume it's just a few CLI 
tools? What about all the sysadmin type scripts out there? We aren't 
having a good track record not breaking user space lately.

Is the sorting penalty really going to be that bad? It's not like we 
will have a large number of devices that sorting should really be an 
issue I wouldn't think.

-Denny




