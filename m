Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7729C13D92C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 12:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgAPLlT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 06:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgAPLlT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jan 2020 06:41:19 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD5820730;
        Thu, 16 Jan 2020 11:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579174878;
        bh=3AxBUuKtQS0zq7huncj7B5kpq6VJwEVgcNAvTO8Xtg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQoor+Vd+vi3+wwC1bGAOh141qllH1nNSR0daxq1/7ByCK64BKsmWE4wVA7HhYpEF
         GaRRvu7cCSBEXNazONPzda33hA587puNRAjgHlbSbAQhLJwDZc3QgTMYpmVz5c+mFo
         YQQOCf9GlI4RqNtcwnhXCu3I49WcGlyoAeWQg1OE=
Date:   Thu, 16 Jan 2020 13:41:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, shiraz.saleem@intel.com,
        aditr@vmware.com, mkalderon@marvell.com, aelior@marvell.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH RFC for-next 2/6] RDMA/mlx5: remove deliver net device
 event
Message-ID: <20200116114115.GE6853@unreal>
References: <1579147847-12158-1-git-send-email-liweihang@huawei.com>
 <1579147847-12158-3-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579147847-12158-3-git-send-email-liweihang@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 12:10:43PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
>
> The code that handles the link event of the net device has been moved
> into the core, and the related processing should been removed from the
> provider's driver.

I have serious doubts that this patch broke mlx5 LAG functionality.

Thanks
