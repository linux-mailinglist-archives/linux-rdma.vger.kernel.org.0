Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9C924D63F
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgHUNjZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Aug 2020 09:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgHUNjX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Aug 2020 09:39:23 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6752AC061574
        for <linux-rdma@vger.kernel.org>; Fri, 21 Aug 2020 06:39:23 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o22so1164041qtt.13
        for <linux-rdma@vger.kernel.org>; Fri, 21 Aug 2020 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MKVtu0huNWPoi4f70gbVdXgIVo7OPlWGvtT3lWq7dGQ=;
        b=LZdFmWso+59T6z6TbPDyyIWFyw3bTNLc9rC1+8nvs+MVu7jE/q4ePc9TCedeJNpKQY
         SHy8y7MCk6QEYVD94wZD54TGaMiKSpWh5ADHL7W+OUkwt5Fyy0mNF+NblXEH8/RsUonU
         HzpX7jNNQIw0SMgqvqBP4ghbSIFp0xKqob8PZx/JxAKtgmYmg+LS25DctYAeBv1N3nMX
         ztETxYJDU1/Qr4H4/3sluSXyEDmnWwoPofRAXC6iXMip0xTexksS0ne0WXzmlYJUMMBS
         16unnnh0g/mOEyndZteVQ8HZyC8qi2OCQmIpfehfh/q9FwdauqIl2Vh7FRWyepTzjUOD
         rr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MKVtu0huNWPoi4f70gbVdXgIVo7OPlWGvtT3lWq7dGQ=;
        b=mKtppXQ3U75qwTkCnFCDlnbHi73dj8C29xOq4GlcTDZg+0/bnB6dvbUJkj2y+rF3TG
         QmrJs1MIiTnrfOwvNI93Fmv5Ie47OQtiFh9EqndOeiMD68zDpnfdrbDW0T3VnC2/qdoW
         xv5dYQd2yJsvYPOiLrxta/3BUHNMz+/S3HlPcahry0ya3IHcNpMnFCVjfDH29ubTM7iy
         nNDLF/KYLdMuAP685TBw3qfOKQLhdELeLlFt7WxaGjQVBEUCBArQY8bIi7da8tad/g4N
         Uoq/Ka2c6FA2/j3wwWvqWbjdjYint9kuPAe6mNA+tIWURcaqJVyiECbiiSXt7mNNKewb
         pMFA==
X-Gm-Message-State: AOAM533GgGt/N+bfKagWuTBN125RAq3it3RDuU4wTOtjloD/vH0iqbSg
        Sjk5rmt6kBeByM/wn4Z7Cp/c8TXb6f/qlA==
X-Google-Smtp-Source: ABdhPJwd8K69wIrq2mgwwLZ8AViAeiNGiIdzV7q9GmbkmU8PGNUTNimUttg8vFRBThqS0YVzDAjtgw==
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr2673949qtr.1.1598017161575;
        Fri, 21 Aug 2020 06:39:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g129sm1812567qkb.39.2020.08.21.06.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:39:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k97GJ-00B03c-28; Fri, 21 Aug 2020 10:39:19 -0300
Date:   Fri, 21 Aug 2020 10:39:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Ariel Elior <ariel.elior@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/uverbs: Fix memleak in ib_uverbs_add_one
Message-ID: <20200821133919.GC24045@ziepe.ca>
References: <20200821081013.4762-1-dinghao.liu@zju.edu.cn>
 <E59593D2-E7F5-4D41-B6DC-B8B8C55241CE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E59593D2-E7F5-4D41-B6DC-B8B8C55241CE@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 21, 2020 at 11:47:32AM +0200, Håkon Bugge wrote:
> 
> 
> > On 21 Aug 2020, at 10:10, Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> > 
> > When ida_alloc_max() fails, uverbs_dev should be freed
> > just like when init_srcu_struct() fails. It's the same
> > for the error paths after this call.
> > 
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > drivers/infiniband/core/uverbs_main.c | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> > index 37794d88b1f3..c6b4e3e2aff6 100644
> > +++ b/drivers/infiniband/core/uverbs_main.c
> > @@ -1170,6 +1170,7 @@ static int ib_uverbs_add_one(struct ib_device *device)
> > 		ib_uverbs_comp_dev(uverbs_dev);
> > 	wait_for_completion(&uverbs_dev->comp);
> > 	put_device(&uverbs_dev->dev);
> > +	kfree(uverbs_dev);
> 
> Isn't this taken care of by the *release* function pointer, which
> happens to be ib_uverbs_release_dev() ?

Yep

Jason
