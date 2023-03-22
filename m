Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C216C4B23
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 13:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCVMyo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 08:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCVMyn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 08:54:43 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1583F22018
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 05:54:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a5so748387qto.6
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679489681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F9v4u5dsmD7IdPDedAw7yl5GKCx002rE2DFuzXEhabA=;
        b=oseP/IlFp1j6s51mg5FR8BiD6pOuhlK2sA/PlZwS/47aFuK75h2plqVR7N7hDpcFa9
         RNPKysEMUcAGmfNzJFQjff8MPwtzdEDzgXasGPPvcWoLZRxVPcs0do46FVyGzpIx9O9f
         FgsKFh5qQ8h7ho1bSmqDMyyTzD9X+IKIEneS507MEDL3prFqV3lx0yiRMRFF8RpcWnLD
         y2HeeLXMMjA65EWEnQpwhRbYW5wkS0WxrYqbmrXRxpcXw54Ksy4fYNzuP6ahgYd10Qw0
         Qy4dGtMucvoCfJFJYxp/OlFfph19hl6TG3+gX53Gm423poeYD12x9UMuxq7X9L/RkxaM
         KD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9v4u5dsmD7IdPDedAw7yl5GKCx002rE2DFuzXEhabA=;
        b=SOJRdJ33o/krnFy5USPYPsJCKWdKm65wR/FQLT4SsCMjSmohioV73c/lru6qM1sDVg
         fljY/LZU728GKih+3PEM9rvwoalOLsKXVPglNO5ibKfbn4/SKJP1cvPusx1Z5G0CVUVk
         4wj4u04kZ0nNHFriFeGSuQ60pcQEE5r6VFHSktZU4rQnMO2McQvXLrYAk1F9tmXC8uGx
         PTEtDuQqwPztl/sGE5Run7iO5KNB7P23QzEYFLrSavf8X4JryKuqAiD+hN6aAsgpJl9K
         Ya5g2Ls8uMcM7wsklPGfpC51Gnv64iMOqAmyp0Kf3APGBU6TF6ddf+GoLK3HOEAj1+1m
         Nxtg==
X-Gm-Message-State: AO0yUKUddR8bvxBWYKmjdQuZ5/L/DGOLg7WReDuxwxtEpV/Ei7sa0VTI
        PEDIhEwpCYab/R7LJdtCrkMiJw==
X-Google-Smtp-Source: AK7set84B/dAzc/qRKnsrbryejsxkR+kgL8Ft54Ca1aeV7djrv80URDlXYzzFfBac/AL/7y8+qjk8Q==
X-Received: by 2002:ac8:5c93:0:b0:3e0:3187:faf3 with SMTP id r19-20020ac85c93000000b003e03187faf3mr6264695qta.13.1679489681268;
        Wed, 22 Mar 2023 05:54:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8604a000000b003d3a34d2eb2sm10168725qtm.41.2023.03.22.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:54:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pexzE-000msK-9E;
        Wed, 22 Mar 2023 09:54:40 -0300
Date:   Wed, 22 Mar 2023 09:54:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBr6kNVoa5RbNzSa@ziepe.ca>
References: <20230322123703.485544-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322123703.485544-1-sagi@grimberg.me>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

This was the only caller of ib_get_vector_affinity() so please delete 
op get_vector_affinity and ib_get_vector_affinity() from verbs as well

Jason
