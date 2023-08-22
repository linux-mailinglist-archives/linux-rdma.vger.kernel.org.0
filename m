Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C72784423
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbjHVO2m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbjHVO2l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:28:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C422CC6
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 07:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C8A065912
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 14:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B40C433C8;
        Tue, 22 Aug 2023 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692714518;
        bh=l8vJgyHy+STNoHEA/DcWYYE1Xx4gPj0wNoG6ScWwIu0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Qrpq/PZ0vEePKZZB83cV2hjWgLBF/UvWg2G/+oeqHiBPzhNUrtE0WVfehy8c3ZaE8
         QKC5D/gZ/+iof4Tp2d8EJUwYO7Eebx/qCo9ZFYrn4NCgD15nh2H5wHha58Y2NdisAW
         Leg++Wc6gWzmGxkyAauIG9dL3h1wy/0bOjiGJD4pcJPFWglDiVxjz7EQiTaF+GgYbJ
         XtX2rub5n4QdhtaRjryPm3mXgbB4MHkFJbmhjfxeSY8R38a2HRB4StX3H7D+XaLbzg
         /db/odFGbjd6clwY1kE2afri7KFJW89cZlMX4/5fAgACTTcHOeZrZdI+0/1yPkXqkH
         KQLvycbtG7aIQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20230822033539.3692453-1-ruanjinjie@huawei.com>
References: <20230822033539.3692453-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next v2] RDMA/hfi1: Use list_for_each_entry() helper
Message-Id: <169271451479.41025.1584923018685286157.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:28:34 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 22 Aug 2023 11:35:38 +0800, Jinjie Ruan wrote:
> Convert list_for_each() to list_for_each_entry() so that the pos list_head
> pointer and list_entry() call are no longer needed, which can
> reduce a few lines of code. No functional changed.
> 
> 

Applied, thanks!

[1/1] RDMA/hfi1: Use list_for_each_entry() helper
      https://git.kernel.org/rdma/rdma/c/3d91dfe72aac33

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
