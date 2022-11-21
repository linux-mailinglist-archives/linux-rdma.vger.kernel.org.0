Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129F2632829
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Nov 2022 16:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiKUPaF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Nov 2022 10:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiKUP3d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Nov 2022 10:29:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A1EFF9
        for <linux-rdma@vger.kernel.org>; Mon, 21 Nov 2022 07:28:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso11057489pjt.0
        for <linux-rdma@vger.kernel.org>; Mon, 21 Nov 2022 07:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZgG43/ONkkxAzZ2lY1tRnt7Ta874ft/hWKVey0Oz7I=;
        b=ayDqx50LbXvyDDHZS763Rs6Ta6IVWmouhCVn9KXhhLgPpu1ACcFzl6nKmyK63Y8H3D
         5S+PQmof8Kq4H61oS4ao/vQbhiM18R6xwS5hOYDt7JeeKd2uumSfENQuYn9HKv/+WOj8
         Whk3gbLG7RD81ca1LlsYTFpVXaKe9W+LLcFpkPmnP9rKBJ3E0przn55zEHXaK3JsyIH5
         wxWn9eOLoSowGAsBiEbgWCSMA+5h5qW3JEsmY/a2spyubJne40Lf4xF3XYyhNIySS7zt
         caWvxw7a6AX4jy8wOCmpst76zHCuEw9kzjjl/DMaUKJtKnN+tv6iuVPzRNXtfdwWefLW
         8rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZgG43/ONkkxAzZ2lY1tRnt7Ta874ft/hWKVey0Oz7I=;
        b=50gfIG25YUuIUj9Dg5omahSotI2Jm4wvQ1WgVNiZCHShYsZbG/Lyzb/AcmlNXocKiA
         xw4obP34yKSrELChEoxW0KzWIJh1AEhCCVR3BAHih6F71OWe9EUcHT+amat+uKpThKeK
         8D6FyOBVl9thmZ6tP2+w/kdOgsItqcA6hDnjo6kO5dHQcSlvSxK+XfVI4wBOxoeJKu97
         PVqjQyJWftGaJGDINYGEi4Dxn96yihoNvJ3l4pII6OnBnHjLLSXmcrp/nhSir5D5V+eK
         7xFFvy/xWyvxrKQ4fsVl1npD1jEt/Q5SEY8EMDY1cpPIkxRaz08c3yKYe42+YNNRJift
         1fnQ==
X-Gm-Message-State: ANoB5pnptfnvBdxisZuQy8mXA/lm+/6PELKUoUF0BFVEAsLeYF0jlh4r
        G0HxLc7n5zIJRBie21VdPqN6iARf2kzWDg==
X-Google-Smtp-Source: AA0mqf6uwWbLEpw8L8efgyTCF/MonZTxma2RKvOrSfYnVMw3POy95vh/cQ/p9jlauR+rrdQlUItmAQ==
X-Received: by 2002:a17:902:9882:b0:188:7a1f:fb18 with SMTP id s2-20020a170902988200b001887a1ffb18mr356119plp.0.1669044532458;
        Mon, 21 Nov 2022 07:28:52 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d187-20020a6236c4000000b0053e62b6fd22sm8765508pfa.126.2022.11.21.07.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 07:28:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ox8j3-00947v-CZ;
        Mon, 21 Nov 2022 11:28:49 -0400
Date:   Mon, 21 Nov 2022 11:28:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [for-next PATCH 1/1] RDMA/rxe: sgt_append from ib_umem_get is
 not highmem
Message-ID: <Y3uZMQJgcNFDhq5L@ziepe.ca>
References: <c806a812-4ecd-226f-109e-84642357fbcb@linux.dev>
 <20221120012939.539953-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120012939.539953-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 19, 2022 at 08:29:38PM -0500, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> In ib_umem_get, sgt_append is allocated from the function
> sg_alloc_append_table_from_pages. And it is not from highmem.

You've confused the allocation of the SGL table itself with the
page_address called on the struct page * stored inside the SGL table.

Think of the SGL as an array of 'struct page *'

The page_address() can return NULL because the 'struct page *' it
contains came from userspace and could very will be highmem.

Jason
