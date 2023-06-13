Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D672E41F
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 15:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242266AbjFMNap (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 09:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjFMNan (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 09:30:43 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C71AA
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 06:30:39 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-62df53196edso5435536d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686663039; x=1689255039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y1wWr1tMbudbOK4z/i9FCl7+zcdXRR+g7ms2GZ5RIas=;
        b=gFdKAzdsC4Km23ekn6ACrWo5EYSNsh2vy5ZkHcAK7IVtBMlaYRrYIVVlhxpfZSmMg7
         WYpvSKLd+daLU69dYdZTnTZwY8a3cmpIHKv0ThNZnJ6fy8fnDSuBy/U9xfvo5q6YcOBR
         IbQp2aY1QmzuFR8osKO90LaK49Pp3V82j9Y6OCpRjFey5CkcH2d3FMqFkUDQ2jEKSofN
         KtwlkG48oBUAOAnP40DTZRYICSL5npHro95D4voyG+gM2QVGgRzdctKeBVmLql56Ev6D
         n8hQoPRtiE3QruGuT+BRpyUxWzpgIpAN4gBNLFmDtHmBUhJG12ZW7gmICwI+AcnllmkN
         l3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663039; x=1689255039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1wWr1tMbudbOK4z/i9FCl7+zcdXRR+g7ms2GZ5RIas=;
        b=YVHQSbh7mQ7pkAm823s/SPPnL0znLpvz/tC/MFmN+7izfZoMU5labHhKLzsSXHQlyy
         SZ2fIek2fnoJ7Enckf5e3tdIQLyYi/j82s/9vzzSv1gpYadSzCQpv7B1nluo138XSEze
         RVVJlP0/VRn9FykyPRjHTKICE8EO+yEBYRt+Fv5rIhS4Dkz5EPTiZj6L6lXVZxVO73AK
         voQcscIAbMHCy/vIcrWHSkj4+6XXyrmjMI1v0Uiz45dr49naDA4i+LEPmFV4bpOv3DvI
         xjXPZyMNl9l5i35LhShtuRxJiyzuvHdJmSObmpnV6ehN4FHv05drFsumU+zVeKjnjy96
         rY2Q==
X-Gm-Message-State: AC+VfDxmr+D5hRzGGJu1hiwoSksUe8fzLxSrDoXVvJAhO08VK5E4Sh0k
        PHm1imAvq/xnkyICzE3OP5mZ+w==
X-Google-Smtp-Source: ACHHUZ4IcAn5/udys+q00pDgo61L01aeH7U8dVDPeDSvd4nHc0VSAtwZb+HE9DprrPHS4pGK0tojOA==
X-Received: by 2002:ad4:5fc5:0:b0:62d:f6f1:10bf with SMTP id jq5-20020ad45fc5000000b0062df6f110bfmr2155854qvb.51.1686663038949;
        Tue, 13 Jun 2023 06:30:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id y16-20020a0ce050000000b006210e0365f7sm3876191qvk.69.2023.06.13.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:30:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q946X-004wZr-Kz;
        Tue, 13 Jun 2023 10:30:37 -0300
Date:   Tue, 13 Jun 2023 10:30:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Message-ID: <ZIhvfdVOMsN2cXEX@ziepe.ca>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 13, 2023 at 01:43:43AM +0000, Shinichiro Kawasaki wrote:
> > I think there is likely some much larger issue with the IW CM if the
> > cm_id can be destroyed while the iwcm_id is in use? It is weird that
> > there are two id memories for this :\
> 
> My understanding about the call chain to rdma id destroy is as follows. I guess
> _destory_id calls iw_destory_cm_id before destroying the rdma id, but not sure
> why it does not wait for cm_id deref by cm_work_handler.
> 
> nvme_rdma_teardown_io_queueus
>  nvme_rdma_stop_io_queues -> chained to cma_iw_handler
>  nvme_rdma_free_io_queues
>   nvme_rdma_free_queue
>    rdma_destroy_id
>     mutex_lock(&id_priv->handler_mutex)
>     destroy_id_handler_unlock
>      mutex_unlock(&id_priv->handler_mutex)
>      _destory_id
>        iw_destroy_cm_id
>        wait_for_completiion(&id_priv->comp)
>        kfree(id_priv)

Once a destroy_cm_id() has returned that layer is no longer
permitted to run or be running in its handlers. The iw cm is broken if
it allows this, and that is the cause of the bug.

Taking more refs within handlers that are already not allowed to be
running is just racy.

Jason
