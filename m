Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA23925FA8B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 14:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgIGMdf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 08:33:35 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2294 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgIGMcp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 08:32:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5627e70000>; Mon, 07 Sep 2020 05:30:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 07 Sep 2020 05:32:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 07 Sep 2020 05:32:45 -0700
Received: from [172.27.12.170] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Sep
 2020 12:32:39 +0000
Subject: Re: [PATCH rdma-next 1/4] lib/scatterlist: Refactor
 sg_alloc_table_from_pages
To:     Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20200903121853.1145976-1-leon@kernel.org>
 <20200903155434.1153934-1-leon@kernel.org> <20200907072912.GA19875@lst.de>
From:   Maor Gottlieb <maorg@nvidia.com>
Message-ID: <2a4b0211-c7a0-2a82-1335-7ed935b92aa2@nvidia.com>
Date:   Mon, 7 Sep 2020 15:32:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200907072912.GA19875@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599481832; bh=vB36ZS5TzpC7eMfT9U7YXNMKeTt+DU0w5HUuBJIhjA4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:Content-Language:X-Originating-IP:
         X-ClientProxiedBy;
        b=HwvTIjsPofXA543PAtAD1r3ScN+KadLzOwar93ZxiWVjM8VyccMcIar+1DOnCCcai
         uhFBsFPWKk7jKIACRKr8HrkT/t9uazUFSTwobWPM3lIjyJ1fcojYgpMAqLj+T87rDZ
         kRTscExWfk0xbDVojnXFZEZ0BZ5O4rsf1080PS/pyHDPX0ZqIPezBRtwC1Y83EtO6H
         9jvovM47QjLjFYlB72OLAJnEl8wosASxncaRATb9mquJYrVGmNTqAOlwJm6MmYyB9i
         3BpcYM6PgceiapPcWZ5H4vB/aDB37RcBrlADijfA38zGcZnMTTjeZnqsQWbLCeh8ng
         3ysl5fd3FtOuw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/7/2020 10:29 AM, Christoph Hellwig wrote:
> On Thu, Sep 03, 2020 at 06:54:34PM +0300, Leon Romanovsky wrote:
>> From: Maor Gottlieb <maorg@nvidia.com>
>>
>> Currently, sg_alloc_table_from_pages doesn't support dynamic chaining of
>> SG entries. Therefore it requires from user to allocate all the pages in
>> advance and hold them in a large buffer. Such a buffer consumes a lot of
>> temporary memory in HPC systems which do a very large memory registratio=
n.
>>
>> The next patches introduce API for dynamically allocation from pages and
>> it requires us to do the following:
>>   * Extract the code to alloc_from_pages_common.
>>   * Change the build of the table to iterate on the chunks and not on th=
e
>>     SGEs. It will allow dynamic allocation of more SGEs.
>>
>> Since sg_alloc_table_from_pages allocate exactly the number of chunks,
>> therefore chunks are equal to the number of SG entries.
> Given how few users __sg_alloc_table_from_pages has, what about just
> switching it to your desired calling conventions without another helper?

I tried it now. It didn't save a lot.=C2=A0 Please give me your decision an=
d=20
if needed I will update accordingly.
