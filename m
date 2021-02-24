Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA53239E5
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Feb 2021 10:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhBXJvB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 24 Feb 2021 04:51:01 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4636 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhBXJtT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Feb 2021 04:49:19 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Dlrfz49gczYCTm;
        Wed, 24 Feb 2021 17:47:07 +0800 (CST)
Received: from dggema702-chm.china.huawei.com (10.3.20.66) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 24 Feb 2021 17:48:34 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema702-chm.china.huawei.com (10.3.20.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 24 Feb 2021 17:48:34 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.006;
 Wed, 24 Feb 2021 17:48:34 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC rdma-core 0/5] libhns: Add support for Dynamic Context
 Attachment
Thread-Topic: [PATCH RFC rdma-core 0/5] libhns: Add support for Dynamic
 Context Attachment
Thread-Index: AQHW/P+g64h4ciCwYkiRw06zMjvQFw==
Date:   Wed, 24 Feb 2021 09:48:34 +0000
Message-ID: <55238899c6574cbe9fd96094ad4cc5e4@huawei.com>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
 <20210209195359.GT4247@nvidia.com>
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

On 2021/2/10 3:54, Jason Gunthorpe wrote:
> On Sun, Feb 07, 2021 at 11:12:49AM +0800, Weihang Li wrote:
>> The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
>> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
>> enables DCA feature, the WQE's buffer will not be allocated when creating
>> but when the users start to post WRs. This will reduce the memory
>> consumption when there are too many QPs are inactive.
> 
> One a WQE buffer is allocated it still acts as a normal WQE ring
> buffer? So this DCA logic is to remap the send queue buffer based on
> demand for SQEs? How does it interact with the normal max send queue
> entries reported?
> 
> Would like to see proper man pages explaining how this all works for
> rdma-core.
> 
> Jason
> 

Hi Jason,

I'm confused about how to introduce DCA in man pages. Current man pages
in rdma-core can be classifed into public and vendor-defined ones.
For example, ibv_create_qp.3 in libibverbs/man and mlx5dv.7 in
providers/mlx5/man, but most of them is a description for a single
interface. If we want to explain how to use DCA and how does it work,
should we put a hns_dca.x file in providers/hns/man? Or add a file
about hns_dca_open_device() and introduce DCA in it?

And another question, I know the files with a number suffix like
ibv_create_qp.3 is for man pages in linux. What about the markdown files
with .md suffix like ibv_fork_init.3.md? If we want to add a new one about
DCA, which type should we choose?

Thanks
Weihang
