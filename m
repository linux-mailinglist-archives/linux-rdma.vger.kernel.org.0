Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910BC97FF3
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 18:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfHUQYF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 12:24:05 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:33247 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfHUQYF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 12:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566404645; x=1597940645;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FVsd+EOteoJmLhh67CZiySkaPnEpsNPXs/QO2Is2js8=;
  b=GlK0YViH8xp55c+HhpLMAQIuoeeBpJDjwhviCaa9hTY0iIWSzQxDpRgl
   I2oczgbK12S4wcY+BdjjwoZm74a4ksCbnUUAXctVZ/h+KFGCYJVCUJgz7
   2u/R4p/fnN2FsZ1FjSnl0uT4pLbdD6cPg/uyVqfDxeDPV5L9TML9X7IJB
   U=;
X-IronPort-AV: E=Sophos;i="5.64,412,1559520000"; 
   d="scan'208";a="780521525"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 21 Aug 2019 16:24:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 81F07A24D0;
        Wed, 21 Aug 2019 16:24:02 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 16:24:02 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.137) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 21 Aug 2019 16:23:57 +0000
Subject: Re: [PATCH v7 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
To:     Michal Kalderon <mkalderon@marvell.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <aca72068-1155-6755-4494-0436a5d5a31f@amazon.com>
 <MN2PR18MB31827364A5B64323681D1B4BA1AA0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <cee52133-ae69-3709-6f3c-187382af054f@amazon.com>
 <MN2PR18MB318297E219BB657ED716C3A3A1AA0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <87468101-ace2-b718-fd1c-aa6d84554773@amazon.com>
 <8470780c-7366-dd71-fcb5-372f2c420e8b@amazon.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3b7e92ce-d74c-201d-1ed0-31f8fd360d2a@amazon.com>
Date:   Wed, 21 Aug 2019 19:23:51 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8470780c-7366-dd71-fcb5-372f2c420e8b@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.137]
X-ClientProxiedBy: EX13D13UWA004.ant.amazon.com (10.43.160.251) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/08/2019 15:25, Gal Pressman wrote:
> On 21/08/2019 13:41, Gal Pressman wrote:
>> On 21/08/2019 13:32, Michal Kalderon wrote:
>>> Thanks Gal, 
>>>
>>> I think I found the problem for the issue below, attached a patch that should be applied on top of the series. 
>>> Please let me know if this fixed the issues you are seeing. 
>>> In qedr we work with only single pages, and this issue will only occur with multiple pages. 
>>
>> Will apply and rerun, thanks.
> 
> I see different traces now:

Well it seems that these traces are there regardless of this series, I will
debug separately.
Your fix did make the other traces disappear.
