Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233AB566F0B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 15:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiGENPr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiGENP1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 09:15:27 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5E935DC1
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 05:39:35 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l14so13398565qtx.2
        for <linux-rdma@vger.kernel.org>; Tue, 05 Jul 2022 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MV/9robfJ8dyu1dzaK7LWHNMYMEjsO1EwYVbeXZRAbk=;
        b=OogdDWH7Cz1tYCj8sXZquslNIbgXiTkWCg6YZwVFVw1Vm9fbVxgkCoLz9+p6UVNYYC
         oZYiE6gGxNIbLNrcQkQCfLOXCkExR+vFekIHKLdSYAwTS2t00Ln/w5v3R9EccL6pJLSg
         ZOEjcfm1n0zQgpoBKKOlrAV4r/dJ0NNWLaVW0wLcEMYc1WK7eBOSub1lTOlLEZc7kthD
         cDbg0cfUe06wq6qh0OSbNGiFcVapWRPEn87VUN4txRHP5R08y0HmjsvWjdId81vBxavT
         izY0PsCfZ3GKY6EtRr9BnYxhYv6sgp8lm2sEOMtdLEOEvSNlZMgMSFNemUqy2eOoFbXq
         pqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MV/9robfJ8dyu1dzaK7LWHNMYMEjsO1EwYVbeXZRAbk=;
        b=kvlURfPgZtQrw/T69RsDcJGELHHA6yOj1Ukt872PP+zXJ+OC5rnP7jfeOLWm3CxFpa
         j/xEbE/zd24VqXRz/xeMzW5H1y4H5kTxbiG6ieEKEDh+caUR9ZZJ+NgM8sRykrAzk+O1
         JN1XyVOmAhN8gX6W6ovSqyuj/z/hEVoD6bMlSxVpqlEJWvXHmOnCEdFRnC+4EVDApvTh
         iOXDRxurXQe6qsPQSNi3gTHRInpMNPmVCNQZl7HwMxW42ZbykNSNUfzXOjShN6WjyjWV
         k+goatNPcFPWPE5AhABrovCGp2ayEEgm+zXCXqzluF1gnHWMQ8QaZ/QRUTvFOnS8QrXo
         wjwQ==
X-Gm-Message-State: AJIora9iI7LGmM35bRU0Q0LfHcWdM2WJCzDrufyqBacusccy1s6WX/Mi
        MJX1AK4s4RbxjkgkK1wIasYXQTchar7SmA==
X-Google-Smtp-Source: AGRyM1vl/UolXvUCaPV0Ugru3PEs2Xxe7Q2FFWkRRZO5sxltcSVvDHIdMgZO4Y9yxM/vpysXbe6i/g==
X-Received: by 2002:ac8:578a:0:b0:31d:3ca6:d7e0 with SMTP id v10-20020ac8578a000000b0031d3ca6d7e0mr16265174qta.181.1657024774610;
        Tue, 05 Jul 2022 05:39:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id bx15-20020a05622a090f00b0031c56d5f7e1sm13508248qtb.92.2022.07.05.05.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 05:39:34 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o8hq1-006TzK-Ez; Tue, 05 Jul 2022 09:39:33 -0300
Date:   Tue, 5 Jul 2022 09:39:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: use-after-free in srpt_enable_tpg()
Message-ID: <20220705123933.GD23621@ziepe.ca>
References: <17649b9c-7e42-1625-8bc9-8ad333ab771c@fujitsu.com>
 <ed7e268e-94c5-38b1-286d-e2cb10412334@acm.org>
 <fbaca135-891c-7ff3-d7ac-bd79609849f5@oracle.com>
 <20220701015934.1105-1-hdanton@sina.com>
 <20220703021119.1109-1-hdanton@sina.com>
 <20220704001157.1644-1-hdanton@sina.com>
 <a671867f-153c-75a4-0f58-8dcb0d4f9c19@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a671867f-153c-75a4-0f58-8dcb0d4f9c19@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 04, 2022 at 09:34:07PM -0700, Bart Van Assche wrote:
> On 7/3/22 17:11, Hillf Danton wrote:
> > On Sun, 3 Jul 2022 07:55:05 -0700 Bart Van Assche wrote:
> > > However, I'm not sure that would make a
> > > significant difference since there is a similar while-loop in one of the
> > > callers of srpt_remove_one() (disable_device() in the RDMA core).
> > 
> > Hehe... feel free to shed light on how the loop in RDMA core is currently
> > making the loop in srpt more prone to uaf?
> 
> In my email I was referring to the following code in disable_device():
> 
>        wait_for_completion(&device->unreg_completion);
> 
> I think that code shows that device removal by the RDMA core is synchronous
> in nature. Even if the ib_srpt source code would be modified such that the
> objects referred by that code live longer, the wait loop in disable_device()
> would wait for the ib_device reference counts to drop to zero.

That is not really the "ib_device" reference count it is the
"registration" reference count.

IB has a system where drivers/ulp can create critical regions where
the ib device must be registered using the ib_device_try_get()/put
calls. "Must be registered" is useful in a number of places but should
not be held for a long period.

This is distinct from the normal struct device refcount that simply
keeps the ib_device memory alive.

Jason
