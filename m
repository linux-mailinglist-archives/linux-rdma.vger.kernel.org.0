Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2178408969
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 12:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhIMKyA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 06:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238690AbhIMKyA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 06:54:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5372460E94;
        Mon, 13 Sep 2021 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530365;
        bh=GhyOQiK1CbAcg3zhIjeJ55FcDgMUMz42+vsrTLfWwfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lkTtX/HE8mC4Ks5kuIhSNpVbyhz/kDghbmOL7MFVLT5waqjketavC3ss/mak/ugDM
         E6aaKMqXcfY/Gy5MudiSgaL+lvxVEQ5kjR2jeSQ0iMLgdXy98KTBxFmllEZlae//Kw
         cE2U9MS6i3Ful7wEAa012xK9+mhKcMkPPrqEev43vQgKHsORDtlj+32CuKPbvcnZrx
         vvaKV5SO/lQmFIVmXrVfdf5ERpgCk1S7LvauhJ0iOP8NWes1Lm+1KNN31EwX+vokYD
         MAbxOwHj552m//eaKX3nlgcjmbPct4euA+j9evL5SFuuTA790hIbSTDNQBFdm8jf8R
         KWEUeBls8lMyA==
Date:   Mon, 13 Sep 2021 13:52:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 06/12] RDMA/bnxt_re: Suppress unwanted error
 messages
Message-ID: <YT8tefZIJGXyY2F9@unreal>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
 <1631470526-22228-7-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631470526-22228-7-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 12, 2021 at 11:15:20AM -0700, Selvin Xavier wrote:
> Terminal CQEs are expected during QP destroy. Avoid
> the unwanted error messages.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
