Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85A06E1316
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 09:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389910AbfJWH0P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 03:26:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:22048 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389351AbfJWH0O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 03:26:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 00:26:14 -0700
X-IronPort-AV: E=Sophos;i="5.68,219,1569308400"; 
   d="scan'208";a="191747859"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 00:26:10 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, rd.dunlab@gmail.com
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 05/12] infiniband: fix ulp/opa_vnic/opa_vnic_encap.h kernel-doc notation
In-Reply-To: <e6be1ddd-c32f-4f8a-4528-7393d5997755@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191010035239.532908118@gmail.com> <20191010035239.890311169@gmail.com> <20191022175215.GA26528@ziepe.ca> <e6be1ddd-c32f-4f8a-4528-7393d5997755@infradead.org>
Date:   Wed, 23 Oct 2019 10:26:07 +0300
Message-ID: <87d0engbxs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 22 Oct 2019, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/22/19 10:52 AM, Jason Gunthorpe wrote:
>> On Wed, Oct 09, 2019 at 08:52:44PM -0700, rd.dunlab@gmail.com wrote:
>>> Make reserved struct fields "private:" so that they don't need to
>>> be added to the kernel-doc notation. This removes 24 warnings.
>> 
>>> +++ linux-next-20191009/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
>>> @@ -129,21 +129,31 @@ struct opa_vesw_info {
>>>  	__be16  fabric_id;
>>>  	__be16  vesw_id;
>>>  
>>> +	/* private: */
>>>  	u8      rsvd0[6];
>>> +	/* public: */
>>>  	__be16  def_port_mask;
>> 
>> This seems overly ugly, is there some other way to handle these
>> reserved fields? Maybe wire protocol structures shouldn't be kdoc?
>
> I don't know of any other way to handle them with kernel-doc.
> Sure, changing the /** to just /* would be one way to hide the
> warnings.  Either this patch or not having them be kernel-doc
> is needed just to "fix" 24 warnings.

The currently available options are:

- The patch at hand (private/public comments). Ugly and verbose.

- Document the structs using regular comments instead of
  kernel-doc. Might be suitable here, but not a generally useful
  approach. Loses all format checking and generated documentation.

- Also document the reserved fields. Ugly and verbose, also in the
  generated documentation.

Some options that I think might be relatively easy to implement:

- Add struct documentation comment indicator to not complain about
  missing member documentation. Some special tag in the struct
  comment. This would also ignore members that actually need to be
  documented.

- Add support for designating private members in the member
  documentation, i.e. require the documentation, but omit the members
  from the generated document. Something like this, with PRIVATE
  replaced with your favorite bikeshed colors:

  /**
   * @rsvd0: PRIVATE
   */

  This could be used either in the struct documentation comment or in
  the inline member documentation comment. Less ugly than the patch at
  hand, and arguably a better notation, but still requires documenting
  the members.

- Add support for a catch-all member documentation comment, for example:

  /**
   * struct foo - bar
   * @*: This member is private.
   */

  Would generate the documentation for the member with the catch-all
  documentation, which might be a generally useful feature, and would be
  easy on the source code side. This could be combined with the PRIVATE
  designation above, practically leading to the same result as the first
  option but with more flexibility.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
