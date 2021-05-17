Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49016383AE6
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 19:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242254AbhEQROQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 13:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236062AbhEQROO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 13:14:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9C4D61263;
        Mon, 17 May 2021 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621271578;
        bh=/IER8xpRm9LXzAIhm5gZtgh710UwTxabbRRiI0budyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2b9+2knRugwoiyGULOQOt+iBrxKMKPsqPLxPL236VS60V3b/Ambr+adOItIMlF78T
         4/QZDdJBdLo0wkrPcgwNo/E8LMUx8QvVqWDmFv8B/x9rg7CDxH1l5H5LQHsF2CsyqG
         D4/cMeaXz7udkhLlzX1j/5kxROL49Ipmqk5Ke+Hs=
Date:   Mon, 17 May 2021 19:12:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 09/13] RDMA/core: Expose the ib port sysfs attribute
 machinery
Message-ID: <YKKkFyHwki9R1Wkc@kroah.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <9-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 01:47:37PM -0300, Jason Gunthorpe wrote:
> Other things outside the core code are creating attributes against the
> port. This patch exposes the basic machinery to do this.
> 
> The ib_port_attribute type allows creating groups of attributes attatched
> to the port and comes with the usual machinery to do this.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/sysfs.c | 217 +++++++++++++++++---------------
>  include/rdma/ib_sysfs.h         |  41 ++++++
>  2 files changed, 158 insertions(+), 100 deletions(-)
>  create mode 100644 include/rdma/ib_sysfs.h
> 
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> index ce6aecbb5a7616..58a45548bf1568 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -44,24 +44,10 @@
>  #include <rdma/ib_pma.h>
>  #include <rdma/ib_cache.h>
>  #include <rdma/rdma_counter.h>
> -
> -struct ib_port;
> -
> -struct port_attribute {
> -	struct attribute attr;
> -	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf);
> -	ssize_t (*store)(struct ib_port *, struct port_attribute *,
> -			 const char *buf, size_t count);
> -};
> -
> -#define PORT_ATTR(_name, _mode, _show, _store) \
> -struct port_attribute port_attr_##_name = __ATTR(_name, _mode, _show, _store)
> -
> -#define PORT_ATTR_RO(_name) \
> -struct port_attribute port_attr_##_name = __ATTR_RO(_name)
> +#include <rdma/ib_sysfs.h>
>  
>  struct port_table_attribute {
> -	struct port_attribute	attr;
> +	struct ib_port_attribute attr;
>  	char			name[8];
>  	int			index;
>  	__be16			attr_id;
> @@ -97,7 +83,7 @@ struct hw_stats_device_attribute {
>  };
>  
>  struct hw_stats_port_attribute {
> -	struct port_attribute attr;
> +	struct ib_port_attribute attr;
>  	ssize_t (*show)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
>  			unsigned int index, unsigned int port_num, char *buf);
>  	ssize_t (*store)(struct ib_device *ibdev, struct rdma_hw_stats *stats,
> @@ -119,29 +105,55 @@ struct hw_stats_port_data {
>  static ssize_t port_attr_show(struct kobject *kobj,
>  			      struct attribute *attr, char *buf)
>  {
> -	struct port_attribute *port_attr =
> -		container_of(attr, struct port_attribute, attr);
> +	struct ib_port_attribute *port_attr =
> +		container_of(attr, struct ib_port_attribute, attr);
>  	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
>  
>  	if (!port_attr->show)
>  		return -EIO;
>  
> -	return port_attr->show(p, port_attr, buf);
> +	return port_attr->show(p->ibdev, p->port_num, port_attr, buf);
>  }
>  
>  static ssize_t port_attr_store(struct kobject *kobj,
>  			       struct attribute *attr,
>  			       const char *buf, size_t count)
>  {
> -	struct port_attribute *port_attr =
> -		container_of(attr, struct port_attribute, attr);
> +	struct ib_port_attribute *port_attr =
> +		container_of(attr, struct ib_port_attribute, attr);
>  	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
>  
>  	if (!port_attr->store)
>  		return -EIO;
> -	return port_attr->store(p, port_attr, buf, count);
> +	return port_attr->store(p->ibdev, p->port_num, port_attr, buf, count);
>  }
>  
> +int ib_port_sysfs_create_groups(struct ib_device *ibdev, u32 port_num,
> +				const struct attribute_group **groups)
> +{
> +	return sysfs_create_groups(&ibdev->port_data[port_num].sysfs->kobj,
> +				   groups);
> +}
> +EXPORT_SYMBOL(ib_port_sysfs_create_groups);

You are wrapping _GPL symbols here with a "convenience" function, please
make these all EXPORT_SYMBOL_GPL() so I don't get nervous.

thanks,

greg k-h
