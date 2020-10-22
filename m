Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751EB295E15
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Oct 2020 14:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503743AbgJVMMy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Oct 2020 08:12:54 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:60178 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503681AbgJVMMy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Oct 2020 08:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603368773; x=1634904773;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2WqRAFLV7OMC65B3cQBiUEPWAqSWuZohwvqkMWlPJ2U=;
  b=VwdnoXgwcvnrfQr1J71g6PUvYh7a04r5jEeFiuxwtMzSODGyORVtkS5U
   vd7iNqEyYyHouyrFVTFMa4DevAw0ISmbJ3O3+n6DOocZoxMfqfGeM3pDq
   ud6puvafqpgHDkgDpLv3vZcWQ7Iolpc08xSox10WEoymNd5SyIS+C6Uha
   0=;
X-IronPort-AV: E=Sophos;i="5.77,404,1596499200"; 
   d="scan'208";a="62669691"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 22 Oct 2020 12:12:46 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id C304FA1F53;
        Thu, 22 Oct 2020 12:12:45 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.24) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 22 Oct 2020 12:12:41 +0000
Subject: Re: New GID query API broke EFA
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
CC:     Avihai Horon <avihaih@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        "Leybovich, Yossi" <sleybo@amazon.com>
References: <3e956560-3c76-5f4b-b8fa-ad96483cd042@amazon.com>
 <20201022112100.GE2611066@unreal> <20201022121035.GX6219@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <460e8221-6837-0428-7401-52d2ef5d8a4c@amazon.com>
Date:   Thu, 22 Oct 2020 15:12:36 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201022121035.GX6219@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.24]
X-ClientProxiedBy: EX13D43UWC002.ant.amazon.com (10.43.162.172) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/10/2020 15:10, Jason Gunthorpe wrote:
> On Thu, Oct 22, 2020 at 02:21:00PM +0300, Leon Romanovsky wrote:
>> On Thu, Oct 22, 2020 at 01:58:29PM +0300, Gal Pressman wrote:
>>> Hi all,
>>>
>>> The new IOCTL query GID API 9f85cbe50aa0 ("RDMA/uverbs: Expose the new GID query
>>> API to user space") currently breaks EFA, as ibv_query_gid() no longer works.
>>>
>>> The problem is that the IOCTL call checks for:
>>>     if (!rdma_ib_or_roce(ib_dev, port_num))
>>>             return -EOPNOTSUPP;
>>>
>>> EFA is neither of these, but it uses GIDs.
>>>
>>> Any objections to remove the check? Any other solutions come to mind?
>>
>> We added this check to protect access to rdma_get_gid_attr() for devices
>> without GID table.
>>  1234         table = rdma_gid_table(device, port_num);
>>  1235         if (index < 0 || index >= table->sz)
>>  1236                 return ERR_PTR(-EINVAL);
>>
>> So you can extend that function to return for table == NULL an error and
>> remove rdma_ib_or_roce()
> 
> How does table == NULL ever?

A driver with gid_tbl_len == 0 would make the allocation return NULL, no?
