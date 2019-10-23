Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE339E1988
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 14:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405178AbfJWMDY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 08:03:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:57027 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731954AbfJWMDY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 08:03:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 05:03:23 -0700
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="210019720"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.201.232]) ([10.254.201.232])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 23 Oct 2019 05:03:21 -0700
Subject: Re: [PATCH 05/12] infiniband: fix ulp/opa_vnic/opa_vnic_encap.h
 kernel-doc notation
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, rd.dunlab@gmail.com
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-doc@vger.kernel.org
References: <20191010035239.532908118@gmail.com>
 <20191010035239.890311169@gmail.com> <20191022175215.GA26528@ziepe.ca>
 <e6be1ddd-c32f-4f8a-4528-7393d5997755@infradead.org>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <1909a6b4-ae13-7c00-ae24-22b3e717ebdd@intel.com>
Date:   Wed, 23 Oct 2019 08:03:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e6be1ddd-c32f-4f8a-4528-7393d5997755@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/22/2019 3:51 PM, Randy Dunlap wrote:
> On 10/22/19 10:52 AM, Jason Gunthorpe wrote:
>> On Wed, Oct 09, 2019 at 08:52:44PM -0700, rd.dunlab@gmail.com wrote:
>>> Make reserved struct fields "private:" so that they don't need to
>>> be added to the kernel-doc notation. This removes 24 warnings.
>>
>>> +++ linux-next-20191009/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
>>> @@ -129,21 +129,31 @@ struct opa_vesw_info {
>>>   	__be16  fabric_id;
>>>   	__be16  vesw_id;
>>>   
>>> +	/* private: */
>>>   	u8      rsvd0[6];
>>> +	/* public: */
>>>   	__be16  def_port_mask;
>>
>> This seems overly ugly, is there some other way to handle these
>> reserved fields? Maybe wire protocol structures shouldn't be kdoc?
> 
> I don't know of any other way to handle them with kernel-doc.
> Sure, changing the /** to just /* would be one way to hide the
> warnings.  Either this patch or not having them be kernel-doc
> is needed just to "fix" 24 warnings.
> 

I would be in favor of just not including this in kernel-doc at this 
time, but the mess of private/public tags while hard on the eyes doesn't 
really bother me either.

Also wouldn't take this as a statement that wire protocol structures not 
be in kdoc, but just that this one doesn't need to be there.

-Denny
