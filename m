Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D4D2DBC90
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Dec 2020 09:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgLPIWn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 03:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgLPIWn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Dec 2020 03:22:43 -0500
Date:   Wed, 16 Dec 2020 10:21:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608106922;
        bh=lzLRdvujDsVQPnOGLlScU9kmGcZgVrGieBPKFTlHmc4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9IGGo3W/dNKc1SoVF3lN0+bI755rYJPwLtfEkoj4BZP5AhDIbMFsH5mNrpK6COJD
         whI18ztp2iMmkY7mIcSGrsD+nT2oaSH5YIzr/RjJ2CPwsc1KtsP9wIC11q+GCdjXKr
         fW4DcgLSynf8iuFC/J/oReFbGjUhZ3odbMRBUrgT3RtF48LA7BmTKEZnHlkFV/kkyu
         EPefCWQ+KYK4DYdSHmU/c69UveqPLjhcy9T1H52WujjMi4sU7zl9iWUbNatiMnVPpw
         o3KcD3NwdxRkVVJ6XaynQ6EO17HAmAAAzuMS0J9nAnLGQSoWHimPWQQyMnGcZpTNLg
         IA8lto+yT7Ygg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core] librdmacm: Make rdma_create_qp_ex() report
 proper errno
Message-ID: <20201216082158.GA1060282@unreal>
References: <20201216015459.78733-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216015459.78733-1-yangx.jy@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 16, 2020 at 09:54:59AM +0800, Xiao Yang wrote:
> Current rdma_create_qp_ex() reports fixed ENOMEM when calling
> ibv_create_qp_ex() fails, so it's hard for user to know which
> actual error happens on ibv_create_qp_ex().
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  librdmacm/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The same change should be done for the ibv_alloc_pd() call.

   635         if (!cma_dev->pd)
   636                 cma_dev->pd = ibv_alloc_pd(cma_dev->verbs);
   637         if (!cma_dev->pd) {
   638                 ret = ERR(ENOMEM);
   639                 goto out;
   640         }


And please add Fixes line.

Thanks
