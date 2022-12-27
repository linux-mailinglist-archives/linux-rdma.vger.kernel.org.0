Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED5656B71
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Dec 2022 14:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiL0NtP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Dec 2022 08:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiL0NtO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Dec 2022 08:49:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06339F78;
        Tue, 27 Dec 2022 05:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B95B8B81057;
        Tue, 27 Dec 2022 13:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A33C433D2;
        Tue, 27 Dec 2022 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672148951;
        bh=J6MPENb0GqW2wj2O0pVPAv4X8wsQSoGtcBJ/cwjHdek=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ggNufj5fSEkQLLlUua5/Ab9WtCdtaRbe3gTScyyfelKBcoRDoXuEjv2BIZelfEEkn
         deQp7N+j+oKeR2CDgDAqrJg/37waInx3SNCwtjRDt2uNkiuhcS89/QCsQm5Fq6eZKg
         xROAlt+E6SIK8l8Sxbi/u9v1T+V7Z+PSAOszZ6tmFeNXRWh2/ZFZD3m8dV8FzzSqZA
         qLPYG5DPubZYPKE57o54Sc1IvN+MLsLBWqkI1t+5Exy1wLJ/710ZW0I9r7NqNQfNrp
         pp0rT7S7ccNtDXOV69NnVqRgmZtxumbpJSOZvXFyPn7dNvuXUP9uHxyH4pmpAC0J0P
         RSB+TMtBndrfg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20221216095225.685353-1-linmq006@gmail.com>
References: <20221216095225.685353-1-linmq006@gmail.com>
Subject: Re: [PATCH] RDMA/hfi1: Fix doc for hfi1_free_ctxt
Message-Id: <167214894790.75776.16054119915672682790.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 15:49:07 +0200
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

On Fri, 16 Dec 2022 13:52:25 +0400, Miaoqian Lin wrote:
> Fix the typo of hfi1_create_ctxtdata.
> 
> 

Applied, thanks!

[1/1] RDMA/hfi1: Fix doc for hfi1_free_ctxt
      https://git.kernel.org/rdma/rdma/c/1b8ba6e41f11fc

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
