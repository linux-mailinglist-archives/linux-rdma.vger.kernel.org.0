Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10C57BD2DC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 07:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbjJIFmA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 01:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345132AbjJIFl7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 01:41:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296369E
        for <linux-rdma@vger.kernel.org>; Sun,  8 Oct 2023 22:41:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A63C433C8;
        Mon,  9 Oct 2023 05:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696830117;
        bh=OxLJljnTRqy0Qg7XlhBn6A8eiUQttohq8uvTBtvmRcY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JQD+UXtqn1iw263q2hwKQT8i2VOK0nDgfG0GPDOzrmoJXDWe/c7DjPZ4m8lInEfro
         J16cZuftK+nF0jOJb2Fk6y2rLpnmkuCD22S8AX25mW7VRNLVQuUjJXqLjKi1zCwxx9
         jai2IbWyTC49juf0Yx9P8WaVg+1M2XjG+fC26kLfYAVO9eDvuYetkRE94vE40p8kCH
         218Grm/FOqwnvvXUibyZlsDHo6yWVnVuU3ilYygyPeGTv4a3oT92Vy8N47jEkSYGrG
         UCg3zuYvSs+yshU2KqFgajfssj2FGQvgFnh93NcwcXqZoEB5oGAuOJMWmk+sTKORDZ
         KcT4CZT2Ra4+A==
From:   Leon Romanovsky <leon@kernel.org>
To:     nex.sw.ncis.nat.hpm.dev@intel.com, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     Sindhu Devale <sindhu.devale@intel.com>
In-Reply-To: <20231004151306.228-1-shiraz.saleem@intel.com>
References: <20231004151306.228-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v1] RDMA/irdma: Add support to re-register a
 memory region
Message-Id: <169683011361.554089.10603440559330325956.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 08:41:53 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 04 Oct 2023 10:13:06 -0500, Shiraz Saleem wrote:
> Add support for reregister MR verb API by doing a de-register
> followed by a register MR with the new attributes. Reuse resources
> like iwmr handle and HW stag where possible.
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: Add support to re-register a memory region
      https://git.kernel.org/rdma/rdma/c/5ac388db27c443

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
