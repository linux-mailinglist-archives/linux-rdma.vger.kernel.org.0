Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991937D53AA
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjJXOKG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjJXOKF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 10:10:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43526B6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 07:10:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCE5C433C7;
        Tue, 24 Oct 2023 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698156603;
        bh=UK19fR29Wf7yUVUHiCkLkJkqdbuARK9su8Ti7FqIvbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlbLcWHxMl+DZBM3yRaZdcUN1QaU5BvGxAYcc/5HqbUZcKe50m744s74HOesGSvAT
         BKni3K/OPjZ1kYlPPqllP8alllWeF3T8o48Z4ZPBG5DND29/maWjig2V6OhBHYotRH
         VuU6B3Etof2om44H6jLZTsP/LwAJvlFz0Ab7I5N7NmwVyimlFl/dFZChOfbf/CGla4
         KYJsf1EYqzLeQOLBKgVwS/s84WwQs1wThdD0uuY4LYw6+38sXsPsRH1yenpQQp7Lor
         c31SWsA0oXRYf9wX81UAppvmCwQnC3ReU/gVpr3Q/nsOTCv3L9zwo3Uj3CrOuCrOo7
         wAZq/sSHiKc2g==
Date:   Tue, 24 Oct 2023 17:09:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, bmt@zurich.ibm.com
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2 00/20] Cleanup for siw
Message-ID: <20231024140959.GA1939579@unreal>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013020053.2120-1-guoqing.jiang@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 13, 2023 at 10:00:33AM +0800, Guoqing Jiang wrote:
> V2 changes:
> 1. address W=1 warning in patch 12 and 19 per the report from lkp.
> 2. add one more patch (20th).
> 
> Hi,
> 
> This series aim to cleanup siw code, please review and comment!
> 
> Thanks,
> Guoqing
> 
> Guoqing Jiang (20):

Bernard, did you return from the vacation?

Thanks
