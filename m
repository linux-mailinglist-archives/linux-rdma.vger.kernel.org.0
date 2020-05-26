Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA361E1AF1
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 08:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgEZGD5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 02:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgEZGD5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 02:03:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F5E2071A;
        Tue, 26 May 2020 06:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590473036;
        bh=BIteLonzfZkwBLmTOvrm+kAH6eSI/E63WpBdwpnbzF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrmDU8u4Z/poQb+UgiC66Zs3DC4RaNw3DId8mSgp9PeNq5OSWVNBtQznb19TJrYmS
         aQGFiVjc1aT+y7zGN//oxT4P9Do7Fdnk9f4l+Twlev1mjyWHRblTCq2dJp93tdptbG
         zhREjypB5EaCo2N9FQGLtgh/iTeh6+pzWW7T+spA=
Date:   Tue, 26 May 2020 09:03:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Subject: Re: [PATCH for-next 0/2]: Broadcom's driver update
Message-ID: <20200526060352.GR10591@unreal>
References: <1590470402-32590-1-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590470402-32590-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 26, 2020 at 01:20:00AM -0400, Devesh Sharma wrote:
> This series is mainly focused on adding driver fast path
> changes to support variable sized wqe support. There are
> two patches.
>
> The first patch is a big patch and contain core changes to
> support the feature. Since the change is related to fast
> path, the patch is not splitted into multiple patches.
> We want to push all related changes in one go.

It doesn't sound like a solid justification for the huge patch.
All patches in series are applied together, why is it different
for this specific feature?

Thanks
