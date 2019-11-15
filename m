Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B76FD6FC
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2019 08:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKOHaK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Nov 2019 02:30:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbfKOHaK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Nov 2019 02:30:10 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6BF7016B954B07E5B9AD;
        Fri, 15 Nov 2019 15:30:00 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 15:29:53 +0800
Subject: =?UTF-8?B?UmU6IOOAkHF1ZXN0aW9u44CR?=
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <8bc6ad1f-075a-e4d4-e5ac-c14de41c4a47@huawei.com>
 <d006cbf9-cbf6-3958-0a83-4d474f6e16d6@morey-chaisemartin.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <93e66037-3c92-6e58-5e04-3412368bb6b9@huawei.com>
Date:   Fri, 15 Nov 2019 15:29:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <d006cbf9-cbf6-3958-0a83-4d474f6e16d6@morey-chaisemartin.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/11/15 14:41, Nicolas Morey-Chaisemartin 写道:
> Hi,
>
> On 11/15/19 3:48 AM, oulijun wrote:
>> Hi, Nicolas Morey-Chaisemartin
>>    I noticed that the rdma-core repository has a suse directory. What is he used for?
> It contains the SUSE specific scripts and the spec file for the rdma-core RPM
OK， thanks

>> If I want to use the suse system directly, there is a user-mode driver for the rdma-core.Can he use it directly?
> I'm not sure I understand what you are trying to do here.
> rdma-core RPM should be available from SUSE repo on all recent distros.
> For development purposes you could also build and use the upstream version. Easiest/cleanest way is probably to use cbuild to generate RPMs for you.
Yes. I mean, if I get a suse iso, is there a matching rdma-core version and directly run rdma app
>
> Nicolas
>
> .
>


