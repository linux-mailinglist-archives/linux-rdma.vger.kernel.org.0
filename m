Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE71B96F4
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 08:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgD0GGS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 02:06:18 -0400
Received: from verein.lst.de ([213.95.11.211]:45575 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgD0GGR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 02:06:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9565668CEE; Mon, 27 Apr 2020 08:06:14 +0200 (CEST)
Date:   Mon, 27 Apr 2020 08:06:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, sagi@grimberg.me, martin.petersen@oracle.com,
        jsmart2021@gmail.com, linux-rdma@vger.kernel.org,
        idanb@mellanox.com, axboe@kernel.dk, vladimirk@mellanox.com,
        oren@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
        jgg@mellanox.com
Subject: Re: [PATCH 14/17] nvmet: Add metadata/T10-PI support
Message-ID: <20200427060614.GB16186@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-16-maxg@mellanox.com> <20200421153045.GE10837@lst.de> <0c6caf5b-693b-74af-670e-7df9c7f9c829@mellanox.com> <20200424071433.GE24059@lst.de> <9da15ad2-ed9c-9a00-4781-b57712835b3b@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9da15ad2-ed9c-9a00-4781-b57712835b3b@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 26, 2020 at 01:50:05PM +0300, Max Gurtovoy wrote:
>>>> I think the printks are a little verbose.  Also why can we set
>>>> ctrl->port->pi_enable if ctrl->port->pi_capable is false?  Shoudn't
>>>> we reject that earlier?  In that case this could simply become:
>>>>
>>>> 	ctrl->pi_support = ctrl->subsys->pi_support && ctrl->port->pi_enable;
>>> for that we'll need to check pi_capable during add_port process and disable
>>> pi_enable bit if user set it.
>> Which seems pretty sensible.  In fact I think the configfs write for
>> pi enable should fail if we don't have the capability.
>
> The port is not enabled so it's not possible currently.
>
> But we can disable it afterwards (in nvmet_enable_port) :
>
> +       /* If the transport didn't set pi_capable, then disable it. */
> +       if (!port->pi_capable)
> +               port->pi_enable = false;

I don't think we should allow users to enable invalid configurations
and silently clear flags, but reject flags as soon as we can - write
to the attribute where possible, else during enable.

> how about:
>
> -       pr_info("creating controller %d for subsystem %s for NQN %s.\n",
> -               ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn);
> +       pr_info("creating controller %d for subsystem %s for NQN %s%s.\n",
> +               ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
> +               ctrl->pi_support ? " T10-PI is enabled" : "");

Ok.
