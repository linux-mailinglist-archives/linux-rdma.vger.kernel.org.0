Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFDF7E97EC
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 09:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjKMIjt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 03:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjKMIjr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 03:39:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F04C7;
        Mon, 13 Nov 2023 00:39:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCF0C433C8;
        Mon, 13 Nov 2023 08:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699864784;
        bh=6egP83vL71pA/isDOFUPTNNN3lSfgoaZ69YXzRvoP9Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=i9O2SzDf/8fev7+d22u8CRbboqct6qGzvjG5dmMEczS7fUIY+hCPyuuVHg9SNKsfM
         CklFtueI+N8gOY4pXTcpIzV/5oYhhfxMUfPk+Kl8wSJuLTVUjnCjgvJArWTm+tQuKz
         S35h7klcoilkoDt0+5QuNlUV2CsNOKod8/q/q2ENqzFni28T/B6iFDwLATpELnwaQX
         kMI58lf52JyK5PRchfKtZ+nVuKmMJVpeMtvkJDIdE10VVFM2rh/Tu2keFLWAW7Brwv
         5/jxq8K4+t0KR0+2XxgraHG37banEoKymRmKwQDeoubekrBbt80KP72v/BK4cyt9vt
         Ge0Eo8+wPufUA==
From:   Leon Romanovsky <leon@kernel.org>
To:     jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231028093242.670325-1-huangjunxian6@hisilicon.com>
References: <20231028093242.670325-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next] RDMA/hns: Fix unnecessary err return when using
 invalid congest control algorithm
Message-Id: <169986478051.284064.14860431429320033574.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 10:39:40 +0200
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


On Sat, 28 Oct 2023 17:32:42 +0800, Junxian Huang wrote:
> Add a default congest control algorithm so that driver won't return
> an error when the configured algorithm is invalid.
> 
> 

Applied, thanks!

[1/1] RDMA/hns: Fix unnecessary err return when using invalid congest control algorithm
      https://git.kernel.org/rdma/rdma/c/efb9cbf6644048

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
