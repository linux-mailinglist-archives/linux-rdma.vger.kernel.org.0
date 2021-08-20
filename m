Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAD63F32AE
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 20:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhHTSDb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 14:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235172AbhHTSDa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 14:03:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B8EC610E6;
        Fri, 20 Aug 2021 18:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629482572;
        bh=xmU37yw1u6uvf9iezQ0d2GWgdX1Zoz+tDBVLDmfIJ84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uLNjqSSIBXyt2AhEvydz6X+zdSAJB+eiGaeVmlHlECtaLm5X4gQfPNSO2vG0jLz+v
         HHs2QQr+c4oElmJOjEbvK0VEhEZDeV+kV7EvsKS5XYagAzJe7h52m10tnqp4npIequ
         GL2e508aKusvxlPTMbvmsMO/PpGC/aKyRjuTGZXYRi/pOBZZVz1Egbqvch6WQwRAyC
         S1crk9WvktF2AY9ZdS4mp+N8/LWIhHfFG5qs1xEflxZiNp6wrZ8KpVgS15OQDoNK9d
         y6GHweZ7FlFl1jW74YLmdMdwaMs41/NQ7HBJ72XdpyE6QtEKb0l2NfhIbecJU7GUfD
         BwLaXDkUHJHCg==
Date:   Fri, 20 Aug 2021 11:02:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shai Malin <smalin@marvell.com>, linux-rdma@vger.kernel.org,
        dledford@redhat.com, mkalderon@marvell.com, davem@davemloft.net,
        aelior@marvell.com, pkushwaha@marvell.com,
        prabhakar.pkin@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH for-next 0/3][v2] qedr: consider dscp prio for vlan tag
 and update tos
Message-ID: <20210820110251.5058362a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210820174944.GA539584@nvidia.com>
References: <20210730065001.805-1-smalin@marvell.com>
        <20210820174944.GA539584@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 20 Aug 2021 14:49:44 -0300 Jason Gunthorpe wrote:
> Since this is mostly netdev stuff can someone from netdev ack this if
> you want it to go through the rdma tree?

It'd be great to get it CCed to netdev@ for that.
