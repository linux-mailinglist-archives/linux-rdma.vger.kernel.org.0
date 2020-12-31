Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76992E7EA4
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Dec 2020 09:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgLaH7w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Dec 2020 02:59:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgLaH7w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 31 Dec 2020 02:59:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39F202222D;
        Thu, 31 Dec 2020 07:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609401551;
        bh=ABAyDpjDXudXPR58WMezrhhiSwcqzq1gWS8Uc10n/7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTJeJ2WGWbS8ROuncfOSd3rZqTcX/A8TeWW2AzRXqHsAZbHLf+K1Z67aybcblX+7U
         iT+U3qikf7SlG3Wu5n1OVfITDvWZYthtx5OPTiJOYbbR8fQTYlMI1557vpYGn/8Olh
         7cJSnkjRiCHDiwFo1/mgG1NWV2ZxRU1T6MAIJOdC9PvSumbKDr/ppjKPEC1irWJEBJ
         GmV/QU3YlaOOPHsfqeb0+g1y2AMzUsz992JsUCbs7+eCXN/hmRPugcuYtTslIyRZUI
         pbdW/iTn7YgAFEIDmAlIogWK4/sNY8/qmHHeZFjLRmnDg92xH8NwArhTmr4gmhMjAN
         c3sH6aRh8rYsw==
Date:   Thu, 31 Dec 2020 09:59:07 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: Is it ok to use debugfs to dump some ucontext-level
 driver-defined info?
Message-ID: <20201231075907.GD6438@unreal>
References: <d681bc1cad0e4726806aeb46f240d07d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d681bc1cad0e4726806aeb46f240d07d@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 29, 2020 at 01:31:39PM +0000, liweihang wrote:
> Hi all,
>
> We want to dump some hns driver-defined information that belongs to a
> process to keep track of current memory usage. For example, there is
> a ucontext-level(process-level) memory pool to store WQE which is
> shared by a lot of QPs, we want to record and query which QPs are using
> this pool and how much space each QP is using.
>
> rdmatool don't have a ucontext-level resource tracking currently, is it
> ok to achieve that through debugfs?
>
> This may looks like:
>
> $ echo 1 > <dbgfs_dir>/hns_roce/hns_0/<pid>/qp
> QPN        Total(kB)  SQ(kB)     SGE(kB)    RQ(kB)
> 110        6400       256        2048       4096
> 118        6400       256        2048       0
>
> Or should it be achieved in rdmatool?

I think so, because PID != ucontext. Why can't it be presented as QP
attribute? Can you please send "rdmatool" example?

Thanks

>
> Thanks
> Weihang
