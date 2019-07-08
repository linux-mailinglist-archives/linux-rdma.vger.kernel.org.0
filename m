Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5513161FBF
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 15:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfGHNqv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 09:46:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728461AbfGHNqv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 09:46:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9707299EDFDB1F1ADACD;
        Mon,  8 Jul 2019 21:46:48 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 8 Jul 2019
 21:46:39 +0800
Subject: Re: [PATCH for-next 5/8] RDMA/hns: Bugfix for calculating qp buffer
 size
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
 <1561376872-111496-6-git-send-email-oulijun@huawei.com>
 <997bdd68-8be1-9684-5d4d-d0b5bf202b80@huawei.com>
 <20190707122117.GB19566@ziepe.ca>
From:   oulijun <oulijun@huawei.com>
Message-ID: <5afe3df6-5246-3093-5a4f-d0a78f660182@huawei.com>
Date:   Mon, 8 Jul 2019 21:46:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20190707122117.GB19566@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/7/7 20:21, Jason Gunthorpe 写道:
> On Sat, Jul 06, 2019 at 09:47:09AM +0800, oulijun wrote:
>> 在 2019/6/24 19:47, Lijun Ou 写道:
>>> From: o00290482 <o00290482@huawei.com>
>> Hi, Jason
>>    May be my local configuration error causing the wroong author.  How should I make changes?
>>
>> The correct as follows:
>> From: Lijun Ou <oulijun@huawei.com>
> I fixed it this once, but please check and fix it on your end in
> future.
>
> You should be able to set the patch author in git's config file:
>
> [user]
>         email = jgg@mellanox.com
>         name = Jason Gunthorpe
>
> Jason
>
> .
Thanks.



