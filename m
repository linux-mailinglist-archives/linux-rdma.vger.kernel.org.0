Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA0718D7E
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 23:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjEaVtw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 17:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEaVtt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 17:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55049A0;
        Wed, 31 May 2023 14:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEBB763F6A;
        Wed, 31 May 2023 21:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD04C433EF;
        Wed, 31 May 2023 21:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685569787;
        bh=aGfdDi3uZnFkx6zkAyqIM68qZh/YHY0DCRpb2p1GQbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FwdoOeCB63lBeSMjLIqrU3Yyd+wOuPyWsYHkQHketH1muZb8vLLUrsTZEAJyq9wo1
         psA9yX89HZl14Mu0KftmkiiwfYtx5IAYOnTAbZAz8nrJw4A9uXwosaC9EXXeDkLvFR
         M8yykpXyL1+bJRYak6xkEFefjCcZURTSBxao+TyK+E0n84nKTSGMInWSBBELvzCvQ2
         BuK6j1EuVAQlgHOeKgzV07VLd2QLhdmiJrv9p3sNOnl//7mnvIhBl78pho/Nm29zkA
         SWO7TSy+W8u7YOfi04pSpFbZzNleaRJ3+am9v1zmCoHpCQnS5ENFNcraZScor/kO/2
         rE3wl1GtVe21g==
Date:   Wed, 31 May 2023 14:49:46 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clegoate@redhat.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Shay Drory <shayd@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Eli Cohen <elic@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5: Fix setting of irq->map.index for
 static IRQ case
Message-ID: <ZHfA+i4E3SykRT4O@x130>
References: <20230531084856.2091666-1-schnelle@linux.ibm.com>
 <cdd8953e-2187-32f7-bb3c-aaf54581775d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdd8953e-2187-32f7-bb3c-aaf54581775d@redhat.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 31 May 11:38, Cédric Le Goater wrote:
>On 5/31/23 10:48, Niklas Schnelle wrote:
>>When dynamic IRQ allocation is not supported all IRQs are allocated up
>>front in mlx5_irq_table_create() instead of dynamically as part of
>>mlx5_irq_alloc(). In the latter dynamic case irq->map.index is set
>>via the mapping returned by pci_msix_alloc_irq_at(). In the static case
>>and prior to commit 1da438c0ae02 ("net/mlx5: Fix indexing of mlx5_irq")
>>irq->map.index was set in mlx5_irq_alloc() twice once initially to 0 and
>>then to the requested index before storing in the xarray. After this
>>commit it is only set to 0 which breaks all other IRQ mappings.
>>
>>Fix this by setting irq->map.index to the requested index together with
>>irq->map.virq and improve the related comment to make it clearer which
>>cases it deals with.
>>
>>Tested-by: Mark Brown <broonie@kernel.org>
>>Reviewed-by: Mark Brown <broonie@kernel.org>
>>Reviewed-by: Simon Horman <simon.horman@corigine.com>
>>Reviewed-by: Eli Cohen <elic@nvidia.com>
>>Fixes: 1da438c0ae02 ("net/mlx5: Fix indexing of mlx5_irq")
>>Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>

Applied to net-mlx5. 

Thanks.


