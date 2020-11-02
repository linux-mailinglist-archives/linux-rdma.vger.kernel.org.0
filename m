Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F12A2F75
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgKBQQS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 11:16:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:14208 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgKBQQS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 11:16:18 -0500
IronPort-SDR: d2MslnZwE82kIWnMush4NDXyzJvQykBY49dLpRxZVc84qemSBXEbK2oc7Ybo3rR5ruxQWvnauN
 xPEP3bPIvUvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="230540023"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="230540023"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 08:16:17 -0800
IronPort-SDR: hWoEzq7IsQfsEKHi5DL2TWjkeAoGLdsTzz8bod4EQ5NFB0o9PLqdl+ck07SI6lkOVdbMXSpvA9
 l/RrNsQKiqlA==
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="538076229"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 08:16:17 -0800
Date:   Mon, 2 Nov 2020 08:16:17 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Changming Liu <liu.changm@northeastern.edu>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        yaohway <yaohway@gmail.com>
Subject: Re: How to fuzz testing infiniband/uverb driver
Message-ID: <20201102161617.GE971338@iweiny-DESK2.sc.intel.com>
References: <BN6PR06MB2532A875B6C3AC57072570B6E5130@BN6PR06MB2532.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR06MB2532A875B6C3AC57072570B6E5130@BN6PR06MB2532.namprd06.prod.outlook.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 01, 2020 at 09:00:13PM +0000, Changming Liu wrote:
> 
> there is no 'uverbs0' file created under /sys/class/infiniband or 
> /dev/infiniband/. So may I ask how to properly set up my testing 
> environment so that I can fuzzi testing this driver? Is a physical
> device required?

A physical device is not required.  Look at one of the software drivers like
rxe.

Ira

