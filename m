Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC42A623D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 11:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgKDKkT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 05:40:19 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13430 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgKDKkR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 05:40:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa285120004>; Wed, 04 Nov 2020 02:40:18 -0800
Received: from [172.27.14.161] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 10:40:14 +0000
Subject: Re: pyverbs test regression
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
 <20201104000020.GU2620339@nvidia.com>
From:   Edward Srouji <edwards@nvidia.com>
Message-ID: <5a02bf4d-c864-124a-38ea-0911686737ea@nvidia.com>
Date:   Wed, 4 Nov 2020 12:40:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201104000020.GU2620339@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604486418; bh=3kMGXT3ahymaVOTE8+oUQfomL6u3eC70IX8Fqpu5Hac=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=B3LvDi7HKF6B52Jix+ubwz1jc3k5Q43HUFINmVhhQzC1Ktr/Dm+EAirsvNdnpMsRh
         urbVb+7l31cfJtO+ZjTlmIr3v/xK7eksWWTn5F9iEcTMj36q1wFVJzj/DSfxrwTmUB
         9lH6afALUmprOz8p9ryiyBjsLHU4aCTtYl1IJzVf0QlG27j15oxYqW88OB4BpAqugW
         uU17OBAIBoP/85m4W1Tj1e4UBubV1EYqn3L+hZ/FzlfboBO9rAGKvQNSmSiZaAKrjt
         rCvwUnhUeOZ95vNoLjTOCF4LrP0puM1Lk8oyclDnk9Wqby9Z1Uhi44Z+Bd3Q6hpNkq
         PUy+681+ar6tQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 11/4/2020 2:00 AM, Jason Gunthorpe wrote:
> On Tue, Nov 03, 2020 at 05:54:58PM -0600, Bob Pearson wrote:
>> Since 5.10 some of the pyverbs tests are skipping with the warning
>> 	"Device rxe_0 doesn't have net interface"
>>
>> These occur in tests/test_rdmacm.py. As far as I can tell the error occurs in
>>
>> RDMATestCase _add_gids_per_port after the following
>>
>> 	    if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
>>                  self.args.append([dev, port, idx, None])
>>                  continue
>>
>> In fact there is no such path which means it never finds an ip_addr for the device.
> That isn't an acceptable way to find netdevs for a RDMA device..
>
> This test is really buggy, that is not an acceptable way to find the
> netdev for a RDMA device. Looks like it is some hacky way to read the
> gid table? It should just read the gid table.. Edward?

GID table is not the reason. We need the netdev in order to get the IP 
address of the interface.

Do you have a better alternative suggestion to do that?

>> Did something change here? Do other RDMA devices have /sys/class/infiniband/XXX/device/net?
> Yes, some will

Nothing really changed in this area lately (in pyverbs / rdma-core tests).

RXE can also have a netdev here if it's linked to one. E.g. by doing 
"rdma link add <rxe_devname> type rxe netdev <net_devname>"

>
> Jason
