Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1576F65B8
	for <lists+linux-rdma@lfdr.de>; Thu,  4 May 2023 09:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjEDHaA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 May 2023 03:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjEDH37 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 May 2023 03:29:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD841990
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 00:29:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B19B62CAC
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 07:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AE2C4339B;
        Thu,  4 May 2023 07:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683185397;
        bh=WNEFMNmQsK51QMNGJ8XauKO9/SbZVRuHCAz9XHkKmgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1YDVsfvjN/uqC4HDXkTBsREVWEsq63XeJfxaypW3yGjZGRvcaCtEUhTNLwVQAIsg
         XtQQZqLssAn2GUbfzpiIRjcRRDFf1fmae9ZVa/kwTcMNOg2hB8hK0Ou1hss264IjoR
         oTY+Zlj1ggvRIID4X7UKtu4IstDe9+b7Qrdxg9FJcgdPKuOAyEd9WQj3pfIU0pKGYZ
         88QvxTK+21bJNrzcYoUvDmPppB4Z+b6ndM+0k7ezh2zxUZyoQ98q6PmrFM0XeGKxo3
         OOKNu5LM8hm++pKP/nYXA9HIAfUATpkYqCEgDCsIuQHcdpTPlh/7NztKPH988o6KDU
         lfRcpG+4Kd2eQ==
Date:   Thu, 4 May 2023 10:29:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Eli Cohen <elic@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: system hang on start-up (mlx5?)
Message-ID: <20230504072953.GP525452@unreal>
References: <A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com>
 <DM8PR12MB54003FBFCABCCB37EE807B45AB6C9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <91176545-61D2-44BF-B736-513B78728DC7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91176545-61D2-44BF-B736-513B78728DC7@oracle.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 03, 2023 at 02:02:33PM +0000, Chuck Lever III wrote:
> 
> 
> > On May 3, 2023, at 2:34 AM, Eli Cohen <elic@nvidia.com> wrote:
> > 
> > Hi Chuck,
> > 
> > Just verifying, could you make sure your server and card firmware are up to date?
> 
> Device firmware updated to 16.35.2000; no change.
> 
> System firmware is dated September 2016. I'll see if I can get
> something more recent installed.

We are trying to reproduce this issue internally.

Thanks
