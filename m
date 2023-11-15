Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D9A7EC55E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbjKOOcB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 09:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344057AbjKOOcB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 09:32:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A7B12E
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 06:31:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04430C433C8;
        Wed, 15 Nov 2023 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700058717;
        bh=1uAwP0IougIfm6D1I6ee5aG4+/K+uRjqCORqs0UDOkk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=gutNfrQgeROVwTUXtiuHc67pv9+/jhVcVOcMIGtlmetuwsKe9wiuu5prov2Al03Hp
         F/uGAZMhAwXgTyE5cIkcBOcf6Klllmks1lvb/J/9pbM9ar3MZmbm25LoD2F8GLeD6R
         apJC0LiLtqKI+ya0Ju77Ug4B3+QnqFHxvix/+ZjSi5yfXVOcuCnjyhmAakC0Mnk9h3
         Y7gC8Lk99Mr5hqNw9eLHs3VZT25gljrOKqn+bfSe3GBqFJ+Gsq8Vv7Nc4KySlRWaJG
         bLTW7/S1j434OvcVhM2OMZ000gSq07/egW7WKWw+WBUMqsxVqcYD1TctCVxKyOzmj0
         i22OZsi0Fz3fA==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
In-Reply-To: <20231114170246.238-1-shiraz.saleem@intel.com>
References: <20231114170246.238-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-rc 0/2] irdma SQD fixes
Message-Id: <170005871254.837026.14830911574144868016.b4-ty@kernel.org>
Date:   Wed, 15 Nov 2023 16:31:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 14 Nov 2023 11:02:44 -0600, Shiraz Saleem wrote:
> This series addresses a couple of minor fixes related to SQD flow
> in irdma.
> 
> Mustafa Ismail (2):
>   RDMA/irdma: Do not modify to SQD on error
>   RDMA/irdma: Add wait for suspend on SQD
> 
> [...]

Applied, thanks!

[1/2] RDMA/irdma: Do not modify to SQD on error
      https://git.kernel.org/rdma/rdma/c/ba12ab66aa83a2
[2/2] RDMA/irdma: Add wait for suspend on SQD
      https://git.kernel.org/rdma/rdma/c/bd6da690c27d75

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
