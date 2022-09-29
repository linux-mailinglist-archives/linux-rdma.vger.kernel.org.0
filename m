Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB65F00E2
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Sep 2022 00:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiI2WqA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 18:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiI2Wpc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 18:45:32 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7AFA0317
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 15:44:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y2so1798862qkl.11
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=C8DTd2XhXBNZr294MgnTSdwSZ5YY3MfsdGTuFVgv+kI=;
        b=e9dKVvc0osew5bBdyDEQo1sEwpgI/YDAwDNQpmHgwEDmdPGv83nyM8BdK34Ourcono
         Z0xsyYYY4VwJcXlzAwgI8E0TcNTBkL9xfuUFvejR2hLiOy72U/44unRE0a5WnWBVk9mX
         VQht2bO6oc3lQ/wh8k+V7/zREQgmOQHmK5JrH2PmfQXj8R3wv+uSaigJmnKsbfxF/1rV
         de2hPUPHVFiBqILMdezt3d09LSpu83bfrzwE403Ay1HJ1tprTI90MWWyK5SXIr7HeBRV
         r+Q4c0mp1hJfj5iGPtB92SyKuyWv4u0DFGKcamNOa+5WCTpETZlVbS66kHM/1bc/1mG4
         2t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=C8DTd2XhXBNZr294MgnTSdwSZ5YY3MfsdGTuFVgv+kI=;
        b=PyNI0h8HlY9aGWTm+mUkw1w3vS8aPEvL4jzNXlmrpvFQayAYjFCk5i4gG9VgzW9wG0
         gmysgq+e4eMSnBW09EB6ru2k9VRO574qTOsOjE62kAobYwMZBEK8iXsWBZOhddGCMk6g
         5m5PVmR6z7UjyoGMaz5EI8dCZgSPKVRwMr7I0eafcBygJ7775RmFhyRcP3icu+3x8h4P
         n/n9My2Wr2W3CIkVcZqPRWuvkZMGKWRJRrs/ckW3XbOpQpgvGVHEZRnfawpH/xs1G+eE
         PlHd4uB1R0EL2Qiw5vV97NNDvreBbwwCkoFr/+CudJJ1Lb74XqXZV/WXtN6O1c3c0XBw
         GMjw==
X-Gm-Message-State: ACrzQf1GuTJjHtp8pfkGK35zGm/svwgjZORD7mj9KZ+5+t0E311Z8h7l
        la2Q78ZGW0e8Ac6X7IvkZqnSbQ==
X-Google-Smtp-Source: AMsMyM6VJOyIz8dOkvahjOryfEaqRLhxojgMv+zbUJavpUSClpFuNSd88Ov6gTWf2XhVvLMF706/OA==
X-Received: by 2002:a05:620a:1aa8:b0:6ce:3dd7:7b46 with SMTP id bl40-20020a05620a1aa800b006ce3dd77b46mr4032945qkb.575.1664491458980;
        Thu, 29 Sep 2022 15:44:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a259600b006cf9084f7d0sm765631qko.4.2022.09.29.15.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:44:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oe2GP-0040cX-Ko;
        Thu, 29 Sep 2022 19:44:17 -0300
Date:   Thu, 29 Sep 2022 19:44:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: Re: [PATCH] IB/mlx5: Add a signature check to received EQEs and CQEs
Message-ID: <YzYfwXtLceoEw0qo@ziepe.ca>
References: <1663974295-2910-1-git-send-email-rohit.sajan.kumar@oracle.com>
 <BYAPR10MB29977D4DCA235EE5F91EFF29DC579@BYAPR10MB2997.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR10MB29977D4DCA235EE5F91EFF29DC579@BYAPR10MB2997.namprd10.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 29, 2022 at 04:25:32PM +0000, Rohit Sajan Kumar wrote:
>    Hey,
> 
>    Pinging everyone as a gentle reminder to review the patch sent upstream
>    last week.

It is not in patchworks or the mailing list, you will have to resend
it.

Jason
