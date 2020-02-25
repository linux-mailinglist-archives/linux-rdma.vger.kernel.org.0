Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9D116BB33
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 08:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgBYHsT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 02:48:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgBYHsS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Feb 2020 02:48:18 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C567221744;
        Tue, 25 Feb 2020 07:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582616898;
        bh=ssJpZWuouMn/15iZg+isVqPQF/xHAJRQnbhT5L+rdfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFLhJxGTD6+F8hherDf4atpvvdEKIKYwUz6tBTk7xiM0okFsCgq+KAIgSnwoggeVR
         +sXhoU/cZZ3HUcXU8TLsZMZEiFAsEKyccqonvC52p6+wI8eqiM2Fm/jMocFzbCLM0M
         8pTEgvyRoI5w6OG4KueIVsq6JrWO3pekgqHk3k3o=
Date:   Tue, 25 Feb 2020 09:48:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Haim Boozaglo <haimbo@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
Message-ID: <20200225074815.GB5347@unreal>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
> Hi all,
>
> When running "ibstat" or "ibstat -l", the output of CA device list
> is displayed in an unsorted order.
>
> Before pull request #561, ibstat displayed the CA device list sorted in
> alphabetical order.
>
> The problem is that users expect to have the output sorted in alphabetical
> order and now they get it not as expected (in an unsorted order).

Do we have anything written in official man pages about this expectation?
I don't think so, there is nothing "to fix".

Thanks

>
> Best Regards,
> Haim Boozaglo.
