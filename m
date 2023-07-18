Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF315757BD0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjGRMaJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGRMaI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 08:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F75FE77;
        Tue, 18 Jul 2023 05:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 197FB6155F;
        Tue, 18 Jul 2023 12:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A15C433C7;
        Tue, 18 Jul 2023 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689683406;
        bh=XvvqG2enMF0C2I2unxaLi71CxARnltN4jedpBpQNdJc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bxd+GU+hxxU5VUmj0VX4eNVdEcnugMxLzAmQPAaL2OQI1IVMzyJMxLBIKvstyDDck
         hpatCx3mpmiTHewIPooc2SlATNgEG7uKFORyw7243vEopHcd6HY1gv2kHoXH8Tx4zn
         M0OnikmzNxTV1AfycaTTbcqL4AqFRSz6sA9HCa51rm+CSQWMZLEeGAYGlP+jwTvEkb
         PC/ckbVWctRFNP8GxYi93ufBAJ0ijQaVtAiInJg3Tp0HBJk1BQ/HgobI6P7wQ383H9
         umJcsmtvjQrSee5Xq96ORW5yWCM6aCmqWE+/D9r4iOfDw6BtVO/Nl5DTqt5qUA1cJ3
         Sw+FmPMdPWAIg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C43698d8a3ed4e720899eadac887427f73d7ec2eb=2E1689623?=
 =?utf-8?q?735=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3C43698d8a3ed4e720899eadac887427f73d7ec2eb=2E16896237?=
 =?utf-8?q?35=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
Subject: Re: [PATCH] RDMA/rxe: Fix an error handling path in rxe_bind_mw()
Message-Id: <168968340262.290612.1449384061566774393.b4-ty@kernel.org>
Date:   Tue, 18 Jul 2023 15:30:02 +0300
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


On Mon, 17 Jul 2023 21:55:56 +0200, Christophe JAILLET wrote:
> All errors go to the error handling path, except this one. Be consistent
> and also branch to it.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Fix an error handling path in rxe_bind_mw()
      https://git.kernel.org/rdma/rdma/c/5c719d7aef298e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
