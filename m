Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9AE3436BA
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 03:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhCVCn6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 21 Mar 2021 22:43:58 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3314 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVCne (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Mar 2021 22:43:34 -0400
Received: from dggeme708-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4F3dyW52nkz147QC;
        Mon, 22 Mar 2021 10:40:19 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeme708-chm.china.huawei.com (10.1.199.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 22 Mar 2021 10:43:27 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 10:43:27 +0800
From:   liweihang <liweihang@huawei.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        oulijun <oulijun@huawei.com>,
        "huwei87@hisilicon.com" <huwei87@hisilicon.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "dt@kernel.org" <dt@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH] IB/hns: Fix a spelling
Thread-Topic: [PATCH] IB/hns: Fix a spelling
Thread-Index: AQHXHsMDqemTdt75o0mxIdrXWvWfRQ==
Date:   Mon, 22 Mar 2021 02:43:27 +0000
Message-ID: <5d404e23725a4c62b06c4a00875c7312@huawei.com>
References: <20210322022751.4137205-1-unixbhaskar@gmail.com>
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

On 2021/3/22 10:28, Bhaskar Chowdhury wrote:
> 
> s/wubsytem/subsystem/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  .../devicetree/bindings/infiniband/hisilicon-hns-roce.txt       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt b/Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
> index 84f1a1b505d2..c57e09099bcb 100644
> --- a/Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
> +++ b/Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
> @@ -1,7 +1,7 @@
>  Hisilicon RoCE DT description
> 
>  Hisilicon RoCE engine is a part of network subsystem.
> -It works depending on other part of network wubsytem, such as, gmac and
> +It works depending on other part of network subsystem, such as, gmac and
>  dsa fabric.
> 
>  Additional properties are described here:
> --
> 2.31.0
> 
> 

Thank you.

Acked-by: Weihang Li <liweihang@huawei.com>
