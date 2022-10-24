Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88260A5A1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 14:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiJXM1t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 08:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiJXM1C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 08:27:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A2E7C307;
        Mon, 24 Oct 2022 05:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43F0CB8119B;
        Mon, 24 Oct 2022 11:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9FCC4314D;
        Mon, 24 Oct 2022 11:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666612066;
        bh=a9DyYzOF0kGPJyVRxDBbt84Jje8TtB3dYA4L4TdMtQg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eTnffTcl7eLkfpIrRszjDUeKiNH+IrR3nACF9IlRJBNQsjzxXKbsVT/z10pA/sORl
         RWKAchKD78Rvw9HQSSvjoSf9WhN3pjw8+nRYyY5CLeAHBObzzgUmExTundJsLGhccV
         M/BAP8p88lOWVMzH3KngT43LgvT+ghF2ynJ516bB8cwZWz/z+a8mKQ9Q2Q0WrMOK65
         NI3mdy2Iq2I4TI8ne6YH+krQ/+L7PaxQ4L3E3fti9eog8b0G4v494O03razfRGZ1Z3
         9ftUHxgvjfN8EkIIzNtNaty1B7qEpasSnm0pe+0KGyxkOSCgCm+TrutrUoljRsOoO9
         GbO6qvsapS1gQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     wangjianli <wangjianli@cdjrlc.com>, jgg@ziepe.ca,
        dennis.dalessandro@cornelisnetworks.com
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
In-Reply-To: <20221022055905.49176-1-wangjianli@cdjrlc.com>
References: <20221022055905.49176-1-wangjianli@cdjrlc.com>
Subject: Re: [PATCH] hw/qib: fix repeated words in comments
Message-Id: <166661206142.860056.6523850341310170375.b4-ty@kernel.org>
Date:   Mon, 24 Oct 2022 14:47:41 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, 22 Oct 2022 13:59:05 +0800, wangjianli wrote:
> Delete the redundant word 'the'.
> 
> 

Applied, thanks!

[1/1] hw/qib: fix repeated words in comments
      https://git.kernel.org/rdma/rdma/c/2d5206c4629dfe

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
