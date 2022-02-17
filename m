Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943C24BA47B
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 16:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbiBQPgr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 10:36:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiBQPgq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 10:36:46 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45EB237F8
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 07:36:31 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id f19so8933008qvb.6
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 07:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S0kEZ1PcPXY0dY9lx7emg7tGaAcpP8itSY0O7IB3Goo=;
        b=eD8p3BY/kVw0x8m5jcMhSDZSIDPsTdFXLZJLeBpCNBRJ9N4DM/eB1xQPO1wsMp9mRZ
         q3eO4q3KbpQbUCo1UHwLCRWyqdyhl+hFMJ5s/A/TLa9vpqPcuXNkTivqrTjjGSpjT5+j
         DEbI+cOkhui5a0k18pS2FITnuwBQ5SCnU8DiZTOR9FH43tLngnGpiHf+4PwzYQQZnr10
         vqgAc8Ki5j8ZBLDr+DO/8RP8DbYGIoa0tHWYA6OiGtrct2n6l0G8oatvjoxa2B0QdgRH
         qMIfTUbk8y36KXaaz5R3plMZyXymliHsPnE/dBAOc61qTGz3Cf5uAZ68tld1GUI2DurK
         bfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S0kEZ1PcPXY0dY9lx7emg7tGaAcpP8itSY0O7IB3Goo=;
        b=DnJl0we+KbCKv4R/JSINIuse0doW2JQxp3nSCWQIdm1BtdMrN/VOir45ruIlm3wJFM
         fcRml+RmPgJaa1chtXx/wVIxn/SB1YSdD+7Yx8qka+rYAAJLQfzl5Mih8fHTZGGoAwgd
         MkfFGeYjS6ZXc/8N7xMtU83rf58WSVLeGwYKl815ES510CDAKYgXFGyVa7odbt1341jP
         H4dIS+ZmWLVVDrBK1c9yce2vxQRQsb8U4aPPYtj37Xo/32U5XIJ6gH3Nk8DHqOHeLHjP
         cByaCHmwvatNXEr+v9JY1v5ZbSNVYrRtJuJNBwOuPX75B7IcT1d11McA1JmnZwyjwtWx
         B6lw==
X-Gm-Message-State: AOAM532m2JRtgvPb5j6n79E85dq1SyTogW2Rdpyk4NQf5Y1bQA4BffEm
        YS7VkVdpZyEb1jbcY9ITnqey8w==
X-Google-Smtp-Source: ABdhPJzq04cDgGoCv5ORPqCmqMAJ+BXnYVdxg7c6zZvyT7eK2CdePx10wwqkEj1R7g2rHZMESwJJNw==
X-Received: by 2002:a0c:aa9a:0:b0:412:91e0:3d8 with SMTP id f26-20020a0caa9a000000b0041291e003d8mr2542527qvb.87.1645112190993;
        Thu, 17 Feb 2022 07:36:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id e16sm24236524qty.47.2022.02.17.07.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 07:36:29 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nKipY-0060Lv-Dc; Thu, 17 Feb 2022 11:36:28 -0400
Date:   Thu, 17 Feb 2022 11:36:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-rc v2] IB/cma: Allow XRG INI QPs to set their local
 ACK timeout
Message-ID: <20220217153628.GB1037534@ziepe.ca>
References: <1644421175-31943-1-git-send-email-haakon.bugge@oracle.com>
 <Ygjx/XokZw/ZMDuT@unreal>
 <E906DFE6-D7A9-463D-91A5-2753D1E0F8CE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E906DFE6-D7A9-463D-91A5-2753D1E0F8CE@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 17, 2022 at 11:29:41AM +0000, Haakon Bugge wrote:
> 
> 
> > On 13 Feb 2022, at 12:56, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Wed, Feb 09, 2022 at 04:39:35PM +0100, Håkon Bugge wrote:
> >> XRC INI QPs should be able to adjust their local ACK timeout.
> >> 
> >> Fixes: 2c1619edef61 ("IB/cma: Define option to set ack timeout and pack tos_set")
> >> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >> Suggested-by: Avneesh Pant <avneesh.pant@oracle.com>
> >> 
> >> 
> > 
> > Thanks,
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Thanks Leon. I just saw that we need a s/XRG/XRC/ in $Subject. Shall I send a v3?

I will fix it

Jason
