Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7285C2E7E82
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Dec 2020 07:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgLaG6d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Dec 2020 01:58:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgLaG6d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 31 Dec 2020 01:58:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE25522242;
        Thu, 31 Dec 2020 06:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609397872;
        bh=4DluMI7+UsaGP4o20zqQ28aInIomLtWBtcOAe0Zzuz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2AKLniEtWomTQU0L34D1K5Sy1kvGTMzeTapPStC1QY20sF+PldywqQoq3tCyZr6F
         YWyV+v0RhMCaW3AwY5mcsABG15kCMNZrwQdueESyLhLNd8sOxOF2zmG8hdcIEKvrV9
         jtjdi/2xD6EUhDDaKmGu8GbXyVhCATVw0VGlBqXsgcSj377HCi33EUm/8rHF4c1sBe
         QSb46ZgsFPZdMPhg2qKlRjpBXpFdcz4Jaroaf8rMQPJpOhXobuRRjLzrEaCPSD17S0
         LolGeGh767fMBSrd46z9Hu4S5KlC4HwNGdjQCmFEvLYtPVx6DJIE9maVK2sOml9a6N
         dsJvVhZNrOujg==
Date:   Thu, 31 Dec 2020 08:57:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     bugzilla-daemon@bugzilla.kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [Bug 210973] New: info leaks in all kernel versions including
 android
Message-ID: <20201231065748.GC6438@unreal>
References: <bug-210973-11804@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-210973-11804@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 30, 2020 at 10:50:43PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=210973
>
>             Bug ID: 210973
>            Summary: info leaks in all kernel versions including android
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: latest
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: Infiniband/RDMA
>           Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
>           Reporter: fxast243@gmail.com
>         Regression: No
>
> While I audit android kernel source code , I noticed that there is an
> Uninitialized data which could lead to info leak in ib_uverbs_create_ah
> function. I download the source code from here
> https://android.googlesource.com/kernel/common. Also it exists in the
> linux-masters
>
> https://github.com/torvalds/linux/blob/master/drivers/infiniband/core/uverbs_cmd.c#L2408
>
>
> # BUG
> resp.ah_handle = uobj->id;
> return uverbs_response(attrs, &resp, sizeof(resp));


Thanks for the report.

There is no info leak here because according to the C99 standard if flexible
array doesn't have members, it will be treated as non-existent for the struct
size calculations.

In our case sizeof(u32) == sizeof(struct ib_uverbs_create_ah_resp) and
not sizeof(u32) + sizeof(u32) as you wrote.

See 6.7.2.1 Structureand union specifiers, item 16 for more info.

Thanks

