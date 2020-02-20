Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5B165506
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 03:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgBTC0o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 21:26:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:13781 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgBTC0o (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 21:26:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 18:26:43 -0800
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="scan'208";a="229323554"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.151]) ([10.254.204.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2020 18:26:42 -0800
Subject: Re: RDMA device renames and node description
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Honggang LI <honli@redhat.com>,
        Gal Pressman <galpress@amazon.com>
References: <5ae69feb-5543-b203-2f1b-df5fe3bdab2b@intel.com>
 <20200218140444.GB8816@unreal>
 <1fcc873b-3f67-2325-99cc-21d90edd2058@intel.com>
 <20200219071129.GD15239@unreal>
 <bea50739-918b-ae6f-5fac-f5642c56f1da@intel.com>
 <20200219165800.GS31668@ziepe.ca>
 <03a8dd71-4031-4800-349f-525a013c2101@intel.com>
 <20200219231826.GD31320@iweiny-DESK2.sc.intel.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <eed7f39c-f993-0c29-9f14-7f6ec9ca1e8c@intel.com>
Date:   Wed, 19 Feb 2020 21:26:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219231826.GD31320@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/19/2020 6:18 PM, Ira Weiny wrote:
> The use of node descriptor was intended to be entirely up to the installation
> in a manner to debug/locate nodes.  Not be used in libraries.  I'm surprised
> that libraries are broken.

Libraries are broken due to the rename of the device. The changing of 
the node descriptor is another consequence of the device rename. 
Libraries can be patched. Node descriptors changing out from under a sys 
admin is another problem altogether.

  > Regardless does the old rdma-ndd config exist?  Could it be 
configured and/or
> modified to give the old names?  When it was written we designed the default
> config to give the old names for backwards compatibility.  Apparently this is
> no longer true?

I'm sure there are ways to get back to the old name. The problem is what 
happens by default when users upgrade.

-Denny
