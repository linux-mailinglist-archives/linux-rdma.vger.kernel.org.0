Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3D5781B7
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiGRMK4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 08:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiGRMKz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 08:10:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DEF9588
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 05:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F037361470
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 12:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2812BC341C0;
        Mon, 18 Jul 2022 12:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658146253;
        bh=+/It2NeB93dFnH3dXB9bl0RaCPKL3cMuz1fhsyicBGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilr4/tGuJeUGEvegy3FxZSkIFnWb68xBdCV2e4r9AS98HDpEhmVh+CTX+E4IjNKI8
         Rew5Q311oolL4SKgkXvj7ZMBPFrU1NZD0HiTu4zerrEQyKt/n9VZDAqh7Oi6qvDM6L
         zs/k0/gHVlJ7clW7CyJt28bQfGMYwS/gGu8jvsIfgMyQ71b8KuaBS5TGh745a5SC+A
         SpCHYDuRIXigFh9+cCT8aGbexvibcDl8kXut1UkDHR0FGav6Hl7jnT6WuZtY2hBviY
         hrRwPTGsr4t31Og83n4zSTfiGo7T6UJQh1unTZAMUCHPDJ4jYfIFlNnPcfkYhOhDqD
         F1dc4Ot4qBnwQ==
Date:   Mon, 18 Jul 2022 15:10:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Tung, Chien Tin" <chien.tin.tung@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Unable to create max_qp QPs on Mellanox ConnectX-4/6
Message-ID: <YtVNyKzvUBqfhNSY@unreal>
References: <CY5PR11MB65342B7EDE1F12E1012ACC09DDB99@CY5PR11MB6534.namprd11.prod.outlook.com>
 <CY5PR11MB6534B320E6A2794419E843F8DD889@CY5PR11MB6534.namprd11.prod.outlook.com>
 <YtOyotf+cAVqUaJs@unreal>
 <CY5PR11MB6534C428394164059E0BD6DBDD8C9@CY5PR11MB6534.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6534C428394164059E0BD6DBDD8C9@CY5PR11MB6534.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 18, 2022 at 03:48:26AM +0000, Tung, Chien Tin wrote:
> > On Thu, Jul 14, 2022 at 02:20:06PM +0000, Tung, Chien Tin wrote:
> > > No one is interested in helping with Create QP issue with Mellanox
> > controller?
> > 
> > 1. Both Jason and I had personal issues that prevented from us to
> > participate in linux-rdma ML.
> Okay,, I don't know what that means but I won't dwell on it.
> 
> > 2. max_qp is set by FW. Please contact NVidia support.
> I sent this issue to the mailing list because with different kernel I get different
> number with 5.18.5 creating 1/2 of QPs as RHEL 8.5/MOFED.
> If you still think this is a FW issue, I can certainly take it up with support.

We already started internal discussion about it. The observed behavior is
a combination of FW issues together with very questionable kernel patch
that tried to overcome them.

Thanks
