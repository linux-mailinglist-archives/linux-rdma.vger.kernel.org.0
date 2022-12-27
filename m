Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBD656B73
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Dec 2022 14:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiL0Ntm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Dec 2022 08:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiL0NtS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Dec 2022 08:49:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97844B868
        for <linux-rdma@vger.kernel.org>; Tue, 27 Dec 2022 05:49:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51FF2B81050
        for <linux-rdma@vger.kernel.org>; Tue, 27 Dec 2022 13:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BBFC433D2;
        Tue, 27 Dec 2022 13:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672148955;
        bh=5XRn477HwrwpAcgL9+D2ofk8fdPJR+BoomgSOPQNxDg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ii/SmgfwmNGj/3UgIMaV1sErkvD7RXnpXWSLEc3ewoiWgPOvL+vLxkGIeSH7pRKpC
         lFfnTDrSnzUhbmBXMw2IeiedkApdfN0OvtYFsHmTdV8JhC20fJUaychNyFyyvHqNZv
         H30rSkjPMYhmWjC4t1VXlhh7388e124Y4548yAmsJIaxo/gcG9madjcXlrIRLSAFxR
         8aTfUv9WSAB2lkh8OU7kWg4FLLjkdVC6li/kdURt7iekqJVozoqEn9R2ErxYzpWear
         VpyUDtVNoY/HcxWG7riPNyOEsj72USCxLfOPIrhPtu6IIidJvNosu0P39VdFjzfngf
         uSqvYrG1Jk9BQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        linux-rdma@vger.kernel.org
In-Reply-To: <20221215123030.155378-1-aleksei.kodanev@bell-sw.com>
References: <20221215123030.155378-1-aleksei.kodanev@bell-sw.com>
Subject: Re: [PATCH rdma-next] RDMA/cxgb4: remove unnecessary NULL check in __c4iw_poll_cq_one()
Message-Id: <167214895189.75776.1803467829421930267.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 15:49:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-87e0e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 15 Dec 2022 15:30:30 +0300, Alexey Kodanev wrote:
> If 'qhp' is NULL then 'wq' is also NULL:
> 
>     struct t4_wq *wq = qhp ? &qhp->wq : NULL;
>     ...
>     ret = poll_cq(wq, ...);
>     if (ret)
>         goto out;
> 
> [...]

Applied, thanks!

[1/1] RDMA/cxgb4: remove unnecessary NULL check in __c4iw_poll_cq_one()
      https://git.kernel.org/rdma/rdma/c/cab30a98352511

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
