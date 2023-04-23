Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7708A6EBFBE
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Apr 2023 15:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjDWNYT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Apr 2023 09:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNYS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Apr 2023 09:24:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C509E6D
        for <linux-rdma@vger.kernel.org>; Sun, 23 Apr 2023 06:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B04F760D30
        for <linux-rdma@vger.kernel.org>; Sun, 23 Apr 2023 13:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E441C433EF;
        Sun, 23 Apr 2023 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682256257;
        bh=bkhXU91t61rMhy2+V9J7vBlWXWsHR2XVwEcqkN4Mgvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2OCQcL1QgXx+nKXnuD+k7orYppvouoUDasco7zFpnfW9SavPQaYeyXYd9my7x2BD
         T0B7EEGxCJDhGpyhrue1Lg5cjzbC4vczGOHvGK52Gs+z7G7EI2DCreM0dC2NUg2FgM
         Qqgr3XAM5fnk6ccB7xlsH7YnluBQOfhUNqMKAy4PT51zYaNG2p/J8wqsmIOlvW2/xW
         6pEWP4MhYDgMcy9Gw9i1YAOKuBAHiahdIHfHf6i8XLLqMNU0krOoRzJn+iEgeW0lAi
         2OQ08GoljD+XviTNQZlz0GgD2zwuz5aOjbMb+LZT7Eje8XEcB4fh39HTxwaJSeDBsP
         Dz37P58ud53Dw==
Date:   Sun, 23 Apr 2023 16:24:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [bug report] net/mlx5e: Generalize IPsec work structs
Message-ID: <20230423132412.GB4782@unreal>
References: <9ef32c2b-8e07-486b-af8d-9d332d5426ab@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef32c2b-8e07-486b-af8d-9d332d5426ab@kili.mountain>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 20, 2023 at 11:24:09AM +0300, Dan Carpenter wrote:
> Hello Leon Romanovsky,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 4562116f8a56: "net/mlx5e: Generalize IPsec work structs"
> from Mar 30, 2023, leads to the following Smatch complaint:
> 
>     drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:755 mlx5e_xfrm_free_state()
>     error: we previously assumed 'sa_entry->work' could be null (see line 746)

Thanks for the report,
I fixed it in commit 94edec448479 ("net/mlx5e: Properly release work data structure")

> 
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
>    745	
>    746		if (sa_entry->work)
>                     ^^^^^^^^^^^^^^
> 
>    747			cancel_work_sync(&sa_entry->work->work);
>    748	
>    749		if (sa_entry->dwork)
>                     ^^^^^^^^^^^^^^^
> These checks can be deleted, right?
> 
>    750			cancel_delayed_work_sync(&sa_entry->dwork->dwork);
>    751	
>    752		mlx5e_accel_ipsec_fs_del_rule(sa_entry);
>    753		mlx5_ipsec_free_sa_ctx(sa_entry);
>    754		kfree(sa_entry->dwork);
>    755		kfree(sa_entry->work->data);
>                       ^^^^^^^^^^^^^^^^^^^^
> Unchecked dereference.
> 
>    756		kfree(sa_entry->work);
>    757	sa_entry_free:
> 
> regards,
> dan carpenter
