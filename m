Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC31B6EB4
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 09:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgDXHOh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 03:14:37 -0400
Received: from verein.lst.de ([213.95.11.211]:33553 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgDXHOh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 03:14:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 723C768CEE; Fri, 24 Apr 2020 09:14:33 +0200 (CEST)
Date:   Fri, 24 Apr 2020 09:14:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, sagi@grimberg.me, martin.petersen@oracle.com,
        jsmart2021@gmail.com, linux-rdma@vger.kernel.org,
        idanb@mellanox.com, axboe@kernel.dk, vladimirk@mellanox.com,
        oren@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
        jgg@mellanox.com
Subject: Re: [PATCH 14/17] nvmet: Add metadata/T10-PI support
Message-ID: <20200424071433.GE24059@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-16-maxg@mellanox.com> <20200421153045.GE10837@lst.de> <0c6caf5b-693b-74af-670e-7df9c7f9c829@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6caf5b-693b-74af-670e-7df9c7f9c829@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 23, 2020 at 03:39:38PM +0300, Max Gurtovoy wrote:
>>> +	if (ctrl->subsys->pi_support && ctrl->port->pi_enable) {
>>> +		if (ctrl->port->pi_capable) {
>>> +			ctrl->pi_support = true;
>>> +			pr_info("controller %d T10-PI enabled\n", ctrl->cntlid);
>>> +		} else {
>>> +			ctrl->pi_support = false;
>>> +			pr_warn("T10-PI is not supported on controller %d\n",
>>> +				ctrl->cntlid);
>>> +		}
>> I think the printks are a little verbose.  Also why can we set
>> ctrl->port->pi_enable if ctrl->port->pi_capable is false?  Shoudn't
>> we reject that earlier?  In that case this could simply become:
>>
>> 	ctrl->pi_support = ctrl->subsys->pi_support && ctrl->port->pi_enable;
>
> for that we'll need to check pi_capable during add_port process and disable 
> pi_enable bit if user set it.

Which seems pretty sensible.  In fact I think the configfs write for
pi enable should fail if we don't have the capability.

> User should set it before enable the port (this will always succeed).
>
> I'll make this change as well.
>
> re the verbosity, sometimes I get many requests from users to get 
> indication for some features.
>
> We can remove this as well if needed.

I'd rather keep debug prints silent.  You could add a verbose mode
in nvmetcli that prints all the settings applied if that helps these
users.
