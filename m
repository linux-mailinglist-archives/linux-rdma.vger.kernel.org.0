Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2A168C3A
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2020 04:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgBVDsO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 22:48:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbgBVDsN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Feb 2020 22:48:13 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33108D351CB03A2E74C1;
        Sat, 22 Feb 2020 11:48:11 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 22 Feb 2020
 11:48:04 +0800
From:   Weihang Li <liweihang@huawei.com>
Subject: Is anyone working on implementing LAG in ib core?
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Message-ID: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
Date:   Sat, 22 Feb 2020 11:48:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

We plan to implement LAG in hns drivers recently, and as we know, there is
already a mature and stable solution in the mlx5 driver. Considering that
the net subsystem in kernel adopt the strategy that the framework implement
bonding, we think it's reasonable to add LAG feature to the ib core based
on mlx5's implementation. So that all drivers including hns and mlx5 can
benefit from it.

In previous discussions with Leon about achieving reporting of ib port link
event in ib core, Leon mentioned that there might be someone trying to do
this.

So may I ask if there is anyone working on LAG in ib core or planning to
implement it in near future? I will appreciate it if you can share your
progress with me and maybe we can finish it together.

If nobody is working on this, our team may take a try to implement LAG in
the core. Any comments and suggestion are welcome.

Thanks,
Weihang

