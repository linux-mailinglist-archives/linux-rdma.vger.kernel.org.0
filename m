Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A72411E7EA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 07:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfEOF3v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 01:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfEOF3v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 01:29:51 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C762084A;
        Wed, 15 May 2019 05:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557898190;
        bh=2OvW2ALE2InIXYYqgO/ge1IrO07xurKYoYknhd5EUIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Khk5oIXE7yU6Y9yFzO3bzbjWFSQKwKVmnCY2bBveeBEnlvRPMo6G1nUz/SCQChvTW
         9jkClF2w/Q2OucdWbwdog1oya01Y/mRtk13jaUR57ZFkQwEIfbRipLfZR/GJJKJQE9
         n9jissFclFShPT081YumxYutcaS8r4pVtSXwgnA4=
Date:   Wed, 15 May 2019 08:29:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH rdma-core 1/5] cbuild: Make pyverbs build with epel
Message-ID: <20190515052947.GF5225@mtr-leonro.mtl.com>
References: <20190514233028.3905-1-jgg@ziepe.ca>
 <20190514233028.3905-2-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514233028.3905-2-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 08:30:24PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> For some reason cmake3 installs python3.6, but EPEL only has cython
> built for python3.4. Convice the python3 link to be python3.4 so cmake
> finds it without hassles.

It depends on our definition of cbuild.
If we say that cbuild purpose is to build packages for given platform,
such hack will be appropriate.
If we say that cbuild purpose is to test and ensure that packages are
built for given platform, such hack will hide the problem that rdma-core
won't be possible to package there.

Thanks
