Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158105A28F4
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 15:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiHZN5r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 09:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiHZN5q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 09:57:46 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0925B7A9
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 06:57:45 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id j1so1097645qvv.8
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=0OUpuGV1Hw1tFQpNMj1kkkg/S4kFCZNGnFNsfsi2hTQ=;
        b=PgNGXkni1y7jrMe15EeF7BUWzSQUHMy4/0yH1+jFPOpQ5l2N9IUVqjM6DjKnUO0WDr
         3UIjTKT5VY8COhrRqk6FK6Z0mQUp4Nlt/EcDMD5EV71SLHO16NwpYyETPt+vzoSLNksP
         8WWsTayHQvz/XV56VRniw9aOkRzLi6tAIq/ox/6vtmNGi3SsOk4yazm1VWfjRmo2peNT
         g6rS8umWhpTLroiqRdeUEqtsKZ/fri3fGaeEeo/egoV5fe2VjulXKBjg6N5AF2+NKFy6
         O9WMDC3zqhaYU3weygSyNYOn+MnjWo13PjBsFMSPQy26WZ2czJ4Js4yRbVBInFKTpZUr
         1NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0OUpuGV1Hw1tFQpNMj1kkkg/S4kFCZNGnFNsfsi2hTQ=;
        b=4/8CINmlN74/NxHEc+DDswE1g44UozVWwAiz68XyFURFF7ZLQ08orvSsyBsgyLuXgI
         VWARinVE07r97/OSRwsdiz88bDPX79mo8j3odz7R+FU2J54lvejzrMCHF3mH39AYGrxN
         WRzyuCr+j+7B/VmxzRNa9hQQ1JkXKBwMUEL2tzsg6Y2b1L9Bo7QpzIVuO7xKtmK1OLsN
         7gwjo4L67E7YOvVu3mRuNEaE8dkPusV5W86aIWv2Y/NaMsecDG1rO8IwoeMBVlQLzPMC
         DHAFlxge042psG2M18rc93Qwt1YHOy8JRixkEhduEofO05SLiSpIxQTI8e/taym2/vN6
         5f0Q==
X-Gm-Message-State: ACgBeo1W++I2+7IatgmZKR9pdAtb+eWM/by63l7yYnV0jn/e2JshTcnq
        vDHhXvgTDLH6mpHEZWppH2e7cg7yrZic6Q==
X-Google-Smtp-Source: AA6agR6x7m+SiVIJXUxCD4BxH1vDAHfmnfJxstzKGIXsWgGpz0u1f4oGRFTpIGCGqtzmZO03USlNPA==
X-Received: by 2002:a05:6214:301b:b0:496:f8df:f088 with SMTP id ke27-20020a056214301b00b00496f8dff088mr8155549qvb.82.1661522264963;
        Fri, 26 Aug 2022 06:57:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f14-20020a05620a280e00b006bbe6e89bdcsm1970285qkp.31.2022.08.26.06.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 06:57:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oRZqB-000byF-Db;
        Fri, 26 Aug 2022 10:57:43 -0300
Date:   Fri, 26 Aug 2022 10:57:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 0/2] RDMA/erdma: Introduce custom implementation
 of drain_sq and drain_rq
Message-ID: <YwjRV3kubU9wnwax@ziepe.ca>
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
 <2c7c248c-34a9-c614-6abf-e2f6640978b8@talpey.com>
 <9ba20242-7591-2ec9-4301-a6478a47fae4@linux.alibaba.com>
 <c7f4ce2d-e43d-50fa-afaf-1535aec2b0aa@talpey.com>
 <fc5dbf48-f3dd-7047-1933-c9e4b86ea891@linux.alibaba.com>
 <8ad2446d-157b-3894-c0a3-f8a57a6e1c34@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad2446d-157b-3894-c0a3-f8a57a6e1c34@talpey.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 26, 2022 at 09:11:25AM -0400, Tom Talpey wrote:

> With your change, ERDMA will pre-emptively fail such a newly posted
> request, and generate no new completion. The consumer is left in limbo
> on the status of its prior requests. Providers must not override this.

Yeah, I tend to agree with Tom.

And I also want to point out that Linux RDMA verbs does not follow the
SW specifications of either IBTA or the iWarp group. We have our own
expectation for how these APIs work that our own ULPs rely on.

So pedantically debating what a software spec we don't follow says is
not relavent. The utility is to understand the intention and use cases
and ensure we cover the same. Usually this means we follow the spec :)

Jason
