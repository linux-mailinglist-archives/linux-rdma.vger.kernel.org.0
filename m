Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB17B519B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 13:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjJBLpX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 07:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJBLpW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 07:45:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039FD93;
        Mon,  2 Oct 2023 04:45:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18F7C433C7;
        Mon,  2 Oct 2023 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696247119;
        bh=tYbjMAUcN0XthNOVzmGs+Y3qL7jGJzmEPsY7LU8xTvA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BTfPMprg4YuP+Z/b4wNUvLHqmhQhknwnOsJaCrX8jdJgMG2qQkoakD1KWkwJpw4ae
         WKVJJGbwR55plXJnNoyyUV/6wOC5TXyibvJgL1jpMPR28Jf/5UQDiOIDRmT1RFh27S
         sIU8eJxG39H5R8owFjMNsWZTItcsulV0TJI1TfE4Nf8KgO9y9tF96f6ETso+iLdEpl
         CoJKbDgyTLzSeqEcl5GN3xhY57Z6/+bL35hj+2HVJoXsv0B/PpGR9dm4FxM6Jonefm
         hKUWpK6reWVyaTW2roySUWjO/UgJdJVgLsYbHcAQSB20M7g5RU+hemNg8KQVa5hIff
         9JUA5RWAxrT4Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        =?utf-8?q?H=C3=A5kon?= Bugge <haakon.bugge@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        wangjianli <wangjianli@cdjrlc.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20230929180305.work.590-kees@kernel.org>
References: <20230929180305.work.590-kees@kernel.org>
Subject: Re: [PATCH 0/7] RDMA: Annotate structs with __counted_by
Message-Id: <169624711583.134088.705118476077332376.b4-ty@kernel.org>
Date:   Mon, 02 Oct 2023 14:45:15 +0300
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


On Fri, 29 Sep 2023 11:04:23 -0700, Kees Cook wrote:
> This annotates several structures with the coming __counted_by attribute
> for bounds checking of flexible arrays at run-time. For more details, see
> commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").
> 
> Thanks!
> 
> -Kees
> 
> [...]

Applied, thanks!

[1/7] RDMA: Annotate struct rdma_hw_stats with __counted_by
      https://git.kernel.org/rdma/rdma/c/4755dc6f29597d
[2/7] RDMA/core: Annotate struct ib_pkey_cache with __counted_by
      https://git.kernel.org/rdma/rdma/c/fc424078f50840
[3/7] RDMA/usnic: Annotate struct usnic_uiom_chunk with __counted_by
      https://git.kernel.org/rdma/rdma/c/ed7c64de622ff9
[4/7] RDMA/siw: Annotate struct siw_pbl with __counted_by
      https://git.kernel.org/rdma/rdma/c/0bc018b7a7b733
[5/7] IB/srp: Annotate struct srp_fr_pool with __counted_by
      https://git.kernel.org/rdma/rdma/c/bd8eec5bfa59b5
[6/7] IB/mthca: Annotate struct mthca_icm_table with __counted_by
      https://git.kernel.org/rdma/rdma/c/2aba54a9e0ead5
[7/7] IB/hfi1: Annotate struct tid_rb_node with __counted_by
      https://git.kernel.org/rdma/rdma/c/964168970cef5f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
