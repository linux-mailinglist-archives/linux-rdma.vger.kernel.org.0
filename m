Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C791B40894E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbhIMKqp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 06:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238997AbhIMKqo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 06:46:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72FE461004;
        Mon, 13 Sep 2021 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631529929;
        bh=fT+txpQO7rkqn4UIw68wywJZmSIj1/mECzi062yYiMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZBrn6UIPBxpgKhDCOnqZzIiB8yPmqZG3/Te1HhmBb/kE4c0PA/VrMzDq4Q7baCfW
         ftULBhf60Q3RwLo//y4dq+RIb6xfoqxUxhoQbqWsexO2k9dcuhHpYpHQP/tt7YimBW
         9hvLAa/kUqd9PoJyjz9DWsReGpeKB97eP9g5L9IytveTaga39ZvBRf1rBAaoHtPwl/
         NyZl+n4W4kXmNDxVXKImOAwq5jOzDYpSXXU5Q0+jK1xXr4HNFWbMp0nMJCiIQIW2p+
         pZxKX8SuEKvBJ/tAAqxVJ7CuSwpuYc5ufJkRfby4zt039qMJIhev5YhrkSpwVLh8CH
         Xqfl0djYJE+aQ==
Date:   Mon, 13 Sep 2021 13:45:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 01/12] RDMA/bnxt_re: Add extended statistics
 counters
Message-ID: <YT8rxVUNJfvzL6hF@unreal>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
 <1631470526-22228-2-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631470526-22228-2-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 12, 2021 at 11:15:15AM -0700, Selvin Xavier wrote:
> Implement extended  statistics counters for newer adapters.
> Check if the FW support for this command and issue the FW
> command only if is supported. Includes code re-organization
> to handle extended stats. Also, add AH and PD software counters.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h     |   5 +-
>  drivers/infiniband/hw/bnxt_re/hw_counters.c | 273 ++++++++++++++++++----------
>  drivers/infiniband/hw/bnxt_re/hw_counters.h |  28 ++-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c    |  16 +-
>  drivers/infiniband/hw/bnxt_re/main.c        |   4 +
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c    |   3 +
>  drivers/infiniband/hw/bnxt_re/qplib_res.h   |   9 +-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  51 ++++++
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h    |  28 +++
>  drivers/infiniband/hw/bnxt_re/roce_hsi.h    |  85 +++++++++
>  10 files changed, 401 insertions(+), 101 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
