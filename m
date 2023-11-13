Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1F97E97E4
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 09:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjKMIjM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 03:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMIjL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 03:39:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65FDC7;
        Mon, 13 Nov 2023 00:39:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14278C433C7;
        Mon, 13 Nov 2023 08:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699864748;
        bh=sxvXTpYz7sOmLeUDp3p5LjPcTHoow7ozfvsBUsYeEOY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Cb/uExjpCQV4pm42BxoA9t4o3pzme4ceq2lDOmpb8kwTyFEIdowqaiBW7UebnmsUl
         h1KxL+B/T39jBVlfeuX8uwVyB74Zf7FSPKrTktsqyWIw+6b6tYuMveMwL5uH7hY2h0
         +UKQpN5BlD3dpX1kn9W4c+P9zCAwjLjyDo2QKAgryOx6nuXQqk3ns+Kn4rW8I79saT
         nf3DX/ZYDnhUpWgn0YTpOTR0i82Ov2rcBcw5vFXbCmqFTSURKfvZrHUVV9x7ECR5mt
         jJS0kZoIPMU5F/e0aKawz+P43bKGyvIbwqhZRCkpMRgUfrFzqgpuxcNGRs3UbXAi83
         XWhuXFHpyuGVQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philipp Stanner <pstanner@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
In-Reply-To: <20231102191308.52046-2-pstanner@redhat.com>
References: <20231102191308.52046-2-pstanner@redhat.com>
Subject: Re: [PATCH] drivers/infiniband: copy userspace arrays safely
Message-Id: <169986474464.283834.3237822817785833042.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 10:39:04 +0200
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


On Thu, 02 Nov 2023 20:13:09 +0100, Philipp Stanner wrote:
> Currently, memdup_user() is utilized at two positions to copy userspace
> arrays. This is done without overflow checks.
> 
> Use the new wrapper memdup_array_user() to copy the arrays more safely.
> 
> 

Applied, thanks!

[1/1] drivers/infiniband: copy userspace arrays safely
      https://git.kernel.org/rdma/rdma/c/c170d4ff21a8a5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
