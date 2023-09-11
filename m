Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11DB79ACEE
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 01:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357866AbjIKWGk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Sep 2023 18:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbjIKLPt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Sep 2023 07:15:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597FACE5;
        Mon, 11 Sep 2023 04:15:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF3FC433C7;
        Mon, 11 Sep 2023 11:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694430945;
        bh=R4oDShqK0hkefKtrhDCN77/ix1K/majf04YiDUI7zG0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=tCoJJGNe4wDVNRSaeU6fODzYhq+tg99Xa1/+0XCG1uodEGYht5rMX8niWGIIX+5Ek
         5EkKwbaTHy0CexfLHsZRkkuAxaSr9pam5ozXFNST59HvLjbo3avCVSKe4zV+pPEkkn
         vn0dKIwrXT4Pxx/TXC/MvFKTOCjcVGfCMc0jMloSDoDbZjHJF0nOm/BB2CQQJ0Bvk2
         Lln0utZuntBxxCfwYV0hjxpygpp2ciW99hByJESjQlBc6sgJiCwPfwXkn04ZDkvhsz
         D01HXAN2agjVMzZnnAXNOZqaa3au7yJLk65sp9NGqeQ/RdMQE9S3Ld/QwNXekJs86m
         aNw66aQrA9bVA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rohit Chavan <roheetchavan@gmail.com>
In-Reply-To: <20230824081304.408-1-roheetchavan@gmail.com>
References: <20230824081304.408-1-roheetchavan@gmail.com>
Subject: Re: [PATCH] RDMA/core: Fix repeated words in comments
Message-Id: <169443094164.187157.7955172028545974729.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 14:15:41 +0300
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


On Thu, 24 Aug 2023 13:43:04 +0530, Rohit Chavan wrote:
> Corrected the repeated words in the documentation of
> rdma_replace_ah_attr() and ib_resolve_unicast_gid_dmac()
> functions.
> 
> 

Applied, thanks!

[1/1] RDMA/core: Fix repeated words in comments
      https://git.kernel.org/rdma/rdma/c/e57b0eef668497

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
