Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D992B1483B9
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 12:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391185AbgAXLYC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 06:24:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388604AbgAXLXx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jan 2020 06:23:53 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EB8B206D4;
        Fri, 24 Jan 2020 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865032;
        bh=xbcJMHTw1R7hwH//aA5aHmzAjfeJ3QBMdI2Jhc1ibig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzctNMO6PlU19lVihscKeVkXkMVqQNAQTTWlfQYYxYHylYxejeVhBHIphuIG7sazD
         w1aR+fxJv/16ABW8UOClqdrZhv6gIWJCsH/YkX9dmpjzGnmaYVgTq0XU+Q7gzaAK8u
         uy/N7LDerhm/8XFyVOIZuRWKgQDUC8v1Ak7yUt9Q=
Date:   Fri, 24 Jan 2020 13:23:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Subject: Re: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation
 code
Message-ID: <20200124112347.GA35595@unreal>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 24, 2020 at 12:52:39AM -0500, Devesh Sharma wrote:
> Restructuring the bnxt_re_create_qp function. Listing below
> the major changes:
>  --Monolithic central part of create_qp where attributes are
>    initialized is now enclosed in one function and this new
>    function has few more sub-functions.
>  --Top level qp limit checking code moved to a function.
>  --GSI QP creation and GSI Shadow qp creation code is handled
>    in a sub function.
>
> Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  13 +-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 635 ++++++++++++++++++++-----------
>  drivers/infiniband/hw/bnxt_re/main.c     |   3 +-
>  3 files changed, 434 insertions(+), 217 deletions(-)
>

Please remove dev_err/dev_dbg/dev_* prints from the driver code.

Thanks
