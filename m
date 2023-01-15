Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED80E66B0B0
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 12:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjAOLgc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 06:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjAOLga (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 06:36:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02928A50;
        Sun, 15 Jan 2023 03:36:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AF7160C91;
        Sun, 15 Jan 2023 11:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126B2C433D2;
        Sun, 15 Jan 2023 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673782588;
        bh=pOckkEQYG5TtPGNWhz6DJdFf29q23zF0lPbvKh712jg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pyvF68SkuPs0PKw817jRJ8I0vpeD77qfWIOetcLGcqJyxyKnYUoAqi3eI+IMgdkuq
         crnlaWcykE71lG+AHSvXqfx+G+Jsrbczbz4pTtsa5CgaWj+tKBnhDma72OAzTB8THE
         RHGBDYOqpUVlB8CEz48BXRd1Hte5uClFHyGeEMo2TDGbr0ubNg4EjjjIQdBd3Kb4W/
         Wg/KsOgDzc5jnkq8Ncv4hgHflpjL3vnqnSbmu6IORYOrG/VypDp/BbHLGbe6/bBo5I
         nRGbMiMxtgfJpzru0UdFxO3yMmYabyPvheYuBuf/rHEdQoeokuRk8QHpokH663JPVb
         j86pJo7P72u2Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <Y7zCBqwC1LtabRJ9@work>
References: <Y7zCBqwC1LtabRJ9@work>
Subject: Re: [PATCH][next] RDMA/erdma: Replace zero-length arrays with
 flexible-array members
Message-Id: <167378258448.161439.10223371948659974585.b4-ty@kernel.org>
Date:   Sun, 15 Jan 2023 13:36:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 09 Jan 2023 19:40:22 -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> arrays, in a couple of structures, with flex-array members.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [2].
> 
> [...]

Applied, thanks!

[1/1] RDMA/erdma: Replace zero-length arrays with flexible-array members
      https://git.kernel.org/rdma/rdma/c/ed73a505480d54

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
