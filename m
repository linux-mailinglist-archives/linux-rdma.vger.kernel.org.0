Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC37C20D50
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 18:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfEPQrj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 12:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbfEPQrj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 12:47:39 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 510D0205ED;
        Thu, 16 May 2019 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558025259;
        bh=K2FYQr4MaMhNG7YfMlJ1KhrqpaZXCgirMC0+FD2sPNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCi689+VNdLXr6ewPOA3pJLnDAiJnmh7k6ycmn2Uh4E4Rxr9FP7BONioEDT3UGXZX
         foUeASlUet8GVwsuc8seFsYrM6DnWoHsYvIUhY9JhVMK4lDtZ8Q3aV/ScYPaTVzy70
         sOTKRLrg1wklJ+ttNCDg2rKWQ+Z53cHvU6Yb1ARQ=
Date:   Thu, 16 May 2019 19:47:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH rdma-core 06/20] build: Support rst as a man page option
Message-ID: <20190516164734.GC6026@mtr-leonro.mtl.com>
References: <20190514234936.5175-1-jgg@ziepe.ca>
 <20190514234936.5175-7-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514234936.5175-7-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 08:49:22PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> infiniband-diags uses rst as a man page preprocessor, so add it along side
> pandoc in the build system.

Why don't we convert RST to MD prior to integrating infiniband-diags
into rdma-core, instead of introducing extra dependency and complexity?

Thanks
