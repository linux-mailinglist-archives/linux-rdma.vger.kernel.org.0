Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B4612FD35
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 20:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgACTpA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 14:45:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43414 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgACTpA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 14:45:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id t129so34625806qke.10
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 11:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9eJ0zBJz79JBEzATjG7P+ZkVDd8SgalcSWzPRhfC4wA=;
        b=pTe4v0WtYFXNfPeGwMdZq45WQA+46OzdBaosulTKTO4frO2NH45pBOpxhSQVADVgHD
         fqj/no5RiguzaQW0o268LWcuNMuJKf//t/c2k3xESb5lj72BASPVxFm+tmsR+SMzT8UF
         g0l3+HXdwPzZHAsv1MKKWy509JQrYogjubsdbDoQ/j8s8kjneHNeDA1fcy5j8qw3h13L
         Z6YpgDI/WdvKuXK8QaVLX4ncrARVmLA/Zhx6D/Iciuy4gdRMPVn923pvdSMDUOdYZdcH
         8Zc4ytDDzpdVX3K/H6y43XwJqBcOmOfdQYbNaQauutkBu/o6556A9tgj4t+1NRCitUiJ
         beOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9eJ0zBJz79JBEzATjG7P+ZkVDd8SgalcSWzPRhfC4wA=;
        b=DXPVAOKA44QuqFhNUZCqbFefAcXAbsaIukphv7U6xdRUMoORX5l5yibLKDqPcVTMGH
         3fRKybqJSX5xSTk7bUjPmW2+QmhNXWv8siRywizEOez+4IO7xBijWXV7kN+WXBasod0n
         uZpqZofRIUA0KxWQdUskUNu93m9jA/4hSMvU/PHbF4ReDg/xO1VM7PR6KSjq0K7A2Bwq
         bM7EEOdn/AdmllW1rUSoSG6TZIH/fYRoaOdzNMEW2h0YPzVqNLv6rOuUyaayv3p27JQG
         JbVzRrk+aQVhScijTxNDc+CJPRyPJVmitcNCUhXtoui3cUAOer5pr/hKj8/6jgWn4BYX
         V8LA==
X-Gm-Message-State: APjAAAXO0lbkhJcSaAavvAzcYae4j+Dz83XsDe+utsZeiKkK3zeNmg3s
        Go1LWVVTJG9oOXno3LY2Ef0Vzg==
X-Google-Smtp-Source: APXvYqz+M79mf+Z1gs45Jkx6e0X3Cux2m70iL3TjVGEybZsB/GYyyza7/hSy52Zbj0UrHc+9fYmLVQ==
X-Received: by 2002:a05:620a:992:: with SMTP id x18mr72861721qkx.327.1578080699640;
        Fri, 03 Jan 2020 11:44:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y26sm19243438qtc.94.2020.01.03.11.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 11:44:59 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inSsU-0004iI-L6; Fri, 03 Jan 2020 15:44:58 -0400
Date:   Fri, 3 Jan 2020 15:44:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 5/6] RDMA/bnxt_re: Use driver_unregister and
 unregistration API
Message-ID: <20200103194458.GA16980@ziepe.ca>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
 <1574671174-5064-6-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574671174-5064-6-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 25, 2019 at 12:39:33AM -0800, Selvin Xavier wrote:

>  static void __exit bnxt_re_mod_exit(void)
>  {
> -	struct bnxt_re_dev *rdev, *next;
> -	LIST_HEAD(to_be_deleted);
> +	struct bnxt_re_dev *rdev;
>  
> +	flush_workqueue(bnxt_re_wq);
>  	mutex_lock(&bnxt_re_dev_lock);
> -	/* Free all adapter allocated resources */
> -	if (!list_empty(&bnxt_re_dev_list))
> -		list_splice_init(&bnxt_re_dev_list, &to_be_deleted);
> -	mutex_unlock(&bnxt_re_dev_lock);
> -       /*
> -	* Cleanup the devices in reverse order so that the VF device
> -	* cleanup is done before PF cleanup
> -	*/
> -	list_for_each_entry_safe_reverse(rdev, next, &to_be_deleted, list) {
> -		dev_info(rdev_to_dev(rdev), "Unregistering Device");
> +	list_for_each_entry(rdev, &bnxt_re_dev_list, list) {
>  		/*
> -		 * Flush out any scheduled tasks before destroying the
> -		 * resources
> +		 * Set unreg flag to avoid VF resource cleanup
> +		 * in module unload path. This is required because
> +		 * dealloc_driver for VF can come after PF cleaning
> +		 * the VF resources.
>  		 */
> -		flush_workqueue(bnxt_re_wq);
> -		bnxt_re_dev_stop(rdev);
> -		bnxt_re_ib_uninit(rdev);
> -		/* Acquire the rtnl_lock as the L2 resources are freed here */
> -		rtnl_lock();
> -		bnxt_re_remove_device(rdev);
> -		rtnl_unlock();
> +		if (rdev->is_virtfn)
> +			rdev->rcfw.res_deinit = true;
>  	}
> +	mutex_unlock(&bnxt_re_dev_lock);

This is super ugly. This driver already has bugs if it has a
dependency on driver unbinding order as drivers can become unbound
from userspace using sysfs or hot un-plug in any ordering.

If the VF driver somehow depends on the PF driver then destruction of
the PF must synchronize and fence the VFs during it's own shutdown.

But this seems very very strange, how can it work if the VF is in a VM
or something and the PF driver is unplugged?

Jason
