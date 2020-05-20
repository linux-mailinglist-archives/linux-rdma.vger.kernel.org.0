Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759421DACCF
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETIDN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 04:03:13 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:39581 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETIDM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 May 2020 04:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589961792; x=1621497792;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3Dbmbql2foAIe75NYiHO1L4m3BAUUE1IAtE2cMLKLSk=;
  b=hOGzhhS52rUMtsp3l0u/ASRr1LgI8mz8UZ4vu/sAq8C401zwRAlRJfZh
   3onnlU5t6MwqJKYGtYMHRb/wAMkIX6EWDbBDDsZxeIyXY+y3Vd1tFPcpt
   z9uL1m4mQ9Juq20oeTCnInh/WZST2OwfTjz4aymq/4PwyOjfe6jGcC5sc
   U=;
IronPort-SDR: Eu37EJ9oB50m0G/9r/a6l6VOaZI2rPNvBWScTdS4yLhdQ/bKZ9qfhggmSkyGfYZsztUvoFGRhi
 erv/e4BWgLQw==
X-IronPort-AV: E=Sophos;i="5.73,413,1583193600"; 
   d="scan'208";a="31309673"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 20 May 2020 08:03:11 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id C405BA22E5;
        Wed, 20 May 2020 08:03:10 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 May 2020 08:03:09 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.193) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 May 2020 08:03:05 +0000
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Fix setting of wrong bit in
 get/set_feature commands
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20200512152204.93091-1-galpress@amazon.com>
 <20200512152204.93091-2-galpress@amazon.com> <20200520000428.GA6797@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <1a80d736-3fde-0aca-f04a-d416742bf3ff@amazon.com>
Date:   Wed, 20 May 2020 11:03:00 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520000428.GA6797@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.193]
X-ClientProxiedBy: EX13D19UWA004.ant.amazon.com (10.43.160.102) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/05/2020 3:04, Jason Gunthorpe wrote:
> On Tue, May 12, 2020 at 06:22:03PM +0300, Gal Pressman wrote:
>> When using a control buffer the ctrl_data bit should be set in order to
>> indicate the control buffer address is valid, not ctrl_data_indirect
>> which is used when the control buffer itself is indirect.
>>
>> Reviewed-by: Firas JahJah <firasj@amazon.com>
>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>>  drivers/infiniband/hw/efa/efa_com_cmd.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> No fixes line??

The reason I didn't add a fixes line (and sent it to for-next) is that it turns
out this is the first set feature command to use a control buffer so nothing was
broken, but this is necessary for patch #2 to work.
