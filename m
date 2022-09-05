Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82085AD23A
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Sep 2022 14:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiIEMPC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 08:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbiIEMO6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 08:14:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B333D1AF39;
        Mon,  5 Sep 2022 05:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA440B8113A;
        Mon,  5 Sep 2022 12:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1390FC433C1;
        Mon,  5 Sep 2022 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662380091;
        bh=tW3SpXtUlXvQt+4+pMzaSsfQI7keGfnQKWKa4aYCZsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cs9GOGTJt0wCCYS9zoz3N/Wet2WiY5cCGAiL+4Bpv7U0JRbUfUsZ64sGI3UtNTt9v
         wfQuAnua0RtigxZubG7kuDxKo0WEgOHqD2HXyK92BIvPFaADZ9/5X7zkO2yaoE9sE0
         EeIu8Go6hYRkDKHlBB1EewzbOD+whkgc7vLSCS1jhgMqzq3YKaoEWH7h040fxZIMvS
         22ZOycHrgRHeH6ofK01sUDsPTaUTxm4yd/JiehE1GDD18yVZiDKA9hAAhQ4wSqtVf6
         gOMKBTKbFz8QAmPBbhdBKX/r1FaXmuxZb8B7mL8/t7D/eQrMbQUTqxCBQnfkJPS+sa
         Jn6Kmo8h561GA==
Date:   Mon, 5 Sep 2022 15:14:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     cgel.zte@gmail.com
Cc:     jgg@ziepe.ca, dennis.dalessandro@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] RDMA/hfi1: Remove the unneeded result variable
Message-ID: <YxXoNwYwtjogoE+V@unreal>
References: <20220901074209.313004-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074209.313004-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 01, 2022 at 07:42:09AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value set_link_state() directly instead of storing it in
> another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/infiniband/hw/hfi1/verbs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Thanks, applied.
