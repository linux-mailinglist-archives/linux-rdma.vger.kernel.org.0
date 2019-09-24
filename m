Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C618BC3ED
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 10:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405186AbfIXIMU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 04:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409442AbfIXIMU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Sep 2019 04:12:20 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 049572146E;
        Tue, 24 Sep 2019 08:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569312739;
        bh=IpHlAZCNBk+o9T6+iOENz76fD7zfx9WH3fpQnoppzJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fh9z+uZ7sEJUaTyCiimDxnnQ6i1HXR3nzyh5ZHk0+0YWDVT8fTDvYdt0LYIGhpsji
         FeoKXQ1aehFeLulhIHULgZynmraXHLMV5RGKCAVQqICf55siTUeAnuVzp6i38rHTOf
         yh5qR6nXNyKnfZsHN7iQfZAACislTifbIpcGmpC8=
Date:   Tue, 24 Sep 2019 11:12:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Honggang LI <honli@redhat.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] redhat: BuildRequires python3
Message-ID: <20190924081216.GS14368@unreal>
References: <20190916013345.8489-1-honli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916013345.8489-1-honli@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 09:33:45AM +0800, Honggang LI wrote:
> From: Honggang Li <honli@redhat.com>
>
> python2 is obsoleted by python3 in RHEL8 and Fedora-30.
>
> Signed-off-by: Honggang Li <honli@redhat.com>
> ---
>  redhat/rdma-core.spec | 4 ++++
>  1 file changed, 4 insertions(+)
>

Queued, https://github.com/linux-rdma/rdma-core/pull/585
Thanks
