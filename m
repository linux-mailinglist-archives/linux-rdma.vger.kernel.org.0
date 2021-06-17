Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BA53AAD06
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhFQHKT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 03:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhFQHKR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 03:10:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FB3661369;
        Thu, 17 Jun 2021 07:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623913689;
        bh=fUyBd3HrrBeIRhuWXncOooMsB6SDgcSJxdnkcRcaND8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RzgqpvNmjWwgBJ/AtXBEeVkykUZ03o4CdFuwYjKZk1fpMjwmCtycQf9suSBr/XDh2
         oTEqwlRKPLra0W/yQH1BZElOIcsL0zgzOJUQ8SgTSSuH3ewS2O0DyoquRHClH4IL5q
         4lQvETMApRYFK6l2uAbI1IpMOU5EpXfc33jxE5SL6Pp/vBCKREFYrDsxQNRIa2mfhW
         Ky75tJ9OC6QZ4S+qVJ7CAjFdbmfX9JEZO1GSsy3TWL0Opm6L3rCrVFVqePMax2H3Ov
         s+9LAtY3WCRwLHbYbWDSXO1Ycb1j18oB+4vAs2/YBEhyfkEvOT+/oqhX0xaMkLDCPJ
         5NiX+2xnyUDaA==
Date:   Thu, 17 Jun 2021 10:08:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH V8 for-next] RDMA/bnxt_re: update ABI to pass wqe-mode to
 user space
Message-ID: <YMr01uWWZ3Cltplj@unreal>
References: <20210616202817.1185276-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616202817.1185276-1-devesh.sharma@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 17, 2021 at 01:58:17AM +0530, Devesh Sharma wrote:
> Changing ucontext ABI response structure to pass wqe_mode
> to user library.
> A flag in comp_mask has been set to indicate presence of
> wqe_mode.
> 
> Moved wqe-mode ABI to uapi/rdma/bnxt_re-abi.h
> 
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  3 +++
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  2 ++
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ------
>  include/uapi/rdma/bnxt_re-abi.h           | 11 ++++++++++-
>  4 files changed, 15 insertions(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
