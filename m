Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D026C64B3
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 11:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCWKUr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjCWKUq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 06:20:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D45DD52B;
        Thu, 23 Mar 2023 03:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABB0D6259D;
        Thu, 23 Mar 2023 10:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B02EC433EF;
        Thu, 23 Mar 2023 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679566845;
        bh=vneMdXeEr1dmIAZE0iPop9xJ7JZjUeKpHnQwSXXFD34=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=d3uWBLyTOCMoMHel6zJXx6PdpRg5xcjZF56KLNLRkdFylulkIw42yuINAQTJ6rNbF
         PgXrpqJ2TQpBntC3R5YyYPddEyC93q5LaKxM2bjkDJRBrkWJ6mobHIIWMaxtAfPJQW
         bkoACNaG6ZRdh8+/MIe6u6u/N4zdejUDilBU0d28YROuIqdXPYtNYAVTprEywpnluC
         h8l/zb4Mw7GEVH+QMg1m8J8vwn9JDNuZ0JvyY14Y33Mm3EDAwKIW4uwy83Lvg5vrbM
         hlcqgptk4F151ZURhhYE6zJOzKtWz16tNMEoiEisrYkg4OQirSQTRKo49aSjC5/qR5
         CX9RuBj/y/0cw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <ZBpB91qQcB10m3Fw@work>
References: <ZBpB91qQcB10m3Fw@work>
Subject: Re: [PATCH v2][next] RDMA/core: Fix multiple -Warray-bounds warnings
Message-Id: <167956684067.1736808.5456264646526617079.b4-ty@kernel.org>
Date:   Thu, 23 Mar 2023 12:20:40 +0200
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


On Tue, 21 Mar 2023 17:47:03 -0600, Gustavo A. R. Silva wrote:
> GCC-13 (and Clang)[1] does not like to access a partially allocated
> object, since it cannot reason about it for bounds checking.
> 
> In this case 140 bytes are allocated for an object of type struct
> ib_umad_packet:
> 
>         packet = kzalloc(sizeof(*packet) + IB_MGMT_RMPP_HDR, GFP_KERNEL);
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Fix multiple -Warray-bounds warnings
      https://git.kernel.org/rdma/rdma/c/aa4d540b415005

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
