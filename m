Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693D057D382
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 20:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiGUSmU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGUSmU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 14:42:20 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9367888F22
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 11:42:18 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x8so60457qvo.13
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZZLXRGi3WNgL74Nmx44M/exPrqh0I+5K7h64IcVvUkE=;
        b=OMsvef03N9VOk/uSDLSUSJCbPH9etPy061AM+ykq+yObyrV2AadJAKlBekDg10b39X
         F3NXaIfaQeAOOIkbfCZfulHu/pGug7anx3hahsfsIlg6IR1Vxaug2qpL+MuLlofR+04A
         zp6xvp2ADSVODQTCIp1Xuhug/iszLjylnO029BKs4vxd0Ww737biJgqZEmrLzzY2kkPh
         JyL22c3B491bBcwOQi0O4+I+e1NX0Q/g1RB+IXXyVsYlLROl7ofZSOEwVidr6CUdkgN1
         zumjaMNlDyWdzcxbuU9zroKuOZPLbPRDYrS4Il2wwkl48u1o2RgkT2tW1BSOJL/XVrqt
         RP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZZLXRGi3WNgL74Nmx44M/exPrqh0I+5K7h64IcVvUkE=;
        b=yGGcgOuH7JxV8ZkmgUBpOgrV7C48o3Jeob8tzpI35LxhIcOlGCYcEqTb+pBwwWpKFb
         7DCcKu+7lcNb3WkqTXGXHr6O3gumeszgHNX8fS5xpoq1AlOIl1Xgvy47qs/8hoaGux94
         LNcWAoxiSi7YBMq2AcpcJiX5Abl+3TuRW8HP0jSS5b4tlc9FSR21Wq/N/MzAWlqXa8m+
         4uct2tJ2dRdS5Klg2HL1XzYzGyPwOylKuufQAhUzb/a4/RrXA8xh3cpPTBqvChxPuYej
         XGFsK4az95bqdymjtPzyFGP01BTbTmMd8qprRdt5G1KKsVDuB6xfe/RbJl8FAnytBnJf
         GtFA==
X-Gm-Message-State: AJIora/wVvFrH5i4bhM4xnwoxbLdoBKAWOORC2a+e6ExcL+ExpT/mdHE
        dTeU0JIeYMpIk/85L3PdWVDo+g==
X-Google-Smtp-Source: AGRyM1sbVLCbqFF/MLRT10aYi1G+Es7OdYIK6Z01YmUUl2DMeTbujOk8qVGOUN5HwbbFUmmosuFvTg==
X-Received: by 2002:a05:6214:da2:b0:474:5a4:864b with SMTP id h2-20020a0562140da200b0047405a4864bmr7541516qvh.120.1658428937740;
        Thu, 21 Jul 2022 11:42:17 -0700 (PDT)
Received: from ziepe.ca ([142.177.133.130])
        by smtp.gmail.com with ESMTPSA id c7-20020a05622a058700b0031f0cfc5645sm1909915qtb.28.2022.07.21.11.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 11:42:17 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1oEb7n-0001w9-Gf; Thu, 21 Jul 2022 15:42:15 -0300
Date:   Thu, 21 Jul 2022 15:42:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Creating new RDMA driver for habanalabs
Message-ID: <20220721184215.GB6833@ziepe.ca>
References: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
 <20210822223128.GZ543798@ziepe.ca>
 <CAFCwf10LXiAxf7Xr+pMcmSk-_q1FEY_YcBjoH05K0mkK9hMCYA@mail.gmail.com>
 <20210823130419.GA543798@ziepe.ca>
 <CAFCwf11NeJYDMBXaNTpQ+dLecxoAnFYE2Z9T9D4-A5gLtf8q+A@mail.gmail.com>
 <CAFCwf13LRmez63hGmXMDO2FoC3Qo_2BwtAtnzyJ70=_OcTc23w@mail.gmail.com>
 <20220706162448.GK23621@ziepe.ca>
 <CAFCwf10rGdOx94bOOW8vfuW73H_KFKPu2tg2Hpduzd+1OjnVOw@mail.gmail.com>
 <20220708132916.GA4459@ziepe.ca>
 <CAFCwf11ibw0y_pZbAYE3B_-Wp7FmqK_Qt=gzQeOr5brzm4E4fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11ibw0y_pZbAYE3B_-Wp7FmqK_Qt=gzQeOr5brzm4E4fw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 10, 2022 at 10:30:41AM +0300, Oded Gabbay wrote:

> Per my understanding, the MRs are meant to notify the driver that the
> user would like the h/w MMU to be familiar with these memory regions.
> As we also need to pin them, it is preferable to have multiple small
> MRs than a single very large MR.
> The fact that the key that is returned is the same for all memory
> regions shouldn't affect the user. Our MMU will be able to do the
> translation correctly using only the ASID+address.
> In addition, because we also have on-device memory (HBM), we would
> like to allow the user to register memory regions in that memory. So
> we need to support at least two MRs.

I think it would make sense to stick with a single MR and just have
some DV operation to remap portions of it. It achieves the same thing
for you without creating a verbs confusion with multiple MRs that are
actually the same MR.

mlx5 already has a dv API that is sort of like this, so there is
precedent.

Jason
