Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65B11CECF7
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 08:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgELGWn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 02:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgELGWn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 02:22:43 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D24C20746;
        Tue, 12 May 2020 06:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589264563;
        bh=BxjNkebzRELWBrlQoNKYuJjXKqEOGdzqAH1umRBcOhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWOVCrIR/yLyCPBjfx02nnI2sqixBHfysB5Xppu+td5xqKs+FSUCbEr2BIZvsqJAR
         ZK6pX1OZVIvrFrB79RpG8w6eksCNecO2euitGBS0P3cou77XnURUlXZXm4jn+/Zulx
         rjpKeIFQnF/vnE6J8+sIQP2DcBG2aqoqIAjQISkk=
Date:   Tue, 12 May 2020 09:22:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjunz@mellanox.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Return -EFAULT if copy_from_user() fails
Message-ID: <20200512062238.GD4814@unreal>
References: <20200511183742.GB225608@mwanda>
 <AM6PR05MB6263ECA5663A63A9CC825145D8BE0@AM6PR05MB6263.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR05MB6263ECA5663A63A9CC825145D8BE0@AM6PR05MB6263.eurprd05.prod.outlook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 01:12:38AM +0000, Yanjun Zhu wrote:
> Does this "err = -EFAULT;" make any sense in your commit?

Yanjun, please stop top-posting, it is annoying.

Thanks
