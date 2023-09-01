Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E59B78F642
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Sep 2023 02:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjIAAC5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Aug 2023 20:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344692AbjIAAC4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Aug 2023 20:02:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C87E6F
        for <linux-rdma@vger.kernel.org>; Thu, 31 Aug 2023 17:02:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf078d5f33so11533785ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 31 Aug 2023 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693526573; x=1694131373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNHF8dnNI4GSHJKTAS5ozu7by5NqtsqOXBkU/kqxDKA=;
        b=NYfUcHh0E5AlhQHVvpNqfVA4IaP626W/VlP0PzP7M/Vz9r9BFJtHjz8JtoWv6OhVwJ
         yO+BKaHHRGRgDDDUU9tpoK1OW1qmFf6XKdSGrQg7uz7rSffD+3DlxImXGD68SDejVpS4
         oRcZ1f837E3WgSBYLwF/Frc5QY3jmAT2zK3b6uRPV8ORvPn/7I+CI8VlNbO2aqPYzNT4
         OWcWYbG9IzSe+0+WZv967PieLuhrOMv0103xvl6VT8CtO7KMtSJM/EvvJ0sw0Pw3JwJE
         fpwk6O4/esUsLd9+W6oOwgPpvzrvSh9JYLfx6tZQJaKBx27OfHn3fNudvzT7FDmtdmKg
         gBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693526573; x=1694131373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNHF8dnNI4GSHJKTAS5ozu7by5NqtsqOXBkU/kqxDKA=;
        b=JAwSgmDmCRrWXGa8CD7e6/62I8OS536CI6laexW8uxH4QBJ06YModrxkbJrTgE6fSe
         R4E0SgFBiKxawQAaXm7jvcSlaClykDl/CnLYZucGy/DjSr0p7MIA7URI/wQr68/jLV5S
         HwtDZPaV8fE0wUNxuKhO0E+FEwlLWRZ+IxkLWyA+kbdZUMXiiqkzXdFEqyUO7fRFJ2v4
         7lAtoUS2e22dROUx8NTLaiASlLatLAl+/ZVpP5Y+eGwPJEXTRKLA+MA+Ntr+VoOZne8i
         nEgeAljaU8NloeIBLL35GBSUGe8ZhxesPRIJdHAybwIbL6KblLDriE9JXdd76bFUf7bh
         fKqA==
X-Gm-Message-State: AOJu0YwDc7nbardZinCZWfudRkPz/3JJD5aBSOy0faPQ9SbPlkUh3HeC
        pvS2PfjP+h9l86Juo0i/0muSjF8daIDwVnf308Q=
X-Google-Smtp-Source: AGHT+IFbhuHFNxk2NwGD42YTubnjRwUac9vjIrFMGJYI29Bg0ok+IU4UoDtGVxuVBvFLjD//YBr0EQ==
X-Received: by 2002:a17:902:ab07:b0:1c2:218c:3754 with SMTP id ik7-20020a170902ab0700b001c2218c3754mr1219290plb.53.1693526573185;
        Thu, 31 Aug 2023 17:02:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b001b87d3e845bsm1755402plg.149.2023.08.31.17.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 17:02:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qbrch-000Kac-4V;
        Thu, 31 Aug 2023 21:02:51 -0300
Date:   Thu, 31 Aug 2023 21:02:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kheib@redhat.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH for-next] RDMA/nldev: Add support for reporting ipoib
 netdev
Message-ID: <ZPEqK2tbPPKmtktF@ziepe.ca>
References: <20230831142225.588762-1-kheib@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831142225.588762-1-kheib@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 31, 2023 at 10:22:25AM -0400, Kamal Heib wrote:
> This patch adds support for reporting the ipoib net device for a given
> RDMA device by calling ib_get_net_dev_by_params() when filling the
> port's info.
> 
> $ rdma link show mlx5_0/1
> link mlx5_0/1 subnet_prefix fe80:0000:0000:0000 lid 66 sm_lid 3 lmc 0
> 	state ACTIVE physical_state LINK_UP netdev ibp196s0f0
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/infiniband/core/nldev.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Are we sure we want to do this? How does it work with namespaces?

> @@ -340,6 +341,21 @@ static int fill_port_info(struct sk_buff *msg,
>  			return -EMSGSIZE;
>  		if (nla_put_u8(msg, RDMA_NLDEV_ATTR_LMC, attr.lmc))
>  			return -EMSGSIZE;
> +		ipoib_netdev = ib_get_net_dev_by_params(device, port,
> +							IB_DEFAULT_PKEY_FULL,
> +							NULL, NULL);

And it doesn't work at all for non-default ipoib interfaces?

Jason
