Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D5B286E37
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 07:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgJHFle (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 01:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgJHFld (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 01:41:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC01F206E9;
        Thu,  8 Oct 2020 05:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602135693;
        bh=DQOPFcbgjR1Ctf/u+f8XFQ9sBqwbx8OZySFosz7p3mI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAMXPES+6mXIY3W8EjWyxU0vPUiHlvktxQQ6x+NGUWNfLcMtUdKnXvQldmZSQbkfp
         d8Z5vMDuI/kcjNUpVYRpXvaCmQ+5A8EetFqZBqOsBV2Bs1ZGAYmK5UB6l8RFy4rKh1
         muOoSZ+I1yux+UT1WRhGC87EA9Q5CLuJoBd7QnQA=
Date:   Thu, 8 Oct 2020 08:41:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next 0/4] RDMA: sprintf to sysfs_emit conversions
Message-ID: <20201008054128.GD13580@unreal>
References: <cover.1602122879.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602122879.git.joe@perches.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 07:36:23PM -0700, Joe Perches wrote:
> A recent commit added a sysfs_emit and sysfs_emit_at to allow various
> sysfs show functions to ensure that the PAGE_SIZE buffer argument is
> never overrun and always NUL terminated.

Unfortunately but the sysfs_emit commit is not in rdma-next tree yet.

Thanks
