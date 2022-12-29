Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4636589DE
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Dec 2022 08:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiL2HKQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Dec 2022 02:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiL2HKP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Dec 2022 02:10:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202829FFE;
        Wed, 28 Dec 2022 23:10:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4CE9B81914;
        Thu, 29 Dec 2022 07:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA81C433D2;
        Thu, 29 Dec 2022 07:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672297812;
        bh=OOtIAx+v0crUQ/KRbMyKaOHS5jTp9VFUiesSf/7LcIY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nPGJ6HF+ClBJtIMs2Ngpbz4YEITcUJNUE9ExTJtoWXLKfSg9KrvwdNuFXXGPRye2G
         CSzjHl4+Ly3+36dkeAlnwMA6rVcQyiT3Oy6nKzpNZgW7CTSpa2fwKpPB+nqEYfRRMD
         ny2s+P4RHyse5wKa+wSm+vJFbUE102MMOcaxhMJv1gD8+v+MfSlsGs10qxbIEs5tK0
         SQLej83Wbj6F9coGp7s7CThqKQGRyDe2nt31VRVJKXwrXqGylD8jre+RKp1Non0nzq
         3pXjeVpjclUhYx1YstrO2KI/U/QmiMJxVBQB97b12Gxl2UZaNt09xkLnMIlujT1jz4
         1vCzhWQgNfAhQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     bvanassche@acm.org, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Martin Liska <mliska@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20221212120411.13750-1-jirislaby@kernel.org>
References: <20221212120411.13750-1-jirislaby@kernel.org>
Subject: Re: [PATCH v2] RDMA/srp (gcc13): move large values to a new enum
Message-Id: <167229780777.209797.11829150379699780577.b4-ty@kernel.org>
Date:   Thu, 29 Dec 2022 09:10:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 12 Dec 2022 13:04:11 +0100, Jiri Slaby (SUSE) wrote:
> Since gcc13, each member of an enum has the same type as the enum [1]. And
> that is inherited from its members. Provided these two:
>   SRP_TAG_NO_REQ        = ~0U,
>   SRP_TAG_TSK_MGMT	= 1U << 31
> all other members are unsigned ints.
> 
> Esp. with SRP_MAX_SGE and SRP_TSK_MGMT_SQ_SIZE and their use in min(),
> this results in the following warnings:
>   include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast
>   drivers/infiniband/ulp/srp/ib_srp.c:563:42: note: in expansion of macro 'min'
> 
> [...]

Applied, thanks!

[1/1] RDMA/srp (gcc13): move large values to a new enum
      https://git.kernel.org/rdma/rdma/c/fb5b88f5b78192

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
