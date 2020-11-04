Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB52A6CBA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 19:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbgKDSem (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 13:34:42 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11430 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgKDSem (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 13:34:42 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa2f4430000>; Wed, 04 Nov 2020 10:34:43 -0800
Received: from [172.27.14.161] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 18:34:40 +0000
Subject: Re: pyverbs test regression
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
 <20201104000020.GU2620339@nvidia.com>
 <5a02bf4d-c864-124a-38ea-0911686737ea@nvidia.com>
 <20201104123634.GV2620339@nvidia.com>
From:   Edward Srouji <edwards@nvidia.com>
Message-ID: <f8921735-296f-ac9d-c3a4-e4475ab2f2c8@nvidia.com>
Date:   Wed, 4 Nov 2020 20:34:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104123634.GV2620339@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604514883; bh=KxWLPnV/02CTMQcK7/l6glhJb+xQVddkNT3DZq2hw6A=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=AfmYXAvSXSscPDKmkci9t0MqIMm4XRs1bhdFgh1aVE89b0JVsXUkHzFvIi61THEOf
         u9QaPa8cMk+VfOj8ROBSHjbH2Tf0rAeLT2pmFbrUGBxhiLGiP/j5IyoRWj/xrPR+Df
         fKlU9g9x2Mv89t/784OK/TIgs4LZ/ygb0Uf1w8ReQEmM16Mp7w6IhECV1bh2zqES35
         f4rXuXHExNxfCX89WyNyy9LVCeyxeTC+NwPiY0NrHhRLv4hgq4vbdXpZKexUjeS6RC
         l6No0DTdfrDUWvFzi8Lx9OvHzWioyloyjI4CIBjnSBDTi+MKUiPb79qHYI6pYx/w2K
         49jWKirkZ6lHA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 11/4/2020 2:36 PM, Jason Gunthorpe wrote:
> On Wed, Nov 04, 2020 at 12:40:11PM +0200, Edward Srouji wrote:
>> On 11/4/2020 2:00 AM, Jason Gunthorpe wrote:
>>> On Tue, Nov 03, 2020 at 05:54:58PM -0600, Bob Pearson wrote:
>>>> Since 5.10 some of the pyverbs tests are skipping with the warning
>>>> 	"Device rxe_0 doesn't have net interface"
>>>>
>>>> These occur in tests/test_rdmacm.py. As far as I can tell the error occurs in
>>>>
>>>> RDMATestCase _add_gids_per_port after the following
>>>>
>>>> 	    if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
>>>>                   self.args.append([dev, port, idx, None])
>>>>                   continue
>>>>
>>>> In fact there is no such path which means it never finds an ip_addr for the device.
>>> That isn't an acceptable way to find netdevs for a RDMA device..
>>>
>>> This test is really buggy, that is not an acceptable way to find the
>>> netdev for a RDMA device. Looks like it is some hacky way to read the
>>> gid table? It should just read the gid table.. Edward?
>> GID table is not the reason. We need the netdev in order to get the IP
>> address of the interface.
> The GID table has a list of all the IP addresses of the IB device, and
> all the netdevs that provide it

Then how can you get the IP address via verbs API(s)? AFAIK, the 
gid_entry does not hold the IP addresses, you can only get the subnet 
prefix, don't you?

>
>>>> Did something change here? Do other RDMA devices have /sys/class/infiniband/XXX/device/net?
>>> Yes, some will
>> Nothing really changed in this area lately (in pyverbs / rdma-core tests).
>>
>> RXE can also have a netdev here if it's linked to one. E.g. by doing "rdma
>> link add <rxe_devname> type rxe netdev <net_devname>"
> No it can't, this is the "parent" device and ib_device can never be a
> parent of a netdev. rxe should have no parent.
>
> Jason
Edward
