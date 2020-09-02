Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29925A854
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgIBJHj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 05:07:39 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:28019 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBJHi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 05:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599037658; x=1630573658;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=DwdsQL93JnGG9v3TJ2epvvrH6/QE6GykfHTmVGH34kg=;
  b=SaNYgeDZun8aZ7GGup1NtCBFaJQz3J7g5m8g6RQwTlyjC4PsC2AbcOpG
   QHrlPay0uPMjKnJ/t0KtDYBDlVw9fpDe5Hptg4Y/QOCDRyJTEAJJyfx55
   6eTektrouqxI2WfnzGHlQ8/0TkPiPS9hl+ZwxDPe8dWxGnn7jsGR9hof4
   c=;
X-IronPort-AV: E=Sophos;i="5.76,381,1592870400"; 
   d="scan'208";a="71709914"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 02 Sep 2020 09:07:36 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id B00A6A062A;
        Wed,  2 Sep 2020 09:07:35 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.183) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Sep 2020 09:07:31 +0000
Subject: Re: [PATCH 13/14] RDMA/mlx5: Use ib_umem_num_dma_blocks()
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Yishai Hadas <yishaih@nvidia.com>
References: <13-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3e8db4b5-86ac-fb59-dd74-fe8f42c170a8@amazon.com>
Date:   Wed, 2 Sep 2020 12:07:26 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <13-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.183]
X-ClientProxiedBy: EX13D22UWC001.ant.amazon.com (10.43.162.192) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02/09/2020 3:43, Jason Gunthorpe wrote:
> For the calls linked to mlx4_ib_umem_calc_optimal_mtt_size() compute the
> number of DMA pages directly based on the returned page_shift. This was
> just being used as a weird default if the algorithm hits the lower limit.
> 
> All other places are just using it with PAGE_SIZE.
> 
> As this is the last call site, remove ib_umem_num_pages().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

The subject line should be fixed to mlx4.
