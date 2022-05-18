Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B954052B1A6
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 06:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiEREuH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 00:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiEREuF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 00:50:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0AA13D6A;
        Tue, 17 May 2022 21:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBD74B81E69;
        Wed, 18 May 2022 04:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5431CC385A9;
        Wed, 18 May 2022 04:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652849401;
        bh=u2H9VRIASmuOkwRABMwQGnZy+J18WWjGktMWeppxl6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KrRwAvSJS16JQnbgfSX15LKWLMUQhjT1/7ervFHXd+0uCupIqz7pxYEJNz3JgmFlO
         N7zL39moQed7uguI8NO5z0zjC7hX536W0vXJXIh88NIIt8lGAP+KI0YdOSmLj5snWO
         YIX8lx4Kmq4oYuJa+Qz7ntWKKM7XjPAKR4lYFxIAv2gpoZ2e6qT/3QuS9ko4Y2TaHe
         bC9AuGO1lHMDcDnz/5Z6CdoERJAUvqk99vHsOMoer2/6ZX0McYL2n7NoDHRPMo1LQ5
         E7O4j1sHdLjDq8PJRJ19OFCuJDNqXrvQY05sPKgMkUuHFftQIKsRRK4Zz5G0rxuYjB
         K7JAxicez3haw==
Date:   Wed, 18 May 2022 07:49:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Mark Bloch <mbloch@nvidia.com>
Cc:     Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
        "matanb@mellanox.com" <matanb@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "sean.hefty@intel.com" <sean.hefty@intel.com>,
        "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/mlx5: Add sysfs entry for vhca to
 /sys/class/infiniband/mlx5
Message-ID: <YoR68a8aN5Ld5Jv7@unreal>
References: <1652137257-5614-1-git-send-email-rohit.sajan.kumar@oracle.com>
 <BYAPR10MB2997DF974EF3631A2E69CA3CDCCA9@BYAPR10MB2997.namprd10.prod.outlook.com>
 <Yn85iFNS96yO2ISD@unreal>
 <d37309bd-c7e0-8e15-bae9-9341f4f9192d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d37309bd-c7e0-8e15-bae9-9341f4f9192d@nvidia.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 15, 2022 at 10:36:07AM +0300, Mark Bloch wrote:
> 
> 
> On 5/14/2022 08:09, Leon Romanovsky wrote:
> > On Fri, May 13, 2022 at 05:46:16PM +0000, Rohit Sajan Kumar wrote:
> >> Hey,
> >>
> >> Sending this as a gentle reminder to review the patch sent earlier this week which can be found in this email chain.
> > 
> > Patches that sent in HTML format, to wrong addresses and not visible
> > in patchworks/ML, without target net-next/rdma-next/e.t.c., with wrong
> > title are generally ignored.
> > 
> > Why vhca_id that returned from MLX5_IB_METHOD_QUERY_PORT is not enough?
> 
> The driver returns that only when in switchdev mode.
> I don't see why that can't be changed but that's the state today.

My guess is that it is not needed outside of switchdev mode. This is why
I would like to know why current solution is not enough.

Thanks
