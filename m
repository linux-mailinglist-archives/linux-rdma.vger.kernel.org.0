Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1182B1BFB
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 14:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgKMNih (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Nov 2020 08:38:37 -0500
Received: from [192.55.52.120] ([192.55.52.120]:52334 "EHLO mga04.intel.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgKMNih (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Nov 2020 08:38:37 -0500
IronPort-SDR: tfYLtipSQyLaMAB3TDkMvgseZRyB1wllq6ensrA1fZ5tB2TZeUIg57AVXnESYPJcG4f3NIHWX5
 2leCj1keT6ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="167892656"
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="167892656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 05:37:44 -0800
IronPort-SDR: qfPd63oDbHJ+QFUJqHY6NNuX8RBeWdVtOV/FE/hkJTkfhbp4NuQl2y1zoEbocJcoUVpU/uR8+c
 b6uVYExJINeA==
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="542657881"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.205.99]) ([10.254.205.99])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 05:37:42 -0800
Subject: Re: [PATCH for-rc v2] IB/hfi1: Move cached value of mm into handler
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, Jann Horn <jannh@google.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20201112025837.24440.6767.stgit@awfm-01.aw.intel.com>
 <20201112171439.GT3976735@iweiny-DESK2.sc.intel.com>
 <b45c2303-a78e-a3b6-fcd2-371886caf788@cornelisnetworks.com>
 <ba7df075-ab50-3344-aacb-656ae10b517a@cornelisnetworks.com>
 <20201113003357.GW3976735@iweiny-DESK2.sc.intel.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <d423534f-806d-317c-d51d-46f1f104a7e6@cornelisnetworks.com>
Date:   Fri, 13 Nov 2020 08:37:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201113003357.GW3976735@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/12/2020 7:33 PM, Ira Weiny wrote:
> So I think the final point is the key to fixing the bug.  Keeping any
> current->mm which is not the one we opened the file with...  (or more
> specifically the one which first registered memory).  In some ways this may be
> worse than before because technically the parent could open the fd and hand it
> to the child and have the child register with it's mm.  But that is ok
> really...  May just be odd behavior for some users depending on what operations
> they do and in what order.

I don't think that's worse than before. Before we were letting it 
operate on the wrong mm. That's so much worse. Yes, parent could open fd 
and hand it off, which is OK. The "odd" behavior is up to whoever wrote 
the user space code to do that in the first place.

> [1] Also, you probably should credit Jann for the idea with a suggested by tag.

Will change reported-by to suggested-by.

-Denny

