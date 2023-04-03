Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750F26D5032
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Apr 2023 20:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjDCSYI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Apr 2023 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjDCSYH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Apr 2023 14:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A41170A;
        Mon,  3 Apr 2023 11:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CE8E625C4;
        Mon,  3 Apr 2023 18:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26910C433EF;
        Mon,  3 Apr 2023 18:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680546245;
        bh=UeZr5YfS0Yaf22ilGxKJbw+QT9yD62PihrxxHaRSgTg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TCdSd8Wrnkf00o30c4E3aJ09Rbsc6zlmDsTZli3Wi6n8Ivqomk473wt8qV58OLDMH
         rYL8OqMCoSK5mXr590SCgS+QS88RB5/Zg5LW/qhvWxkSOJ4+tubYDcNB5PstwvvcU6
         5ypEfCmQRciO72a52CuWZx29YIyN7DyYtyPWn+a+ADcauaM2KlHMSCt3xFotT/qmH2
         DHjkGVHFUHvxsHBMMkU+F28BzpsX+0kbf8+ZUqIKJ0zwE1vJagU0/96w2gISGlsyNe
         tFlcz4vIwA4vYTqjLuT0igvId0tpmhvfCjqttM883erTnpTjxlFS0HN4E+HcbOvz3X
         liEKe4ltb4JaA==
From:   Leon Romanovsky <leon@kernel.org>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        nathan@kernel.org, ndesaulniers@google.com,
        Tom Rix <trix@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20230330235800.1845815-1-trix@redhat.com>
References: <20230330235800.1845815-1-trix@redhat.com>
Subject: Re: [PATCH] IB/qib: remove unused cnt variable
Message-Id: <168054624148.6296.6352837498286911660.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 21:24:01 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 30 Mar 2023 19:58:00 -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/infiniband/hw/qib/qib_file_ops.c:487:20: error: variable
>   'cnt' set but not used [-Werror,-Wunused-but-set-variable]
>         u32 tid, ctxttid, cnt, limit, tidcnt;
>                           ^
> drivers/infiniband/hw/qib/qib_file_ops.c:1771:9: error: variable
>   'cnt' set but not used [-Werror,-Wunused-but-set-variable]
>         int i, cnt = 0, maxtid = ctxt_tidbase + dd->rcvtidcnt;
>                ^
> This variable is not used so remove it.
> 
> [...]

Applied, thanks!

[1/1] IB/qib: remove unused cnt variable
      https://git.kernel.org/rdma/rdma/c/e7706c4bbfe88f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
