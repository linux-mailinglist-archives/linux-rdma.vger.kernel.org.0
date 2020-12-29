Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF6F2E70E3
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Dec 2020 14:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgL2Nc0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 29 Dec 2020 08:32:26 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2348 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgL2NcZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Dec 2020 08:32:25 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4D4wJq3hGWz13bV5;
        Tue, 29 Dec 2020 21:30:19 +0800 (CST)
Received: from dggema701-chm.china.huawei.com (10.3.20.65) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 29 Dec 2020 21:31:39 +0800
Received: from dggema703-chm.china.huawei.com (10.3.20.67) by
 dggema701-chm.china.huawei.com (10.3.20.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 29 Dec 2020 21:31:39 +0800
Received: from dggema703-chm.china.huawei.com ([10.8.64.130]) by
 dggema703-chm.china.huawei.com ([10.8.64.130]) with mapi id 15.01.1913.007;
 Tue, 29 Dec 2020 21:31:39 +0800
From:   liweihang <liweihang@huawei.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Is it ok to use debugfs to dump some ucontext-level driver-defined
 info?
Thread-Topic: Is it ok to use debugfs to dump some ucontext-level
 driver-defined info?
Thread-Index: AQHW3ebw3F8B3O2FE0G2KEXK5NMuLQ==
Date:   Tue, 29 Dec 2020 13:31:39 +0000
Message-ID: <d681bc1cad0e4726806aeb46f240d07d@huawei.com>
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

Hi all,

We want to dump some hns driver-defined information that belongs to a
process to keep track of current memory usage. For example, there is
a ucontext-level(process-level) memory pool to store WQE which is
shared by a lot of QPs, we want to record and query which QPs are using
this pool and how much space each QP is using.

rdmatool don't have a ucontext-level resource tracking currently, is it
ok to achieve that through debugfs?

This may looks like:

$ echo 1 > <dbgfs_dir>/hns_roce/hns_0/<pid>/qp
QPN        Total(kB)  SQ(kB)     SGE(kB)    RQ(kB)
110        6400       256        2048       4096
118        6400       256        2048       0

Or should it be achieved in rdmatool?

Thanks
Weihang
