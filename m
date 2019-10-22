Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6015DFA1B
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 03:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfJVBYT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 21:24:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51966 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727264AbfJVBYT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 21:24:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CE84667279759794311C;
        Tue, 22 Oct 2019 09:24:15 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 22 Oct 2019
 09:24:05 +0800
Subject: Re: [PATCH v2 for-next] RDMA/hns: Release qp resources when failed to
 destroy qp
To:     Doug Ledford <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1570584110-3659-1-git-send-email-liweihang@hisilicon.com>
 <d425d78e2fba5258e3f3c2c4dab02258986775b6.camel@redhat.com>
From:   Weihang Li <liweihang@hisilicon.com>
Message-ID: <d94a8b66-d9e0-0d6f-b6af-12d8731ac58f@hisilicon.com>
Date:   Tue, 22 Oct 2019 09:24:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d425d78e2fba5258e3f3c2c4dab02258986775b6.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/10/22 4:42, Doug Ledford wrote:
> On Wed, 2019-10-09 at 09:21 +0800, Weihang Li wrote:
>> From: Yangyang Li <liyangyang20@huawei.com>
>>
>> Even if no response from hardware, we should make sure that qp related
>> resources are released to avoid memory leaks.
>>
>> Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08
>> SoC")
>>
>> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>>
> 
> Thanks, applied to for-next.  For the future sake, no space between
> Fixes: and Signed-off-by: lines please.  They're all just metadata, they
> don't need to be separated.
> 
OK, thank you.

