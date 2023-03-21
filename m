Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F46C2BE4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Mar 2023 09:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCUIFt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Mar 2023 04:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCUIFs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Mar 2023 04:05:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26F5199C4
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 01:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D7C661A10
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 08:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390BBC433D2;
        Tue, 21 Mar 2023 08:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679385946;
        bh=KV2e1D783ZXrseToS4GBCtmxUSpWxC8PdjQbarAQRdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dXUa50wRlogbWwTqlZSFo6+PrCepuYOTVzjMCOVmkxv+ayiE8SwtCir4P9HMnQXah
         xllw/ZIazuQwJTRQ38pPfHnrP+dmH2iI+6+RmjfHh0e3KjxVE67K0XQX1efg1r5m5x
         GZ3QmxMK7H7YZEsltcKOG+Lo1ZM3R+UBa5kmt6x8X1HcEk7VNtBED7ESxEgcynEB+R
         xr5evIkwfTivHETuMkr5BHXO0bqZ7XNmbXq3H6hatKjAyYJiMHk/KK2FEqy+trrHOw
         lO6Ey2j83m4AuFeyh8oeEKgdD8Wc0jzuHjj3j7x5cCGv2oOZfSxJTAUMJLe9vk9r1x
         SgemAkkJS7EfA==
Date:   Tue, 21 Mar 2023 10:05:42 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Nicolas Morey <nmorey@suse.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [ANNOUNCE] rdma-core: new stable releases
Message-ID: <20230321080542.GQ36557@unreal>
References: <38b760d3-1c9c-c92e-243b-9da2a6fdb89b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b760d3-1c9c-c92e-243b-9da2a6fdb89b@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 20, 2023 at 10:28:03PM +0100, Nicolas Morey wrote:
> *** IMPORTANT: Due to their age and the lack of significant patches, branches v20-v25 have been retired. ***

It is worth to add a section in README file with a sentence
about minimal supported rdma-core version.

Thanks
