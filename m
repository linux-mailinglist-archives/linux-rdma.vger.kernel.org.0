Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9FF25F1D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfEVIK5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 04:10:57 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:59974 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfEVIK4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 04:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558512656; x=1590048656;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TVMDp99O7fTVcC+ILvlLFhxwunXP85zu3Bl8XX2VGp8=;
  b=VlE9cByQBmncVJ0j0jQFHfMbzJN+97BuM7rq0+ewCuW2ze4OtqpKBZbM
   xJqu+Yu4jSS7/7mR3Z2JrJgNV1rISVPpFeFGxRA+0D/lN84Y42Vxh5juh
   U/sGRijM0uAUFF7Up9q3EkTd9voXADq16Hsuo/Wkd2AA+HDcG/fzCfPA1
   M=;
X-IronPort-AV: E=Sophos;i="5.60,498,1549929600"; 
   d="scan'208";a="675731254"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 May 2019 08:10:50 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4M8AjTY090027
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 22 May 2019 08:10:47 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 May 2019 08:10:46 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.16) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 May 2019 08:10:42 +0000
Subject: Re: [PATCH for-rc] RDMA/uverbs: Pass udata on uverbs error unwind
To:     <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20190522080643.52654-1-galpress@amazon.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <4a91c9a6-7c06-f633-f64d-e4e26369bd53@amazon.com>
Date:   Wed, 22 May 2019 11:10:37 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522080643.52654-1-galpress@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.16]
X-ClientProxiedBy: EX13D16UWC002.ant.amazon.com (10.43.162.161) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/05/2019 11:06, Gal Pressman wrote:
> When destroy_* is called as a result of uverbs create cleanup flow a
> cleared udata should be passed instead of NULL to indicate that it is
> called under user flow.
> 
> Fixes: bc38a6abdd5a ("[PATCH] IB uverbs: core implementation")
> Fixes: 67cdb40ca444 ("[IB] uverbs: Implement more commands")
> Fixes: 42849b2697c3 ("RDMA/uverbs: Export ib_open_qp() capability to user space")
> Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
> Signed-off-by: Gal Pressman <galpress@amazon.com>

Forgot to mention, this patch is applied on top of Jason's fix:
https://patchwork.kernel.org/patch/10954379/
