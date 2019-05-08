Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B8E17409
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 10:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEHIkk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 04:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfEHIkk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 04:40:40 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94F3120989;
        Wed,  8 May 2019 08:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557304838;
        bh=h1E7y49o0j8Jso1btJF/OMzcq3CXCAY+OsIQIFLaDdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPAoEKAwFmNHVd5CN42mvaL96vlMYEsebxPfBlLwj8Wa9x62a6RCvPod4+LPGvHta
         Z6AO9e7HRi9fF0aCbOK9hyCRzwIn9VawGlV14w7ZBGhnuoTuOTc7nzDam6npctP5K0
         SQ2d/5CWvULtEOMKpCaRJmzcpnZJb0R6JNIwyOL8=
Date:   Wed, 8 May 2019 11:40:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH rdma-core 0/2] Update rdma-core to Fedora Core 30
Message-ID: <20190508084033.GX6938@mtr-leonro.mtl.com>
References: <20190507192017.6284-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507192017.6284-1-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 04:20:15PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> Now that it is released move up cbuild and fix the one warning the new gcc
> detected.
>
> Jason Gunthorpe (2):
>   srp_daemon: Print the correct device name for error
>   cbuild: Update to Fedora Core 30
>
>  buildlib/cbuild         | 8 ++++----
>  srp_daemon/srp_daemon.c | 3 +--
>  2 files changed, 5 insertions(+), 6 deletions(-)
>

Thanks, applied.
