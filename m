Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B7165EE4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 14:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgBTNeE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 08:34:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:28598 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgBTNeE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 08:34:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 05:34:03 -0800
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="229480224"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.151]) ([10.254.204.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2020 05:34:01 -0800
Subject: Re: [PATCH rdma-next 1/2] RDMA/ipoib: Don't set constant driver
 version
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20200220071239.231800-1-leon@kernel.org>
 <20200220071239.231800-2-leon@kernel.org>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <dc3541f9-720c-7f6c-2073-df5f2b446fa3@intel.com>
Date:   Thu, 20 Feb 2020 08:34:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220071239.231800-2-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/20/2020 2:12 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> There is no need to set driver version in in-tree kernel code.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>   drivers/infiniband/ulp/ipoib/ipoib.h         | 2 --
>   drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 3 ---
>   drivers/infiniband/ulp/ipoib/ipoib_main.c    | 4 ----
>   3 files changed, 9 deletions(-)
>

Same comments as the other patch, can we just remove the field from the 
drvinfo struct altogether.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

