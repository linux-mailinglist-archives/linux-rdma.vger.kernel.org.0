Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0713814CAF6
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2020 13:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgA2MoV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jan 2020 07:44:21 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:57353 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgA2MoU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jan 2020 07:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580301860; x=1611837860;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gkcdETw4jRFupZQW3dCV4Iw1V+HOK2bB+IivXdE41HI=;
  b=N2AQlpDQ3wFCNBTmYHjVZWydor+71Fb75Uf4jBtQmmcI5BPUJ+wqY/VL
   0oxcllkPduZZG5hAj6K7HDF9i+rNddnW1ieogXvNlqDWtp3SMc2mPCAHB
   Z7H9XugVB98kbDcsTgLuCht/wzYn55NjzswoG6bbH4Ift5nrwFqG+yChO
   A=;
IronPort-SDR: EGGQSfoSq/ixyCk/PFWHmGHZMLiBtpqrlpV4SpAgCMHg8CZQ/2WxAENe0T7VxRv6PwkFtAH+CH
 6hJdP6dFnHAA==
X-IronPort-AV: E=Sophos;i="5.70,377,1574121600"; 
   d="scan'208";a="14750393"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 29 Jan 2020 12:44:18 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 24806A15D0;
        Wed, 29 Jan 2020 12:44:16 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 29 Jan 2020 12:44:15 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.29) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 Jan 2020 12:43:57 +0000
Subject: Re: [PATCH rdma-next] RDMA/core: Fix protection fault in
 get_pkey_idx_qp_list
To:     Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
References: <20200126171553.4916-1-leon@kernel.org>
 <fceb1026-0fb1-5e4f-d617-01a0bcfa21f8@amazon.com>
 <35d59005-4bab-38dc-c6c1-a1e1f4cbd8be@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <a2028a8f-bf41-44cc-4b65-0df77ec3406c@amazon.com>
Date:   Wed, 29 Jan 2020 14:43:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <35d59005-4bab-38dc-c6c1-a1e1f4cbd8be@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.29]
X-ClientProxiedBy: EX13D22UWC002.ant.amazon.com (10.43.162.29) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 29/01/2020 14:14, Maor Gottlieb wrote:
> 
> On 1/29/2020 2:06 PM, Gal Pressman wrote:
>> On 26/01/2020 19:15, Leon Romanovsky wrote:
>>> From: Maor Gottlieb <maorg@mellanox.com>
>>>
>>> We don't need to set pkey as valid in case that user set only one
>>> of pkey index or port number, otherwise it will be resulted in NULL
>>> pointer dereference while accessing to uninitialized pkey list.
>> Why would the pkey list be uninitialized? Isn't it initialized as an empty list
>> on device registration?
> 
> It will try to access to list of invalid port / pkey, e.g. to list of 
> port 0. port_data is indexed by port number.
> dev->port_data[pp->port_num].pkey_list

Makes sense.
Shouldn't there be a check in the (!qp_pps) section as well? We shouldn't assign
the field unless the mask is given.

Does this work correctly if the user issues two calls to modify_qp where the
first one modifies the pkey index and the second the port number (if that's even
possible)?
Is it expected that the state would stay invalid?
