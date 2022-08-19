Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B641159A876
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Aug 2022 00:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiHSWTP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Aug 2022 18:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240454AbiHSWTH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Aug 2022 18:19:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB7DD87D2
        for <linux-rdma@vger.kernel.org>; Fri, 19 Aug 2022 15:19:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 12so4717951pga.1
        for <linux-rdma@vger.kernel.org>; Fri, 19 Aug 2022 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=QUVq2AEfy4BLzc5ShfAzmaXa1lQpxGbdDm4GA683rSc=;
        b=ENdToelV8P3tTBi2wyMgiiiSSMF5hoMniphFi0mNyhiWmSB7WnKAAGDm0y249ftZx0
         euJ59gUES9Sl1uGVN9rZFlMBBym+At5jN4QekFPo64wXRHssx1NA7mtKm5Zza9ebg/Mk
         8RvsoBVQmiYFDka9tvNFAMmHimhVJcbfvX97A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=QUVq2AEfy4BLzc5ShfAzmaXa1lQpxGbdDm4GA683rSc=;
        b=V3awX4AACg7OXs4loNNTpCKpi3GRWTBsdO/JqMf/tun+6ZkEdcCu0T1Ftyy4B8zSVZ
         H8L2ZfEomP47qMc3Bc0xJ0hUXM2SoHBz7LFQeDZ5zVDxPZ3UBpvnzqNkfmy6uXoWdKIw
         cPu2oSycTC5aef1mYjIeJaG2a7BhCkO1inOzVfhy0zlpfN2ucSJYbzv52ZYrFQnOFK+u
         OGOs/XlnclLppWF8ee8kYCw7/5qYLL+3D/YpWm7Tmqev4+JyVDx2mrjTMNzBBpWOXWPr
         DwJgySIoPJgwo+s2kK21qydYkwMpJ/1WP61rg9GqJjZ2B4tunJNhNsU7cNkWi41WlYL0
         1P9A==
X-Gm-Message-State: ACgBeo0J3ijiFYm4mNmkungoiT4qZvB3cZ27NEHOUrd+Cri0oImlNyqe
        L33gPgkRO9qK9RcPVpLwdYNnCw==
X-Google-Smtp-Source: AA6agR5yjAIf5Xy45cDJTVjnFsujDKd9TTUypCIz7oBxdMnqx9LYIfaHcjwndscLsXmluc2KObcPhw==
X-Received: by 2002:a05:6a00:10d3:b0:4fe:5d:75c8 with SMTP id d19-20020a056a0010d300b004fe005d75c8mr10058352pfu.6.1660947542596;
        Fri, 19 Aug 2022 15:19:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b0016be96e07d1sm3570628plg.121.2022.08.19.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 15:19:02 -0700 (PDT)
Date:   Fri, 19 Aug 2022 15:19:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 02/19] infiniband/mthca: Fix dma_map_sg error check
Message-ID: <202208191518.A550DF53BC@keescook>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
 <20220819060801.10443-3-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819060801.10443-3-jinpu.wang@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 19, 2022 at 08:07:44AM +0200, Jack Wang wrote:
> dma_map_sg return 0 on error, in case of error set
> EIO as return code.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Håkon Bugge" <haakon.bugge@oracle.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
