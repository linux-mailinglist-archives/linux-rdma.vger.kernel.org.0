Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B47B8D1D
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbjJDTEn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 15:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245683AbjJDTCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 15:02:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2430E3
        for <linux-rdma@vger.kernel.org>; Wed,  4 Oct 2023 11:56:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C37C433C9;
        Wed,  4 Oct 2023 18:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445780;
        bh=jYkJuJRTWqyJSKCaG/TJONvh8LMPM2TFv33zirtqBOs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oOBXtnjBeEojTlJHl+a8YL3hvAZeRffsvWYgVeDDEZeYPoNZZHnTXWLv27ZVQzCVr
         3B5wnIwmVoCruaylVrsHW8JnzcQqURCxQs01oRw4gv8Q56EKLZFR4hJmM1+MXvcnww
         1uCPUlwcpL+mr4RVNTFC6Qxmznq4JoXiFSqBjHmkDNcToVUf1EBoV4u+oDqMrS7Cpp
         ujuinEcDXt6+JDvvRCjKrCvOdUzl0xn7gM5MmGuzNX2pXPGamxdGuS1QxrezrflUuG
         7HyB4qtYiQoyYJQBAny8BQlq2Y+m9Q+XGMWIZp5AQpP3GWzFRYDz7OG/WMBjk6OQNI
         ckXsqc5yueKoA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Chuck Lever <cel@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org
In-Reply-To: <169643338101.8035.6826446669479247727.stgit@manet.1015granger.net>
References: <169643338101.8035.6826446669479247727.stgit@manet.1015granger.net>
Subject: Re: [PATCH] RDMA/core: Fix a couple of obvious typos in comments
Message-Id: <169644577625.1672086.811881233652527418.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 21:56:16 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 04 Oct 2023 11:29:41 -0400, Chuck Lever wrote:
> 


Applied, thanks!

[1/1] RDMA/core: Fix a couple of obvious typos in comments
      https://git.kernel.org/rdma/rdma/c/0aa44595d61ca9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
