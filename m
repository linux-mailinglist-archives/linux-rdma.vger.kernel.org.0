Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970A165CAAA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 01:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjADAS7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 19:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjADAS7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 19:18:59 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F52FD30
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 16:18:58 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id qb7so7843847qvb.5
        for <linux-rdma@vger.kernel.org>; Tue, 03 Jan 2023 16:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0atn0iniHte3SGU9siu6umkpxbpJmez2kN6pYnEtJVc=;
        b=TJNENb/+JAVpzfZh/AePlZA1nMrXrOwhMdGhDHWwsX3GDPoFgjV4PoxpTtzjJYV8z0
         0qIMIOfVJySJnuvdSHaEPJCuz73cUHNDPxS3uIr51CGpkYrozWBdLF1k2VqPUvdAYehm
         IHhJZsoG1SpovipvY6uVYCA+P8g25nH04C3P7UAaprFQ7g9+h5DK4NyIhQzjijt4yqP/
         4mP4oDuT+wi9odN+6GFqZLuwzwuO1IFjx0E7dt8PPmKLQu2Y7yMKy7IEWCPlk613NObO
         LveY6hUtoUJg5AIK4CKSScFODTC7+vlMLF/sTZExpLfawRKvQ4DO1fJXl2Lk6KRcgOJh
         dSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0atn0iniHte3SGU9siu6umkpxbpJmez2kN6pYnEtJVc=;
        b=bT7/da9c5TQGq8yFFVkv3XEOqmVTRpuNJbP5Jq68dwUvHLDv6GGTVKBj1Ps9JlRal/
         b2Q79g1qYtJjqqJ9DEAojIqlQ+eFoGtvrFhWdrJSVYrwyZOiAgYeisd+T2cc6aiTcTmd
         MrVBlYcI4nblK+2+hCLOFLOtmvP9RUp/TPij/qThu3+0IVw9tBK/praDMmVW2R6I88kM
         uMDrPJ4irDPNa3eSBcw++V/qdqlyzBHqkFsLHFYiNTJlxZMKsCv/VeuPX7sITwpxcLs/
         +P3vqH7E/NJn1N9K2Zrrtsv+VEotjRX31O3/kxZWL5nPlucGIe5I7Yehi/IUVPgizWph
         Yr6Q==
X-Gm-Message-State: AFqh2ko2WBhhhUZn5sIIJUS2x8K1giVkQd0obc0ACSv0mqqVtgD+PlFH
        h696XWKdzbWLn3VXRYFKWuNWdQ==
X-Google-Smtp-Source: AMrXdXvYCFBfZe7QQv8pep+eVu13cx24lRiQtaciYf1OIIOUf0SCvEuxijeriHol/y3Gjnheu0zXrA==
X-Received: by 2002:a0c:800d:0:b0:4c7:34b5:7993 with SMTP id 13-20020a0c800d000000b004c734b57993mr64047423qva.27.1672791537194;
        Tue, 03 Jan 2023 16:18:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b006bbf85cad0fsm23201666qkp.20.2023.01.03.16.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 16:18:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pCrUe-001d0j-41;
        Tue, 03 Jan 2023 20:18:56 -0400
Date:   Tue, 3 Jan 2023 20:18:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Haywood <mark.haywood@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: buildlib/pandoc-prebuilt
Message-ID: <Y7TF8EK/PXiwKRwU@ziepe.ca>
References: <4c29b8d8-c4c8-a7ae-e1f9-ddce3b55d961@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c29b8d8-c4c8-a7ae-e1f9-ddce3b55d961@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 03, 2023 at 06:04:21PM -0500, Mark Haywood wrote:
> I just extracted https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
> and noticed that buildlib/pandoc-prebuilt does not exist in v44.0. Is that
> intentional?

?

It looks OK:

$ wget https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
$ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt/
rdma-core-44.0/buildlib/pandoc-prebuilt/
rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
rdma-core-44.0/buildlib/pandoc-prebuilt/971674ea9c99ebc02210ea2412f59a09a2432784
rdma-core-44.0/buildlib/pandoc-prebuilt/241312b7f23c00b7c2e6311643a22e00e6eedaac
[..]

Jason
