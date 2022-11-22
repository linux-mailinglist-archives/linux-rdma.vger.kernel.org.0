Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77322633EA7
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 15:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiKVOQ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 09:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiKVOQZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 09:16:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9432D1F7
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 06:16:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12CBBB81B3B
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 14:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BA2C433C1;
        Tue, 22 Nov 2022 14:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669126581;
        bh=qb+bMUsf0/xyz+/0Wv8IZUE8xOJA7iSLdc1fOrOTs7I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I95OdT3ubAAzLY1whU/PgRzpgIZ0EK6Jp11MaKVONtsScYq/FtSDLFjvzbZZ68cPo
         lfzhfMjjf1DtTeW7sdJuWSeECybOPz4Mp4sHizXtxDJNT3tdvRQ4qy/PiGexf8RhEc
         PCrrVFftLitBPeM/xQq1SAH10wKvGUgVdVExzrd73Zs7Cpqi1tDqhhE0dtbg90Gojm
         4tt6Ic1cs/RQvwoU9x1kkrEqztnV1qKSi6JC+/Hiskej+cOGk//7krjk5blptvAEXq
         yylM/Yj88Wkw60I4OmT6QJNlb9BUpMPH1oufDKd+DAldDT38nbyS93HQN9EQdS0E8/
         CCLdQQD6qQCQA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>
In-Reply-To: <20221122004410.1471-1-shiraz.saleem@intel.com>
References: <20221122004410.1471-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-rc] RDMA/irdma: Initialize net_type before checking it
Message-Id: <166912657823.230160.14617482644281042873.b4-ty@kernel.org>
Date:   Tue, 22 Nov 2022 16:16:18 +0200
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

On Mon, 21 Nov 2022 18:44:10 -0600, Shiraz Saleem wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> The av->net_type is not initialized before it is checked in
> irdma_modify_qp_roce. This leads to an incorrect update to the ARP cache
> and QP context. RoCEv2 connections might fail as result.
> 
> Set the net_type using rdma_gid_attr_network_type.
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Initialize net_type before checking it
      https://git.kernel.org/rdma/rdma/c/9907526d25c4ad

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
