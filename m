Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400F13F103D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 04:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhHSCQ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 22:16:59 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:14230 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbhHSCQz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Aug 2021 22:16:55 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GqpK61kCbz1CXTW;
        Thu, 19 Aug 2021 10:15:54 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 10:16:18 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 19 Aug
 2021 10:16:18 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Restore mr status when rereg mr fails
To:     <dledford@redhat.com>, <jgg@nvidia.com>
References: <1629337984-24459-1-git-send-email-liangwenpeng@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <f5a42b02-57f7-4ab6-c81a-cc9a2289f5ab@huawei.com>
Date:   Thu, 19 Aug 2021 10:16:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1629337984-24459-1-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please ignore this patch.
I mistakenly sent two unrelated patches together,
and I will send the two patches separately
