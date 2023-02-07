Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBED68D414
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Feb 2023 11:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjBGK21 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Feb 2023 05:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjBGK2Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Feb 2023 05:28:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB09F23108;
        Tue,  7 Feb 2023 02:28:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77EE3B81854;
        Tue,  7 Feb 2023 10:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D247C433EF;
        Tue,  7 Feb 2023 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675765700;
        bh=zRQOcq6RWAaLJtuhvYQYOJyLbpfJKoXpH/MHB0mfWLY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O1GftF68Fxel6dZ1eInH+ssSSZhD3B/+9/y+WhFoRxR9FQ5Fhwipbr8anVSkA1sUR
         gNVbuWWNxWIwsqmHkeCUnuZJYV7zP3zmdYFOgP/QC/yT4X3rQEsx+pYg/RBqqw/FJ8
         Ipdi42EXQKiqwG7/gFzMXlaLagP3ubzM2Ct54EuulFSTRPRdMcK9SSuni3zza217KF
         4hgBh2tgdk2o7ioet2Q7CvMIpRq8Wk6xutsrfXrFC/ghS3A9Z1TK0B3WWn0Nq7zzMH
         nh7iI+Q5K8CgeP8xkU2emcRrV6cFbZUBkd5d5cLGOm38UyEAeiaTtQYzionpMyZ6bO
         kFVVfoI2WxWgg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Michael Guralnik <michaelgur@nvidia.com>,
        Dan Carpenter <error27@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <Y+ERYy4wN0LsKsm+@kili>
References: <Y+ERYy4wN0LsKsm+@kili>
Subject: Re: [PATCH] RDMA/mlx5: check reg_create() create for errors
Message-Id: <167576569583.91565.12336209121176541340.b4-ty@kernel.org>
Date:   Tue, 07 Feb 2023 12:28:15 +0200
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


On Mon, 06 Feb 2023 17:40:35 +0300, Dan Carpenter wrote:
> The reg_create() can fail.  Check for errors before dereferencing it.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx5: check reg_create() create for errors
      https://git.kernel.org/rdma/rdma/c/8e6e49ccf1a0f2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
