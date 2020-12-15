Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B1D2DA8D1
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 08:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgLOHz1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 02:55:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgLOHz1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Dec 2020 02:55:27 -0500
Date:   Tue, 15 Dec 2020 09:54:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608018886;
        bh=R8etNAPkRU6+byAgOXrXAxEOg0MvbSBitQVCMsvOZyo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDuiIxgch6a/z5+OciYtFoMzhcl9LAQTa8OcE6osMI7onxEGYaEHOoF5epLLPzAsl
         PS91dkYEPfLOcwbbNGk2Jplna1yJNw/caMahfj8exX+T/NV2DMMaxHvcOY4B9oCkiO
         f5U5kOnNNOkUY0o4zIn8+LUpCN7ZKbMo6jYnHmhIxaW5OsvnZDDApoV7XF2o/XPM7v
         QMQbebtFkHeanl7+zXSWU8pAbOURMQQSBB+RCdXerXpJtpwNVO1trcVtT/g31Njctk
         pi3bSRPohIEUn6FcH1/D3WbQAzogYoJTHDpVLKbmQvVpDBDmHiQYc8nF9awXPtxPwM
         hXsIoUBegZD3A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ulp/ipoib/ipoib_multicast: convert comma to
 semicolon
Message-ID: <20201215075443.GN5005@unreal>
References: <20201214134218.4510-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214134218.4510-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 14, 2020 at 09:42:18PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Can you please do it in one patch for whole subsystem?

Thanks
