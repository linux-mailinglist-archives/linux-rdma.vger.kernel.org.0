Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7EB2183FD
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 11:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgGHJl2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 8 Jul 2020 05:41:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2567 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbgGHJl2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 05:41:28 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 5921894B756752CBE5A8
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2020 17:41:27 +0800 (CST)
Received: from dggema701-chm.china.huawei.com (10.3.20.65) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 8 Jul 2020 17:41:27 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema701-chm.china.huawei.com (10.3.20.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 8 Jul 2020 17:41:26 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Wed, 8 Jul 2020 17:41:26 +0800
From:   liweihang <liweihang@huawei.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>
Subject: Question about IB_QP_CUR_STATE
Thread-Topic: Question about IB_QP_CUR_STATE
Thread-Index: AQHWVQvzdhZOnKQSQUeecEiJVm3Vfg==
Date:   Wed, 8 Jul 2020 09:41:26 +0000
Message-ID: <876ca1eb8667461a9d2e0effb8ee3934@huawei.com>
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

Hi all,

I'm a little confused about the role of IB_QP_CUR_STATE in the enumeration
ib_qp_attr_mask.

In manual page of ibv_modify_qp(), comments of cur_qp_state is "Assume this
is the current QP state". Why we need to get current qp state from users
instead of drivers?

For example, why the users are allowed to modify qp from RTR to RTS again
even if the qp's state in driver and hardware has already been RTS.

I would be appretiate it if someone can help with this.

Weihang
