Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74155182BD7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 10:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgCLJEm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 05:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCLJEm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Mar 2020 05:04:42 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C248206F1;
        Thu, 12 Mar 2020 09:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584003881;
        bh=99f0RGg48t+JI93Fjeso3N8BMV2RJ24KcH4YgHuWNWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpIRH85VmqooKgA+Ldw0+Fq5D4NnxTAzrq0J3WVncp03+KSEje6LOpd30+VFgbW9D
         no+FqPNYDY0wp/pQauBb3aZxwdl4uzKvKg04uzM7ZjUyVWY0C5nxyzbzqXEU7UmWMv
         FFA+wC5t//p1kM0DMfs783xsdP0cZKB9xUbx/IFM=
Date:   Thu, 12 Mar 2020 11:04:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v3 for-next] RDMA/hns: Check if depth of qp is 0 before
 configure
Message-ID: <20200312090438.GB17383@unreal>
References: <1583995244-51072-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583995244-51072-1-git-send-email-liweihang@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 12, 2020 at 02:40:44PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
>
> Depth of qp shouldn't be allowed to be set to zero, after ensuring that,
> subsequent process can be simplified. And when qp is changed from reset to
> reset, the capability of minimum qp depth was used to identify hardware of
> hip06, it should be changed into a more readable form.
>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

I didn't review, please don't add tags before they explicitly posted.
https://lore.kernel.org/linux-rdma/1583140937-2223-1-git-send-email-liweihang@huawei.com/

Thanks
