Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CCA6027CE
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 11:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiJRJC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiJRJC1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 05:02:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48739A99F7
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 02:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2985FB81DCC
        for <linux-rdma@vger.kernel.org>; Tue, 18 Oct 2022 09:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E77C433D6;
        Tue, 18 Oct 2022 09:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666083728;
        bh=JX8lQNoY71OxzEiFCuJaKUIgZIEJlXbZJeOahnaTO58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYPX8zUM7R4u0OnZl1SLUD+w/gZSaDJ+STO2yr+eH02ug6peU7U4dbAS6/QitamX0
         q5tThuyg5begVcO8i3Rqw/0CEWAyHvI8ZUumvwKqdgnxP0s86kb6GgJpXi0vyg9crX
         a+GEEnXPByJWfMhyAkJOsCFckAt1lowSLQ3rEI5jkFAxr0TdoOw5JPaJlYcsUtrZWW
         KAWZcwIt5V+7d8O3nxD1V0DhX0akN0w59ByQZ2ktwK3M0U8TYPWImVnQE/UJ6iDlGw
         K192WNKRnUQn36ItOky/o80NWDij9fBlCeXHNe6AhOPKbJxr6Tz6GMfMQ62uWPyxKO
         YaIf2VFTj6pUw==
Date:   Tue, 18 Oct 2022 12:02:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Subject: Re: [PATCH for-next 16/16] RDMA/rxe: Add parameters to control task
 type
Message-ID: <Y05rjL+ufktJslNU@unreal>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
 <20221018043345.4033-17-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018043345.4033-17-rpearsonhpe@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 17, 2022 at 11:33:47PM -0500, Bob Pearson wrote:
> Add modparams to control the task types for req, comp, and resp
> tasks.

You need to be more descriptive why module parameters are unavoidable.

Thanks
