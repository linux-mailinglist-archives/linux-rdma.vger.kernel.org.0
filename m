Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFBC1DCEEA
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2020 16:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgEUOGw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 10:06:52 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:35150 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgEUOGw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 May 2020 10:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590070012; x=1621606012;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=B4yCVMZbTyh930uGANtI+cq9ESNnMCCi3jYgcrkCqyc=;
  b=oNnnRBIHtRJfkCOh/lgxTWaCHhrS1eECYUmmiwEroiezdKZzR3X1D0mp
   p6xr+Mz/Ewv4/kG9Pi8myZfNsdDTBQYpLfGQid1e8+3mBeolcZFAR61tK
   TBdX5tV4AslrL19xncFWn92RyapJeJ+WpFnUFEw2/Hu15cNXCr/+3ITSP
   s=;
IronPort-SDR: 6/90JaFkxUq2EZm7Efqcj8Qkt3YUihAg888s5M9UY8n2cRJvKiNb5TxC+rZkFTx7kUSzmgWaLJ
 pK36sJ3hBszQ==
X-IronPort-AV: E=Sophos;i="5.73,417,1583193600"; 
   d="scan'208";a="31481883"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 21 May 2020 14:06:40 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 7754BA212B;
        Thu, 21 May 2020 14:06:38 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 21 May 2020 14:06:37 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.65) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 21 May 2020 14:06:33 +0000
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Fix setting of wrong bit in
 get/set_feature commands
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20200512152204.93091-1-galpress@amazon.com>
 <20200512152204.93091-2-galpress@amazon.com> <20200520000428.GA6797@ziepe.ca>
 <1a80d736-3fde-0aca-f04a-d416742bf3ff@amazon.com>
 <20200521135731.GA17583@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <4a6835db-0cc9-e94b-c86f-a8fafef0cf46@amazon.com>
Date:   Thu, 21 May 2020 17:06:28 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521135731.GA17583@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D43UWA004.ant.amazon.com (10.43.160.108) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/05/2020 16:57, Jason Gunthorpe wrote:
> On Wed, May 20, 2020 at 11:03:00AM +0300, Gal Pressman wrote:
>> On 20/05/2020 3:04, Jason Gunthorpe wrote:
>>> On Tue, May 12, 2020 at 06:22:03PM +0300, Gal Pressman wrote:
>>>> When using a control buffer the ctrl_data bit should be set in order to
>>>> indicate the control buffer address is valid, not ctrl_data_indirect
>>>> which is used when the control buffer itself is indirect.
>>>>
>>>> Reviewed-by: Firas JahJah <firasj@amazon.com>
>>>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
>>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>>>>  drivers/infiniband/hw/efa/efa_com_cmd.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> No fixes line??
>>
>> The reason I didn't add a fixes line (and sent it to for-next) is that it turns
>> out this is the first set feature command to use a control buffer so nothing was
>> broken, but this is necessary for patch #2 to work.
> 
> It should probably still have a fixes line in case someone decided to
> backport the 2nd patch. But applied without

Hmm, you're right.
If it isn't too late:
Fixes: e9c6c5373088 ("RDMA/efa: Add common command handlers")

Thanks
