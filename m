Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2755A4A5
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 01:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiFXXLi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 19:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXXLh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 19:11:37 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B5388B12
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 16:11:36 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id n15so6670115qvh.12
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 16:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nd/lt6E8OaO2NEmLKvlDR5Haw9geg+IvwaMpBdXGlWg=;
        b=CDG157+kjMOOH/a/ACYVfBDBF8Rmsfrz4tYz/hI9pdgJB6Opgp7K8VYjecaH4GuM4K
         ZkcuURQOKnGC8oGL1XiM4fBnTGCOUCaKdc1+53efZ2NGcdBbgx6eSBIauZF2L/UNbOK/
         upPLqmdiba+LSg+II9vM9PUUIgLxlXFCb4LmmDxPREgJD15y8YPOZ8YO0wq0Ywh4X3rY
         EWoz3a8nlfdlhwj7ygmQlETNB8o4CgN2CWlQ4iGqBQab3DUv5ot5mvmVis3IycbQNI9r
         cxTSVbQcfjvnsI016GzgGFTRvBe75ci9fX+F2LP5HeZNIV3O3NAacvWn3i/dRAQmN5l3
         zedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nd/lt6E8OaO2NEmLKvlDR5Haw9geg+IvwaMpBdXGlWg=;
        b=OIpJkSa6Y9Y2Na4TlMHO6psuR5cksO/cdriYiGcLspnresMfWaDYIZccr+LTW/vXRq
         /ZzX4ukLHsJMAm6PDYvWO3dLX1YERZm2ZmMMMaPaUlb1Cl6oHP827Uqeveqp4sNw+SJd
         Cg1AWfeRmdn95zFt9rqAurjxSHnIX678Uxutrh7iqIuV7ewBoL6jULxBQj4qmFkP/GY1
         95OG7ytMZOfD17KJOxwx4akCKNiK3XFxLy5erqxM8P8j+KoGTxyqJyYyqG2/0Bp0qYAa
         kwzzEKb8PqZJ691Wx+3BM6S8b66tBesg5eZ+Zx3TWUos39W9hZ3zibp7y3m11ypy9mzI
         kNmg==
X-Gm-Message-State: AJIora9Ikx4QfARJeEZaNl1l/3zXmvobwHPU2kAVTmxBOEKHVGVgUwAL
        KolI2alK+byhK6HDh1MuZgqhgsmheI5hUA==
X-Google-Smtp-Source: AGRyM1uUEMlrZafmifJAYVijxD0vNxYuIabPpjN6cO7ywsBoMXP4WUtWYwFFBMGMFg1wWEwPUxkQOw==
X-Received: by 2002:ac8:5a50:0:b0:305:20c4:791d with SMTP id o16-20020ac85a50000000b0030520c4791dmr1231902qta.437.1656112295668;
        Fri, 24 Jun 2022 16:11:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm2847133qko.112.2022.06.24.16.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:11:34 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o4sSc-001HMe-Cj; Fri, 24 Jun 2022 20:11:34 -0300
Date:   Fri, 24 Jun 2022 20:11:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerd Rausch <gerd.rausch@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 1/1] RDMA/addr: Refresh neighbour entries upon
 "rdma_resolve_addr"
Message-ID: <20220624231134.GE23621@ziepe.ca>
References: <60b4df0f7349570fe91b94eb8861043f0aba7cf2.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b4df0f7349570fe91b94eb8861043f0aba7cf2.camel@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 16, 2022 at 08:57:14AM -0700, Gerd Rausch wrote:
> Unlike with IPv[46], where "ip_finish_output2" triggers
> a refresh of STALE neighbour entries via "neigh_output",
> "rdma_resolve_addr" never triggers an update.

Why? We alread call neigh_event_send() right after this in
addr_resolve_neigh(), and this seems to ignore the input resolve_neigh
to addr_resolve() ?

I think there is more going on here than this commit message is
explaining.

Jason
