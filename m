Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97586493694
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 09:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346156AbiASIvp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 03:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345165AbiASIvo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jan 2022 03:51:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61846C061574
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 00:51:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2797AB81889
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 08:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ADAC004E1;
        Wed, 19 Jan 2022 08:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642582301;
        bh=7pdMckHC44Cx01mpaW1+jRF6ExDb8S62hm7ggQ6AW+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ciP7Fvj/kfhVhUDXPuJodJci//zPT8obL3vdYGh5N+ofO1WT9dGbpsFy7Ci4enARO
         izc4MI7sxNT6qMLpX48wygQplWgJBXBVAIQoo1vX4CufVeCYe2rmsGZAUcIGHmZJks
         hJxNCqxibKQ6stUSqZIBz6wWTLT3qkv744C6El+Dry0FPiei6e5THfhkwXmdHPcjmc
         3Rbmn2SbW4/phtoZNkcMBVnoY/l1txdZIYM38mtJbjOdPFM0yU8HTNbjYWdWS7fvQE
         c3lgcbInj54hUGn6SyxRbTAV6Ly11UGix9ghUEY6AiEjH1KHxeTzdktfpdz1J2Ekqo
         bGTDQmBTMaw6Q==
Date:   Wed, 19 Jan 2022 10:51:37 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Christian Blume <chr.blume@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: SoftRoCE and OpenSM
Message-ID: <YefRGdQHkjnzOxuh@unreal>
References: <CAGP7Hd4atpB0J-PP-AC6peiUaD=Y75Fdue9Ab7AS8nkQPwdXvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGP7Hd4atpB0J-PP-AC6peiUaD=Y75Fdue9Ab7AS8nkQPwdXvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 19, 2022 at 01:41:30PM +1300, Christian Blume wrote:
> Hello!
> 
> Is it at all possible for a SoftRoCE node to talk to OpenSM? Can I set
> up OpenSM in such a way that it automatically discovers all SoftRoCE
> nodes on my subnet? Thanks for your help.

AFAICT, RXE lacks MAD support which is needed for OpenSM.

Thanks

> 
> Cheers,
> Christian
