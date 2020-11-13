Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61F82B23CB
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 19:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgKMSbJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Nov 2020 13:31:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:43188 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKMSbJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Nov 2020 13:31:09 -0500
IronPort-SDR: LlgwLaW5+HsH5lZJxUZ10x2lSecGKDS7y0AzaPA35nFO/8sQ/I4zylzatGadHMIXysfNgLlTEv
 8rJSHZQx/5AQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="188533795"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="188533795"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 10:31:09 -0800
IronPort-SDR: RdsImr+0BIfBRTiHcRWzA7YA/RX73RTlodY8/OL7HxjIXQGvM2HMpynS2haLRPM914t195EQlg
 mn/8oeeDYEtA==
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="542748483"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 10:31:08 -0800
Date:   Fri, 13 Nov 2020 10:31:08 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, Jann Horn <jannh@google.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH for-rc v2] IB/hfi1: Move cached value of mm into handler
Message-ID: <20201113183108.GA709632@iweiny-DESK2.sc.intel.com>
References: <20201112025837.24440.6767.stgit@awfm-01.aw.intel.com>
 <20201112171439.GT3976735@iweiny-DESK2.sc.intel.com>
 <b45c2303-a78e-a3b6-fcd2-371886caf788@cornelisnetworks.com>
 <ba7df075-ab50-3344-aacb-656ae10b517a@cornelisnetworks.com>
 <20201113003357.GW3976735@iweiny-DESK2.sc.intel.com>
 <d423534f-806d-317c-d51d-46f1f104a7e6@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d423534f-806d-317c-d51d-46f1f104a7e6@cornelisnetworks.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 13, 2020 at 08:37:39AM -0500, Dennis Dalessandro wrote:
> On 11/12/2020 7:33 PM, Ira Weiny wrote:
> > So I think the final point is the key to fixing the bug.  Keeping any
> > current->mm which is not the one we opened the file with...  (or more
> > specifically the one which first registered memory).  In some ways this may be
> > worse than before because technically the parent could open the fd and hand it
> > to the child and have the child register with it's mm.  But that is ok
> > really...  May just be odd behavior for some users depending on what operations
> > they do and in what order.
> 
> I don't think that's worse than before.

'worse' was a bad word...  sorry.  I just meant that the new code opens up the
opportunity to get it to work with the child when this is really not the way I
the API was intended...  But now I am just bike shedding...  ;-)

> Before we were letting it operate on
> the wrong mm. That's so much worse. Yes, parent could open fd and hand it
> off, which is OK. The "odd" behavior is up to whoever wrote the user space
> code to do that in the first place.
> 
> > [1] Also, you probably should credit Jann for the idea with a suggested by tag.
> 
> Will change reported-by to suggested-by.

Ah yea both are appropriate.  I'm not an expert on if both should be tagged or
not...  But to me it seems suggested-by is a bit stronger because a solution
was provided beyond just a bug reported.

Ira

> 
> -Denny
> 
