Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0201FCC12
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFQLRS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 07:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgFQLRP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 07:17:15 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D5A20DD4;
        Wed, 17 Jun 2020 11:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592392635;
        bh=eMxXf17fi1lb25kXg0RUwVui2Flx1C275LgVM4K2fF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuBUeZEqWEpOPIbPglcLkbmXNPDsnsvpPDzaJW++8n9hxyvhqHizix04nEsfOVq4V
         +d7+A0C4g64kn3Q0GPlutFJgRSvrcWrE9K5IdwtrL4026Uolp3kQ1/pGZAPPxfg/D4
         ZHbFg2L8lXb7AM6pf+RvVeFMxsFgVUkwomEpS4rk=
Date:   Wed, 17 Jun 2020 14:17:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Vladimir Chukov <vladimir.chukov@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [BUG report] rdma-ndd: wrong NodeDescription for second device
Message-ID: <20200617111710.GK2383158@unreal>
References: <CAL94vcd2bHKHZaw7wsRMMyk1FCq+nRFR-XD2W0ueG_dgOyVFew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL94vcd2bHKHZaw7wsRMMyk1FCq+nRFR-XD2W0ueG_dgOyVFew@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 01:04:15PM +0200, Vladimir Chukov wrote:
> Description: rdma-ndd sets correct NodeDescription for device which
> was initialised first; for the second device description in sysfs is
> set correctly, but saquery  to that node  will return default
> "NodeDescription.........MT4119 ConnectX5   Mellanox Technologies"

What do you see for the second device in NodeDescription?

Thanks
