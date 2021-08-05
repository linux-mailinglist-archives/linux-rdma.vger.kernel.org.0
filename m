Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8452F3E0E7D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 08:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbhHEGlH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 02:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhHEGlG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Aug 2021 02:41:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D02E60F41;
        Thu,  5 Aug 2021 06:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628145653;
        bh=Ok7j6cqjkb/HHIs//Mc6bkwVhAdw714MopWNYF3XM3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0SsWdmY36usHrfHx3p1xEGRRh/Fgwgoot9TQwPc3VGS34vOd0iamLLL8z9WiqM1c
         3+DwfJKZzLnodJFZQu5ZOIxLHWaFWfcJPtXMJvzbkIZ6xFdEptk2TZA1LcPpRKbZz7
         jOphkJCnC1HytVBK0Efsz7xDKIDtmPELrrVxRFhbUA9rzr6OCHIN3QMRI+/AtN0Oq1
         pRQRMlF3CYobNkFRGPh2YPtZVQTXQiJ4yJHyvtgh12MBLnvbdQPIKrlxm2b+7GQK5M
         5Da70WCf5+5Y6Y7jTPiqIifGi3N4pSf7RCf64PndTUEsqJSRoMJ/QCRLe37Ti/sTPF
         DFXHyxFYZFvBA==
Date:   Thu, 5 Aug 2021 09:40:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Omar Navarro Leija <omarsa@seas.upenn.edu>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Incorrect Return Type for rdma_destroy_qp
Message-ID: <YQuH8TN7dJ4MAwNf@unreal>
References: <CAMAtMKd2b6mKauR5HmCwEqFpHZ=me+Qn+hU_7CewETUBDnMF7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMAtMKd2b6mKauR5HmCwEqFpHZ=me+Qn+hU_7CewETUBDnMF7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 04, 2021 at 01:30:54PM -0400, Omar Navarro Leija wrote:
> Hello!
> 
> The man page has rdma_destroy_qp as:
> 
> #include <rdma/rdma_cma.h>
> void rdma_destroy_qp (struct rdma_cm_id *id);
> 
> 
> Note the void return type. Yet the return value section states:
> 
> Return Value
> Returns 0 on success, or -1 on error. If an error occurs, errno will
> be set to indicate the failure reason. Indeed the implementation is
> written as:
> 
> void rdma_destroy_qp(struct rdma_cm_id *id)
> {
> ibv_destroy_qp(id->qp);
> id->qp = NULL;
> ucma_destroy_cqs(id);
> }
> 
> I believe  rdma_destroy_qp should return an int which propagates the
> return value of calling ibv_destroy_qp. As a workaround, I just call
> ibv_destroy_qp directly.

It is worth to fix man pages.

Thanks

> 
> Omar
