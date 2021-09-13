Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3274089E8
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbhIMLMy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 07:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239218AbhIMLMw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 07:12:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42D806044F;
        Mon, 13 Sep 2021 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631531496;
        bh=K+x98JBHxDq3P/AVC1aKULNv7cVBVV/rJtv6t2OpywI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BgissV4fpF7ZsKDfHqQ6yZjFChUDn5VAjQcKVVi5bokSUri/pvx89M9Bgoy+ci8ph
         je9e1Avfzj5fKqt4I2Acf+NTkb+vJ42ijCm583TVGzqPT7QQJhS6DhqQl7T2KyQoD3
         lnPAggTvO3/Tl6wya0EgPHT8g+XRvS8AZTv2Tc/nzT3p7QH+Fl15DRYhiZ/0JMv0Eh
         hBl7l/PWXulQA1L0rmkkV3Tz690h1poGXGdfdJluzcgJ5xibRVU2X3WlKxpwHKCzbe
         SdPByh++nz8kOKfW5Yel0j2GyoA14+O2amyxzBQhVgHHtHjgxo8bVk87kNNOImg0Zj
         KQ6qaBeounxEg==
Date:   Mon, 13 Sep 2021 14:11:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 10/12] RDMA/bnxt_re: Correct FRMR size
 calculation
Message-ID: <YT8x5XnIrJJ5JXGF@unreal>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
 <1631470526-22228-11-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631470526-22228-11-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 12, 2021 at 11:15:24AM -0700, Selvin Xavier wrote:
> FRMR WQE requires to provide the log2 value of the
> PBL and page size.
> Use the standard ilog2 to calculate the log2 value
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
