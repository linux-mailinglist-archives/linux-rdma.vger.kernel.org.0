Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E889552A9D2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351162AbiEQSDI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 14:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345697AbiEQSDH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 14:03:07 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212F53FBC9
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 11:03:06 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m1so15129660qkn.10
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qYLGulgiXtqkGHB5690TZrqi9P52kY4/ILEk7GNvo8I=;
        b=d1EWMzvycfAGBYsJZQZH5yrENWSi0Lz37ujcaPlZJ4unA4H0x3pCDDdIZeuaKcwI6N
         rCxeOBcZd2ndnT4BRF+FeOisiuQXpk0ExFqrIfVAqFKk1yxTNEHuHuZXSkKIfFvGqZX+
         bFlI31Uf4DpfWyUopf5y37IaB+mI2+gBIuSMpW24FZD++Wcf8M+DkPQVTgK+XFjWSe6I
         dzkKPf6tEMKiIMnHu3nRX35QXLshgVU0NU1MzvHua1QhYf6D15Tj8zUK7MpZpyHl0SCs
         zsw07DghloAy/d1e1yumQDMQdrvnMnPMIsIR6DuwWvUzRe3qQyqcrtmButecDXmlj7mX
         rqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qYLGulgiXtqkGHB5690TZrqi9P52kY4/ILEk7GNvo8I=;
        b=sU+6ch3RYq9mHh7S62CNi3vX2ABiihUJkedpSELoIrmkY6ZuQiw9OUhuxjD5+7J3f6
         1ts6fIU77Fe3xUEwyf47s6cNTblnrgSpFo2orToFSBJSkjKV/q8UpeqItfcMNt1pGA7E
         Zv9tx3BDljPerwgqTzwKYFAtRcZr5R6P6/Y+bEZV7SCu0qHtw6CfDJyiWTa1uo8WtH/e
         gdr4CYKmtLQMRLyBzxnokxWIQRLVmLEf81tDpLgVhEIeTmC1BKfbf1nErMo5SmX5OuVf
         +7qGw5ms2PviCqEwFdqLj5FpLksW+fDTCaMMzG54Qz36np7HimkaEjgM5wXL0SWl+qMk
         02cg==
X-Gm-Message-State: AOAM5315NXRPd57IwUSyxeVJmc7CyUP5Ai2ed/civC23ASbN3C0vLcr8
        VKFU3KwVuA34Z/JnmuHgi2fr+Q==
X-Google-Smtp-Source: ABdhPJzERzhGKPBQiikc9HIAelrTIToUaE4SM6vylFfp/3XqAiKYqLEFKxNbx2dUn/bo6K2457Es0Q==
X-Received: by 2002:a37:2f06:0:b0:6a0:5596:f395 with SMTP id v6-20020a372f06000000b006a05596f395mr16675021qkh.298.1652810585229;
        Tue, 17 May 2022 11:03:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id o5-20020a05620a110500b006a0b40689b6sm7737036qkk.135.2022.05.17.11.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 11:03:04 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nr1XD-0087sl-Ll; Tue, 17 May 2022 15:03:03 -0300
Date:   Tue, 17 May 2022 15:03:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Haowen Bai <baihaowen@meizu.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA: remove null check after call container_of()
Message-ID: <20220517180303.GK63055@ziepe.ca>
References: <1652751208-23211-1-git-send-email-baihaowen@meizu.com>
 <20220517121646.GE63055@ziepe.ca>
 <142a9c03-574f-adcf-bc4d-bb2a25c01e88@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <142a9c03-574f-adcf-bc4d-bb2a25c01e88@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 17, 2022 at 07:54:38PM +0200, Christophe JAILLET wrote:
> Le 17/05/2022 à 14:16, Jason Gunthorpe a écrit :
> > On Tue, May 17, 2022 at 09:33:28AM +0800, Haowen Bai wrote:
> > > container_of() will never return NULL, so remove useless code.
> > 
> > It is confusing here, but it can be null.
> 
> Hi,
> 
> out of curiosity, can you elaborate how it can be NULL?

It is guarented/required that that container_of is a 0 offset. The
normal usage of the ib_alloc_device macro:

#define ib_alloc_device(drv_struct, member)                                    \
	container_of(_ib_alloc_device(sizeof(struct drv_struct) +              \
				      BUILD_BUG_ON_ZERO(offsetof(              \
					      struct drv_struct, member))),    \
		     struct drv_struct, member)

Enforces this property with a BUILD_BUG_ON

So, if the input pointer to container_of is reliably NULL or ERR_PTR
then the output pointer will be the same.

The rvt code here open codes the call because it is a mid-layer and
the sizeof() calculation above is not correct for it.

Jason
