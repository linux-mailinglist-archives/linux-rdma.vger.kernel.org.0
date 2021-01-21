Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BCA2FEB53
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbhAUNPp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 08:15:45 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:19725 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbhAUNPl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 08:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611234941; x=1642770941;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PsfoKx/hyaMVkwjODX746+FLrLtvm5f9cDCj2C4Es9w=;
  b=Rd8BSfa/K00Yq12fLfwlxZl332z2QU0tlpODOWHpYne4NM+eeQ8NbS9q
   bePDTeE7Km4jTvc0jNRHXEB3n7b0HusJhbYNFO/wV+ib+qiI1nMpa7Zjh
   Mp+HcIxSmGmFRR8U4KZTpZANFuGzQldDXdh4xdk74TYuP2xnTLuFV+7pP
   w=;
X-IronPort-AV: E=Sophos;i="5.79,364,1602547200"; 
   d="scan'208";a="112553244"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 21 Jan 2021 13:14:53 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 0709FA1901;
        Thu, 21 Jan 2021 13:14:51 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.132) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 21 Jan 2021 13:14:47 +0000
Subject: Re: [PATCH 03/30] RDMA/hw/efa/efa_com: Stop using param description
 notation for non-params
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Yossi Leybovich <sleybo@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
 <20210121094519.2044049-4-lee.jones@linaro.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <8f803700-e001-7eb8-9ea0-a039201b9509@amazon.com>
Date:   Thu, 21 Jan 2021 15:14:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121094519.2044049-4-lee.jones@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.132]
X-ClientProxiedBy: EX13D12UWC001.ant.amazon.com (10.43.162.78) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/01/2021 11:44, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/infiniband/hw/efa/efa_com.c:801: warning: Excess function parameter 'note' description in 'efa_com_admin_q_comp_intr_handler'
> 
> Cc: Gal Pressman <galpress@amazon.com>
> Cc: Yossi Leybovich <sleybo@amazon.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I would change the subject's prefix to 'RDMA/efa', but other than that looks good:
Acked-by: Gal Pressman <galpress@amazon.com>

Thanks Lee.
