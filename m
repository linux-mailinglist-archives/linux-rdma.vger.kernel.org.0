Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176B239EDC5
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhFHEnB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhFHEnA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 00:43:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C5D36124B;
        Tue,  8 Jun 2021 04:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623127268;
        bh=UyPpuTAPiYdyKSKABBcXetxwrRAaXqj3Ub9RGtsGB7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mFw4mdeqw6t86u9IQ0aRVXiDNKK5gKLiSZUNTOXoQTikslfiRfLXKCgyfORsImAsv
         dxCYpmgS7HrO8Pay9f+2yzeNd6E4b5X1niuGKUxEiaf26DnXTysn3QF8ZSK7nuysmu
         UT60/gooBiVUJOCX34U9hksZrAlOaLoOIrLAlQYDK0HE/z/0HSOfPHoI6jtuKM2P8E
         N2JWL/vQq1ZhOKMyHqVS0phgQD8uIXegXNRGSs6qmRdSgmE6BuO07TZV/jOrznSvOc
         8R/YIhYPIhNfxzgdYWZwgnncagk4q/ctJajC8OBiBHwI28Ow9t1KgShF7KAwyDNK7q
         wGchQ5lKyjFew==
Date:   Tue, 8 Jun 2021 07:41:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [Bug Report] RDMA/core: test_qpex.py attempts invalid MW bind
 operation
Message-ID: <YL704NdV9F15CDtQ@unreal>
References: <8d329494-6653-359b-91aa-31ac9dc8122c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d329494-6653-359b-91aa-31ac9dc8122c@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 04:50:20PM -0500, Pearson, Robert B wrote:
> sorry/this time without the HTML.
> 
> ======================================================================
> ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
> Verify bind memory window operation using the new post_send API.
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "/home/rpearson/src/rdma-core/tests/test_qpex.py", line 292, in
> test_qp_ex_rc_bind_mw
>     u.poll_cq(server.cq)
>   File "/home/rpearson/src/rdma-core/tests/utils.py", line 538, in poll_cq
>     raise PyverbsRDMAError('Completion status is {s}'.
> pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Memory window
> bind error. Errno: 6, No such device or address
> 
> This test attempts to bind a type 2 MW to an MR that does not have bind mw
> access set and expects the test to succeed.

Does the test break after your MW series? Or will it break not-merged
code yet?

Generally speaking, we expect that developers run rdma-core tests and
fixed/extend them prior to the submission.

Thanks

> 
> Bob Pearson
> 
