Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768E03D6FA7
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 08:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbhG0Gsy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 02:48:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7877 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhG0Gsy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jul 2021 02:48:54 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GYnNN409Tz80Zk;
        Tue, 27 Jul 2021 14:45:08 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 14:48:52 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 27 Jul
 2021 14:48:52 +0800
Subject: Re: [PATCH v2 rdma-core 00/10] libhns: Add support for Dynamic
 Context Attachment
To:     <jgg@nvidia.com>, <leon@kernel.org>
References: <1627356480-41805-1-git-send-email-liangwenpeng@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <ae718121-fafa-832c-f07a-6c81648af359@huawei.com>
Date:   Tue, 27 Jul 2021 14:48:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1627356480-41805-1-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/7/27 11:27, Wenpeng Liang wrote:
> The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
> enables DCA feature, the WQE's buffer will not be allocated when creating
> but when the users start to post WRs. This will reduce the memory
> consumption when there are too many QPs are inactive.
> 
> For more detailed information, please refer to the man pages provided by
> the last patch of this series.
> 
> This series is associated with the kernel one "RDMA/hns: Add support for
> Dynamic Context Attachment", and two RFC versions of this series has been
> sent before.

Sorry, some patches are missing from this patchset. Please ignore this patchset.
