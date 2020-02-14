Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AC715D9D7
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 15:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgBNOyr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 09:54:47 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37131 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgBNOyq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Feb 2020 09:54:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id c188so9438203qkg.4
        for <linux-rdma@vger.kernel.org>; Fri, 14 Feb 2020 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cx8F59JuTbMdxDy8f+ZvChzU2qcwFcSX+twtJt8aVBc=;
        b=DIIo603TxlXBqYTRCeKdVG9PWbqQAhqzArqQh9BrsOYvEKIIYIuXSuJycx+wTLFxEy
         s6kKrELmSarYflKIlfnYghwph+BMkdgyllL8JC0DKhno9pmSh4PK5OxcwKya9hiuaL1q
         5+8HvQY8t8nsXe9+lLjAcF76shdmUINo8+NOZK5sN+s5KYrbK1cq1KHagPzz/Sx8gmAA
         96GWATcO8nkSYmHghvPxSzJ+23C+Oh25QXZUYbDc+PXtvAMjXPQG78USbSlAwEzOWSTy
         qdfiLoieImQd/OiJ2jk5V1PRkQ3dzI0yGoKO9u7za8tFAimn/QGVOV3P2GbYFu9n0Zj1
         fqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cx8F59JuTbMdxDy8f+ZvChzU2qcwFcSX+twtJt8aVBc=;
        b=n1bw/osQAk1uhcfZM6ZP2oC1OIyNAmrOq8yq7BLldsSnQyZImp2TvvUwsspIWtO7Gs
         HJgVgmLqJ3hgNTvFjY6thlRpKhqNWekwxvM4+alC7zCSVtJbOLeFqQnUOwng8WJQ+iPj
         GNKqZlym2O+y35B0Eqkbny2NIUUrhAdDkv+2FpQJ3TIttJBJjbFa0UCPILYV3JLts3v2
         hfAwVPswckV9qq1s1Oo2GlBqJroqt4JNwAu50+YV3twAcACjbLVIQTxOz+uU26Co8gdx
         DBR/P6IdrwN3Zur48wMJDup6EUh37PI/FpySOfdbMu6rbktdowd618gs4wdFF2ollFqO
         JApQ==
X-Gm-Message-State: APjAAAXK3ly3l5NqecU1KBIsqNDN7pocpEReNhoM6kRMyN3ATfmSiMKY
        CU39U7+W2dUVAIX+gol9tdQvUuluKuoWtw==
X-Google-Smtp-Source: APXvYqypwuZskQ1yIgXoYBG4S+9MbSSD/z8QLOBLMjqXEo8tkXH+zZeU1p9bdnsU+MPZrI89HRDRpQ==
X-Received: by 2002:a05:620a:22fb:: with SMTP id p27mr2786542qki.365.1581692084474;
        Fri, 14 Feb 2020 06:54:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d20sm1540890qkg.8.2020.02.14.06.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 06:54:43 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2cMd-0007Uv-E7; Fri, 14 Feb 2020 10:54:43 -0400
Date:   Fri, 14 Feb 2020 10:54:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        nhorman@redhat.com, sassmann@redhat.com,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [RFC PATCH v4 18/25] RDMA/irdma: Implement device supported verb
 APIs
Message-ID: <20200214145443.GU31668@ziepe.ca>
References: <20200212191424.1715577-1-jeffrey.t.kirsher@intel.com>
 <20200212191424.1715577-19-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212191424.1715577-19-jeffrey.t.kirsher@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 11:14:17AM -0800, Jeff Kirsher wrote:

> +/**
> + * irdma_ib_register_device - register irdma device to IB core
> + * @iwdev: irdma device
> + */
> +int irdma_ib_register_device(struct irdma_device *iwdev)
> +{
> +	int ret;
> +
> +	ret = irdma_init_rdma_device(iwdev);
> +	if (ret)
> +		return ret;
> +
> +	rdma_set_device_sysfs_group(&iwdev->ibdev, &irdma_attr_group);

New drivers are forbidden from calling this:

/**
 * rdma_set_device_sysfs_group - Set device attributes group to have
 *				 driver specific sysfs entries at
 *				 for infiniband class.
 *
 * @device:	device pointer for which attributes to be created
 * @group:	Pointer to group which should be added when device
 *		is registered with sysfs.
 * rdma_set_device_sysfs_group() allows existing drivers to expose one
 * group per device to have sysfs attributes.
 *
 * NOTE: New drivers should not make use of this API; instead new device
 * parameter should be exposed via netlink command. This API and mechanism
 * exist only for existing drivers.
 */

Jason
