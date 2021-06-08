Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C828139EEED
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 08:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFHGtH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 02:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhFHGtH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 02:49:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3147F60234;
        Tue,  8 Jun 2021 06:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623134834;
        bh=Vw53svuUQRvoZUk0wrn5oTh4HH1UVImK5BKXRRiKgoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXAiZFdt+h2M+HtVoGrb7Ds72q1QmvtU0+daBYxKLhXFKP7eSPPD7BMDF1Jq/Wya9
         /+5f+aXKJVRR1tRk74PWQ36C3hykLXddvb9PwRdZtttS//j2rPJl5A+wDQPwsHI5Vg
         LmowYgemmCyVqOUUtr6odf4f+H7FaOkSMnYKJL70Xxb2Lfp+DmFpZnVPkNNYPAlraX
         8mjC09IxaJUxixra+jZ09TMsOd5p1PwwkcTdGMxHv1F9xDiSvkYdOTf7DgZoKQKGjI
         UlZrLYQaKnFX/PonrqNOYl0BiMsHDJY4Am22afUBanRo7BrURlm2OoqOlVS+2Ymu7D
         Loh8/HrmsAw6A==
Date:   Tue, 8 Jun 2021 09:47:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [Bug Report] RDMA/core: test_qpex.py attempts invalid MW bind
 operation
Message-ID: <YL8SbuEHsyioU/Ne@unreal>
References: <8d329494-6653-359b-91aa-31ac9dc8122c@gmail.com>
 <YL704NdV9F15CDtQ@unreal>
 <474ad554-574c-120e-97ba-b617e346f14d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <474ad554-574c-120e-97ba-b617e346f14d@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 11:54:29PM -0500, Pearson, Robert B wrote:
> 
> On 6/7/2021 11:41 PM, Leon Romanovsky wrote:
> > On Mon, Jun 07, 2021 at 04:50:20PM -0500, Pearson, Robert B wrote:
> > > sorry/this time without the HTML.
> > > 
> > > ======================================================================
> > > ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
> > > Verify bind memory window operation using the new post_send API.
> > > ----------------------------------------------------------------------
> > > Traceback (most recent call last):
> > >    File "/home/rpearson/src/rdma-core/tests/test_qpex.py", line 292, in
> > > test_qp_ex_rc_bind_mw
> > >      u.poll_cq(server.cq)
> > >    File "/home/rpearson/src/rdma-core/tests/utils.py", line 538, in poll_cq
> > >      raise PyverbsRDMAError('Completion status is {s}'.
> > > pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Memory window
> > > bind error. Errno: 6, No such device or address
> > > 
> > > This test attempts to bind a type 2 MW to an MR that does not have bind mw
> > > access set and expects the test to succeed.
> > Does the test break after your MW series? Or will it break not-merged
> > code yet?
> > 
> > Generally speaking, we expect that developers run rdma-core tests and
> > fixed/extend them prior to the submission.
> > 
> > Thanks
> > 
> > > Bob Pearson
> 
> Nope. I don't have real RNICs at home to test. But (see my note to Zhu) the
> non extended APIs do set the access flags correctly and the extended test
> case does not. The wr_bind_mw() function can't fix this for the test case.
> It has to set the access flags when it creates the MR and it didn't. It is
> possible that mlx5 doesn't check the bind access flag but that seems
> unlikely.

mlx5 devices support MW 1 & 2 and kernel checks that only these types
can be accepted from the user space. This is why mlx5 doesn't need to
check access flags again.

   903 static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
   904 {

....

   927         if (cmd.mw_type != IB_MW_TYPE_1 && cmd.mw_type != IB_MW_TYPE_2) {
   928                 ret = -EINVAL;
   929                 goto err_put;
   930         }


Thanks

> 
> Bob
> 
