Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3D30832C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jan 2021 02:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhA2BW0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 28 Jan 2021 20:22:26 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4593 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2BWT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 20:22:19 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DRffP08kkzY3sC;
        Fri, 29 Jan 2021 09:20:29 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 09:21:35 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 29 Jan 2021 09:21:35 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.002;
 Fri, 29 Jan 2021 09:21:35 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: Question about the mechanism of RoCEv2 VLAN validation
Thread-Topic: Question about the mechanism of RoCEv2 VLAN validation
Thread-Index: AQHW9X8IxKfQwUKiHkePfWN8w4hMZA==
Date:   Fri, 29 Jan 2021 01:21:35 +0000
Message-ID: <f65510d97b87414c8c0ddcf608ada862@huawei.com>
References: <ff917571dbae45fe9c9d840bac400404@huawei.com>
 <20210128141136.GF4247@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/1/28 22:12, Jason Gunthorpe wrote:
> On Thu, Jan 28, 2021 at 02:08:21PM +0000, liweihang wrote:
> 
>> UD is connectionless-oriented, an UD QP won't record VLAN info in it's QPC,
>> so how to achieve the checking mechanism? Or a UD QP should just ignore the
>> unmatched VLAN ID?
> 
> Right, UD QPs recieve all packets for the entire device that match the
> UD QPN
> 
> They indirectly report the incoming gid table index they were matched
> with in the completion and the first 40 bytes
> 
> If an app only wants to look at certain gid table entries then it is
> up to the app to filter
> 
> Jason
> 

Thank you, Jason. It's really helpful.

Weihang
