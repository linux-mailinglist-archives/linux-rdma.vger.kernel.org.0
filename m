Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B78867C956
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjAZLBK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 06:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbjAZLA6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 06:00:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825A72ED5D;
        Thu, 26 Jan 2023 03:00:57 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n7so1363080wrx.5;
        Thu, 26 Jan 2023 03:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VehCcPc5oamf6yJ895qNayFJF7UKM6woflLaenVwWu8=;
        b=nYDIPiJhQdGxnkUxCb7vz5Fn1JLaz2Nf06P9u3I6PhW8Q+hkC8nuNyZ18qToAZt1mh
         CObz/55kCZZNhCOZoZfhTK5Ma2F25n/4c6qhPCadKwjgsB3DIbIVDOU8+r4q+RsXMwl9
         IixFwdNZ4bxC7EOD3mBzqGHDWdTowpI+I55SAr5hfrFWXISZFMfiUG6cxN7hRf8QEr31
         ahcqC3OLA+ZmwPAueu9Ose0Zzr6yNW8iwknJ20Wfgb2JLHlcM6u73/4AVA1AL9X1uDLp
         f0sNGNShD38Trd0uV0/maneIQ7mQ2NQOvEJg3p08C1dVh7Ix27dzRdzclQYM39DDWqmk
         GgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VehCcPc5oamf6yJ895qNayFJF7UKM6woflLaenVwWu8=;
        b=bEaqL0TBQG8uV7WgfiuzOkmtwvheZowrXsha5dUmaqwmgHrw5jIMM1ldbrnbuv7Zr+
         KVKaYTTcmHCGxx7bDErPbf7Ow22h+yaW5QALlqZ3HwhEA4UTh1Pl/hUacHFANHs0e13M
         WobCXRfmA/O+4h7eeQc/mBwZadxD6993OSdAtMJzRIXMLUWTJqk/vm6YhpzTC+UlZ/W+
         jieiAYblUtrcYUNZbPlBfdEmrwGIS+ksnPN8yc+4hzqmaqM7CRxkQnTZ5qNMPlpbUvCL
         C7nHMRrulm0bNa6Xaw6B4zlI45yCMB96oDqnW6znW5L3Cb5NP77iC0TnUh6y0LzjKDAc
         +LDQ==
X-Gm-Message-State: AO0yUKVghW2UCN6Ryc3vdb6tdpdWGOAiD4M82YxyjCn+LAFFtvnUqjp3
        kFNrMGFmsHiKr8mgw1Sgah0=
X-Google-Smtp-Source: AK7set8dIuJOVQgCVuzoQ0w6XBThN40o/xychVKQ79ukoCcUgu9EZHpKEzVCBfcuqEZQYsJTHGCxjQ==
X-Received: by 2002:a5d:4dc1:0:b0:2bf:b2fe:a2ca with SMTP id f1-20020a5d4dc1000000b002bfb2fea2camr8439459wru.20.1674730856022;
        Thu, 26 Jan 2023 03:00:56 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i6-20020adff306000000b002425be3c9e2sm1000897wro.60.2023.01.26.03.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 03:00:55 -0800 (PST)
Date:   Thu, 26 Jan 2023 14:00:45 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dexuan Cui <decui@microsoft.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/mana_ib: Prevent array underflow in
 mana_ib_create_qp_raw()
Message-ID: <Y9JdXfJvGhrJeLF7@kadam>
References: <Y8/3Vn8qx00kE9Kk@kili>
 <Y9JThu/RSCGKAnTH@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9JThu/RSCGKAnTH@unreal>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 26, 2023 at 12:18:46PM +0200, Leon Romanovsky wrote:
> On Tue, Jan 24, 2023 at 06:20:54PM +0300, Dan Carpenter wrote:
> > The "port" comes from the user and if it is zero then the:
> > 
> > 	ndev = mc->ports[port - 1];
> > 
> > assignment does an out of bounds read.  I have changed the if
> > statement to fix this and to mirror how it is done in
> > mana_ib_create_qp_rss().
> > 
> > Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> >  drivers/infiniband/hw/mana/qp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> > index ea15ec77e321..54b61930a7fd 100644
> > --- a/drivers/infiniband/hw/mana/qp.c
> > +++ b/drivers/infiniband/hw/mana/qp.c
> > @@ -289,7 +289,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
> >  
> >  	/* IB ports start with 1, MANA Ethernet ports start with 0 */
> >  	port = ucmd.port;
> > -	if (ucmd.port > mc->num_ports)
> > +	if (port < 1 || port > mc->num_ports)
> 
> Why do I see port in mana_ib_create_qp? It should come from ib_qp_init_attr.

I am so confused by this question.  Are you asking me?  This is the _raw
function.  I'm now sure what mana_ib_create_qp() has to do with it.

The port comes from ib_copy_from_udata() which is just a wrapper around
copy_from_user().

regards,
dan carpenter

