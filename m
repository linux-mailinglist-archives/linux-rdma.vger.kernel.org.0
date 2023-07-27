Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062C9765A44
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 19:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjG0R3p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 13:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjG0R3h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 13:29:37 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1443A8C
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 10:29:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-403b36a4226so6752301cf.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690478963; x=1691083763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0aXIBEn3uR/bTZLnvVbTOW+Bupfnnl78tADWvahZrsQ=;
        b=hssbAwkQH/gHRQbfHOLk9vGmXqVNzEYrwO9Oo2+ne79JQ7NlpDBzLBfcbQG5ZIw3eb
         rhJF4MX+nSTULHYi5DgnRjf+SeTVqsBurjdrungRDIVyvxTX4LQr5Z1PCEDEIpM0IN6+
         IUhw1wY49RsA+FizWEd/6molI1k2kvdqRolvRkRbIoXOc83SrbiddFXYU45TuFkofsc/
         Q84mG1aGVhYetFpuevV0vbJq1y5p7gTfIE+BLqv17vNrGA09ajCgoHLznfTkZ3UkLIQO
         bVzCoTcSBsYHgkt5j16BweSTXsLurDrROGOWyELgRxnk0Z/OD4BSKWMeX8HrhnPtPCm/
         rIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478963; x=1691083763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aXIBEn3uR/bTZLnvVbTOW+Bupfnnl78tADWvahZrsQ=;
        b=aCCyqUclBh7dYP02k6wEQcPDRWiRiY0aRTrvnmYYvAYyfd/6xLL6MUrI1Z8cUleeNX
         LWJmQCRmANO6IAGD8qr5uwbUd5S3l2NrDsQtvLTw/Xel4MWudHkleBmKCWt54kALkJKj
         72GwWcFXkYc4gl34QAPdK3yDyI57VdxSuTKlBsMQ2fra5+nvhoNepaoMYMTHp+YzKeUY
         Qkr5bgHRCEZoU2E+w79GN2F4wxPOqQxQl9jGlw7pu8C5UEfMuBxalGH4ulYSc/4Ryj3X
         VwdYXwSwbDqkoImedUYZcXaL9DXgfeKPHeEeOOS/5e8YlMmkWlmxz0LMqzxGDGfnXMFa
         pYQA==
X-Gm-Message-State: ABy/qLZvM+naXt328/646dvRGJu4BK+Mh/05M4xFgNC6mzsqxTIq9zJn
        I9i1qsb34nRXnwm1OLoMXgtfgiGGXnkLD+bhSq0=
X-Google-Smtp-Source: APBJJlFYCNdJy9tJsRzz1mlJtdoHAoOCrqgksbKD5kloAE0leH6wF5obTSLK4BjphhIPhZzatH59dQ==
X-Received: by 2002:a05:622a:34c:b0:3fd:e9f5:7f6d with SMTP id r12-20020a05622a034c00b003fde9f57f6dmr214007qtw.19.1690478962894;
        Thu, 27 Jul 2023 10:29:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id a14-20020aed278e000000b004016edea7dfsm554040qtd.63.2023.07.27.10.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:29:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qP4nh-001NCv-N3;
        Thu, 27 Jul 2023 14:29:21 -0300
Date:   Thu, 27 Jul 2023 14:29:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 0/5] Fix potential issues for siw
Message-ID: <ZMKpcQsJ3FBvxYHo@ziepe.ca>
References: <20230727140349.25369-1-guoqing.jiang@linux.dev>
 <SN7PR15MB575506FAF5423F726708AF8F9901A@SN7PR15MB5755.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR15MB575506FAF5423F726708AF8F9901A@SN7PR15MB5755.namprd15.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 27, 2023 at 05:17:40PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Guoqing Jiang <guoqing.jiang@linux.dev>
> > Sent: Thursday, 27 July 2023 16:04
> > To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; leon@kernel.org
> > Cc: linux-rdma@vger.kernel.org
> > Subject: [EXTERNAL] [PATCH 0/5] Fix potential issues for siw
> > 
> > Hi,
> > 
> > Several issues appeared if we rmmod siw module after failed to insert
> > the module (with manual change like below).
> > 
> > --- a/drivers/infiniband/sw/siw/siw_main.c
> > +++ b/drivers/infiniband/sw/siw/siw_main.c
> > @@ -577,6 +577,7 @@ static __init int siw_init_module(void)
> >         if (rv)
> >                 goto out_error;
> > 
> > +       goto out_error;
> >         rdma_link_register(&siw_link_ops);
> > 
> > Basically, these issues are double free, use before initalization or
> > null pointer dereference. For more details, pls review the individual
> > patch.
> > 
> > Thanks,
> > Guoqing
> 
> Hi Guoqing,
> 
> very good catch, thank you. I was under the wrong assumption a
> module is not loaded if the init_module() returns a value.

I think that is actually true, isn't it? I'm confused?

Jason
