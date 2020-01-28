Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF314BC8A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2020 16:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgA1PBt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jan 2020 10:01:49 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:11315 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgA1PBt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jan 2020 10:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580223709; x=1611759709;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5XxmMMxX6by3tchbJIjCuufaljVB1T246eATRTjsifs=;
  b=QuW2jtD3xtblIah61ut7OOno4uXHWouhtjXXi0mvubED1yIVAR5/nDG6
   lRbM0lm+CXdNUDo9O3jguvWnZOjN346yff0J5WA2u11QhtCsugOwaTdz5
   gkXHeCxY9SJKI+hsnjSxqp6mfhg+nlMqQCSfhckILp3HLZtjElab4GX4M
   Q=;
IronPort-SDR: B03eUh26fWnG7IbKCeHEYbCYG0qvsxJ9YjBxHAAODqcVFKc0DxwqXXq07zLp6xeaPb6FcXyBet
 Yz6C4g+SFSbg==
X-IronPort-AV: E=Sophos;i="5.70,374,1574121600"; 
   d="scan'208";a="13675542"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 28 Jan 2020 15:01:47 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 4573FA1B9A;
        Tue, 28 Jan 2020 15:01:43 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 28 Jan 2020 15:01:43 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.117) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 Jan 2020 15:01:39 +0000
Subject: Re: [PATCH rdma-rc] RDMA/umem: Fix ib_umem_find_best_pgsz()
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Leon Romanovsky" <leonro@mellanox.com>
References: <20200128135612.174820-1-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <456e2a2f-3951-6357-9df8-bf17793a04f7@amazon.com>
Date:   Tue, 28 Jan 2020 17:01:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200128135612.174820-1-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.117]
X-ClientProxiedBy: EX13D29UWC003.ant.amazon.com (10.43.162.80) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 28/01/2020 15:56, Leon Romanovsky wrote:
> From: Artemy Kovalyov <artemyko@mellanox.com>
> 
> Except for the last entry, the ending iova alignment sets the maximum
> possible page size as the low bits of the iova must be zero when
> starting the next chunk.
> 
> Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page size in an MR")
> Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

This fixes the issue for EFA, thanks Leon.
Tested-by: Gal Pressman <galpress@amazon.com>
