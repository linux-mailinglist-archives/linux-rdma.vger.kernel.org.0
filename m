Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A591CF0038
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 15:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbfKEOpp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 09:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387584AbfKEOpo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 09:45:44 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80AE521928;
        Tue,  5 Nov 2019 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572965144;
        bh=TFalv/0ja8lWoEp7zIFpgn1uOia/GHKRBnqQvQeV+Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DxaTHhMMKbsjnq3kRxwcK9ZA8elhOkceYZVLhizQEr0e0c3E+cDPKDJM5FeM302PW
         M89xyNabSvv1Q11V9zCyaQomlhtj6E/zgdZmGjIEkMuPmYp9TtBO7Kt+DcMIhupnm5
         TNw5uP+7E0L18erjRlnNvbenMq9GnzyO8ihrGHSg=
Date:   Tue, 5 Nov 2019 16:45:41 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com, Rahul Kundu <rahul.kundu@chelsio.com>
Subject: Re: [PATCH rdma-core] cxgb4: always query device before initializing
 chip version
Message-ID: <20191105144541.GG6763@unreal>
References: <1572870368-8686-1-git-send-email-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572870368-8686-1-git-send-email-bharat@chelsio.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 04, 2019 at 05:56:08PM +0530, Potnuri Bharat Teja wrote:
> chip_version may be initialized wrongly if alloc_context() is
> invoked multiple times. therefore always query device to derive the
> correct chip_version.
>
> Fixes: c7e71b250268 ("cxgb4: fix chipversion initialization")
> Signed-off-by: Rahul Kundu <rahul.kundu@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  providers/cxgb4/dev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Thanks, applied.
