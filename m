Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8DF6C4E69
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 15:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCVOs0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 10:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjCVOsG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 10:48:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A186A1D6;
        Wed, 22 Mar 2023 07:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFFFBB81CF4;
        Wed, 22 Mar 2023 14:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159AFC4339B;
        Wed, 22 Mar 2023 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496357;
        bh=1CqlgGyaxSbqJLKw1Zf8lNBZD34fL7zsNgh3LojnYIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTY/FW9DyW+TBizcHbzhVt7CkAvagGslPzS18TcS07D3RGegRXwarFCIkbTEOPJOq
         3Y6twigaw+nwROohTBCYULX+AQkXGA4tXs0DXDur4ee23M3vMa+nwjeGnNjVObqvRw
         480Kp9uyFRbG1/a3/Vxj+sCYTlfwNyl6Diy6YSr6lRUM6H7F2uHTC6jcX137rAYsaX
         vY8tJBk9kgFZU3VYUnGwikytlGUjNRBf2Aa9TYEBB/NsHhrKAzqCMCvWT+WPM+Ox7K
         AmzuunBoQ+R5IXJzwre+9rMfN/uaYGwm4igbIUMWQoNaImm/0pGLTWH5/WQIjn8KRj
         2e3TwoJDvAxsA==
Date:   Wed, 22 Mar 2023 08:45:54 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBsUol590J+8ie4r@kbusch-mbp.dhcp.thefacebook.com>
References: <20230322123703.485544-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322123703.485544-1-sagi@grimberg.me>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 22, 2023 at 02:37:03PM +0200, Sagi Grimberg wrote:
> No rdma device exposes its irq vectors affinity today. So the only
> mapping that we have left, is the default blk_mq_map_queues, which
> we fallback to anyways. Also fixup the only consumer of this helper
> (nvme-rdma).
> 
> Remove this now dead code.

Thanks, this will make it even more practical to unify the queue setup for nvme
transports.

Acked-by: Keith Busch <kbusch@kernel.org>
