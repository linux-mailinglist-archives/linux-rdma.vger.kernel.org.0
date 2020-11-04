Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53E62A63A5
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 12:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgKDLwA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 06:52:00 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:54483 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgKDLvo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 06:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1604490704; x=1636026704;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YXgOvmfG0v/univVtaD303vvtoaC2hMPjmQU3oqB85I=;
  b=Zf/10A18WhyOGdybx2P+c8lYekq5+2KIxNJo/iOqh6asNHQAGM8dRrYo
   UaiCTJCcw5KNMYRFwkA94BsLWshOXoUotK7ssNn+YCPBCxbePoQXczPFJ
   U1uUg8IXMfORIKL3jJHXceTIBIMEUrNt7Ealok1EBg/wb7YRKSSrlaTHs
   0=;
X-IronPort-AV: E=Sophos;i="5.77,450,1596499200"; 
   d="scan'208";a="91815598"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 04 Nov 2020 11:51:32 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 62833A1F84;
        Wed,  4 Nov 2020 11:47:11 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.237) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 4 Nov 2020 11:47:07 +0000
Subject: Re: pyverbs test regression
To:     Edward Srouji <edwards@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
 <20201104000020.GU2620339@nvidia.com>
 <5a02bf4d-c864-124a-38ea-0911686737ea@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <2e391227-83a7-8999-8024-25e28c114d93@amazon.com>
Date:   Wed, 4 Nov 2020 13:47:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5a02bf4d-c864-124a-38ea-0911686737ea@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D20UWA004.ant.amazon.com (10.43.160.62) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 04/11/2020 12:40, Edward Srouji wrote:
> On 11/4/2020 2:00 AM, Jason Gunthorpe wrote:
>> On Tue, Nov 03, 2020 at 05:54:58PM -0600, Bob Pearson wrote:
>>> Since 5.10 some of the pyverbs tests are skipping with the warning
>>>     "Device rxe_0 doesn't have net interface"
>>>
>>> These occur in tests/test_rdmacm.py. As far as I can tell the error occurs in
>>>
>>> RDMATestCase _add_gids_per_port after the following
>>>
>>>         if not
>>> os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
>>>                  self.args.append([dev, port, idx, None])
>>>                  continue
>>>
>>> In fact there is no such path which means it never finds an ip_addr for the
>>> device.
>> That isn't an acceptable way to find netdevs for a RDMA device..
>>
>> This test is really buggy, that is not an acceptable way to find the
>> netdev for a RDMA device. Looks like it is some hacky way to read the
>> gid table? It should just read the gid table.. Edward?
> 
> GID table is not the reason. We need the netdev in order to get the IP address
> of the interface.
> 
> Do you have a better alternative suggestion to do that?
> 
>>> Did something change here? Do other RDMA devices have
>>> /sys/class/infiniband/XXX/device/net?
>> Yes, some will
> 
> Nothing really changed in this area lately (in pyverbs / rdma-core tests).
> 
> RXE can also have a netdev here if it's linked to one. E.g. by doing "rdma link
> add <rxe_devname> type rxe netdev <net_devname>"

Maybe it was changed in b27e504929d7 ("tests: Verify net interface support on
RDMATestCase"), which made the tests skip if the path doesn't exist, instead of
returning an error and failing the test.

How did these tests work for rxe before if the path doesn't exist?
