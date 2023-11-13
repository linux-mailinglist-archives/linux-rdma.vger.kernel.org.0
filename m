Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB557E9772
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 09:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjKMIQh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 03:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKMIQh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 03:16:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4781710EB
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 00:16:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC2DC433C7;
        Mon, 13 Nov 2023 08:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699863393;
        bh=91GYblUek7XkZsIsbZT6MrsB8bzqU4P2G8xMobLK9GA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PSOTgyEDbYmH/cnbiFJCcBKzYREbLhSS1kitJwWArhoNE+y98f8m032aez5MjnsI6
         ttYctR25CujSB0fZ6bzZUqO/mOkHSddTekX2FkOfjIlMJL25d/XFqtgGItoKGrNEzg
         sZk+6tHSwSXIsYhgFNdbXjJup+trpzYxegmNIwB6Z6JjmeDOr4M4WtnD+KI0h+zhCC
         ZQ8G3nkyoGZcAMWYvCFGSDQuPMVfDsOjcoEvAlKFd9PAv2UvxhiCS97bR55SpQyz6W
         NRkKMcoAlZvrZV/2S4AWf4E6rXiA93fkcnVCP4elWSpPJvKNihBeUXnpRft54TAlsb
         3UGbUPiqA6bEA==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Cc:     jgg@ziepe.ca, max7255@meta.com,
        dennis.dalessandro@cornelisnetworks.com, guoqing.jiang@linux.dev,
        benve@cisco.com, vadim.fedorenko@linux.dev
In-Reply-To: <20231104075643.195186-1-bmt@zurich.ibm.com>
References: <20231104075643.195186-1-bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next v2] RDMA/siw: Use ib_umem_get() to pin user pages
Message-Id: <169986338874.279256.4216931938838572496.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 10:16:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Sat, 04 Nov 2023 08:56:43 +0100, Bernard Metzler wrote:
> Abandon siw private code to pin user pages during user
> memory registration, but use ib_umem_get() instead.
> This will help maintaining the driver in case of changes
> to the memory subsystem.
> 
> 

Applied, thanks!

[1/1] RDMA/siw: Use ib_umem_get() to pin user pages
      https://git.kernel.org/rdma/rdma/c/476b7c7e00ec3d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
