Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0745D56563E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiGDM4E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 08:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiGDMzs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 08:55:48 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E4511466
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 05:55:42 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id i11so9750058qtr.4
        for <linux-rdma@vger.kernel.org>; Mon, 04 Jul 2022 05:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MyvtwDChEwCdQVh5aGFvmjJ86anRb7CfVG7QHKgc7LA=;
        b=d2JzXWFRgE5JJjJf2/6E4xP/RJbjLjvpW6mD3e0cf3EYbY+wKSyIZEkstBbDskGN0i
         lw2NP8JIcNS3e6Li72+dJFvSSP7CheIPlzrx3WFq6rWnYlHZxhGUVItJaeE+Vs8GqTGB
         k5gVcC1Iqd8AgibBGDFLYKbDjmzCDPLlGjNQdcjqUCQJOoyODenA7WEHWRvVrx8dFC2c
         ZY/riuwLGhx2twXI9HDnzlh6UE8PJwmxNJFJzP8cs4cefS4l8guq/Bjo1g3Sj7Z8VLRk
         hoiD12VtTZ4BMqKqxrZJCoGm48/ljQ0XmxcZNSfTOmWOuHgeRpR5+9QA9gI7dPxPXYBh
         bsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MyvtwDChEwCdQVh5aGFvmjJ86anRb7CfVG7QHKgc7LA=;
        b=L+mdzTa2CngKz/dCOvwxnQCWgyck5Mic9m8O3kKYkvbv43g3toWgIK9UCJpfpAz6vZ
         BWPEqFk+PeZLJYyYvlwFXaocF6ZXdnutw1oEph+UVlJ56RpBnHjLfAxqjX45tAxMq5Oc
         Agf8oh62X0b1gglqgQnm2YKVYh09xEGVyuqEdgHnAba7RUhEjXt7xJCASkTGMwg1UASl
         lXTcemDIbDHm/HmPDE+CryjiZZ9rjPnNrQzqLXxNval0Po1RispKXBO4zR+x384Ol8uJ
         //eQliaAUHkH5pDjiJihAGbFp8p4w2adKUdqQsCc6zVilPJ2IY39Hin362sOw1aPLi4K
         ygIQ==
X-Gm-Message-State: AJIora8Tm1qipVRQx4hsK1JH9u3FJw0/hJXRdrjk6v+oiwhpq9DIT36g
        ZjxcnZo39SV4ILTXXcgavdU4VZiHafHtkA==
X-Google-Smtp-Source: AGRyM1t8gU4dy8PXRJK3zRmcBOBaIw68TVC+CnJppG4KhoROsvWsCv5tzB8GU7dKlV83gIYj5a6kYg==
X-Received: by 2002:a05:6214:4016:b0:470:45d8:3be5 with SMTP id kd22-20020a056214401600b0047045d83be5mr27042453qvb.126.1656939342181;
        Mon, 04 Jul 2022 05:55:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a400f00b006af147d4876sm23282306qko.30.2022.07.04.05.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:55:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o8Lc5-005tVm-4O; Mon, 04 Jul 2022 09:55:41 -0300
Date:   Mon, 4 Jul 2022 09:55:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Xiao Yang <yangx.jy@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com
Subject: Re: [PATCH] RDMA/rxe: Process received packets in time
Message-ID: <20220704125541.GB23621@ziepe.ca>
References: <20220703155625.14497-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703155625.14497-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 03, 2022 at 11:56:25PM +0800, Xiao Yang wrote:
> If received packets (i.e. skb) stored in qp->resp_pkts
> cannot be processed in time, they may be ovewritten/reused
> and then lead to abnormal behavior.

I just merged a bunch of fixed from Bob on atomics, do they solve this
problem too by chance?

Jason
