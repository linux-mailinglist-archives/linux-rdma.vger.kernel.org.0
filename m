Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34A63D087D
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 07:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhGUFGf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 01:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233088AbhGUFGe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 01:06:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24FBD61019;
        Wed, 21 Jul 2021 05:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626846430;
        bh=nZu1ol/FxuxiNW0ST35OvWsLorC0P+mSFpL7CtBP+Zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qu3XVDkBDMQH1Z8v5R2RZe9kry9Y51T4DaUcSn6/UmwowRlvoOJ3XEmlco3XudlBq
         uYk8vg/+myVTGR+eRswEficsXzxSt8f6x+P4aCW4o/yg5I0vfW9K3DB29ehqF+M8OS
         hrAdgHRjkqTGSMMKyGiSUGf9HONueDAr9OL6eQnkgBcXK7L99pSsjzGe+q44fFpw0l
         oN4bfP6ltXAy/DP8wXETMSMUoj1hXi654wLUMhivIj9RiMsf6OFO+b0FMP+uVt71i8
         7nggXAl60dwr1/+KttoDl8sVLL2duusFGIqac9p19qkCV7daxizlKVmMx6J5vLBdcp
         AVQYQOY9cv7bw==
Date:   Wed, 21 Jul 2021 08:47:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: RDMA/rxe is broken (impacting running NFSoRDMA over softRoCE)
Message-ID: <YPe02wEIHJffalro@unreal>
References: <CAN-5tyGbmTjiT+nxXB7BMp6mwpUs+HVUGy-CGXBBrC04jQ3grA@mail.gmail.com>
 <63d7f374-1252-82c8-769d-2d1a540466fd@gmail.com>
 <CAN-5tyFQd3wzRXtcQoO0wC-bU1Ggk05K7ikokY_ZGZidG=CP5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyFQd3wzRXtcQoO0wC-bU1Ggk05K7ikokY_ZGZidG=CP5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 20, 2021 at 05:48:03PM -0400, Olga Kornievskaia wrote:
> On Tue, Jul 20, 2021 at 2:27 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:

<...>

> There were a number of commits that lead to crashes. commit
> ec9bf373f2458f4b5f1ece8b93a07e6204081667 "RDMA/core: Use refcount_t
> instead of atomic_t on refcount of ib_uverbs_device" leads to the
> following kernel oops. commit 205be5dc9984b67a3b388cbdaa27a2f2644a4bd6
> "RDMA/irdma: Fix spelling mistake "Allocal" -> "Allocate"" also leads
> to the kernel oops.

The commits above aren't relevant to RXE at all.

If first commit is wrong, all drivers will experience crashes and second
commit is in irdma and not in RXE.

And both of them are legit commits.

Thanks
