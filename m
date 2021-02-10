Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47238316251
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 10:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhBJJeq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 04:34:46 -0500
Received: from gentwo.org ([3.19.106.255]:47804 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhBJJcW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Feb 2021 04:32:22 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 64A123F02E; Wed, 10 Feb 2021 09:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 614C63EA54;
        Wed, 10 Feb 2021 09:31:32 +0000 (UTC)
Date:   Wed, 10 Feb 2021 09:31:32 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Jason Gunthorpe <jgg@nvidia.com>
cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
In-Reply-To: <20210209191517.GQ4247@nvidia.com>
Message-ID: <alpine.DEB.2.22.394.2102100925200.172831@www.lameter.com>
References: <alpine.DEB.2.22.394.2101281845160.13303@www.lameter.com> <20210209191517.GQ4247@nvidia.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 9 Feb 2021, Jason Gunthorpe wrote:

> This one got spam filtered and didn't make it to the list:
>
> Received-SPF: SoftFail (hqemgatev14.nvidia.com: domain of
>         cl@linux.com is inclined to not designate 3.19.106.255 as
>         permitted sender) identity=mailfrom; client-ip=3.19.106.255;
>         receiver=hqemgatev14.nvidia.com;
>         envelope-from="cl@linux.com"; x-sender="cl@linux.com";
>         x-conformance=spf_only; x-record-type="v=spf1"
>
> Also the extra From/Date/Subject ended up in the commit message

Yes the Linux Foundation guys are not willing to address this issue in any
way. I may have to give up my linux.com email address.

> I fixed it all up, applied to for-next

Thank you.

> It looks like OPA will also suffer this race (opa_pr_query_possible),
> maybe it is a little less likely since it will be driven by PR queries
> not broadcast joins.
>
> But the same logic is likely true there, I'd be surprised if OPA
> fabrics are not running a capable OPA SM at this point.

There is also another potentially racy check in there for OPA in regards
to the support of path records?

static bool ib_sa_opa_pathrecord_support(struct ib_sa_client *client,
                                         struct ib_sa_device *sa_dev,
                                         u8 port_num)
{
        struct ib_sa_port *port;
        unsigned long flags;
        bool ret = false;

        port = &sa_dev->port[port_num - sa_dev->start_port];
        spin_lock_irqsave(&port->classport_lock, flags);
        if (!port->classport_info.valid)
                goto ret;

        if (port->classport_info.data.type == RDMA_CLASS_PORT_INFO_OPA)
                ret = opa_get_cpi_capmask2(&port->classport_info.data.opa)
&
                        OPA_CLASS_PORT_INFO_PR_SUPPORT;
ret:
        spin_unlock_irqrestore(&port->classport_lock, flags);
        return ret;
}

