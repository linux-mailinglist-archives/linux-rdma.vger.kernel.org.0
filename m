Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68910398414
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 10:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhFBIaV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 2 Jun 2021 04:30:21 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3383 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhFBIaV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Jun 2021 04:30:21 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fw2Br03Jlz67S3;
        Wed,  2 Jun 2021 16:24:52 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:28:33 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:28:32 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Wed, 2 Jun 2021 16:28:32 +0800
From:   liweihang <liweihang@huawei.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, chenglang <chenglang@huawei.com>
Subject: Re: [PATCH v2 for-next 3/7] RDMA/hns: Use new interface to modify QP
 context
Thread-Topic: [PATCH v2 for-next 3/7] RDMA/hns: Use new interface to modify QP
 context
Thread-Index: AQHXVhzXF+kB4ZPb2kapX2a5uLt4QQ==
Date:   Wed, 2 Jun 2021 08:28:32 +0000
Message-ID: <3670a41073ee412c8b1c941e15423664@huawei.com>
References: <1622465974-20415-1-git-send-email-liweihang@huawei.com>
 <1622465974-20415-4-git-send-email-liweihang@huawei.com>
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

On 2021/5/31 20:59, liweihang wrote:
> +#define QPC_OWNER_MODE QPC_FIELD_LOC(1536, 1536)
> +#define QPC_CIRE_SLV_SQ_EN QPC_FIELD_LOC(1537, 1537)
> +#define QPC_CIRE_DOING QPC_FIELD_LOC(1538, 1538)
> +#define QPC_CIRE_RESULT QPC_FIELD_LOC(1539, 1539)
> +#define QPC_OWNER_DB_WAIT_DO QPC_FIELD_LOC(1540, 1540)
> +#define QPC_SQ_WQE_INVLD QPC_FIELD_LOC(1541, 1541)
> +#define QPC_DCA_MODE QPC_FIELD_LOC(1542, 1542)
> +#define QPC_RTY_OWNER_NOCHK QPC_FIELD_LOC(1543, 1543)
> +#define QPC_V2_IRRL_HEAD QPC_FIELD_LOC(1543, 1536) //

This '//' is added by mistake, I will resend this series, thanks.

Weihang

> +#define QPC_SQ_MAX_PSN QPC_FIELD_LOC(1567, 1544)
> +#define QPC_SQ_MAX_IDX QPC_FIELD_LOC(1583, 1568)

