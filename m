Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92FB9126390
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 14:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfLSNcR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 08:32:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfLSNcR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Dec 2019 08:32:17 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4107D2082E;
        Thu, 19 Dec 2019 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576762336;
        bh=+vYCHNystTs4b69kHKPGRpTyPDFm1f2X8LCuIiuE+/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDhkMonP+MRVGi22hOu/+vY242HwiEG0JCi3/2YQce4qTgUFH4cB1goudg1N1P5sJ
         6FHxeolLyz+1c36z3TOV10b+1GdJ0KhCgyoR+na56tDEkDiIJuomrpSHTwbM3MdA7v
         bcI/jBs70gd1WHzp1SrBH5ls/eLEAO9zJ4cGsNpg=
Date:   Thu, 19 Dec 2019 15:32:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v10 0/3] Proposed trace points for RDMA/core
Message-ID: <20191219133213.GC298744@unreal>
References: <20191218201631.30584.53987.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218201631.30584.53987.stgit@manet.1015granger.net>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 18, 2019 at 03:18:04PM -0500, Chuck Lever wrote:
> Hey y'all-
>
> Refresh of the RDMA/core trace point patches.
>
>
> Changes since v9:
> - One-line Makefile fix to ensure patch 1/3 compiles
>

The one-line change fixed my compilation issues. The series perfectly compiles.

Thanks for fixing.
