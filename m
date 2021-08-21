Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572553F39E6
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 11:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhHUJfb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Aug 2021 05:35:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18025 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhHUJfa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Aug 2021 05:35:30 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GsCtG1cbJzbfwq;
        Sat, 21 Aug 2021 17:31:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 21 Aug 2021 17:34:48 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 21 Aug
 2021 17:34:48 +0800
Subject: Re: [PATCH v4 for-next 00/12] RDMA/hns: Add support for Dynamic
 Context Attachment
To:     <dledford@redhat.com>, <jgg@nvidia.com>
References: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <leon@kernel.org>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <3b0d66e6-2e04-33b7-e6a8-e9a4ca6ec8bf@huawei.com>
Date:   Sat, 21 Aug 2021 17:34:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/7/29 10:19, Wenpeng Liang wrote:
> The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
> enables DCA feature, the WQE's buffer will not be allocated when creating
> but when the users start to post WRs. This will reduce the memory
> consumption when there are too many QPs are inactive.

Hi, Jason.
The comments of v4 have not been fixed yet, but the jgg-for-next branch has
already applied this patchset, should I send v5 or send a fix?

Thanks,
Wenpeng
