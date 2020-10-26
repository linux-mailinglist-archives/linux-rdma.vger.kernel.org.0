Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1336298FA9
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 15:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781837AbgJZOmc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 10:42:32 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:59599 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781681AbgJZOmc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Oct 2020 10:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603723352; x=1635259352;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Zill1pUuo+nkHeeNq/mAVl0OAHizrzmB8AWW8UBFl1Y=;
  b=BFa1KzFk+bpZTzYKoqyZxh+3G6cRxa2YXmfRaAHwppgoPOtEWqEc+uFS
   CTqvZR7MNCFvzHmzoaiFsvJw8W94PPdoVDUxG06lpUmV6Nx1QKPNQxtJC
   1HovY5Lknc+EyMB/cSqqDJpfuVJKzM+vz4GP6KFQkGNWGntc4lAISBGSA
   8=;
X-IronPort-AV: E=Sophos;i="5.77,419,1596499200"; 
   d="scan'208";a="80391384"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 26 Oct 2020 14:42:24 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id DB36FC0A5F;
        Mon, 26 Oct 2020 14:42:21 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.144) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 26 Oct 2020 14:42:17 +0000
Subject: Re: [PATCH rdma-next 3/6] RDMA/mlx5: Use
 mlx5_umem_find_best_quantized_pgoff() for WQ
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>,
        "majd@mellanox.com" <majd@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@mellanox.com>
References: <20201026132635.1337663-1-leon@kernel.org>
 <20201026132635.1337663-4-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <94d30486-1909-f044-b59c-ba52e0b1e0e9@amazon.com>
Date:   Mon, 26 Oct 2020 16:42:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026132635.1337663-4-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.144]
X-ClientProxiedBy: EX13D31UWA002.ant.amazon.com (10.43.160.82) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 26/10/2020 15:26, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> This fixes a subtle bug, the WQ mailbox has only 5 bits to describe the
> page_offset, while mlx5_ib_get_buf_offset() is hard wired to only work
> with 6 bit page_offsets.
> 
> Thus it did not properly reject badly aligned buffers.
> 
> YISHAI: WTF? Why does this PRM command only have 5 bits? We must force 4k
> alignment for WQ umems in the userspace?

You forgot to remove those :).
