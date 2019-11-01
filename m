Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3AEC0BA
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 10:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKAJpB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 05:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfKAJpB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Nov 2019 05:45:01 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15815217D9;
        Fri,  1 Nov 2019 09:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572601500;
        bh=W7nHAsxH7yo/6zXibGLFzLc4Ekgolj/4cGcWogbEi54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fd2+otcviDK5p3ZkrtvhVfxhuLAEBZa8BTfJbKgyYguI0R/ktrUSOPyHpqj/iQLps
         6mtzAmX5MKPmZfjoOslbxolTfKrxvGKZHjkkA6p4lT1jmEudEqh8B8lq5K3FBZk01Y
         9tIKx/zkjVqKCoF5YAiwoIBOyJgb/GSPTPHgt7zU=
Date:   Fri, 1 Nov 2019 11:44:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH rdma-core] libhns: Use syslog for debugging while no
 print by default
Message-ID: <20191101094444.GF8713@unreal>
References: <1572574425-41927-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572574425-41927-1-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 01, 2019 at 10:13:45AM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
>
> There should be no fprintf/printf in libraries by default unless
> debugging. So replace all fprintf/printf in libhns with a macro that is
> controlled by HNS_ROCE_DEBUG.
> This patch also standardizes all printtings to maintain a uniform style.
>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> ---
>  providers/hns/hns_roce_u.c       | 12 +++++++-----
>  providers/hns/hns_roce_u.h       | 13 +++++++++++--
>  providers/hns/hns_roce_u_hw_v1.c | 28 ++++++++++++++--------------
>  providers/hns/hns_roce_u_hw_v2.c | 18 +++++++++---------
>  providers/hns/hns_roce_u_verbs.c | 36 ++++++++++++++++++------------------
>  5 files changed, 59 insertions(+), 48 deletions(-)

Thank you for pointing our attention that there are printf() in the library code.
Yes, to removal all fprintf/printf.
No, to introducing not-unified way to see debug messages.
Any solution should be applicable to all providers at least.

Thanks
