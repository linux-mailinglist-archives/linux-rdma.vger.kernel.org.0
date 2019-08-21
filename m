Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFBA971E2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 08:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfHUGHF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 02:07:05 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:63399 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfHUGHF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 02:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566367624; x=1597903624;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kWMI+juwKRtPJaV9AZ08garuu76Mg5531vsi4q5UgvQ=;
  b=ojLjfq/2Zz+WWY23N+DFf0Yq9t2yvrRFILu75blENKxGKVaKgosp6TiF
   p+6gXM/SvEKkYOS3HW5b/s7jyReyUzA86eQ4WBLzAPWOwiNFpYANxP0f0
   1Fx7plTiNntxUmcQCDLoE8gUgIYI212PgFhSquJg+JFFCVoETC3AEhq1D
   U=;
X-IronPort-AV: E=Sophos;i="5.64,411,1559520000"; 
   d="scan'208";a="416577209"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 21 Aug 2019 06:07:01 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id DF625A2512;
        Wed, 21 Aug 2019 06:07:00 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 06:07:00 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.230) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 06:06:55 +0000
Subject: Re: [PATCH v7 rdma-next 1/7] RDMA/core: Move core content from
 ib_uverbs to ib_core
To:     Michal Kalderon <mkalderon@marvell.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-2-michal.kalderon@marvell.com>
 <0f6f1dd6-e4b3-5261-7480-0735f29bac63@amazon.com>
 <MN2PR18MB3182BE00A39C1A933C584737A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3ba20a5e-8fd6-a42c-0818-7fcaa25a979a@amazon.com>
Date:   Wed, 21 Aug 2019 09:06:40 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR18MB3182BE00A39C1A933C584737A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.230]
X-ClientProxiedBy: EX13D05UWB002.ant.amazon.com (10.43.161.50) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/08/2019 0:32, Michal Kalderon wrote:
>> From: Gal Pressman <galpress@amazon.com>
>> Sent: Tuesday, August 20, 2019 5:08 PM
>>
>> On 20/08/2019 15:18, Michal Kalderon wrote:
>>> diff --git a/drivers/infiniband/core/ib_core_uverbs.c
>> b/drivers/infiniband/core/ib_core_uverbs.c
>>> new file mode 100644
>>> index 000000000000..cab7dc922cf0
>>> --- /dev/null
>>> +++ b/drivers/infiniband/core/ib_core_uverbs.c
>>> @@ -0,0 +1,100 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>> +/*
>>> + * Copyright (c) 2005 Mellanox Technologies. All rights reserved.
>>> + * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights
>> reserved.
>>> + * Copyright 2019 Marvell. All rights reserved.
>>> + *
>>> + * This software is available to you under a choice of one of two
>>> + * licenses.  You may choose to be licensed under the terms of the GNU
>>> + * General Public License (GPL) Version 2, available from the file
>>> + * COPYING in the main directory of this source tree, or the
>>> + * OpenIB.org BSD license below:
>>> + *
>>> + *     Redistribution and use in source and binary forms, with or
>>> + *     without modification, are permitted provided that the following
>>> + *     conditions are met:
>>> + *
>>> + *      - Redistributions of source code must retain the above
>>> + *        copyright notice, this list of conditions and the following
>>> + *        disclaimer.
>>> + *
>>> + *      - Redistributions in binary form must reproduce the above
>>> + *        copyright notice, this list of conditions and the following
>>> + *        disclaimer in the documentation and/or other materials
>>> + *        provided with the distribution.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>> KIND,
>>> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
>> WARRANTIES OF
>>> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
>> COPYRIGHT HOLDERS
>>> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
>> AN
>>> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
>> OR IN
>>> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
>> IN THE
>>> + * SOFTWARE.
>>> + */
>>
>> Is the full license needed in addition to the SPDX?
> The file contains code that was placed in a different file and copyrighted, so I copied
> The copyrights from the original files based on the git history of the code lines I copied.
> Thanks,
> Michal

I'm referring to the license text, not the copyrights.
