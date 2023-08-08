Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C6277430E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 19:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjHHR4U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 13:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjHHRzt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 13:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6C6A27F;
        Tue,  8 Aug 2023 09:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4812D6248F;
        Tue,  8 Aug 2023 10:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB9DC433C7;
        Tue,  8 Aug 2023 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691490357;
        bh=jcj5AnviVGxOZut2LUZpuwexLCnK8ogmL2HAywZngOY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UkVsqtjaolGtihYMK3/K7O142oSS/rjtnHRkaEJylAmvlmLOPfRp3dHT31f4ltjaS
         fAkvxtSAKuziR9nO0cdN4f8GIaBx/HPqmcD1GaxA39P8CjHu/wtcjmATssTmgqRUEQ
         cYn9LT3I8kZi/bNSLJVh6G2tBEdqyAE919A6Yb60oBn5wCTIsxwLIHJ/H0uRvudrhY
         pJyreENSZ4jLDG/lPO/7rN5aqx7CBhN1C1/xPOgaoN9frO2esncgk/bAN10+CekTM5
         wAZedoMW70lbAAPnC5KDtf3DYx5uc0pwSEI+SB2FknTRMD2lRXPt8Xgy6V3WOU5l4B
         KXR7TwEHahDXw==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
In-Reply-To: <2023080427-commuting-crewless-cbee@gregkh>
References: <2023080427-commuting-crewless-cbee@gregkh>
Subject: Re: [PATCH] infiniband: make all 'class' structures const
Message-Id: <169149035350.236427.16315785273438930549.b4-ty@kernel.org>
Date:   Tue, 08 Aug 2023 13:25:53 +0300
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


On Fri, 04 Aug 2023 17:05:28 +0200, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, making all 'class' structures to be declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at load time.
> 
> 

Applied, thanks!

[1/1] infiniband: make all 'class' structures const
      https://git.kernel.org/rdma/rdma/c/64917f4c35b3e4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
