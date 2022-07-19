Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A585792FB
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 08:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiGSGJf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 02:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGSGJf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 02:09:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7971F612
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 23:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB8E0B81862
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jul 2022 06:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32021C341C6;
        Tue, 19 Jul 2022 06:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658210971;
        bh=2Fg4uZnyZI5DOAZBJyoShkrECVQ14YdRCyIU9dHnTaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MuHfsQf9fEHuOTUYSCxaZgKJEXXaIGL3NrSYLUF4BRNENp1WfweHytERa1A89+P5m
         FUT5mJ5mtSLlbh4zokcRYmxhPuuUOcPKe1ARrYBGVk+Xfp6e71koNhxwFAL6pxfqbA
         7dpU9vZiUvdagr+fJ92AOtC/svHdqCRKZtteS7gkDMefqlppFRZdCLhkyPpxEi5F+S
         8l0NK/Wr4xnBGXO/iI593SRu50gQaUj68Tx2AGPrdra39CBBTDYqI0UP9gPAznq2hP
         Otj/tqsAf5AqubkImkyRY+UVKw+uHAL9CEhfgFtCHkd+jgRTPC9LbT37/HmizLxbJO
         6CgQOV3z65qpw==
Date:   Tue, 19 Jul 2022 09:09:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Tung, Chien Tin" <chien.tin.tung@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, msanalla@nvidia.com
Subject: Re: Unable to create max_qp QPs on Mellanox ConnectX-4/6
Message-ID: <YtZKl8EflY3JkKQo@unreal>
References: <CY5PR11MB65342B7EDE1F12E1012ACC09DDB99@CY5PR11MB6534.namprd11.prod.outlook.com>
 <CY5PR11MB6534B320E6A2794419E843F8DD889@CY5PR11MB6534.namprd11.prod.outlook.com>
 <YtOyotf+cAVqUaJs@unreal>
 <CY5PR11MB6534C428394164059E0BD6DBDD8C9@CY5PR11MB6534.namprd11.prod.outlook.com>
 <YtVNyKzvUBqfhNSY@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVNyKzvUBqfhNSY@unreal>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 18, 2022 at 03:10:48PM +0300, Leon Romanovsky wrote:
> On Mon, Jul 18, 2022 at 03:48:26AM +0000, Tung, Chien Tin wrote:
> > > On Thu, Jul 14, 2022 at 02:20:06PM +0000, Tung, Chien Tin wrote:
> > > > No one is interested in helping with Create QP issue with Mellanox
> > > controller?
> > > 
> > > 1. Both Jason and I had personal issues that prevented from us to
> > > participate in linux-rdma ML.
> > Okay,, I don't know what that means but I won't dwell on it.
> > 
> > > 2. max_qp is set by FW. Please contact NVidia support.
> > I sent this issue to the mailing list because with different kernel I get different
> > number with 5.18.5 creating 1/2 of QPs as RHEL 8.5/MOFED.
> > If you still think this is a FW issue, I can certainly take it up with support.
> 
> We already started internal discussion about it. The observed behavior is
> a combination of FW issues together with very questionable kernel patch
> that tried to overcome them.

We are working to provide more comprehensive fix, but for now, you can
revert the following patch: 7f839965b2d7 ("net/mlx5: Update log_max_qp value to be 17 at most")

Thanks

> 
> Thanks
