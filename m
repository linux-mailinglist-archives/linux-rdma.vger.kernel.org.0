Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891E31CDC34
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgEKNzA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 11 May 2020 09:55:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730180AbgEKNzA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 09:55:00 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 1F932260B38E5FA80076;
        Mon, 11 May 2020 21:54:58 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.243]) by
 DGGEML403-HUB.china.huawei.com ([fe80::74d9:c659:fbec:21fa%31]) with mapi id
 14.03.0487.000; Mon, 11 May 2020 21:54:48 +0800
From:   liweihang <liweihang@huawei.com>
To:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Questions about masked atomic
Thread-Topic: Questions about masked atomic
Thread-Index: AdYnm7vjyDIKjW3JQkW+0B8JTa36qA==
Date:   Mon, 11 May 2020 13:54:48 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A02359ED3@DGGEML522-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi All,

I have two questions about masked atomic (Masked Compare and Swap & MFetchAdd):

1. The kernel now supports masked atomic, but the it does not support atomic
   operation. Is the masked atomic valid in kernel currently?
2. In the userspace, ofed does not have the corresponding opcode for the masked
   atomic (IB_WR_MASKED_ATOMIC_CMP_AND_SWP, IB_WR_MASKED_ATOMIC_FETCH_AND_ADD),
   and ibv_send_wr also has no related data segment for it. How to support it in
   userspace?

Thanks
Weihang
