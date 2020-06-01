Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD61EA598
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2020 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgFAOOz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 10:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAOOy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Jun 2020 10:14:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06388C05BD43
        for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2020 07:14:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s1so9108980qkf.9
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jun 2020 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IFSd0lM+5oS0t921WLpOPbQzBucVukCdkUKKoErmEbs=;
        b=ievD0DqZ66bOEIA0HZ8vcqwFy/CIAUwBRl9L33AQUKWCvTpex47aCyGGXnaJOz1sbe
         CvZlHT4O6tvclmJ69Q9msBZwNuiWxhaotER2AFQ+M7Z4dAon4c/nO2RwtOQK+t+vR2Hw
         VrNc9AErucu9NiJw/rnJBGq1RYKLbKu7FB7ji8iuk0nWRcW9WyONYiJ8zj/y14aIGq9y
         qr+NoYl8E6QltEPwwMrm2BhfZOnOb/MgJHtcozQ8DYzklvRoWDJpTl33h7uj0oWD0hHF
         NcajsHHMVYkwX2ud+6Kj5TqD+LEYZ33TxE8cTzls+slsg5jLejCz836Gp05ELHFJAt6Y
         KK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IFSd0lM+5oS0t921WLpOPbQzBucVukCdkUKKoErmEbs=;
        b=Ewr9+z/CYj7dOby3Ck20FLrlzRc0WTI3JXtxF+tMJryzhEX3yAu7NavJkOptsCmsyQ
         Xblt1tnkS4zegKFNUUmWwR3Hju1LQHKLCUpbatY7zM1qun1Sxr2Fv28igRGBkAvOx4Y2
         dYFg7q7AncjRN5mv+tRhKRUAgoI69rzKMl5Bi7jSii6m+FQPolQjvUCCeZkd0AVrFgOB
         vtYvO/Bymg63S9cxVjygH31mliZrPT6kIkw9C40x/sqL5dhIgQj8wfljtb8+1fqz7bOy
         Hyzy0TyPmqtvHvxbWfE3JiE/yky8Vye6f2zTAwoiAby5ToF+Ea23+0fjCAIycFk+o9JV
         6HSA==
X-Gm-Message-State: AOAM533rdDXaEv+ZEykKO2Hn35cI3fdS/2T2pNSdkyTt31dW8Pklwyw6
        E+FKPp8dbBrcItKIU/Wlx+AEWQ==
X-Google-Smtp-Source: ABdhPJxsxLusMAVoQVodlnsvnv+YbVV98ASJ0KcxzqmXYzN3sXp5jwD89vPhryNmJWMoLVXwQPj7Zg==
X-Received: by 2002:a37:4e54:: with SMTP id c81mr19435565qkb.46.1591020892158;
        Mon, 01 Jun 2020 07:14:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s42sm16325603qtk.14.2020.06.01.07.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jun 2020 07:14:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jflDG-0006GL-Mq; Mon, 01 Jun 2020 11:14:50 -0300
Date:   Mon, 1 Jun 2020 11:14:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] IB/hfi1: Fix hfi1_netdev_rx_init() error handling
Message-ID: <20200601141450.GA24045@ziepe.ca>
References: <BY5PR11MB3958CF61BB1F59A6F6B5234D868F0@BY5PR11MB3958.namprd11.prod.outlook.com>
 <20200530140224.GA1330098@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530140224.GA1330098@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 30, 2020 at 05:02:24PM +0300, Dan Carpenter wrote:
> The hfi1_vnic_up() function doesn't check whether hfi1_netdev_rx_init()
> returns errors.  In hfi1_vnic_init() we need to change the code to
> preserve the error code instead of returning success.
> 
> Fixes: 2280740f01ae ("IB/hfi1: Virtual Network Interface Controller (VNIC) HW support")
> Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Add error handling in hfi1_vnic_up() and add second fixes tag
> 
>  drivers/infiniband/hw/hfi1/vnic_main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Applied to for-next with the 'if (rc)' fixup, thanks

Jason
