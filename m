Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74984399A59
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 07:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCF6x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 01:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhFCF6w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 01:58:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33320613E3;
        Thu,  3 Jun 2021 05:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622699828;
        bh=1bkR6tAJUmUvX7TKSxpwVUs45s+ReKdf3AmhVLLop/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FBX/1YIIJQB3pklZ8aT/5qhl4Y+GCdhY2i/mE384SMyCNFTzfTdqrVGjDhCGINyPW
         svqRLNEEh/GsOb2F+FM73G0DkLalUXJtxxXFAw3+4wyp6CP56SiuXmT7zTICSiHR5P
         V9EK06ygEbHFgewjBumrOV4QCQxPcSBSTjm6Y36HxHvu4hutShIFxgEAV+wJHgm89r
         oL4DRg1vhSaNo21oJs+b9qhOYhMaxtvvEHt1mHcUe2vpiteWEE8QUG4Rh2EqG2rebo
         705ua2mhbPPj5VCI8Qe30MrmFCAjXghQFCDFLqzITuYp3EqIjZyjmyXyQpci9d5iZs
         kXX59ojiYTXPQ==
Date:   Thu, 3 Jun 2021 08:57:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH V5 for-next 1/3] RDMA/bnxt_re: Enable global atomic ops
 if platform supports
Message-ID: <YLhvL44jBi8HYCoR@unreal>
References: <20210602154618.973816-1-devesh.sharma@broadcom.com>
 <20210602154618.973816-2-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602154618.973816-2-devesh.sharma@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 02, 2021 at 09:16:16PM +0530, Devesh Sharma wrote:
> Enabling Atomic operations for Gen P5 devices if the underlying
> platform supports global atomic ops.
> 
> Fixes: 7ff662b76167 ("Disable atomic capability on bnxt_re adapters")

First, it looks to me like a feature and not Fix, so I'll be second to
Nicolas's request, please don't add Fixes line to every commit.

Second, even this is a dix, the fixes line is still wrong.
➜  kernel git:(rdma-next) git fixes 7ff662b76167
Fixes: 7ff662b76167 ("RDMA/bnxt_re: Disable atomic capability on bnxt_re adapters")

Thanks
