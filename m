Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37235B0C7
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jun 2019 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF3RAc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jun 2019 13:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfF3RAc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Jun 2019 13:00:32 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6494206E0;
        Sun, 30 Jun 2019 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561914031;
        bh=aNNDZwNKxZtcwnFNkHnF2mppwvRCqhYNB8vLsvoyGj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WlHghS8xcG2jrtUQ8syAM4Ppo2UrW9G+18H9Oy1numqC84t+mFU/IPB5vHq2lycjO
         2NzpsXXN1RYH2aGt4PcGOGocvwitOxvDq+2OPKouciBcJOxGypqwS5RmvOguX/828H
         3efkFVU0Cn4HVEKQ7F2UoHhyvm0bbkkLreevM+9s=
Date:   Sun, 30 Jun 2019 20:00:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Estela, Henry R" <henry.r.estela@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Pine, Kevin" <kevin.pine@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [ANNOUNCE] qperf maintainer change
Message-ID: <20190630170026.GI4727@mtr-leonro.mtl.com>
References: <152F98E1C68AAF499EABB07558C80F3B421A3FEA@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152F98E1C68AAF499EABB07558C80F3B421A3FEA@ORSMSX106.amr.corp.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 21, 2019 at 06:00:29PM +0000, Estela, Henry R wrote:
> Hello,
> I am passing on the role of qperf maintainer to Kevin Pine, since I am no longer working on RDMA related software.
>
> Leon, could you add him to the github repo?

I see that no response was for my private email, so I'll request it again.

Please provide github username, so I'll be able to transfer access rights.

Thanks

>
> Thanks,
> Henry
>
